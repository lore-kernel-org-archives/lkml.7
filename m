Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFC1279DB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfFCO2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:28:50 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:36188 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfFCO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:28:50 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id LEUe2000L3XaVaC01EUe2d; Mon, 03 Jun 2019 16:28:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hXnx0-0004dT-At
        for linux-kernel@vger.kernel.org; Mon, 03 Jun 2019 16:28:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hXnx0-0006dw-9C
        for linux-kernel@vger.kernel.org; Mon, 03 Jun 2019 16:28:38 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.2-rc3
Date:   Mon,  3 Jun 2019 16:28:38 +0200
Message-Id: <20190603142838.25494-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.2-rc3[1] compared to v5.1[2].

Summarized:
  - build errors: +2/-0
  - build warnings: +149/-111

JFYI, when comparing v5.2-rc3[1] to v5.2-rc2[3], the summaries are:
  - build errors: +1/-3
  - build warnings: +64/-63

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a/ (all 242 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd/ (236 out of 242 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/cd6c84d8f0cdc911df435bb075ba22ce3c605b07/ (240 out of 242 configs)


*** ERRORS ***

2 error regressions:
  + error: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!:  => N/A
  + error: "devm_ioremap" [drivers/counter/ftm-quaddec.ko] undefined!:  => N/A


*** WARNINGS ***

149 warning regressions:
  + /kisskb/src/arch/parisc/math-emu/cnv_float.h: warning: '<<' in boolean context, did you mean '<' ? [-Wint-in-bool-context]:  => 50:52, 62:31, 58:27, 54:21
  + /kisskb/src/arch/s390/include/asm/uaccess.h: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]:  => 113:2, 143:2
  + /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2960 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 51:1, 93:1
  + /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 93:1
  + /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2976 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 51:1
  + /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 149:1
  + /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1188 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 149:1
  + /kisskb/src/drivers/block/ps3vram.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'sector_t' [-Wformat]:  => 770:2
  + /kisskb/src/drivers/crypto/ccree/cc_cipher.c: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 465:1
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.27' uses dynamic stack allocation [enabled by default]:  => 406:1
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/bus/hwsq.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]:  => 162:16
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]:  => 154:40
  + /kisskb/src/drivers/hwmon/f71805f.c: warning: 'address' may be used uninitialized in this function [-Wuninitialized]:  => 1626:26
  + /kisskb/src/drivers/hwmon/w83627hf.c: warning: 'address' may be used uninitialized in this function [-Wuninitialized]:  => 1980:27
  + /kisskb/src/drivers/hwtracing/intel_th/msu.c: warning: unused variable 'i' [-Wunused-variable]:  => 783:21, 863:6
  + /kisskb/src/drivers/iommu/fsl_pamu_domain.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 102:9
  + /kisskb/src/drivers/lightnvm/core.c: warning: 't' may be used uninitialized in this function [-Wuninitialized]:  => 510:5
  + /kisskb/src/drivers/misc/habanalabs/habanalabs_ioctl.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 143:23
  + /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined [enabled by default]:  => 92:0
  + /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined:  => 92
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2.h: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709551584' to '-32' [-Woverflow]:  => 614:2
  + /kisskb/src/drivers/net/wireless/realtek/rtw88/phy.c: warning: array subscript is above array bounds [-Warray-bounds]:  => 430:26
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/core.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]:  => 149:36
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/core.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat]:  => 149:9
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 75:1
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 75:1
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 75:1
  + /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 58:35
  + /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t' [-Wformat]:  => 58:2
  + /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]:  => 58:35
  + /kisskb/src/fs/btrfs/props.c: warning: 'num_bytes' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 389:4
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: 'in_data_buf' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 2581:19
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: 'in_data_buf' may be used uninitialized in this function [-Wuninitialized]:  => 2581:19
  + /kisskb/src/include/linux/list.h: warning: 'head' may be used uninitialized in this function [-Wuninitialized]:  => 93:12
  + /kisskb/src/include/linux/rhashtable.h: warning: 'next' may be used uninitialized in this function [-Wuninitialized]:  => 110:10
  + /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1645:17
  + /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wuninitialized]:  => 1655:3, 1645:3
  + /kisskb/src/kernel/locking/lockdep.c: warning: 'print_lock_trace' defined but not used [-Wunused-function]:  => 2821:13
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U13c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32, 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2500>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U40a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U53c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U55a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U80a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U83c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U85a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9000>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U90a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uac80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaf00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32, 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucf00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud280>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ude60>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue640>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uec80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uff00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/lib/test_kasan.c: warning: 'kasan_alloca_oob_left' uses dynamic stack allocation:  => 491:1
  + /kisskb/src/lib/test_kasan.c: warning: 'kasan_alloca_oob_right' uses dynamic stack allocation:  => 501:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.47' uses dynamic stack allocation [enabled by default]:  => 2177:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.49' uses dynamic stack allocation [enabled by default]:  => 1884:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.48' uses dynamic stack allocation [enabled by default]:  => 2245:1
  + /kisskb/src/mm/vmalloc.c: warning: 'lva' may be used uninitialized in this function [-Wuninitialized]:  => 976:28
  + /kisskb/src/net/core/devlink.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 4304:6 => 4390:6, 4321:6
  + /kisskb/src/net/ipv4/fib_semantics.c: warning: 'err' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1023:12
  + /kisskb/src/net/ipv4/fib_semantics.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 1023:12
  + /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1504 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2905:1
  + /kisskb/src/net/xfrm/xfrm_policy.c: warning: array subscript is above array bounds [-Warray-bounds]:  => 3495:15
  + /kisskb/src/sound/soc/fsl/imx-audmix.c: warning: 'capture_dai_name' may be used uninitialized in this function [-Wuninitialized]:  => 277:45
  + warning: "copy_page" [drivers/md/dm-integrity.ko] has no CRC!:  => N/A
  + warning: 140 bad relocations:  => N/A
  + warning: 141 bad relocations:  => N/A
  + warning: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel:  => N/A
  + warning: arch/powerpc/oprofile/oprofile.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.:  => N/A
  + warning: same module names found::  => N/A
  + warning: vmlinux.o(.text+0x2f2a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x2f3c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x302a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x30ba): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3128): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x312a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3164): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x322a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x325dc): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x340c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3474): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3484): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x352a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3628): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x362a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3664): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3734): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3770): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x37784): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x3a14): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3c34): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3c70): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3dc6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x40e): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x42c6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x51a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x5f878): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x24c84): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x308): Section mismatch in reference from the function populate_initrd_image() to the function .init.text:set_reset_devices():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x30c): Section mismatch in reference from the function populate_initrd_image() to the variable .init.ramfs.info:__initramfs_size:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x32c): Section mismatch in reference from the function populate_initrd_image() to the function .init.text:set_reset_devices():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x36cc): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x36e4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x38cc): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3914): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3928): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3b58): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0xe704): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys():  => N/A

