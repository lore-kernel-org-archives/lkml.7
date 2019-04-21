Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F5C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEE72080D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfDURNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:13:09 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:59674 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDURNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:13:09 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 35Cy2000P3XaVaC015Cyo9; Sun, 21 Apr 2019 19:12:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hIG1S-0006HR-DT
        for linux-kernel@vger.kernel.org; Sun, 21 Apr 2019 19:12:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hIG1S-0003JT-CM
        for linux-kernel@vger.kernel.org; Sun, 21 Apr 2019 19:12:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.1-rc4
Date:   Sun, 21 Apr 2019 19:12:58 +0200
Message-Id: <20190421171258.12689-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.1-rc4[1] compared to v5.0[2].

Summarized:
  - build errors: +1/-1
  - build warnings: +117/-109

JFYI, when comparing v5.1-rc4[1] to v5.1-rc3[3], the summaries are:
  - build errors: +1/-0
  - build warnings: +60/-85

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/15ade5d2e7775667cf191cf2f94327a4889f8b9d/ (all 236 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1c163f4c7b3f621efff9b28a47abb36f7378d783/ (all 236 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/79a3aaa7b82e3106be97842dedfd8429248896e6/ (all 236 configs)


*** ERRORS ***

1 error regressions:
  + error: arch/sh/kernel/cpu/sh2/clock-sh7619.o: undefined reference to `followparent_recalc':  => .data+0x70)

1 error improvements:
  - error: ene_ub6250.c: relocation truncated to fit: R_NDS32_9_PCREL_RELA against `.text': (.text+0x348) => 


*** WARNINGS ***

117 warning regressions:
  + /kisskb/src/arch/arm/include/asm/uaccess.h: warning: 'old_fs' may be used uninitialized in this function [-Wuninitialized]:  => 70:36
  + /kisskb/src/arch/arm/mm/init.c: warning: unused variable 'dtcm_end' [-Wunused-variable]:  => 470:13
  + /kisskb/src/arch/arm/mm/init.c: warning: unused variable 'itcm_end' [-Wunused-variable]:  => 471:13
  + /kisskb/src/arch/s390/kernel/perf_cpum_cf_diag.c: warning: 'cf_diag_push_sample' uses dynamic stack allocation [enabled by default]:  => 514:1
  + /kisskb/src/arch/xtensa/mm/mmu.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'long unsigned int' [-Wformat=]:  => 36:9
  + /kisskb/src/drivers/clk/ti/clk.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 578:2
  + /kisskb/src/drivers/clocksource/timer-ti-dm.c: warning: 'omap_dm_timer_set_load_start' defined but not used [-Wunused-function]:  => 589:12
  + /kisskb/src/drivers/gpu/drm/arm/display/komeda/komeda_dev.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 145:5
  + /kisskb/src/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: warning: (near initialization for 'opts.mipi_dphy') [-Wmissing-braces]:  => 620:8
  + /kisskb/src/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: warning: missing braces around initializer [-Wmissing-braces]:  => 620:8
  + /kisskb/src/drivers/i2c/busses/i2c-sh_mobile.c: warning: 'data' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 399:26
  + /kisskb/src/drivers/i2c/busses/i2c-sh_mobile.c: warning: 'data' may be used uninitialized in this function [-Wuninitialized]:  => 399:26
  + /kisskb/src/drivers/iio/adc/ad7606_par.c: warning: unused variable 'st' [-Wunused-variable]:  => 36:23, 21:23
  + /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_latch_mask' may be used uninitialized in this function [-Wuninitialized]:  => 599:29
  + /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_map_mask' may be used uninitialized in this function [-Wuninitialized]:  => 606:29
  + /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_out_ctrl_shift' may be used uninitialized in this function [-Wuninitialized]:  => 577:47
  + /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'pin_name' may be used uninitialized in this function [-Wuninitialized]:  => 618:3
  + /kisskb/src/drivers/mtd/ubi/wl.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 1520:19
  + /kisskb/src/fs/ocfs2/alloc.c: warning: 'first_bit' may be used uninitialized in this function [-Wuninitialized]:  => 7604:17
  + /kisskb/src/init/main.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type '__kernel_size_t {aka unsigned int}' [-Wformat=]:  => 787:37
  + /kisskb/src/init/main.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]:  => 384:35, 388:35, 380:35
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation [enabled by default]:  => 7825:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation [enabled by default]:  => 7736:1
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U10a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U18c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U23c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U40a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5820>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U75a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U86e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U95a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uabe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uac80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubdc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uca00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uda00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uff00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/mm/kmemleak.c: warning: 'scan_large_block' defined but not used [-Wunused-function]:  => 1404:13
  + /kisskb/src/mm/mprotect.c: warning: unused variable 'mm' [-Wunused-variable]:  => 42:20
  + /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 1948:27 => 1124:35, 1965:27, 2111:35, 1109:35, 1131:35, 2105:35, 1137:35, 2099:35, 2117:35
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.50' uses dynamic stack allocation [enabled by default]:  => 2185:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.52' uses dynamic stack allocation [enabled by default]:  => 1892:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.51' uses dynamic stack allocation [enabled by default]:  => 2253:1
  + /kisskb/src/net/core/devlink.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 4304:6
  + /kisskb/src/net/netfilter/nf_nat_masquerade.c: warning: 'masq_refcnt6' defined but not used [-Wunused-variable]:  => 15:21
  + <stdin>: warning: #warning syscall io_uring_enter not implemented [-Wcpp]:  => 1484:2
  + <stdin>: warning: #warning syscall io_uring_register not implemented [-Wcpp]:  => 1487:2
  + <stdin>: warning: #warning syscall io_uring_setup not implemented [-Wcpp]:  => 1481:2
  + <stdin>: warning: #warning syscall pidfd_send_signal not implemented [-Wcpp]:  => 1478:2
  + arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for FS_ENCRYPTION:  => 534
  + arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NET_DEVLINK:  => 333
  + arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for FS_ENCRYPTION:  => 423
  + arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NET_DEVLINK:  => 306
  + warning: "copy_page" [fs/nfs/nfs.ko] has no CRC!:  => N/A
  + warning: vmlinux.o(.text+0x2b3c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x2d28): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x2d5c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x2fac): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3074): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3084): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3228): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x325c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3334): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3368): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x339a8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x35a4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x37be4): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x3834): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3868): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3d8f90): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3d95f8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x3e0790): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3e0df8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x457cd0): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x458338): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2e18): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2e84): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2f90): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x30a8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A

