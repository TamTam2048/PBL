window.setup = () => {
    let index;
    if (localStorage.getItem("activeTab")) {
        index = parseInt(localStorage.getItem("activeTab"))
    }
    else {
        index = 0;
        localStorage.setItem("activeTab", "0");
    }
    return {
        activeTab: index,
        handleChangeTab(index) {
            this.activeTab = index
            localStorage.setItem("activeTab", index.toString())
        }
    }
}
