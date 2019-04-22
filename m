Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09695C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B97206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfDVGeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:34:20 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:56906 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:34:19 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 3Ja82000B3XaVaC01Ja84M; Mon, 22 Apr 2019 08:34:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hISWm-0008Cr-56
        for linux-kernel@vger.kernel.org; Mon, 22 Apr 2019 08:34:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hISWm-0007eJ-30
        for linux-kernel@vger.kernel.org; Mon, 22 Apr 2019 08:34:08 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.1-rc6
Date:   Mon, 22 Apr 2019 08:34:08 +0200
Message-Id: <20190422063408.29138-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.1-rc6[1] compared to v5.0[2].

Summarized:
  - build errors: +1/-1
  - build warnings: +138/-108

JFYI, when comparing v5.1-rc6[1] to v5.1-rc5[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +62/-63

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/085b7755808aa11f78ab9377257e1dad2e6fa4bb/ (all 236 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1c163f4c7b3f621efff9b28a47abb36f7378d783/ (all 236 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/dc4060a5dc2557e6b5aa813bf5b73677299d62d2/ (all 236 configs)


*** ERRORS ***

1 error regressions:
  + error: arch/sh/kernel/cpu/sh2/clock-sh7619.o: undefined reference to `followparent_recalc':  => .data+0x70)

1 error improvements:
  - error: ene_ub6250.c: relocation truncated to fit: R_NDS32_9_PCREL_RELA against `.text': (.text+0x348) => 


*** WARNINGS ***

138 warning regressions:
  + /kisskb/src/arch/arm/include/asm/uaccess.h: warning: 'old_fs' may be used uninitialized in this function [-Wuninitialized]:  => 70:36
  + /kisskb/src/arch/arm/mm/init.c: warning: unused variable 'dtcm_end' [-Wunused-variable]:  => 470:13
  + /kisskb/src/arch/arm/mm/init.c: warning: unused variable 'itcm_end' [-Wunused-variable]:  => 471:13
  + /kisskb/src/arch/s390/kernel/perf_cpum_cf_diag.c: warning: 'cf_diag_push_sample' uses dynamic stack allocation [enabled by default]:  => 514:1
  + /kisskb/src/drivers/clk/ti/clk.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 578:2
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
  + /kisskb/src/init/main.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]:  => 384:35, 388:35, 380:35
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation [enabled by default]:  => 7858:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation [enabled by default]:  => 7769:1
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U25a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3960>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U40a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5460>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U55a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U56e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U60a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6820>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7640>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U83c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U91e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaa00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud960>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uda00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
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
  + /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 1948:27 => 2111:35, 1137:35, 2117:35, 1109:35, 2105:35, 1131:35, 2099:35, 1965:27, 1124:35
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
  + warning: vmlinux.o(.text+0x3d9270): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3d98d8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x3e0a50): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3e10b8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x458630): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x458c98): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2e18): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2e84): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2f90): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x30a8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A

108 warning improvements:
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
  - /kisskb/src/drivers/staging/iio/adc/ad7606_par.c: warning: unused variable 'st' [-Wunused-variable]: 22:23, 37:23 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]: 5:18 => 
  - /kisskb/src/kernel/bpf/verifier.c: warning: 'prev_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]: 5068:4 => 
  - /kisskb/src/kernel/cgroup/cgroup-v1.c: warning: 'root' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1263:3 => 
  - /kisskb/src/kernel/cgroup/cgroup-v1.c: warning: 'root' may be used uninitialized in this function [-Wuninitialized]: 1263:20 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 280>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 320>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 500>]' may be used uninitialized in this function [-Wuninitialized]: 133:34, 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 6e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 8c0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 960>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1500>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U16e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U20a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U21e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2780>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U31e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3be0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U51e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34, 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7280>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7aa0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8820>]' may be used uninitialized in this function [-Wuninitialized]: 152:32, 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U88c0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
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
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ube60>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc3c0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucbe0>]' may be used uninitialized in this function [-Wuninitialized]: 133:34 => 
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
