FactoryBot.define do
  factory :label do
    name { "Label_1" }
  end
  factory :second_label, class: Label do
    name { "Label_2" }
  end
end
