// Copyright (c) 2025 ETH Zurich, University of Bologna
//
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

module stream_fork_blocking_dynamic #(
    parameter int unsigned N_OUP = 0    // Synopsys DC requires a default value for parameters.
) (
    input  logic                valid_i,
    output logic                ready_o,
    input  logic [N_OUP-1:0]    sel_i,
    output logic [N_OUP-1:0]    valid_o,
    input  logic [N_OUP-1:0]    ready_i
);

    // Block data input unless:
    //  - at least one output is selected
    //  - AND all selected outputs are ready
    assign ready_o = |sel_i && &(ready_i & sel_i);

    // Drive valid_o high only for selected outputs when valid_i is asserted and all are ready
    assign valid_o = {N_OUP{valid_i && ready_o}} & sel_i;

endmodule
