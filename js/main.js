(function () {
  'use strict';

  const navToggle = document.querySelector('.nav-toggle');
  const menu = document.getElementById('menu');

  if (navToggle && menu) {
    navToggle.addEventListener('click', () => {
      const isOpen = navToggle.getAttribute('aria-expanded') === 'true';
      navToggle.setAttribute('aria-expanded', String(!isOpen));
      menu.classList.toggle('is-open', !isOpen);
    });
  }

  // Copy-to-clipboard for contact links with data-copy
  const copyLinks = document.querySelectorAll('[data-copy]');

  const copyText = async (text) => {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      await navigator.clipboard.writeText(text);
    } else {
      const textarea = document.createElement('textarea');
      textarea.value = text;
      textarea.setAttribute('aria-hidden', 'true');
      textarea.style.position = 'fixed';
      textarea.style.opacity = '0';
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand('copy');
      document.body.removeChild(textarea);
    }
  };

  const showFeedback = (element, message) => {
    let status = element.parentElement.querySelector('.copy-feedback');
    if (!status) {
      status = document.createElement('span');
      status.className = 'copy-feedback';
      status.setAttribute('role', 'status');
      status.setAttribute('aria-live', 'polite');
      element.parentElement.appendChild(status);
    }
    status.textContent = message;
    clearTimeout(status._timer);
    status._timer = setTimeout(() => {
      status.textContent = '';
    }, 1500);
  };

  copyLinks.forEach((link) => {
    link.addEventListener('click', async (event) => {
      event.preventDefault();
      const value = link.getAttribute('data-copy');
      try {
        await copyText(value);
        showFeedback(link, 'Copiato');
      } catch (error) {
        showFeedback(link, 'Errore copia');
      }
    });
  });

  // Placeholder hooks for future filters/ordering (cards, timeline)
  // Example structure: data attributes already in HTML (data-year, data-type, data-stack, data-order)
  // These can be wired to controls without altering layout.
})();
