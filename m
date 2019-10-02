Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77338C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C9E218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfJBI6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:58:22 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:42750 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfJBI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:58:19 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id 8Yy92100b05gfCL01Yy9ln; Wed, 02 Oct 2019 10:58:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iFaSX-000682-Cr
        for linux-kernel@vger.kernel.org; Wed, 02 Oct 2019 10:58:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iFaSX-0004H3-BQ
        for linux-kernel@vger.kernel.org; Wed, 02 Oct 2019 10:58:09 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.4-rc1
Date:   Wed,  2 Oct 2019 10:58:09 +0200
Message-Id: <20191002085809.16381-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.4-rc1[1] compared to v5.3[2].

Summarized:
  - build errors: +15/-3
  - build warnings: +215/-117

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c/ (233 out of 242 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4d856f72c10ecb060868ed10ff1b1453943fc6c8/ (all 242 configs)


*** ERRORS ***

15 error regressions:
  + /kisskb/build/tmp/cc1Or5dj.s: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}:  => 663, 1200, 222, 873, 1420
  + /kisskb/build/tmp/cc2uWmof.s: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}:  => 1213, 919, 688, 1434, 226
  + /kisskb/build/tmp/ccc6hBqd.s: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}:  => 513, 1279, 1058, 727
  + /kisskb/build/tmp/cclSQ19p.s: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}:  => 1396, 881, 1175, 671, 226
  + /kisskb/build/tmp/ccu3SlxY.s: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}:  => 1238, 911, 222, 680, 1457
  + /kisskb/src/arch/mips/include/asm/octeon/cvmx-ipd.h: error: 'CVMX_PIP_SFT_RST' undeclared (first use in this function):  => 331:36
  + /kisskb/src/arch/mips/include/asm/octeon/cvmx-ipd.h: error: 'CVMX_PIP_SFT_RST' undeclared (first use in this function); did you mean 'CVMX_CIU_SOFT_RST'?:  => 331:36
  + /kisskb/src/arch/mips/include/asm/octeon/cvmx-ipd.h: error: storage size of 'pip_sft_rst' isn't known:  => 330:27
  + /kisskb/src/drivers/watchdog/cpwd.c: error: 'compat_ptr_ioctl' undeclared here (not in a function):  => 500:19
  + error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!:  => N/A
  + error: "__moddi3" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] undefined!:  => N/A
  + error: "__umoddi3" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] undefined!:  => N/A
  + error: c2p_iplan2.c: undefined reference to `c2p_unsupported':  => .text+0xc4), .text+0x150)
  + error: c2p_planar.c: undefined reference to `c2p_unsupported':  => .text+0xd6), .text+0x1dc)
  + error: page_alloc.c: undefined reference to `node_reclaim_distance':  => .text+0x3180), .text+0x3148)

3 error improvements:
  - /kisskb/src/mm/hmm.c: error: implicit declaration of function 'pud_pfn' [-Werror=implicit-function-declaration]: 753:9, 753:3 => 
  - /kisskb/src/mm/hmm.c: error: implicit declaration of function 'pud_pfn'; did you mean 'pte_pfn'? [-Werror=implicit-function-declaration]: 753:9 => 
  - error: "can_do_mlock" [drivers/infiniband/sw/siw/siw.ko] undefined!: N/A => 


*** WARNINGS ***

215 warning regressions:
  + /kisskb/src/arch/mips/include/asm/octeon/cvmx-ipd.h: warning: unused variable 'pip_sft_rst' [-Wunused-variable]:  => 330:27
  + /kisskb/src/arch/mips/include/asm/octeon/cvmx.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 299:23, 282:17
  + /kisskb/src/drivers/android/binderfs.c: warning: (near initialization for 'device_info.name') [-Wmissing-braces]:  => 657:9
  + /kisskb/src/drivers/android/binderfs.c: warning: missing braces around initializer [-Wmissing-braces]:  => 657:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/renoir_ppt.c: warning: (near initialization for 'metrics.ClockFrequency') [-Wmissing-braces]:  => 186:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/renoir_ppt.c: warning: missing braces around initializer [-Wmissing-braces]:  => 186:2
  + /kisskb/src/drivers/md/dm-writecache.c: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 1613:18
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 300:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1216 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 300:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1408 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 300:1
  + /kisskb/src/drivers/net/phy/mdio-cavium.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 24:2, 39:2, 47:2, 21:16, 54:16, 125:2, 93:16, 86:2, 138:16, 131:2
  + /kisskb/src/drivers/net/phy/mdio-cavium.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 113:48, 114:37
  + /kisskb/src/drivers/net/phy/mdio-octeon.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 48:3
  + /kisskb/src/drivers/net/phy/mdio-octeon.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 91:2, 56:2, 77:2
  + /kisskb/src/drivers/parisc/dino.c: warning: 'pci_dev_is_behind_card_dino' defined but not used [-Wunused-function]:  => 160:12
  + /kisskb/src/drivers/staging/octeon/ethernet-mem.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 123:18
  + /kisskb/src/drivers/staging/octeon/ethernet-tx.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 268:22, 280:22, 276:20, 264:37, 276:5, 264:22, 280:37, 268:37
  + /kisskb/src/drivers/staging/octeon/octeon-stubs.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 1205:9
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.35' uses dynamic stack allocation [enabled by default]:  => 498:1
  + /kisskb/src/drivers/usb/usbip/stub_rx.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 573:5
  + /kisskb/src/drivers/video/fbdev/sa1100fb.c: warning: 'sa1100fb_min_dma_period' defined but not used [-Wunused-function]:  => 975:21
  + /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1180 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 410:1
  + /kisskb/src/fs/splice.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]:  => 1394:8, 1368:8
  + /kisskb/src/include/linux/kernel.h: warning: 'clone_src_i_size' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 37:33
  + /kisskb/src/kernel/kexec_file.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 1307:19, 1324:19
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U41e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U51e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U58c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7820>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32, 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U90a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9460>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U96e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua640>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uab40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uae60>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uba00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uddc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/lib/rhashtable.c: warning: 'next' may be used uninitialized in this function [-Wuninitialized]:  => 259:20
  + /kisskb/src/mm/memcontrol.c: warning: 'mem_cgroup_id_get_many' defined but not used [-Wunused-function]:  => 4924:13
  + /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]: 2189:42 => 2189:42, 1616:17
  + /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1480 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2905:1
  + /kisskb/src/net/sunrpc/xprtsock.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 2611:16
  + /kisskb/src/net/wireless/nl80211.c: warning: 'rdev' may be used uninitialized in this function [-Wuninitialized]:  => 13070:21
  + /kisskb/src/net/wireless/nl80211.c: warning: 'wdev' may be used uninitialized in this function [-Wuninitialized]:  => 13100:33
  + /kisskb/src/sound/soc/fsl/fsl_ssi.c: warning: 'baudrate' may be used uninitialized in this function [-Wuninitialized]:  => 769:7
  + /kisskb/src/sound/soc/soc-pcm.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 1092:9, 1074:5
  + arch/arm/configs/davinci_all_defconfig: warning: symbol value 'm' invalid for REMOTEPROC:  => 231
  + arch/arm/configs/multi_v7_defconfig: warning: symbol value 'm' invalid for REMOTEPROC:  => 936
  + arch/arm/configs/omap2plus_defconfig: warning: symbol value 'm' invalid for REMOTEPROC:  => 484
  + arch/arm64/configs/defconfig: warning: symbol value 'm' invalid for REMOTEPROC:  => 726
  + warning: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL:  => N/A
  + warning: "__errno_location" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "__fxstat64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "__guard" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "__lxstat" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "__lxstat64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "__stack_smash_handler" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "__xmknod" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "__xstat" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "access" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "chmod" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "chown" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "close" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "closedir" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "dup2" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "fchmod" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "fchown" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "fdatasync" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "fsync" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "ftruncate64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "futimes" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "getuid" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "insb" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "insl" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "insw" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "ioctl" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "link" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "lseek" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "lseek64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "mkdir" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "open" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "open64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "opendir" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "outsb" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "outsl" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "outsw" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "pread64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "printf" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "pwrite64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "read" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "readdir" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "readdir64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "readlink" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "rename" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL:  => N/A
  + warning: "rmdir" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "seekdir" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "statfs" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "statfs64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "symlink" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "syscall" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "telldir" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "truncate" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "truncate64" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "unlink" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "utime" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "utimes" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: "write" [vmlinux] is a static EXPORT_SYMBOL:  => N/A
  + warning: 12 bad relocations:  => N/A
  + warning: 140 bad relocations:  => N/A
  + warning: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel:  => N/A
  + warning: arch/powerpc/oprofile/oprofile.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.:  => N/A
  + warning: vmlinux.o(.text+0x2e1c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x2fc8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x31d4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x31dc): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x31e4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x33c8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3774): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x39c8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x6ee98): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x114): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_printf():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x13c): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_printf():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x15c): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.call_prom():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x18c): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_getprop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x1a4): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_panic():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2ac8): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2acc): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2cd0): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2cd4): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2cf4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2efc): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3cb8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3cc8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3ccc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3cdc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3ce4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3cf8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3f68): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3f78): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3f94): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x538): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x590): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x5f0): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x610): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x6dc): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x6e4): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x720): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x758): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x75c): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7ac): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7b8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7bc): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7c0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7c4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x804): Section mismatch in reference from the function mmp2_add_sdhost() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x810): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh0:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x814): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x818): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x81c): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x864): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x870): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x874): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x878): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x87c): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8c4): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8d0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8d4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8d8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8dc): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x960): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A

117 warning improvements:
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]: 182:1 => 
  - /kisskb/src/drivers/crypto/ccree/cc_cipher.c: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 465:1 => 
  - /kisskb/src/drivers/crypto/talitos.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 3142:4 => 
  - /kisskb/src/drivers/dma/imx-dma.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 542:6 => 
  - /kisskb/src/drivers/gpu/drm/arm/malidp_hw.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 387:8, 1311:4 => 
  - /kisskb/src/drivers/media/usb/dvb-usb/pctv452e.c: warning: value computed is not used [-Wunused-value]: 918:2 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1288 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 127:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 127:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1312 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 127:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 294:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 294:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1368 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 294:1 => 
  - /kisskb/src/drivers/pinctrl/pinctrl-rockchip.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 2783:3 => 
  - /kisskb/src/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 820:20, 815:20 => 
  - /kisskb/src/drivers/pwm/pwm-atmel-hlcdc.c: warning: 'clk_period_ns' may be used uninitialized in this function [-Wuninitialized]: 67:56 => 
  - /kisskb/src/drivers/scsi/cxlflash/main.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 980:3, 983:3, 2347:6, 754:6, 975:3, 3018:6, 759:3, 757:3, 978:3 => 
  - /kisskb/src/drivers/scsi/ibmvscsi/ibmvfc.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 1838:11, 4022:3, 1830:11 => 
  - /kisskb/src/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 1582:6, 2496:16, 2494:16 => 
  - /kisskb/src/drivers/scsi/ncr53c8xx.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 3917:18, 3908:7, 3914:7, 6713:6 => 
  - /kisskb/src/drivers/scsi/wd33c93.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 1856:11 => 
  - /kisskb/src/drivers/soundwire/slave.c: warning: 'sdw_slave_add' defined but not used [-Wunused-function]: 16:12 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.34' uses dynamic stack allocation [enabled by default]: 498:1 => 
  - /kisskb/src/drivers/video/fbdev/sh_mobile_lcdcfb.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 1596:22, 2086:22 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 295:1 => 
  - /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]: 26:7 => 
  - /kisskb/src/kernel/fork.c: warning: 'task_struct_whitelist' defined but not used [-Wunused-function]: 771:13 => 
  - /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1676:17 => 
  - /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wuninitialized]: 1686:3, 1676:3 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 8c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U be0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U dc0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U25a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U28c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U35a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4280>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U43c0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4aa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4dc0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U50a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5500>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5a00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U61e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U68c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U71e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 140:32
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U78c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8960>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8be0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8e60>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U98c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9f00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaaa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub140>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub280>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub3c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub6e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub8c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubbe0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubd20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubdc0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud8c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue5a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf5a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufb40>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufbe0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufc80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 2189:32, 1616:17 => 2189:32
  - /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1512 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2905:1 => 
  - /kisskb/src/net/sunrpc/xprtsock.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 2605:16 => 
  - /kisskb/src/net/xfrm/xfrm_policy.c: warning: array subscript is above array bounds [-Warray-bounds]: 3496:15 => 
  - /kisskb/src/sound/aoa/codecs/onyx.c: warning: 'c' may be used uninitialized in this function [-Wmaybe-uninitialized]: 377:37 => 
  - warning: same module names found:: N/A => 
  - warning: vmlinux.o(.text+0x2e0c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x2fd0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x31f4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x31fac): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x31fc): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3204): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x33d0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x37154): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3794): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x39d0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x36c4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x38c4): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x38f0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3af0): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48a4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48b4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48bc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48cc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48d0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48e8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4b58): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4b68): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4b84): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
