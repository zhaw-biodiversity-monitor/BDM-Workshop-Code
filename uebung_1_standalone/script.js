function update_progress(){
    const now = new Date();

    const hours_dec = now.getHours() + now.getMinutes()/60 + now.getSeconds()/3600;

    const percent = hours_dec/24*100

    const percent_text = percent.toFixed(4)+"%"


    document.getElementById("percent").innerHTML = percent_text
    document.getElementById("progress").value = percent
    console.log(percent)
}


setInterval(update_progress, 100)