bpb:
  .oem:               db    "MARVELOS"
  .sect_size:         dw    512
  .sects_per_cluster: db    0
  .reserved_sects:    dw    0
  .fat_count:         db    0
  .root_dir_entries:  dw    0
  .sect_count:        dw    0
  .media_type:        db    0
  .sects_per_fat:     dw    0
  .sects_per_tract:   dw    18
  .heads_count:       dw    2
  .hidden_sects:      dd    0
  .large_sect_count:  dd    0
  .drive_num:         db    0
  .reserved:          db    0
  .signature:         db    0
  .volume_id:         dd    0
  .volume_label:      db    "MARVEL   OS"
  .fs_type:           db    "FAT16   "
