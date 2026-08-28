(function () {
  "use strict";

  var WHATSAPP_NUMBER = "5511960247203";

  /* ---------- Menu mobile ---------- */
  var toggle = document.getElementById("menu-toggle");
  var nav = document.getElementById("menu-principal");

  if (toggle && nav) {
    toggle.addEventListener("click", function () {
      var isOpen = nav.classList.toggle("is-open");
      toggle.setAttribute("aria-expanded", isOpen ? "true" : "false");
      toggle.setAttribute("aria-label", isOpen ? "Fechar menu" : "Abrir menu");
    });

    nav.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", function () {
        nav.classList.remove("is-open");
        toggle.setAttribute("aria-expanded", "false");
        toggle.setAttribute("aria-label", "Abrir menu");
      });
    });
  }

  /* ---------- Formulário rápido -> WhatsApp ---------- */
  var form = document.getElementById("form-orcamento");

  if (form) {
    form.addEventListener("submit", function (event) {
      event.preventDefault();

      var tipoServico = document.getElementById("tipo-servico").value.trim();
      var descricao = document.getElementById("descricao").value.trim();
      var local = document.getElementById("local").value.trim();

      if (!tipoServico || !descricao || !local) {
        return;
      }

      var mensagem =
        "Olá, Stilo Drywall! Encontrei seu site e gostaria de solicitar um orçamento.\n\n" +
        "Serviço: " + tipoServico + "\n" +
        "Descrição: " + descricao + "\n" +
        "Local: " + local;

      var url = "https://wa.me/" + WHATSAPP_NUMBER + "?text=" + encodeURIComponent(mensagem);
      window.open(url, "_blank", "noopener");
    });
  }
})();
