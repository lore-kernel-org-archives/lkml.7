Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C31C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F5E20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbfDBNtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:49:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42844 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731168AbfDBNkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:02 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdu-0002mR-32; Tue, 02 Apr 2019 14:39:58 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdt-0004qM-2Y; Tue, 02 Apr 2019 14:39:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.17110877@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 00/99] 3.16.65-rc1 review
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.65 release.
There are 99 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Apr 04 13:38:27 UTC 2019.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Anand Jain (1):
      btrfs: dev-replace: go back to suspended state if target device is missing
         [0d228ece59a35a9b9e8ff0d40653234a6d90f61e]

Arnaldo Carvalho de Melo (4):
      perf help: Remove needless use of strncpy()
         [b6313899f4ed2e76b8375cf8069556f5b94fbff0]
      perf parse-events: Fix unchecked usage of strncpy()
         [bd8d57fb7e25e9fcf67a9eef5fa13aabe2016e07]
      perf svghelper: Fix unchecked usage of strncpy()
         [2f5302533f306d5ee87bd375aef9ca35b91762cb]
      perf ui helpline: Use strlcpy() as a shorter form of strncpy() + explicit set nul
         [4d0f16d059ddb91424480d88473f7392f24aebdc]

Bart Van Assche (1):
      tools/lib/lockdep: Rename "trywlock" into "trywrlock"
         [7f3c7952d111ac93573fb86f4d5aeff527a07fcc]

Ben Hutchings (2):
      Revert "cifs: empty TargetInfo leads to crash on recovery"
         [not upstream; reverts bad backport]
      perf pmu: Suppress potential format-truncation warning
         [11a64a05dc649815670b1be9fe63d205cb076401]

Breno Leitao (2):
      powerpc/tm: Set MSR[TS] just prior to recheckpoint
         [e1c3743e1a20647c53b719dbf28b48f45d23f2cd]
      powerpc/tm: Unset MSR[TS] if not recheckpointing
         [6f5b9f018f4c7686fd944d920209d1382d320e4e]

Chris Wilson (1):
      drm/i915/ringbuffer: Delay after EMIT_INVALIDATE for gen4/gen5
         [55f99bf2a9c331838c981694bc872cd1ec4070b2]

Christian Borntraeger (1):
      genwqe: Fix size check
         [fdd669684655c07dacbdb0d753fd13833de69a33]

Christoffer Dall (1):
      KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less
         [fb544d1ca65a89f7a3895f7531221ceeed74ada7]

Colin Ian King (3):
      altera-stapl: check for a null key before strcasecmp'ing it
         [9ccb645683ef46e3c52c12c088a368baa58447d4]
      pcrypt: use format specifier in kobject_add
         [b1e3874c75ab15288f573b3532e507c37e8e7656]
      x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)
         [53bb565fc5439f2c8c57a786feea5946804aa3e9]

Dan Carpenter (4):
      IB/qib: Fix an error code in qib_sdma_verbs_send()
         [5050ae5fa3d54c8e83e1e447cc7e3591110a7f57]
      Input: nomadik-ske-keypad - fix a loop timeout test
         [4d8f727b83bcd6702c2d210330872c9122d2d360]
      misc: vexpress: Off by one in vexpress_syscfg_exec()
         [f8a70d8b889f180e6860cb1f85fed43d37844c5a]
      wireless: airo: potential buffer overflow in sprintf()
         [3d39e1bb1c88f32820c5f9271f2c8c2fb9a52bac]

Dmitry Monakhov (1):
      ext4: ext4_inline_data_fiemap should respect callers argument
         [d952d69e268f833c85c0bafee9f67f9dba85044b]

Dmitry Safonov (1):
      tty/ldsem: Wake up readers after timed out down_write()
         [231f8fd0cca078bd4396dd7e380db813ac5736e2]

Dominique Martinet (1):
      9p/net: put a lower bound on msize
         [574d356b7a02c7e1b01a1d9cba8a26b3c2888f45]

Eric Biggers (1):
      crypto: user - support incremental algorithm dumps
         [0ac6b8fb23c724b015d9ca70a89126e8d1563166]

Eric Dumazet (1):
      net/hamradio/6pack: use mod_timer() to rearm timers
         [202700e30740c6568b5a6943662f3829566dd533]

