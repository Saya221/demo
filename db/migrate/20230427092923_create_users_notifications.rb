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
      CREATE OR REPLACE FUNCTION users_notifications_insert_trigger()
      RETURNS TRIGGER AS $$
      DECLARE
        partition_name TEXT;
        partition_date DATE;
      BEGIN
        partition_date := date_trunc('month', NEW.created_at)::date;
        partition_name := 'users_notifications_' || TO_CHAR(partition_date, 'YYYY_MM');
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
