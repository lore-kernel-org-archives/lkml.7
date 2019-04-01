Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD43C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3CB2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfDAI6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:58:35 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:38528 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfDAI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:58:30 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id uwyK1z00l3XaVaC01wyKof; Mon, 01 Apr 2019 10:58:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hAsln-0002xt-OA
        for linux-kernel@vger.kernel.org; Mon, 01 Apr 2019 10:58:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hAsln-0003Xi-MA
        for linux-kernel@vger.kernel.org; Mon, 01 Apr 2019 10:58:19 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.1-rc3
Date:   Mon,  1 Apr 2019 10:58:19 +0200
Message-Id: <20190401085819.13576-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.1-rc3[1] compared to v5.0[2].

Summarized:
  - build errors: +0/-1
  - build warnings: +137/-104

JFYI, when comparing v5.1-rc3[1] to v5.1-rc2[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +56/-67

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/79a3aaa7b82e3106be97842dedfd8429248896e6/ (all 236 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1c163f4c7b3f621efff9b28a47abb36f7378d783/ (all 236 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8c2ffd9174779014c3fe1f96d9dc3641d9175f00/ (all 236 configs)


*** ERRORS ***

1 error improvements:
  - error: ene_ub6250.c: relocation truncated to fit: R_NDS32_9_PCREL_RELA against `.text': (.text+0x348) => 


*** WARNINGS ***

137 warning regressions:
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
  + /kisskb/src/drivers/iio/adc/ad7606_par.c: warning: unused variable 'st' [-Wunused-variable]:  => 21:23, 36:23
  + /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_latch_mask' may be used uninitialized in this function [-Wuninitialized]:  => 599:29
  + /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_map_mask' may be used uninitialized in this function [-Wuninitialized]:  => 606:29
  + /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_out_ctrl_shift' may be used uninitialized in this function [-Wuninitialized]:  => 577:47
  + /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'pin_name' may be used uninitialized in this function [-Wuninitialized]:  => 618:3
  + /kisskb/src/drivers/mtd/ubi/wl.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 1520:19
  + /kisskb/src/fs/ocfs2/alloc.c: warning: 'first_bit' may be used uninitialized in this function [-Wuninitialized]:  => 7604:17
  + /kisskb/src/init/main.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type '__kernel_size_t {aka unsigned int}' [-Wformat=]:  => 787:37
  + /kisskb/src/init/main.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]:  => 380:35, 384:35, 388:35
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation [enabled by default]:  => 7825:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation [enabled by default]:  => 7736:1
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U10a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4640>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U46e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U65a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32, 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua820>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua960>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaa00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uba00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uddc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ued20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]:  => 260:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation [enabled by default]:  => 259:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation [enabled by default]:  => 266:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation [enabled by default]:  => 263:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation [enabled by default]:  => 262:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation [enabled by default]:  => 257:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation [enabled by default]:  => 256:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation [enabled by default]:  => 254:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]:  => 260:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation [enabled by default]:  => 259:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation [enabled by default]:  => 266:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation [enabled by default]:  => 263:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation [enabled by default]:  => 262:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation [enabled by default]:  => 257:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation [enabled by default]:  => 256:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation [enabled by default]:  => 254:1
  + /kisskb/src/mm/mprotect.c: warning: unused variable 'mm' [-Wunused-variable]:  => 42:20
  + /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 1948:27 => 1137:35, 1109:35, 2117:35, 1124:35, 2111:35, 1965:27, 2105:35, 2099:35, 1131:35
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
  + warning: vmlinux.o(.text+0x3d8ef0): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3d9558): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x3e06f0): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3e0d58): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x457c30): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x458298): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2e18): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2e84): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2f90): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x30a8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A

104 warning improvements:
  - /kisskb/src/arch/m68k/atari/config.c: warning: variable length array 'switches' is used [-Wvla]: 151:2 => 
  - /kisskb/src/arch/m68k/kernel/signal.c: warning: variable length array 'buf' is used [-Wvla]: 654:3 => 
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
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 500>]' may be used uninitialized in this function [-Wuninitialized]: 152:32, 133:34 => 121:34
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1500>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U16e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2780>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U31e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3b40>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3be0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U51e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32, 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7aa0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8820>]' may be used uninitialized in this function [-Wuninitialized]: 152:32, 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U88c0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U90a0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9460>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
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
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucbe0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucc80>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucdc0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud1e0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud5a0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue460>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uea00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueaa0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uebe0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uef00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34, 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/trace/trace_dynevent.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 89:5 => 
  - /kisskb/src/lib/test_ubsan.c: warning: 'test_ubsan_out_of_bounds' uses dynamic stack allocation [enabled by default]: 67:1 => 
  - /kisskb/src/lib/test_ubsan.c: warning: 'test_ubsan_vla_bound_not_positive' uses dynamic stack allocation [enabled by default]: 51:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.51' uses dynamic stack allocation [enabled by default]: 2186:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.53' uses dynamic stack allocation [enabled by default]: 1893:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.52' uses dynamic stack allocation [enabled by default]: 2254:1 => 
  - /kisskb/src/net/mac80211/mesh_pathtbl.c: warning: 'new_mpath' may be used uninitialized in this function [-Wuninitialized]: 406:28 => 
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
