

const elems = document.querySelectorAll(".ascii-glitch");
const charset = "^$ù6|3#&@*/.?,:!oiuvqz";
const update_every = 90;// ms

/** 
 * Closure for the glitching effect.
 * @param  {Number} p_glitch   The probability of a given character being transformed.
 * @param  {Node}   x          The item to glitch.
 * @return {() => void}        A function that advances the glitching effect one step.
**/
function glitcher(p_glitch,x) {
    
    let original = x.textContent;
    return () => {
        let chars = x.textContent.split("");

        chars.forEach((char,i) => {
            if (char === ' ') return;
            if (Math.random() <= p_glitch){
                chars[i] = charset.charAt(Math.floor(Math.random() * charset.length));
            } else {
                chars[i] = original.charAt(i);
            }
        });
        x.textContent = chars.join("");
    }
}

const glitches = Array.from(elems).map((x) => glitcher(0.2,x));
var last_frame = 0;
function render(time) {

    // Call all the glitch functions every `update_every`
    let delta = time - last_frame;
    if (delta > update_every) {
        last_frame = time;
        glitches.map((x) => x());
    }
    requestAnimationFrame(render);
}
requestAnimationFrame(render);