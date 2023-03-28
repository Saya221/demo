# frozen_string_literal: true

class Api::V1::YoutubeUrlProcessingService < Api::V1::BaseService
  def initialize(video_id)
    @video_id = video_id
  end

  def perform
    get_video

    {
      movie_title: video.snippet.title,
      thumbnail_url: video.snippet.thumbnails.default.url,
      description: video.snippet.description
    }
  end

  private

  attr_reader :video_id, :video

  def get_video
    @video = YOUTUBE_V3_CLIENT.list_videos("snippet", id: video_id).items.first

    raise Api::Error::ServiceExecuteFailed, :not_found_video unless video
  end
end
