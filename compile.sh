rm -r ./lib/lib_src ./lib/lib_bench ./lib/lib_bench
vlib ./lib/lib_src
vlib ./lib/lib_bench
vlib ./lib/thirdparty

vcom -work thirdparty ./thirdpartylibrary/CryptPack.vhd
vcom -work lib_src ./src/Sbox.vhd
vcom -work lib_bench ./bench/Sbox_tb.vhd
vcom -work lib_src ./src/SubBytes.vhd
vcom -work lib_bench ./bench/SubBytes_tb.vhd
vcom -work lib_src ./src/ShiftRow.vhd
vcom -work lib_bench ./bench/ShiftRow_tb.vhd
vcom -work lib_src ./src/MixColumn.vhd
vcom -work lib_bench ./bench/MixColumn_tb.vhd
vcom -work lib_src ./src/AddRoundKey.vhd
vcom -work lib_bench ./bench/AddRoundKey_tb.vhd
vcom -work lib_src ./src/RotWord.vhd
vcom -work lib_bench ./bench/RotWord_tb.vhd
vcom -work lib_src ./src/KeyExpansion.vhd
vcom -work lib_bench ./bench/KeyExpansion_tb.vhd
vcom -work lib_src ./src/KeyExpansion_IO.vhd
vcom -work lib_bench ./bench/KeyExpansion_IO_tb.vhd
vcom -work lib_src ./src/FSM_AES.vhd
vcom -work lib_src ./src/AESRound.vhd
vcom -work lib_src ./src/AES.vhd
vcom -work lib_bench ./bench/AES_tb.vhd
vsim AES_tb




