class DeleteExpiredProjectsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    count = Project.expired.count

    Rails.logger.info "DeleteExpiredProjectsJob: Automatically deleting expired projects..."

    if count.positive?
      Rails.logger.info "DeleteExpiredProjectsJob: Found #{count} expired projects."
      Project.expired.delete_all # NOTE: Use .destroy_all to trigger callbacks if needed
      Rails.logger.info "DeleteExpiredProjectsJob: Successfully deleted #{count} expired projects."
    else
      Rails.logger.info "DeleteExpiredProjectsJob: No expired projects to delete."
    end
  end
end
