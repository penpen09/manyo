FactoryBot.define do
  factory :user do
    name { "Admin" }
    email { "admin@admin.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
  factory :second_user, class: User do
    name { "SatoTakeru" }
    email { "sato@takeru.com" }
    password { "satotakeru0123" }
    password_confirmation { "satotakeru0123" }
    admin { false }
  end
end
