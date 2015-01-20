class CreateActiveRecordExamples < ActiveRecord::Migration
  def change
    create_table :active_record_examples do |t|

      t.timestamps
    end
  end
end
