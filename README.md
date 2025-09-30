# Sokoban (RISC-V, RV32I)

A terminal Sokoban implementation written in RISC-V assembly (RV32I), designed to run on the CPUlator RV32 simulator.

---

## Features
- Single-player and two-player turn-based modes
- Win detection and restart flow
- Optional single-player “cheat” mode (see the User Guide)

---

## How to Run (CPUlator)

1. Open CPUlator RV32 (RV32-SPIM):  
   https://cpulator.01xz.net/?sys=rv32-spim
2. Open `src/Sokoban.s` and paste it into CPUlator’s editor.
3. Press **Compile & Load** (F5), then **Continue** (F3).
4. Follow on-screen prompts.

**Controls**

| Key | Action |
|-----|--------|
| `w` | up     |
| `a` | left   |
| `s` | down   |
| `d` | right  |
| `r` | reset  |

For symbols, modes, errors, and tips, see the **[User Guide (PDF)](docs/Sokoban%20User%20Guide.pdf)**.

---

