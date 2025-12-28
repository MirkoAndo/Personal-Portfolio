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

  // Placeholder hooks for future filters/ordering (cards, timeline)
  // Example structure: data attributes already in HTML (data-year, data-type, data-stack, data-order)
  // These can be wired to controls without altering layout.
})();
