/**
 * pdf 파일 렌더링
 */
var pdfDoc = null,
	pageRendering = false,
	pageNumPending = null,
	scale = 1.5,
    num = document.getElementsByClassName('pdfCanvas');

function canvasSetting(num, page, numPages){
	return new Promise(function(resolve){
		if(numPages === 1){
			num = '';
		}
		
		var canvases = document.getElementById('the-canvas'+num+''),
			context = canvases.getContext('2d');
		var viewport = page.getViewport({scale: scale});
		canvases.height = viewport.height;
		canvases.width = viewport.width;

		var renderContext = {
			canvasContext: context,
			viewport: viewport
		};
		
		resolve(renderContext);
	});
}

function renderPage(num, pdfDoc, numPages) {
	pageRendering = true;
	pdfDoc.getPage(num).then(function(page) {
		canvasSetting(num, page, numPages).then(function(renderContext){
			var renderTask = page.render(renderContext);
                renderTask.promise.then(function() {
                    console.log('페이지 렌더링 완료');
                });
		});
	});
}

/* pdf 페이지 렌더링 */
function pdfRendering(url){
	pdfjsLib.getDocument(url).promise.then(function(pdfDoc_) {
		pdfDoc = pdfDoc_;
		var numPages = parseInt(pdfDoc.numPages);
		if(numPages !== 1){
			for(var i=1; i<=num.length; i++){
				renderPage(i, pdfDoc, numPages);
			}
		}
		else{
			renderPage(1, pdfDoc, numPages);
		}
		
	}, function (reason) {
        console.error(reason);
	});
}