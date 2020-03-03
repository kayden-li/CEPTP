var totop = document.querySelector("#float")
window.onscroll = function() {
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop
	console.log(scrollTop)
	if (scrollTop > 50) {
		totop.className = "show"
	} else {
		totop.className = "top"
	}
}