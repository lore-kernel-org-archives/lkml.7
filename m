Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F1C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1023212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfD0PdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:33:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60600 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfD0PPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000z3-85; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004Nb-2k; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>
Date:   Sat, 27 Apr 2019 16:13:08 +0100
Message-ID: <lsq.1556377988.384060557@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 000/202] 3.16.66-rc1 review
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.66 release.
There are 202 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 01 18:00:00 UTC 2019.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Aaro Koskinen (1):
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled
         [dcf300a69ac307053dfb35c2e33972e754a98bce]

Alex Williamson (1):
      vfio/type1: Limit DMA mappings per container
         [492855939bdb59c6f947b0b5b44af9ad82b7e38c]

Alexander Popov (1):
      KVM: x86: Fix single-step debugging
         [5cc244a20b86090c087073c124284381cdf47234]

Alexandru Ardelean (1):
      dmaengine: dmatest: unmap data on a single code-path when xfer done
         [0255200bd29afc320c6ea4c1adf8bdc13a9b3c15]

Andrea Arcangeli (1):
      coredump: fix race condition between mmget_not_zero()/get_task_mm() and core dumping
         [04f5866e41fb70690e28397487d8bd8eea7d712a]

Andy Lutomirski (1):
      x86/uaccess: Don't leak the AC flag into __put_user() value evaluation
         [2a418cf3f5f1caf911af288e978d61c9844b0695]

Andy Shevchenko (1):
      dmaengine: dmatest: Abort test in case of mapping error
         [6454368a804c4955ccd116236037536f81e5b1f1]

Arend van Spriel (5):
      brcmfmac: add subtype check for event handling in data path
         [a4176ec356c73a46c07c181c6d04039fafa34a9f]
      brcmfmac: assure SSID length from firmware is limited
         [1b5e2423164b3670e8bc9174e4762d297990deff]
      brcmfmac: consolidate ifp lookup in driver core
         [75effb03ee8e4c9d4bbc909118ce5444b047dfde]
      brcmfmac: make brcmf_proto_hdrpull() return struct brcmf_if instance
         [796cfb65e3ed01a9b08e3a0b93e34120c54bbbd2]
      brcmfmac: revise handling events in receive path
         [9c349892ccc90c6de2baaa69cc78449f58082273]

Aya Levin (1):
      net/mlx4_core: Add masking for a few queries on HCA caps
         [a40ded6043658444ee4dd6ee374119e4e98b33fc]

B-Ak (1):
      ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby mode
         [667e9334fa64da2273e36ce131b05ac9e47c5769]

Ben Hutchings (1):
      binfmt_elf: Fix missing SIGKILL for empty PIE
         [not upstream; fixes bad backport]

Bin Liu (1):
      usb: phy: am335x: fix race condition in _probe
         [a53469a68eb886e84dd8b69a1458a623d3591793]

Borislav Petkov (1):
      x86/a.out: Clear the dump structure initially
         [10970e1b4be9c74fce8ab6e3c34a7d718f063f2c]

Charles Keepax (1):
      ALSA: compress: Fix stop handling on compressed capture streams
         [4f2ab5e1d13d6aa77c55f4914659784efd776eb4]

Charles Yeh (1):
      USB: serial: pl2303: add new PID to support PL2303TB
         [4dcf9ddc9ad5ab649abafa98c5a4d54b1a33dabb]

Christian Borntraeger (1):
      s390/early: improve machine detection
         [03aa047ef2db4985e444af6ee1c1dd084ad9fb4c]

Christoph Paasch (1):
      net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec
         [398f0132c14754fcd03c1c4f8e7176d001ce8ea1]

Cong Wang (1):
      team: avoid complex list operations in team_nl_cmd_options_set()
         [2fdeee2549231b1f989f011bb18191f5660d3745]

Dan Carpenter (4):
      ALSA: cs46xx: Potential NULL dereference in probe
         [1524f4e47f90b27a3ac84efbdd94c63172246a6f]
      mfd: ab8500-core: Return zero in get_register_interruptible()
         [10628e3ecf544fa2e4e24f8e112d95c37884dc98]
      scsi: bnx2fc: Fix error handling in probe()
         [b2d3492fc591b1fb46b81d79ca1fc44cac6ae0ae]
      skge: potential memory corruption in skge_get_regs()
         [294c149a209c6196c2de85f512b52ef50f519949]

Daniel Drake (1):
      x86/kaslr: Fix incorrect i8254 outb() parameters
         [7e6fc2f50a3197d0e82d1c0e86282976c9e6c8a4]

Daniele Palmas (1):
      usb: cdc-acm: send ZLP for Telit 3G Intel based modems
         [34aabf918717dd14e05051896aaecd3b16b53d95]

Darrick J. Wong (2):
      tmpfs: fix link accounting when a tmpfile is linked in
         [1062af920c07f5b54cf5060fde3339da6df0cf6b]
      tmpfs: fix uninitialized return value in shmem_link
         [29b00e609960ae0fcff382f4c7079dd0874a5311]

David Hildenbrand (1):
      mm: migrate: don't rely on __PageMovable() of newpage after unlocking it
         [e0a352fabce61f730341d119fbedf71ffdb8663f]

David Howells (1):
      assoc_array: Fix shortcut creation
         [bb2ba2d75a2d673e76ddaf13a9bd30d6a8b1bb08]