Filipe Manana (2):
      Btrfs: fix fsync of files with multiple hard links in new directories
         [41bd60676923822de1df2c50b3f9a10171f4338a]
      Btrfs: fix stale dir entries after unlink, inode eviction and fsync
         [bde6c242027b0f1d697d5333950b3a05761d40e4]

Finn Thain (1):
      block/swim3: Fix -EBUSY error when re-opening device after unmount
         [296dcc40f2f2e402facf7cd26cf3f2c8f4b17d47]

Geert Uytterhoeven (10):
      pinctrl: sh-pfc: r8a7740: Add missing LCD0 marks to lcd0_data24_1 group
         [96bb2a6ab4eca10e5b6490b3f0738e9f7ec22c2b]
      pinctrl: sh-pfc: r8a7740: Add missing REF125CK pin to gether_gmii group
         [1ebc589a7786f17f97b9e87b44e0fb4d0290d8f8]
      pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b group
         [884fa25fb6e5e63ab970d612a628313bb68f37cc]
      pinctrl: sh-pfc: r8a7791: Remove bogus marks from vin1_b_data18 group
         [0d6256cb880166a4111bebce35790019e56b6e1b]
      pinctrl: sh-pfc: sh7264: Fix PFCR3 and PFCR0 register configuration
         [1b99d0c80bbe1810572c2cb77b90f67886adfa8d]
      pinctrl: sh-pfc: sh7269: Add missing PCIOR0 field
         [9540cbdfcd861caf67a6f0e4bb7f46d41c4aad86]
      pinctrl: sh-pfc: sh73a0: Add missing TO pin to tpu4_to3 group
         [124cde98f856b6206b804acbdec3b7c80f8c3427]
      pinctrl: sh-pfc: sh7734: Add missing IPSR11 field
         [94482af7055e1ffa211c1135256b85590ebcac99]
      pinctrl: sh-pfc: sh7734: Fix shifted values in IPSR10
         [054f2400f706327f96770219c3065b5131f8f154]
      pinctrl: sh-pfc: sh7734: Remove bogus IPSR10 value
         [4d374bacd7c9665179f9752a52d5d602c45d8190]

Georgy A Bystrenin (1):
      CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock problem
         [9a596f5b39593414c0ec80f71b94a226286f084e]

Gustavo A. R. Silva (4):
      ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities
         [5ae4f61f012a097df93de2285070ec8e34716d29]
      ALSA: emux: Fix potential Spectre v1 vulnerabilities
         [4aea96f4237cea0c51a8bc87c0db31f0f932f1f0]
      ALSA: pcm: Fix potential Spectre v1 vulnerability
         [94ffb030b6d31ec840bb811be455dd2e26a4f43e]
      ALSA: rme9652: Fix potential Spectre v1 vulnerability
         [0b84304ef5da92add8dc75a1b07879c5374cdb05]

Huacai Chen (2):
      MIPS: Align kernel load address to 64KB
         [bec0de4cfad21bd284dbddee016ed1767a5d2823]
      MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
         [92aa0718c9fa5160ad2f0e7b5bffb52f1ea1e51a]

Hugh Dickins (2):
      mm Documentation: undoc non-linear vmas
         [7a14239a8fff45a241b6943a3ac444d5b67fcbed]
      mm: rmap use pte lock not mmap_sem to set PageMlocked
         [b87537d9e2feb30f6a962f27eb32768682698d3b]

Jia-Ju Bai (1):
      usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()
         [c85400f886e3d41e69966470879f635a2b50084c]

Jim Mattson (2):
      kvm: Disallow wraparound in kvm_gfn_to_hva_cache_init
         [f1b9dd5eb86cec1fcf66aad17e7701d98d024a9a]
      kvm: vmx: Set IA32_TSC_AUX for legacy mode guests
         [0023ef39dc35c773c436eaa46ca539a26b308b55]

Jiong Wang (1):
      mips: bpf: fix encoding bug for mm_srlv32_op
         [17f6c83fb5ebf7db4fcc94a5be4c22d5a7bfe428]

Jonas Gorski (1):
      MIPS: BCM63XX: fix switch core reset on BCM6368
         [8a38dacf87180738d42b058334c951eba15d2d47]

Kai-Heng Feng (1):
      igb: Fix an issue that PME is not enabled during runtime suspend
         [1fb3a7a75e2efcc83ef21f2434069cddd6fae6f5]

Krzysztof Kozlowski (1):
      gpiolib: Fix return value of gpio_to_desc() stub if !GPIOLIB
         [c5510b8dafce5f3f5a039c9b262ebcae0092c462]

