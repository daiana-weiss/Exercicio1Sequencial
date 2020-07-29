      $set sourceformat"free"

      *>Divisão de identificação do programa
       identification division.
       program-id. "lista11exe1_sequencial".
       author. "Daiana Weiss".
       installation. "PC".
       date-written. 23/07/2020.
       date-compiled. 23/07/2020.


      *>Divisão para configuração do ambiente
       environment division.
       configuration section.
           special-names. decimal-point is comma.

      *>-----Declaração dos recursos externos
       input-output section.
       file-control.

           select arqCad assign to "arqCad.txt" *> associando arquivo logico
           organization is line sequential      *> forma de organizacao dos dados
           access mode is sequential            *> forma de tratamento dos dados
           lock mode is automatic               *> forma de tratamento dead lock (evita que duas pessoas mexam no arquivo ao mesmo tempo)
           file status is ws-fs-arqCad.         *> file status (nessa variavel vai aparecer o codigo de status do arquivo. se for diferente de 0, eh erro.)

       i-o-control.

      *>Declaração de variáveis
       data division.

      *>----Variaveis de arquivos
       file section.
       fd arqCad.
       01 fd-cad.
           05 fd-cod                               pic 9(004). *> codigo do aluno
           05 fd-nome-alu                          pic X(035). *> nome do aluno
           05 fd-nome-mae                          pic X(035). *> nome da mae do aluno
           05 fd-nome-pai                          pic X(035). *> nome do pai do aluno
           05 fd-data-nasc                         pic X(010). *> data de nascimento do aluno
           05 fd-fase                              pic 9(002). *> fase em que o aluno está
           05 fd-tel-cont                          pic X(015). *> telefone de um dos pais
           05 fd-email                             pic X(025). *> email de um dos pais
           05 fd-endereco                          pic X(100). *> endereco da familia
           05 fd-alergico                          pic X(001). *> eh alergico?
               88 fd-eh-alergico                   value "S" "s". *> se sim, fd-eh-alergico = verdadeiro
               88 fd-n-eh-alergico                 value "N" "n". *> se nao, fd-n-eh-alergico = verdadeiro

      *>----Variaveis de trabalho
       working-storage section.

       77 ws-fs-arqCad                             pic  9(02).

       01 ws-cad.
           05 ws-cod                               pic 9(004) value zeros.
           05 ws-nome-alu                          pic X(035) value spaces.
           05 ws-nome-mae                          pic X(035) value spaces.
           05 ws-nome-pai                          pic X(035) value spaces.
           05 ws-data-nasc                         pic X(010) value spaces.
           05 ws-fase                              pic 9(002) value zeros.
           05 ws-tel-cont                          pic X(015) value spaces.
           05 ws-email                             pic X(025) value spaces.
           05 ws-endereco                          pic X(100) value spaces.
           05 ws-alergico                          pic X(001) value spaces.
               88 ws-eh-alergico                   value "S" "s".
               88 ws-n-eh-alergico                 value "N" "n".

       01 ws-tela-menu.
          05  ws-cadastro-aluno                    pic  x(01).
          05  ws-consulta-cadastro                 pic  x(01).


       77 ws-sair                                  pic  x(01).
          88  fechar-programa                      value "x" "x".
          88  voltar                               value "v" "V".

       77 ws-menu                                  pic  x(02).


       77 ws-msn-erro-ofsset                       pic 9(02).
       77 ws-msn-erro-cod                          pic 9(02).
       77 ws-msn-erro-text                         pic X(42).


      *>----Variaveis para comunicação entre programas
       linkage section.


      *>----Declaração de tela
       screen section.


       01  tela-menu.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
           05 blank screen.
           05 line 01 col 01 value "                                                                     [ ]Sair     ".
           05 line 02 col 01 value "                                Cadastro de Alunos                               ".
           05 line 03 col 01 value "      MENU                                                                       ".
           05 line 04 col 01 value "        [ ]Cadastro de Alunos                                                    ".
           05 line 05 col 01 value "        [ ]Consulta de Cadastro                                                  ".

           05 sc-sair-menu  line 01  col 71 pic x(001) using ws-sair                 foreground-color 12.
           05 sc-endereco      line 04  col 10 pic x(001) using ws-cadastro-aluno    foreground-color 15.
           05 sc-alergico      line 05  col 10 pic x(001) using ws-consulta-cadastro foreground-color 15.



       01  tela-cad-aluno.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
           05 blank screen.
           05 line 01 col 01 value "                                                                     [ ]Sair     ".
           05 line 02 col 01 value "                                Cadastro de Alunos                               ".
           05 line 03 col 01 value "       Codigo        :                                                           ".
           05 line 04 col 01 value "       Nome          :                                                           ".
           05 line 05 col 01 value "       Nome da mae   :                                                           ".
           05 line 06 col 01 value "       Nome do pai   :                                                           ".
           05 line 07 col 01 value "       Data nasc     :                                                           ".
           05 line 08 col 01 value "       Fase          :                                                           ".
           05 line 09 col 01 value "       Telefone      :                                                           ".
           05 line 10 col 01 value "       E-mail        :                                                           ".
           05 line 11 col 01 value "       Endereco      :                                                           ".
           05 line 13 col 01 value "       Alergico (S/N):                                                           ".


           05 sc-sair-cad-alu  line 01  col 71 pic x(001) using ws-sair      foreground-color 12.
           05 sc-cod           line 03  col 23 pic 9(004) using ws-cod       foreground-color 15.
           05 sc-nome-aluno    line 04  col 23 pic x(035) using ws-nome-alu  foreground-color 15.
           05 sc-mae           line 05  col 23 pic x(035) using ws-nome-mae  foreground-color 15.
           05 sc-pai           line 06  col 23 pic x(035) using ws-nome-pai  foreground-color 15.
           05 sc-data-nasc     line 07  col 23 pic x(010) using ws-data-nasc foreground-color 15.
           05 sc-fase          line 08  col 23 pic 9(002) using ws-fase      foreground-color 15.
           05 sc-telefone      line 09  col 23 pic x(015) using ws-tel-cont  foreground-color 15.
           05 sc-email         line 10  col 23 pic x(025) using ws-email     foreground-color 15.
           05 sc-endereco      line 11  col 23 pic x(100) using ws-endereco  foreground-color 15.
           05 sc-alergico      line 13  col 23 pic x(001) using ws-alergico  foreground-color 15.


       01  tela-consulta-cad.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
           05 blank screen.
           05 line 01 col 01 value "                                                                     [ ]Sair     ".
           05 line 02 col 01 value "                                Cadastro de Alunos                               ".
           05 line 03 col 01 value "       Codigo        :                                                           ".
           05 line 04 col 01 value "       Nome          :                                                           ".
           05 line 05 col 01 value "       Nome da mae   :                                                           ".
           05 line 06 col 01 value "       Nome do pai   :                                                           ".
           05 line 07 col 01 value "       Data nasc     :                                                           ".
           05 line 08 col 01 value "       Fase          :                                                           ".
           05 line 09 col 01 value "       Telefone      :                                                           ".
           05 line 10 col 01 value "       E-mail        :                                                           ".
           05 line 11 col 01 value "       Endereco      :                                                           ".
           05 line 13 col 01 value "       Alergico (S/N):                                                           ".


           05 sc-sair-cad-alu  line 01  col 71 pic x(001) using ws-sair      foreground-color 12.
           05 sc-cod           line 03  col 23 pic 9(004) from  ws-cod       foreground-color 12.
           05 sc-nome-aluno    line 04  col 23 pic x(035) from  ws-nome-alu  foreground-color 15.
           05 sc-mae           line 05  col 23 pic x(035) from  ws-nome-mae  foreground-color 15.
           05 sc-pai           line 06  col 23 pic x(035) from  ws-nome-pai  foreground-color 15.
           05 sc-data-nasc     line 07  col 23 pic x(010) from  ws-data-nasc foreground-color 15.
           05 sc-fase          line 08  col 23 pic 9(002) from  ws-fase      foreground-color 15.
           05 sc-telefone      line 09  col 23 pic x(015) from  ws-tel-cont  foreground-color 15.
           05 sc-email         line 10  col 23 pic x(025) from  ws-email     foreground-color 15.
           05 sc-endereco      line 11  col 23 pic x(100) from  ws-endereco  foreground-color 15.
           05 sc-alergico      line 13  col 23 pic x(001) from  ws-alergico  foreground-color 15.



      *>Declaração do corpo do programa
       procedure division.


           perform inicializa.
           perform processamento.
           perform finaliza.

      *>------------------------------------------------------------------------
      *>  Procedimentos de inicialização
      *>------------------------------------------------------------------------
       inicializa section.

           .
       inicializa-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  Processamento principal
      *>------------------------------------------------------------------------
       processamento section.

           perform until fechar-programa
                display erase
                move spaces to ws-cadastro-aluno
                move spaces to ws-consulta-cadastro
                move spaces to ws-sair

                display tela-menu
                accept tela-menu

                if ws-cadastro-aluno = "X"
                or ws-cadastro-aluno = "x" then
                       perform cadastra-aluno
                end-if
                if ws-consulta-cadastro = "X"
                or ws-consulta-cadastro = "x" then
                       perform consulta-cad-aluno
                end-if
           end-perform
           .
       processamento-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  Rotina de consulta de cadastro  - lê o arquivo
      *>------------------------------------------------------------------------
       consulta-cad-aluno section.

      *>   abrindo arquivo apenas para leitura
           open input arqCad

      *>       tratamento de file status
               if ws-fs-arqCad <> 00 then
                   move 1                                 to ws-msn-erro-ofsset
                   move ws-fs-arqCad                      to ws-msn-erro-cod
                   move "Erro ao abrir arq. para consulta" to ws-msn-erro-text
                   perform finaliza-anormal
               end-if

           perform until voltar or ws-fs-arqCad = 10
      *> -------------  Ler dados do arquivo
               read arqCad
      *>       tratamento de file status
               if ws-fs-arqCad <> 00 and ws-fs-arqCad <> 10 then
                   move 2                                 to ws-msn-erro-ofsset
                   move ws-fs-arqCad                      to ws-msn-erro-cod
                   move "Erro ao ler arq. para consulta." to ws-msn-erro-text
                   perform finaliza-anormal
               end-if


      *>       move os dados da var do arquivo para as variaveis de trabalho
               move  fd-cad       to  ws-cad

               display tela-consulta-cad
               accept tela-consulta-cad

           end-perform

      *>   fechar arquivo
           close arqCad

      *>   tratamento de file status
           if ws-fs-arqCad <> 00 then
               move 3                                  to ws-msn-erro-ofsset
               move ws-fs-arqCad                       to ws-msn-erro-cod
               move "Erro ao fechar arq. de consulta." to ws-msn-erro-text
               perform finaliza-anormal
           end-if


           .
       consulta-cad-aluno-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  Rotina de cadastro de aluno  - escreve no arquivo
      *>------------------------------------------------------------------------
       cadastra-aluno section.

      *>    abrindo o arquivo com o comando extend - se nao tiver um arquivo existente ele cria. se tiver,
      *>   ele continua cadastrando neste mesmo arquivo.
           open extend arqCad

      *>   tratamento de file status
           if ws-fs-arqCad <> 00 and ws-fs-arqCad <> 05 then
               move 4                                 to ws-msn-erro-ofsset
               move ws-fs-arqCad                      to ws-msn-erro-cod
               move "Erro ao abrir arq. de cadastro." to ws-msn-erro-text
               perform finaliza-anormal
           end-if


      *>   pedindo as informacoes do cadastro do aluno
           perform until voltar
      *>       inicializando variaveis
               move zeros  to  ws-cod
               move spaces to  ws-nome-alu
               move spaces to  ws-nome-mae
               move spaces to  ws-nome-pai
               move spaces to  ws-data-nasc
               move zeros  to  ws-fase
               move spaces to  ws-tel-cont
               move spaces to  ws-email
               move spaces to  ws-endereco
               move spaces to  ws-alergico

      *>       recebendo os dados do cadastro
               display tela-cad-aluno
               accept tela-cad-aluno

      *> -------------  Salvar dados no arquivo ------------------
      *>       mover as informacoes obtidas para a var do arquivo
               move  ws-cad       to  fd-cad

      *>       gravar as informacoes obtidas no arquivo
               if ws-nome-alu <> spaces then
                   write fd-cad
               end-if


           end-perform

      *>   fechar arquivo
           close arqCad

      *>   tratamento de file status
           if ws-fs-arqCad <> 00 then
               move 5                                 to ws-msn-erro-ofsset
               move ws-fs-arqCad                      to ws-msn-erro-cod
               move "Erro ao fechar arq. de cadastro." to ws-msn-erro-text
               perform finaliza-anormal
           end-if
           .
       cadastra-aluno-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  Finalização  Anormal
      *>------------------------------------------------------------------------
       finaliza-anormal section.
           display erase

      *>   imprimindo mensagens de erro
           display ws-msn-erro-ofsset
           display ws-msn-erro-cod
           display ws-msn-erro-text
           Stop run
           .
       finaliza-anormal-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  Finalização
      *>------------------------------------------------------------------------
       finaliza section.

           Stop run
           .
       finaliza-exit.
           exit.




