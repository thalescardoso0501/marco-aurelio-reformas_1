# Marco Aurélio | Reformas e Instalações

Site estático (HTML + CSS + JavaScript puro) para divulgação dos serviços de
Marco Aurélio Fernandes da Silva — drywall, alvenaria, revestimentos e elétrica —
com foco em gerar pedidos de orçamento pelo WhatsApp.

Não usa banco de dados, login, painel administrativo ou build step. É só abrir e usar.

## Estrutura

```
marco-aurelio-reformas/
├── index.html
├── css/
│   └── style.css
├── js/
│   └── script.js
├── assets/
│   └── images/
├── baixar-imagens.ps1
├── favicon.svg
└── README.md
```

## Antes de abrir o site: baixe as imagens

O `index.html` já referencia as imagens pelos caminhos locais
`assets/images/hero-reforma.png`, `drywall.png`, `alvenaria.png`,
`revestimentos.png` e `eletrica.png` — mas a pasta `assets/images/` vem
vazia neste ZIP, porque o ambiente que gerou o site não teve permissão de
rede para baixar os arquivos automaticamente.

Para baixar as 5 imagens com um único clique:

1. Abra a pasta `marco-aurelio-reformas` no VS Code (ou no Explorador de
   Arquivos do Windows).
2. Clique com o botão direito em `baixar-imagens.ps1` e escolha
   **"Executar com PowerShell"**.
   - Alternativa: abra um terminal PowerShell dentro da pasta do projeto e
     rode `.\baixar-imagens.ps1`.
   - Se o Windows bloquear a execução ("...não pode ser carregado porque a
     execução de scripts foi desabilitada..."), rode antes, no mesmo
     terminal: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`
     e execute o script novamente.
3. O script baixa as 5 imagens, salva com os nomes corretos dentro de
   `assets/images/` e confirma no final se todos os arquivos foram criados
   com sucesso. Não é necessário editar nada no código.

Depois disso o site funciona 100% offline/local, sem depender de nenhum
CDN externo.

## Como abrir no VS Code

1. Extraia o `.zip`.
2. Abra a pasta `marco-aurelio-reformas` no VS Code (`Arquivo > Abrir Pasta...`).

## Como visualizar localmente

A forma mais simples é usar a extensão **Live Server** do VS Code:

1. Instale a extensão "Live Server" (autor: Ritwick Dey).
2. Clique com o botão direito em `index.html` e escolha **"Open with Live Server"**.

Alternativa sem extensão (com Python instalado):

```bash
cd marco-aurelio-reformas
python3 -m http.server 8000
```

Depois acesse `http://localhost:8000` no navegador.

Você também pode simplesmente dar duplo clique em `index.html` para abrir
direto no navegador, mas alguns navegadores restringem certos recursos ao
abrir via `file://` — o Live Server é o método recomendado.

## Como trocar textos, telefone e imagens

- **Textos**: edite diretamente o `index.html`. Cada seção está comentada
  (`CABEÇALHO`, `HERO`, `SERVIÇOS`, `COMO FUNCIONA`, `SOBRE`, `CONTATO`, `RODAPÉ`).
- **Telefone/WhatsApp**: o número `5511960247203` aparece nos links `https://wa.me/...`
  espalhados pelo `index.html` (cabeçalho, cada card de serviço, seção de contato,
  rodapé e botão flutuante) e também na constante `WHATSAPP_NUMBER` no início do
  arquivo `js/script.js` (usada pelo formulário rápido). Troque nos dois lugares
  caso o número mude.
- **Imagens**: as fotos ilustrativas dos serviços foram geradas por IA (ver seção
  abaixo) e atualmente estão referenciadas por URL externa no `index.html`. Para
  usar arquivos próprios:
  1. Coloque suas imagens em `assets/images/` (ex.: `hero-reforma.jpg`).
  2. No `index.html`, troque o `src="https://..."` de cada `<img>` pelo caminho
     local, por exemplo: `src="assets/images/hero-reforma.jpg"`.
  3. Otimize as imagens (formato `.jpg`/`.webp`, até ~300–400 KB) antes de subir
     para manter o carregamento rápido.

## Como publicar na Vercel ou Netlify

**Vercel:**
1. Crie uma conta em vercel.com e instale a CLI (`npm i -g vercel`) ou use o
   painel web.
2. Pelo painel: "Add New… > Project", importe a pasta/repositório e mantenha
   as configurações padrão (não há build step — é site estático).
3. Pela CLI: rode `vercel` dentro da pasta do projeto e siga as instruções.

**Netlify:**
1. Crie uma conta em netlify.com.
2. Arraste a pasta `marco-aurelio-reformas` para a área de "Deploy manually"
   no painel do Netlify, ou conecte um repositório Git.
3. Não é necessário configurar comando de build nem diretório de publicação
   além da raiz do projeto.

## Sobre as imagens geradas

As fotos ilustrativas de drywall, alvenaria, pisos/azulejos e elétrica foram
geradas por inteligência artificial (Higgsfield) apenas para representar as
áreas de atuação — elas não são fotos reais de obras do Marco Aurélio.

## Checklist testado antes da entrega

- Navegação por âncoras (Início, Serviços, Como funciona, Contato)
- Menu mobile abre/fecha e fecha ao clicar em um link
- Todos os botões de orçamento (geral + 4 serviços) abrem o WhatsApp em nova
  aba com mensagem pré-preenchida e número `5511960247203`
- Formulário rápido monta a mensagem com serviço, descrição e local, e abre
  o WhatsApp
- Botão flutuante do WhatsApp visível em todas as seções
- Layout responsivo (mobile, tablet, desktop)
- Sem erros no console