Kyle Roeschley (1):
      ath6kl: Only use match sets when firmware supports it
         [fb376a495fbdb886f38cfaf5a3805401b9e46f13]

Larry Finger (1):
      b43: Fix error in cordic routine
         [8ea3819c0bbef57a51d8abe579e211033e861677]

Laurent Pinchart (1):
      drm: rcar-du: Fix vblank initialization
         [3d61fe5f59dd3e6f96fc0772156d257cb04dc656]

Leon Romanovsky (1):
      net/mlx5: Continue driver initialization despite debugfs failure
         [199fa087dc6b503baad06712716fac645a983e8a]

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units
         [ed54ffbe554f0902689fd6d1712bbacbacd11376]

Maciej W. Rozycki (1):
      MIPS: SiByte: Enable ZONE_DMA32 for LittleSur
         [756d6d836dbfb04a5a486bc2ec89397aa4533737]

Macpaul Lin (1):
      cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.
         [eafb27fa5283599ce6c5492ea18cf636a28222bb]

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()
         [132d00becb31e88469334e1e62751c81345280e0]

Michael Ellerman (1):
      powerpc/configs: Don't enable PPC_EARLY_DEBUG in defconfigs
         [2b874a5c7b75fdc90fdd1e2ffaa3ec5a9d21e253]

Michal Hocko (2):
      hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined
         [b15c87263a69272423771118c653e9a1d0672caa]
      mm, memory_hotplug: do not clear numa_node association after hot_remove
         [46a3679b8190101e4ebdfe252ef79e6150a4f2ac]

Mike Kravetz (1):
      mm: migration: fix migration of huge PMD shared pages
         [017b1660df89f5fb4bfe66c34e35f7d2031100c7]

Noralf Trønnes (1):
      fbdev: fbcon: Fix unregister crash when more than one framebuffer
         [2122b40580dd9d0620398739c773d07a7b7939d0]

Pan Bian (1):
      f2fs: read page index before freeing
         [0ea295dd853e0879a9a30ab61f923c26be35b902]

Paul Burton (1):
      MIPS: Expand MIPS32 ASIDs to 64 bits
         [ff4dd232ec45a0e45ea69f28f069f2ab22b4908a]

Pavel Shilovsky (1):
      CIFS: Enable encryption during session setup phase
         [cabfb3680f78981d26c078a26e5c748531257ebb]

Peter Rosin (1):
      fbdev: fbmem: behave better with small rotated displays and many CPUs
         [f75df8d4b4fabfad7e3cba2debfad12741c6fde7]

Rasmus Villemoes (1):
      lib/string.c: remove duplicated function
         [cd514e727b18ff4d189b8e268db13729a4175091]

Sameer Pujar (1):
      ALSA: hda/tegra: clear pending irq handlers
         [63d2a9ec310d8bcc955574220d4631aa55c1a80c]

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays
         [8d503f206c336677954160ac62f0c7d9c219cd89]

Sean Christopherson (1):
      KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup
         [e81434995081fd7efb755fd75576b35dbb0850b1]

Sergei Shtylyov (1):
      sata_rcar: fix deferred probing
         [9f83cfdb1ace3ef268ecc6fda50058d2ec37d603]

Sergey Senozhatsky (1):
      panic: avoid deadlocks in re-entrant console drivers
         [c7c3f05e341a9a2bd1a92993d4f996cfd6e7348e]

Shivasharan S (1):
      scsi: megaraid_sas: Use 63-bit DMA addressing
         [894169db12463cea08d0e2a9e35f42b291340e5a]

Shrikrishna Khare (1):
      Driver: Vmxnet3: Fix regression caused by 5738a09
         [58caf637365fef97c8e84ea5699a8e34d68fce93]

Stefan Agner (1):
      serial: imx: fix error handling in console_setup
         [63fd4b94b948c14eeb27a3bbf50ea0f7f0593bad]

Steffen Maier (1):
      scsi: zfcp: fix posting too many status read buffers leading to adapter shutdown
         [60a161b7e5b2a252ff0d4c622266a7d8da1120ce]

