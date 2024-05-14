# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


def populate_for_development
  puts 'Creating organization...'
  org = Organization.create(name: 'CSA Recife', slug: 'csa-recife')
  User.create!(email: 'admin@example.com',
               password: 'password',
               password_confirmation: 'password',
               organization_id: org.id)

  puts 'Creating Locations...'
  Location.create!(
    organization_id: org.id,
    name: 'Casa Forte'
  )

  Location.create!(
    organization_id: org.id,
    name: 'Graças'
  )

  puts 'Creating Products...'
  create_products(org)
  puts 'Done!'
end

def create_products(organization)
  products = [
    { name: "Abacate", description: "Rico em gorduras monoinsaturadas, o abacate é perfeito para guacamole, saladas e até cosméticos.", main_usage: "Guacamole, saladas, cosméticos." },
    { name: "Abobrinha", description: "De sabor suave e textura macia, a abobrinha é ideal para refogados, assados e pratos saudáveis.", main_usage: "Refogados, assados, sopas." },
    { name: "Abobrinha baby", description: "Pequena e delicada, a abobrinha baby é ótima para pratos gourmet e decoração, além de ser saborosa grelhada.", main_usage: "Grelhados, decoração de pratos." },
    { name: "Acelga", description: "A acelga, com suas folhas verdes e talos crocantes, é nutritiva e versátil, usada em saladas, refogados e sopas.", main_usage: "Saladas, refogados, sopas." },
    { name: "Acerola", description: "Pequena mas poderosa, a acerola é uma explosão de vitamina C, perfeita para sucos, geleias e sorvetes.", main_usage: "Sucos, geleias, sorvetes." },
    { name: "Agrião", description: "Com sabor picante e rico em ferro, o agrião adiciona um toque especial a saladas, sopas e sanduíches.", main_usage: "Saladas, sopas, sanduíches." },
    { name: "Aipo", description: "Crocante e com um sabor distinto, o aipo é excelente em saladas, sopas e como ingrediente para sucos detox.", main_usage: "Saladas, sopas, sucos." },
    { name: "Alecrim", description: "Erva aromática com sabor intenso, o alecrim é ideal para temperar carnes, assados e preparar chás.", main_usage: "Carnes, assados, chás." },
    { name: "Alface americana", description: "Com folhas crocantes e um sabor suave, a alface americana é a base perfeita para saladas, sanduíches e wraps.", main_usage: "Saladas, sanduíches, wraps." },
    { name: "Alface americana mini", description: "Versão menor da alface americana, mantém a crocância e é ideal para saladas individuais e decoração de pratos.", main_usage: "Saladas, decoração." },
  ]

  products.each do |product|
    Product.create!(
      organization_id: organization.id,
      name: product[:name],
      description: product[:description],
      main_usage: product[:main_usage],
      )
  end
end

case Rails.env
when 'development'
  populate_for_development
end
