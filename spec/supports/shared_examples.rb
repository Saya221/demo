# frozen_string_literal: true

shared_examples "partition" do
  before do
    stub_const("UUID11", "1aa5b0c5-4d4c-4c32-bd4a-392462dcaca0") # Zlib.crc32(UUID_10) % 1000 + 1 = 11
    stub_const("UUID578", "b53777ec-35bf-4849-9470-bd9b7b335067") # Zlib.crc32(UUID_577) % 1000 + 1 = 578
  end

  let(:underscore_class_name) { described_class.name.underscore }
  let(:user1) { create :user, id: UUID578 }
  let(:user2) { create :user, id: UUID11 }
  let(:init_partitions) do
    [
      "#{underscore_class_name.pluralize}_" + ((Zlib.crc32(UUID11) % 1000) + 1).to_s,
      "#{underscore_class_name.pluralize}_" + ((Zlib.crc32(UUID578) % 1000) + 1).to_s
    ]
  end

  describe "#set_table_name" do
    let!("#{described_class.name.underscore}1") { create(underscore_class_name, user: user1) }
    let!("#{described_class.name.underscore}2") { create(underscore_class_name, user: user2) }

    it do
      expect(init_partitions[1]).to eq described_class.set_table_name(UUID578)
      expect(init_partitions[0]).to eq described_class.set_table_name
    end
  end

  describe "#get_first_partition" do
    context "with init partitions" do
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
        ).to eq underscore_class_name.pluralize
      end
    end
  end
end

shared_examples "filter and sort" do
  before do
    stub_const("UUID11", "1aa5b0c5-4d4c-4c32-bd4a-392462dcaca0") # Zlib.crc32(UUID_10) % 1000 + 1 = 11
    stub_const("UUID578", "b53777ec-35bf-4849-9470-bd9b7b335067") # Zlib.crc32(UUID_577) % 1000 + 1 = 578
  end

  let(:underscore_class_name) { described_class.name.underscore }

  let!("#{described_class.name.underscore}1") { create(underscore_class_name, id: UUID11) }
  let!("#{described_class.name.underscore}2") { create(underscore_class_name, id: UUID578) }

  let(:subject1) { send("#{underscore_class_name}1") }
  let(:subject2) { send("#{underscore_class_name}2") }

  describe "#filter_by" do
    context "with id" do
      let(:conditions) { { id: UUID11 } }

      it { expect(described_class.filter_by(conditions)).to eq [subject1] }
    end

    context "with default" do
      let(:conditions) {}

      it { expect(described_class.filter_by(conditions)).to eq [subject1, subject2] }
    end
  end

  describe "#sort_by" do
    context "with id" do
      let(:conditions) { { id: :asc } }

      it { expect(described_class.sort_by(conditions)).to eq [subject1, subject2] }
    end

    context "with default" do
      context "when conditions is Hash" do
        let(:conditions) { {} }

        it { expect(described_class.sort_by(conditions)).to eq [subject2, subject1] }
      end

      context "when conditions is nil" do
        let(:conditions) {}

        it { expect(described_class.sort_by(conditions)).to eq [subject2, subject1] }
      end
    end
  end
end

shared_examples "blank" do |resource, field|
  it do
    expect(response_data[:success]).to eq false
    expect(response_data[:errors][0][:resource]).to eq resource
    expect(response_data[:errors][0][:field]).to eq field
    expect(response_data[:errors][0][:code]).to eq 1003
  end
end

shared_examples "unauthorized" do |action|
  before { action }

  it do
    expect(response_data[:success]).to eq false
    expect(response_data[:errors][0][:code]).to eq 1201
  end
end
