class CreateCampaignQualifications < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_qualifications do |t|
      t.references :campaign_quota
      t.integer :question_id
      t.text :pre_codes

      t.timestamps
    end
  end
end
