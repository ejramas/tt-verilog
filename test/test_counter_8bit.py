# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Set values
    dut._log.info("Setting Values")
    dut.en.value = 1
    dut.load.value = 0
    dut.data_in.value = 0
    dut.out_en.value = 1
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("----- Testing Start -----")

    # Test 1: Count for 10 cycles
    await ClockCycles(dut.clk, 10)
    dut._log.info("1. Output Value should be: 10, is: %d", dut.data_out.value)

    # Test 2: Asynchronous Reset
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 1)
    dut._log.info("2. Output Value should be: 0, is: %d", dut.data_out.value)
    dut.rst_n.value = 1

    # Test 3: Load value 100
    await ClockCycles(dut.clk, 10)
    dut.data_in.value = 100
    dut.load.value = 1
    await ClockCycles(dut.clk, 1)
    dut.load.value = 0
    dut._log.info("3. Output Value should be: 100, is: %d", dut.data_out.value)

    # Test 4: Tri-state test
    dut.out_en.value = 0
    await ClockCycles(dut.clk, 1)
    dut._log.info("4. Output Value should be: High Z, is: %d", dut.data_out.value)

    dut._log.info("----- Test Complete -----")



    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
