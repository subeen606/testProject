
	var disScroll;
	var lastScrollTop = 0;
	var delta = 5;
	var navbarHeight = $(".header").outerHeight();
	
	$(window).scroll(function () {
		disScroll = true;
	});
	
	setInterval(function() {
		if(disScroll){
			hasScrolled();
			disScroll = false;
		}
	}, 100);
	
	function hasScrolled() {
		var st = $(this).scrollTop();
		
		if(st > lastScrollTop && st > navbarHeight){
			$(".header").css("height", "70px");
			$(".header_content").css("height", "70px");
			/*$(".logo img").css("width", "80%");*/
			
			
		}else{
			if(st + $(window).height() < $(document).height()){
				$(".header").css("height", "130px");
				$(".header_content").css("height", "130px");
			/*	$(".logo img").css("width", "100%")*/
			}
		}
	
	lastScrollTop = st;
	}
	