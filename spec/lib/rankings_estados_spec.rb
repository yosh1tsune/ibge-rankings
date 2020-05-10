require 'estados'
require 'active_support/core_ext/kernel/reporting'

describe 'Rankings estados' do
  it 'mostra com sucesso o ranking geral de um estado' do
    uf = [35, 'São Paulo', 'SP']
    $stdout = StringIO.new

    Estados.uf_geral(uf)
    $stdout.rewind

    expect($stdout.gets.strip).to include 
      "Ranking Geral: SP
      
      1. MARIA - Frequência: 2143232
      2. JOSE - Frequência: 1118772
      3. ANA - Frequência: 664153
      4. JOAO - Frequência: 610851
      5. ANTONIO - Frequência: 497959
      6. PAULO - Frequência: 333637
      7. CARLOS - Frequência: 328926
      8. LUCAS - Frequência: 282840
      9. LUIZ - Frequência: 270982
      10. PEDRO - Frequência: 264316
      11. MARCOS - Frequência: 258443
      12. GABRIEL - Frequência: 256501
      13. LUIS - Frequência: 246582
      14. RAFAEL - Frequência: 231278
      15. FRANCISCO - Frequência: 201111
      16. MARCELO - Frequência: 197445
      17. BRUNO - Frequência: 188035
      18. FELIPE - Frequência: 186363
      19. GUILHERME - Frequência: 176046
      20. RODRIGO - Frequência: 173059"
  end

  it 'mostra com sucesso o ranking mawsculino de um estado' do
    uf = [35, 'São Paulo', 'SP']
    $stdout = StringIO.new

    Estados.uf_geral(uf)
    $stdout.rewind

    expect($stdout.gets.strip).to include 
      "Ranking Feminino: SP 

      1. MARIA - Frequência: 2136057
      2. ANA - Frequência: 662035
      3. JULIANA - Frequência: 157939
      4. MARCIA - Frequência: 152146
      5. ADRIANA - Frequência: 149268
      6. APARECIDA - Frequência: 143645
      7. FERNANDA - Frequência: 140306
      8. PATRICIA - Frequência: 139205
      9. ALINE - Frequência: 131893
      10. CAMILA - Frequência: 131233
      11. SANDRA - Frequência: 131018
      12. BRUNA - Frequência: 129465
      13. JULIA - Frequência: 127506
      14. LETICIA - Frequência: 122960
      15. BEATRIZ - Frequência: 122096
      16. GABRIELA - Frequência: 118669
      17. JESSICA - Frequência: 116920
      18. AMANDA - Frequência: 116617
      19. LUCIANA - Frequência: 112676
      20. VANESSA - Frequência: 110214"
  end

  it 'mostra com sucesso o ranking mawsculino de um estado' do
    uf = [35, 'São Paulo', 'SP']
    $stdout = StringIO.new

    Estados.uf_geral(uf)
    $stdout.rewind

    expect($stdout.gets.strip).to include 
      "Ranking Masculino: SP 

      1. JOSE - Frequência: 1115060
      2. JOAO - Frequência: 608330
      3. ANTONIO - Frequência: 496524
      4. PAULO - Frequência: 332376
      5. CARLOS - Frequência: 327672
      6. LUCAS - Frequência: 280197
      7. LUIZ - Frequência: 269909
      8. PEDRO - Frequência: 262959
      9. MARCOS - Frequência: 257364
      10. GABRIEL - Frequência: 253754
      11. LUIS - Frequência: 245546
      12. RAFAEL - Frequência: 229331
      13. FRANCISCO - Frequência: 200457
      14. MARCELO - Frequência: 196612
      15. BRUNO - Frequência: 186596
      16. FELIPE - Frequência: 184644
      17. GUILHERME - Frequência: 174690
      18. RODRIGO - Frequência: 172242
      19. EDUARDO - Frequência: 165321
      20. GUSTAVO - Frequência: 164437"
  end
end