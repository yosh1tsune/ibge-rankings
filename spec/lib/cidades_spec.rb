require 'cidade.rb'

describe 'Cidades' do
  context '.seleciona_cidade' do
    it 'deve retornar os dados de uma cidade' do
      input = Cidade.new('SÃO PAULO, SP')
      cidade = input.send(:seleciona_cidade)

      expect(cidade[:id]).to eq 3550308
      expect(cidade[:nome]).to eq 'SÃO PAULO'
      expect(cidade[:uf]).to eq 'SP'
    end

    it 'e o nome da cidade deve ser enviado com acentuação' do
      input = Cidade.new('SAO PAULO, SP')
      cidade = input.send(:seleciona_cidade)

      expect(cidade).to eq "\nCidade não encontrada. Certifique-se de que "\
                           'inseriu o nome correto!'
    end

    it 'e deve conter a UF separada por virgula' do
      input = Cidade.new('SÃO PAULO SP')
      cidade = input.send(:seleciona_cidade)

      expect(cidade).to eq "\nUF não encontrada. Certifique-se de que inseriu "\
                           'Cidade e UF separados por vírgula!'
    end
  end


  context '.cidade_geral' do
    it 'deve mostrar o ranking de nomes geral de uma UF' do
      json = File.read("spec/support/localidade.json")    
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?'\
            'localidade=3550308'
      response = double('faraday_response', body: json, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(response)
  
      cidade = Cidade.new('SÃO PAULO, SP')
      tabela = cidade.cidade_geral

      expect(tabela.title).to eq 'Ranking Geral: SÃO PAULO, SP'
    end
  end
  
  context '.cidade_masc' do
    it 'deve mostrar o ranking de nomes masculino de uma UF' do
      json = File.read("spec/support/localidade.json")    
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?'\
            'localidade=3550308&sexo=M'
      response = double('faraday_response', body: json, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(response)
  
      cidade = Cidade.new('SÃO PAULO, SP')
      tabela = cidade.cidade_masc

      expect(tabela.title).to eq 'Ranking Masculino: SÃO PAULO, SP'
    end
  end

  context '.cidade_fem' do
    it 'deve mostrar o ranking de nomes feminino de uma UF' do
      json = File.read("spec/support/localidade.json")    
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?'\
            'localidade=3550308&sexo=F'
      response = double('faraday_response', body: json, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(response)
  
      cidade = Cidade.new('SÃO PAULO, SP')
      tabela = cidade.cidade_fem

      expect(tabela.title).to eq 'Ranking Feminino: SÃO PAULO, SP'
    end
  end
end