111 warning improvements:
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]: 182:1 => 
  - /kisskb/src/arch/s390/mm/pgtable.c: warning: 'pmd_alloc_map' defined but not used [-Wunused-function]: 413:15 => 
  - /kisskb/src/arch/um/kernel/skas/uaccess.c: warning: unused variable 'buf' [-Wunused-variable]: 62:10 => 
  - /kisskb/src/arch/um/os-Linux/umid.c: warning: ISO C90 forbids variable length array 'dir' [-Wvla]: 388:2 => 
  - /kisskb/src/arch/um/os-Linux/umid.c: warning: ISO C90 forbids variable length array 'file' [-Wvla]: 213:2, 138:2 => 
  - /kisskb/src/drivers/atm/ambassador.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]: 1762:3 => 
  - /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.23' uses dynamic stack allocation [enabled by default]: 406:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: (near initialization for 'stream_update.src') [-Wmissing-braces]: 5861:10 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: missing braces around initializer [-Wmissing-braces]: 5861:10 => 
  - /kisskb/src/drivers/gpu/drm/arm/display/komeda/komeda_dev.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 145:5 => 
  - /kisskb/src/drivers/mtd/ubi/wl.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 1520:19 => 
  - /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]: 2962:6 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 845:5 => 
  - /kisskb/src/drivers/net/wan/lmc/lmc_main.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]: 1876:5, 1851:9, 1873:9, 1860:9, 1862:5, 1875:5 => 
  - /kisskb/src/drivers/scsi/myrs.c: warning: 'sshdr.sense_key' may be used uninitialized in this function [-Wmaybe-uninitialized]: 821:24 => 
  - /kisskb/src/fs/btrfs/qgroup.c: warning: array subscript is below array bounds [-Warray-bounds]: 1720:18, 1721:17 => 
  - /kisskb/src/fs/reiserfs/stree.c: warning: the frame size of 1052 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 812:1 => 
  - /kisskb/src/include/linux/skbuff.h: warning: 'extra_uref' may be used uninitialized in this function [-Wuninitialized]: 1397:6 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 960>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U be0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U16e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1be0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2000>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U20a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U21e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2aa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U35a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3c80>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U45a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5f00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U66e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U68c0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6960>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U73c0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9820>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua000>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uadc0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub460>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud640>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud960>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udf00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueb40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uebe0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf960>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/trace/trace_hwlat.c: warning: the frame size of 1696 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 341:1 => 
  - /kisskb/src/lib/rhashtable.c: warning: 'next' may be used uninitialized in this function [-Wuninitialized]: 264:2 => 
  - /kisskb/src/mm/mprotect.c: warning: unused variable 'mm' [-Wunused-variable]: 42:20 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.50' uses dynamic stack allocation [enabled by default]: 2185:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.52' uses dynamic stack allocation [enabled by default]: 1892:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.51' uses dynamic stack allocation [enabled by default]: 2253:1 => 
  - /kisskb/src/net/netfilter/nf_nat_masquerade.c: warning: 'masq_refcnt6' defined but not used [-Wunused-variable]: 15:21 => 
  - /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1480 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2904:1 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for FS_ENCRYPTION: 534 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NET_DEVLINK: 333 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for FS_ENCRYPTION: 423 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NET_DEVLINK: 306 => 
  - warning: vmlinux.o(.text+0x2b3c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x2d28): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x2d5c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x2fac): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3074): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3084): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3228): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x325c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3334): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3368): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x339c8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x35a4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x37c04): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3834): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3868): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3d9430): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3d9a98): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3e0c10): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3e1278): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x458810): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x458e78): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2e18): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2e84): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2f90): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x30a8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
