({
	createBarChart : function(cmp, temp) {
	   var dataMap = {"chartLabels": Object.keys(temp),
                       "chartData": Object.values(temp)
                       };
        
        var el = cmp.find('barChart').getElement();
        var ctx = el.getContext('2d');
        
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dataMap.chartLabels,
                datasets: [
                    {
                        label: "My Data",
                        backgroundColor: "rgba(153,255,51,0.4)",
                        data: dataMap.chartData
                    }
                ]
            }
        });	
    }
})