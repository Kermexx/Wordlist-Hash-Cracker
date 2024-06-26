Vou explicar cada parte do código pq eu achei legal.

O código é feito em bash script

Primeiro nós passamos as variáveis da wordlist que vamos usar e do hash que queremos quebrar>

#!/bin/bash

# Define a variável com o caminho para a wordlist
wordlist="/usr/share/john/password.lst"

# Define o hash que queremos quebrar
hash="806825f0827b628e81620f0d83922fb2c52c7136"

--------------

Agora vamos fazer um loop e passar a wordlist que vai ficar dentro desse loop>

while read senha; do
        ...(conteudo do loop aqui dentro)
done < $wordlist

Basicamente estamos fazendo um loop onde cada linha dentro do arquivo "wordlist" é lido e colocado
como "senha", então em resumo cada linha ele coloca o nome de senha. Estamos passando a wordlist
ali no done < $wordlist para ser o loop que vai varrer dentro dessa wordlist

-------------

Aqui é basico, só vai printar na tela que está testando a senha e falar a linha da wordlist que ele eestá>

echo -e "Testando senha ====> $senha"

Depois disso a gente vai transformar as senhas, em um contexto esse código foi criado pq no lab
dizia que o hash que pegamos foi fruto de um script que passou a senha para um md5, desse md5
passou para um base64 e desse base64 passou para um sha1. Então o que a gente está fazendo é
exatamente isso, vamos pegar cada linha da nossa wordlist e tranformar a senha > md5 > base64 > sha1
e depois de transformar a gente testa pra ver se tem alguma que bate, legal né?

hashx=$(echo -n "$senha" | md5sum | head -c 32 | base64 -w 0 | sha1sum | head -c 40)
    
Então estamos colocando essa lógica na variável hashx. Esses "head -c 32, head -c 40 e -w 0" é
só pra ele não considerar a quebra de linha que vai dar, então ele vai pegar exatamente o 
tamanho do hash e não as quebras de linhas.

--------------

Aqui a gente só printa o hash criado na tela

echo "Hash encontrado ====> $hashx"

Agora a gente vai fazer a comparação, vamos testar cada hash, a logica é simples:
Se hash = hashx então fala que encontrou a senha e para o programa.

 if [ "$hash" == "$hashx" ]; then
        echo "####################"
        echo "[+] SENHA ENCONTRADA ====> $senha"
        echo "####################"
        exit 0  # Encerra o script com código de sucesso (0)
 fi


E agora só confirma que fechou > 

exit 1
