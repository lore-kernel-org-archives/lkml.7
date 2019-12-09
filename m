Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1424207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLIK4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:56:23 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53460 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:56:21 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id bmwD2100e5USYZQ01mwD8w; Mon, 09 Dec 2019 11:56:14 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ieGi5-0004h8-Pf
        for linux-kernel@vger.kernel.org; Mon, 09 Dec 2019 11:56:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ieGi5-0000fG-OS
        for linux-kernel@vger.kernel.org; Mon, 09 Dec 2019 11:56:13 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.5-rc1
Date:   Mon,  9 Dec 2019 11:56:13 +0100
Message-Id: <20191209105613.2491-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.5-rc1[1] compared to v5.4[2].

Summarized:
  - build errors: +2/-8
  - build warnings: +84/-87

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e42617b825f8073569da76dc4510bfa019b1c35a/ (all 232 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/219d54332a09e8d8741c1e1982f5eae56099de85/ (all 232 configs)


*** ERRORS ***

2 error regressions:
  + error: "clk_set_min_rate" [drivers/devfreq/tegra30-devfreq.ko] undefined!:  => N/A
  + error: tegra30-devfreq.c: undefined reference to `clk_set_min_rate':  => .text+0xcc8)

8 error improvements:
  - /kisskb/src/drivers/staging/octeon/ethernet-defines.h: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function): 30:38 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-defines.h: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function); did you mean 'CONFIG_MDIO_OCTEON_MODULE'?: 30:38 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function): 190:6 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'OCTEON_IRQ_WORKQ0' undeclared (first use in this function): 472:25 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'OCTEON_IRQ_WORKQ0' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?: 472:25 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-spi.c: error: 'OCTEON_IRQ_RML' undeclared (first use in this function): 224:12, 198:19 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-spi.c: error: 'OCTEON_IRQ_RML' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?: 224:12, 198:19 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-tx.c: error: 'OCTEON_IRQ_TIMER1' undeclared (first use in this function): 705:18, 716:11 => 


*** WARNINGS ***

84 warning regressions:
  + /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined [enabled by default]:  => 261:0
  + /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined [enabled by default]:  => 262:0
  + /kisskb/src/arch/s390/kernel/perf_cpum_cf_diag.c: warning: 'cf_diag_push_sample' uses dynamic stack allocation [enabled by default]:  => 519:1
  + /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation [enabled by default]:  => 1134:1
  + /kisskb/src/arch/s390/kernel/unwind_bc.c: warning: 'ip' may be used uninitialized in this function [-Wuninitialized]:  => 157:5, 161:12
  + /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 149:1
  + /kisskb/src/drivers/block/null_blk_main.c: warning: 'new_value' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 291:12, 307:48
  + /kisskb/src/drivers/block/null_blk_main.c: warning: 'new_value' may be used uninitialized in this function [-Wuninitialized]:  => 311:1, 310:1, 326:1, 324:1
  + /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint1.type') [-Wmissing-braces]:  => 719:9
  + /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint2.type') [-Wmissing-braces]:  => 720:9
  + /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint_desc.type') [-Wmissing-braces]:  => 718:9
  + /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: missing braces around initializer [-Wmissing-braces]:  => 720:9, 719:9, 718:9
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.28' uses dynamic stack allocation [enabled by default]:  => 403:1
  + /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 477:1
  + /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: the frame size of 1068 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 477:1
  + /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 477:1
  + /kisskb/src/drivers/gpio/gpio-aspeed-sgpio.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 112:1
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/bus/hwsq.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]:  => 162:16
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]:  => 154:40
  + /kisskb/src/drivers/gpu/drm/tegra/dpaux.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]:  => 787:6, 751:6
  + /kisskb/src/drivers/leds/leds-el15203000.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 246:8
  + /kisskb/src/drivers/mfd/htc-pasic3.c: warning: unused variable 'asic' [-Wunused-variable]:  => 186:22
  + /kisskb/src/drivers/net/arcnet/arc-rimi.c: warning: unused variable 'lp' [-Wunused-variable]:  => 346:23
  + /kisskb/src/drivers/net/can/cc770/cc770_platform.c: warning: unused variable 'priv' [-Wunused-variable]:  => 236:21
  + /kisskb/src/drivers/net/ethernet/8390/ax88796.c: warning: unused variable 'ei_local' [-Wunused-variable]:  => 808:20
  + /kisskb/src/drivers/net/ethernet/freescale/fsl_pq_mdio.c: warning: unused variable 'priv' [-Wunused-variable]:  => 518:27
  + /kisskb/src/drivers/net/ethernet/marvell/mv643xx_eth.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 2971:20
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: warning: overflow in implicit constant conversion [-Woverflow]:  => 577:41
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 302:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/wq.c: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' [-Wformat]:  => 92:2
  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation [enabled by default]:  => 1089:1
  + /kisskb/src/drivers/net/ethernet/pensando/ionic/ionic_main.c: warning: 'hb' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 331:6
  + /kisskb/src/drivers/net/ethernet/smsc/smc911x.c: warning: unused variable 'lp' [-Wunused-variable]:  => 2117:24
  + /kisskb/src/drivers/net/ethernet/smsc/smc91c92_cs.c: warning: unused variable 'smc' [-Wunused-variable]:  => 958:23
  + /kisskb/src/drivers/staging/comedi/drivers/pcl816.c: warning: 'last_chan' may be used uninitialized in this function [-Wuninitialized]:  => 148:6
  + /kisskb/src/drivers/staging/comedi/drivers/pcl818.c: warning: 'last_chan' may be used uninitialized in this function [-Wuninitialized]:  => 337:6
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.35' uses dynamic stack allocation [enabled by default]:  => 498:1
  + /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation [enabled by default]:  => 2875:1
  + /kisskb/src/drivers/thermal/broadcom/ns-thermal.c: warning: unused variable 'ns_thermal' [-Wunused-variable]:  => 78:21
  + /kisskb/src/fs/btrfs/tree-checker.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]:  => 230:43, 230:5
  + /kisskb/src/fs/btrfs/tree-checker.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat]:  => 232:5
  + /kisskb/src/fs/ext4/extents.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 5054:23
  + /kisskb/src/fs/proc/inode.c: warning: 'pdeo' may be used uninitialized in this function [-Wuninitialized]:  => 374:12
  + /kisskb/src/fs/ubifs/orphan.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' [-Wformat]:  => 132:3, 140:3
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wuninitialized]:  => 225:15
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_is' may be used uninitialized in this function [-Wuninitialized]:  => 225:15
  + /kisskb/src/include/asm-generic/memory_model.h: warning: passing argument 1 of 'soft_offline_page' makes integer from pointer without a cast [-Wint-conversion]:  => 33:37
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]:  => 26:7
  + /kisskb/src/kernel/bpf/btf.c: warning: 't' may be used uninitialized in this function [-Wuninitialized]:  => 3910:20
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.22' uses dynamic stack allocation [enabled by default]:  => 2748:1
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation [enabled by default]:  => 1492:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'bucket_find_contain' uses dynamic stack allocation [enabled by default]:  => 367:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation [enabled by default]:  => 1490:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_mapping_error' uses dynamic stack allocation [enabled by default]:  => 1321:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation [enabled by default]:  => 1604:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation [enabled by default]:  => 1636:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation [enabled by default]:  => 1551:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation [enabled by default]:  => 1571:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation [enabled by default]:  => 1338:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation [enabled by default]:  => 1532:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation [enabled by default]:  => 1428:1
  + /kisskb/src/kernel/sched/cputime.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]:  => 1007:6
  + /kisskb/src/net/netfilter/nf_flow_table_offload.c: warning: large integer implicitly truncated to unsigned type [-Woverflow]:  => 80:21, 80:3
  + /kisskb/src/net/netfilter/nf_flow_table_offload.c: warning: unsigned conversion from 'int' to '__be16' {aka 'short unsigned int'} changes value from '327680' to '0' [-Woverflow]:  => 80:21
  + /kisskb/src/security/integrity/ima/ima_crypto.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 510:1
  + warning: 14 bad relocations:  => N/A
  + warning: 142 bad relocations:  => N/A
  + warning: 2 bad relocations:  => N/A
  + warning: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp:  => N/A
  + warning: unmet direct dependencies detected for GPIO_GENERIC:  => N/A
  + warning: vmlinux.o(.text+0x311e8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x363b8): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x6ca9c): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd():  => N/A
  + warning: vmlinux.o(.text+0xbad4): Section mismatch in reference from the function mmu_mark_initmem_nx() to the function .init.text:mmu_mapin_ram_chunk():  => N/A
  + warning: vmlinux.o(.text+0xbaec): Section mismatch in reference from the function mmu_mark_initmem_nx() to the function .init.text:mmu_mapin_ram_chunk():  => N/A
  + warning: vmlinux.o(.text+0xbb04): Section mismatch in reference from the function mmu_mark_initmem_nx() to the function .init.text:mmu_mapin_ram_chunk():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2d48): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2f50): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3fbc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3fcc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3fe8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x9b4): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A

87 warning improvements:
  - /kisskb/src/arch/mips/include/asm/octeon/cvmx.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 299:23, 282:17 => 
  - /kisskb/src/drivers/char/tpm/tpm2-cmd.c: warning: 'blob_handle' may be used uninitialized in this function [-Wmaybe-uninitialized]: 669:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/renoir_ppt.c: warning: (near initialization for 'metrics.ClockFrequency') [-Wmissing-braces]: 186:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/renoir_ppt.c: warning: missing braces around initializer [-Wmissing-braces]: 186:2 => 
  - /kisskb/src/drivers/md/dm-writecache.c: warning: 'g' may be used uninitialized in this function [-Wuninitialized]: 1613:18 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 302:1 => 
  - /kisskb/src/drivers/usb/host/xhci-debugfs.c: warning: 'f_map' may be used uninitialized in this function [-Wuninitialized]: 246:20, 327:20 => 
  - /kisskb/src/drivers/video/fbdev/sa1100fb.c: warning: 'sa1100fb_min_dma_period' defined but not used [-Wunused-function]: 975:21 => 
  - /kisskb/src/fs/ext4/inode.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 6 has type 'ssize_t {aka int}' [-Wformat=]: 3621:12 => 
  - /kisskb/src/fs/ext4/page-io.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 6 has type 'ssize_t {aka int}' [-Wformat=]: 155:5 => 
  - /kisskb/src/include/linux/via-core.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 192:2, 198:2, 206:2 => 
  - /kisskb/src/kernel/kexec_file.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 1324:19, 1307:19 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 3c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U f00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2640>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3aa0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3e60>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4460>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U51e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U58c0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5a00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U66e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6960>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7640>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7c80>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7f00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U91e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9960>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9b40>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9e60>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua1e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubc80>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud500>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udc80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uddc0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue0a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue6e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue820>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueb40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/sound/soc/soc-pcm.c: warning: unused variable 'name' [-Wunused-variable]: 1149:8 => 
  - warning: "clear_page" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!: N/A => 
  - warning: "copy_page" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!: N/A => 
  - warning: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL: N/A => 
  - warning: 12 bad relocations: N/A => 
  - warning: 140 bad relocations: N/A => 
  - warning: vmlinux.o(.text+0x6ee98): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2d18): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2f20): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3f8c): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3f9c): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3fb8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x984): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
