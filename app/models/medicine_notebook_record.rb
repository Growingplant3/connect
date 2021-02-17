class MedicineNotebookRecord < ApplicationRecord
  has_many :prescription_details, dependent: :destroy
  accepts_nested_attributes_for :prescription_details, allow_destroy: true
  belongs_to :user
  belongs_to :pharmacy
  validates :date_of_issue, :date_of_dispensing, :medical_institution_name, :doctor_name, presence: true
  validates_associated :prescription_details
  validate :should_be_past
  scope :descending_order, -> { order(date_of_issue: "desc") }

  def should_be_past
    if date_of_issue.present? && date_of_issue > Date.current
      errors.add(:date_of_issue, I18n.t('errors.messages.prescription_should_be_past'))
    end

    if date_of_dispensing.present? && date_of_dispensing > Date.current
      errors.add(:date_of_dispensing, I18n.t('errors.messages.prescription_should_be_past'))
    end
  end

  def self.arrange_create(params,medicine_notebook_record,current_pharmacy)
    puts "メソッドに入った"
    child_array = []
    grandson_1_array = []
    # grandson_2_array = []
    a = 0
    b = 0
    # c = 0
    x = params[:medicine_notebook_record][:prescription_details_attributes].keys.count
    while x > a
      puts "while x の中"
      prescription_detail = medicine_notebook_record.prescription_details.build
      # binding.pry
      medicine_record_relation = prescription_detail.medicine_record_relations.build
      child_key_index = params[:medicine_notebook_record][:prescription_details_attributes].keys[a]
      child_value = params[:medicine_notebook_record][:prescription_details_attributes][child_key_index]
      y = child_value[:medicine_record_relations_attributes].keys.count
      while y > b
        puts "while y の中"
        grandson_1_key_index = params[:medicine_notebook_record][:prescription_details_attributes][child_key_index][:medicine_record_relations_attributes].keys[b]
        grandson_1_value = params[:medicine_notebook_record][:prescription_details_attributes][child_key_index][:medicine_record_relations_attributes][grandson_1_key_index]
        grandson_1_array.push(grandson_1_value)
        medicine_record_relation[:medicine_id] = grandson_1_array[b][:medicine_id]
        medicine_record_relation.save
        b += 1
      end
      puts "おはよう"
      child_array.push(child_value)
      column_names = PrescriptionDetail.column_names
      column_names.each do |one_column|
        case one_column
        when "pharmacy_id"
          prescription_detail[one_column.to_sym] = current_pharmacy.id
        when "id"
        else
          prescription_detail[one_column.to_sym] = child_array[a][one_column]
        end
      end
      binding.pry
      prescription_detail.save
      a += 1
      puts "こんばんは"
    end
  end
end
