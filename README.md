# Iugu UX Bundle

Um pacote de bibliotecas e códigos de apoio (glue code) para facilitar o desenvolvimento de aplicações web.

### Vendor / Javascripts ( vendor.js ) 

  - backbone.js
  - gmaps.js (experimental)
  - iscroll.js (experimental)
  - jquery.base64.js
  - jquery.checkboxes.js
  - jquery.cookie.js
  - jquery.ui.js
  - jquery.ui.touch-punch.js (routeia toques para cliques)
  - jquery.web-storage.js
  - underscore.js

### Iugu-UX / JS ( iugu-ux.js )

Porquê?

  - Detecta as capacidades de cada navegador e adiciona na tag **html** como classe CSS
    - .no-js ou .js para suporte à Javascript
    - .not-ready ou .ready para detectar load de carregamentos básicos
    - .desktop ou .mobile para tipo de dispositivos
    - .nome\_SISTEMA para o tipo de navegador
    - .android ou .ios para o tipo de sistema operacional do dispositivo mobile
    - .deprecated\_android para sistemas operacionais androids < 3
    - .os\_SISTEMA para o tipo de sistema operacional
  - .mediaquery para detectar suportes à modelos adaptativos
    - .mq-mp => Mobile Portrait
    - .mq-ml => Mobile Landscape
    - .mq-tb => Tablets
    - .mq-ls => Large Screens
    - .mq-sm => Small Screens
  - Algumas bibliotecas do Twitter Bootstrap (Experimental) e Google Prettify
  - Suporte à I18N via arquivos JSON
  - Organização e inclusão automática de models, delegadores, controladores, apresentadores e funcionalidades
  - Suporte à playback de Som (Experimental)

#### Helpers

detectLanguage: Tenta detectar o idioma do navegador

getMousePos(evento): Descobre a coordenada do clique ou do touch

debug( mensagem ): Adiciona uma linha ao console de depuração do navegador

String.capitalize: Extende a função string para suportar maiúscula na primeira letra

### Iugu-UX / CSS ( iugu-ux.css )

Porquê?

  - Helpers: Funções e Mixins em SASS
  - Gerador Automático de Sprite/Atlas ( Detecção Automática de Retina e Não Retina )
  - Variáveis
  - Componentes
  - Gerador de Código para MediaQuery
  - Reset / Padronizador HTML
  - Tipografia
  - Utilitários

#### Referência SASS Iugu-UX

**Core**

Incluir arquivo "iugu-ux/core"

- Compass/CSS3 Background Size
- Compass/CSS3 Images
- Compass/Utilities/Sprites
- Compass/CSS3
- Mixins
- Mixins Adaptativos
- Sprites Padrões Iugu

**Filtros/Seletores Adaptativos**

Exemplo de uso dos mixins
```sass
@include for-hd()
  body
    background: #FF0000
```

for-hd: Tela de alta definição
for-ios-hd: Retina
for-no-js: Sem suporte à Javascript
for-screen: Tela
for-print: Impressão
for-mobile-portrait: Dipositivos Portateis ( Retrato )
for-mobile-landscape: Dispositivos Portateis ( Paisagem )
for-tables: Tablets (768 ateh 1024)
for-large-screens: Qualquer tela com resolução maior que 1024
for-small-screens: Qualquer tela com resolução menor que 768

**Filtros/Seletores**

- box-mode: Ativar Border-Box
- block( $n ): Largura de $n X tamanho de bloco (Variável)
- text-overflow: Melhora a quebra de texto ( Experimental )
- prefix( $variable, $value ): Ativa prefixos de compatibilidade
- transition( $transition ): Transições de Navegadores
- user-select( $select ): Compatibilidade de Seleção de Usuário

**Reset**

- .auto-clear: Ou clear Fix Iugu
- .clear

**Outros Utilitários em Reset (Beta/Troca de Arquivo)**

- .responsive: Width: 100% (Experimental)
- .only-{android,ios,mobile,desktop}: Seleção criteriosa 

**Sprites**

- build-sprites( $name, $images, $size{ retina, normal } ): Gera automaticamente atlas de sprites, ideal para transformar todas as imagens da aplicação em um único mapa. Leva em consideração e se adapta a telas de alta definição (Retina Display)

```sass
@import "iugu-ux/core"

$iux-default: sprite-map("iux-default/*.png", $layout: smart, $spacing: 0px, $cleanup: true, $sprite-dimensions: true)
@include build-sprites("iux-default", $iux-default, normal)

@include for-hd()
  $iux-default-hd: sprite-map("iux-default-hd/*.png", $layout: smart, $spacing: 0px, $cleanup: true, $sprite-dimensions: true)
    @include build-sprites("iux-default", $iux-default-hd, retina)
```

**Utilitários**

- .no-bottom-margin
- .element-spacing
- .b{1..128}: Bloco
- .icon-

**Variáveis**

```sass
$sansFontFamily: Helvetica, Arial, sans-serif

$baseElementSpacing: 20px
$baseFontSize: 14px
$baseFontFamily: $sansFontFamily
$baseLineHeight: 14px
$baseLineSpacing: 6px
$baseBlockSize: 20px
$baseLineColor: #DDD
$baseLineShadowColor: #BBB

$lineAlternateBackgroundColor: #EFEFEF
$lineHighlightBackgroundColor: #E7E7E7

$gridSpacing: $baseElementSpacing 

$textColor: #333333

$bodyBackgroundColor: #FFFFFF
$applicationBackgroundColor: #F0F0F0

$headingFontWeight: bold
$headingFontColor: #000000

$white: #FFFFFF
$gray: #999999
$red: #b94a48
$yellow: #f89406
$green: #468847
$blue: #3a87ad

$redText: #b94a48
$redBackground: #f2dede
$redBorder: darken(adjust-hue($redBackground, -10), 3%)

$yellowText: #c09853
$yellowBackground: #fcf8e3
$yellowBorder: darken(adjust-hue($yellowBackground, -10), 3%)

$greenText: #468847
$greenBackground: #dff0d8
$greenBorder: darken(adjust-hue($greenBackground, -10), 3%)

$blueText: #3a87ad
$blueBackground: #d9edf7
$blueBorder: darken(adjust-hue($blueBackground, -10), 3%)
```

### Aplicação (Web-App)

