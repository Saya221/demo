class CreateUsersNotifications < ActiveRecord::Migration[7.0]
  def up
    create_table :users_notifications, id: :uuid do |t|
      t.datetime :read_at
      t.references :user, type: :uuid
      t.references :notification, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end

    execute <<-SQL
      CREATE OR REPLACE FUNCTION crc32(text_string text)
      RETURNS bigint AS $$
      DECLARE
        tmp bigint;
        i int;
        j int;
        byte_length int;
        binary_string bytea;
      BEGIN
        IF text_string = '' THEN
          RETURN 0;
        END IF;

        i = 0;
        tmp = 4294967295;
        byte_length = bit_length(text_string) / 8;
        binary_string = decode(replace(text_string, E'\\\\', E'\\\\\\\\'), 'escape');
        LOOP
          tmp = (tmp # get_byte(binary_string, i))::bigint;
          i = i + 1;
          j = 0;
          LOOP
            tmp = ((tmp >> 1) # (3988292384 * (tmp & 1)))::bigint;
            j = j + 1;
            IF j >= 8 THEN
                EXIT;
            END IF;
          END LOOP;
          IF i >= byte_length THEN
            EXIT;
          END IF;
        END LOOP;
        RETURN (tmp # 4294967295);
      END
      $$ IMMUTABLE LANGUAGE plpgsql;
    SQL

    # Testing function crc32
    # @conn = PG.connect(dbname: ENV["DATABASE_NAME"])
    # def crc32(text_string)
    #   result = nil
    #   @conn.exec("SELECT crc32('#{text_string}') AS result") do |result_set|
    #     result = result_set.getvalue(0,0).to_i
    #   end
    #   result
    # end
    # 10_000_000.times do
    #   uuid = SecureRandom.uuid
    #   print "." if Zlib.crc32(uuid) != crc32(uuid)
    # end

    execute <<-SQL
      CREATE OR REPLACE FUNCTION users_notifications_insert_trigger()
      RETURNS TRIGGER AS $$
      DECLARE
        partition_name TEXT;
      BEGIN
        partition_name := 'users_notifications_' || mod(crc32(NEW.id::text), 1000);
        IF NOT EXISTS(SELECT relname FROM pg_class WHERE relname=partition_name) THEN
          EXECUTE 'CREATE TABLE ' || partition_name || ' (LIKE users_notifications INCLUDING CONSTRAINTS)';
        END IF;

        EXECUTE 'INSERT INTO ' || partition_name || ' SELECT ($1).*'
          USING NEW;

        RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER users_notifications_insert_trigger
      BEFORE INSERT ON users_notifications
      FOR EACH ROW EXECUTE FUNCTION users_notifications_insert_trigger();
    SQL
  end

  def down
    connection.tables.each do |table|
      drop_table table if table.start_with?("users_notifications_")
    end

    drop_table :users_notifications
  end
end
