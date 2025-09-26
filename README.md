# ULA (Unidade Lógica e Aritmética) em Verilog

Este projeto implementa uma Unidade Lógica e Aritmética (ULA) de 4 bits em Verilog. A ULA é capaz de realizar diversas operações aritméticas e lógicas, exibindo os resultados em displays de 7 segmentos.

## Funcionalidades

A ULA pode executar as seguintes operações:

* **Adição:** `A + B`
* **Subtração:** `A - B`
* **Multiplicação:** `A * B`
* **Divisão:** `A / B`
* **AND Lógico:** `A & B`
* **OR Lógico:** `A | B`
* **XOR Lógico:** `A ^ B`

## Entradas e Saídas

### Entradas

| Porta | Largura (bits) | Descrição |
| --- | --- | --- |
| `A` | 4 | Operando A |
| `B` | 4 | Operando B |
| `Cin` | 1 | Carry de entrada para as operações de soma e subtração. |
| `Selector` | 3 | Seleciona a operação a ser executada. |

### Saídas

| Porta | Largura (bits) | Descrição |
| --- | --- | --- |
| `S` | 8 | Resultado da operação. |
| `Cout` | 1 | Carry de saída da soma ou "borrow" de saída da subtração. |
| `error` | 1 | Flag de erro. Ativada em caso de divisão por zero ou overflow (resultado maior que 99). |
| `zero` | 1 | Flag de zero. Ativada quando o resultado da operação é zero. |
| `seg_a` - `seg_g` | 1 (cada) | Saídas para o display de 7 segmentos que indica a operação selecionada. |
| `unit_a` - `unit_g` | 1 (cada) | Saídas para o display de 7 segmentos que exibe o dígito das unidades do resultado. |
| `tens_a` - `tens_g` | 1 (cada) | Saídas para o display de 7 segmentos que exibe o dígito das dezenas do resultado. |

## Seleção de Operação

A operação é selecionada através da entrada `Selector` de 3 bits, conforme a tabela abaixo:

| `Selector[2:0]` | Operação |
| --- | --- |
| `001` | Adição |
| `010` | Subtração |
| `011` | Multiplicação |
| `100` | Divisão |
| `101` | AND |
| `110` | OR |
| `111` | XOR |
| `000` | Nenhuma |

## Módulos Utilizados

O projeto é modular e utiliza os seguintes componentes:

* **FullAdder4Bit**: Somador completo de 4 bits.
* **FullSubtractor4Bit**: Subtrator completo de 4 bits.
* **Multiplier**: Multiplicador de 4 bits.
* **Divider**: Divisor de 4 bits.
* **And4bit, Or4bit, Xor4bit**: Módulos para as operações lógicas.
* **mux8to1**: Multiplexador de 8 para 1, utilizado para selecionar o resultado da operação.
* **DecoderOps**: Decodificador para exibir a operação selecionada no display de 7 segmentos.
* **ResultConverter**: Converte o resultado binário de 8 bits para BCD (Binary Coded Decimal) para ser exibido nos displays de dezenas e unidades.
* **DecoderResults**: Decodificador para os displays de 7 segmentos que mostram o resultado.

## Flags

* **Zero Flag (`zero`):** É ativada (`1`) quando todos os bits do resultado `S` são `0`.
* **Error Flag (`error`):** É ativada (`1`) em duas condições:
    1.  **Divisão por Zero:** Quando a operação de divisão é selecionada (`Selector` = `100`) e o operando `B` é zero.
    2.  **Overflow:** Quando o resultado da operação excede 99, o que ultrapassa a capacidade de exibição dos dois displays de 7 segmentos.