Davidlohr Bueso (1):
      arc: do not export symbols in troubleshoot.c
         [be2a7fce397d82b7dc3fdbc61fb0bdab118e65ca]

Dexuan Cui (1):
      Drivers: hv: vmbus: Check for ring when getting debug info
         [ba50bf1ce9a51fc97db58b96d01306aa70bc3979]

Eric Biggers (5):
      KEYS: allow reaching the keys quotas exactly
         [a08bf91ce28ed3ae7b6fef35d843fef8dc8c2cd9]
      KEYS: always initialize keyring_index_key::desc_len
         [ede0fa98a900e657d1fcd80b50920efc896c1a4c]
      KEYS: restrict /proc/keys by credentials at open time
         [4aa68e07d845562561f5e73c04aa521376e95252]
      KEYS: user: Align the payload buffer
         [cc1780fc42c76c705dd07ea123f1143dc5057630]
      crypto: authenc - fix parsing key with misaligned rta_len
         [8f9c469348487844328e162db57112f7d347c49f]

Eric Dumazet (3):
      batman-adv: fix uninit-value in batadv_interface_tx()
         [4ffcbfac60642f63ae3d80891f573ba7e94a265c]
      net/x25: fix a race in x25_bind()
         [797a22bd5298c2674d927893f46cadf619dad11d]
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
         [4179cb5a4c924cd233eaadd081882425bc98f44e]

Eric W. Biederman (4):
      ipc/shm: Fix pid freeing.
         [2236d4d39035b9839944603ec4b65ce71180a9ea]
      signal: Always notice exiting tasks
         [35634ffa1751b6efd8cf75010b509dcb0263e29b]
      signal: Better detection of synchronous signals
         [7146db3317c67b517258cb5e1b08af387da0618b]
      signal: Restore the stop PTRACE_EVENT_EXIT
         [cf43a757fd49442bc38f76088b70c2299eed2c2f]

Eugene Loh (1):
      kallsyms: Handle too long symbols in kallsyms.c
         [6db2983cd8064808141ccefd75218f5b4345ffae]

Eugeniy Paltsev (1):
      ARC: U-boot: check arguments paranoidly
         [a66f2e57bd566240d8b3884eedf503928fbbe557]

Felix Fietkau (1):
      mac80211: ensure that mgmt tx skbs have tailroom for encryption
         [9d0f50b80222dc273e67e4e14410fcfa4130a90c]

Feras Daoud (1):
      IB/ipoib: Fix for use-after-free in ipoib_cm_tx_start
         [6ab4aba00f811a5265acc4d3eb1863bb3ca60562]

Florian Westphal (1):
      netfilter: nf_tables: nft_compat: fix refcount leak on xt module
         [b8e9dc1c75714ceb53615743e1036f76e00f5a17]

Franky Lin (1):
      brcmfmac: screening firmware event packet
         [c56caa9db8abbbfb9e31325e0897705aa897db37]

Gabriel Krisman Bertazi (1):
      sd: Clear PS bit before Mode Select.
         [2c5d16d6a9e7218e57b716e4fd9d77c776d21471]

Gavin Li (1):
      brcmfmac: fix incorrect event channel deduction
         [8e290cecdd0178f3d4cf7d463c51dc7e462843b4]

Gerald Schaefer (1):
      s390/smp: fix CPU hotplug deadlock with CPU rescan
         [b7cb707c373094ce4008d4a6ac9b6b366ec52da5]

Greg Kroah-Hartman (3):
      debugfs: fix debugfs_rename parameter checking
         [d88c93f090f708c18195553b352b9f205e65418f]
      tty: Handle problem if line discipline does not have receive_buf
         [27cfb3a53be46a54ec5e0bd04e51995b74c90343]
      tty: mark Siemens R3964 line discipline as BROKEN
         [c7084edc3f6d67750f50d4183134c4fb5712a5c8]

Grygorii Strashko (1):
      net: phy: micrel: ksz9031: reconfigure autoneg after phy autoneg workaround
         [c1a8d0a3accf64a014d605e6806ce05d1c17adf1]

Guenter Roeck (1):
      unicore32: Fix build error
         [ca98565a6182a960cd857d7546267a0775154eb8]

Gustavo A. R. Silva (4):
      char/mwave: fix potential Spectre v1 vulnerability
         [701956d4018e5d5438570e39e8bda47edd32c489]
      ipmi: msghandler: Fix potential Spectre v1 vulnerabilities
         [a7102c7461794a5bb31af24b08e9e0f50038897a]
      perf tests evsel-tp-sched: Fix bitwise operator
         [489338a717a0dfbbd5a3fabccf172b78f0ac9015]
      usb: gadget: udc: net2272: Fix bitwise and boolean operations
         [07c69f1148da7de3978686d3af9263325d9d60bd]

Hangbin Liu (1):
      sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()
         [173656accaf583698bac3f9e269884ba60d51ef4]

Hans de Goede (2):
      ACPI: power: Skip duplicate power resource references in _PRx
         [7d7b467cb95bf29597b417d4990160d4ea6d69b9]
      libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD
         [dd957493baa586f1431490f97f9c7c45eaf8ab10]

Heiner Kallweit (1):
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ9031
         [1d16073a326891c2a964e4cb95bc18fbcafb5f74]

