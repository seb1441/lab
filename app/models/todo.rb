class Todo < ApplicationRecord
  as_enum :status, pending: 0, in_progress: 1, done: 2

  belongs_to :user

  def buttons
    buttons = []
    buttons.push ["text-danger", "todos/pending/", "Pending"] unless pending?
    buttons.push ["text-warning", "todos/inprogress/", "In progress"] unless in_progress?
    buttons.push ["text-success", "todos/done/", "Done"] unless done?
    buttons
  end

  def self.humanized_statuses
    hash = statuses.hash
    # hash[] = hash.delete :old_key
    hash.transform_keys{ |key| key.humanize }
    # hash.each do |k, v|
    #   byebug
    #   hash[k.humanized] = hash.delete k
    # end
  end
end
