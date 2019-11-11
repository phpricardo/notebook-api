namespace :dev do
  desc "Configura o ambiente de desenvolvimento."
  task setup: :environment do

    %x(rails db:drop db:create db:migrate)

    puts "Cadastrando os tipos de contato..."

    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts "Tipos de Contato cadastrados."
    
    puts "Cadastrando os contatos..."
    100.times do 
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 40.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )  
    end
    puts "Contatos cadastrados."

    puts "Cadastrando os telefones..."
      Contact.all.each do |contact|
        Random.rand(5).times do |i|
          phone = Phone.create!(number:Faker::PhoneNumber.cell_phone, contact_id: contact.id)
          contact.phones << phone
          contact.save!
        end
      end
    puts "telefones cadastrados."

    puts "Cadastrando Endereços..."
      Contact.all.each do |contact|
          address = Address.create!(
            street: Faker::Address.street_address,
            city: Faker::Address.city,
            contact: contact  
          )
      end
    puts "Endereços cadastrados."

  end

end
