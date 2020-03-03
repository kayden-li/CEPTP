/**
 * Created by 10245 on 2018/1/18.
 *
 * 轮播图无法暂停，小圆点无法使用
 *
 *
 */
window.onload = function() {
    var list = document.getElementById('list');
    var prev = document.getElementById('prev');
    var next = document.getElementById('next');
    var play = document.getElementById('play');
    var buttons = document.getElementById('buttons').getElementsByTagName('span');

    var choice1 = document.getElementById('choice1')
    var choice2 = document.getElementById('choice2')
    var choice3 = document.getElementById('choice3')
    var choice4 = document.getElementById('choice4')
    var curse = document.getElementById('curse').getElementsByTagName('ul');

    var index = 1;
    var timer;

    /**
     * 课程列表
     */
    choice1.onclick = function () {
        curse[0].className = 'blc'
        curse[1].className = 'non'
        curse[2].className = 'non'
        curse[3].className = 'non'
    }
    choice2.onclick = function () {
        curse[0].className = 'non'
        curse[1].className = 'blc'
        curse[2].className = 'non'
        curse[3].className = 'non'
    }
    choice3.onclick = function () {
        curse[0].className = 'non'
        curse[1].className = 'non'
        curse[2].className = 'blc'
        curse[3].className = 'non'
    }
    choice4.onclick = function () {
        curse[0].className = 'non'
        curse[1].className = 'non'
        curse[2].className = 'non'
        curse[3].className = 'blc'
    }


    /**
     * 轮播图
     * @param offset
     */
    buttons[0].onclick = function () {
        index = 1
        buttonsShow();
        list.style.left = '-1220px';
    }
    buttons[1].onclick = function () {
        index = 2
        buttonsShow();
        list.style.left = '-2440px';
    }
    buttons[2].onclick = function () {
        index = 3
        buttonsShow();
        list.style.left = '-3660px';
    }
    function animate(offset) {
        var newLeft = parseInt(list.style.left) + offset;
        list.style.left = newLeft + 'px';
        if(newLeft<-2440){list.style.left = 0 + 'px';
        }
        if(newLeft>0){list.style.left = -2440 + 'px';
        }
    }
    prev.onclick = function() {
        index -= 1;
        if (index < 1) {
            index = 3;
        }
        buttonsShow();
        animate(1220);
    }
    next.onclick = function() {
        index += 1;
        if (index > 3) {
            index = 1;
        }
        buttonsShow();
        animate(-1220);
    }
    function buttonsShow() {
        for (var i = 0; i < buttons.length; i++) {
            if (buttons[i].className == 'on') {
                buttons[i].className = '';
            }
        }
        buttons[index - 1].className = 'on';
    }
    function playing() {
        timer = setInterval(function() {
            prev.onclick()
        }, 4000)
    }
    // function stop(){
    //     clearInterval(timer);
    // }

    // play.onmouseover = stop()
    play.onmouseout = playing()
    playing();
}















