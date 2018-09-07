// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Wed Jun 13 10:00:37 2018
// Host        : ninja-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               g:/project_FPGA/power_analyzer/PA_CODE/PA_2018_6_5_X1/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/fre_acc/fre_acc_sim_netlist.v
// Design      : fre_acc
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fre_acc,c_counter_binary_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_10,Vivado 2016.4" *) 
(* NotValidForBitStream *)
module fre_acc
   (CLK,
    CE,
    SCLR,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [31:0]Q;

  wire CE;
  wire CLK;
  wire [31:0]Q;
  wire SCLR;
  wire NLW_U0_THRESH0_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_COUNT_BY = "1" *) 
  (* C_COUNT_MODE = "0" *) 
  (* C_COUNT_TO = "1" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_LOAD = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_HAS_THRESH0 = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_LOAD_LOW = "0" *) 
  (* C_RESTRICT_COUNT = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_THRESH0_VALUE = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "32" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fre_acc_c_counter_binary_v12_0_10 U0
       (.CE(CE),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_U0_THRESH0_UNCONNECTED),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "1" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "0" *) 
(* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "0" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "32" *) 
(* C_XDEVICEFAMILY = "kintex7" *) (* ORIG_REF_NAME = "c_counter_binary_v12_0_10" *) (* downgradeipidentifiedwarnings = "yes" *) 
module fre_acc_c_counter_binary_v12_0_10
   (CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    UP,
    LOAD,
    L,
    THRESH0,
    Q);
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  input UP;
  input LOAD;
  input [31:0]L;
  output THRESH0;
  output [31:0]Q;

  wire \<const1> ;
  wire CE;
  wire CLK;
  wire [31:0]L;
  wire [31:0]Q;
  wire SCLR;
  wire NLW_i_synth_THRESH0_UNCONNECTED;

  assign THRESH0 = \<const1> ;
  VCC VCC
       (.P(\<const1> ));
  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_COUNT_BY = "1" *) 
  (* C_COUNT_MODE = "0" *) 
  (* C_COUNT_TO = "1" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_LOAD = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_HAS_THRESH0 = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_LOAD_LOW = "0" *) 
  (* C_RESTRICT_COUNT = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_THRESH0_VALUE = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "32" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fre_acc_c_counter_binary_v12_0_10_viv i_synth
       (.CE(CE),
        .CLK(CLK),
        .L(L),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_i_synth_THRESH0_UNCONNECTED),
        .UP(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
IrPZT8sJrL4gwcjQ4A7teFTXVZWRVdh6UPM07RVq2FwKwc+JevJgbPZljTLdm83pMI2QQQ+tLnQS
MbZ4Fj9kXA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Xjxc1YFxqqOuRTtcFqb+Qgvi25msCPqB6MteWaomj+1IvhcHL1FqbAcJWhlLpfCxY3h7wM3hUDY1
gZ2GDMJBja7ize2rh09vjUmfwtb/L7c5Le+uxWN9tGTn29dr7Fb/HPAy9YHaq+l6KW2vcmVs5bqa
6AOIAzYCRlgjSVh5+iI=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
W2iY0mEtVej8CRvsjx6juNRjA5oabilHWdENH/ObJyTPEdBkw3WcUoFAo9mS2TONllZEXxXMkV/R
zYZ4+NnzEszGToGUuIXO2rePS9KG/qYLYu+ocaB06pGEbm0pjNbicrGYgBpEZk9/CQzvLtc1ZKmH
KUoF1kGwUDDZaLV3Y7E=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vL2hyj8rfykj77F8iyedkPIoRj8bPGcmwT5sViu6QFIDomMfa+enezpWdeIqg7mtV2lxIXHXWQq2
Nif9EUYSdjEeOm7U/2F8YfjHbXWW4pAbYcPDz0wufebhfByqTrUi29TU4Pzms2No1SyBHK7N7Y7E
xTO7KtlKA2I8v8JoeidD9uPPu84yVRn6BnNYirinE6U+pz63fA/5VkxmDmlitEA7mC1eqTaWmrMj
l9wFVPNJkFb1mFr3owpjLSyOOjnN2w8w1pjZQd4vZU5zkOu+5IjxH9dzt+hPrV9lag6492CSVIMp
Bo99fE/TOBzrmayw/vTIsFnumymv0VGKzSZ/tw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j7tcHAfXlfVr8K10yq5dUrOoTCQlDTOVF01bkmcT0VV31eCSJJD6TxC2OfocSSIPlKK2h+JU5tTw
qPnDzSoVe71M+ZVvyFqoo25ZJpANMae6fwNU211yi848qfxH8dnlRh3MQPipG1c/5l2co14Squ3Q
lzU/jsNFRh4tyKL/oXsudAOpQrXlfDnPXS4UyeE8zD5+Vcrmm/x80V13XrGo9heXGuG02DN6WYQ2
+c2IeUxs+A937VV9Rsf0Dis20A+MYUDq1mJDFLFE1/pv+T9TbpGe/W1Yz7iNeY/jhqMZan/3I3kJ
phnt3cfQOwp0BWZfxDaVKifSzUzdIbCbsVoHrw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lIy7ekoWNfLu2R6GSV4TVNNFD+3yG0n8BmtMDh9u2RcNnvhiFlh5PoPDzKQOKPOqv4dkap866r1O
vtFI+lDmRoh+upItF6oMoraiP4kiKqmqmD/LTaoM7EsledaleDytecQPq+pVHdS/ehmk+Vf66AbO
DPCGr2MQU1mLXFFvTSmVlrawNyg77P889HpOZQ0fBsIGOCJb7hL7YVW4dm/YA7RVCHg0PE7O7PZl
Yy7KsFsVlppe/MZ8b1eNnIYe2D9icFE2UeKPZILe9rv8tEE24VfJ9cHKK3VOAUeurDya19EDR59b
40zNwO++e9S0RNyGWHyFvnYNLkgaXC18mzJ92g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
LBE4Z/bWAe0CpyjTO+xEhdrmjUvLn2R9OgoLZtZrniR34tgMqKKK1H4NWuImACxBS45G/l6hqUDj
Sfri59hms31P5HD4P+QQdFF8x7ir0Oq2Ey7k7wP0CGjBFjOOV6jfryZxuY0VeAbC09ab14v654g4
FZq+aMNNliyEcx0VkG1Ai/3mc/NuY8vVQCYWV1smWRmBKjdtoeSNqRWbIuXghyua5cONAIoFYAEL
HuIc6/uLBXsHdmgpAU+gEJ1OcBz9JSbcSUSLhlsDteSxBnqneLzb4a8omcwFFvR2RoYWkJxdn9nn
K0/MRWopCjBwjH8qAz1zzgscTx1Rnt/k5RHhZw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
JL0v3Jhup2X9Z+NeBSaSNci37fLoOoTQ4pDFkv84hMjfRhMtBYe5cTMxA/Q+uIoJeIWiTWQx+Q9y
UB5cacPIHPQ+avjut1T53OHAQoelQJCmXYqfH1LEKimxpHdAl7jpGRVPyoTluXWd+A4LYCDW3HJn
Q2F701AywSbDutuDHQwTr4aMD1ElJQn4hzNCOP+PTp0PWax9EuLhcZAfSrl/MoQPObbLwo6YMq6U
DWR6zIH6PlglH/tN2dtPbgZX+f1q/pZ0CDBBCxaF4Q2ZixQ2rX4xUdHKjSUIbjxX8+1VydgSqlfR
pWolrvps8+q/tIk3wze/eu2H9CcscchIpqiskg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10768)
`pragma protect data_block
3So4uixl5nlc6iF9cg8Oo/wRRj1HH/9w8hA8bxlgWaQwlXWk8zihClhJ3sGxOKOKrR37R0aYo9oT
KRAFXG8W0HJ5ZG5BSA43VDPW7BOZEFsoQ4K5cZEL0mqkK2ZjJKdygbWybsKuc3nDohjuttvCIPXU
JZSFSehK6L2SQ06OJ3FjttGfaKw3+bpZ27nMIE3Rg2xKsBvwiz47VMVtzhFcoyt26yLSNgGpKxB8
YJcbNzwN6DjHrRB0Xns075L8WoschYjYJs6+RjSJKcfYKjgK10n4xhB6VkndG6EnF9Du/cUzVG8a
6VTF3ARVATiQ0yF7/VN8sVDXXfFjJ8OtYcYfFc2uW4GXOtH9/ifpXy54WAyp0m/WtBnWrFzxaLwf
d9GBe3H12VjVSf6K8JpKI+UTHhtXcltECRktMzSzmlU3ag9eA+GM2/LwI06W2UpKZK9Co55vfHV0
j8WY34Z+kIXuvtBqqgHLGT+Tpo9pzwqi2VqYghvPtN/4A8OoKs/FimS6YqI7caae3AHXtPtMDJgw
yBNjIPZNqeI4AYS07uNOlMJoY5zat0PjW3XTeBpFqWcSMRTwhcPLDyHOJb9v8I2HwTqo1XmSjf0h
FYb6NdbAUxel11YWPs1MlRjoDGVjljQMei2bZgKk5ZBb0uRI4sih+IlpGB2GqMReMHuj04u7iNPG
8NX45xyqlA99jUpFLkVIMeDzsli8vSsiTvJlwulCNuQVXuf/xjPR3MJnW8azoLaKMajxmYOB7HOr
PAdjspRUsBYXp/vgXRENyRruHI/JbPucBgsvJv304llYF344ZcRq0rj/JWww6k16VftlnoHvN6U5
zpBH9z2dTLqAX1GTD7+jsLAosRcYpkot9/30ZKAAMfxSueWLVXoCZXf9ctzfCXJAC61iKY78qq63
xc5FmPzgOKdZnhalGeByJLfhWE/XbK70k7iS3gKz3VqWEkj4hHgfe49AMjoOhhlls5xcv/pF3gwa
ZHg8o1mg4XDlMQ6iFWJTdECIjcPqnFXpqWWXfaH1JQILQWI03xJOhn6O6+XqZ9WAww3LecjUgi1T
ntLuU+NL9a600+08KzqqWBVjhJYxkUqRaBnp3Wn8F4fP9IBh6hFJTSr2tzhjXETZMpNRpleg1O57
GTGic94y1BMqGI5OMK24DLRByo5GLvNkzlEvwipP2Uw5E2QOcpYFQma1qs8WK13j/zo3SqY6q4lg
kO3iB0I5pm94bb4SMW5jLcK6ZJufKBMYKWlvYU0ApuEw1NEwWgHZvdAHf1jFnrE8Acb8qSIdJ+jx
pH3UgvNr6D3RRa2jyNNrgozatflTpy91gC6X0IPA10wa6LJec7F6EUlJc5BPkLXk8T+cu72Vv2m7
mOp0bzqIujhxXMp6pR5+i0PRu2FYLfZEwQw/h6ZhSiXJgr6vNngaVTRWIdJ2MnIYmc5is6PGlTmw
5psAz9Z0HqHvNORpsIpM+tLx4wLc7TzYGqJiAu8Ee27J+4uRXrhdPuSqDaGx4tSpejb4v42Z2LDi
ieD5wMtnSBj1i2nn8+m6TsuR8ezIfpYGk1ixXaUNBpzExAN/0nVub437rFrsETxbdJvxggVV33fY
YtD7uQT2fSkz3MXCiokvKAo26b3J+tX+d+tPNC49jF5h/me3jAEwUBa5fbvp9kUZ6EqGYaIES+yJ
VAdVFoXSpKoWdDGcK7M5YGlQymzBldayAbAAGNTeTNdA9L+P+HYTv4O706BV+Jqv53O1x8uWd7HE
zz69urpgdqBvkD2gk0DJRJ51bJSzwFLVPESMesz+CmPZkBY5w19F/08y/VFUHlBgmVFCE/USJ//s
O9mfVWDm0B97pOwxplXM5D7pIUFMVk7ZxK1d0pWzs1O97hMDitvk+OPESG52aWQpP6ATIitZTKi7
doQn43KF/0YhxmEO7l02HI0G4Ohq32MYGGcUrSHKUkcZDX8WN6Ev45es1J963REvtXbBES23rJqI
BO+xEkOt/co9Fz2JUdxWacWHsD2jsBa7VNXZM20BUzm85tdSKtCVBMdcwnAZi+YXpW0nsU1l9skm
bga6YYDRMsbkH7U4gb12CKJHwA115197nejBFCm+gW5cQKYEbvWWCg9+Bf3FqOMJOStVkfTLSxXf
IIpt/2W2uRFf6RLYgv2JdyBcm/pn6zG8EW4lH6zXrw+1DfolaVCXaV93NBbZlovFHfmHSqrqKBJA
fV+mH4R5Fxlb1fgR3ONZc3pCcYIPQY1gDSa42HAwNULVvO/f5rHgXgmu+CG6mSGlR9nmuKv0GtFV
D+GhW2B1xcMVHw8uUWDZERW7htM384BQmuFI5B/i9mPGmssteZf16EGjG/NtpFaAW2/RKq16m05Q
E05UOZygtDZVgZGGgvaSq5K5+lfFNRDVFjnjSdGzO7Q5GsXRwPRR87W7Quid/I60V3tiYX0UiYAr
qY5TPspXwbgNjENZ2Y0C5an/lq2vn1baIjJpFdOyQ7Ch8Dd7sE3K+6Fl07h25HskW6Bat4S8gLrj
47j1blQtLoFdL58BYhtEZ5P0Hsf58sEA+iTmYXItlX3rRBBU7yEJw9YK/JK4hLRy6HYx6D07K9DY
8sNGgAu/LlK1Wsb77Ev06BLAH6AZ2uxEIt1ls7qcCeYZ3/KprxDOn8ss+C4noEmS19roUCnJSF8J
/8A2W+UWeV8+wzT5QJjxTN1SZuq5krovio8pE+YbOUszh4w3lJRu02tp62PuALSKuRR/Sq0t/Jij
cMYxKxdSZS82C0QyeeidAq15vnqQTnd/n6GEoHK0LykP7XfBBB2AJ/AuQALCYq15Q7tAkfYcuVl1
yRRCdBWKy34hTtcFsb6BTIYacviLQu/bvo0nHYTxl7b7bTnqCOgITgJCjLAl7fQP5YPwg6eh8Drz
dEXxXl99CYC1Vef9nL+dla9tLaTK6+zSodDTZe+DaKWKObYrvK47KEHvdHo7aaSTpf1AaHb/Ij4c
+MrZzxMIGTcoj8M92PYMXvePXlaVSvVfXyOqPVGOjoNAbBdxgHnn9Jvsqua0et3Db+lqNwVmYZc/
6sUx1Oj5hJhK3wIMWaSAIJMG6kHv6WOg7niR3R8X9XvdXYQbowgqjqa1BFgJUECffGMmiVLHUoK4
nCFuFfNfYBk2CNentYgdm3vEzEPKsqn60z8M5zAlLkUpW6UIPlFMIUhU+ARDB8Gefc8dIw2Jce/y
k/3jzZQ4TfszPEIwGQoCeO6M0ZDOEskCWjuyTZ/ub00NeANX5bdFN6M6ujQx00/tU3tEXxQ2xoAV
W7fogLYv70Lx+jTjOPzLG4lEQjifusVp27m3viSUGiZNrDB9BVwG/W7tdDD97Xvfr3fwFUh4SJcd
Mngfvq0ouvIZe0zf/cgFVK3b3LYB9g2QQsdNEyMDBViz4EqYPvxnvwtg/WaMAPeUJhV2IbOvbzuN
5qjthIipsbSJvlUpSNuWmyqmdXh0mqrmkQjQ9BOTiKWrxJEF+cst7J1IO0PS9KILQZgAETHic0hh
K92GgM0aIHq17oeLNm0suK9GPqWHbUsv2Ql5jmZtvhOhxyo0P1M7f47N1JhqAdw6eNozGoIS8H3E
2Cu5Y1YWj809uOYqAojr2bsYdAQ5qkYfGqWRsbY/0LVdDc4VUxl8GiLxL5HmVsmdtw25HonbwTqL
n938j1JvbFbvB6JIJzBp9bDD0/F/o9zzboER+6mCvdl+Ntl4mYshrVYipjt+va9RhvUAyHAtBTR+
Dh0xoJomyCG007Q/8Q7SSVerYHiGWwmNA04g14xi6kpKBorgx6NooOLjOZCBhpPTmufZwzjkL0/H
/JoIXKjnGU3PnHK5cJ+ai0sjBh6yCia6CICiUBhn/SkL+9Qi3iBi8yNqsXJzakd0KEnAEDxChDK7
ko6s99eI/vKZYDuTVp0aC++GKRdthKwg1h6vTIfJDEs1GQ7n4r6D+eSiG1pdoxSCk0hoAndmH0db
4yeZ0/hp+QFkNODCMjW5XqkCwPfy1JxpO2QRRBHIih/Rq91vVZmjFSStZE3MmzS+mqPcWJEHtk8i
bgf0B6gly+li9rxz3nCUBGExfKocQ+B+5DNtPNpZC4eBVWOWlM3i+KWxKIiBs6ZFcpFVpdHTUN+o
VbqOiYnbJFFWEcbFiMQqpSSd3cPeeIG9gufMs6PNKwo5Gqw3e8BCtRhtD/GeO7KcnK6TPiy82k2B
pxruCv34ygEMi0xuzSMSuDEmUbq2QhrH6vn3eTBKnGPhuTVjlwsAQg9uH2JeC2+L4eMW+ZTINgFq
s5/QWOykrOQh4yI5KNcxlpwwAcTzjJwEhZU1nDVl9vSRtNrJrNhaOT8zVpP6Ct/OArplBgeCTsXj
My04R6THF8vTBxgpJxOmufW/uuAUOr6szX9Tvk/PUrpdIQxvXO64+mHDCPwrWFEObyrLPhzFFwIE
yOvXBpFa9cIg9e35pIOEOlCuQ2gbMYqrzIqfmus8d5JebGQPa3Q9lsQPksrNJP4XdsXvBF+CcAzy
FKgANTmi/MQpL7mMwtggE01YKO8lXoeeRSgUVgIzyFfxq7SGZDHn6Ss2bkBSNvtdmTyLk5rdwHUh
MUiu63AWl1sv5K8HYe1G8Fx/yTQroQVHsg3pRQ1ZAq5DcdGjYt1KXsBfNdMsw80gLBMdLd25LD1p
uHYMPcymk3szKa9dHoB8fyqLqcsum7aHGCD17PFU5K4a7OXshKhG4p899MEMtHf/x6UEbHteTTb7
+eD3jXNkyjd7RJvhzCYAWygb+dg7Q5fPfeYVugTkrXQ6ZpaAHmzaQxImUtJEbsNQWZ6cnH8Lzyrb
ueHSxVjTy2vack+f1P6LQGfr1tZzQuZ1p17nBC+PgJ7mzwH/bSonsqfdVMRyBCMs89apQX+S7jRe
twEmbmE3jOTaU4WmQtaLAjdH/JuzUCb+PDXDakKE9vLAc8oW0QCruHIbVD6itRbi3utJO0Ax5+r2
XAPtwN/VKfexjqUQu03ZbQLRM3008uAvH7lI1ZVOkG3CAfwNMC6ZZPcQeIDhrpUQcnKvaoTLQGza
pePBoF+1sXuStc2+5W8ziLuC9usk7kgve2+6b7lnTKOxGwXCdoKM6CK5EF76kri+zdfEahyxE2wF
TBO34wVPwWPG4SIc4rr8hTLY5bvP8e0DpJ/vS0tl02OqAqwbqsrxaIWv1vlnp9/52VUMuy/sF/AN
kwPuzZaBlilR/m7HR6TtPZa33jrCqPQRG2twLdQNGavdw1O8pOMjUs8yQJZPMjJeRCFahopSc2iM
nKpBm1ZEyQ7MFw/TrJVlR06I5iQRp372aAr1l4ElfVCFD0Bvs21p3gqKHsitBxRhGgjHtPjZw6jz
w9XmscccFSmd/qdOuiq4bxbGFWlrWo/MCd30/7DQMVHHIMAl/CWb0s70hqS9DZwscbtsJz6IupjC
wgaUaWkWNxG7upFGdzqAncWaVNg8uHaAj5FL1gCN/I/f4WQgYVgIw0/1//re6S77u1K4kATba6je
OtRqJkXTEA5TsgZch2iNAEHbVMoExzJy4TpJYq40+P0ZlznA3DFu9osHsBrPs6exagtwssiRnacc
gGrlPLU+QI1wMn06Rn2nX/eAgEgntFeCd3F56H3Z7A9xSoJjRNHZcspI0BhCILvnzMyTrmIcEFww
T+5QDnhj0Ymv9lhxir7ifMSwaXTGe9kv2vMOzDvM8o+GzHzwbPiF1bPcwBIuL2dcCBh82nLJvin8
RKIHW2KrBc4bbYckZL2tqVwAO+fFzfhD4NC7LIwiAp7RGWToNzVltjECE5wKA45LT2J0JcUQffTh
0fbKOalxT/ZRxln5xqg+U/4uqgOVA5Lw6Ygo5DxEgKBhCV1IYK7coJcOt32OMWK1NjIOmuA/IUTM
feAKfTUciRY+F44LZN2ZugOjq/Exx9UuJqJe8Ol/H5HfBUoVXxMM/xcyVDijT8Xw8hDeIpuKKUi3
8rUqx8L6shjKmiw2b0dAQL9nrEJkOEmdRmmq2XnUS4R3VxbzxSFmbnjltVbTzAlyPnplbrpsxCSi
+2L7JRlTqgAgF0frAecBHyu1rPeAWw1KVY/6rfTFJZnfFmJa8dKA7AJ2xOYgaJUCsmnvHSQfaBiy
Jpv1nBqzx9j2lLPvlshgUsrmh3xPi/u1YImGrhg7ZG0kCBBotdR8JIQ2cgRuZerMpXUEWhFkxd3z
p3+IX0nrUeQdvFhHwV76P2L2ILC38+X+DBgO560jkxWqSQ2k1Engn8rf48t6/YbPKm714fCU+L1Q
en8GWI/NgX2+tzIfw+twNxo+73AWZ06DhPKm9GnSR3I2FYDPRn72bxVJWbHtyNblrhrLpgnLnTZj
8hD878BQGMBycZIY50cVNT/ohDRbvIv5rhlp3yhUMBjP8SiK5Nsb7g79YzglWsMQP1IaKiSnFsvb
TH1jIX93CRg0PmmzOAfCgMXp+NTLSh9luS5HOcokMqCwwwXsnYPwiZSoK0fhUbsXCD72IzixrvIc
pS8mOJkK3DAoWSPnqjmz3ARg+KVqhUEs8tXJUaooDyxXYp46sDp3K/QniCn/G5e/oeo0AJHD3Lwg
ivppypBFEYpCeA+hHxbMYVt5wErWhRbAMAMydMl85azyrv+ST1fJnQe+0Rl2uFoIbtV1+D9hdJ3q
v1SKZn22rXD4YMR728P38/k05q9bD/lsnaOjMd/rYU466RVciEzngN1wma20TdlUq8UZBJVfVg5D
fwPuEIoEsXJKofDwpqVgbMj93eDAAs7OuckG2jAe6KkCJopBgMnAPZkiS3s5G+QYgtWmO6Ycy8T6
Gdyw15L34WRsbM7MDgE+DkiSrp8FlK3azvYdjuRiH5BHfOMrdiQNjDCCmGbrYbqUWG0IlZRGX8Qx
rQXEQpPInhgqk2A+RdIL8cfgsz6ABJIp9CwNlhARHA1rkwWKI4bCS2lKZo1IVnMx8ZO5LR0ttqub
vgkjXO0do2hg7s1Vq3eWvL9oRoJVe7ixYs13Sz1iJ7wwDwERQz7vaizGFXMGMN16IddYdx7sERKC
tqTIOyqCK6j1OEm6JAtfGp8SMQBGC35y11/uu1omB+OBNNfWuauwNvjThP/z/8uayZFac3q83hjj
opnZAC/V7SDGrqLxJ+HOJ3otnjrCG9C/+khXeruPkxSvCWlp6qfkXh9Et/D5Fy0jC+Spe4Wx1Sw2
bmWku1OCBm2DPO6gGQZ74mI6DZ3XGCLo/43gQJnMPN0vajTlw9zFylI6/nh2Hi8R14qJrVnrOSL1
62/8idmd+FgK/onSrxa43G1Co7ieMUq8rpEiNYbtsHwEyg7muMAs2IIqapXr8rVhnTyToGIwUmTg
sRD5AApJE+y2V/9Dymu9EWZ4hlO3g28tNDXmWFNJdwch60QlmOJtpWkSen8TcGq4R+kGIsxKz5/0
d868xuKzDT8zxf+1JXWotOMBZk+WSO2CCf8n60hNb0j/gnluE3C5m+BVvxGl4xm+Uzx+vZSPw725
PJL8sLGetFYu0+BAePiBsViKJg6BwAMFoPceyluVEFCB3fVYPSoknya2WEYHbKBB/aIfHTQD+Qe5
/0B8XzIdGau5YdfVAintPODiilGNaHTsV0n0lgRZFdvfy3KtBTzFwkbxA/XbenrCY5mOdo75m1zt
2mXNB9DJY+CDjSih/dbJdujcXgqb0+Xsek7dK2lKalWR2Ahclcaintq20Pz8fkgb4hEJup3hkjOb
B7UeSkI7+5C6Op03QERVcru9EEY95/nfwwumpvTQwkQpGplQeFiwuo/9wFlBZnryhnNbOWIcZvp0
FlgY/DcYT6iCfiDDJj+rHiqEPgQJdkcAXeRV4hRSQ3IvW/4l/ZaLzKLqsu56dWU0dGDJmLwKiDcK
AROTjxBFiF0l2YHZELjB7wMbTwifDbYGAeSWqEAd+PTB7Il0+zMR28cJtlfcYgDL9R69OzQJMZJF
+z50yXKhAInNPHs9XcapVXxFB4dyJHLYrURhwta6g9mCL0JH5Tnkbt5mFnnxnS71hkNlfHATbYw8
w8VZwNnW1F2eRBWUdzfxnU8oB4DCtv0wA82awg6LXETRICFiHLzllJGoBOt8zp50AeqJQ3A0Ky0B
UW/O/saMdhP1r7Oa0YX7Ja7Ju5MLLMirh0/4oZU+y4zmovSAYWcs4x5nlJHrlnI0XkgO7rC04JOZ
ZUyH4ZGDZX6yqJkNxmZ1mXqfcgu52TffPV0D+Ih1LoMHHpULgxuBU7zeNO1ckUh2K6wo6F+7OPqh
aX77FUzbh/M+9OgsO78icnRNeTXaRvhAeuXb3+SVxOoaDOu3i54X3DJ96nOO5yPJdxbXRBhNh2HF
z7/p/soOIN412sWdIK4sFgsbLEwDPYiZE8wGfQZ9eoeIrlzq3t9y3UM8ANETG/Ah/v6iewXCVAUl
rf7ltpPGHGPM6dQEpHSXo5Uz6EzeGA2JQHXRTeZfJnXz5yKfnZJU/Nwm5ufkCd3P4Cyclh+zbMjq
9PxH1mCoBABLy+WfCyqfkEOCTyCBa8I1yWhtbTlE0zJzwq0VMGdE9l1qY3jwC2AmGau+W1k6a6+s
97aGQT2QJSGyOwKvXdBTv9BuQSQqDybljU5klVJUc9xV6y8lniP3YkqRMjhMf4KZOxrOhd1CytH1
Io6HLfoGGoRwTL7fynzqDsr6w3pVhGpwJr5dhnKLqSQItCV8HD9OcJu6VgFuRwMlSAZSYyU3fwzd
YS6dj6PuyKne/W1OqhRZhYR05vrERkayxB49jZBXKKgxBvM/jVYhaKuLP1yfYxrJn1Ayfckyluzg
We4HBKtvgwGzfIpVf8EBMnfSyLqpb6NZ8RZevapafbOyKin0cQVu702zUlgShWvXoovmiHVsD59V
FDrGhC6+TVd+VHhSSs0+v0S1mpzmOYEF2NWPmRNOBU9oiKZJUi7I1Sj5yWoL7gj8NCEDQOmWjSxn
fqQrPk/4uLN6MKnAc5XR9usHLQMpV9L+e+p14smK5TAMVzlQJdckFvS+yp+j5QtOh2ATbE60fWTK
dbR8GsmoSEszL2BruiSSrO6yhVEVSTQFxcLXenWcd338L26KEaq1hrsFM8Y6SebKwoLAPnDY7gsv
4tkS5wOgUbYGz+HgoOcAz9P6fXq5x5Ap7ZFGHhXl5cXREGF5s89lM4zTfcGd9z1eLBtL2L+vFLeO
yLnbkjf3CuafBU6Pj4WQd77e0dmLIRMARGpMYp+fzqLswv8i/ZTGAvVooya7AJrZgfMDftA5wiOU
EeR3Ihgm9P2D2Vf5aiRDg44lTfKjZ5VIuqVPp2wD4t08XQLh5u+j6XADFdoCsv2rcFzNfM6wecAY
V0F2VLcWueQ/430TCzm1TGNLk7HPRD+N/H1X2DFMgH58jO44sAlqKsyuTQBvevSybF3n872YEqWR
nnDjPdDvB+tGKEyLdRQHcdx9FmwkfFr3c2FaMTX9As5wjVTVs8mD5bEtkifAnhjzju+3rZZkMQMx
1KlKuCQK1Wi8Og5rGJPHOloK4i8n/XEtwtVOu9oxJF2esC5qElLE+bzx180UYENclp/vs8lhZooa
UvQOWYL0rWKBP5KTlaECoWiVQzmGPAsvVcSDTTYEPx0+077KYMy7OwSsq3FOZ5MSACPpADN55phj
21ubWlpKgehOoOd9I3oJeGilXuxspKiKDZ3/nXwtOG155F54aH10gvmHSb2D8fK2BhL0Ei2aGCma
q23qgGDJ11B+QdlqrBXnzWoQP0nLc7+Gb7lHJtylgNciMK2B7CVMtGFQEzZts6MiopWonjwiPxE1
j6XZS9fh9MDBeNMmuZdtJOuEbyvkTWTT5e44mrVNeRGm7ESuaZyGaQNKValjXpzxNJX5LGgu0ZKK
Uoc0cus+m1xThQY8yzIeivS1wQCrlqjBDqT3ctSrbDwbBAs4Mx5NoiMgwz9RiztTuHCV8UsvW0t+
cFU53LonNsgAPTQ83XhcZ5R41FjFhph9GT9JopwU6ZGqy6qWwudYGDAVey0/sG/DJAa1uP0kQuCp
b6wPQ6GyvZB7eOhInNPJUS+5DMVlE3ub6Le2q5/W9welbWh3OBah1VdsYjgCq85kgpdlihaPHib+
fuUlxqRETyHSABWVMERlHq9T50sCf/ky4ywWXB8gqqnRqzK5PTn63rEeqWxYUqWY/3bKlAHBANso
LsDdAKedR2jBiJnT6IFGlXWBsy3ynoCr6hN0MAhIhYxthTZXqF1tWfDnK1093CvQXXEoZIBoAd7r
9zpi9zhjUSPX1DDIK9vC6fQGQHebcxXcPBH77si/4KdzpeP8IoO++kzd5yLYJuBI2+MWmXTtTsif
r6myAve/au6JE4xa2FK5ffZexdRVGWQ3inuF1UYUhu1x1SC7L1dLmLYhZkOetBS46MFiBnLkwwoH
AS+R5iE2KTBwSFKBNrvIcfErfQagfFOy1UABMkWz/Y6RTF0E2f+CX3xTeTQ2gb3AqpvO87aY68rN
Z7S/h7X8jjWZRGDNdmfy5UgV02186pZDqLIHSRQOo1a+Kcmd3RVVf/KRcEs2d93HJqLTMHuh8fuJ
jcQ1aXVQOMZO/ePEAxkKo/sldII2d8vVuET87RdbyAcDTFSldYCQ95GB5Hoge2tKxa1rLx2uTgps
mTjiyQmQ7g4EvSbNdiml+a1QFLYytT+xyEYLgQlTjLQzlGFdsYQJgaoxLtl9svHV39UXzwQ29bYH
Bh+jJ/WAnDxzy4RgmAAZE0yuY6QcDYpQ0iwxCuBfAYF1BmUWC1SduB7u4w5HxrCfZNoKu6LK8yxn
kUlHP0vDCK9ZlDabIcZakMXMGxvZ5L3582JvK6dqEjjtAYFDCWepc9JTvNhYeky10b4Id67d72PK
ZfZjP2I7Z9VCBi5GZG4IIb9Pj5pzb5Gf5hlDvws92s7m4H/66zS9wkHnqcXCDny8BRTpD1HjufUk
j+1QLZl7ECnDkaHKodubADTI/YWoUwsHDffVRMXB3uP2z2NBNmhrFHCIqGeVONgVJ2ZpxA0f1zVt
n/iRWjF5j7LdG/gPMdervgazIjpmLt71DOhiYnmd875ICFjkDSVtEIihiFkIc+wrof4VW/dMY71Z
QxtTXGaAeXxEXBEm+Bb8wjuxpgdJ4bGCzbNtfOA8xHjieCi5H0B1Fx8Yq2I+pkRILZx8p/tU+ASv
ZvDFFbgoKh8Om7i2lhQquluI1JqbNwRnJeG+R65F1LttC/VRQn9+JHFHJX41cNZZVFrS6Ibofu0K
0lufhm54usn7tMv7LsEIxCu2Ul7yGNVAyviTkQ8iO2Mx+ZycDJOYmRXKpqrmfKhf5F5yqbTVSomk
V10o0tRMv8LGvVFbiY/5e1Qb60J4IjYQNfN9DgKSZlBgPkXaicq51T6Gu8zHWFbsUB8zH9XEQYir
cp7Yf6mFC90FgJyzSkcKAeZcoUS5TwN62ISzqHR+oLm2sqLZhu7WNMTN+hg75hhL9Oa75zfDQROC
xaEDsXVErzqv+KyLzue4pBHWpLtpuYaxDEhczVY83LMzGXweCZqgnfFbYiEo9s8BfhidUyMi9GQ6
hSFgc8pCDSfn3UB2lVjp60rala7PdfswAS8AK1GwVZlOueaXcKyeviIFeHPg9oAC5ATLP3dtjhxg
ZMJW2E0eHFex5W5YciBAwAmGVBEww3MRpciRTePeYy1ofiUcKjJi7w36hbtu8FevQuBI40O/U7Ta
XPXPHJICL7Z6FUuo6E55f456zzTR2x+0lSnQ8CrB1g45tD9/yVWCUIozEw24GyqXEGYUgKqpQOrO
iLLQwcgSZ/ykJ4RXWUNb4hfLgB+68moFnOTWUTuxAzKXoXf5G3AuueE/e6KQa86OCiloX6ooZKJI
lXczD9AeH98eI5vDIl4/9wv31CFLfBV/Fw9YHUCYCbWhrfAWtwPYnVHeg2cukyJc9jSkZLDOg22F
8gNW7cuuPDoxl09fwvTc8cjszP0vRhpzKxY86RD35jivptKwJkUNIsAYXG37Kk4ZzPMEIE2F1Yyl
IKnp5PIdc91sprxlOUMQyQKlljFzr+JcwYiBgCVEWEfSfwK/jaOXPOKrWXoDWuJwIlAll5u5/KiI
xMhFx3bUQK/VwD4AFnf8hBGbIR4AJdPimt2veCsqE93kSj1og/UvtdxtzaXYbGcp8Qr212yqhP5f
h5FZQFAo/j4ozzp4CSLT7QMUQauPhMZlPKAxzCgs70ws9NjihGQRPhItmOpE2c4hRHjIdm/ZZg5x
QBiqr4/O/qgXlR7/ZIU/TNxsT+CiWbVlMvrZuDbMu+OpfvjOeDLLZUzejjerCJ219+yovCgcesIt
2/vsFzVeZ5IofabLUK+RpufjId4hRGADneqxVMAnaYhlkBf63q48dHbJaarhSZu2ZwN7XeervIVH
BDUGd98SURoOKnLJRVHxakQK+jDOo3bfR7+NUTUadh0C27tB0W9DvXC6P1aewoyDNFf1StMn+kIG
A7KBJ3wqaX+6L+xdoW8leLFbHzt9QAT9otUff3GdO+Nb/dbBMeGEzPETG7WNw3CIA/gxEv4FA2/p
a5mYymOYdFYoNmAbAT4By07pIEfITGP7kA+zq0U1oj+211p7uzzj4TEvnGYD3CeCqMpxl+Q1BgZ6
aieewmE3+qvfy0YOUYPH4a+pJWMkVZHQ6ZmAQf+MYRYlYS2lbu772asuExlOFwRU45E68TMJkVlB
Bhn96Grlbz+iDL5sIc15HULqNz1X04e4DcDWEDj1wWUxlr7ChCDYXA0nDuo4mbsDcvpY3+FbCQ8f
cwryZDWAHsyfZ7gsUnTPeXzXV1i55hcnKn7vXSL7fd/IM4jlDRgl/ThFYWJSP1zkQnjmhN7U69z2
/vhwbLDlAO0kikdojm2OoSdP9nA6xF7l8OdXxlZWRmMFcGWjDWMWP8kCM35MaejXAuQgoQVdZpje
wlafP8MJ8adn7JYJgMToNSOAq6efnSWamEBG1pI0JomTNicgYlKEuThI6sGgT4ap7To/8Gg36bx8
Pk6dKbgk9aJAk/6P0ULOrrkxhqGo39Vl+pQ2JmpOhLI14iZ1ohx2hVCexTd+O11uUzXqRz0QhXdC
stKljfiHTljbDh3uxFdiHXva5Zux2ALjJ2khe8VZ61H+2TqrR0lA3XLdYzxF5v7rl+eaANiiRh7D
StH0z12oM3Bkny9Qqgr39daFzB0sZr1AFgxRuz82OsFEAPx6h6ilR8Evv0qQCBcSehV3rE5xnekD
VDs+4rTS71wWMJtTve2J30Go6UmeLoMFDvGykcfpQ9S35WCd3hWpcPV2zLx4US4cGvbzNA+V75eo
Y8VizYBiNtal/xeMo9AimkElA6ug9xS7h48eL94LrohYwyOIZKMeBplmk4nE6uohAgLLDqCO+yMY
MyistfA4Dxw8AZlWNlCdxgu8esar/7TDMQEtiEluzK450xvNVoTUwZomG0QuiYR3Hk5+ALB72OeE
5FIk8KHqJQdMgoMWnhQZw6l7+jbsoLQx2lPL638L0tDY6gbCwjoY2wFGv8vUe7tEJjw6EOjxz+qS
R/1hcY8GEBAD40NPrSD4W2zh722MDqMKnJNNSFidiQNi+s2KLzBRll81a9JkCcXR2hDAVbvTkdk+
eg5CGSjMr64p3xtLAHAm2DvWcz8BTLJi7Tozn6vtR7/l9s8SOXXx+yxTT7XHip27xfAxHxod/uXN
3wGBz1n952ia432M/Q7n1cqA6j3D695SgGxwyZxYsqt+Y6sB20J9jQdw+2bgp687t5m5Nt7c7/cp
XMH3k5gP41f6TAysNMwUy5PlmN+PQ44eSWG4f5Dt3InvVYbAlwawz7tO79YoFFrjNviKx6Ayf1UF
irtwzsSeQIYl2uPJUCYFjjTxQr3eZFOQ8HQ43STxqmpSjmwFooLzFt5CLPoXC+La6pnwnv7KXAJI
fPMEWFtnNBUFa1i1JDeNyWLvpMOVYsHY48LZoc7sigX4VEm3HvH9zeDd0QQMuJHxnSe560DOXXu5
Mo4o1jUxybdJrBRpUYdyTGrYOU43Yn0hoE8RpRyJYGa7Lkzns63rgRIyySqN1vSxaNUHlvK3cg3b
JD0x5WwLIcPdHiLLQq0C0Cv6txkGESWKi8ymVl2VdG+cub2XIxJsjkug2gwwrKxpxYloQkzdMOU3
3WIiyjkp7TF46XikQu6cN/QxamsJxDnIAhJUa1cl57TF7cqgMu3zyevkVur9B81iPajqtNKCY1H7
e6+O+rNMXPU5z1ecaJCB09X92hp0rJPerlWGLkjrbT4DcR7CsoM9kYDv4YYE9q4mePItYOsHLnQ6
rx4x3SKFEcEq0v7nUOjcbYMPGLRlamtrrT9Z7tsPMeMrzkdA0pi1a+9WOFnV1KN2BcnCD5t+uSaT
mqDMFn30UrMnabJgDw/fUuYR/Dp629X2p8rvCXH9OVBfeia+glRQpSQWJPgDOeu8yhe1Nw==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
