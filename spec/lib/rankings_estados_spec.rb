require 'estado.rb'

describe 'Rankings estados' do
  it 'deve retornar todas as UFs' do
    ufs = Estado.get_ufs

    expect(ufs).to include 'Amapá - AP'
    expect(ufs).to include 'São Paulo - SP'
  end

  xit 'deve retornar todas as informações da UF fornecida' do
    estado = Estado.new('BA')
    uf = estado.chama_rankings
    
    expect(uf[:id]).to eq 29
    expect(uf[:nome]).to eq 'Bahia'
    expect(uf[:sigla]).to eq 'BA'
  end

  xit 'e deve ser fornecida uma UF valida' do
    estado = Estado.new('XR')
    uf = estado.chama_rankings
    
    expect(uf).to eq "\nUF não encontrada! Insira uma UF válida."
  end

  it 'deve mostrar o ranking de nomes geral de uma UF' do
    estado = Estado.new('SP')
    tabela = estado.uf_geral

    expect(tabela.title).to eq 'Ranking Geral: SP'
  end

  it 'deve mostrar o ranking de nomes masculino de uma UF' do
    estado = Estado.new('SP')
    tabela = estado.uf_masc

    expect(tabela.title).to eq 'Ranking Masculino: SP'
  end

  it 'deve mostrar o ranking de nomes feminino de uma UF' do
    estado = Estado.new('SP')
    tabela = estado.uf_fem

    expect(tabela.title).to eq 'Ranking Feminino: SP'
  end
end