Theodore Ts'o (8):
      ext4: avoid declaring fs inconsistent due to invalid file handles
         [8a363970d1dc38c4ec4ad575c862f776f468d057]
      ext4: avoid kernel warning when writing the superblock to a dead device
         [e86807862e6880809f191c4cea7f88a489f0ed34]
      ext4: check for shutdown and r/o file system in ext4_write_inode()
         [18f2c4fcebf2582f96cbd5f2238f4f354a0e4847]
      ext4: fix a potential fiemap/page fault deadlock w/ inline_data
         [2b08b1f12cd664dc7d5c84ead9ff25ae97ad5491]
      ext4: fix special inode number checks in __ext4_iget()
         [191ce17876c9367819c4b0a25b503c0f6d9054d8]
      ext4: force inode writes when nfsd calls commit_metadata()
         [fde872682e175743e0c3ef939c89e3c6008a1529]
      ext4: include terminating u32 in size of xattr entries when expanding inodes
         [a805622a757b6d7f65def4141d29317d8e37b8a1]
      ext4: make sure enough credits are reserved for dioread_nolock writes
         [812c0cab2c0dfad977605dbadf9148490ca5d93f]

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path
         [756af9c642329d54f048bac2a62f829b391f6944]

Vasily Averin (6):
      dlm: fixed memory leaks after failed ls_remove_names allocation
         [b982896cdb6e6a6b89d86dfb39df489d9df51e14]
      dlm: lost put_lkb on error path in receive_convert() and receive_unlock()
         [c0174726c3976e67da8649ac62cae43220ae173a]
      dlm: memory leaks on error path in dlm_user_request()
         [d47b41aceeadc6b58abc9c7c6485bef7cfb75636]
      dlm: possible memory leak on error path in create_lkb()
         [23851e978f31eda8b2d01bd410d3026659ca06c7]
      sunrpc: fix cache_head leak due to queued request
         [4ecd55ea074217473f94cfee21bb72864d39f8d7]
      sunrpc: use SVC_NET() in svcauth_gss_* functions
         [b8be5674fa9a6f3677865ea93f7803c4212f3e10]

Yang Dongsheng (1):
      Btrfs: fill ->last_trans for delayed inode in btrfs_fill_inode.
         [6e17d30bfaf43e04d991392d8484f1c556810c33]

Zheng Yan (1):
      ceph: don't update importing cap's mseq when handing cap export
         [3c1392d4c49962a31874af14ae9ff289cb2b3851]

