# frozen_string_literal: true

shared_examples :partition do
  let(:underscore_class_name) { described_class.name.underscore }
  let(:user1) { create :user, id: MethodsHelper::UUID578 }
  let(:user2) { create :user, id: MethodsHelper::UUID11 }
  let(:init_partitions) do
    [
      "#{underscore_class_name.pluralize}_" + ((Zlib.crc32(MethodsHelper::UUID11) % 1000) + 1).to_s,
      "#{underscore_class_name.pluralize}_" + ((Zlib.crc32(MethodsHelper::UUID578) % 1000) + 1).to_s
    ]
  end

  describe "#set_table_name" do
    let!("#{described_class.name.underscore}1") { create(underscore_class_name, user: user1) }
    let!("#{described_class.name.underscore}2") { create(underscore_class_name, user: user2) }

    it do
      expect(init_partitions[1]).to eq described_class.set_table_name(MethodsHelper::UUID578)
      expect(init_partitions[0]).to eq described_class.set_table_name
    end
  end

  describe "#get_first_partition" do
    context "with init partitions" do
      before { described_class.reset_table_name }

      let!("#{described_class.name.underscore}1") { create(underscore_class_name, user: user2) }
      let!("#{described_class.name.underscore}2") { create(underscore_class_name, user: user1) }

      it { expect(init_partitions[0]).to eq described_class.get_first_partition }
    end

    context "without init partitions" do
      it { expect(described_class.table_name).to eq described_class.get_first_partition }
    end
  end

  describe "#union_all_partitions" do
    context "with init partitions" do
      let!("#{described_class.name.underscore}1") { create(underscore_class_name, user: user1) }
      let!("#{described_class.name.underscore}2") { create(underscore_class_name, user: user2) }

      it { expect(described_class.union_all_partitions.size).to eq 2 }
    end

    context "without init partitions" do
      it do
        expect(
          described_class.union_all_partitions.table_name
        ).to eq underscore_class_name.pluralize.to_s
      end
    end
  end
end
