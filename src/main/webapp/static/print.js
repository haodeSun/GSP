var printThis = function(obj){
	pdfMake.fonts = {
	   yourFontName: {
	     normal: 'MicrosoftYaHeiGB.ttf',
	     bold: 'MicrosoftYaHeiGB.ttf',
	     italics: 'MicrosoftYaHeiGB.ttf',
	     bolditalics: 'MicrosoftYaHeiGB.ttf'
	   }
	}
	var printThisone = {
		header:{
				image: 'data:image/jpg;base64,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',
	     		height:30,
	     		width:50,
	     		margin:[20,5,0,0]
			},
		footer: function(currentPage, pageCount) { 
			return [
				{
					"text": currentPage.toString() + ' ofTotal ' + pageCount,
					"style": "footStyle"
				}
			];
		},
		content: [
			{ text: '', style: 'headStyle' },
			{
				style: 'tableExample',
				table: {
					widths:["auto","*"],
					body: []
				}
			}
		],
		styles: {
			headStyle: {
				fontSize: 14,
				bold: true,
				margin:[230,10]
			},
			tableExample: {
				margin:[-20, 5, 0, 15]
			},
			footStyle: {
				margin:[20, 0, 0, 5]
			}
		},
		defaultStyle: {
    		font: 'yourFontName'
  		}
	}
	printThisone.content[0].text = $("head title").text().replace(/[-\w+]/g,"");
	/*for(var n=0,tdLen=$(obj).parent("td").siblings("td").length;n<tdLen;n++){
		printThisone.content[1].table.body.push([$($("#contentTable").find("th")[n]).text(),$($(obj).parent("td").siblings("td")[n]).text().replace(/[\r\n]/g,"").replace(/(^\s*)|(\s*$)/g,"")]);
	}*/
	for(var n=1,tdLen=$("#contentTable").find("th").length;n<tdLen;n++){
		printThisone.content[1].table.body.push([$($("#contentTable").find("th")[n]).text(),$($("#contentTable").find("tbody").find("input:checkbox:checked").parent("td").siblings("td")[n-1]).text().replace(/[\r\n]/g,"").replace(/(^\s*)|(\s*$)/g,"")]);
	}
	console.log(printThisone.content[1].table.body);
	if($("#contentTable").find("tbody").find("input:checkbox:checked").length>1){
		alertx("只能选择一条信息打印");
	}
	else if($("#contentTable").find("tbody").find("input:checkbox:checked").length == 0){
		alertx("请选择一条要打印的信息");
	}
	else{
		pdfMake.createPdf(printThisone).print();
		$('#modalDialog').modal('hide');
	}
}
	
