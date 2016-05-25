module AnalyticsTrackingParams
  class UrlParams
    class << self
      def append_tracking_params(url)
        conjunction = url.include?('?') ? '&' : '?'
        url + conjunction + tracking_hash.to_param
      end

      private
        def tracking_hash
          {
            utm_source: :slack,
            utm_medium: :bot,
            utm_content: :notifications,
            utm_campaign: :notifications
          }
        end
    end
  end
end
