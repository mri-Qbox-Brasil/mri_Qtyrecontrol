# 🔧 Tyre Control System

Este recurso foi criado para adicionar realismo à sua experiência de direção no FiveM. Ele simula **estouro de pneus** com base em rolagem ou altura, e também permite **substituição manual dos pneus**, com animações, ferramentas e durabilidade configuráveis!

## ⚙️ Configuração

### 🛠 `Debug`

-   `true` ou `false`: Ativa mensagens de debug no console.

### 🚫 `AllowedVehicleClasses`

Define **quais classes de veículos podem sofrer estouro de pneus** ou permitir troca manual. Basta ativar/desativar com `true` ou `false`.

| Classe | Descrição       | Ativo por padrão |
| ------ | --------------- | ---------------- |
| 0      | Compacts        | ✅               |
| 1      | Sedans          | ✅               |
| 2      | SUVs            | ✅               |
| 3      | Coupes          | ✅               |
| 4      | Muscle          | ✅               |
| 5      | Sports Classics | ✅               |
| 6      | Sports          | ✅               |
| 7      | Super           | ✅               |
| 8      | Motorcycles     | ✅               |
| 9      | Off-road        | ✅               |
| 10     | Industrial      | ❌               |
| 11     | Utility         | ❌               |
| 12     | Vans            | ❌               |
| 13     | Bicycles        | ❌               |
| 14     | Boats           | ❌               |
| 15     | Helicopters     | ❌               |
| 16     | Planes          | ❌               |
| 17     | Service         | ❌               |
| 18     | Emergency       | ❌               |
| 19     | Military        | ❌               |
| 20     | Commercial      | ❌               |
| 21     | Trains          | ❌               |

### 🧨 `TyreBurst`

Controla estouro de pneus com base no **grau de rotação lateral** do veículo.

-   `Active`: Ativa ou desativa o sistema.
-   `LoopTimer`: Tempo de verificação em ms.
-   `RollDegree`: Grau mínimo de inclinação lateral para aplicar a chance.
-   `BurstChance`: Chance percentual de estourar o pneu.

### 💥 `FullBurstOnDegree`

Sistema de **estouro completo** dos pneus em casos de capotamento extremo.

-   `Active`: Ativa a lógica.
-   `LoopTimer`: Intervalo de verificação (mais curto para respostas rápidas).
-   `RollDegree`: Grau crítico de rotação para estourar todos os pneus.
-   `BurstChance`: Chance de 0 a 100.

### 🪂 `TyreBurstByHeight`

Simula estouro de pneus após quedas de grande altura.

-   `Active`: Ativa/desativa o recurso.
-   `LoopTimer`: Tempo entre verificações.
-   `MinHeight`: Altura mínima (em metros) para considerar a queda.
-   `BurstChance`: Chance percentual de estourar o pneu.

### 🔧 `TyreChange`

Configurações para o sistema de substituição de pneus.

-   `ItemName` : Nome do item que representa o pneu no inventário.
-   `CancelKey`: Código da tecla para cancelar a troca (168 = F7).
-   `Prop`: Nome do objeto usado como pneu.
-   Animação de segurar o pneu(antes da troca):
    -   `AnimationName`: Nome da animação do emotemenu que será utilizada para segurar o pneu.
-   Animação de trocar o pneu:
    -   `Anim.dict`: Dicionário da animação.
    -   `Anim.anim`: Nome da animação dentro do dicionário.

#### 🛠️ Ferramenta Necessária (`ItemTool`)

-   `Required`: Define se uma ferramenta é necessária.
-   `Name`: Nome do item (ex: `'WEAPON_WRENCH'`).

#### 🔋 Durabilidade da Ferramenta (`ItemDurability`)

-   `Enabled`: Ativa a perda de durabilidade.
-   `Loss`: Quantidade de durabilidade perdida por uso.

#### ⏱️ Tempo

-   `NotifyTime`: Tempo da notificação (em ms).
-   `ChangeTime`: Tempo total para troca do pneu (em ms).
