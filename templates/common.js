function formatDate(timestamp) {
    let date = new Date(timestamp);

    let year = date.getFullYear();
    let month = String(date.getMonth() + 1).padStart(2, '0');
    let day = String(date.getDate()).padStart(2, '0');
    let formattedDate = `${year}-${month}-${day}`;
    return formattedDate;
}

const apiUrl = 'http://localhost:[%PORT%]/api/';

const severity_message = {
    info: "Information",
    low: "Low",
    med: "Medium",
    high: "High",
    crit: "Critical"
}

const severity_color = {
    info: "blue",
    low: "green",
    med: "yellow",
    high: "orange",
    crit: "red"
}
const severity_types = ["crit", "high", "med", "low", "info"];
let global_rules;

async function get_rules() {
    let api_endpoint = apiUrl + "rules"
    await fetch(api_endpoint)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response is incorrect');
        }
        return response.json();
    })
    .then(data => {
        global_rules = data.rules;
    });
}

async function sidemenu() {
    
    const hashValue = window.location.hash;
    const severity_hash = hashValue.substring(1);
    const sidemenu_id = document.getElementById('sidemenu-ul');
    const total_numlist = {crit: 0, high: 0, med: 0, low: 0};
    const rule_numlist = {crit: {}, high: {}, med: {}, low: {}};
    const computer_list = {}
    const api_endpoint = apiUrl + "sidemenu";
    fetch(api_endpoint)
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response is incorrect');
        }
        return response.json();
      })
      .then(data => {
        let sidemenu = {crit: [], high: [], med: [], low: []};
        data.sidemenu.forEach(item => { 
            if (item[0] != "info") {
                sidemenu[item[0]].push(item);
                total_numlist[item[0]] += parseInt(item[3]);
                if (item[1] in rule_numlist[item[0]]) {
                    rule_numlist[item[0]][item[1]] += parseInt(item[3]);
                }
                else {
                    rule_numlist[item[0]][item[1]] = parseInt(item[3]);
                }
            }

            if (item[2] in computer_list) {
                computer_list[item[2]] += parseInt(item[3]);
            }
            else {
                computer_list[item[2]] = parseInt(item[3]);
            }
        });

        console.log(total_numlist);
        console.log(computer_list);

        let li = document.createElement('li');
        let h3 = document.createElement('h3');
        let a = document.createElement('a');
        a.href = "/";
        a.textContent = "Rule Summary";
        h3.classList.add("font-semibold");
        h3.appendChild(a);
        li.appendChild(h3);
        sidemenu_id.appendChild(li);

        for (let severity in rule_numlist) {

          let li = document.createElement('li');
          let btn = document.createElement('button');
          let i = document.createElement('i');
          btn.classList.add("toggle-btn");
          btn.dataset.severity = severity_message[severity].toLowerCase();
          i.classList.add("icon","fas","fa-chevron-right");
          btn.appendChild(i);
          btn.append(severity_message[severity].toLowerCase() + " alerts (" + total_numlist[severity].toLocaleString() + ")");
          li.appendChild(btn);

          let sortedDetections = Object.entries(rule_numlist[severity]).sort((a, b) => b[1] - a[1]);
          let ul = document.createElement('ul');
          ul.classList.add("submenu");
          ul.style.display = "none";

          sortedDetections.forEach(item => {
            let sub_li = document.createElement('li');
            sub_li.classList.add("font-semibold");

            let sub_a = document.createElement('a');
            sub_a.style.cssText = "font-size: 10pt !important";
            sub_a.innerText = "■" + item[0] + " (" + item[1].toLocaleString() + ")";
            sub_a.target = "_blank";
            global_rules.forEach(rule => {
                if (rule[0] == item[0]) {
                    sub_a.href = "/rule/content?alert_title=" + item[0] + "#" + severity_message[severity].toLowerCase();
                    return;
                }
            });
            
            sub_li.appendChild(sub_a);

            let sub_ul = document.createElement('ul');
            sidemenu[severity].sort((a, b) => {if (a[2] <= b[2]) return -1;});
            //console.log(sidemenu[severity]);

            sidemenu[severity].forEach(alert => {
              
              if (alert[1] == item[0]) {
                let alert_li = document.createElement('li');
                let alert_a = document.createElement('a');
                alert_a.classList.add("sidemenu","link","inline-flex","items-center","gap-2","rounded-lg","px-2","py-1","text-sm","font-semibold","text-slate-600","transition","hover:bg-indigo-100","hover:text-indigo-900");
                alert_a.style.cssText = "font-size:10pt !important;";
                alert_a.dataset.class = severity_message[severity].toLowerCase();
                alert_a.href = "/computer?computer=" + encodeURI(alert[2]) + "#" + severity_message[severity].toLowerCase();
                alert_a.innerText = alert[2] + " (" + parseInt(alert[3]).toLocaleString() + ") (" + formatDate(alert[4]) + " ~ " + formatDate(alert[5]) + " )";
                alert_li.appendChild(alert_a);
                
                sub_ul.appendChild(alert_li);
              }
              //console.log(alert);
            });
            sub_li.appendChild(sub_ul);
            ul.appendChild(sub_li);
          });
          li.appendChild(ul);
          
          sidemenu_id.appendChild(li);

        }
        
        // Computer Summary
        let computer_li = document.createElement('li');
        let computer_h3 = document.createElement('h3');
        computer_h3.classList.add("font-semibold");
        let computer_a = document.createElement('a');
        computer_a.href = "/computer/summary";
        computer_a.innerText = "Computer Summary";
        computer_h3.appendChild(computer_a);
        computer_li.appendChild(computer_h3);
        
        sidemenu_id.appendChild(computer_li);

        let computer_list_li = document.createElement('li');
        let computer_list_btn = document.createElement('button');
        computer_list_btn.classList.add("toggle-btn");
        computer_list_btn.dataset.severity = "computer";
        let computer_list_i = document.createElement('i');
        computer_list_i.classList.add("icon","fas","fa-chevron-right");
        computer_list_btn.appendChild(computer_list_i);
        computer_list_btn.append("computers");
        computer_list_li.appendChild(computer_list_btn);

        let computer_list_ul = document.createElement('ul');
        computer_list_ul.classList.add("submenu");
        
        let sortedComputers = Object.entries(computer_list).sort((a, b) => b[1] - a[1]);
        sortedComputers.forEach(computer => {
            let li = document.createElement('li');
            let a = document.createElement('a');
            a.dataset.class = "computer";
            a.style.cssText = "font-size:10pt !important;";
            a.href = "/computer?computer=" + encodeURI(computer[0]) + "#computer";
            a.classList.add("sidemenu","inline-flex","items-center","gap-2","rounded-lg","px-2","py-1","text-sm","font-semibold","text-slate-600","transition","hover:bg-indigo-100","hover:text-indigo-900");
            a.innerText = computer[0] + "(" + computer[1].toLocaleString() + ")";
            li.appendChild(a);
            computer_list_ul.appendChild(li);
        });

        computer_list_li.appendChild(computer_list_ul);
        sidemenu_id.appendChild(computer_list_li);

        const buttons = document.querySelectorAll('.toggle-btn');
        buttons.forEach(button => {
            button.addEventListener('click', function() {
                const submenu = this.nextElementSibling;
                const icon = this.querySelector('.icon');
                if (submenu.style.display === 'block') {
                    submenu.style.display = 'none';
                    icon.classList.remove('fa-chevron-down');
                    icon.classList.add('fa-chevron-right');
                } else {
                    submenu.style.display = 'block';
                    icon.classList.remove('fa-chevron-right');
                    icon.classList.add('fa-chevron-down');
                }
            });
            if (button.dataset.severity == severity_hash) {
                button.click()
            }
        });

    })
    .catch(error => {
        console.log(error.message)
    });
}

window.addEventListener('load', function() {
    const sidebar = document.getElementById('page-sidebar');
    const originalSideWidth = sidebar.clientWidth;
    const dragHandle = document.getElementById('drag-handle');

    dragHandle.addEventListener('mousedown', function(e) {
        document.addEventListener('mousemove', resizeSidebar);
        document.addEventListener('mouseup', stopResizing);
    });
});

function resizeSidebar(e) {
    const newWidth = e.clientX;
    document.getElementById('page-sidebar').style.width = `${newWidth}px`;
    const new_content_width = e.clientX - originalSideWidth;
    document.getElementById('page-content').style.paddingLeft = `${new_content_width}px`;
}

function stopResizing() {
    document.removeEventListener('mousemove', resizeSidebar);
    document.removeEventListener('mouseup', stopResizing);
}