Hui Peng (1):
      ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks
         [cbb2ebf70daf7f7d97d3811a2ff8e39655b8c184]

Icenowy Zheng (2):
      USB: storage: add quirk for SMI SM3350
         [0a99cc4b8ee83885ab9f097a3737d1ab28455ac0]
      USB: storage: don't insert sane sense for SPC3+ when bad sense specified
         [c5603d2fdb424849360fe7e3f8c1befc97571b8c]

Ilya Dryomov (1):
      rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set
         [85f5a4d666fd9be73856ed16bb36c5af5b406b29]

Ingo Molnar (1):
      perf/core: Fix impossible ring-buffer sizes warning
         [528871b456026e6127d95b1b2bd8e3a003dc1614]

Ivan Mironov (3):
      drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock
         [66a8d5bfb518f9f12d47e1d2dce1732279f9451e]
      drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2
         [62d85b3bf9d978ed4b6b2aeef5cf0ccf1423906e]
      scsi: sd: Fix cache_type_store()
         [44759979a49bfd2d20d789add7fa81a21eb1a4ab]

Jack Stocker (1):
      USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB
         [3483254b89438e60f719937376c5e0ce2bc46761]

Jacob Wen (1):
      l2tp: copy 4 more bytes to linear part if necessary
         [91c524708de6207f59dd3512518d8a1c7b434ee3]

Jann Horn (2):
      fuse: call pipe_buf_release() under pipe lock
         [9509941e9c534920ccc4771ae70bd6cbbe79df1c]
      mm: enforce min addr even if capable() in expand_downwards()
         [0a1d52994d440e21def1c2174932410b4f2a98a1]

Jason Gunthorpe (1):
      packet: Do not leak dev refcounts on error exit
         [d972f3dce8d161e2142da0ab1ef25df00e2f21a9]

Jiri Olsa (1):
      perf/x86: Add check_period PMU callback
         [81ec3f3c4c4d78f2d3b6689c9816bfbdf7417dbb]

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached
         [ffeafdd2bf0b280d67ec1a47ea6287910d271f3f]

John Johansen (1):
      apparmor: provide userspace flag indicating binfmt_elf_mmap change
         [34c426acb75cc21bdf84685e106db0c1a3565057]

Jonathan Bakker (1):
      Input: bma150 - register input device after setting private data
         [90cc55f067f6ca0e64e5e52883ece47d8af7b67b]

Jonathan Hunter (1):
      mfd: tps6586x: Handle interrupts on suspend
         [ac4ca4b9f4623ba5e1ea7a582f286567c611e027]

Jonathan Neuschäfer (1):
      mmc: spi: Fix card detection during probe
         [c9bd505dbd9d3dc80c496f88eafe70affdcf1ba6]

Jose Abreu (1):
      net: stmmac: Fix a race in EEE enable callback
         [8a7493e58ad688eb23b81e45461c5d314f4402f1]

Julian Wiedmann (3):
      s390/qeth: cancel close_dev work before removing a card
         [c2780c1a3fb724560b1d44f7976e0de17bf153c7]
      s390/qeth: conclude all event processing before offlining a card
         [c0a2e4d10d9366ada133a8ae4ff2f32397f8b15b]
      s390/qeth: fix use-after-free in error path
         [afa0c5904ba16d59b0454f7ee4c807dae350f432]

Jun-Ru Chang (1):
      MIPS: Remove function size check in get_frame_info()
         [2b424cfc69728224fcb5fad138ea7260728e0901]

Kal Conley (1):
      net/packet: fix 4gb buffer limit due to overflow check
         [fc62814d690cf62189854464f4bd07457d5e9e50]

Kan Liang (1):
      perf/x86/intel/uncore: Add Node ID mask
         [9e63a7894fd302082cf3627fe90844421a6cbe7f]

Kangjie Lu (1):
      ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages
         [44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661]

Kees Cook (1):
      Yama: Check for pid death before checking ancestry
         [9474f4e7cd71a633fa1ef93b7daefd44bbdfd482]

Leonid Iziumtsev (1):
      dmaengine: imx-dma: fix wrong callback invoke
         [341198eda723c8c1cddbb006a89ad9e362502ea2]

Linus Torvalds (1):
      binfmt_elf: switch to new creds when switching to new mm
         [9f834ec18defc369d73ccf9e87a2790bfa05bf46]

Linus Walleij (1):
      ARM: dts: kirkwood: Fix polarity of GPIO fan lines
         [b5f034845e70916fd33e172fad5ad530a29c10ab]

Liping Zhang (1):
      netfilter: nft_compat: fix crash when related match/target module is removed
         [4b512e1c1f8de6b9ceb796ecef8658e0a083cab7]

Logan Gunthorpe (1):
      scsi: isci: initialize shost fully before calling scsi_add_host()
         [cc29a1b0a3f2597ce887d339222fa85b9307706d]

Lukas Wunner (2):
      dmaengine: bcm2835: Fix abort of transactions
         [9e528c799d17a4ac37d788c81440b50377dd592d]
      dmaengine: bcm2835: Fix interrupt race on RT
         [f7da7782aba92593f7b82f03d2409a1c5f4db91b]

Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it
         [7b12c8189a3dc50638e7d53714c88007268d47ef]

