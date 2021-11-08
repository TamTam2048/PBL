window.handleDisplayProfileDropdown = () => {
    let dropdown = document.getElementById('profile-dropdown');
    if (dropdown.style.display === 'none') {
        dropdown.style.display = 'block';
    } else {
        dropdown.style.display = 'none';
    }
}
