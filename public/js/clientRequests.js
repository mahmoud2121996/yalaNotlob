/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function filterFunction() {
    var input, filter, ul, li, a, i;
    input = document.getElementById("myInput");
    div = document.getElementById("myDropdown");
    results = document.getElementById('results');
    invited = document.getElementById('invited');

    $.get( `/friends/search/${input.value}`, function(data) {
        a = div.getElementsByTagName("a");
        results.innerHTML = "";
        for (i = 0; i < data.message.length; i++) {
            let a = document.createElement('a');
            a.innerHTML = data.message[i].name;
            a.setAttribute("class", "result");
            a.setAttribute("id", data.message[i].id);
            a.addEventListener("click", () => {
                let added = document.getElementsByClassName(`card w-50 ${a.getAttribute('id')}`)[0];
                let add = true;

                if(added){
                    added.remove();
                }else{
                    let card = document.createElement('div');
                    card.setAttribute('class', `card w-50 ${a.getAttribute('id')}`);
                    let img = document.createElement('img');
                    if(data.type == "friend"){
                        img.setAttribute('src', '/assets/images/user.png');
                    }else{
                        img.setAttribute('src', '/assets/images/group.png');
                    }
                    img.setAttribute('class', 'card-img-top');
                    img.setAttribute('alt', '...');
                    let card_body = document.createElement('div');
                    card_body.setAttribute('class', 'card-body');
                    let h5 = document.createElement('h5');
                    h5.setAttribute('class', 'card-title');
                    h5.innerHTML = a.innerHTML;
                    let btn = document.createElement('a');
                    btn.setAttribute('class', 'btn btn-danger');
                    btn.innerHTML = 'Remove';
                    let hidden = document.createElement('input');
                    hidden.setAttribute('type', 'hidden');
                    if(data.type == "friend"){
                        groupsAdded = document.getElementsByClassName('groups[]');
                        
                        if(groupsAdded.length > 0){
                            add = false;
                            $('.errorMsg').html('<li id="last" class="alert alert-danger" role="alert"><b>You can not add friends and groups together</b></li>');
                            $(".alert").fadeOut(7000);
                        }else{
                            hidden.setAttribute('name', 'id[]');
                            hidden.setAttribute('class', 'id[]');
                        }
                    
                    }else{
                        idsAdded = document.getElementsByClassName('id[]');

                        if(idsAdded.length > 0){
                            add = false;
                            $('.errorMsg').html('<li id="last" class="alert alert-danger" role="alert"><b>You can not add friends and groups together</b></li>');
                            $(".alert").fadeOut(7000);
                        }else{
                            hidden.setAttribute('name', 'groups[]');
                            hidden.setAttribute('class', 'groups[]');
                        }
                       
                    }

                    hidden.value = a.getAttribute('id');

                    card_body.append(h5);
                    card_body.append(btn);
                    card_body.append(hidden);

                    
                    card.append(img);
                    card.append(card_body);
                    if(add){
                        invited.append(card);
                        a.remove();
    
                        btn.addEventListener('click', () => {
                            card.remove();
                        });
                    }
                   
                }
            });
            results.append(a);
        }
    });
    
} 

function searchByMail(){
    var input;
    input = document.getElementById("myInput");
    div = document.getElementById("myDropdown");
    results = document.getElementById('results');
    results.classList.remove('d-none');

    $.get( `/friends/search-by-mail/${input.value}`, function(data) {
        a = div.getElementsByTagName("a");
        results.innerHTML = "";
        console.log(data.message[0]);
        for (i = 0; i < data.message.length; i++) {
            let a = document.createElement('a');
            a.innerHTML = data.message[i][1];
            a.setAttribute("class", "result");
            a.setAttribute("id", data.message[i][0]);
            a.setAttribute("data-email", data.message[i][4]);
            a.addEventListener("click", () => {
                input.value = a.getAttribute("data-email");
                results.setAttribute("class", "d-none");
            })
            results.append(a);
        }
    })
}