Manuel Reinhardt (1):
      ALSA: usb-audio: Fix implicit fb endpoint setup by quirk
         [2bc16b9f3223d049b57202ee702fcb5b9b507019]

Marcel Holtmann (2):
      Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt
         [af3d5d1c87664a4f150fcf3534c6567cb19909b0]
      Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer
         [7c9cbd0b5e38a1672fcd137894ace3b042dfbf69]

Mark Rutland (1):
      perf/core: Don't WARN() for impossible ring-buffer sizes
         [9dff0aa95a324e262ffb03f425d00e4751f3294e]

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem
         [d5d27fd9826b59979b184ec288e4812abac0e988]

Martin Schwidefsky (1):
      s390/mm: always force a load of the primary ASCE on context switch
         [a38662084c8bdb829ff486468c7ea801c13fcc34]

Martin Sperl (1):
      dmaengine: bcm2835: add additional defines for DMA-registers
         [e42685d7a7d5afa6278561ffd85c475eae246be3]

Matthias Schwarzott (1):
      media: em28xx: Fix use-after-free when disconnecting
         [910b0797fa9e8af09c44a3fa36cb310ba7a7218d]

Matti Kurkela (2):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780
         [e8b22d0a329f0fb5c7ef95406872d268f01ee3b1]
      Input: elantech - force needed quirks on Fujitsu H760
         [f9a703a54d16ba2470391c4b12236ee56591d50c]

Max Schulze (1):
      USB: serial: simple: add Motorola Tetra TPG2200 device id
         [b81c2c33eab79dfd3650293b2227ee5c6036585c]

Michael Straube (1):
      staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1
         [5f74a8cbb38d10615ed46bc3e37d9a4c9af8045a]

Miklos Szeredi (2):
      fuse: decrement NR_WRITEBACK_TEMP on the right page
         [a2ebba824106dabe79937a9f29a875f837e1b6d4]
      fuse: handle zero sized retrieve correctly
         [97e1532ef81acb31c30f9e75bf00306c33a77812]

Naoya Horiguchi (1):
      mm: hwpoison: use do_send_sig_info() instead of force_sig()
         [6376360ecbe525a9c17b3d081dfd88ba3e4ed65b]

Nathan Sullivan (1):
      net/phy: micrel: Add workaround for bad autoneg
         [d2fd719bcb0e83cb39cfee22ee800f98a56eceb3]

Naveen N. Rao (1):
      powerpc/signal: Properly handle return value from uprobe_deny_signal()
         [46725b17f1c6c815a41429259b3f070c01e71bc1]

Nicolas Pitre (2):
      vt: always call notifier with the console lock held
         [7e1d226345f89ad5d0216a9092c81386c89b4983]
      vt: invoke notifier on screen size change
         [0c9b1965faddad7534b6974b5b36c4ad37998f8e]

Nikos Tsironis (1):
      dm thin: fix bug where bio that overwrites thin block ignores FUA
         [4ae280b4ee3463fa57bbe6eede26b97daff8a0f1]

Oleg Nesterov (1):
      mm/mmap.c: expand_downwards: don't require the gap if !vm_prev
         [32e4e6d5cbb0c0e427391635991fe65e17797af8]

Oliver Hartkopp (1):
      can: bcm: check timer values before ktime conversion
         [93171ba6f1deffd82f381d36cb13177872d023f6]

Pablo Neira Ayuso (2):
      netfilter: nf_tables: fix flush after rule deletion in the same batch
         [23b7ca4f745f21c2b9cfcb67fdd33733b3ae7e66]
      netfilter: nft_compat: use-after-free when deleting targets
         [753c111f655e38bbd52fc01321266633f022ebe2]

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time
         [225d9464268599a5b4d094d02ec17808e44c7553]

Paul Elder (1):
      usb: gadget: musb: fix short isoc packets with inventra dma
         [c418fd6c01fbc5516a2cd1eaf1df1ec86869028a]

Paul Fulghum (1):
      tty/n_hdlc: fix __might_sleep warning
         [fc01d8c61ce02c034e67378cd3e645734bc18c8c]

Paul Moore (1):
      netlabel: fix out-of-bounds memory accesses
         [5578de4834fe0f2a34fedc7374be691443396d1f]

Pavel Shilovsky (3):
      CIFS: Do not consider -ENODATA as stat failure for reads
         [082aaa8700415f6471ec9c5ef0c8307ca214989a]
      CIFS: Do not count -ENODATA as failure for query directory
         [8e6e72aeceaaed5aeeb1cb43d3085de7ceb14f79]
      CIFS: Do not hide EINTR after sending network packets
         [ee13919c2e8d1f904e035ad4b4239029a8994131]

Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data
         [ba16adeb346387eb2d1ada69003588be96f098fa]

Peter Zijlstra (1):
      perf/core: Fix perf_event_open() vs. execve() race
         [79c9ce57eb2d5f1497546a3946b4ae21b6fdc438]

Rajasingh Thavamani (1):
      net: phy: Micrel KSZ8061: link failure after cable connect
         [232ba3a51cc224b339c7114888ed7f0d4d95695e]

