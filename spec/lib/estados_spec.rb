require 'estado.rb'

describe 'Estados' do
  context '.get_ufs' do
    it 'deve retornar todas as UFs' do
      ufs = Estado.all

      expect(ufs).to include 'Amapá - AP'
      expect(ufs).to include 'São Paulo - SP'
    end
  end

  context '.seleciona_uf' do
    it 'deve retornar todas as informações da UF fornecida' do
      estado = Estado.new('BA')
      uf = estado.send(:seleciona_uf)

      expect(uf[:id]).to eq 29
      expect(uf[:nome]).to eq 'Bahia'
      expect(uf[:sigla]).to eq 'BA'
    end

    it 'e deve ser fornecida uma UF valida' do
      estado = Estado.new('XR')
      uf = estado.send(:seleciona_uf)
      
      expect(uf).to eq "\nUF não encontrada! Insira uma UF válida."
    end
  end

  context '.uf_geral' do
    it 'deve mostrar o ranking de nomes geral de uma UF' do
      json = File.read("spec/support/api.json")    
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?'\
            'localidade=35'
      response = double('faraday_response', body: json, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(response)
  
      estado = Estado.new('SP')
      tabela = estado.uf_geral

      expect(tabela.title).to eq 'Ranking Geral: SP'
    end
  end
  
  context '.uf_masc' do
    it 'deve mostrar o ranking de nomes masculino de uma UF' do
      json = File.read("spec/support/api.json")    
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?'\
            'localidade=35&sexo=M'
      response = double('faraday_response', body: json, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(response)

      estado = Estado.new('SP')
      tabela = estado.uf_masc

      expect(tabela.title).to eq 'Ranking Masculino: SP'
    end
  end

  context '.uf_fem' do
    it 'deve mostrar o ranking de nomes feminino de uma UF' do
      json = File.read("spec/support/api.json")    
      url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?'\
            'localidade=35&sexo=F'
      response = double('faraday_response', body: json, status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(response)

      estado = Estado.new('SP')
      tabela = estado.uf_fem

      expect(tabela.title).to eq 'Ranking Feminino: SP'
    end
  end
end