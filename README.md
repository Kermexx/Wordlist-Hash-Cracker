### Descrição do Script Bash para Quebra de Hash

Este script em Bash é utilizado para encontrar uma senha correspondente a um hash específico, utilizando uma wordlist padrão do John the Ripper.

#### Funcionamento do Script:

1. **Definição de Variáveis:**
   - `wordlist="/usr/share/john/password.lst"`: Define o caminho para a wordlist que contém as senhas a serem testadas.
   - `hash="806825f0827b628e81620f0d83922fb2c52c7136"`: Define o hash alvo que desejamos encontrar a senha correspondente.

2. **Loop de Leitura da Wordlist:**
   - `while read senha; do`: Inicia um loop que lê cada senha da wordlist.

3. **Processamento de Hash:**
   - `echo -e "Testando senha ====> $senha"`: Exibe a senha sendo testada.
   - `hashx=$(echo -n "$senha" | md5sum | head -c 32 | base64 -w 0 | sha1sum | head -c 40)`: Calcula o hash da senha da seguinte maneira:
     - `md5sum`: Calcula o hash MD5 da senha.
     - `head -c 32`: Remove a quebra de linha adicionada pelo `md5sum`, capturando apenas os primeiros 32 caracteres do hash MD5.
     - `base64 -w 0`: Codifica o hash MD5 resultante em Base64, sem quebras de linha.
     - `sha1sum`: Calcula o hash SHA1 do resultado Base64.
     - `head -c 40`: Remove a quebra de linha adicionada pelo `sha1sum`, capturando apenas os primeiros 40 caracteres do hash SHA1.

4. **Comparação de Hash:**
   - `if [ "$hash" == "$hashx" ]; then`: Verifica se o hash resultante (`$hashx`) corresponde ao hash alvo (`$hash`).
     - Se correspondente, exibe a senha encontrada.
     - Caso contrário, continua testando as próximas senhas na wordlist.

5. **Finalização do Script:**
   - `exit 0`: Encerra o script com status de sucesso se a senha for encontrada.
   - `exit 1`: Encerra o script com status de falha se a senha não for encontrada após percorrer toda a wordlist.

#### Uso Recomendado:

- Este script é útil durante testes de penetração (`pentest`) para tentar quebrar hashes usando uma wordlist conhecida de senhas.
- Pode ser adaptado modificando a variável `wordlist` para apontar para diferentes wordlists ou ajustando o hash alvo (`$hash`) para quebrar outros hashes específicos.

Esse script exemplifica um método básico de quebra de hash usando Bash, combinando vários comandos para manipular e comparar hashes de forma eficiente.