Richard Weinberger (28):
      Clean up signal_delivered()
         [10b1c7ac8bfed429cf3dcb0225482c8dc1485d8e]
      Rip out get_signal_to_deliver()
         [828b1f65d23cf8a68795739f6dd08fc8abd9ee64]
      arc: Use get_signal() signal_setup_done()
         [f6dd2a3f1f8d8df640cfa2d60f85c0b818af1593]
      arm64: Use get_signal() signal_setup_done()
         [00554fa4f80279db92f82c4f52c8ae72711f173e]
      avr32: Use get_signal() signal_setup_done()
         [d809709a8845954a95c2ac86c13bd0dfd549c1ae]
      blackfin: Use get_signal() signal_setup_done()
         [1270cff147a39f7da5b25225dca6ca3132ca6130]
      c6x: Use get_signal() signal_setup_done()
         [e19c025bc9a184ed9c5daf06ffb89abc81d1696a]
      cris: Use get_signal() signal_setup_done()
         [fa0197722eb7559a6a9733881bbb8d9e76364f33]
      frv: Use get_signal() signal_setup_done()
         [720f36b983224ac52b6acdd8b646ce30f6b38763]
      hexagon: Use get_signal() signal_setup_done()
         [ac443624490f7033aefd06713e7761aee5977de3]
      ia64: Use get_signal() signal_setup_done()
         [98c20309b97fc30001adf643cf876125f334fd8a]
      m32r: Use get_signal() signal_setup_done()
         [0f5bef660a7c3b030eb60ceb29e3b2d89f894f56]
      m68k: Use get_signal() signal_setup_done()
         [0d97500d393012690f3579056629bea0369e6554]
      microblaze: Use get_signal() signal_setup_done()
         [9c53c7ec14a5738ae3117d7d71b7abf630526c9f]
      mips: Use get_signal() signal_setup_done()
         [81d103bf80678669c56658185e758fc3f9845d71]
      mips: Use sigsp()
         [7c4f563507c33ca97dcfbd62dba1e9232575d499]
      mn10300: Use get_signal() signal_setup_done()
         [8b166553a9aaf39774bc22f5e93c965584303929]
      parisc: Use get_signal() signal_setup_done()
         [e4dc894b61776733629b24507031dd46f5ba5efc]
      powerpc: Use get_signal() signal_setup_done()
         [129b69df9c9074750245fca8aa92df5cc1a86ef4]
      powerpc: Use sigsp()
         [059ade650ae57cfd371af690fdba887af04aded8]
      s390: Use get_signal() signal_setup_done()
         [067bf2d4d3a7aedc5982f6a58716054e5004b801]
      score: Use get_signal() signal_setup_done()
         [2bb12b773feb3e792145961e57ab356e6134d4a5]
      sh: Use get_signal() signal_setup_done()
         [b46e848768acc458ba94feef162b8901592dbb9c]
      tile: Use get_signal() signal_setup_done()
         [b3707c7ed013d36752272ca2f9ed20dc8aed92e4]
      tracehook_signal_handler: Remove sig, info, ka and regs
         [df5601f9c3d831b4c478b004a1ed90a18643adbe]
      um: Use get_signal() signal_setup_done()
         [307627eebbb0bc41b21e74d78b932362a6c1b38d]
      unicore32: Use get_signal() signal_setup_done()
         [649671c90eaf3cbbd0cd03460b6a92c0b674a32e]
      xtensa: Use get_signal() signal_setup_done()
         [5bdb7611eb7987102f3c0fef1220dd64b6fbd9fd]

Ross Lagerwall (1):
      cifs: Fix potential OOB access of lock element array
         [b9a74cde94957d82003fb9f7ab4777938ca851cd]

Rundong Ge (1):
      net: dsa: slave: Don't propagate flag changes on down slave interfaces
         [17ab4f61b8cd6f9c38e9d0b935d86d73b5d0d2b5]

Russell King (1):
      ARM: iop32x/n2100: fix PCI IRQ mapping
         [db4090920ba2d61a5827a23e441447926a02ffee]

Sakari Ailus (1):
      media: v4l: ioctl: Validate num_planes for debug messages
         [7fe9f01c04c2673bd6662c35b664f0f91888b96f]

Samir Virmani (1):
      uart: Fix crash in uart_write and uart_put_char
         [aff9cf5955185d1f183227e46c5f8673fa483813]

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts
         [5c27ff5db1491a947264d6d4e4cbe43ae6535bae]

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets
         [491af60ffb848b59e82f7c9145833222e0bf27a5]

Shakeel Butt (1):
      mm, oom: fix use-after-free in oom_kill_process
         [cefc7ef3c87d02fc9307835868ff721ea12cc597]

Sheng Lan (1):
      net: netem: fix skb length BUG_ON in __skb_to_sgvec
         [5845f706388a4cde0f6b80f9e5d33527e942b7d9]

Shuah Khan (1):
      [media] media: em28xx-dvb - fix em28xx_dvb_resume() to not unregister i2c and dvb
         [6eb5e3399e8f45aa191ad21c0556bece8ea559f2]

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting
         [d358def706880defa4c9e87381c5bf086a97d5f9]

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error
         [4a8ef6999bce998fa5813023a9a6b56eea329dba]

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU page flush when detach device from a domain
         [9825bd94e3a2baae1f4874767ae3a7d4c049720e]

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
         [955d3411a17f590364238bd0d3329b61f20c1cd2]
      batman-adv: Force mac header to start of data on xmit
         [9114daa825fc3f335f9bea3313ce667090187280]

