require 'decada.rb'

describe 'Decada' do
  it 'deve formatar os nomes inseridos' do
    decada = Decada.new('        Bruno , Carlos      ')

    expect(decada.nomes).to eq ['Bruno', 'Carlos']
  end

  context '.nomes_por_decada' do
    it 'deve retornar o rankings de nomes' do
      json = File.read("spec/support/localidade.json")    
      response = double('faraday_response', body: json, status: 200)
      allow(Faraday).to receive(:get).and_return(response)
      decada = Decada.new('Bruno, Carlos, Joao')
      ranking = decada.nomes_por_decada

      expect(ranking.title).to eq 'Frequência de uso por década: Bruno, '\
                                  'Carlos, Joao'
    end

    it 'ou retornar aviso caso o nome não exista nos dados do ibge' do
      decada = Decada.new('zzzz, xxxx')
      ranking = decada.nomes_por_decada

      expect(ranking).to eq ["\nNome zzzz não encontrado! Verifique a "\
                            'ortografia e as instruções',
                            "\nNome xxxx não encontrado! Verifique a "\
                            'ortografia e as instruções']
    end
  end
end