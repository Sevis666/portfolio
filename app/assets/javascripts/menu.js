function toggleSideMenu() {
    var main = document.getElementsByTagName("main")[0];
    var menu = document.getElementById("side-menu");
    if (main.className == "side-menu-is-open") {
        main.className = "";
    } else {
        main.className = "side-menu-is-open";
    }
}
