$(function() {
	var homepage = $('#homepage');
	
	if(homepage.length > 0){
    	var vm = {
    		concerts: ko.observableArray(),
    		toggleArtists: function(){
    			this.artists_info_visible(this.artists_info_visible() ? false : true);
    		}
    	};
    	
    	$.getJSON(homepage.data('api'), function(data) {
    		for (var i=0; i<data.length; i++) {
	    		var concert = data[i];
	    		concert.artists_info_visible = ko.observable(false);
              	vm.concerts.push(concert)
            }
	    	ko.applyBindings(vm);
	    });
	}
});