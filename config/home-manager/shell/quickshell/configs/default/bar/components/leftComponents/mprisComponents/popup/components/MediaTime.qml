import "../../../../../components"

BarText {
    height: 25
    width: info.width - background.offset
    text: `${Math.round(player.position / 60)}:${String(Math.round(player.position % 60)).padStart(2, '0')} / ${Math.round(player.length / 60)}:${String(Math.round(player.length % 60)).padStart(2, '0')}`
}
