global bpb
global bpb.oem
global bpb.sects_per_track
global bpb.heads_count

bpb:
  .oem:               db    "MARVELOS"
  .sect_size:         dw    512
  .sects_per_cluster: db    2
  .reserved_sects:    dw    1
  .fat_count:         db    2
  .root_dir_entries:  dw    512
  .sect_count:        dw    20480
  .media_type:        db    0xf0
  .sects_per_fat:     dw    40
  .sects_per_track:   dw    32
  .heads_count:       dw    16
  .hidden_sects:      dd    0
  .large_sect_count:  dd    0
  .drive_num:         db    0
  .reserved:          db    0
  .signature:         db    0x29
  .volume_id:         dd    0
  .volume_label:      db    "MARVEL   OS"
  .fs_type:           db    "FAT16   "