Zhengbin (1):
      9p/net: fix memory leak in p9_client_create
         [bb06c388fa20ae24cfe80c52488de718a7e3a53f]

 Documentation/filesystems/proc.txt                 |   1 -
 Documentation/vm/page_migration                    |  10 +-
 Documentation/vm/unevictable-lru.txt               | 120 ++++-----------------
 Makefile                                           |   4 +-
 arch/arm/kvm/arm.c                                 |  23 ++--
 arch/mips/Kconfig                                  |   1 +
 arch/mips/bcm63xx/reset.c                          |   2 +-
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   7 +-
 arch/mips/include/asm/cpu-info.h                   |   2 +-
 arch/mips/include/asm/mmu.h                        |   2 +-
 arch/mips/include/asm/mmu_context.h                |   8 +-
 arch/mips/include/asm/pgtable-64.h                 |   5 +
 arch/mips/include/uapi/asm/inst.h                  |   2 +-
 arch/mips/mm/c-r3k.c                               |   2 +-
 arch/powerpc/configs/g5_defconfig                  |   1 -
 arch/powerpc/configs/maple_defconfig               |   1 -
 arch/powerpc/configs/pmac32_defconfig              |   1 -
 arch/powerpc/configs/ppc64_defconfig               |   1 -
 arch/powerpc/configs/ppc6xx_defconfig              |   1 -
 arch/powerpc/kernel/signal_32.c                    |  38 +++++--
 arch/powerpc/kernel/signal_64.c                    |  44 ++++++--
 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/kvm/vmx.c                                 |   6 +-
 arch/x86/pci/broadcom_bus.c                        |   4 +-
 crypto/crypto_user.c                               |  37 ++++---
 crypto/pcrypt.c                                    |   2 +-
 drivers/ata/sata_rcar.c                            |   4 +-
 drivers/block/swim3.c                              |   6 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |  40 ++++++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |   2 +-
 drivers/infiniband/hw/qib/qib_sdma.c               |   4 +-
 drivers/input/keyboard/nomadik-ske-keypad.c        |   2 +-
 drivers/misc/altera-stapl/altera.c                 |   3 +-
 drivers/misc/genwqe/card_utils.c                   |   2 +-
 drivers/misc/vexpress-syscfg.c                     |   2 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |   6 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   6 +-
 drivers/net/hamradio/6pack.c                       |  24 ++---
 drivers/net/vmxnet3/vmxnet3_drv.c                  |   6 +-
 drivers/net/vmxnet3/vmxnet3_int.h                  |   4 +-
 drivers/net/wireless/airo.c                        |   2 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |   2 +-
 drivers/net/wireless/b43/phy_common.c              |   2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |   3 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |   6 +-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c                |   9 +-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c                |   2 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |   1 +
 drivers/pinctrl/sh-pfc/pfc-sh7734.c                |  20 ++--
 drivers/power/olpc_battery.c                       |   4 +-
 drivers/s390/scsi/zfcp_aux.c                       |   6 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   2 +-
 drivers/tty/serial/imx.c                           |   2 +-
 drivers/tty/tty_ldsem.c                            |  10 ++
 drivers/usb/class/cdc-acm.c                        |  10 ++
 drivers/usb/class/cdc-acm.h                        |   1 +
 drivers/usb/host/r8a66597-hcd.c                    |   5 +-
 drivers/usb/serial/pl2303.c                        |   5 +
 drivers/usb/serial/pl2303.h                        |   5 +
 drivers/video/console/fbcon.c                      |   2 +-
 drivers/video/fbdev/core/fbmem.c                   |   8 +-
 fs/btrfs/btrfs_inode.h                             |   6 ++
 fs/btrfs/delayed-inode.c                           |   2 +
 fs/btrfs/dev-replace.c                             |   2 +
 fs/btrfs/inode.c                                   |  65 +++++++++--
 fs/btrfs/tree-log.c                                |  16 +++
 fs/ceph/caps.c                                     |   1 -
 fs/cifs/sess.c                                     |  22 ++--
 fs/cifs/smb2maperror.c                             |   4 +-
 fs/cifs/smb2pdu.c                                  |  11 +-
 fs/dlm/lock.c                                      |  17 +--
 fs/dlm/lockspace.c                                 |   2 +-
 fs/ext4/ext4.h                                     |  17 ++-
 fs/ext4/extents.c                                  |   3 +-
 fs/ext4/ialloc.c                                   |   2 +-
 fs/ext4/inline.c                                   |  26 +++--
 fs/ext4/inode.c                                    |  61 +++++++----
 fs/ext4/ioctl.c                                    |   2 +-
 fs/ext4/namei.c                                    |   4 +-
 fs/ext4/resize.c                                   |   5 +-
 fs/ext4/super.c                                    |  32 +++---
 fs/ext4/xattr.c                                    |   2 +-
 fs/f2fs/node.c                                     |   4 +-
 include/linux/gpio/consumer.h                      |   2 +-
 include/linux/hugetlb.h                            |  14 +++
 include/linux/mm.h                                 |   6 ++
 include/trace/events/ext4.h                        |  20 ++++
 kernel/panic.c                                     |   6 +-
 lib/string.c                                       |  27 ++---
 mm/hugetlb.c                                       |  37 ++++++-
 mm/memory_hotplug.c                                |  46 +++-----
 mm/rmap.c                                          |  92 +++++++++++-----
 net/9p/client.c                                    |  21 ++++
 net/sunrpc/auth_gss/svcauth_gss.c                  |   8 +-
 net/sunrpc/cache.c                                 |   9 +-
 sound/core/pcm.c                                   |   2 +
 sound/pci/emu10k1/emufx.c                          |   5 +
 sound/pci/hda/hda_tegra.c                          |   2 +
 sound/pci/rme9652/hdsp.c                           |  10 +-
 sound/synth/emux/emux_hwdep.c                      |   7 +-
 tools/lib/lockdep/include/liblockdep/rwlock.h      |   6 +-
 tools/perf/builtin-help.c                          |   2 +-
 tools/perf/ui/tui/helpline.c                       |   2 +-
 tools/perf/util/parse-events.c                     |   2 +-
 tools/perf/util/pmu.c                              |   4 +-
 tools/perf/util/svghelper.c                        |   2 +-
 virt/kvm/kvm_main.c                                |  40 +++----
 108 files changed, 771 insertions(+), 460 deletions(-)

-- 
Ben Hutchings
Klipstein's 4th Law of Prototyping and Production:
                               A fail-safe circuit will destroy others.

