# frozen_string_literal: true

namespace :sync_algolia do
  desc "Sync users to Algolia indice"
  task users: :environment do
    objects = ActiveModel::Serializer::CollectionSerializer.new(User.all, serializer: Api::V1::UserSerializer, type: :algolia).as_json
    objects.each { |object| object[:objectID] = object.delete(:id) }

    index = ALGOLIA_CLIENT.init_index("#{APP::NAME}_users")
    index.set_settings(attributesForFaceting: %w[filterOnly(role) filterOnly(status)])

    objects.each_slice(1000) do |batch_objects|
      index.save_objects(batch_objects)
    end
  end
end