109 warning improvements:
  - /kisskb/src/arch/m68k/atari/config.c: warning: variable length array 'switches' is used [-Wvla]: 151:2 => 
  - /kisskb/src/arch/m68k/kernel/signal.c: warning: variable length array 'buf' is used [-Wvla]: 654:3 => 
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]: 182:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c: warning: (near initialization for 'task_info.process_name') [-Wmissing-braces]: 1474:10 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c: warning: missing braces around initializer [-Wmissing-braces]: 1474:10 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c: warning: (near initialization for 'task_info.process_name') [-Wmissing-braces]: 323:10 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c: warning: missing braces around initializer [-Wmissing-braces]: 323:10 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 217:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1232 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 217:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1248 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 217:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1528 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 217:1 => 
  - /kisskb/src/drivers/staging/iio/adc/ad7606_par.c: warning: unused variable 'st' [-Wunused-variable]: 37:23, 22:23 => 
  - /kisskb/src/kernel/bpf/verifier.c: warning: 'prev_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]: 5068:4 => 
  - /kisskb/src/kernel/cgroup/cgroup-v1.c: warning: 'root' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1263:3 => 
  - /kisskb/src/kernel/cgroup/cgroup-v1.c: warning: 'root' may be used uninitialized in this function [-Wuninitialized]: 1263:20 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 280>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 320>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 500>]' may be used uninitialized in this function [-Wuninitialized]: 152:32, 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 6e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 8c0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U21e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2500>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2780>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U31e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3be0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U51e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32, 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7aa0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8820>]' may be used uninitialized in this function [-Wuninitialized]: 133:34, 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U88c0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U90a0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9500>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9aa0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9e60>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua140>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaaa0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub1e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub320>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub960>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ube60>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc3c0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucc80>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucdc0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud1e0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud5a0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud780>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue460>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue500>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uea00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueaa0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uebe0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uec80>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uef00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34, 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_ip_fixup' uses dynamic stack allocation [enabled by default]: 249:1 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation [enabled by default]: 301:1 => 
  - /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation [enabled by default]: 307:1 => 
  - /kisskb/src/kernel/trace/trace_dynevent.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 89:5 => 
  - /kisskb/src/lib/test_ubsan.c: warning: 'test_ubsan_out_of_bounds' uses dynamic stack allocation [enabled by default]: 67:1 => 
  - /kisskb/src/lib/test_ubsan.c: warning: 'test_ubsan_vla_bound_not_positive' uses dynamic stack allocation [enabled by default]: 51:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.51' uses dynamic stack allocation [enabled by default]: 2186:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.53' uses dynamic stack allocation [enabled by default]: 1893:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.52' uses dynamic stack allocation [enabled by default]: 2254:1 => 
  - /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation [enabled by default]: 232:1 => 
  - /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation [enabled by default]: 1908:1 => 
  - /kisskb/src/net/mac80211/mesh_pathtbl.c: warning: 'new_mpath' may be used uninitialized in this function [-Wuninitialized]: 406:28 => 
  - /kisskb/src/net/sunrpc/stats.c: warning: 'rpc_clnt_show_stats' uses dynamic stack allocation [enabled by default]: 268:1 => 
  - <stdin>: warning: #warning syscall io_pgetevents not implemented [-Wcpp]: 1333:2 => 
  - <stdin>: warning: #warning syscall perf_event_open not implemented [-Wcpp]: 1186:2 => 
  - <stdin>: warning: #warning syscall pkey_alloc not implemented [-Wcpp]: 1321:2 => 
  - <stdin>: warning: #warning syscall pkey_free not implemented [-Wcpp]: 1324:2 => 
  - <stdin>: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]: 1318:2 => 
  - <stdin>: warning: #warning syscall rseq not implemented [-Wcpp]: 1336:2 => 
  - <stdin>: warning: #warning syscall seccomp not implemented [-Wcpp]: 1240:2 => 
  - <stdin>: warning: #warning syscall statx not implemented [-Wcpp]: 1327:2 => 
  - modpost: WARNING: modpost: Found 2 section mismatch(es).: N/A => 
  - modpost: WARNING: modpost: Found 3 section mismatch(es).: N/A => 
  - warning: "clear_page" [fs/exofs/exofs.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/exofs/libore.ko] has no CRC!: N/A => 
  - warning: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS: N/A => 
  - warning: vmlinux.o(.text+0x32fb0): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x35d4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x37b14): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3844): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3878): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3cd510): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3cdb78): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3d4c10): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3d5278): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x44b570): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x44bbd8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2dd8): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2e44): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2f50): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3068): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
