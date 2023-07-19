---
marp: true
theme: default
paginate: true
header:  <div style="display: flex;flex-direction: row; align-items: center; width: 100%;"><img style="float: center; width: 80px;" src="unb.png"> &nbsp; _UnB - Introdução ao processamento de Imagens_</div>
footer: Hand Gesture Recognition based on Shape Parameters
style: |
  .columns {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 1rem;
  }
---

<!-- _paginate: false -->
<!-- _header: ""-->
<!-- _footer: "" -->

# Adaptação do artigo "Hand Gesture Recognition based on Shape Parameters" by Meenakshi Panwar

&nbsp;
&nbsp;

**Ana Beatriz Pontes**
**Hyago Gabriel Figueiredo**

---

# Artigo base

- Sistema em tempo real para reconhecimento de gestos de mão
- Objetivo: reconhecer gestos de mão para gerar comandos para um computador

![bg right:50% w:650](exemploClasificacao.jpg)

---

# Metodologia - artigo base

- Fórmulas usadas:
  &nbsp;
  $$M_{ij} = \sum_x\sum_y x^i y^j I(x,y)$$
  $$E.D(a,b)=\sqrt{(x_a - x_b)^2 + (y_a - y_b)^2}$$

![bg right:50% w:450](diagrama_original.jpg)

---

#### Passo a passo do artigo base

&nbsp;

- Segmentação K-means
- Preenchimento de buracos

![bg right w:500](exemplo.jpg)

---
<div class="columns">
<div>
<br><br><br><br>

- Detecção de orientação
- Detecção de pontos de interesse
- Rotação da imagem

</div>
<div>

Identificação|Dimensões
:------------------------------------:|:---------------------:
![right w:230](img48.jpg) | ![w:200](img49.jpg)
![right w:200](img46.jpg) | ![w:200](img47.jpg)
</div>
</div>


---

- Detecção do polegar
- Idenificação de picos a aprtir do centroide da imagem

![bg vertical right w:230](img51.jpg)
![bg w:600](exemplo1.jpg)

---

![bg right:50% w:550](tabela.jpg)

# Resultados - artigo base

- Gera uma sequencia de bits binários
- Compara com uma base de dados
- Classifica o gesto

---

# Nossa metodologia

![w:1000](diagrma.png)

---

# Resultados

- Exemplo de resultado assertivo

**_Legenda dos pontos:_**
Cor|Significado
:---:|:---:
🔴 | Todos os possíveis pontos
🟡 | Pontos cotados como topo
🟢 | Resultado para máximos locais

![bg right w:150](teste.jpg) ![bg w:260](bom1.png)

---

# Resultados

- Exemplo de resultado incerto

**_Legenda dos pontos:_**
Cor|Significado
:---:|:---:
🔴 | Todos os possíveis pontos
🟡 | Pontos cotados como topo
🟢 | Resultado para máximos locais

![bg right w:300](teste9.jpg) ![bg  w:370](incerteza2.png)

---

# Resultados

- Exemplo de resultado não satisfatório

**_Legenda dos pontos:_**
Cor|Significado
:---:|:---:
🔴 | Todos os possíveis pontos
🟡 | Pontos cotados como topo
🟢 | Resultado para máximos locais

![bg right w:250](teste2.jpg) ![bg  w:300](menos.png)

---

# Conclusões

<!-- _paginate: false -->
<!-- _header: ""-->
<!-- _footer: "" -->

- Desafios encontrados
- Diferenças de resultados entre o artigo base e a nossa metodologia
- Pontos similares entre os resultados
- Possíveis melhorias

---

# Referencias

<!-- _paginate: false -->
<!-- _header: ""-->
<!-- footer: " " -->

- Meenakshi Panwar and Pawan Singh Mehra , “Hand Gesture Recognition
  for Human Computer Interaction”
- Amornched Jinda-apiraksa, Warong Pongstiensak, and Toshiaki Kondo,
  ”A Simple Shape-Based Approach to Hand Gesture Recognition”
- A. Jinda-Apiraksa, W. Pongstiensak, and T. Kondo, “Shape-Based Finger
  Pattern Recognition using Compactness and Radial Distance”
- Rajeshree Rokade , Dharmpal Doye, Manesh Kokare, “Hand Gesture
  Recognition by Thinning Method”

---
<!-- _paginate: false -->
<!-- _footer: "Imagem de agradecimento retirada dos slides do Professor Pedro Garcia. Fonte: https://github.com/pedrogarciafreitas" -->

![bg fit](thanks.png)
