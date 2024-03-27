//***************************************************************************//
//                           VERILOG MAINSIM FILE                            //
//Cadence(R) Modus(TM) DFT Software Solution, Version 20.12-s002_1, built Feb//
//***************************************************************************//
//                                                                           //
//  FILE CREATED..............March 27, 2024 at 19:50:48                     //
//                                                                           //
//  PROJECT NAME..............test_scripts                                   //
//                                                                           //
//  TESTMODE..................FULLSCAN                                       //
//                                                                           //
//  INEXPERIMENT..............rca_atpg                                       //
//                                                                           //
//  TDR.......................dummy.tdr                                      //
//                                                                           //
//  TEST PERIOD...............80.000   TEST TIME UNITS...........ns          //
//  TEST PULSE WIDTH..........8.000                                          //
//  TEST STROBE OFFSET........72.000   TEST STROBE TYPE..........edge        //
//  TEST BIDI OFFSET..........0.000                                          //
//  TEST PI OFFSET............0.000    X VALUE...................X           //
//                                                                           //
//  SCAN FORMAT...............parallel SCAN OVERLAP..............yes         //
//  SCAN PERIOD...............80.000   SCAN TIME UNITS...........ns          //
//  SCAN PULSE WIDTH..........8.000                                          //
//  SCAN STROBE OFFSET........8.000    SCAN STROBE TYPE..........edge        //
//  SCAN BIDI OFFSET..........0.000                                          //
//  SCAN PI OFFSET............0.000    X VALUE...................X           //
//                                                                           //
//                                                                           //
//   Individually set PIs                                                    //
//  "clk_i" (PI # 11)                                                        //
//  TEST OFFSET...............8.000    PULSE WIDTH...............8.000       //
//  SCAN OFFSET...............16.000   PULSE WIDTH...............8.000       //
//                                                                           //
//  Active TESTMODEs TM = 1 ..FULLSCAN                                       //
//                                                                           //
//***************************************************************************//

  `timescale 1 ns / 1 ps

  module test_scripts_FULLSCAN_rca_atpg ;

//***************************************************************************//
//                DEFINE VARIABLES FOR ALL PRIMARY I/O PORTS                 //
//***************************************************************************//

  reg [1:13] stim_PIs;   
  reg [1:13] part_PIs;   

  reg [1:13] stim_CIs;   

  reg [1:6] meas_POs;   

  reg [1:6] scan_POs;   
  wire [1:6] part_POs;   

//***************************************************************************//
//                   DEFINE VARIABLES FOR ALL SHIFT CHAINS                   //
//***************************************************************************//

  reg [1:5] stim_CR_1;   

  reg [1:5] meas_OR_1;   

  reg [1:5] part_S_CR_1_TM_1;   

  wire [1:5] part_M_OR_1_TM_1;   


//***************************************************************************//
//                             OTHER DEFINITIONS                             //
//***************************************************************************//

  integer  CYCLE, SCANCYCLE, SERIALCYCLE, PInum, POnum, ORnum, MODENUM, EXPNUM, SCANOPNUM, SEQNUM, TASKNUM, START, NUM_SHIFTS, MultiShift, maxMultiShifts, MultiShiftsLeft, forcePointStart, forcePoint, SCANNUM ; 
  integer  CMD, DATAID, SAVEID, TID, num_files, rc_read, repeat_depth, repeat_heart, repeat_num, MAX, FAILSETID, DIAG_DATAID; 
  integer  test_num, test_num_prev, failed_test_num, num_tests, num_failed_tests, total_num_tests, total_num_failed_tests, total_cycles, scan_num, overlap; 
  integer  num_repeats [1:15]; 
  reg      [1:8185] name_POs [1:6]; 
  reg      [130:0] good_compares, miscompares, miscompare_limit, total_good_compares, total_miscompares, measure_current; 
  reg      [63:0] start_of_repeat [1:15]; 
  reg      [63:0] start_of_current_line, fseek_offset; 
  reg      [130:0] line_number, save_line_number; 
  reg      sim_trace, sim_heart, sim_range, failset, global_term, sim_debug, sim_more_debug, diag_debug; 
  reg      [1:800] PATTERN, pattern, TESTFILE, INITFILE, SOD, EOD, eventID, DIAG_DEBUG_FILE; 
  reg      [1:8184] DATAFILE, SAVEFILE, COMMENT, FAILSET; 
  reg      [1:4096] PROCESSNAME; 

//***************************************************************************//
//        INSTANTIATE THE STRUCTURE AND CONNECT TO VERILOG VARIABLES         //
//***************************************************************************//

  rca
    rca_inst (
      .clk_i    ( part_PIs[11] ),      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
      .rst_i    ( part_PIs[12] ),      // pinName = rst_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .a_i      ({part_PIs[05]  ,      // pinName = a_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                  part_PIs[04]  ,      // pinName = a_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                  part_PIs[03]  ,      // pinName = a_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                  part_PIs[02]}),      // pinName = a_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .b_i      ({part_PIs[09]  ,      // pinName = b_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                  part_PIs[08]  ,      // pinName = b_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                  part_PIs[07]  ,      // pinName = b_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                  part_PIs[06]}),      // pinName = b_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .c_i      ( part_PIs[10] ),      // pinName = c_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .s_o      ({part_POs[05]  ,      // pinName = s_o[3]; 
                  part_POs[04]  ,      // pinName = s_o[2]; 
                  part_POs[03]  ,      // pinName = s_o[1]; 
                  part_POs[02]}),      // pinName = s_o[0]; 
      .c_o      ( part_POs[01] ),      // pinName = c_o; 
      .SE       ( part_PIs[01] ),      // pinName = SE;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .scan_in  ( part_PIs[13] ),      // pinName = scan_in;  tf =  SI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .scan_out ( part_POs[06] )     // pinName = scan_out;  tf =  SO  ; 
      );

//***************************************************************************//
//                        MAKE SOME OTHER CONNECTIONS                        //
//***************************************************************************//

  assign ( weak0, weak1 ) // Termination 
    part_POs [1] = global_term,     // pinName = c_o; 
    part_POs [2] = global_term,     // pinName = s_o[0]; 
    part_POs [3] = global_term,     // pinName = s_o[1]; 
    part_POs [4] = global_term,     // pinName = s_o[2]; 
    part_POs [5] = global_term,     // pinName = s_o[3]; 
    part_POs [6] = global_term;      // pinName = scan_out;  tf =  SO  ; 


  assign ( supply0, supply1 ) // CR = 1 
    rca_inst.scan_in = part_S_CR_1_TM_1 [5] ,   // CR = 1;  pos = 1;  Pin Index = 12;  Pin Name = scan_in;  pinInvFromLatch = no;  Latch Index = 16;  Latch Name = \genblk2[0]_d0t_reg_s_q_o_reg.__iNsT5.dff_primitive;   
    rca_inst.\genblk2[1].reg_s_q_o_reg .SI = part_S_CR_1_TM_1 [4] ,   // CR = 1;  pos = 2;  Pin Index = 77;  Pin Name = \genblk2[1]_d0t_reg_s_q_o_reg.SI;  pinInvFromLatch = no;  Latch Index = 36;  Latch Name = \genblk2[1]_d0t_reg_s_q_o_reg.__iNsT5.dff_primitive;   
    rca_inst.\genblk2[2].reg_s_q_o_reg .SI = part_S_CR_1_TM_1 [3] ,   // CR = 1;  pos = 3;  Pin Index = 132;  Pin Name = \genblk2[2]_d0t_reg_s_q_o_reg.SI;  pinInvFromLatch = no;  Latch Index = 56;  Latch Name = \genblk2[2]_d0t_reg_s_q_o_reg.__iNsT5.dff_primitive;   
    rca_inst.\genblk2[3].reg_s_q_o_reg .SI = part_S_CR_1_TM_1 [2] ,   // CR = 1;  pos = 4;  Pin Index = 187;  Pin Name = \genblk2[3]_d0t_reg_s_q_o_reg.SI;  pinInvFromLatch = no;  Latch Index = 76;  Latch Name = \genblk2[3]_d0t_reg_s_q_o_reg.__iNsT5.dff_primitive;   
    rca_inst.reg_c_q_o_reg.SI = part_S_CR_1_TM_1 [1] ;   // CR = 1;  pos = 5;  Pin Index = 382;  Pin Name = reg_c_q_o_reg.SI;  pinInvFromLatch = no;  Latch Index = 141;  Latch Name = reg_c_q_o_reg.__iNsT5.dff_primitive;   

  assign // OR = 1 
    part_M_OR_1_TM_1 [1] =  rca_inst.scan_out ,   // OR = 1;  pos = 1;  Pin Index = 18;  Pin Name = scan_out;  pinInvFromLatch = no;  Latch Index = 141;  Latch Name = reg_c_q_o_reg.__iNsT5.dff_primitive;   
    part_M_OR_1_TM_1 [2] =  rca_inst.\genblk2[3].reg_s_q_o_reg .Q ,   // OR = 1;  pos = 2;  Pin Index = 188;  Pin Name = \genblk2[3]_d0t_reg_s_q_o_reg.Q;  pinInvFromLatch = no;  Latch Index = 76;  Latch Name = \genblk2[3]_d0t_reg_s_q_o_reg.__iNsT5.dff_primitive;   
    part_M_OR_1_TM_1 [3] =  rca_inst.\genblk2[2].reg_s_q_o_reg .Q ,   // OR = 1;  pos = 3;  Pin Index = 133;  Pin Name = \genblk2[2]_d0t_reg_s_q_o_reg.Q;  pinInvFromLatch = no;  Latch Index = 56;  Latch Name = \genblk2[2]_d0t_reg_s_q_o_reg.__iNsT5.dff_primitive;   
    part_M_OR_1_TM_1 [4] =  rca_inst.\genblk2[1].reg_s_q_o_reg .Q ,   // OR = 1;  pos = 4;  Pin Index = 78;  Pin Name = \genblk2[1]_d0t_reg_s_q_o_reg.Q;  pinInvFromLatch = no;  Latch Index = 36;  Latch Name = \genblk2[1]_d0t_reg_s_q_o_reg.__iNsT5.dff_primitive;   
    part_M_OR_1_TM_1 [5] =  rca_inst.\genblk2[0].reg_s_q_o_reg .Q ;   // OR = 1;  pos = 5;  Pin Index = 23;  Pin Name = \genblk2[0]_d0t_reg_s_q_o_reg.Q;  pinInvFromLatch = no;  Latch Index = 16;  Latch Name = \genblk2[0]_d0t_reg_s_q_o_reg.__iNsT5.dff_primitive;   

//***************************************************************************//
//                     OPEN THE FILE AND RUN SIMULATION                      //
//***************************************************************************//

  initial 
    begin 

      $timeformat ( -12, 2, " ps", 10 ); 

      `ifdef sdf_annotate 
        `ifdef SDF_Minimum 
          $sdf_annotate ("default.sdf",rca_inst,,"sdf_Min.log","MINIMUM");
        `endif 
        `ifdef SDF_Maximum 
          $sdf_annotate ("default.sdf",rca_inst,,"sdf_Max.log","MAXIMUM");
        `endif 
        `ifdef SDF_Typical
          $sdf_annotate ("default.sdf",rca_inst,,"sdf_Typ.log","TYPICAL");
        `endif 
      `endif 

      `ifndef NOT_NC 
        if ( $test$plusargs ( "simvision" ) )  begin 
          $shm_open("simvision.shm"); 
          $shm_probe("AC"); 
        end  
      `endif 

      if ( $test$plusargs ( "vcd" ) )  begin 
        $dumpfile("out.vcd"); 
        $dumpvars(0,test_scripts_FULLSCAN_rca_atpg ); 
      end  

      DATAFILE = 0; 
      sim_setup; 

      `ifdef MISCOMPAREDEBUG 
        diag_debug = 1'b0; 
        if ( $value$plusargs ( "MISCOMPAREDEBUGFILE=%s", DIAG_DEBUG_FILE )) begin 
          DIAG_DATAID = $fopen ( DIAG_DEBUG_FILE, "r" ); 
          if ( DIAG_DATAID ) begin 
            diag_debug = 1'b1; 
            $fclose ( DIAG_DATAID ); 
          end  
          else $display ( "\nERROR (TVE-951): Failed to open the file: Diagnostic 'MISCOMPAREDEBUGFILE' %0s. \n", DIAG_DEBUG_FILE ); 
        end  
      `endif  

      num_files = 0; 
      for ( TID = 1; TID <= 99; TID = TID + 1 ) begin 
        $sformat ( TESTFILE, "TESTFILE%0d=%s", TID, "%s" ); 
        if ( $value$plusargs ( TESTFILE, DATAFILE )) begin 
          DATAID = $fopen ( DATAFILE, "r" ); 
          if ( DATAID )  begin 
            sim_vector_file; 
            num_files = num_files + 1; 
          end  
          else $display ( "\nERROR (TVE-951): Failed to open the file: %0s. \n", DATAFILE ); 
        end  
      end  

      if ( FAILSETID )  $fclose ( FAILSETID ); 

      if ( DATAFILE )  begin
        $display ( "\nINFO (TVE-209): Cumulative Results: " ); 
        $display ( "                      Number of Files Simulated:  %0d ", num_files ); 
        $display ( "                      Total Number of Cycles:     %0d ", total_cycles ); 
        $display ( "                      Total Number of Tests:      %0d ", total_num_tests ); 
        $display ( "                        - Total Passed Tests:     %0d ", total_num_tests - total_num_failed_tests ); 
        $display ( "                        - Total Failed Tests:     %0d ", total_num_failed_tests ); 
        $display ( "                      Total Number of Compares:   %0.0f ", total_good_compares + total_miscompares ); 
        $display ( "                        - Total Good Compares:    %0.0f ", total_good_compares ); 
        $display ( "                        - Total Miscompares:      %0.0f \n", total_miscompares ); 
      end  
      else $display ( "\nWARNING (TVE-661): No input data files found. The data file must be specified using +TESTFILE1=<string>, +TESTFILE2=<string>, ... The +TESTFILEn=<string> keyword is an NC-Sim command. \n" ); 

      $finish; 

    end  

//***************************************************************************//
//                     DEFINE SIMULATION SETUP PROCEDURE                     //
//***************************************************************************//

  task sim_setup; 
    begin 

      total_good_compares = 0; 
      total_miscompares = 0; 
      miscompare_limit = 0; 
      total_num_tests = 0; 
      total_num_failed_tests = 0; 
      total_cycles = 0; 
      SOD = ""; 
      EOD = ""; 
      START = 0; 
      NUM_SHIFTS = 0; 
      MAX = 1; 

      sim_heart = 1'b0; 
      sim_range = 1'b1; 
      sim_trace = 1'b0; 
      sim_debug = 1'b0; 
      sim_more_debug = 1'b0; 

      global_term = 1'bZ; 

      failset = 1'b0; 
      FAILSETID = 0; 

      CYCLE = 0; 
      SCANCYCLE = 0; 
      SERIALCYCLE = 0; 
      SEQNUM = 0; 
      name_POs [1] = "c_o";      // pinName = c_o; 
      name_POs [2] = "s_o[0]";      // pinName = s_o[0]; 
      name_POs [3] = "s_o[1]";      // pinName = s_o[1]; 
      name_POs [4] = "s_o[2]";      // pinName = s_o[2]; 
      name_POs [5] = "s_o[3]";      // pinName = s_o[3]; 
      name_POs [6] = "scan_out";      // pinName = scan_out;  tf =  SO  ; 



      if ( $test$plusargs ( "MODUS_DEBUG" ) )  sim_trace = 1'b1; 

      if ( $test$plusargs ( "HEARTBEAT" ) )  sim_heart = 1'b1; 

      if ( $value$plusargs ( "START_RANGE=%s", SOD ) )  sim_range = 1'b0; 

      if ( $value$plusargs ( "END_RANGE=%s", EOD ) ); 

      if ( $value$plusargs ( "miscompare_limit=%0f", miscompare_limit ) ); 

      if ( $test$plusargs ( "FAILSET" ) )  failset = 1'b1; 

      stim_PIs = {13{1'bX}};   
      stim_CIs = 13'bXXXXXXXXXX0XX; 
      meas_POs = {6{1'bX}};   
      stim_CR_1 = {5{1'b0}};   
      part_S_CR_1_TM_1 = {5{1'bZ}};   
      meas_OR_1 = {5{1'bX}};   

    end  
  endtask  

//***************************************************************************//
//                          FAILSET SETUP PROCEDURE                          //
//***************************************************************************//

  task failset_setup; 
    begin 

      $sformat ( FAILSET, "%0s_FAILSET", DATAFILE ); 
      FAILSETID = $fopen ( FAILSET, "w" ); 
      if ( ! FAILSETID ) 
        $display ( "\nERROR (TVE-951): Failed to open the file: %0s. \n", FAILSET ); 

    end  
  endtask 

//***************************************************************************//
//                           SET UP FOR SIMULATION                           //
//***************************************************************************//

  task sim_vector_file; 
    begin 

      CYCLE = 0; 
      SCANCYCLE = 0; 
      SERIALCYCLE = 0; 
      good_compares = 0; 
      miscompares = 0; 
      measure_current = 0; 
      test_num = 0; 
      test_num_prev = 0; 
      failed_test_num = 0; 
      num_tests = 0; 
      num_failed_tests = 0; 
      scan_num = 0; 
      overlap = 0; 
      repeat_depth = 0; 
      repeat_heart = 1000; 


      $display ( "\nINFO (TVE-200): Simulating vector file: %0s ", DATAFILE ); 

      $display ( "\nINFO (TVE-189): Design:  rca   Test Mode:  FULLSCAN   InExperiment:  rca_atpg " ); 
      start_of_current_line = $ftell ( DATAID ); 
      line_number = 1; 
      rc_read = $fscanf ( DATAID, "%d", CMD ); 
      while ( rc_read > 0 ) begin 

        cmd_code; 

        if ( rc_read > 0 )  begin 
          if ( sim_range )  begin 
            if (( miscompare_limit > 0 ) & ( miscompares > miscompare_limit ))  begin 
              sim_range = 1'b0; 
              if ( overlap )  num_tests = num_tests - 1; 
              $display ( "\nINFO (TVE-207): The miscompare limit (+miscompare_limit) of %0.0f has been reached. ", miscompare_limit ); 
            end  
            if ( EOD == pattern )  begin 
              sim_range = 1'b0; 
            end  
          end  
          start_of_current_line = $ftell ( DATAID ); 
          rc_read = $fscanf ( DATAID, "%d", CMD ); 
          if ( rc_read <= 0 )  begin 
            rc_read = $fgets ( COMMENT, DATAID ); 
            if ( rc_read > 0 )  bad_cmd_code; 
            else  line_number = 0; 
          end  
        end  
      end  

      if ( line_number == 0 )  begin
        $display ( "\nINFO (TVE-201): Simulation complete on vector file: %0s ", DATAFILE ); 
        $display ( "\nINFO (TVE-210): Results for vector file: %0s ", DATAFILE ); 
        $display ( "                      Number of Cycles:           %0d ", CYCLE ); 
        $display ( "                      Number of Tests:            %0d ", num_tests ); 
        $display ( "                        - Passed Tests:           %0d ", num_tests - num_failed_tests ); 
        $display ( "                        - Failed Tests:           %0d ", num_failed_tests ); 
        $display ( "                      Number of Compares:         %0.0f ", good_compares + miscompares ); 
        $display ( "                        - Good Compares:          %0.0f ", good_compares ); 
        $display ( "                        - Miscompares:            %0.0f ", miscompares ); 
        $display ( "                      Time:                       %t \n", $time ); 
      end  

      $fclose ( DATAID ); 

      total_good_compares = total_good_compares + good_compares; 

      total_miscompares = total_miscompares + miscompares; 

      total_num_tests = total_num_tests + num_tests; 

      total_num_failed_tests = total_num_failed_tests + num_failed_tests; 

      total_cycles = total_cycles + CYCLE; 

    end  
  endtask  

//***************************************************************************//
//                           DEFINE TEST PROCEDURE                           //
//***************************************************************************//

  task test_cycle; 
    begin 

      CYCLE = CYCLE + 1; 
      SERIALCYCLE = SERIALCYCLE + 1; 
     #0.000000;        // 0.000000 ns;  From the start of the cycle.
      part_PIs [1] = stim_PIs [1];      // pinName = SE;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [2] = stim_PIs [2];      // pinName = a_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [3] = stim_PIs [3];      // pinName = a_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [4] = stim_PIs [4];      // pinName = a_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [5] = stim_PIs [5];      // pinName = a_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [6] = stim_PIs [6];      // pinName = b_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [7] = stim_PIs [7];      // pinName = b_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [8] = stim_PIs [8];      // pinName = b_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [9] = stim_PIs [9];      // pinName = b_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [10] = stim_PIs [10];      // pinName = c_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [12] = stim_PIs [12];      // pinName = rst_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [13] = stim_PIs [13];      // pinName = scan_in;  tf =  SI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
     #8.000000;        // 8.000000 ns;  From the start of the cycle.
      part_PIs [11] = stim_PIs [11];      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
     #8.000000;        // 16.000000 ns;  From the start of the cycle.
      part_PIs [11] = stim_CIs [11];      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
     #56.000000;        // 72.000000 ns;  From the start of the cycle.

      for ( POnum = 1; POnum <= 6; POnum = POnum + 1 ) begin 
        if (( part_POs [ POnum ] !== meas_POs [ POnum ] ) & ( meas_POs [ POnum ] !== 1'bX )) begin 
          if ( test_num != failed_test_num )  begin 
            num_failed_tests = num_failed_tests + 1; 
            failed_test_num = test_num; 
          end  
          miscompares = miscompares + 1; 
          $display ( "\nWARNING (TVE-650): PO miscompare at Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t ", test_num, PATTERN, CYCLE, $time ); 
          $display ( "           Expected: %0b   Simulated: %0b   On PO: %0s   ", meas_POs [ POnum ], part_POs [ POnum ], name_POs [ POnum ] ); 

          if (( failset ) & ( FAILSETID == 0 ))  failset_setup; 
          if ( FAILSETID ) begin 
            $fdisplay ( FAILSETID, " Chip %0s pad %0s pattern %0s position %0d value %0b ", "rca", name_POs [ POnum ], PATTERN, -1, part_POs [ POnum ] ); 
          end  
        end  
        else if ( meas_POs [ POnum ] !== 1'bX )  good_compares = good_compares + 1; 
      end  
     #8.000000;        // 80.000000 ns;  From the start of the cycle.
      meas_POs = {6{1'bX}}; 

    end  
  endtask  

//***************************************************************************//
//                       DEFINE SCAN PRECOND PROCEDURE                       //
//***************************************************************************//

  task Scan_Preconditioning_Sequence_TM_1_SEQ_1_SOP_1; 
    begin 

      PROCESSNAME = "SCAN PRECONDITIONING (Scan_Preconditioning_Sequence)";
      stim_PIs [1] = 1'b1;      // pinName = SE;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  

      test_cycle; 
      PROCESSNAME = "";
      PROCESSNAME = "";

    end  
  endtask  

//***************************************************************************//
//                      DEFINE SCAN SEQUENCE PROCEDURE                       //
//***************************************************************************//

  task Scan_Sequence_TM_1_SEQ_2_SOP_1; 
    begin 

      PROCESSNAME = "SCAN SEQUENCE (Scan_Sequence)";
      if ( overlap )  test_num = test_num - 1; 
      SERIALCYCLE = SERIALCYCLE + MAX; 
      CYCLE = CYCLE + 1; 
     #0.000000;        // 0.000000 ns;  From the start of the cycle.

      for ( SCANCYCLE = 1; SCANCYCLE <= MAX; SCANCYCLE = SCANCYCLE + 1 ) begin 

        if (( part_M_OR_1_TM_1 [ 0 + SCANCYCLE ] !== meas_OR_1 [ 0 + SCANCYCLE ] ) & ( meas_OR_1 [ 0 + SCANCYCLE ] !== 1'bX )) begin      // pinName = scan_out;  tf =  SO  ; 
          if ( test_num != failed_test_num )  begin 
            num_failed_tests = num_failed_tests + 1; 
            failed_test_num = test_num; 
          end  
          miscompares = miscompares + 1; 
          $display ( "\nWARNING (TVE-660): Parallel scan miscompare at Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t ", test_num, PATTERN, CYCLE, $time ); 
          $display ( "           Expected: %0b   Simulated: %0b   Observe Register (OR) = 1;   Measured on Scan Cycle: %0d   Feeds Scan Out: %0s   ", meas_OR_1 [ 0 + SCANCYCLE ], part_M_OR_1_TM_1 [ 0 + SCANCYCLE ], SCANCYCLE + 0, name_POs [6] ); 

          if (( failset ) & ( FAILSETID == 0 ))  failset_setup; 
          if ( FAILSETID ) begin 
            $fdisplay ( FAILSETID, " Chip %0s pad %0s pattern %0s position %0d value %0b ", "rca", name_POs [6], PATTERN, SCANCYCLE, part_M_OR_1_TM_1 [ 0 + SCANCYCLE ] ); 
          end  
        end  
        else  begin 
          if ( meas_OR_1 [ 0 + SCANCYCLE ] !== 1'bX )  begin 
            good_compares = good_compares + 1;
          end 
        end 
      end  
     #0.000000;        // 0.000000 ns;  From the start of the cycle.
      part_S_CR_1_TM_1 [1:5] = stim_CR_1 [1:5]; 
     #16.000000;        // 16.000000 ns;  From the start of the cycle.
      part_PIs [11] = 1'b1;      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
     #8.000000;        // 24.000000 ns;  From the start of the cycle.
      part_PIs [11] = 1'b0;      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
     #56.000000;        // 80.000000 ns;  From the start of the cycle.
      part_S_CR_1_TM_1 = {5{1'bZ}};   
     #0; 
      meas_OR_1 = {5{1'bX}};   
      stim_CR_1 = {5{1'b0}};   
      stim_PIs = part_PIs; 
      SCANCYCLE = 0; 
      NUM_SHIFTS = 0; 
      if ( overlap )  test_num = test_num + 1; 
      PROCESSNAME = "";

    end  
  endtask  

//***************************************************************************//
//                 READ COMMANDS AND DATA AND RUN SIMULATION                 //
//***************************************************************************//

  task cmd_code; 
    begin 

      if ( sim_trace )  $display ( "\nCommand code:  %0d ", CMD ); 

      case ( CMD ) 

        000: begin 
          rc_read = 0;  // This will stop execution 
          line_number = line_number + 1; 
        end  

        100: begin 
          rc_read = $fgets ( COMMENT, DATAID ); 
          if ( rc_read > 0 )  begin 
          end  
          else  begin 
            $display ( "\nERROR (TVE-998): Unrecognizable data at line %0.0f in file: %0s \n", line_number, DATAFILE ); 
            $display ( "  Command code = %0d, Unrecognized data = %0s \n", CMD, COMMENT ); 
          end  
          line_number = line_number + 1; 
        end  

        104: begin 
          rc_read = $fgets ( PROCESSNAME, DATAID ); 
          if ( rc_read > 0 )  begin 
          end  
          else  begin 
            $display ( "\nERROR (TVE-998): Unrecognizable data at line %0.0f in file: %0s \n", line_number, DATAFILE ); 
            $display ( "  Command code = %0d, Unrecognized data = %0s \n", CMD, PROCESSNAME ); 
          end  
          line_number = line_number + 1; 
        end  

        110: begin 
          rc_read = $fgets ( COMMENT, DATAID ); 
          if ( rc_read > 0 )  begin 
            $display ( "\n %0s ", COMMENT ); 
          end  
          else  begin 
            $display ( "\nERROR (TVE-998): Unrecognizable data at line %0.0f in file: %0s \n", line_number, DATAFILE ); 
            $display ( "  Command code = %0d, Unrecognized data = %0s \n", CMD, COMMENT ); 
          end  
          line_number = line_number + 1; 
        end  

        151: begin 
          test_num_prev = test_num; 
          rc_read = $fscanf ( DATAID, "%d", test_num ); 
          if ( rc_read > 0 )  begin 
            if (( test_num != test_num_prev ) && ( sim_range ))  num_tests = num_tests + 1; 
          end  
          else  bad_cmd_code; 

          rc_read = $fscanf ( DATAID, "%d", scan_num ); 
          if ( rc_read > 0 )  begin 
          end  
          else  bad_cmd_code; 

          rc_read = $fscanf ( DATAID, "%d", overlap ); 
          if ( rc_read > 0 )  begin 
          end  
          else  bad_cmd_code; 

          line_number = line_number + 1; 
        end  

        200: begin 
          if ( rc_read > 0 )  begin 
            rc_read = $fscanf ( DATAID, "%b", stim_PIs [1:13] ); 
            if ( rc_read <= 0 )  bad_cmd_code; 
            line_number = line_number + 1; 
          end  
        end  

        201: begin 
          if ( rc_read > 0 )  begin 
            rc_read = $fscanf ( DATAID, "%b", stim_CIs [1:13] ); 
            if ( rc_read <= 0 )  bad_cmd_code; 
            line_number = line_number + 1; 
          end  
        end  

        202: begin 
          if ( rc_read > 0 )  begin 
            rc_read = $fscanf ( DATAID, "%b", meas_POs [1:6] ); 
            if ( rc_read <= 0 )  bad_cmd_code; 
            line_number = line_number + 1; 
          end  
        end  

        203: begin 
          rc_read = $fscanf ( DATAID, "%b", global_term ); 
          if ( rc_read > 0 )  begin 
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  

        300: begin 
          rc_read = $fscanf ( DATAID, "%d", MODENUM ); 
          if ( rc_read <= 0 )  bad_cmd_code; 
          else  begin 

            case ( MODENUM ) 

              1: begin 
                rc_read = $fscanf ( DATAID, "%d", SCANNUM ); 
                if ( rc_read <= 0 )  bad_cmd_code; 
                else  begin 

                  case ( SCANNUM ) 

                    1: begin 

                      if ( rc_read > 0 )  begin 
                        rc_read = $fscanf ( DATAID, "%b", stim_CR_1 [1:5] ); 
                        if ( rc_read <= 0 )  bad_cmd_code; 
                        line_number = line_number + 1; 
                      end  
                    end  

                  endcase  
                end  
              end  

            endcase  
          end  
        end  

        301: begin 
          rc_read = $fscanf ( DATAID, "%d", MODENUM ); 
          if ( rc_read <= 0 )  bad_cmd_code; 
          else  begin 

            case ( MODENUM ) 

              1: begin 
                rc_read = $fscanf ( DATAID, "%d", SCANNUM ); 
                if ( rc_read <= 0 )  bad_cmd_code; 
                else  begin 

                  case ( SCANNUM ) 

                    1: begin 

                      if ( rc_read > 0 )  begin 
                        rc_read = $fscanf ( DATAID, "%b", meas_OR_1 [1:5] ); 
                        if ( rc_read <= 0 )  bad_cmd_code; 
                        line_number = line_number + 1; 
                      end  
                    end  

                  endcase  
                end  
              end  

            endcase  
          end  
        end  

        400: begin 
          if ( sim_range )  test_cycle; 
          line_number = line_number + 1; 
        end  

        500: begin 
          repeat_depth = repeat_depth + 1; 
          rc_read = $fscanf ( DATAID, "%d", num_repeats [repeat_depth] ); 
          if ( rc_read > 0 )  begin 
            start_of_repeat[repeat_depth] = $ftell ( DATAID ); 
          end  
          else  bad_cmd_code; 
          if ((sim_range & sim_heart) && repeat_heart) 
            $display ( "\nINFO (TVE-202): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Tests Passed %0d of %0d, Failed %0d.  Start of %0d cycles of a repeat loop.", test_num, pattern, CYCLE + 1, $time, num_tests - num_failed_tests, num_tests, num_failed_tests, num_repeats [repeat_depth] ); 
          line_number = line_number + 1; 
        end  

        501: begin 
          num_repeats [repeat_depth] = num_repeats [repeat_depth] - 1; 
          if ( num_repeats [repeat_depth] )  begin 
            if ((sim_range & sim_heart) && repeat_heart && (num_repeats [repeat_depth] % repeat_heart == 0 )) 
              $display ( "\nINFO (TVE-202): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Tests Passed %0d of %0d, Failed %0d.  Number of cycles remaining in this repeat loop is %0d.", test_num, pattern, CYCLE + 1, $time, num_tests - num_failed_tests, num_tests, num_failed_tests, num_repeats [repeat_depth] ); 
            rc_read = $fseek ( DATAID, start_of_repeat [repeat_depth], 0 ); 
            rc_read = 1; 
            fseek_offset = $ftell ( DATAID ); 
            if ( fseek_offset != start_of_repeat [repeat_depth] )  begin 
              $display ( "\nERROR (TVE-956): A Verilog simulator limitation in the fseek routine has been reached.  The size of the Verilog Data file is so big that it can not support branching using fseek in the Verilog simulator.  Any branching after 9,223,372,036,854,775,807 (0x7fffffffffffffff) bytes of data will not run correctly under the Verilog simulator.  It is recommended that you break up the Verilog Data file using the keyword maxvectorsperfile.  The Verilog Data file:  %0s  \n", DATAFILE ); 
              rc_read = 0;  // This will stop execution 
            end  
          end  
          else  repeat_depth = repeat_depth - 1; 
          line_number = line_number + 1; 
        end  

        600: begin 
          rc_read = $fscanf ( DATAID, "%d", MODENUM ); 
          if ( rc_read <= 0 )  bad_cmd_code; 
          else  begin 

            case ( MODENUM ) 

              1: begin 
                rc_read = $fscanf ( DATAID, "%d", SEQNUM ); 
                if ( rc_read <= 0 )  bad_cmd_code; 
                else  begin 

                  case ( SEQNUM ) 

                    1: begin 
                      rc_read = $fscanf ( DATAID, "%d", MAX ); 
                      if ( rc_read > 0 )  begin 
                        if ( sim_range )  Scan_Preconditioning_Sequence_TM_1_SEQ_1_SOP_1; 
                      end  
                      else  bad_cmd_code; 
                      line_number = line_number + 1; 
                    end  

                    2: begin 
                      rc_read = $fscanf ( DATAID, "%d", MAX ); 
                      if ( rc_read > 0 )  begin 
                        if ( sim_range )  Scan_Sequence_TM_1_SEQ_2_SOP_1; 
                      end  
                      else  bad_cmd_code; 
                      line_number = line_number + 1; 
                    end  

                  endcase  
                end  
              end 

            endcase  
          end  
        end  

        900: begin 
          rc_read = $fscanf ( DATAID, "%s", pattern ); 
          if ( rc_read > 0 )  begin 
            if ( SOD == pattern )  begin 
              sim_range = 1'b1; 
            end  
            if (( sim_range ) & ( scan_num > 0 ))  begin 
              if ( overlap )  $display ( "\nINFO (TVE-211): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Relative Scan: %0d  Overlap Tests %0d and %0d.  Tests Passed %0d of %0d, Failed %0d. ", test_num - 1, pattern, CYCLE + 1, $time, scan_num, test_num - 1, test_num, num_tests - num_failed_tests - 1, num_tests - 1, num_failed_tests ); 
              else  $display ( "\nINFO (TVE-211): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Relative Scan: %0d  Tests Passed %0d of %0d, Failed %0d. ", test_num, pattern, CYCLE + 1, $time, scan_num, num_tests - num_failed_tests, num_tests, num_failed_tests ); 
              scan_num = 0; 
            end  
            else if ( sim_range & sim_heart )  begin 
              $display ( "\nINFO (TVE-202): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Tests Passed %0d of %0d, Failed %0d. ", test_num, pattern, CYCLE + 1, $time, num_tests - num_failed_tests, num_tests, num_failed_tests ); 
            end  
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  

        901: begin 
          rc_read = $fscanf ( DATAID, "%s", PATTERN ); 
          if ( rc_read > 0 )  begin 
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  

        903: begin 
          measure_current = measure_current + 1; 
          line_number = line_number + 1; 
        end  

        904: begin 
          rc_read = $fscanf ( DATAID, "%s", eventID ); 
          if ( rc_read > 0 )  begin 
            `ifdef MISCOMPAREDEBUG 
              if ( diag_debug ) begin 
                $processSimulationDebugFile ( DIAG_DEBUG_FILE, "rca_inst", eventID ); 
              end 
            `endif 
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  

        905: begin 
          rc_read = $fscanf ( DATAID, "%s", eventID ); 
          if ( rc_read > 0 )  begin 
            `ifdef MISCOMPAREDEBUG 
              if ( diag_debug ) begin 
                $processSimulationDebugFile ( DIAG_DEBUG_FILE, "rca_inst", eventID ); 
              end 
            `endif 
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  


        default: begin 
          bad_cmd_code; 
          rc_read = 0;  // This will stop execution 
          line_number = line_number + 1; 
        end  

      endcase  

    end  
  endtask  

//***************************************************************************//
//                          PRINT BAD CMD CODE DATA                          //
//***************************************************************************//

  task bad_cmd_code; 
    begin 

      $display ( "\nERROR (TVE-998): Unrecognizable data at line %0.0f in file: %0s \n", line_number, DATAFILE ); 
      start_of_current_line = $ftell ( DATAID ); 
      rc_read = $fgets ( COMMENT, DATAID ); 
      $display ( "  Command code = %0d, Unrecognized data = %0s \n", CMD, COMMENT ); 
      rc_read = 0;  // This will stop execution 

    end  
  endtask  

  endmodule 
