i=0;
//banner===================================
//轮播
//点播
$('.banner ul.dian1 li').click(function(){
	$('.banner .tupian1').stop();
	i=$(this).index();
	$('.banner .tupian1').animate({'left':-i*window.outerWidth},500);
	$(this).addClass('col').siblings().removeClass('col');
});
//自动
t=setInterval(function(){
	if(i==4){
		i=0;
	}
	$('.banner .tupian1').animate({'left':-i*window.outerWidth},500);
	$('.banner ul.dian1 li').eq(i).addClass('col').siblings().removeClass('col');
	i++;
},2000);
//hover停止
$('.banner').hover(function(){
	clearInterval(t);
},function(){
	t=setInterval(function(){
	if(i==4){
		i=0;
	}
	$('.banner .tupian1').animate({'left':-i*window.outerWidth},500);
	$('.banner ul.dian1 li').eq(i).addClass('col').siblings().removeClass('col');
	i++;
},2000);
});
