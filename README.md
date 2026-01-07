<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>32-bit ALU UVM Verification</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<style>
/* Reset */
* { margin:0; padding:0; box-sizing:border-box; }

/* Body */
body { font-family: 'Inter', sans-serif; background:#f5f7fa; color:#1c1c1c; line-height:1.6; padding:20px 40px; }
header { text-align:center; margin-bottom:30px; }
header h1 { color:#284139; font-size:2.8em; margin-bottom:5px; }
header .subtitle { color:#809076; font-size:1.2em; margin-bottom:10px; }

/* Badges */
.badges { display:flex; justify-content:center; gap:10px; margin-bottom:20px; }
.badges img { height:25px; }

/* TOC */
#toc { background:#ffffff; padding:15px 20px; border-radius:8px; border-left:6px solid #BB6830; margin-bottom:25px; box-shadow:0 4px 10px rgba(0,0,0,0.05);}
#toc h2 { color:#284139; cursor:pointer; }
#toc ul { list-style:none; padding-left:10px; margin-top:10px; display:none; }
#toc li { margin-bottom:8px; }

/* Sections */
section { background:#ffffff; padding:20px 30px; margin-bottom:25px; border-left:6px solid #BB6830; border-radius:8px; box-shadow:0 4px 10px rgba(0,0,0,0.05);}
section h2 { color:#284139; cursor:pointer; }
section.collapsible { max-height:5000px; transition:max-height 0.3s ease; overflow:hidden; }

/* Tools Highlight */
.tool { background-color:#BB8D3F; color:#fff; padding:2px 8px; border-radius:4px; font-weight:bold; }

/* Preformatted blocks */
pre { background-color:#E8F0F2; padding:12px; border-radius:6px; overflow-x:auto; margin-bottom:10px; display:none; }

/* Expand buttons */
.expand-btn { background:#284139; color:#fff; border:none; padding:5px 10px; border-radius:5px; cursor:pointer; margin-bottom:8px; font-size:0.9em; }
.expand-btn:hover { background:#507CA9; }

/* Footer */
footer { text-align:center; margin-top:40px; padding-top:10px; border-top:1px solid #ddd; color:#555; font-size:0.9em; }

/* Collapsible toggle */
.collapsed h2::after { content:' ▼'; float:right; }
.expanded h2::after { content:' ▲'; float:right; }

</style>
</head>
<body>

<header>
    <h1>32-bit ALU UVM Verification</h1>
    <p class="subtitle">Professional Verification Environment using UVM, IMC, SimVision & Verisim Debug</p>
</header>

<div class="badges">
    <img src="https://img.shields.io/badge/Build-Passing-brightgreen" alt="Build Status">
    <img src="https://img.shields.io/badge/Coverage-95%25-blue" alt="Coverage">
    <img src="https://img.shields.io/github/stars/username/repo?style=social" alt="GitHub Stars">
</div>

<div id="toc">
    <h2 onclick="toggleTOC()">Table of Contents</h2>
    <ul>
        <li><a href="#overview">Overview</a></li>
        <li><a href="#features">Features</a></li>
        <li><a href="#tools">Tools Used</a></li>
        <li><a href="#structure">Directory Structure</a></li>
        <li><a href="#getting-started">Getting Started</a></li>
        <li><a href="#contribution">Contribution Guidelines</a></li>
        <li><a href="#authors">Authors</a></li>
        <li><a href="#license">License</a></li>
    </ul>
</div>

<section id="overview" class="collapsible expanded">
    <h2>Overview</h2>
    <p>This project provides a complete <strong>UVM (Universal Verification Methodology)</strong> environment for a <strong>32-bit ALU</strong>. It ensures functional correctness, performance, and reliability using constrained-random stimulus, coverage analysis, and assertions.</p>
</section>

<section id="getting-started" class="collapsible expanded">
    <h2>Getting Started</h2>

    <h3>Running Simulation</h3>
    <button class="expand-btn" onclick="toggleCode(this)">Show/Hide Compile & Run Code</button>
    <pre>
# Compile
vcs -sverilog rtl/alu.sv lab2/alu_env.sv +incdir+lab1 -debug_access+all -l compile.log

# Run simulation
./simv +UVM_TESTNAME=alu_basic_test -l sim.log

# View waveforms
simvision simv.vpd &
    </pre>

    <h3>Coverage Collection (IMC)</h3>
    <button class="expand-btn" onclick="toggleCode(this)">Show/Hide Coverage Code</button>
    <pre>
imc collect -f sim.log -o coverage_report
    </pre>
</section>

<footer>
    <p>© 2026 Aqdar Ahmed | 32-bit ALU UVM Verification</p>
</footer>

<script>
// TOC toggle
function toggleTOC() {
    const ul = document.querySelector("#toc ul");
    ul.style.display = ul.style.display === "block" ? "none" : "block";
}

// Section collapsible
document.querySelectorAll('section h2').forEach(h2 => {
    h2.addEventListener('click', () => {
        const section = h2.parentElement;
        section.classList.toggle('expanded');
        section.classList.toggle('collapsed');
        section.style.maxHeight = section.classList.contains('expanded') ? section.scrollHeight + "px" : "40px";
    });
});

// Expandable code snippets
function toggleCode(btn) {
    const pre = btn.nextElementSibling;
    if(pre.style.display === "block") {
        pre.style.display = "none";
        btn.textContent = "Show/Hide Code";
    } else {
        pre.style.display = "block";
        btn.textContent = "Hide Code";
    }
}
</script>

</body>
</html>
