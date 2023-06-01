# frozen_string_literal: true

shared_examples :filter_and_sort do
  let(:underscore_class_name) { described_class.name.underscore }

  let!("#{described_class.name.underscore}1") { create(underscore_class_name, id: MethodsHelper::UUID11) }
  let!("#{described_class.name.underscore}2") { create(underscore_class_name, id: MethodsHelper::UUID578) }

  let(:subject1) { send("#{underscore_class_name}1") }
  let(:subject2) { send("#{underscore_class_name}2") }

  describe "#filter_by" do
    context "id" do
      let(:conditions) { { id: MethodsHelper::UUID11 } }

      it { expect(described_class.filter_by(conditions)).to eq [subject1] }
    end

    context "default" do
      let(:conditions) {}

      it { expect(described_class.filter_by(conditions)).to eq [subject1, subject2] }
    end
  end

  describe "#sort_by" do
    context "id" do
      let(:conditions) { { id: :asc } }

      it { expect(described_class.sort_by(conditions)).to eq [subject1, subject2] }
    end

    context "default" do
      context "conditions is Hash" do
        let(:conditions) { {} }

        it { expect(described_class.sort_by(conditions)).to eq [subject2, subject1] }
      end

      context "conditions is nil" do
        let(:conditions) {}

        it { expect(described_class.sort_by(conditions)).to eq [subject2, subject1] }
      end
    end
  end
end

shared_examples :blank do |resource, field|
  it do
    expect(response_data[:success]).to eq false
    expect(response_data[:errors][0][:resource]).to eq resource
    expect(response_data[:errors][0][:field]).to eq field
    expect(response_data[:errors][0][:code]).to eq 1003
  end
end

shared_examples :unauthorized do |action|
  before { action }

  it do
    expect(response_data[:success]).to eq false
    expect(response_data[:errors][0][:code]).to eq 1201
  end
end
