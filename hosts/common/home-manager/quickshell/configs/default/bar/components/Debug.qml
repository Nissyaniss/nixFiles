import QtQuick

Item {
    property var to_print
    function debug() {
        console.log("====DEBUG====");
        console.log(to_print);
        console.log("=============");
    }
    state: debug()
}
