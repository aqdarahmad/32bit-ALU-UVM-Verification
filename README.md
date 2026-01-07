<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>32-bit ALU UVM Verification</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>32-bit ALU UVM Verification</h1>
        <p class="subtitle">Professional Verification Environment using UVM, IMC, SimVision & Verisim Debug</p>
    </header>

    <section>
        <h2>Overview</h2>
        <p>This project provides a complete <strong>UVM (Universal Verification Methodology)</strong> environment for a <strong>32-bit ALU</strong>. It ensures functional correctness, performance, and reliability using constrained-random stimulus, coverage analysis, and assertions.</p>
    </section>

    <section>
        <h2>Features</h2>
        <ul>
            <li><strong>UVM Components:</strong> Driver, Monitor, Sequencer, Scoreboard, Functional coverage, Assertions</li>
            <li><strong>ALU Operations:</strong> Add, Subtract, AND, OR, XOR, Shifts, Rotates, Overflow detection</li>
            <li><strong>Verification Methodology:</strong> Constrained-random tests, Transaction-based sequences, Reference model comparison</li>
        </ul>
    </section>

    <section>
        <h2>Tools Used</h2>
        <ul>
            <li><span class="tool">IMC</span> – Metrics & Coverage Collection</li>
            <li><span class="tool">SimVision</span> – Waveform viewing & simulation debug</li>
            <li><span class="tool">Verisim Debug</span> – Step-by-step RTL debugging</li>
            <li><span class="tool">Synopsys VCS</span> – RTL simulation engine</li>
        </ul>
    </section>

    <section>
        <h2>Directory Structure</h2>
        <pre>
project/
│
├─ lab1/       # Sequence items and sequences
├─ lab2/       # Testbench top and environment
├─ rtl/        # ALU RTL files
├─ sim/        # Simulation scripts & logs
├─ coverage/   # Functional coverage reports
└─ README.html # Project documentation
        </pre>
    </section>

    <section>
        <h2>Getting Started</h2>
        <h3>Prerequisites</h3>
        <ul>
            <li>Linux OS with VCS installed</li>
            <li>UVM 1.2+ library</li>
            <li>SSH access to repo</li>
        </ul>

        <h3>Running Simulation</h3>
        <pre>
# Compile
vcs -sverilog rtl/alu.sv lab2/alu_env.sv +incdir+lab1 -debug_access+all -l compile.log

# Run simulation
./simv +UVM_TESTNAME=alu_basic_test -l sim.log

# View waveforms
simvision simv.vpd &
        </pre>

        <h3>Coverage Collection (IMC)</h3>
        <pre>
imc collect -f sim.log -o coverage_report
        </pre>
    </section>

    <section>
        <h2>Contribution Guidelines</h2>
        <ul>
            <li>Ensure sequences are covered by functional tests</li>
            <li>Maintain coding standards for SystemVerilog/UVM</li>
            <li>Use IMC, SimVision, and Verisim debug for verification</li>
            <li>Push changes only after passing regression tests</li>
        </ul>
    </section>

    <section>
        <h2>Authors</h2>
        <p><strong>Aqdar Ahmed</strong> – Project Lead & Verification Engineer</p>
    </section>

    <section>
        <h2>License</h2>
        <p>MIT License – see LICENSE file for details</p>
    </section>

    <footer>
        <p>© 2026 Aqdar Ahmed | 32-bit ALU UVM Verification</p>
    </footer>
</body>
</html>
/* Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Body */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f5f7fa;
    color: #1c1c1c;
    line-height: 1.6;
    padding: 20px 40px;
}

/* Header */
header {
    text-align: center;
    margin-bottom: 40px;
}

header h1 {
    color: #284139; /* Emerald Green */
    font-size: 2.5em;
    margin-bottom: 10px;
}

header .subtitle {
    color: #809076; /* Wasabi */
    font-size: 1.2em;
}

/* Sections */
section {
    background: #ffffff;
    padding: 20px 30px;
    margin-bottom: 25px;
    border-left: 6px solid #BB6830; /* Egyptian Earth */
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
}

section h2 {
    color: #284139; /* Emerald Green */
    margin-bottom: 15px;
}

section h3 {
    color: #BB6830; /* Egyptian Earth */
    margin-top: 10px;
    margin-bottom: 10px;
}

ul {
    list-style-type: disc;
    padding-left: 20px;
    margin-bottom: 10px;
}

ul li {
    margin-bottom: 8px;
}

/* Tools Highlight */
.tool {
    background-color: #BB8D3F; /* Gold */
    color: #fff;
    padding: 2px 8px;
    border-radius: 4px;
    font-weight: bold;
}

/* Preformatted blocks */
pre {
    background-color: #E8F0F2;
    padding: 12px;
    border-radius: 6px;
    overflow-x: auto;
    margin-bottom: 10px;
}

/* Footer */
footer {
    text-align: center;
    margin-top: 40px;
    padding-top: 10px;
    border-top: 1px solid #ddd;
    color: #555;
}

