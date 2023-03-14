
function update(){
    var checked = 0;
    var progress_bar = document.getElementById("progress-done");
    //Reference the Form.
    var tasks = document.getElementById("tasks");
    var boxes = tasks.querySelectorAll("input[type='checkbox']:checked");
    checked = boxes.length;
    var k = document.querySelectorAll("input[type='checkbox']").length;
    progress_bar.style.width = ((checked / k) * 100) + "%";
}
checks = document.querySelectorAll("input[type='checkbox']");
checks.forEach(function(box) {
    box.addEventListener("change", function(e) {
        update()
    });

});
function fade(){
    var element = document.getElementById("menu-content");
    if(element.style.opacity <= 0.1){
        var op = 0.1;  // initial opacity
        element.style.display = 'block';
        var timer = setInterval(function () {
            if (op >= 1){
                clearInterval(timer);
            }
            element.style.opacity = op;
            element.style.filter = 'alpha(opacity=' + op * 100 + ")";
            op += op * 0.1;
        }, 10);
    }
    if(element.style.opacity > 0.1 ){
        var op = 1;  // initial opacity
        var timer = setInterval(function () {
        if (op <= 0.1){
            clearInterval(timer);
            element.style.display = 'none';
        }
        element.style.opacity = op;
        element.style.filter = 'alpha(opacity=' + op * 100 + ")";
        op -= op * 0.1;
    }, 10);
    }
}
function listOut(e){
 const headerList = document.getElementById('anchor-list');
 const anchorList = headerList.children;
 var list1 = document.getElementById('first');
 var list2 = document.getElementById('second');
 var list3 = document.getElementById('third');
    if(e == anchorList[0]){
        list1.style.display = 'block';
        list2.style.display = 'none';
        list3.style.display = 'none';
    }
    if(e == anchorList[1]){
        list1.style.display = 'none';
        list2.style.display = 'block';
        list3.style.display = 'none';
    }
    if(e == anchorList[2]){
        list1.style.display = 'none';
        list2.style.display = 'none';
        list3.style.display = 'block';
    }
}

