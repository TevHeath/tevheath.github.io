document.addEventListener('DOMContentLoaded', function() {
  var dropdowns = document.querySelectorAll('.navbar .dropdown');

  dropdowns.forEach(function(dropdown) {
    dropdown.addEventListener('click', function(event) {
      if (event.target.closest('.dropdown-toggle')) {
        event.preventDefault();
      }
    });
  });
});
