window.addEventListener('load', () => {
    const uploader = document.getElementById('uploader');
    uploader.addEventListener('change', (e) => {
        const file = uploader.files[0];
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = () => {
            const image = reader.result;
            const previewImage = document.getElementById('preview-image');
            previewImage.setAttribute('src', image);
            document.getElementById('preview-image-holder').style.display = 'block';
            document.getElementById('form-uploader').style.display = 'none';
        }
    });
});