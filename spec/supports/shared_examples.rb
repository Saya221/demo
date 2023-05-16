# frozen_string_literal: true

shared_examples :partition do
  let(:underscore_class_name) { described_class.name.underscore }
  let(:init_partitions) do
    [
      "#{underscore_class_name.pluralize}_" + ((Zlib.crc32(MethodsHelper::UUID11) % 1000) + 1).to_s,
      "#{underscore_class_name.pluralize}_" + ((Zlib.crc32(MethodsHelper::UUID578) % 1000) + 1).to_s
    ]
  end

  describe "#set_table_name" do
    before { create_partitions(described_class, %i[uuid11 uuid578]) }

    it { expect(init_partitions[0]).to eq described_class.set_table_name(MethodsHelper::UUID11) }
    it { expect(init_partitions[0]).to eq described_class.set_table_name }
  end

  describe "#get_first_partition_table" do
    context "with init partitions" do
      before { create_partitions(described_class, %i[uuid11 uuid578]) }

      it { expect(init_partitions[0]).to eq described_class.get_first_partition_table }
    end

    context "without init partitions" do
      it { expect(described_class.table_name).to eq described_class.get_first_partition_table }
    end
  end

  describe "#union_all_partitions" do
    context "with init partitions" do
      let(:user1) { create :user, id: MethodsHelper::UUID578 }
      let(:user2) { create :user, id: MethodsHelper::UUID11 }

      let("#{described_class.name.underscore}1") { build(underscore_class_name, user: user1) }
      let("#{described_class.name.underscore}2") { build(underscore_class_name, user: user2) }

      before do
        create_partitions(described_class, %i[uuid11 uuid578])

        subject1 = send("#{underscore_class_name}1")
        subject2 = send("#{underscore_class_name}2")

        [subject1, subject2].each_with_index do |subject, index|
          described_class.table_name = init_partitions[index]
          subject.save
        end
      end

      it { expect(described_class.union_all_partition_tables.size).to eq 2 }
    end

    context "without init partitions" do
      it do
        expect(
          described_class.union_all_partition_tables.table_name
        ).to eq underscore_class_name.pluralize.to_s
      end
    end
  end
end
