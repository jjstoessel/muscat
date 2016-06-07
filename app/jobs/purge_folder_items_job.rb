class PurgeFolderItemsJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    FolderItem.solr_clean_index_orphans
  end
end
