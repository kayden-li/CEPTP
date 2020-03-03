/**
 * Created by 10245 on 2018/1/22.
 */
var comstyle = document.getElementById("com-style").getElementsByTagName("div")
var resultstyle = document.getElementById("result-style").getElementsByTagName("div")


for(var i = 0; i < 4; ++i){
    comstyle[i].onclick = function () {
        var nodis = document.getElementsByClassName("cho")
        nodis[0].className = "choice-style fl"
        this.className = "choice-style fl cho"
    }
}
for(var i = 0; i < 4; ++i){
    resultstyle[i].onclick = function () {
        var nodis = document.getElementsByClassName("cho")
        nodis[1].className = "choice-style fl"
        this.className = "choice-style fl cho"
    }
}