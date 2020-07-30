const btn = document.querySelector('.Options');
const About = document.querySelector(".About");
const btnOk = document.querySelector(".btnOk");

btn.addEventListener('click', ToggleClas);
About.addEventListener('click', displayAlert)
btnOk.addEventListener('click', closeAlert)

function ToggleClas() {
    const menu = document.querySelector('.menu-bar');
    menu.classList.toggle('active');
}

function displayAlert() {
    const AboutBox = document.querySelector('.AboutBox');
    AboutBox.classList.add('active');
}

function closeAlert() {
    const AboutBox = document.querySelector('.AboutBox');
    AboutBox.classList.remove('active');
}
// window.addEventListener('keydown', () => pF10(e))

// function pF10(e) {
//     if (e.key == "F10") {
//         const menu = document.querySelector('.menu-bar');
//         menu.classList.toggle('active');
//     }
// }

    // var dragItem = document.querySelector("#item");
    // var container = document.querySelector("#container");

    // var active = false;
    // var currentX;
    // var currentY;
    // var initialX;
    // var initialY;
    // var xOffset = 0;
    // var yOffset = 0;

    // container.addEventListener("touchstart", dragStart, false);
    // container.addEventListener("touchend", dragEnd, false);
    // container.addEventListener("touchmove", drag, false);

    // container.addEventListener("mousedown", dragStart, false);
    // container.addEventListener("mouseup", dragEnd, false);
    // container.addEventListener("mousemove", drag, false);

    // function dragStart(e) {
    //   if (e.type === "touchstart") {
    //     initialX = e.touches[0].clientX - xOffset;
    //     initialY = e.touches[0].clientY - yOffset;
    //   } else {
    //     initialX = e.clientX - xOffset;
    //     initialY = e.clientY - yOffset;
    //   }

    //   if (e.target === dragItem) {
    //     active = true;
    //   }
    // }

    // function dragEnd(e) {
    //   initialX = currentX;
    //   initialY = currentY;

    //   active = false;
    // }

    // function drag(e) {
    //   if (active) {

    //     e.preventDefault();

    //     if (e.type === "touchmove") {
    //       currentX = e.touches[0].clientX - initialX;
    //       currentY = e.touches[0].clientY - initialY;
    //     } else {
    //       currentX = e.clientX - initialX;
    //       currentY = e.clientY - initialY;
    //     }

    //     xOffset = currentX;
    //     yOffset = currentY;

    //     setTranslate(currentX, currentY, dragItem);
    //   }
    // }

    // function setTranslate(xPos, yPos, el) {
    //   el.style.transform = "translate3d(" + xPos + "px, " + yPos + "px, 0)";
    // }