Takashi Iwai (2):
      ALSA: usb-audio: Always check descriptor sizes in parser code
         [3e96d7280f16e2f787307f695a31296b9e4a1cd7]
      ALSA: usb-audio: Avoid access before bLength check in build_audio_procunit()
         [f4351a199cc120ff9d59e06d02e8657d08e6cc46]

Thomas Hellstrom (2):
      drm/vmwgfx: Fix setting of dma masks
         [4cbfa1e6c09e98450aab3240e5119b0ab2c9795b]
      drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user
         [728354c005c36eaf44b6e5552372b67e60d17f56]

Thomas Richter (1):
      perf test: Fix failure of 'evsel-tp-sched' test on s390
         [03d309711d687460d1345de8a0363f45b1c8cd11]

Tina Zhang (1):
      drm/modes: Prevent division by zero htotal
         [a2fcd5c84f7a7825e028381b10182439067aa90d]

Vineet Gupta (2):
      ARC: mm: do_page_fault fixes #1: relinquish mmap_sem if signal arrives while handle_mm_fault
         [4d447455e73b47c43dd35fcc38ed823d3182a474]
      ARC: show_regs: lockdep: avoid page allocator...
         [ab6c03676cb190156603cf4c5ecf97aa406c9c53]

Vitaly Kuznetsov (1):
      x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only when it is available
         [6b1971c694975e49af302229202c0043568b1791]

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure
         [a01421e4484327fe44f8e126793ed5a48a221e24]

Waiman Long (1):
      fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache_sb()
         [1dbd449c9943e3145148cc893c2461b72ba6fef0]

Willem de Bruijn (2):
      packet: validate address length
         [99137b7888f4058087895d035d81c6b2d31015c5]
      packet: validate address length if non-zero
         [6b8d95f1795c42161dc0984b6863e95d6acf24ed]

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus value
         [6ebec961d59bccf65d08b13fc1ad4e6272a89338]

YueHaibing (2):
      mdio_bus: Fix use-after-free on device_register fails
         [6ff7b060535e87c2ae14dd8548512abfdda528fb]
      net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails
         [58bdd544e2933a21a51eecf17c3f5f94038261b5]

YunQiang Su (1):
      Disable MSI also when pcie-octeon.pcie_disable on
         [a214720cbf50cd8c3f76bbb9c3f5c283910e9d33]

Yunjian Wang (1):
      net: bridge: Fix ethernet header pointer before check skb forwardable
         [28c1382fa28f2e2d9d0d6f25ae879b5af2ecbd03]

Zach Brown (1):
      net/phy: micrel: configure intterupts after autoneg workaround
         [b866203d872d5deeafcecd25ea429d6748b5bd56]

