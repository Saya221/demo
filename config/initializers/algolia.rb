ALGOLIA_CLIENT = Algolia::Search::Client.create ENV.fetch("ALGOLIA_APP_ID", nil), ENV.fetch("ALGOLIA_API_KEY", nil)
