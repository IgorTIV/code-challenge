require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { is_expected.to validate_presence_of(:order_id) }
  it { is_expected.to validate_presence_of(:source_id) }
  it { is_expected.to validate_presence_of(:source_type) }
  it { is_expected.to validate_presence_of(:price) }

  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }


  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:source) }

  it { is_expected.to belong_to(:product).class_name('Product').with_foreign_key(:source_id) }
end