Zheng Yan (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list
         [04242ff3ac0abbaa4362f97781dac268e6c3541a]

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue
         [e75913c93f7cd5f338ab373c34c93a655bd309cb]

 Makefile                                           |   4 +-
 arch/alpha/mm/fault.c                              |   2 +-
 arch/arc/kernel/head.S                             |   4 +-
 arch/arc/kernel/setup.c                            |  88 ++++++++++----
 arch/arc/kernel/signal.c                           |  39 +++---
 arch/arc/kernel/troubleshoot.c                     |  27 ++---
 arch/arc/mm/fault.c                                |  13 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   4 +-
 arch/arm/mach-iop32x/n2100.c                       |   3 +-
 arch/arm/plat-pxa/ssp.c                            |   3 -
 arch/arm64/include/asm/signal32.h                  |  11 +-
 arch/arm64/kernel/signal.c                         |  48 ++++----
 arch/arm64/kernel/signal32.c                       |  14 +--
 arch/avr32/kernel/signal.c                         |  43 +++----
 arch/blackfin/kernel/signal.c                      |  39 +++---
 arch/c6x/kernel/signal.c                           |  43 +++----
 arch/cris/arch-v10/kernel/signal.c                 |  79 +++++-------
 arch/cris/arch-v32/kernel/signal.c                 |  77 +++++-------
 arch/frv/kernel/signal.c                           |  99 +++++++--------
 arch/hexagon/kernel/signal.c                       |  45 +++----
 arch/ia64/kernel/signal.c                          |  46 ++++---
 arch/m32r/kernel/signal.c                          |  47 ++++----
 arch/m68k/kernel/signal.c                          |  63 ++++------
 arch/microblaze/kernel/signal.c                    |  48 +++-----
 arch/mips/include/asm/abi.h                        |  10 +-
 arch/mips/kernel/process.c                         |   7 +-
 arch/mips/kernel/signal-common.h                   |   2 +-
 arch/mips/kernel/signal.c                          |  72 +++++------
 arch/mips/kernel/signal32.c                        |  39 +++---
 arch/mips/kernel/signal_n32.c                      |  20 ++--
 arch/mips/pci/msi-octeon.c                         |   4 +-
 arch/mips/pci/pci-octeon.c                         |  10 +-
 arch/mn10300/kernel/signal.c                       |  89 ++++++--------
 arch/parisc/kernel/signal.c                        |  58 ++++-----
 arch/powerpc/kernel/signal.c                       |  41 ++-----
 arch/powerpc/kernel/signal.h                       |  14 +--
 arch/powerpc/kernel/signal_32.c                    |  36 +++---
 arch/powerpc/kernel/signal_64.c                    |  28 ++---
 arch/s390/include/asm/mmu_context.h                |  12 +-
 arch/s390/kernel/compat_signal.c                   |  79 ++++++------
 arch/s390/kernel/early.c                           |   4 +-
 arch/s390/kernel/entry.h                           |   4 +-
 arch/s390/kernel/setup.c                           |   2 +
 arch/s390/kernel/signal.c                          |  78 +++++-------
 arch/s390/kernel/smp.c                             |   4 +
 arch/score/kernel/signal.c                         |  43 +++----
 arch/sh/kernel/signal_32.c                         |  79 +++++-------
 arch/sh/kernel/signal_64.c                         |  82 +++++--------
 arch/tile/include/asm/compat.h                     |   3 +-
 arch/tile/kernel/compat_signal.c                   |  29 ++---
 arch/tile/kernel/signal.c                          |  54 ++++-----
 arch/um/include/shared/frame_kern.h                |  12 +-
 arch/um/kernel/signal.c                            |  27 ++---
 arch/unicore32/kernel/signal.c                     |  51 ++++----
 arch/x86/boot/compressed/aslr.c                    |   4 +-
 arch/x86/ia32/ia32_aout.c                          |   6 +-
 arch/x86/include/asm/uaccess.h                     |   7 +-
 arch/x86/kernel/cpu/perf_event.c                   |   9 ++
 arch/x86/kernel/cpu/perf_event.h                   |  21 ++++
 arch/x86/kernel/cpu/perf_event_intel.c             |   9 ++
 arch/x86/kernel/cpu/perf_event_intel_uncore.c      |   4 +-
 arch/x86/kvm/vmx.c                                 |   7 +-
 arch/x86/kvm/x86.c                                 |   3 +-
 arch/x86/um/signal.c                               |  45 ++++---
 arch/xtensa/kernel/signal.c                        |  43 +++----
 crypto/authenc.c                                   |  14 ++-
 drivers/acpi/power.c                               |  22 ++++
 drivers/ata/libata-core.c                          |   1 +
 drivers/block/rbd.c                                |   9 +-
 drivers/char/Kconfig                               |   2 +-
 drivers/char/ipmi/ipmi_msghandler.c                |   6 +
 drivers/char/mwave/mwavedd.c                       |   7 ++
 drivers/dma/bcm2835-dma.c                          | 124 +++++++++++--------
 drivers/dma/dmatest.c                              |  30 ++---
 drivers/dma/imx-dma.c                              |   8 +-
 drivers/gpu/drm/drm_fb_helper.c                    | 133 ++++++++++++---------
 drivers/gpu/drm/drm_modes.c                        |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   2 +-
 drivers/hv/hyperv_vmbus.h                          |   5 +-
 drivers/hv/ring_buffer.c                           |  31 +++--
 drivers/hv/vmbus_drv.c                             |  91 +++++++++-----
 drivers/i2c/busses/i2c-cadence.c                   |   9 +-
 drivers/i2c/i2c-dev.c                              |   6 +
 drivers/infiniband/ulp/ipoib/ipoib.h               |   1 -
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   3 +-
 drivers/input/misc/bma150.c                        |   9 +-
 drivers/input/mouse/elantech.c                     |  23 ++++
 drivers/iommu/amd_iommu.c                          |  15 ++-
 drivers/md/dm-thin.c                               |  55 ++++++++-
 drivers/media/usb/em28xx/em28xx-dvb.c              |  20 +---
 drivers/media/v4l2-core/v4l2-ioctl.c               |   4 +-
 drivers/mfd/ab8500-core.c                          |   2 +-
 drivers/mfd/tps6586x.c                             |  24 ++++
 drivers/mmc/host/mmc_spi.c                         |   1 +
 drivers/mmc/host/tmio_mmc_pio.c                    |   8 +-
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |  13 +-
 drivers/net/can/dev.c                              |  27 ++---
 drivers/net/ethernet/marvell/skge.c                |   6 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c            |  68 +++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  22 ++--
 drivers/net/phy/mdio_bus.c                         |   1 -
 drivers/net/phy/micrel.c                           |  41 ++++++-
 drivers/net/team/team.c                            |  27 +----
 drivers/net/vxlan.c                                |  13 +-
 drivers/net/wireless/brcm80211/brcmfmac/bcdc.c     |  29 ++---
 drivers/net/wireless/brcm80211/brcmfmac/dhd.h      |   2 +-
 drivers/net/wireless/brcm80211/brcmfmac/dhd_bus.h  |   4 +-
 .../net/wireless/brcm80211/brcmfmac/dhd_linux.c    |  76 +++++++++---
 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c |  32 +++--
 drivers/net/wireless/brcm80211/brcmfmac/fweh.h     |  16 ++-
 drivers/net/wireless/brcm80211/brcmfmac/fwsignal.c |  11 +-
 drivers/net/wireless/brcm80211/brcmfmac/proto.h    |  18 ++-
 drivers/net/wireless/brcm80211/brcmfmac/usb.c      |   2 +-
 .../net/wireless/brcm80211/brcmfmac/wl_cfg80211.c  |   2 +
 drivers/s390/block/dasd_eckd.c                     |   8 ++
 drivers/s390/char/sclp_config.c                    |   2 +
 drivers/s390/net/qeth_core.h                       |   3 +-
 drivers/s390/net/qeth_core_main.c                  |  35 ++++--
 drivers/s390/net/qeth_l2_main.c                    |   7 +-
 drivers/s390/net/qeth_l3_main.c                    |   3 +
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |   4 +-
 drivers/scsi/isci/init.c                           |  14 +--
 drivers/scsi/libsas/sas_expander.c                 |   2 +
 drivers/scsi/sd.c                                  |   7 ++
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |   1 +
 drivers/tty/n_hdlc.c                               |   1 +
 drivers/tty/serial/serial_core.c                   |  12 +-
 drivers/tty/tty_io.c                               |   3 +-
 drivers/tty/vt/vt.c                                |   3 +-
 drivers/usb/class/cdc-acm.c                        |   7 ++
 drivers/usb/core/quirks.c                          |   3 +-
 drivers/usb/gadget/net2272.c                       |   2 +-
 drivers/usb/musb/musb_gadget.c                     |  13 +-
 drivers/usb/musb/musbhsdma.c                       |  21 ++--
 drivers/usb/phy/phy-am335x.c                       |   5 +-
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   2 +
 drivers/usb/serial/usb-serial-simple.c             |   3 +-
 drivers/usb/storage/scsiglue.c                     |   8 +-
 drivers/usb/storage/unusual_devs.h                 |  12 ++
 drivers/vfio/vfio_iommu_type1.c                    |  15 +++
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |   2 +
 fs/binfmt_elf.c                                    |   3 +-
 fs/ceph/snap.c                                     |   3 +-
 fs/cifs/file.c                                     |   8 +-
 fs/cifs/smb2file.c                                 |   4 +-
 fs/cifs/smb2pdu.c                                  |   6 +-
 fs/cifs/transport.c                                |   2 +-
 fs/dcache.c                                        |   6 +-
 fs/debugfs/inode.c                                 |   7 ++
 fs/fuse/dev.c                                      |   4 +-
 fs/fuse/file.c                                     |   2 +-
 fs/proc/task_mmu.c                                 |  22 +++-
 include/keys/user-type.h                           |   2 +-
 include/linux/perf_event.h                         |   5 +
 include/linux/sched.h                              |  21 ++++
 include/linux/signal.h                             |  15 +--
 include/linux/tracehook.h                          |   8 +-
 include/sound/compress_driver.h                    |   6 +-
 ipc/shm.c                                          |   4 +-
 kernel/events/core.c                               |  70 ++++++++---
 kernel/events/ring_buffer.c                        |   3 +
 kernel/signal.c                                    | 105 ++++++++++++----
 lib/assoc_array.c                                  |   8 +-
 mm/memory-failure.c                                |   3 +-
 mm/migrate.c                                       |   8 +-
 mm/mmap.c                                          |  24 ++--
 mm/oom_kill.c                                      |   8 ++
 mm/shmem.c                                         |  12 +-
 net/batman-adv/hard-interface.c                    |   4 +-
 net/batman-adv/soft-interface.c                    |   4 +
 net/bluetooth/l2cap_core.c                         |  83 ++++++++-----
 net/bridge/br_forward.c                            |  26 ++--
 net/can/bcm.c                                      |  27 +++++
 net/dsa/slave.c                                    |  13 +-
 net/ipv4/cipso_ipv4.c                              |   6 +-
 net/ipv6/addrconf.c                                |   3 +-
 net/ipv6/sit.c                                     |   3 +-
 net/l2tp/l2tp_core.c                               |   5 +-
 net/mac80211/tx.c                                  |   9 +-
 net/netfilter/nf_tables_api.c                      |   3 +
 net/netfilter/nft_compat.c                         | 120 +++++++++++--------
 net/nfc/llcp_commands.c                            |  20 ++++
 net/nfc/llcp_core.c                                |  24 +++-
 net/packet/af_packet.c                             |  12 +-
 net/sched/sch_netem.c                              |  10 +-
 net/vmw_vsock/vmci_transport.c                     |   4 +
 net/x25/af_x25.c                                   |  13 +-
 scripts/kallsyms.c                                 |   4 +-
 security/apparmor/apparmorfs.c                     |   1 +
 security/keys/key.c                                |   4 +-
 security/keys/keyring.c                            |   4 +-
 security/keys/proc.c                               |  11 +-
 security/keys/request_key.c                        |   1 +
 security/keys/request_key_auth.c                   |   2 +-
 security/yama/yama_lsm.c                           |   4 +-
 sound/pci/cs46xx/dsp_spos.c                        |   3 +
 sound/soc/codecs/tlv320aic32x4.c                   |   4 +
 sound/soc/intel/sst-mfld-platform-pcm.c            |   8 +-
 sound/usb/card.c                                   |   5 +
 sound/usb/mixer.c                                  |  10 +-
 sound/usb/pcm.c                                    |   9 +-
 sound/usb/quirks-table.h                           |   6 +
 sound/usb/stream.c                                 |  31 +++--
 tools/perf/tests/evsel-tp-sched.c                  |   8 +-
 206 files changed, 2364 insertions(+), 1834 deletions(-)

-- 
Ben Hutchings
Teamwork is essential - it allows you to blame someone else.

