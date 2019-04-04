Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC322C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6741A21741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfDDTDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:03:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33746 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729818AbfDDTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:03:20 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hC7dm-0006aQ-P7; Thu, 04 Apr 2019 20:03:17 +0100
Date:   Thu, 4 Apr 2019 20:03:10 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc:     lwn@lwn.net
Message-ID: <lsq.1554404557.476372446@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ov3su3gvsvvxachn"
Content-Disposition: inline
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Linux 3.16.65
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ov3su3gvsvvxachn
Content-Type: multipart/mixed; boundary="xvzyoln6y5yjpv3x"
Content-Disposition: inline


--xvzyoln6y5yjpv3x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.16.65 kernel.

All users of the 3.16 kernel series should upgrade.

The updated 3.16.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
=2Egit linux-3.16.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git

The diff from 3.16.64 is attached to this message.

Ben.

------------

 Documentation/filesystems/proc.txt                 |   1 -
 Documentation/vm/page_migration                    |  10 +-
 Documentation/vm/unevictable-lru.txt               | 120 ++++-------------=
----
 Makefile                                           |   2 +-
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
 arch/powerpc/kernel/signal_64.c                    |  47 ++++++--
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
 sound/pci/hda/hda_tegra.c                          |   1 +
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

Anand Jain (1):
      btrfs: dev-replace: go back to suspended state if target device is mi=
ssing

Arnaldo Carvalho de Melo (4):
      perf help: Remove needless use of strncpy()
      perf svghelper: Fix unchecked usage of strncpy()
      perf ui helpline: Use strlcpy() as a shorter form of strncpy() + expl=
icit set nul
      perf parse-events: Fix unchecked usage of strncpy()

Bart Van Assche (1):
      tools/lib/lockdep: Rename "trywlock" into "trywrlock"

Ben Hutchings (3):
      perf pmu: Suppress potential format-truncation warning
      Revert "cifs: empty TargetInfo leads to crash on recovery"
      Linux 3.16.65

Breno Leitao (3):
      powerpc/tm: Set MSR[TS] just prior to recheckpoint
      powerpc/tm: Unset MSR[TS] if not recheckpointing
      powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM

Chris Wilson (1):
      drm/i915/ringbuffer: Delay after EMIT_INVALIDATE for gen4/gen5

Christian Borntraeger (1):
      genwqe: Fix size check

Christoffer Dall (1):
      KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less

Colin Ian King (3):
      x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)
      pcrypt: use format specifier in kobject_add
      altera-stapl: check for a null key before strcasecmp'ing it

Dan Carpenter (4):
      wireless: airo: potential buffer overflow in sprintf()
      misc: vexpress: Off by one in vexpress_syscfg_exec()
      IB/qib: Fix an error code in qib_sdma_verbs_send()
      Input: nomadik-ske-keypad - fix a loop timeout test

Dmitry Monakhov (1):
      ext4: ext4_inline_data_fiemap should respect callers argument

Dmitry Safonov (1):
      tty/ldsem: Wake up readers after timed out down_write()

Dominique Martinet (1):
      9p/net: put a lower bound on msize

Eric Biggers (1):
      crypto: user - support incremental algorithm dumps

Eric Dumazet (1):
      net/hamradio/6pack: use mod_timer() to rearm timers

Filipe Manana (2):
      Btrfs: fix stale dir entries after unlink, inode eviction and fsync
      Btrfs: fix fsync of files with multiple hard links in new directories

Finn Thain (1):
      block/swim3: Fix -EBUSY error when re-opening device after unmount

Geert Uytterhoeven (10):
      pinctrl: sh-pfc: r8a7740: Add missing REF125CK pin to gether_gmii gro=
up
      pinctrl: sh-pfc: r8a7740: Add missing LCD0 marks to lcd0_data24_1 gro=
up
      pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b g=
roup
      pinctrl: sh-pfc: r8a7791: Remove bogus marks from vin1_b_data18 group
      pinctrl: sh-pfc: sh73a0: Add missing TO pin to tpu4_to3 group
      pinctrl: sh-pfc: sh7734: Add missing IPSR11 field
      pinctrl: sh-pfc: sh7264: Fix PFCR3 and PFCR0 register configuration
      pinctrl: sh-pfc: sh7269: Add missing PCIOR0 field
      pinctrl: sh-pfc: sh7734: Remove bogus IPSR10 value
      pinctrl: sh-pfc: sh7734: Fix shifted values in IPSR10

Georgy A Bystrenin (1):
      CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock p=
roblem

Gustavo A. R. Silva (4):
      ALSA: emux: Fix potential Spectre v1 vulnerabilities
      ALSA: pcm: Fix potential Spectre v1 vulnerability
      ALSA: rme9652: Fix potential Spectre v1 vulnerability
      ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities

Huacai Chen (2):
      MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
      MIPS: Align kernel load address to 64KB

Hugh Dickins (2):
      mm Documentation: undoc non-linear vmas
      mm: rmap use pte lock not mmap_sem to set PageMlocked

Jia-Ju Bai (1):
      usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66=
597_endpoint_disable()

Jim Mattson (2):
      kvm: vmx: Set IA32_TSC_AUX for legacy mode guests
      kvm: Disallow wraparound in kvm_gfn_to_hva_cache_init

Jiong Wang (1):
      mips: bpf: fix encoding bug for mm_srlv32_op

Jonas Gorski (1):
      MIPS: BCM63XX: fix switch core reset on BCM6368

Kai-Heng Feng (1):
      igb: Fix an issue that PME is not enabled during runtime suspend

Krzysztof Kozlowski (1):
      gpiolib: Fix return value of gpio_to_desc() stub if !GPIOLIB

Kyle Roeschley (1):
      ath6kl: Only use match sets when firmware supports it

Larry Finger (1):
      b43: Fix error in cordic routine

Laurent Pinchart (1):
      drm: rcar-du: Fix vblank initialization

Leon Romanovsky (1):
      net/mlx5: Continue driver initialization despite debugfs failure

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units

Maciej W. Rozycki (1):
      MIPS: SiByte: Enable ZONE_DMA32 for LittleSur

Macpaul Lin (1):
      cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Michael Ellerman (1):
      powerpc/configs: Don't enable PPC_EARLY_DEBUG in defconfigs

Michal Hocko (2):
      mm, memory_hotplug: do not clear numa_node association after hot_remo=
ve
      hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined

Mike Kravetz (1):
      mm: migration: fix migration of huge PMD shared pages

Noralf Tr=F8nnes (1):
      fbdev: fbcon: Fix unregister crash when more than one framebuffer

Pan Bian (1):
      f2fs: read page index before freeing

Paul Burton (1):
      MIPS: Expand MIPS32 ASIDs to 64 bits

Pavel Shilovsky (1):
      CIFS: Enable encryption during session setup phase

Peter Rosin (1):
      fbdev: fbmem: behave better with small rotated displays and many CPUs

Rasmus Villemoes (1):
      lib/string.c: remove duplicated function

Sameer Pujar (1):
      ALSA: hda/tegra: clear pending irq handlers

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sean Christopherson (1):
      KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup

Sergei Shtylyov (1):
      sata_rcar: fix deferred probing

Sergey Senozhatsky (1):
      panic: avoid deadlocks in re-entrant console drivers

Shivasharan S (1):
      scsi: megaraid_sas: Use 63-bit DMA addressing

Shrikrishna Khare (1):
      Driver: Vmxnet3: Fix regression caused by 5738a09

Stefan Agner (1):
      serial: imx: fix error handling in console_setup

Steffen Maier (1):
      scsi: zfcp: fix posting too many status read buffers leading to adapt=
er shutdown

Theodore Ts'o (8):
      ext4: include terminating u32 in size of xattr entries when expanding=
 inodes
      ext4: avoid declaring fs inconsistent due to invalid file handles
      ext4: force inode writes when nfsd calls commit_metadata()
      ext4: check for shutdown and r/o file system in ext4_write_inode()
      ext4: make sure enough credits are reserved for dioread_nolock writes
      ext4: fix a potential fiemap/page fault deadlock w/ inline_data
      ext4: avoid kernel warning when writing the superblock to a dead devi=
ce
      ext4: fix special inode number checks in __ext4_iget()

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Vasily Averin (6):
      dlm: fixed memory leaks after failed ls_remove_names allocation
      dlm: possible memory leak on error path in create_lkb()
      dlm: lost put_lkb on error path in receive_convert() and receive_unlo=
ck()
      dlm: memory leaks on error path in dlm_user_request()
      sunrpc: fix cache_head leak due to queued request
      sunrpc: use SVC_NET() in svcauth_gss_* functions

Yan, Zheng (1):
      ceph: don't update importing cap's mseq when handing cap export

Yang Dongsheng (1):
      Btrfs: fill ->last_trans for delayed inode in btrfs_fill_inode.

zhengbin (1):
      9p/net: fix memory leak in p9_client_create


--xvzyoln6y5yjpv3x
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.16.65.patch"
Content-Disposition: attachment; filename="linux-3.16.65.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems=
/proc.txt
index e9ad2244f7d7..238494cbf4cc 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -429,7 +429,6 @@ flags associated with the particular virtual memory are=
a in two letter encoded
     ac  - area is accountable
     nr  - swap space is not reserved for the area
     ht  - area uses huge tlb pages
-    nl  - non-linear mapping
     ar  - architecture specific flag
     dd  - do not include area into core dump
     sd  - soft-dirty flag
diff --git a/Documentation/vm/page_migration b/Documentation/vm/page_migrat=
ion
index 6513fe2d90b8..479c3d0329bd 100644
--- a/Documentation/vm/page_migration
+++ b/Documentation/vm/page_migration
@@ -99,12 +99,10 @@ is increased so that the page cannot be freed while pag=
e migration occurs.
 4. The new page is prepped with some settings from the old page so that
    accesses to the new page will discover a page with the correct settings.
=20
-5. All the page table references to the page are converted
-   to migration entries or dropped (nonlinear vmas).
-   This decrease the mapcount of a page. If the resulting
-   mapcount is not zero then we do not migrate the page.
-   All user space processes that attempt to access the page
-   will now wait on the page lock.
+5. All the page table references to the page are converted to migration
+   entries. This decreases the mapcount of a page. If the resulting
+   mapcount is not zero then we do not migrate the page. All user space
+   processes that attempt to access the page will now wait on the page loc=
k.
=20
 6. The radix tree lock is taken. This will cause all processes trying
    to access the page via the mapping to block on the radix tree spinlock.
diff --git a/Documentation/vm/unevictable-lru.txt b/Documentation/vm/unevic=
table-lru.txt
index 744f82f86c58..fdebbd42fba5 100644
--- a/Documentation/vm/unevictable-lru.txt
+++ b/Documentation/vm/unevictable-lru.txt
@@ -523,83 +523,20 @@ map.
=20
 try_to_unmap() is always called, by either vmscan for reclaim or for page
 migration, with the argument page locked and isolated from the LRU.  Separ=
ate
-functions handle anonymous and mapped file pages, as these types of pages =
have
-different reverse map mechanisms.
-
- (*) try_to_unmap_anon()
-
-     To unmap anonymous pages, each VMA in the list anchored in the anon_v=
ma
-     must be visited - at least until a VM_LOCKED VMA is encountered.  If =
the
-     page is being unmapped for migration, VM_LOCKED VMAs do not stop the
-     process because mlocked pages are migratable.  However, for reclaim, =
if
-     the page is mapped into a VM_LOCKED VMA, the scan stops.
-
-     try_to_unmap_anon() attempts to acquire in read mode the mmap semapho=
re of
-     the mm_struct to which the VMA belongs.  If this is successful, it wi=
ll
-     mlock the page via mlock_vma_page() - we wouldn't have gotten to
-     try_to_unmap_anon() if the page were already mlocked - and will return
-     SWAP_MLOCK, indicating that the page is unevictable.
-
-     If the mmap semaphore cannot be acquired, we are not sure whether the=
 page
-     is really unevictable or not.  In this case, try_to_unmap_anon() will
-     return SWAP_AGAIN.
-
- (*) try_to_unmap_file() - linear mappings
-
-     Unmapping of a mapped file page works the same as for anonymous mappi=
ngs,
-     except that the scan visits all VMAs that map the page's index/page o=
ffset
-     in the page's mapping's reverse map priority search tree.  It also vi=
sits
-     each VMA in the page's mapping's non-linear list, if the list is
-     non-empty.
-
-     As for anonymous pages, on encountering a VM_LOCKED VMA for a mapped =
file
-     page, try_to_unmap_file() will attempt to acquire the associated
-     mm_struct's mmap semaphore to mlock the page, returning SWAP_MLOCK if=
 this
-     is successful, and SWAP_AGAIN, if not.
-
- (*) try_to_unmap_file() - non-linear mappings
-
-     If a page's mapping contains a non-empty non-linear mapping VMA list,=
 then
-     try_to_un{map|lock}() must also visit each VMA in that list to determ=
ine
-     whether the page is mapped in a VM_LOCKED VMA.  Again, the scan must =
visit
-     all VMAs in the non-linear list to ensure that the pages is not/shoul=
d not
-     be mlocked.
-
-     If a VM_LOCKED VMA is found in the list, the scan could terminate.
-     However, there is no easy way to determine whether the page is actual=
ly
-     mapped in a given VMA - either for unmapping or testing whether the
-     VM_LOCKED VMA actually pins the page.
-
-     try_to_unmap_file() handles non-linear mappings by scanning a certain
-     number of pages - a "cluster" - in each non-linear VMA associated wit=
h the
-     page's mapping, for each file mapped page that vmscan tries to unmap.=
  If
-     this happens to unmap the page we're trying to unmap, try_to_unmap() =
will
-     notice this on return (page_mapcount(page) will be 0) and return
-     SWAP_SUCCESS.  Otherwise, it will return SWAP_AGAIN, causing vmscan to
-     recirculate this page.  We take advantage of the cluster scan in
-     try_to_unmap_cluster() as follows:
-
-	For each non-linear VMA, try_to_unmap_cluster() attempts to acquire the
-	mmap semaphore of the associated mm_struct for read without blocking.
-
-	If this attempt is successful and the VMA is VM_LOCKED,
-	try_to_unmap_cluster() will retain the mmap semaphore for the scan;
-	otherwise it drops it here.
-
-	Then, for each page in the cluster, if we're holding the mmap semaphore
-	for a locked VMA, try_to_unmap_cluster() calls mlock_vma_page() to
-	mlock the page.  This call is a no-op if the page is already locked,
-	but will mlock any pages in the non-linear mapping that happen to be
-	unlocked.
-
-	If one of the pages so mlocked is the page passed in to try_to_unmap(),
-	try_to_unmap_cluster() will return SWAP_MLOCK, rather than the default
-	SWAP_AGAIN.  This will allow vmscan to cull the page, rather than
-	recirculating it on the inactive list.
-
-	Again, if try_to_unmap_cluster() cannot acquire the VMA's mmap sem, it
-	returns SWAP_AGAIN, indicating that the page is mapped by a VM_LOCKED
-	VMA, but couldn't be mlocked.
+functions handle anonymous and mapped file and KSM pages, as these types of
+pages have different reverse map lookup mechanisms, with different locking.
+In each case, whether rmap_walk_anon() or rmap_walk_file() or rmap_walk_ks=
m(),
+it will call try_to_unmap_one() for every VMA which might contain the page.
+
+When trying to reclaim, if try_to_unmap_one() finds the page in a VM_LOCKED
+VMA, it will then mlock the page via mlock_vma_page() instead of unmapping=
 it,
+and return SWAP_MLOCK to indicate that the page is unevictable: and the sc=
an
+stops there.
+
+mlock_vma_page() is called while holding the page table's lock (in addition
+to the page lock, and the rmap lock): to serialize against concurrent mloc=
k or
+munlock or munmap system calls, mm teardown (munlock_vma_pages_all), recla=
im,
+holepunching, and truncation of file pages and their anonymous COWed pages.
=20
=20
 try_to_munlock() REVERSE MAP SCAN
@@ -615,29 +552,15 @@ all PTEs from the page.  For this purpose, the unevic=
table/mlock infrastructure
 introduced a variant of try_to_unmap() called try_to_munlock().
=20
 try_to_munlock() calls the same functions as try_to_unmap() for anonymous =
and
-mapped file pages with an additional argument specifying unlock versus unm=
ap
+mapped file and KSM pages with a flag argument specifying unlock versus un=
map
 processing.  Again, these functions walk the respective reverse maps looki=
ng
-for VM_LOCKED VMAs.  When such a VMA is found for anonymous pages and file
-pages mapped in linear VMAs, as in the try_to_unmap() case, the functions
-attempt to acquire the associated mmap semaphore, mlock the page via
-mlock_vma_page() and return SWAP_MLOCK.  This effectively undoes the
-pre-clearing of the page's PG_mlocked done by munlock_vma_page.
-
-If try_to_unmap() is unable to acquire a VM_LOCKED VMA's associated mmap
-semaphore, it will return SWAP_AGAIN.  This will allow shrink_page_list() =
to
-recycle the page on the inactive list and hope that it has better luck wit=
h the
-page next time.
-
-For file pages mapped into non-linear VMAs, the try_to_munlock() logic wor=
ks
-slightly differently.  On encountering a VM_LOCKED non-linear VMA that mig=
ht
-map the page, try_to_munlock() returns SWAP_AGAIN without actually mlockin=
g the
-page.  munlock_vma_page() will just leave the page unlocked and let vmscan=
 deal
-with it - the usual fallback position.
+for VM_LOCKED VMAs.  When such a VMA is found, as in the try_to_unmap() ca=
se,
+the functions mlock the page via mlock_vma_page() and return SWAP_MLOCK.  =
This
+undoes the pre-clearing of the page's PG_mlocked done by munlock_vma_page.
=20
 Note that try_to_munlock()'s reverse map walk must visit every VMA in a pa=
ge's
 reverse map to determine that a page is NOT mapped into any VM_LOCKED VMA.
-However, the scan can terminate when it encounters a VM_LOCKED VMA and can
-successfully acquire the VMA's mmap semaphore for read and mlock the page.
+However, the scan can terminate when it encounters a VM_LOCKED VMA.
 Although try_to_munlock() might be called a great many times when munlocki=
ng a
 large region or tearing down a large address space that has been mlocked v=
ia
 mlockall(), overall this is a fairly rare event.
@@ -665,11 +588,6 @@ would never see them.
  (3) mlocked pages that could not be isolated from the LRU and moved to the
      unevictable list in mlock_vma_page().
=20
- (4) Pages mapped into multiple VM_LOCKED VMAs, but try_to_munlock() could=
n't
-     acquire the VMA's mmap semaphore to test the flags and set PageMlocke=
d.
-     munlock_vma_page() was forced to let the page back on to the normal L=
RU
-     list for vmscan to handle.
-
 shrink_inactive_list() also diverts any unevictable pages that it finds on=
 the
 inactive lists to the appropriate zone's unevictable list.
=20
diff --git a/Makefile b/Makefile
index 5f9f8b3c9214..293d65674b4d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 16
-SUBLEVEL =3D 64
+SUBLEVEL =3D 65
 EXTRAVERSION =3D
 NAME =3D Museum of Fishiegoodies
=20
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 5dcac8df0a85..3bba53492d7a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -59,7 +59,7 @@ static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_=
vcpu);
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen =3D ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
-static DEFINE_RWLOCK(kvm_vmid_lock);
+static DEFINE_SPINLOCK(kvm_vmid_lock);
=20
 static bool vgic_present;
=20
@@ -376,7 +376,9 @@ void force_vm_exit(const cpumask_t *mask)
  */
 static bool need_new_vmid_gen(struct kvm *kvm)
 {
-	return unlikely(kvm->arch.vmid_gen !=3D atomic64_read(&kvm_vmid_gen));
+	u64 current_vmid_gen =3D atomic64_read(&kvm_vmid_gen);
+	smp_rmb(); /* Orders read of kvm_vmid_gen and kvm->arch.vmid */
+	return unlikely(ACCESS_ONCE(kvm->arch.vmid_gen) !=3D current_vmid_gen);
 }
=20
 /**
@@ -391,16 +393,11 @@ static void update_vttbr(struct kvm *kvm)
 {
 	phys_addr_t pgd_phys;
 	u64 vmid;
-	bool new_gen;
=20
-	read_lock(&kvm_vmid_lock);
-	new_gen =3D need_new_vmid_gen(kvm);
-	read_unlock(&kvm_vmid_lock);
-
-	if (!new_gen)
+	if (!need_new_vmid_gen(kvm))
 		return;
=20
-	write_lock(&kvm_vmid_lock);
+	spin_lock(&kvm_vmid_lock);
=20
 	/*
 	 * We need to re-check the vmid_gen here to ensure that if another vcpu
@@ -408,7 +405,7 @@ static void update_vttbr(struct kvm *kvm)
 	 * use the same vmid.
 	 */
 	if (!need_new_vmid_gen(kvm)) {
-		write_unlock(&kvm_vmid_lock);
+		spin_unlock(&kvm_vmid_lock);
 		return;
 	}
=20
@@ -431,7 +428,6 @@ static void update_vttbr(struct kvm *kvm)
 		kvm_call_hyp(__kvm_flush_vm_context);
 	}
=20
-	kvm->arch.vmid_gen =3D atomic64_read(&kvm_vmid_gen);
 	kvm->arch.vmid =3D kvm_next_vmid;
 	kvm_next_vmid++;
=20
@@ -441,7 +437,10 @@ static void update_vttbr(struct kvm *kvm)
 	vmid =3D ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
 	kvm->arch.vttbr =3D pgd_phys | vmid;
=20
-	write_unlock(&kvm_vmid_lock);
+	smp_wmb();
+	ACCESS_ONCE(kvm->arch.vmid_gen) =3D atomic64_read(&kvm_vmid_gen);
+
+	spin_unlock(&kvm_vmid_lock);
 }
=20
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4e238e6e661c..834de4754f00 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -633,6 +633,7 @@ config SIBYTE_LITTLESUR
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select ZONE_DMA32 if 64BIT
=20
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
diff --git a/arch/mips/bcm63xx/reset.c b/arch/mips/bcm63xx/reset.c
index acbeb1fe7c57..7feee13ce237 100644
--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -119,7 +119,7 @@
 #define BCM6368_RESET_DSL	0
 #define BCM6368_RESET_SAR	SOFTRESET_6368_SAR_MASK
 #define BCM6368_RESET_EPHY	SOFTRESET_6368_EPHY_MASK
-#define BCM6368_RESET_ENETSW	0
+#define BCM6368_RESET_ENETSW	SOFTRESET_6368_ENETSW_MASK
 #define BCM6368_RESET_PCM	SOFTRESET_6368_PCM_MASK
 #define BCM6368_RESET_MPI	SOFTRESET_6368_MPI_MASK
 #define BCM6368_RESET_PCIE	0
diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips=
/boot/compressed/calc_vmlinuz_load_addr.c
index 37fe58c19a90..542c3ede9722 100644
--- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -13,6 +13,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "../../../../include/linux/sizes.h"
=20
 int main(int argc, char *argv[])
 {
@@ -45,11 +46,11 @@ int main(int argc, char *argv[])
 	vmlinuz_load_addr =3D vmlinux_load_addr + vmlinux_size;
=20
 	/*
-	 * Align with 16 bytes: "greater than that used for any standard data
-	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
+	 * Align with 64KB: KEXEC needs load sections to be aligned to PAGE_SIZE,
+	 * which may be as large as 64KB depending on the kernel configuration.
 	 */
=20
-	vmlinuz_load_addr +=3D (16 - vmlinux_size % 16);
+	vmlinuz_load_addr +=3D (SZ_64K - vmlinux_size % SZ_64K);
=20
 	printf("0x%llx\n", vmlinuz_load_addr);
=20
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-i=
nfo.h
index c78f60977812..ff71c4c8b952 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -39,7 +39,7 @@ struct cache_desc {
 #define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
=20
 struct cpuinfo_mips {
-	unsigned long		asid_cache;
+	u64			asid_cache;
=20
 	/*
 	 * Capability and feature descriptor structure for MIPS CPU
diff --git a/arch/mips/include/asm/mmu.h b/arch/mips/include/asm/mmu.h
index c436138945a8..e1b7ce96bfdd 100644
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -2,7 +2,7 @@
 #define __ASM_MMU_H
=20
 typedef struct {
-	unsigned long asid[NR_CPUS];
+	u64 asid[NR_CPUS];
 	void *vdso;
 } mm_context_t;
=20
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index 2e373da5f8e9..d8299597f4e3 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -85,15 +85,15 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,=
 struct task_struct *tsk)
  *  All unused by hardware upper bits will be considered
  *  as a software asid extension.
  */
-#define ASID_VERSION_MASK  ((unsigned long)~(ASID_MASK|(ASID_MASK-1)))
-#define ASID_FIRST_VERSION ((unsigned long)(~ASID_VERSION_MASK) + 1)
+#define ASID_VERSION_MASK  (~(u64)(ASID_MASK | (ASID_MASK - 1)))
+#define ASID_FIRST_VERSION ((u64)(~ASID_VERSION_MASK) + 1)
=20
 /* Normal, classic MIPS get_new_mmu_context */
 static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 {
 	extern void kvm_local_flush_tlb_all(void);
-	unsigned long asid =3D asid_cache(cpu);
+	u64 asid =3D asid_cache(cpu);
=20
 	if (! ((asid +=3D ASID_INC) & ASID_MASK) ) {
 		if (cpu_has_vtag_icache)
@@ -103,8 +103,6 @@ get_new_mmu_context(struct mm_struct *mm, unsigned long=
 cpu)
 #else
 		local_flush_tlb_all();	/* start new asid cycle */
 #endif
-		if (!asid)		/* fix version if needed */
-			asid =3D ASID_FIRST_VERSION;
 	}
=20
 	cpu_context(cpu, mm) =3D asid_cache(cpu) =3D asid;
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgt=
able-64.h
index 1659bb91ae21..34abb62cf204 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -189,6 +189,11 @@ static inline int pmd_bad(pmd_t pmd)
=20
 static inline int pmd_present(pmd_t pmd)
 {
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
+		return pmd_val(pmd) & _PAGE_PRESENT;
+#endif
+
 	return pmd_val(pmd) !=3D (unsigned long) invalid_pte_table;
 }
=20
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm=
/inst.h
index 63ce61a77216..926defc455a7 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -262,8 +262,8 @@ enum mm_32a_minor_op {
 	mm_ext_op =3D 0x02c,
 	mm_pool32axf_op =3D 0x03c,
 	mm_srl32_op =3D 0x040,
+	mm_srlv32_op =3D 0x050,
 	mm_sra_op =3D 0x080,
-	mm_srlv32_op =3D 0x090,
 	mm_rotr_op =3D 0x0c0,
 	mm_lwxs_op =3D 0x118,
 	mm_addu32_op =3D 0x150,
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 135ec313c1f6..10ef55caba20 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -244,7 +244,7 @@ static void r3k_flush_cache_page(struct vm_area_struct =
*vma,
 	pmd_t *pmdp;
 	pte_t *ptep;
=20
-	pr_debug("cpage[%08lx,%08lx]\n",
+	pr_debug("cpage[%08llx,%08lx]\n",
 		 cpu_context(smp_processor_id(), mm), addr);
=20
 	/* No ASID =3D> no such page in the cache.  */
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_de=
fconfig
index 3c72fa615bd9..2fea9a1b6cba 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -283,7 +283,6 @@ CONFIG_DEBUG_MUTEXES=3Dy
 CONFIG_LATENCYTOP=3Dy
 CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
 CONFIG_BOOTX_TEXT=3Dy
-CONFIG_PPC_EARLY_DEBUG=3Dy
 CONFIG_PPC_EARLY_DEBUG_BOOTX=3Dy
 CONFIG_CRYPTO_NULL=3Dm
 CONFIG_CRYPTO_TEST=3Dm
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/ma=
ple_defconfig
index 95e545d9f25c..292ceb054887 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -137,7 +137,6 @@ CONFIG_DEBUG_STACK_USAGE=3Dy
 CONFIG_XMON=3Dy
 CONFIG_XMON_DEFAULT=3Dy
 CONFIG_BOOTX_TEXT=3Dy
-CONFIG_PPC_EARLY_DEBUG=3Dy
 CONFIG_PPC_EARLY_DEBUG_BOOTX=3Dy
 CONFIG_CRYPTO_ECB=3Dm
 CONFIG_CRYPTO_PCBC=3Dm
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/p=
mac32_defconfig
index 553e66278010..5c0a75a3c7d1 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -349,7 +349,6 @@ CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
 CONFIG_XMON=3Dy
 CONFIG_XMON_DEFAULT=3Dy
 CONFIG_BOOTX_TEXT=3Dy
-CONFIG_PPC_EARLY_DEBUG=3Dy
 CONFIG_PPC_EARLY_DEBUG_BOOTX=3Dy
 CONFIG_CRYPTO_NULL=3Dm
 CONFIG_CRYPTO_PCBC=3Dm
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/pp=
c64_defconfig
index f26b267eb71f..0d2e6dbdbc0c 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -339,7 +339,6 @@ CONFIG_FTR_FIXUP_SELFTEST=3Dy
 CONFIG_MSI_BITMAP_SELFTEST=3Dy
 CONFIG_XMON=3Dy
 CONFIG_BOOTX_TEXT=3Dy
-CONFIG_PPC_EARLY_DEBUG=3Dy
 CONFIG_CRYPTO_TEST=3Dm
 CONFIG_CRYPTO_PCBC=3Dm
 CONFIG_CRYPTO_HMAC=3Dy
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/p=
pc6xx_defconfig
index c91066944842..29cc48ee4f8f 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1261,7 +1261,6 @@ CONFIG_DEBUG_STACKOVERFLOW=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
 CONFIG_XMON=3Dy
 CONFIG_BOOTX_TEXT=3Dy
-CONFIG_PPC_EARLY_DEBUG=3Dy
 CONFIG_PPC_EARLY_DEBUG_BOOTX=3Dy
 CONFIG_KEYS=3Dy
 CONFIG_KEYS_DEBUG_PROC_KEYS=3Dy
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_3=
2.c
index fccd6261326a..90ec6856239b 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -882,7 +882,23 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	/* If TM bits are set to the reserved value, it's an invalid context */
 	if (MSR_TM_RESV(msr_hi))
 		return 1;
-	/* Pull in the MSR TM bits from the user context */
+
+	/*
+	 * Disabling preemption, since it is unsafe to be preempted
+	 * with MSR[TS] set without recheckpointing.
+	 */
+	preempt_disable();
+
+	/*
+	 * CAUTION:
+	 * After regs->MSR[TS] being updated, make sure that get_user(),
+	 * put_user() or similar functions are *not* called. These
+	 * functions can generate page faults which will cause the process
+	 * to be de-scheduled with MSR[TS] set but without calling
+	 * tm_recheckpoint(). This can cause a bug.
+	 *
+	 * Pull in the MSR TM bits from the user context
+	 */
 	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | (msr_hi & MSR_TS_MASK);
 	/* Now, recheckpoint.  This loads up all of the checkpointed (older)
 	 * registers, including FP and V[S]Rs.  After recheckpointing, the
@@ -906,6 +922,8 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	}
 #endif
=20
+	preempt_enable();
+
 	return 0;
 }
 #endif
@@ -1228,11 +1246,11 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r=
6, int r7, int r8,
 		     struct pt_regs *regs)
 {
 	struct rt_sigframe __user *rt_sf;
+	int tm_restore =3D 0;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	struct ucontext __user *uc_transact;
 	unsigned long msr_hi;
 	unsigned long tmp;
-	int tm_restore =3D 0;
 #endif
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn =3D do_no_restart_syscall;
@@ -1266,11 +1284,19 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r=
6, int r7, int r8,
 				goto bad;
 		}
 	}
-	if (!tm_restore)
-		/* Fall through, for non-TM restore */
+	if (!tm_restore) {
+		/*
+		 * Unset regs->msr because ucontext MSR TS is not
+		 * set, and recheckpoint was not called. This avoid
+		 * hitting a TM Bad thing at RFID
+		 */
+		regs->msr &=3D ~MSR_TS_MASK;
+	}
+	/* Fall through, for non-TM restore */
 #endif
-	if (do_setcontext(&rt_sf->uc, regs, 1))
-		goto bad;
+	if (!tm_restore)
+		if (do_setcontext(&rt_sf->uc, regs, 1))
+			goto bad;
=20
 	/*
 	 * It's not clear whether or why it is desirable to save the
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_6=
4.c
index 36a6bcb4ffdc..bfacb8290441 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -431,9 +431,6 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	if (MSR_TM_RESV(msr))
 		return -EINVAL;
=20
-	/* pull in MSR TM from user context */
-	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
-
 	/* pull in MSR LE from user context */
 	regs->msr =3D (regs->msr & ~MSR_LE) | (msr & MSR_LE);
=20
@@ -532,6 +529,25 @@ static long restore_tm_sigcontexts(struct pt_regs *reg=
s,
 	tm_enable();
 	/* Make sure the transaction is marked as failed */
 	current->thread.tm_texasr |=3D TEXASR_FS;
+
+	/*
+	 * Disabling preemption, since it is unsafe to be preempted
+	 * with MSR[TS] set without recheckpointing.
+	 */
+	preempt_disable();
+
+	/* pull in MSR TM from user context */
+	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
+
+	/*
+	 * CAUTION:
+	 * After regs->MSR[TS] being updated, make sure that get_user(),
+	 * put_user() or similar functions are *not* called. These
+	 * functions can generate page faults which will cause the process
+	 * to be de-scheduled with MSR[TS] set but without calling
+	 * tm_recheckpoint(). This can cause a bug.
+	 */
+
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&current->thread, msr);
=20
@@ -547,6 +563,8 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	}
 #endif
=20
+	preempt_enable();
+
 	return err;
 }
 #endif
@@ -689,12 +707,25 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long =
r4, unsigned long r5,
 		if (restore_tm_sigcontexts(regs, &uc->uc_mcontext,
 					   &uc_transact->uc_mcontext))
 			goto badframe;
-	}
-	else
-	/* Fall through, for non-TM restore */
+	} else
 #endif
-	if (restore_sigcontext(regs, NULL, 1, &uc->uc_mcontext))
-		goto badframe;
+	{
+		/*
+		 * Fall through, for non-TM restore
+		 *
+		 * Unset MSR[TS] on the thread regs since MSR from user
+		 * context does not have MSR active, and recheckpoint was
+		 * not called since restore_tm_sigcontexts() was not called
+		 * also.
+		 *
+		 * If not unsetting it, the code can RFID to userspace with
+		 * MSR[TS] set, but without CPU in the proper state,
+		 * causing a TM bad thing.
+		 */
+		current->thread.regs->msr &=3D ~MSR_TS_MASK;
+		if (restore_sigcontext(regs, NULL, 1, &uc->uc_mcontext))
+			goto badframe;
+	}
=20
 	if (restore_altstack(&uc->uc_stack))
 		goto badframe;
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 24e6e92cef86..e9eae4fbdde2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1041,7 +1041,7 @@ asmlinkage void kvm_spurious_fault(void);
 	"cmpb $0, kvm_rebooting \n\t"	      \
 	"jne 668b \n\t"      		      \
 	__ASM_SIZE(push) " $666b \n\t"	      \
-	"call kvm_spurious_fault \n\t"	      \
+	"jmp kvm_spurious_fault \n\t"	      \
 	".popsection \n\t" \
 	_ASM_EXTABLE(666b, 667b)
=20
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 70c3146fe6ca..f7a9c127e30d 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2077,9 +2077,6 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 		index =3D __find_msr_index(vmx, MSR_CSTAR);
 		if (index >=3D 0)
 			move_msr_up(vmx, index, save_nmsrs++);
-		index =3D __find_msr_index(vmx, MSR_TSC_AUX);
-		if (index >=3D 0 && vmx->rdtscp_enabled)
-			move_msr_up(vmx, index, save_nmsrs++);
 		/*
 		 * MSR_STAR is only needed on long mode guests, and only
 		 * if efer.sce is enabled.
@@ -2092,6 +2089,9 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 	index =3D __find_msr_index(vmx, MSR_EFER);
 	if (index >=3D 0 && update_transition_efer(vmx, index))
 		move_msr_up(vmx, index, save_nmsrs++);
+	index =3D __find_msr_index(vmx, MSR_TSC_AUX);
+	if (index >=3D 0 && vmx->rdtscp_enabled)
+		move_msr_up(vmx, index, save_nmsrs++);
=20
 	vmx->save_nmsrs =3D save_nmsrs;
=20
diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
index 526536c81ddc..ca1e8e6dccc8 100644
--- a/arch/x86/pci/broadcom_bus.c
+++ b/arch/x86/pci/broadcom_bus.c
@@ -50,8 +50,8 @@ static void __init cnb20le_res(u8 bus, u8 slot, u8 func)
 	word1 =3D read_pci_config_16(bus, slot, func, 0xc0);
 	word2 =3D read_pci_config_16(bus, slot, func, 0xc2);
 	if (word1 !=3D word2) {
-		res.start =3D (word1 << 16) | 0x0000;
-		res.end   =3D (word2 << 16) | 0xffff;
+		res.start =3D ((resource_size_t) word1 << 16) | 0x0000;
+		res.end   =3D ((resource_size_t) word2 << 16) | 0xffff;
 		res.flags =3D IORESOURCE_MEM;
 		update_res(info, res.start, res.end, res.flags, 0);
 	}
diff --git a/crypto/crypto_user.c b/crypto/crypto_user.c
index c571d85cfad7..0d651d87cd7c 100644
--- a/crypto/crypto_user.c
+++ b/crypto/crypto_user.c
@@ -226,30 +226,33 @@ static int crypto_report(struct sk_buff *in_skb, stru=
ct nlmsghdr *in_nlh,
=20
 static int crypto_dump_report(struct sk_buff *skb, struct netlink_callback=
 *cb)
 {
-	struct crypto_alg *alg;
+	const size_t start_pos =3D cb->args[0];
+	size_t pos =3D 0;
 	struct crypto_dump_info info;
-	int err;
-
-	if (cb->args[0])
-		goto out;
-
-	cb->args[0] =3D 1;
+	struct crypto_alg *alg;
+	int res;
=20
 	info.in_skb =3D cb->skb;
 	info.out_skb =3D skb;
 	info.nlmsg_seq =3D cb->nlh->nlmsg_seq;
 	info.nlmsg_flags =3D NLM_F_MULTI;
=20
+	down_read(&crypto_alg_sem);
 	list_for_each_entry(alg, &crypto_alg_list, cra_list) {
-		err =3D crypto_report_alg(alg, &info);
-		if (err)
-			goto out_err;
+		if (pos >=3D start_pos) {
+			res =3D crypto_report_alg(alg, &info);
+			if (res =3D=3D -EMSGSIZE)
+				break;
+			if (res)
+				goto out;
+		}
+		pos++;
 	}
-
+	cb->args[0] =3D pos;
+	res =3D skb->len;
 out:
-	return skb->len;
-out_err:
-	return err;
+	up_read(&crypto_alg_sem);
+	return res;
 }
=20
 static int crypto_dump_report_done(struct netlink_callback *cb)
@@ -478,7 +481,7 @@ static int crypto_user_rcv_msg(struct sk_buff *skb, str=
uct nlmsghdr *nlh)
 	if ((type =3D=3D (CRYPTO_MSG_GETALG - CRYPTO_MSG_BASE) &&
 	    (nlh->nlmsg_flags & NLM_F_DUMP))) {
 		struct crypto_alg *alg;
-		u16 dump_alloc =3D 0;
+		unsigned long dump_alloc =3D 0;
=20
 		if (link->dump =3D=3D NULL)
 			return -EINVAL;
@@ -486,16 +489,16 @@ static int crypto_user_rcv_msg(struct sk_buff *skb, s=
truct nlmsghdr *nlh)
 		down_read(&crypto_alg_sem);
 		list_for_each_entry(alg, &crypto_alg_list, cra_list)
 			dump_alloc +=3D CRYPTO_REPORT_MAXSIZE;
+		up_read(&crypto_alg_sem);
=20
 		{
 			struct netlink_dump_control c =3D {
 				.dump =3D link->dump,
 				.done =3D link->done,
-				.min_dump_alloc =3D dump_alloc,
+				.min_dump_alloc =3D min(dump_alloc, 65535UL),
 			};
 			err =3D netlink_dump_start(crypto_nlsk, skb, nlh, &c);
 		}
-		up_read(&crypto_alg_sem);
=20
 		return err;
 	}
diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index c305d4112735..a96de79498ee 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -440,7 +440,7 @@ static int pcrypt_sysfs_add(struct padata_instance *pin=
st, const char *name)
 	int ret;
=20
 	pinst->kobj.kset =3D pcrypt_kset;
-	ret =3D kobject_add(&pinst->kobj, NULL, name);
+	ret =3D kobject_add(&pinst->kobj, NULL, "%s", name);
 	if (!ret)
 		kobject_uevent(&pinst->kobj, KOBJ_ADD);
=20
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 8732e42db3a9..f7eaa3e5b787 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -874,7 +874,9 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	int ret =3D 0;
=20
 	irq =3D platform_get_irq(pdev, 0);
-	if (irq <=3D 0)
+	if (irq < 0)
+		return irq;
+	if (!irq)
 		return -EINVAL;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct sata_rcar_priv),
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 523ee8fd4c15..eaf1336623aa 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1027,7 +1027,11 @@ static void floppy_release(struct gendisk *disk, fmo=
de_t mode)
 	struct swim3 __iomem *sw =3D fs->swim3;
=20
 	mutex_lock(&swim3_mutex);
-	if (fs->ref_count > 0 && --fs->ref_count =3D=3D 0) {
+	if (fs->ref_count > 0)
+		--fs->ref_count;
+	else if (fs->ref_count =3D=3D -1)
+		fs->ref_count =3D 0;
+	if (fs->ref_count =3D=3D 0) {
 		swim3_action(fs, MOTOR_OFF);
 		out_8(&sw->control_bic, 0xff);
 		swim3_select(fs, RELAX);
diff --git a/drivers/gpu/drm/i915/intel_ringbuffer.c b/drivers/gpu/drm/i915=
/intel_ringbuffer.c
index b849fde1ea74..10d8771f8fc2 100644
--- a/drivers/gpu/drm/i915/intel_ringbuffer.c
+++ b/drivers/gpu/drm/i915/intel_ringbuffer.c
@@ -103,6 +103,7 @@ gen4_render_ring_flush(struct intel_engine_cs *ring,
 	struct drm_device *dev =3D ring->dev;
 	u32 cmd;
 	int ret;
+	int i;
=20
 	/*
 	 * read/write caches:
@@ -142,12 +143,47 @@ gen4_render_ring_flush(struct intel_engine_cs *ring,
 	    (IS_G4X(dev) || IS_GEN5(dev)))
 		cmd |=3D MI_INVALIDATE_ISP;
=20
-	ret =3D intel_ring_begin(ring, 2);
+	i =3D 2;
+	if (invalidate_domains & I915_GEM_DOMAIN_INSTRUCTION)
+		i +=3D 20;
+
+	ret =3D intel_ring_begin(ring, i);
 	if (ret)
 		return ret;
=20
 	intel_ring_emit(ring, cmd);
-	intel_ring_emit(ring, MI_NOOP);
+
+	/*
+	 * A random delay to let the CS invalidate take effect? Without this
+	 * delay, the GPU relocation path fails as the CS does not see
+	 * the updated contents. Just as important, if we apply the flushes
+	 * to the EMIT_FLUSH branch (i.e. immediately after the relocation
+	 * write and before the invalidate on the next batch), the relocations
+	 * still fail. This implies that is a delay following invalidation
+	 * that is required to reset the caches as opposed to a delay to
+	 * ensure the memory is written.
+	 */
+	if (invalidate_domains & I915_GEM_DOMAIN_INSTRUCTION) {
+		intel_ring_emit(ring, GFX_OP_PIPE_CONTROL(4) |
+				PIPE_CONTROL_QW_WRITE);
+		intel_ring_emit(ring, ring->scratch.gtt_offset |
+				PIPE_CONTROL_GLOBAL_GTT);
+		intel_ring_emit(ring, 0);
+		intel_ring_emit(ring, 0);
+
+		for (i =3D 0; i < 12; i++)
+			intel_ring_emit(ring, MI_FLUSH);
+
+		intel_ring_emit(ring, GFX_OP_PIPE_CONTROL(4) |
+				PIPE_CONTROL_QW_WRITE);
+		intel_ring_emit(ring, ring->scratch.gtt_offset |
+				PIPE_CONTROL_GLOBAL_GTT);
+		intel_ring_emit(ring, 0);
+		intel_ring_emit(ring, 0);
+	}
+
+	intel_ring_emit(ring, cmd);
+
 	intel_ring_advance(ring);
=20
 	return 0;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-d=
u/rcar_du_drv.c
index 792fd1d20e86..f3be7393334d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -89,7 +89,7 @@ static int rcar_du_load(struct drm_device *dev, unsigned =
long flags)
 	}
=20
 	/* vblank handling */
-	ret =3D drm_vblank_init(dev, (1 << rcdu->num_crtcs) - 1);
+	ret =3D drm_vblank_init(dev, rcdu->num_crtcs);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to initialize vblank\n");
 		goto done;
diff --git a/drivers/infiniband/hw/qib/qib_sdma.c b/drivers/infiniband/hw/q=
ib/qib_sdma.c
index c6d6a54d2e19..1c9a3e875201 100644
--- a/drivers/infiniband/hw/qib/qib_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_sdma.c
@@ -597,8 +597,10 @@ int qib_sdma_verbs_send(struct qib_pportdata *ppd,
 		dw =3D (len + 3) >> 2;
 		addr =3D dma_map_single(&ppd->dd->pcidev->dev, sge->vaddr,
 				      dw << 2, DMA_TO_DEVICE);
-		if (dma_mapping_error(&ppd->dd->pcidev->dev, addr))
+		if (dma_mapping_error(&ppd->dd->pcidev->dev, addr)) {
+			ret =3D -ENOMEM;
 			goto unmap;
+		}
 		sdmadesc[0] =3D 0;
 		make_sdma_desc(ppd, sdmadesc, (u64) addr, dw, dwoffset);
 		/* SDmaUseLargeBuf has to be set in every descriptor */
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/ke=
yboard/nomadik-ske-keypad.c
index 63332e2f8628..e07f88c9588f 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -100,7 +100,7 @@ static int __init ske_keypad_chip_init(struct ske_keypa=
d *keypad)
 	while ((readl(keypad->reg_base + SKE_RIS) !=3D 0x00000000) && timeout--)
 		cpu_relax();
=20
-	if (!timeout)
+	if (timeout =3D=3D -1)
 		return -EINVAL;
=20
 	/*
diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl=
/altera.c
index 24272e022bec..69e08013deb9 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2176,8 +2176,7 @@ static int altera_get_note(u8 *p, s32 program_size,
 			key_ptr =3D &p[note_strings +
 					get_unaligned_be32(
 					&p[note_table + (8 * i)])];
-			if ((strnicmp(key, key_ptr, strlen(key_ptr)) =3D=3D 0) &&
-						(key !=3D NULL)) {
+			if (key && !strncasecmp(key, key_ptr, strlen(key_ptr))) {
 				status =3D 0;
=20
 				value_ptr =3D &p[note_strings +
diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_ut=
ils.c
index 19dfacc37d76..bcde07267b95 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -206,7 +206,7 @@ u32 genwqe_crc32(u8 *buff, size_t len, u32 init)
 void *__genwqe_alloc_consistent(struct genwqe_dev *cd, size_t size,
 			       dma_addr_t *dma_handle)
 {
-	if (get_order(size) > MAX_ORDER)
+	if (get_order(size) >=3D MAX_ORDER)
 		return NULL;
=20
 	return pci_alloc_consistent(cd->pci_dev, size, dma_handle);
diff --git a/drivers/misc/vexpress-syscfg.c b/drivers/misc/vexpress-syscfg.c
index 3250fc1df0aa..26dc51990b55 100644
--- a/drivers/misc/vexpress-syscfg.c
+++ b/drivers/misc/vexpress-syscfg.c
@@ -61,7 +61,7 @@ static int vexpress_syscfg_exec(struct vexpress_syscfg_fu=
nc *func,
 	int tries;
 	long timeout;
=20
-	if (WARN_ON(index > func->num_templates))
+	if (WARN_ON(index >=3D func->num_templates))
 		return -EINVAL;
=20
 	command =3D readl(syscfg->base + SYS_CFGCTRL);
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/=
ibmveth.c
index 21978cc019e7..427a6674d237 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1059,11 +1059,15 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buf=
f *skb,
=20
 map_failed_frags:
 	last =3D i+1;
-	for (i =3D 0; i < last; i++)
+	for (i =3D 1; i < last; i++)
 		dma_unmap_page(&adapter->vdev->dev, descs[i].fields.address,
 			       descs[i].fields.flags_len & IBMVETH_BUF_LEN_MASK,
 			       DMA_TO_DEVICE);
=20
+	dma_unmap_single(&adapter->vdev->dev,
+			 descs[0].fields.address,
+			 descs[0].fields.flags_len & IBMVETH_BUF_LEN_MASK,
+			 DMA_TO_DEVICE);
 map_failed:
 	if (!firmware_has_feature(FW_FEATURE_CMO))
 		netdev_err(netdev, "tx: unable to map xmit buffer\n");
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethern=
et/intel/igb/igb_main.c
index 905328f3db86..4797faced343 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7419,9 +7419,11 @@ static int __igb_shutdown(struct pci_dev *pdev, bool=
 *enable_wake,
 	igb_clear_interrupt_scheme(adapter);
=20
 #ifdef CONFIG_PM
-	retval =3D pci_save_state(pdev);
-	if (retval)
-		return retval;
+	if (!runtime) {
+		retval =3D pci_save_state(pdev);
+		if (retval)
+			return retval;
+	}
 #endif
=20
 	status =3D rd32(E1000_STATUS);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/e=
thernet/mellanox/mlx5/core/main.c
index ee24f132e319..e53bb76856fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -313,9 +313,9 @@ int mlx5_dev_init(struct mlx5_core_dev *dev, struct pci=
_dev *pdev)
 	INIT_LIST_HEAD(&priv->pgdir_list);
 	spin_lock_init(&priv->mkey_lock);
=20
-	priv->dbg_root =3D debugfs_create_dir(dev_name(&pdev->dev), mlx5_debugfs_=
root);
-	if (!priv->dbg_root)
-		return -ENOMEM;
+	if (mlx5_debugfs_root)
+		priv->dbg_root =3D
+			debugfs_create_dir(pci_name(pdev), mlx5_debugfs_root);
=20
 	err =3D pci_enable_device(pdev);
 	if (err) {
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 66e2b19ef709..5e8aff812f20 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -551,12 +551,7 @@ static void resync_tnc(unsigned long channel)
=20
=20
 	/* Start resync timer again -- the TNC might be still absent */
-
-	del_timer(&sp->resync_t);
-	sp->resync_t.data	=3D (unsigned long) sp;
-	sp->resync_t.function	=3D resync_tnc;
-	sp->resync_t.expires	=3D jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
 }
=20
 static inline int tnc_init(struct sixpack *sp)
@@ -567,11 +562,7 @@ static inline int tnc_init(struct sixpack *sp)
=20
 	sp->tty->ops->write(sp->tty, &inbyte, 1);
=20
-	del_timer(&sp->resync_t);
-	sp->resync_t.data =3D (unsigned long) sp;
-	sp->resync_t.function =3D resync_tnc;
-	sp->resync_t.expires =3D jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
=20
 	return 0;
 }
@@ -654,6 +645,8 @@ static int sixpack_open(struct tty_struct *tty)
 	sp->tx_t.data =3D (unsigned long) sp;
=20
 	init_timer(&sp->resync_t);
+	sp->resync_t.function =3D resync_tnc;
+	sp->resync_t.data =3D (unsigned long) sp;
=20
 	spin_unlock_bh(&sp->lock);
=20
@@ -947,13 +940,8 @@ static void decode_prio_command(struct sixpack *sp, un=
signed char cmd)
         /* if the state byte has been received, the TNC is present,
            so the resync timer can be reset. */
=20
-	if (sp->tnc_state =3D=3D TNC_IN_SYNC) {
-		del_timer(&sp->resync_t);
-		sp->resync_t.data	=3D (unsigned long) sp;
-		sp->resync_t.function	=3D resync_tnc;
-		sp->resync_t.expires	=3D jiffies + SIXP_INIT_RESYNC_TIMEOUT;
-		add_timer(&sp->resync_t);
-	}
+	if (sp->tnc_state =3D=3D TNC_IN_SYNC)
+		mod_timer(&sp->resync_t, jiffies + SIXP_INIT_RESYNC_TIMEOUT);
=20
 	sp->status1 =3D cmd & SIXP_PRIO_DATA_MASK;
 }
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet=
3_drv.c
index f8996dd66368..e4f37a004805 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1308,9 +1308,9 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 				goto rcd_done;
 			}
 			new_dma_addr =3D dma_map_page(&adapter->pdev->dev,
-						rbi->page,
-						0, PAGE_SIZE,
-						PCI_DMA_FROMDEVICE);
+						    new_page,
+						    0, PAGE_SIZE,
+						    PCI_DMA_FROMDEVICE);
 			if (dma_mapping_error(&adapter->pdev->dev,
 					      new_dma_addr)) {
 				put_page(new_page);
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet=
3_int.h
index 10219fc9e38b..9282d0ecb1d8 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,12 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.2.2.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.2.3.0-k"
=20
 /* Each byte of this 32-bit integer encodes a version number in
  * VMXNET3_DRIVER_VERSION_STRING.
  */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01020200
+#define VMXNET3_DRIVER_VERSION_NUM      0x01020300
=20
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 64747d457bb3..4fedd4560951 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -5469,7 +5469,7 @@ static int proc_BSSList_open( struct inode *inode, st=
ruct file *file ) {
            we have to add a spin lock... */
 	rc =3D readBSSListRid(ai, doLoseSync, &BSSList_rid);
 	while(rc =3D=3D 0 && BSSList_rid.index !=3D cpu_to_le16(0xffff)) {
-		ptr +=3D sprintf(ptr, "%pM %*s rssi =3D %d",
+		ptr +=3D sprintf(ptr, "%pM %.*s rssi =3D %d",
 			       BSSList_rid.bssid,
 				(int)BSSList_rid.ssidLen,
 				BSSList_rid.ssid,
diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wirel=
ess/ath/ath6kl/cfg80211.c
index 0e26f4a34fda..438934108f25 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -930,7 +930,7 @@ static int ath6kl_set_probed_ssids(struct ath6kl *ar,
 		else
 			ssid_list[i].flag =3D ANY_SSID_FLAG;
=20
-		if (n_match_ssid =3D=3D 0)
+		if (ar->wiphy->max_match_sets !=3D 0 && n_match_ssid =3D=3D 0)
 			ssid_list[i].flag |=3D MATCH_SSID_FLAG;
 	}
=20
diff --git a/drivers/net/wireless/b43/phy_common.c b/drivers/net/wireless/b=
43/phy_common.c
index 08244b3b327e..f694cafef574 100644
--- a/drivers/net/wireless/b43/phy_common.c
+++ b/drivers/net/wireless/b43/phy_common.c
@@ -596,7 +596,7 @@ struct b43_c32 b43_cordic(int theta)
 	u8 i;
 	s32 tmp;
 	s8 signx =3D 1;
-	u32 angle =3D 0;
+	s32 angle =3D 0;
 	struct b43_c32 ret =3D { .i =3D 39797, .q =3D 0, };
=20
 	while (theta > (180 << 16))
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/=
pfc-r8a7740.c
index e4c1ef477053..22582c0e81c4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1987,7 +1987,7 @@ static const unsigned int gether_gmii_pins[] =3D {
 	 */
 	185, 186, 187, 188, 189, 190, 191, 192, 174, 161, 204,
 	171, 170, 169, 168, 167, 166, 173, 172, 176, 184, 183, 203,
-	205, 163, 206, 207,
+	205, 163, 206, 207, 158,
 };
 static const unsigned int gether_gmii_mux[] =3D {
 	ET_ERXD0_MARK, ET_ERXD1_MARK, ET_ERXD2_MARK, ET_ERXD3_MARK,
@@ -2159,6 +2159,7 @@ static const unsigned int lcd0_data24_1_mux[] =3D {
 	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
 	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
 	LCD0_D8_MARK, LCD0_D9_MARK, LCD0_D10_MARK, LCD0_D11_MARK,
+	LCD0_D12_MARK, LCD0_D13_MARK, LCD0_D14_MARK, LCD0_D15_MARK,
 	LCD0_D16_MARK, LCD0_D17_MARK, LCD0_D18_PORT163_MARK,
 	LCD0_D19_PORT162_MARK, LCD0_D20_PORT161_MARK, LCD0_D21_PORT158_MARK,
 	LCD0_D22_PORT160_MARK, LCD0_D23_PORT159_MARK,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/=
pfc-r8a7791.c
index 34dbfae48646..601a349f9cab 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -2656,8 +2656,7 @@ static const unsigned int qspi_data4_b_pins[] =3D {
 	RCAR_GP_PIN(6, 4),
 };
 static const unsigned int qspi_data4_b_mux[] =3D {
-	SPCLK_B_MARK, MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
-	IO2_B_MARK, IO3_B_MARK, SSL_B_MARK,
+	MOSI_IO0_B_MARK, MISO_IO1_B_MARK, IO2_B_MARK, IO3_B_MARK,
 };
 /* - SCIF0 ---------------------------------------------------------------=
--- */
 static const unsigned int scif0_data_pins[] =3D {
@@ -3786,17 +3785,14 @@ static const unsigned int vin1_b_data18_pins[] =3D {
 };
 static const unsigned int vin1_b_data18_mux[] =3D {
 	/* B */
-	VI1_DATA0_B_MARK, VI1_DATA1_B_MARK,
 	VI1_DATA2_B_MARK, VI1_DATA3_B_MARK,
 	VI1_DATA4_B_MARK, VI1_DATA5_B_MARK,
 	VI1_DATA6_B_MARK, VI1_DATA7_B_MARK,
 	/* G */
-	VI1_G0_B_MARK, VI1_G1_B_MARK,
 	VI1_G2_B_MARK, VI1_G3_B_MARK,
 	VI1_G4_B_MARK, VI1_G5_B_MARK,
 	VI1_G6_B_MARK, VI1_G7_B_MARK,
 	/* R */
-	VI1_R0_B_MARK, VI1_R1_B_MARK,
 	VI1_R2_B_MARK, VI1_R3_B_MARK,
 	VI1_R4_B_MARK, VI1_R5_B_MARK,
 	VI1_R6_B_MARK, VI1_R7_B_MARK,
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/p=
fc-sh7264.c
index e1cb6dc05028..c63506397309 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -1716,6 +1716,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs=
[] =3D {
 	},
=20
 	{ PINMUX_CFG_REG("PFCR3", 0xfffe38a8, 16, 4) {
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		PF12MD_000, PF12MD_001, 0, PF12MD_011,
 		PF12MD_100, PF12MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0 }
@@ -1759,8 +1762,10 @@ static const struct pinmux_cfg_reg pinmux_config_reg=
s[] =3D {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PF1MD_000, PF1MD_001, PF1MD_010, PF1MD_011,
 		PF1MD_100, PF1MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0
-	 }
+		0, 0, 0, 0, 0, 0, 0, 0,
+		PF0MD_000, PF0MD_001, PF0MD_010, PF0MD_011,
+		PF0MD_100, PF0MD_101, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0 }
 	},
=20
 	{ PINMUX_CFG_REG("PFIOR0", 0xfffe38b2, 16, 1) {
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/p=
fc-sh7269.c
index 7a11320ad96d..e1a662a56673 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -2119,7 +2119,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs=
[] =3D {
 	},
=20
 	{ PINMUX_CFG_REG("PCIOR0", 0xfffe3852, 16, 1) {
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		PC8_IN, PC8_OUT,
 		PC7_IN, PC7_OUT,
 		PC6_IN, PC6_OUT,
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/p=
fc-sh73a0.c
index ee370de4609a..29b7c79915f6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2676,6 +2676,7 @@ static const unsigned int tpu4_to2_mux[] =3D {
 };
 static const unsigned int tpu4_to3_pins[] =3D {
 	/* TO */
+	PIN_NUMBER(6, 26),
 };
 static const unsigned int tpu4_to3_mux[] =3D {
 	TPU4TO3_MARK,
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/p=
fc-sh7734.c
index e53dd1cb1625..d27ebd0e6ef0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2218,31 +2218,31 @@ static const struct pinmux_cfg_reg pinmux_config_re=
gs[] =3D {
 	    /* IP10_22 [1] */
 		FN_CAN_CLK_A, FN_RX4_D,
 	    /* IP10_21_19 [3] */
-		FN_AUDIO_CLKOUT, FN_TX1_E, FN_HRTS0_C, FN_FSE_B,
-		FN_LCD_M_DISP_B, 0, 0, 0,
+		FN_AUDIO_CLKOUT, FN_TX1_E, 0, FN_HRTS0_C, FN_FSE_B,
+		FN_LCD_M_DISP_B, 0, 0,
 	    /* IP10_18_16 [3] */
-		FN_AUDIO_CLKC, FN_SCK1_E, FN_HCTS0_C, FN_FRB_B,
-		FN_LCD_VEPWC_B, 0, 0, 0,
+		FN_AUDIO_CLKC, FN_SCK1_E, 0, FN_HCTS0_C, FN_FRB_B,
+		FN_LCD_VEPWC_B, 0, 0,
 	    /* IP10_15 [1] */
 		FN_AUDIO_CLKB_A, FN_LCD_CLK_B,
 	    /* IP10_14_12 [3] */
 		FN_AUDIO_CLKA_A, FN_VI1_CLK_B, FN_SCK1_D, FN_IECLK_B,
 		FN_LCD_FLM_B, 0, 0, 0,
 	    /* IP10_11_9 [3] */
-		FN_SSI_SDATA3, FN_VI1_7_B, FN_HTX0_C, FN_FWE_B,
-		FN_LCD_CL2_B, 0, 0, 0,
+		FN_SSI_SDATA3, FN_VI1_7_B, 0, FN_HTX0_C, FN_FWE_B,
+		FN_LCD_CL2_B, 0, 0,
 	    /* IP10_8_6 [3] */
-		FN_SSI_SDATA2, FN_VI1_6_B, FN_HRX0_C, FN_FRE_B,
-		FN_LCD_CL1_B, 0, 0, 0,
+		FN_SSI_SDATA2, FN_VI1_6_B, 0, FN_HRX0_C, FN_FRE_B,
+		FN_LCD_CL1_B, 0, 0,
 	    /* IP10_5_3 [3] */
 		FN_SSI_WS23, FN_VI1_5_B, FN_TX1_D, FN_HSCK0_C, FN_FALE_B,
-		FN_LCD_DON_B, 0, 0, 0,
+		FN_LCD_DON_B, 0, 0,
 	    /* IP10_2_0 [3] */
 		FN_SSI_SCK23, FN_VI1_4_B, FN_RX1_D, FN_FCLE_B,
 		FN_LCD_DATA15_B, 0, 0, 0 }
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xFFFC0048, 32,
-			3, 1, 2, 2, 2, 3, 3, 1, 2, 3, 3, 1, 1, 1, 1) {
+			3, 1, 2, 3, 2, 2, 3, 3, 1, 2, 3, 3, 1, 1, 1, 1) {
 	    /* IP11_31_29 [3] */
 	    0, 0, 0, 0, 0, 0, 0, 0,
 	    /* IP11_28 [1] */
diff --git a/drivers/power/olpc_battery.c b/drivers/power/olpc_battery.c
index 1ec810ada5ed..d41f0da27c98 100644
--- a/drivers/power/olpc_battery.c
+++ b/drivers/power/olpc_battery.c
@@ -425,14 +425,14 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 100 / 256;
+		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
 		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
 		if (ret)
 			return ret;
=20
-		val->intval =3D (int)be16_to_cpu(ec_word) * 100 / 256;
+		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index a7a0b3e4f5ea..2a4d40a1b2cf 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -275,16 +275,16 @@ static void zfcp_free_low_mem_buffers(struct zfcp_ada=
pter *adapter)
  */
 int zfcp_status_read_refill(struct zfcp_adapter *adapter)
 {
-	while (atomic_read(&adapter->stat_miss) > 0)
+	while (atomic_add_unless(&adapter->stat_miss, -1, 0))
 		if (zfcp_fsf_status_read(adapter->qdio)) {
+			atomic_inc(&adapter->stat_miss); /* undo add -1 */
 			if (atomic_read(&adapter->stat_miss) >=3D
 			    adapter->stat_read_buf_num) {
 				zfcp_erp_adapter_reopen(adapter, 0, "axsref1");
 				return 1;
 			}
 			break;
-		} else
-			atomic_dec(&adapter->stat_miss);
+		}
 	return 0;
 }
=20
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megar=
aid/megaraid_sas_base.c
index 55036079d074..9b66d42fa971 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4592,7 +4592,7 @@ megasas_set_dma_mask(struct pci_dev *pdev)
 	 * All our contollers are capable of performing 64-bit DMA
 	 */
 	if (IS_DMA64) {
-		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) !=3D 0) {
+		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(63)) !=3D 0) {
=20
 			if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) !=3D 0)
 				goto fail_set_dma_mask;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7450561a2326..21d8a5a02d05 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1777,7 +1777,7 @@ imx_console_setup(struct console *co, char *options)
=20
 	retval =3D clk_prepare(sport->clk_per);
 	if (retval)
-		clk_disable_unprepare(sport->clk_ipg);
+		clk_unprepare(sport->clk_ipg);
=20
 error_console:
 	return retval;
diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 0ffb0cbe2823..82544588797f 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -306,6 +306,16 @@ down_write_failed(struct ld_semaphore *sem, long count=
, long timeout)
 	if (!locked)
 		ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
 	list_del(&waiter.list);
+
+	/*
+	 * In case of timeout, wake up every reader who gave the right of way
+	 * to writer. Prevent separation readers into two groups:
+	 * one that helds semaphore and another that sleeps.
+	 * (in case of no contention with a writer)
+	 */
+	if (!locked && list_empty(&sem->write_wait))
+		__ldsem_wake_readers(sem);
+
 	raw_spin_unlock_irq(&sem->wait_lock);
=20
 	__set_task_state(tsk, TASK_RUNNING);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7109eeaa2288..447cbe6d75b0 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -499,6 +499,13 @@ static int acm_tty_install(struct tty_driver *driver, =
struct tty_struct *tty)
 	if (retval)
 		goto error_init_termios;
=20
+	/*
+	 * Suppress initial echoing for some devices which might send data
+	 * immediately after acm driver has been installed.
+	 */
+	if (acm->quirks & DISABLE_ECHO)
+		tty->termios.c_lflag &=3D ~ECHO;
+
 	tty->driver_data =3D acm;
=20
 	return 0;
@@ -1690,6 +1697,9 @@ static const struct usb_device_id acm_ids[] =3D {
 	{ USB_DEVICE(0x0e8d, 0x0003), /* FIREFLY, MediaTek Inc; andrey.arapov@gma=
il.com */
 	.driver_info =3D NO_UNION_NORMAL, /* has no union descriptor */
 	},
+	{ USB_DEVICE(0x0e8d, 0x2000), /* MediaTek Inc Preloader */
+	.driver_info =3D DISABLE_ECHO, /* DISABLE ECHO in termios flag */
+	},
 	{ USB_DEVICE(0x0e8d, 0x3329), /* MediaTek Inc GPS */
 	.driver_info =3D NO_UNION_NORMAL, /* has no union descriptor */
 	},
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index 6050d8e92c5e..b32afbd69dfd 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -135,3 +135,4 @@ struct acm {
 #define QUIRK_CONTROL_LINE_STATE	BIT(6)
 #define CLEAR_HALT_CONDITIONS		BIT(7)
 #define SEND_ZERO_PACKET		BIT(8)
+#define DISABLE_ECHO			BIT(9)
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hc=
d.c
index a9f12e382f2a..e8c6d5efb1b0 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -1990,6 +1990,8 @@ static int r8a66597_urb_dequeue(struct usb_hcd *hcd, =
struct urb *urb,
=20
 static void r8a66597_endpoint_disable(struct usb_hcd *hcd,
 				      struct usb_host_endpoint *hep)
+__acquires(r8a66597->lock)
+__releases(r8a66597->lock)
 {
 	struct r8a66597 *r8a66597 =3D hcd_to_r8a66597(hcd);
 	struct r8a66597_pipe *pipe =3D (struct r8a66597_pipe *)hep->hcpriv;
@@ -2002,13 +2004,14 @@ static void r8a66597_endpoint_disable(struct usb_hc=
d *hcd,
 		return;
 	pipenum =3D pipe->info.pipenum;
=20
+	spin_lock_irqsave(&r8a66597->lock, flags);
 	if (pipenum =3D=3D 0) {
 		kfree(hep->hcpriv);
 		hep->hcpriv =3D NULL;
+		spin_unlock_irqrestore(&r8a66597->lock, flags);
 		return;
 	}
=20
-	spin_lock_irqsave(&r8a66597->lock, flags);
 	pipe_stop(r8a66597, pipe);
 	pipe_irq_disable(r8a66597, pipenum);
 	disable_irq_empty(r8a66597, pipenum);
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 9c3b02e2011e..6028d9c98bb7 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -85,9 +85,14 @@ static const struct usb_device_id id_table[] =3D {
 	{ USB_DEVICE(YCCABLE_VENDOR_ID, YCCABLE_PRODUCT_ID) },
 	{ USB_DEVICE(SUPERIAL_VENDOR_ID, SUPERIAL_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM220_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM960_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LM920_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LM940_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_TD620_PRODUCT_ID) },
 	{ USB_DEVICE(CRESSI_VENDOR_ID, CRESSI_EDY_PRODUCT_ID) },
 	{ USB_DEVICE(ZEAGLE_VENDOR_ID, ZEAGLE_N2ITION3_PRODUCT_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_QN3USB_PRODUCT_ID) },
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index f379e00920bd..715d0ecd4eea 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -122,10 +122,15 @@
=20
 /* Hewlett-Packard POS Pole Displays */
 #define HP_VENDOR_ID		0x03f0
+#define HP_LM920_PRODUCT_ID	0x026b
+#define HP_TD620_PRODUCT_ID	0x0956
 #define HP_LD960_PRODUCT_ID	0x0b39
 #define HP_LCM220_PRODUCT_ID	0x3139
 #define HP_LCM960_PRODUCT_ID	0x3239
 #define HP_LD220_PRODUCT_ID	0x3524
+#define HP_LD220TA_PRODUCT_ID	0x4349
+#define HP_LD960TA_PRODUCT_ID	0x4439
+#define HP_LM940_PRODUCT_ID	0x5039
=20
 /* Cressi Edy (diving computer) PC interface */
 #define CRESSI_VENDOR_ID	0x04b8
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 57b1d44acbfe..948ce6af4a16 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3019,7 +3019,7 @@ static int fbcon_fb_unbind(int idx)
 	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++) {
 		if (con2fb_map[i] !=3D idx &&
 		    con2fb_map[i] !=3D -1) {
-			new_idx =3D i;
+			new_idx =3D con2fb_map[i];
 			break;
 		}
 	}
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 0b96e34647d2..3ce2d7101009 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -433,7 +433,9 @@ static void fb_do_show_logo(struct fb_info *info, struc=
t fb_image *image,
 			image->dx +=3D image->width + 8;
 		}
 	} else if (rotate =3D=3D FB_ROTATE_UD) {
-		for (x =3D 0; x < num; x++) {
+		u32 dx =3D image->dx;
+
+		for (x =3D 0; x < num && image->dx <=3D dx; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dx -=3D image->width + 8;
 		}
@@ -445,7 +447,9 @@ static void fb_do_show_logo(struct fb_info *info, struc=
t fb_image *image,
 			image->dy +=3D image->height + 8;
 		}
 	} else if (rotate =3D=3D FB_ROTATE_CCW) {
-		for (x =3D 0; x < num; x++) {
+		u32 dy =3D image->dy;
+
+		for (x =3D 0; x < num && image->dy <=3D dy; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dy -=3D image->height + 8;
 		}
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 43527fd78825..f14c0c8f0e93 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -143,6 +143,12 @@ struct btrfs_inode {
 	 */
 	u64 last_unlink_trans;
=20
+	/*
+	 * Track the transaction id of the last transaction used to create a
+	 * hard link for the inode. This is used by the log tree (fsync).
+	 */
+	u64 last_link_trans;
+
 	/*
 	 * Number of bytes outstanding that are going to need csums.  This is
 	 * used in ENOSPC accounting.
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 61f87c7edbb8..b7774c134c63 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1801,6 +1801,8 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 	set_nlink(inode, btrfs_stack_inode_nlink(inode_item));
 	inode_set_bytes(inode, btrfs_stack_inode_nbytes(inode_item));
 	BTRFS_I(inode)->generation =3D btrfs_stack_inode_generation(inode_item);
+        BTRFS_I(inode)->last_trans =3D btrfs_stack_inode_transid(inode_ite=
m);
+
 	inode->i_version =3D btrfs_stack_inode_sequence(inode_item);
 	inode->i_rdev =3D 0;
 	*rdev =3D btrfs_stack_inode_rdev(inode_item);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 28e15b6f13c7..7ee449d0da8a 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -782,6 +782,8 @@ int btrfs_resume_dev_replace_async(struct btrfs_fs_info=
 *fs_info)
 		btrfs_info(fs_info, "cannot continue dev_replace, tgtdev is missing");
 		btrfs_info(fs_info,
 			"you may cancel the operation after 'mount -o degraded'");
+		dev_replace->replace_state =3D
+					BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED;
 		btrfs_dev_replace_unlock(dev_replace);
 		return 0;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 67e036ccb63d..e597cc1c5d5b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3511,25 +3511,72 @@ static void btrfs_read_locked_inode(struct inode *i=
node)
 	BTRFS_I(inode)->generation =3D btrfs_inode_generation(leaf, inode_item);
 	BTRFS_I(inode)->last_trans =3D btrfs_inode_transid(leaf, inode_item);
=20
+	inode->i_version =3D btrfs_inode_sequence(leaf, inode_item);
+	inode->i_generation =3D BTRFS_I(inode)->generation;
+	inode->i_rdev =3D 0;
+	rdev =3D btrfs_inode_rdev(leaf, inode_item);
+
+	BTRFS_I(inode)->index_cnt =3D (u64)-1;
+	BTRFS_I(inode)->flags =3D btrfs_inode_flags(leaf, inode_item);
+
+cache_index:
 	/*
 	 * If we were modified in the current generation and evicted from memory
 	 * and then re-read we need to do a full sync since we don't have any
 	 * idea about which extents were modified before we were evicted from
 	 * cache.
+	 *
+	 * This is required for both inode re-read from disk and delayed inode
+	 * in delayed_nodes_tree.
 	 */
 	if (BTRFS_I(inode)->last_trans =3D=3D root->fs_info->generation)
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 			&BTRFS_I(inode)->runtime_flags);
=20
-	inode->i_version =3D btrfs_inode_sequence(leaf, inode_item);
-	inode->i_generation =3D BTRFS_I(inode)->generation;
-	inode->i_rdev =3D 0;
-	rdev =3D btrfs_inode_rdev(leaf, inode_item);
-
-	BTRFS_I(inode)->index_cnt =3D (u64)-1;
-	BTRFS_I(inode)->flags =3D btrfs_inode_flags(leaf, inode_item);
+	/*
+	 * We don't persist the id of the transaction where an unlink operation
+	 * against the inode was last made. So here we assume the inode might
+	 * have been evicted, and therefore the exact value of last_unlink_trans
+	 * lost, and set it to last_trans to avoid metadata inconsistencies
+	 * between the inode and its parent if the inode is fsync'ed and the log
+	 * replayed. For example, in the scenario:
+	 *
+	 * touch mydir/foo
+	 * ln mydir/foo mydir/bar
+	 * sync
+	 * unlink mydir/bar
+	 * echo 2 > /proc/sys/vm/drop_caches   # evicts inode
+	 * xfs_io -c fsync mydir/foo
+	 * <power failure>
+	 * mount fs, triggers fsync log replay
+	 *
+	 * We must make sure that when we fsync our inode foo we also log its
+	 * parent inode, otherwise after log replay the parent still has the
+	 * dentry with the "bar" name but our inode foo has a link count of 1
+	 * and doesn't have an inode ref with the name "bar" anymore.
+	 *
+	 * Setting last_unlink_trans to last_trans is a pessimistic approach,
+	 * but it guarantees correctness at the expense of ocassional full
+	 * transaction commits on fsync if our inode is a directory, or if our
+	 * inode is not a directory, logging its parent unnecessarily.
+	 */
+	BTRFS_I(inode)->last_unlink_trans =3D BTRFS_I(inode)->last_trans;
+	/*
+	 * Similar reasoning for last_link_trans, needs to be set otherwise
+	 * for a case like the following:
+	 *
+	 * mkdir A
+	 * touch foo
+	 * ln foo A/bar
+	 * echo 2 > /proc/sys/vm/drop_caches
+	 * fsync foo
+	 * <power failure>
+	 *
+	 * Would result in link bar and directory A not existing after the power
+	 * failure.
+	 */
+	BTRFS_I(inode)->last_link_trans =3D BTRFS_I(inode)->last_trans;
=20
-cache_index:
 	path->slots[0]++;
 	if (inode->i_nlink !=3D 1 ||
 	    path->slots[0] >=3D btrfs_header_nritems(leaf))
@@ -6151,6 +6198,7 @@ static int btrfs_link(struct dentry *old_dentry, stru=
ct inode *dir,
 			if (err)
 				goto fail;
 		}
+		BTRFS_I(inode)->last_link_trans =3D trans->transid;
 		d_instantiate(dentry, inode);
 		btrfs_log_new_name(trans, inode, NULL, parent);
 	}
@@ -8218,6 +8266,7 @@ struct inode *btrfs_alloc_inode(struct super_block *s=
b)
 	ei->index_cnt =3D (u64)-1;
 	ei->dir_index =3D 0;
 	ei->last_unlink_trans =3D 0;
+	ei->last_link_trans =3D 0;
 	ei->last_log_commit =3D 0;
=20
 	spin_lock_init(&ei->lock);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 63d9e0a784a1..f4e90842eb08 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4430,6 +4430,22 @@ static int btrfs_log_inode_parent(struct btrfs_trans=
_handle *trans,
 		goto end_trans;
 	}
=20
+	/*
+	 * If a new hard link was added to the inode in the current transaction
+	 * and its link count is now greater than 1, we need to fallback to a
+	 * transaction commit, otherwise we can end up not logging all its new
+	 * parents for all the hard links. Here just from the dentry used to
+	 * fsync, we can not visit the ancestor inodes for all the other hard
+	 * links to figure out if any is new, so we fallback to a transaction
+	 * commit (instead of adding a lot of complexity of scanning a btree,
+	 * since this scenario is not a common use case).
+	 */
+	if (inode->i_nlink > 1 &&
+	    BTRFS_I(inode)->last_link_trans > last_committed) {
+		ret =3D -EMLINK;
+		goto end_trans;
+	}
+
 	inode_only =3D LOG_INODE_EXISTS;
 	while (1) {
 		if (!parent || !parent->d_inode || sb !=3D parent->d_inode->i_sb)
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1fde164b74b5..ba864d7154a2 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2830,7 +2830,6 @@ static void handle_cap_export(struct inode *inode, st=
ruct ceph_mds_caps *ex,
 			tcap->cap_id =3D t_cap_id;
 			tcap->seq =3D t_seq - 1;
 			tcap->issue_seq =3D t_seq - 1;
-			tcap->mseq =3D t_mseq;
 			tcap->issued |=3D issued;
 			tcap->implemented |=3D issued;
 			if (cap =3D=3D ci->i_auth_cap)
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 7426b06741ce..d7218c16ba70 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -343,13 +343,12 @@ void build_ntlmssp_negotiate_blob(unsigned char *pbuf=
fer,
 	/* BB is NTLMV2 session security format easier to use here? */
 	flags =3D NTLMSSP_NEGOTIATE_56 |	NTLMSSP_REQUEST_TARGET |
 		NTLMSSP_NEGOTIATE_128 | NTLMSSP_NEGOTIATE_UNICODE |
-		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC;
-	if (ses->server->sign) {
+		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC |
+		NTLMSSP_NEGOTIATE_SEAL;
+	if (ses->server->sign)
 		flags |=3D NTLMSSP_NEGOTIATE_SIGN;
-		if (!ses->server->session_estab ||
-				ses->ntlmssp->sesskey_per_smbsess)
-			flags |=3D NTLMSSP_NEGOTIATE_KEY_XCH;
-	}
+	if (!ses->server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
+		flags |=3D NTLMSSP_NEGOTIATE_KEY_XCH;
=20
 	sec_blob->NegotiateFlags =3D cpu_to_le32(flags);
=20
@@ -412,13 +411,12 @@ int build_ntlmssp_auth_blob(unsigned char **pbuffer,
 	flags =3D NTLMSSP_NEGOTIATE_56 |
 		NTLMSSP_REQUEST_TARGET | NTLMSSP_NEGOTIATE_TARGET_INFO |
 		NTLMSSP_NEGOTIATE_128 | NTLMSSP_NEGOTIATE_UNICODE |
-		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC;
-	if (ses->server->sign) {
+		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC |
+		NTLMSSP_NEGOTIATE_SEAL;
+	if (ses->server->sign)
 		flags |=3D NTLMSSP_NEGOTIATE_SIGN;
-		if (!ses->server->session_estab ||
-				ses->ntlmssp->sesskey_per_smbsess)
-			flags |=3D NTLMSSP_NEGOTIATE_KEY_XCH;
-	}
+	if (!ses->server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
+		flags |=3D NTLMSSP_NEGOTIATE_KEY_XCH;
=20
 	tmp =3D *pbuffer + sizeof(AUTHENTICATE_MESSAGE);
 	sec_blob->NegotiateFlags =3D cpu_to_le32(flags);
diff --git a/fs/cifs/smb2maperror.c b/fs/cifs/smb2maperror.c
index a491814cb2c0..c28e3b946e6a 100644
--- a/fs/cifs/smb2maperror.c
+++ b/fs/cifs/smb2maperror.c
@@ -377,8 +377,8 @@ static const struct status_to_posix_error smb2_error_ma=
p_table[] =3D {
 	{STATUS_NONEXISTENT_EA_ENTRY, -EIO, "STATUS_NONEXISTENT_EA_ENTRY"},
 	{STATUS_NO_EAS_ON_FILE, -ENODATA, "STATUS_NO_EAS_ON_FILE"},
 	{STATUS_EA_CORRUPT_ERROR, -EIO, "STATUS_EA_CORRUPT_ERROR"},
-	{STATUS_FILE_LOCK_CONFLICT, -EIO, "STATUS_FILE_LOCK_CONFLICT"},
-	{STATUS_LOCK_NOT_GRANTED, -EIO, "STATUS_LOCK_NOT_GRANTED"},
+	{STATUS_FILE_LOCK_CONFLICT, -EACCES, "STATUS_FILE_LOCK_CONFLICT"},
+	{STATUS_LOCK_NOT_GRANTED, -EACCES, "STATUS_LOCK_NOT_GRANTED"},
 	{STATUS_DELETE_PENDING, -ENOENT, "STATUS_DELETE_PENDING"},
 	{STATUS_CTL_FILE_NOT_SUPPORTED, -ENOSYS,
 	"STATUS_CTL_FILE_NOT_SUPPORTED"},
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 7ae11fe72b11..6a5b70240a08 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -608,7 +608,6 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_ses=
 *ses,
 	 */
 	kfree(ses->auth_key.response);
 	ses->auth_key.response =3D NULL;
-	ses->auth_key.len =3D 0;
=20
 	/*
 	 * If memory allocation is successful, caller of this function
@@ -765,11 +764,8 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_se=
s *ses,
=20
 	if (!rc) {
 		mutex_lock(&server->srv_mutex);
-		if (server->sign && server->ops->generate_signingkey) {
+		if (server->ops->generate_signingkey) {
 			rc =3D server->ops->generate_signingkey(ses);
-			kfree(ses->auth_key.response);
-			ses->auth_key.response =3D NULL;
-			ses->auth_key.len =3D 0;
 			if (rc) {
 				cifs_dbg(FYI,
 					"SMB3 session key generation failed\n");
@@ -791,11 +787,6 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_se=
s *ses,
 	}
=20
 keygen_exit:
-	if (!server->sign) {
-		kfree(ses->auth_key.response);
-		ses->auth_key.response =3D NULL;
-		ses->auth_key.len =3D 0;
-	}
 	kfree(ses->ntlmssp);
=20
 	return rc;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 83f3d5520307..8680ffa0cad7 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1210,6 +1210,7 @@ static int create_lkb(struct dlm_ls *ls, struct dlm_l=
kb **lkb_ret)
=20
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
+		dlm_free_lkb(lkb);
 		return rv;
 	}
=20
@@ -4177,6 +4178,7 @@ static int receive_convert(struct dlm_ls *ls, struct =
dlm_message *ms)
 			  (unsigned long long)lkb->lkb_recover_seq,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error =3D -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
=20
@@ -4230,6 +4232,7 @@ static int receive_unlock(struct dlm_ls *ls, struct d=
lm_message *ms)
 			  lkb->lkb_id, lkb->lkb_remid,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error =3D -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
=20
@@ -5792,20 +5795,20 @@ int dlm_user_request(struct dlm_ls *ls, struct dlm_=
user_args *ua,
 			goto out;
 		}
 	}
-
-	/* After ua is attached to lkb it will be freed by dlm_free_lkb().
-	   When DLM_IFL_USER is set, the dlm knows that this is a userspace
-	   lock and that lkb_astparam is the dlm_user_args structure. */
-
 	error =3D set_lock_args(mode, &ua->lksb, flags, namelen, timeout_cs,
 			      fake_astfn, ua, fake_bastfn, &args);
-	lkb->lkb_flags |=3D DLM_IFL_USER;
-
 	if (error) {
+		kfree(ua->lksb.sb_lvbptr);
+		ua->lksb.sb_lvbptr =3D NULL;
+		kfree(ua);
 		__put_lkb(ls, lkb);
 		goto out;
 	}
=20
+	/* After ua is attached to lkb it will be freed by dlm_free_lkb().
+	   When DLM_IFL_USER is set, the dlm knows that this is a userspace
+	   lock and that lkb_astparam is the dlm_user_args structure. */
+	lkb->lkb_flags |=3D DLM_IFL_USER;
 	error =3D request_lock(ls, lkb, name, namelen, &args);
=20
 	switch (error) {
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index f3e72787e7f9..30e4e01db35a 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -673,11 +673,11 @@ static int new_lockspace(const char *name, const char=
 *cluster,
 	kfree(ls->ls_recover_buf);
  out_lkbidr:
 	idr_destroy(&ls->ls_lkbidr);
+ out_rsbtbl:
 	for (i =3D 0; i < DLM_REMOVE_NAMES_MAX; i++) {
 		if (ls->ls_remove_names[i])
 			kfree(ls->ls_remove_names[i]);
 	}
- out_rsbtbl:
 	vfree(ls->ls_rsbtbl);
  out_lsfree:
 	if (do_unreg)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ea1db0e2a714..aa2da07ee7fb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2165,8 +2165,19 @@ int do_journal_get_write_access(handle_t *handle,
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
=20
-extern struct inode *ext4_iget(struct super_block *, unsigned long);
-extern struct inode *ext4_iget_normal(struct super_block *, unsigned long);
+typedef enum {
+	EXT4_IGET_NORMAL =3D	0,
+	EXT4_IGET_SPECIAL =3D	0x0001, /* OK to iget a system inode */
+	EXT4_IGET_HANDLE =3D 	0x0002	/* Inode # is from a handle */
+} ext4_iget_flags;
+
+extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
+				 ext4_iget_flags flags, const char *function,
+				 unsigned int line);
+
+#define ext4_iget(sb, ino, flags) \
+	__ext4_iget((sb), (ino), (flags), __func__, __LINE__)
+
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct dentry *, struct iattr *);
 extern int  ext4_getattr(struct vfsmount *mnt, struct dentry *dentry,
@@ -2701,7 +2712,7 @@ extern struct buffer_head *ext4_get_first_inline_bloc=
k(struct inode *inode,
 					int *retval);
 extern int ext4_inline_data_fiemap(struct inode *inode,
 				   struct fiemap_extent_info *fieinfo,
-				   int *has_inline);
+				   int *has_inline, __u64 start, __u64 len);
 extern void ext4_inline_data_truncate(struct inode *inode, int *has_inline=
);
=20
 extern int ext4_convert_inline_data(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 86ac712decf8..289562c42511 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5153,7 +5153,8 @@ int ext4_fiemap(struct inode *inode, struct fiemap_ex=
tent_info *fieinfo,
 	if (ext4_has_inline_data(inode)) {
 		int has_inline =3D 1;
=20
-		error =3D ext4_inline_data_fiemap(inode, fieinfo, &has_inline);
+		error =3D ext4_inline_data_fiemap(inode, fieinfo, &has_inline,
+						start, len);
=20
 		if (has_inline)
 			return error;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 18479ebf2ce1..e9a5e819a56c 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1094,7 +1094,7 @@ struct inode *ext4_orphan_get(struct super_block *sb,=
 unsigned long ino)
 	if (!ext4_test_bit(bit, bitmap_bh->b_data))
 		goto bad_orphan;
=20
-	inode =3D ext4_iget(sb, ino);
+	inode =3D ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
 		err =3D PTR_ERR(inode);
 		ext4_error(sb, "couldn't read orphan inode %lu (err %d)",
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 68308d7ed190..c2bb71c98d43 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -704,8 +704,11 @@ int ext4_try_to_write_inline_data(struct address_space=
 *mapping,
=20
 	if (!PageUptodate(page)) {
 		ret =3D ext4_read_inline_page(inode, page);
-		if (ret < 0)
+		if (ret < 0) {
+			unlock_page(page);
+			put_page(page);
 			goto out_up_read;
+		}
 	}
=20
 	ret =3D 1;
@@ -1813,11 +1816,12 @@ int ext4_destroy_inline_data(handle_t *handle, stru=
ct inode *inode)
=20
 int ext4_inline_data_fiemap(struct inode *inode,
 			    struct fiemap_extent_info *fieinfo,
-			    int *has_inline)
+			    int *has_inline, __u64 start, __u64 len)
 {
 	__u64 physical =3D 0;
-	__u64 length;
-	__u32 flags =3D FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST;
+	__u64 inline_len;
+	__u32 flags =3D FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
+		FIEMAP_EXTENT_LAST;
 	int error =3D 0;
 	struct ext4_iloc iloc;
=20
@@ -1826,6 +1830,13 @@ int ext4_inline_data_fiemap(struct inode *inode,
 		*has_inline =3D 0;
 		goto out;
 	}
+	inline_len =3D min_t(size_t, ext4_get_inline_size(inode),
+			   i_size_read(inode));
+	if (start >=3D inline_len)
+		goto out;
+	if (start + len < inline_len)
+		inline_len =3D start + len;
+	inline_len -=3D start;
=20
 	error =3D ext4_get_inode_loc(inode, &iloc);
 	if (error)
@@ -1834,14 +1845,13 @@ int ext4_inline_data_fiemap(struct inode *inode,
 	physical =3D (__u64)iloc.bh->b_blocknr << inode->i_sb->s_blocksize_bits;
 	physical +=3D (char *)ext4_raw_inode(&iloc) - iloc.bh->b_data;
 	physical +=3D offsetof(struct ext4_inode, i_block);
-	length =3D i_size_read(inode);
=20
-	if (physical)
-		error =3D fiemap_fill_next_extent(fieinfo, 0, physical,
-						length, flags);
 	brelse(iloc.bh);
 out:
 	up_read(&EXT4_I(inode)->xattr_sem);
+	if (physical)
+		error =3D fiemap_fill_next_extent(fieinfo, start, physical,
+						inline_len, flags);
 	return (error < 0 ? error : 0);
 }
=20
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 806cc2eb5886..20b4175a701f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2579,7 +2579,8 @@ static int ext4_writepages(struct address_space *mapp=
ing,
 		 * We may need to convert up to one extent per block in
 		 * the page and we may dirty the inode.
 		 */
-		rsv_blocks =3D 1 + (PAGE_CACHE_SIZE >> inode->i_blkbits);
+		rsv_blocks =3D 1 + ext4_chunk_trans_blocks(inode,
+					PAGE_CACHE_SIZE >> inode->i_blkbits);
 	}
=20
 	/*
@@ -4174,7 +4175,9 @@ static inline int ext4_iget_extra_inode(struct inode =
*inode,
 	return 0;
 }
=20
-struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
+struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
+			  ext4_iget_flags flags, const char *function,
+			  unsigned int line)
 {
 	struct ext4_iloc iloc;
 	struct ext4_inode *raw_inode;
@@ -4187,6 +4190,18 @@ struct inode *ext4_iget(struct super_block *sb, unsi=
gned long ino)
 	uid_t i_uid;
 	gid_t i_gid;
=20
+	if ((!(flags & EXT4_IGET_SPECIAL) &&
+	     (ino < EXT4_FIRST_INO(sb) && ino !=3D EXT4_ROOT_INO)) ||
+	    (ino < EXT4_ROOT_INO) ||
+	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {
+		if (flags & EXT4_IGET_HANDLE)
+			return ERR_PTR(-ESTALE);
+		__ext4_error(sb, function, line,
+			     "inode #%lu: comm %s: iget: illegal inode #",
+			     ino, current->comm);
+		return ERR_PTR(-EIO);
+	}
+
 	inode =3D iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
@@ -4202,18 +4217,27 @@ struct inode *ext4_iget(struct super_block *sb, uns=
igned long ino)
 	raw_inode =3D ext4_raw_inode(&iloc);
=20
 	if ((ino =3D=3D EXT4_ROOT_INO) && (raw_inode->i_links_count =3D=3D 0)) {
-		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: root inode unallocated");
 		ret =3D -EIO;
 		goto bad_inode;
 	}
=20
+	if ((flags & EXT4_IGET_HANDLE) &&
+	    (raw_inode->i_links_count =3D=3D 0) && (raw_inode->i_mode =3D=3D 0)) {
+		ret =3D -ESTALE;
+		goto bad_inode;
+	}
+
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		ei->i_extra_isize =3D le16_to_cpu(raw_inode->i_extra_isize);
 		if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
 		    EXT4_INODE_SIZE(inode->i_sb)) {
-			EXT4_ERROR_INODE(inode, "bad extra_isize (%u !=3D %u)",
-				EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize,
-				EXT4_INODE_SIZE(inode->i_sb));
+			ext4_error_inode(inode, function, line, 0,
+					 "iget: bad extra_isize %u "
+					 "(inode size %u)",
+					 ei->i_extra_isize,
+					 EXT4_INODE_SIZE(inode->i_sb));
 			ret =3D -EIO;
 			goto bad_inode;
 		}
@@ -4233,7 +4257,8 @@ struct inode *ext4_iget(struct super_block *sb, unsig=
ned long ino)
 	}
=20
 	if (!ext4_inode_csum_verify(inode, raw_inode, ei)) {
-		EXT4_ERROR_INODE(inode, "checksum invalid");
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: checksum invalid");
 		ret =3D -EIO;
 		goto bad_inode;
 	}
@@ -4281,7 +4306,8 @@ struct inode *ext4_iget(struct super_block *sb, unsig=
ned long ino)
 			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
 	inode->i_size =3D ext4_isize(raw_inode);
 	if ((size =3D i_size_read(inode)) < 0) {
-		EXT4_ERROR_INODE(inode, "bad i_size value: %lld", size);
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bad i_size value: %lld", size);
 		ret =3D -EIO;
 		goto bad_inode;
 	}
@@ -4354,7 +4380,8 @@ struct inode *ext4_iget(struct super_block *sb, unsig=
ned long ino)
 	ret =3D 0;
 	if (ei->i_file_acl &&
 	    !ext4_data_block_valid(EXT4_SB(sb), ei->i_file_acl, 1)) {
-		EXT4_ERROR_INODE(inode, "bad extended attribute block %llu",
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bad extended attribute block %llu",
 				 ei->i_file_acl);
 		ret =3D -EIO;
 		goto bad_inode;
@@ -4404,7 +4431,8 @@ struct inode *ext4_iget(struct super_block *sb, unsig=
ned long ino)
 		make_bad_inode(inode);
 	} else {
 		ret =3D -EIO;
-		EXT4_ERROR_INODE(inode, "bogus i_mode (%o)", inode->i_mode);
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
 	brelse(iloc.bh);
@@ -4418,13 +4446,6 @@ struct inode *ext4_iget(struct super_block *sb, unsi=
gned long ino)
 	return ERR_PTR(ret);
 }
=20
-struct inode *ext4_iget_normal(struct super_block *sb, unsigned long ino)
-{
-	if (ino < EXT4_FIRST_INO(sb) && ino !=3D EXT4_ROOT_INO)
-		return ERR_PTR(-EIO);
-	return ext4_iget(sb, ino);
-}
-
 static int ext4_inode_blocks_set(handle_t *handle,
 				struct ext4_inode *raw_inode,
 				struct ext4_inode_info *ei)
@@ -4638,7 +4659,8 @@ int ext4_write_inode(struct inode *inode, struct writ=
eback_control *wbc)
 {
 	int err;
=20
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
+	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC) ||
+	    (inode->i_sb->s_flags & MS_RDONLY))
 		return 0;
=20
 	if (EXT4_SB(inode->i_sb)->s_journal) {
@@ -4656,7 +4678,8 @@ int ext4_write_inode(struct inode *inode, struct writ=
eback_control *wbc)
 		if (wbc->sync_mode !=3D WB_SYNC_ALL || wbc->for_sync)
 			return 0;
=20
-		err =3D ext4_force_commit(inode->i_sb);
+		err =3D jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
+						EXT4_I(inode)->i_sync_tid);
 	} else {
 		struct ext4_iloc iloc;
=20
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 723a2307a9e8..a77035ec6a4d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -127,7 +127,7 @@ static long swap_inode_boot_loader(struct super_block *=
sb,
 	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
=20
-	inode_bl =3D ext4_iget(sb, EXT4_BOOT_LOADER_INO);
+	inode_bl =3D ext4_iget(sb, EXT4_BOOT_LOADER_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(inode_bl))
 		return PTR_ERR(inode_bl);
 	ei_bl =3D EXT4_I(inode_bl);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e5282863d9d4..9e1760f8bf1d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1439,7 +1439,7 @@ static struct dentry *ext4_lookup(struct inode *dir, =
struct dentry *dentry, unsi
 					 dentry);
 			return ERR_PTR(-EIO);
 		}
-		inode =3D ext4_iget_normal(dir->i_sb, ino);
+		inode =3D ext4_iget(dir->i_sb, ino, EXT4_IGET_NORMAL);
 		if (inode =3D=3D ERR_PTR(-ESTALE)) {
 			EXT4_ERROR_INODE(dir,
 					 "deleted inode referenced: %u",
@@ -1472,7 +1472,7 @@ struct dentry *ext4_get_parent(struct dentry *child)
 		return ERR_PTR(-EIO);
 	}
=20
-	return d_obtain_alias(ext4_iget_normal(child->d_inode->i_sb, ino));
+	return d_obtain_alias(ext4_iget(child->d_inode->i_sb, ino, EXT4_IGET_NORM=
AL));
 }
=20
 /*
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 15b9e5dea908..b9d35d52889c 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1609,7 +1609,7 @@ int ext4_group_add(struct super_block *sb, struct ext=
4_new_group_data *input)
 				     "No reserved GDT blocks, can't resize");
 			return -EPERM;
 		}
-		inode =3D ext4_iget(sb, EXT4_RESIZE_INO);
+		inode =3D ext4_iget(sb, EXT4_RESIZE_INO, EXT4_IGET_SPECIAL);
 		if (IS_ERR(inode)) {
 			ext4_warning(sb, "Error opening resize inode");
 			return PTR_ERR(inode);
@@ -1936,7 +1936,8 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk=
_t n_blocks_count)
 		}
=20
 		if (!resize_inode)
-			resize_inode =3D ext4_iget(sb, EXT4_RESIZE_INO);
+			resize_inode =3D ext4_iget(sb, EXT4_RESIZE_INO,
+						 EXT4_IGET_SPECIAL);
 		if (IS_ERR(resize_inode)) {
 			ext4_warning(sb, "Error opening resize inode");
 			return PTR_ERR(resize_inode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0b1cd5a7a48b..282ebfd9d9f7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1013,20 +1013,11 @@ static struct inode *ext4_nfs_get_inode(struct supe=
r_block *sb,
 {
 	struct inode *inode;
=20
-	if (ino < EXT4_FIRST_INO(sb) && ino !=3D EXT4_ROOT_INO)
-		return ERR_PTR(-ESTALE);
-	if (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
-		return ERR_PTR(-ESTALE);
-
-	/* iget isn't really right if the inode is currently unallocated!!
-	 *
-	 * ext4_read_inode will return a bad_inode if the inode had been
-	 * deleted, so we should be safe.
-	 *
+	/*
 	 * Currently we don't know the generation for parent directory, so
 	 * a generation of 0 means "accept any"
 	 */
-	inode =3D ext4_iget_normal(sb, ino);
+	inode =3D ext4_iget(sb, ino, EXT4_IGET_HANDLE);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	if (generation && inode->i_generation !=3D generation) {
@@ -1051,6 +1042,16 @@ static struct dentry *ext4_fh_to_parent(struct super=
_block *sb, struct fid *fid,
 				    ext4_nfs_get_inode);
 }
=20
+static int ext4_nfs_commit_metadata(struct inode *inode)
+{
+	struct writeback_control wbc =3D {
+		.sync_mode =3D WB_SYNC_ALL
+	};
+
+	trace_ext4_nfs_commit_metadata(inode);
+	return ext4_write_inode(inode, &wbc);
+}
+
 /*
  * Try to release metadata pages (indirect blocks, directories) which are
  * mapped via the block device.  Since these pages could have journal heads
@@ -1171,6 +1172,7 @@ static const struct export_operations ext4_export_ops=
 =3D {
 	.fh_to_dentry =3D ext4_fh_to_dentry,
 	.fh_to_parent =3D ext4_fh_to_parent,
 	.get_parent =3D ext4_get_parent,
+	.commit_metadata =3D ext4_nfs_commit_metadata,
 };
=20
 enum {
@@ -4221,7 +4223,7 @@ static int ext4_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	 * so we can safely mount the rest of the filesystem now.
 	 */
=20
-	root =3D ext4_iget(sb, EXT4_ROOT_INO);
+	root =3D ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(root)) {
 		ext4_msg(sb, KERN_ERR, "get root inode failed");
 		ret =3D PTR_ERR(root);
@@ -4456,7 +4458,7 @@ static journal_t *ext4_get_journal(struct super_block=
 *sb,
 	 * things happen if we iget() an unused inode, as the subsequent
 	 * iput() will try to delete it. */
=20
-	journal_inode =3D ext4_iget(sb, journal_inum);
+	journal_inode =3D ext4_iget(sb, journal_inum, EXT4_IGET_SPECIAL);
 	if (IS_ERR(journal_inode)) {
 		ext4_msg(sb, KERN_ERR, "no journal found");
 		return NULL;
@@ -4710,7 +4712,7 @@ static int ext4_commit_super(struct super_block *sb, =
int sync)
 	BUFFER_TRACE(sbh, "marking dirty");
 	ext4_superblock_csum_set(sb);
 	lock_buffer(sbh);
-	if (buffer_write_io_error(sbh)) {
+	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the
 		 * superblock failed.  This could happen because the
@@ -5396,7 +5398,7 @@ static int ext4_quota_enable(struct super_block *sb, =
int type, int format_id,
 	if (!qf_inums[type])
 		return -EPERM;
=20
-	qf_inode =3D ext4_iget(sb, qf_inums[type]);
+	qf_inode =3D ext4_iget(sb, qf_inums[type], EXT4_IGET_SPECIAL);
 	if (IS_ERR(qf_inode)) {
 		ext4_error(sb, "Bad quota inode # %lu", qf_inums[type]);
 		return PTR_ERR(qf_inode);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 9047f04f9bc6..4d140b79fb57 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1340,7 +1340,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, i=
nt new_extra_isize,
 	end =3D (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 	min_offs =3D end - base;
 	last =3D entry;
-	total_ino =3D sizeof(struct ext4_xattr_ibody_header);
+	total_ino =3D sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
=20
 	error =3D xattr_check_inode(inode, header, end);
 	if (error)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4b697ccc9b0c..a4d72544f3ff 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -509,6 +509,7 @@ static void truncate_node(struct dnode_of_data *dn)
 {
 	struct f2fs_sb_info *sbi =3D F2FS_SB(dn->inode->i_sb);
 	struct node_info ni;
+	pgoff_t index;
=20
 	get_node_info(sbi, dn->nid, &ni);
 	if (dn->inode->i_blocks =3D=3D 0) {
@@ -532,10 +533,11 @@ static void truncate_node(struct dnode_of_data *dn)
 	clear_node_page_dirty(dn->node_page);
 	F2FS_SET_SB_DIRT(sbi);
=20
+	index =3D dn->node_page->index;
 	f2fs_put_page(dn->node_page, 1);
=20
 	invalidate_mapping_pages(NODE_MAPPING(sbi),
-			dn->node_page->index, dn->node_page->index);
+			index, index);
=20
 	dn->node_page =3D NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 05e53ccb708b..0b2aaf47b5ac 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -245,7 +245,7 @@ static inline int gpiod_to_irq(const struct gpio_desc *=
desc)
=20
 static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
-	return ERR_PTR(-EINVAL);
+	return NULL;
 }
 static inline int desc_to_gpio(const struct gpio_desc *desc)
 {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6bc75164e68f..1e4bccd88c84 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -97,6 +97,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr);
 int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *pte=
p);
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 			      int write);
 struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
@@ -124,6 +126,18 @@ static inline unsigned long hugetlb_total_pages(void)
 	return 0;
 }
=20
+static inline int huge_pmd_unshare(struct mm_struct *mm, unsigned long *ad=
dr,
+						pte_t *ptep)
+{
+	return 0;
+}
+
+static inline void adjust_range_if_pmd_sharing_possible(
+				struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+}
+
 #define follow_hugetlb_page(m,v,p,vs,a,b,i,w)	({ BUG(); 0; })
 #define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a93a36e1a480..42a3552f641a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1947,6 +1947,12 @@ static inline struct vm_area_struct *find_exact_vma(=
struct mm_struct *mm,
 	return vma;
 }
=20
+static inline bool range_in_vma(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	return (vma && vma->vm_start <=3D start && end <=3D vma->vm_end);
+}
+
 #ifdef CONFIG_MMU
 pgprot_t vm_get_page_prot(unsigned long vm_flags);
 #else
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index d4f70a7fe876..8670ddbff178 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -195,6 +195,26 @@ TRACE_EVENT(ext4_drop_inode,
 		  (unsigned long) __entry->ino, __entry->drop)
 );
=20
+TRACE_EVENT(ext4_nfs_commit_metadata,
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	ino_t,	ino			)
+	),
+
+	TP_fast_assign(
+		__entry->dev	=3D inode->i_sb->s_dev;
+		__entry->ino	=3D inode->i_ino;
+	),
+
+	TP_printk("dev %d,%d ino %lu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino)
+);
+
 TRACE_EVENT(ext4_mark_inode_dirty,
 	TP_PROTO(struct inode *inode, unsigned long IP),
=20
diff --git a/kernel/panic.c b/kernel/panic.c
index 4de988c2aaec..e06b7d22c3b7 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -13,6 +13,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/kallsyms.h>
 #include <linux/notifier.h>
+#include <linux/vt_kern.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/ftrace.h>
@@ -178,7 +179,10 @@ void panic(const char *fmt, ...)
 	 */
 	crash_kexec(NULL);
=20
-	bust_spinlocks(0);
+#ifdef CONFIG_VT
+	unblank_screen();
+#endif
+	console_unblank();
=20
 	/*
 	 * We may have ended up stopping the CPU holding the lock (in
diff --git a/lib/string.c b/lib/string.c
index d3e7e521ba9c..80e8bdb60538 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -31,14 +31,14 @@
 #include <asm/word-at-a-time.h>
 #include <asm/page.h>
=20
-#ifndef __HAVE_ARCH_STRNICMP
+#ifndef __HAVE_ARCH_STRNCASECMP
 /**
- * strnicmp - Case insensitive, length-limited string comparison
+ * strncasecmp - Case insensitive, length-limited string comparison
  * @s1: One string
  * @s2: The other string
  * @len: the maximum number of characters to compare
  */
-int strnicmp(const char *s1, const char *s2, size_t len)
+int strncasecmp(const char *s1, const char *s2, size_t len)
 {
 	/* Yes, Virginia, it had better be unsigned */
 	unsigned char c1, c2;
@@ -60,6 +60,13 @@ int strnicmp(const char *s1, const char *s2, size_t len)
 	} while (--len);
 	return (int)c1 - (int)c2;
 }
+EXPORT_SYMBOL(strncasecmp);
+#endif
+#ifndef __HAVE_ARCH_STRNICMP
+int strnicmp(const char *s1, const char *s2, size_t len)
+{
+	return strncasecmp(s1, s2, len);
+}
 EXPORT_SYMBOL(strnicmp);
 #endif
=20
@@ -77,20 +84,6 @@ int strcasecmp(const char *s1, const char *s2)
 EXPORT_SYMBOL(strcasecmp);
 #endif
=20
-#ifndef __HAVE_ARCH_STRNCASECMP
-int strncasecmp(const char *s1, const char *s2, size_t n)
-{
-	int c1, c2;
-
-	do {
-		c1 =3D tolower(*s1++);
-		c2 =3D tolower(*s2++);
-	} while ((--n > 0) && c1 =3D=3D c2 && c1 !=3D 0);
-	return c1 - c2;
-}
-EXPORT_SYMBOL(strncasecmp);
-#endif
-
 #ifndef __HAVE_ARCH_STRCPY
 /**
  * strcpy - Copy a %NUL terminated string
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3ca4e9eb205b..f7a5996dc672 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3657,12 +3657,40 @@ static int vma_shareable(struct vm_area_struct *vma=
, unsigned long addr)
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE &&
-	    vma->vm_start <=3D base && end <=3D vma->vm_end)
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
 		return 1;
 	return 0;
 }
=20
+/*
+ * Determine if start,end range within vma could be mapped by shared pmd.
+ * If yes, adjust start and end to cover range associated with possible
+ * shared pmd mappings.
+ */
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+	unsigned long check_addr =3D *start;
+
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	for (check_addr =3D *start; check_addr < *end; check_addr +=3D PUD_SIZE) {
+		unsigned long a_start =3D check_addr & PUD_MASK;
+		unsigned long a_end =3D a_start + PUD_SIZE;
+
+		/*
+		 * If sharing is possible, adjust start/end if necessary.
+		 */
+		if (range_in_vma(vma, a_start, a_end)) {
+			if (a_start < *start)
+				*start =3D a_start;
+			if (a_end > *end)
+				*end =3D a_end;
+		}
+	}
+}
+
 /*
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_allo=
c()
  * and returns the corresponding pte. While this is not necessary for the
@@ -3751,6 +3779,11 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned=
 long addr, pud_t *pud)
 {
 	return NULL;
 }
+
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+}
 #define want_pmd_share()	(0)
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
=20
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a5033435b9ca..b098b4aac4b5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -32,6 +32,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memblock.h>
 #include <linux/bootmem.h>
+#include <linux/rmap.h>
=20
 #include <asm/tlbflush.h>
=20
@@ -1393,6 +1394,21 @@ do_migrate_range(unsigned long start_pfn, unsigned l=
ong end_pfn)
 			continue;
 		}
=20
+		/*
+		 * HWPoison pages have elevated reference counts so the migration would
+		 * fail on them. It also doesn't make any sense to migrate them in the
+		 * first place. Still try to unmap such a page in case it is still mapped
+		 * (e.g. current hwpoison implementation doesn't unmap KSM pages but keep
+		 * the unmap as the catch all safety net).
+		 */
+		if (PageHWPoison(page)) {
+			if (WARN_ON(PageLRU(page)))
+				isolate_lru_page(page);
+			if (page_mapped(page))
+				try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS);
+			continue;
+		}
+
 		if (!get_page_unless_zero(page))
 			continue;
 		/*
@@ -1880,34 +1896,6 @@ static int check_cpu_on_node(pg_data_t *pgdat)
 	return 0;
 }
=20
-static void unmap_cpu_on_node(pg_data_t *pgdat)
-{
-#ifdef CONFIG_ACPI_NUMA
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		if (cpu_to_node(cpu) =3D=3D pgdat->node_id)
-			numa_clear_node(cpu);
-#endif
-}
-
-static int check_and_unmap_cpu_on_node(pg_data_t *pgdat)
-{
-	int ret;
-
-	ret =3D check_cpu_on_node(pgdat);
-	if (ret)
-		return ret;
-
-	/*
-	 * the node will be offlined when we come here, so we can clear
-	 * the cpu_to_node() now.
-	 */
-
-	unmap_cpu_on_node(pgdat);
-	return 0;
-}
-
 /**
  * try_offline_node
  *
@@ -1941,7 +1929,7 @@ void try_offline_node(int nid)
 		return;
 	}
=20
-	if (check_and_unmap_cpu_on_node(pgdat))
+	if (check_cpu_on_node(pgdat))
 		return;
=20
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 0ebe6ab837c6..d3d26ce2903c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1195,8 +1195,41 @@ static int try_to_unmap_one(struct page *page, struc=
t vm_area_struct *vma,
 	pte_t pteval;
 	spinlock_t *ptl;
 	int ret =3D SWAP_AGAIN;
+	unsigned long sh_address;
+	bool pmd_sharing_possible =3D false;
+	unsigned long spmd_start, spmd_end;
 	enum ttu_flags flags =3D (enum ttu_flags)arg;
=20
+	/* munlock has nothing to gain from examining un-locked vmas */
+	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
+		goto out;
+
+	/*
+	 * Only use the range_start/end mmu notifiers if huge pmd sharing
+	 * is possible.  In the normal case, mmu_notifier_invalidate_page
+	 * is sufficient as we only unmap a page.  However, if we unshare
+	 * a pmd, we will unmap a PUD_SIZE range.
+	 */
+	if (PageHuge(page)) {
+		spmd_start =3D address;
+		spmd_end =3D spmd_start + vma_mmu_pagesize(vma);
+
+		/*
+		 * Check if pmd sharing is possible.  If possible, we could
+		 * unmap a PUD_SIZE range.  spmd_start/spmd_end will be
+		 * modified if sharing is possible.
+		 */
+		adjust_range_if_pmd_sharing_possible(vma, &spmd_start,
+								&spmd_end);
+		if (spmd_end - spmd_start !=3D vma_mmu_pagesize(vma)) {
+			sh_address =3D address;
+
+			pmd_sharing_possible =3D true;
+			mmu_notifier_invalidate_range_start(vma->vm_mm,
+							spmd_start, spmd_end);
+		}
+	}
+
 	pte =3D page_check_address(page, mm, address, &ptl, 0);
 	if (!pte)
 		goto out;
@@ -1207,9 +1240,12 @@ static int try_to_unmap_one(struct page *page, struc=
t vm_area_struct *vma,
 	 * skipped over this mm) then we should reactivate it.
 	 */
 	if (!(flags & TTU_IGNORE_MLOCK)) {
-		if (vma->vm_flags & VM_LOCKED)
-			goto out_mlock;
-
+		if (vma->vm_flags & VM_LOCKED) {
+			/* Holding pte lock, we do *not* need mmap_sem here */
+			mlock_vma_page(page);
+			ret =3D SWAP_MLOCK;
+			goto out_unmap;
+		}
 		if (flags & TTU_MUNLOCK)
 			goto out_unmap;
 	}
@@ -1220,6 +1256,30 @@ static int try_to_unmap_one(struct page *page, struc=
t vm_area_struct *vma,
 		}
   	}
=20
+	/*
+	 * Call huge_pmd_unshare to potentially unshare a huge pmd.  Pass
+	 * sh_address as it will be modified if unsharing is successful.
+	 */
+	if (PageHuge(page) && huge_pmd_unshare(mm, &sh_address, pte)) {
+		/*
+		 * huge_pmd_unshare unmapped an entire PMD page.  There is
+		 * no way of knowing exactly which PMDs may be cached for
+		 * this mm, so flush them all.  spmd_start/spmd_end cover
+		 * this PUD_SIZE range.
+		 */
+		flush_cache_range(vma, spmd_start, spmd_end);
+		flush_tlb_range(vma, spmd_start, spmd_end);
+
+		/*
+		 * The ref count of the PMD page was dropped which is part
+		 * of the way map counting is done for shared PMDs.  When
+		 * there is no other sharing, huge_pmd_unshare returns false
+		 * and we will unmap the actual page and drop map count
+		 * to zero.
+		 */
+		goto out_unmap;
+	}
+
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval =3D ptep_clear_flush(vma, address, pte);
@@ -1299,30 +1359,12 @@ static int try_to_unmap_one(struct page *page, stru=
ct vm_area_struct *vma,
=20
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
-	if (ret !=3D SWAP_FAIL && !(flags & TTU_MUNLOCK))
+	if (ret !=3D SWAP_FAIL && ret !=3D SWAP_MLOCK && !(flags & TTU_MUNLOCK))
 		mmu_notifier_invalidate_page(mm, address);
 out:
-	return ret;
-
-out_mlock:
-	pte_unmap_unlock(pte, ptl);
-
-
-	/*
-	 * We need mmap_sem locking, Otherwise VM_LOCKED check makes
-	 * unstable result and race. Plus, We can't wait here because
-	 * we now hold anon_vma->rwsem or mapping->i_mmap_mutex.
-	 * if trylock failed, the page remain in evictable lru and later
-	 * vmscan could retry to move the page to unevictable lru if the
-	 * page is actually mlocked.
-	 */
-	if (down_read_trylock(&vma->vm_mm->mmap_sem)) {
-		if (vma->vm_flags & VM_LOCKED) {
-			mlock_vma_page(page);
-			ret =3D SWAP_MLOCK;
-		}
-		up_read(&vma->vm_mm->mmap_sem);
-	}
+	if (pmd_sharing_possible)
+		mmu_notifier_invalidate_range_end(vma->vm_mm,
+							spmd_start, spmd_end);
 	return ret;
 }
=20
diff --git a/net/9p/client.c b/net/9p/client.c
index d150562c4172..6cc2e73142b3 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -155,6 +155,12 @@ static int parse_opts(char *opts, struct p9_client *cl=
nt)
 				ret =3D r;
 				continue;
 			}
+			if (option < 4096) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "msize should be at least 4k\n");
+				ret =3D -EINVAL;
+				continue;
+			}
 			clnt->msize =3D option;
 			break;
 		case Opt_trans:
@@ -980,10 +986,18 @@ static int p9_client_version(struct p9_client *c)
 	else if (!strncmp(version, "9P2000", 6))
 		c->proto_version =3D p9_proto_legacy;
 	else {
+		p9_debug(P9_DEBUG_ERROR,
+			 "server returned an unknown version: %s\n", version);
 		err =3D -EREMOTEIO;
 		goto error;
 	}
=20
+	if (msize < 4096) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "server returned a msize < 4096: %d\n", msize);
+		err =3D -EREMOTEIO;
+		goto error;
+	}
 	if (msize < c->msize)
 		c->msize =3D msize;
=20
@@ -1048,6 +1062,13 @@ struct p9_client *p9_client_create(const char *dev_n=
ame, char *options)
 	if (clnt->msize > clnt->trans_mod->maxsize)
 		clnt->msize =3D clnt->trans_mod->maxsize;
=20
+	if (clnt->msize < 4096) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "Please specify a msize of at least 4k\n");
+		err =3D -EINVAL;
+		goto close_trans;
+	}
+
 	err =3D p9_client_version(clnt);
 	if (err)
 		goto close_trans;
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcaut=
h_gss.c
index d52b1814f62b..03000a10983d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1103,7 +1103,7 @@ static int svcauth_gss_legacy_init(struct svc_rqst *r=
qstp,
 	struct kvec *resv =3D &rqstp->rq_res.head[0];
 	struct rsi *rsip, rsikey;
 	int ret;
-	struct sunrpc_net *sn =3D net_generic(rqstp->rq_xprt->xpt_net, sunrpc_net=
_id);
+	struct sunrpc_net *sn =3D net_generic(SVC_NET(rqstp), sunrpc_net_id);
=20
 	memset(&rsikey, 0, sizeof(rsikey));
 	ret =3D gss_read_verf(gc, argv, authp,
@@ -1214,7 +1214,7 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rq=
stp,
 	uint64_t handle;
 	int status;
 	int ret;
-	struct net *net =3D rqstp->rq_xprt->xpt_net;
+	struct net *net =3D SVC_NET(rqstp);
 	struct sunrpc_net *sn =3D net_generic(net, sunrpc_net_id);
=20
 	memset(&ud, 0, sizeof(ud));
@@ -1404,7 +1404,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *au=
thp)
 	__be32		*rpcstart;
 	__be32		*reject_stat =3D resv->iov_base + resv->iov_len;
 	int		ret;
-	struct sunrpc_net *sn =3D net_generic(rqstp->rq_xprt->xpt_net, sunrpc_net=
_id);
+	struct sunrpc_net *sn =3D net_generic(SVC_NET(rqstp), sunrpc_net_id);
=20
 	dprintk("RPC:       svcauth_gss: argv->iov_len =3D %zd\n",
 			argv->iov_len);
@@ -1692,7 +1692,7 @@ svcauth_gss_release(struct svc_rqst *rqstp)
 	struct rpc_gss_wire_cred *gc =3D &gsd->clcred;
 	struct xdr_buf *resbuf =3D &rqstp->rq_res;
 	int stat =3D -EINVAL;
-	struct sunrpc_net *sn =3D net_generic(rqstp->rq_xprt->xpt_net, sunrpc_net=
_id);
+	struct sunrpc_net *sn =3D net_generic(SVC_NET(rqstp), sunrpc_net_id);
=20
 	if (gc->gc_proc !=3D RPC_GSS_PROC_DATA)
 		goto out;
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 11e7b55f04e2..cdfa7f4c0a59 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -50,6 +50,10 @@ static void cache_init(struct cache_head *h)
 	h->last_refresh =3D now;
 }
=20
+static void cache_fresh_locked(struct cache_head *head, time_t expiry);
+static void cache_fresh_unlocked(struct cache_head *head,
+				struct cache_detail *detail);
+
 struct cache_head *sunrpc_cache_lookup(struct cache_detail *detail,
 				       struct cache_head *key, int hash)
 {
@@ -94,6 +98,7 @@ struct cache_head *sunrpc_cache_lookup(struct cache_detai=
l *detail,
 				*hp =3D tmp->next;
 				tmp->next =3D NULL;
 				detail->entries --;
+				cache_fresh_locked(tmp, 0);
 				freeme =3D tmp;
 				break;
 			}
@@ -109,8 +114,10 @@ struct cache_head *sunrpc_cache_lookup(struct cache_de=
tail *detail,
 	cache_get(new);
 	write_unlock(&detail->hash_lock);
=20
-	if (freeme)
+	if (freeme) {
+		cache_fresh_unlocked(freeme, detail);
 		cache_put(freeme, detail);
+	}
 	return new;
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_lookup);
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 2326e239e8bd..98fd4c1c7c40 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -25,6 +25,7 @@
 #include <linux/time.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
+#include <linux/nospec.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
@@ -126,6 +127,7 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
 				return -EFAULT;
 			if (stream < 0 || stream > 1)
 				return -EINVAL;
+			stream =3D array_index_nospec(stream, 2);
 			if (get_user(subdevice, &info->subdevice))
 				return -EFAULT;
 			mutex_lock(&register_mutex);
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index acce8c76eff0..7ce0b7bc6409 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/moduleparam.h>
+#include <linux/nospec.h>
=20
 #include <sound/core.h>
 #include <sound/tlv.h>
@@ -1001,6 +1002,8 @@ static int snd_emu10k1_ipcm_poke(struct snd_emu10k1 *=
emu,
=20
 	if (ipcm->substream >=3D EMU10K1_FX8010_PCM_COUNT)
 		return -EINVAL;
+	ipcm->substream =3D array_index_nospec(ipcm->substream,
+					     EMU10K1_FX8010_PCM_COUNT);
 	if (ipcm->channels > 32)
 		return -EINVAL;
 	pcm =3D &emu->fx8010.pcm[ipcm->substream];
@@ -1047,6 +1050,8 @@ static int snd_emu10k1_ipcm_peek(struct snd_emu10k1 *=
emu,
=20
 	if (ipcm->substream >=3D EMU10K1_FX8010_PCM_COUNT)
 		return -EINVAL;
+	ipcm->substream =3D array_index_nospec(ipcm->substream,
+					     EMU10K1_FX8010_PCM_COUNT);
 	pcm =3D &emu->fx8010.pcm[ipcm->substream];
 	mutex_lock(&emu->fx8010.lock);
 	spin_lock_irq(&emu->reg_lock);
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 358414da6418..44953a273246 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -261,6 +261,7 @@ static int hda_tegra_suspend(struct device *dev)
 		snd_hda_suspend(chip->bus);
=20
 	azx_stop_chip(chip);
+	synchronize_irq(chip->irq);
 	azx_enter_link_reset(chip);
 	hda_tegra_disable_clocks(hda);
=20
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index a2fbc99aad87..5a2df095d206 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/math64.h>
 #include <linux/vmalloc.h>
+#include <linux/nospec.h>
=20
 #include <sound/core.h>
 #include <sound/control.h>
@@ -4129,15 +4130,16 @@ static int snd_hdsp_channel_info(struct snd_pcm_sub=
stream *substream,
 				    struct snd_pcm_channel_info *info)
 {
 	struct hdsp *hdsp =3D snd_pcm_substream_chip(substream);
-	int mapped_channel;
+	unsigned int channel =3D info->channel;
=20
-	if (snd_BUG_ON(info->channel >=3D hdsp->max_channels))
+	if (snd_BUG_ON(channel >=3D hdsp->max_channels))
 		return -EINVAL;
+	channel =3D array_index_nospec(channel, hdsp->max_channels);
=20
-	if ((mapped_channel =3D hdsp->channel_map[info->channel]) < 0)
+	if (hdsp->channel_map[channel] < 0)
 		return -EINVAL;
=20
-	info->offset =3D mapped_channel * HDSP_CHANNEL_BUFFER_BYTES;
+	info->offset =3D hdsp->channel_map[channel] * HDSP_CHANNEL_BUFFER_BYTES;
 	info->first =3D 0;
 	info->step =3D 32;
 	return 0;
diff --git a/sound/synth/emux/emux_hwdep.c b/sound/synth/emux/emux_hwdep.c
index 5ae1eae9f6db..f2361789f622 100644
--- a/sound/synth/emux/emux_hwdep.c
+++ b/sound/synth/emux/emux_hwdep.c
@@ -22,9 +22,9 @@
 #include <sound/core.h>
 #include <sound/hwdep.h>
 #include <asm/uaccess.h>
+#include <linux/nospec.h>
 #include "emux_voice.h"
=20
-
 #define TMP_CLIENT_ID	0x1001
=20
 /*
@@ -66,13 +66,16 @@ snd_emux_hwdep_misc_mode(struct snd_emux *emu, void __u=
ser *arg)
 		return -EFAULT;
 	if (info.mode < 0 || info.mode >=3D EMUX_MD_END)
 		return -EINVAL;
+	info.mode =3D array_index_nospec(info.mode, EMUX_MD_END);
=20
 	if (info.port < 0) {
 		for (i =3D 0; i < emu->num_ports; i++)
 			emu->portptrs[i]->ctrls[info.mode] =3D info.value;
 	} else {
-		if (info.port < emu->num_ports)
+		if (info.port < emu->num_ports) {
+			info.port =3D array_index_nospec(info.port, emu->num_ports);
 			emu->portptrs[info.port]->ctrls[info.mode] =3D info.value;
+		}
 	}
 	return 0;
 }
diff --git a/tools/lib/lockdep/include/liblockdep/rwlock.h b/tools/lib/lock=
dep/include/liblockdep/rwlock.h
index 4ec03f861551..6d12cbb51748 100644
--- a/tools/lib/lockdep/include/liblockdep/rwlock.h
+++ b/tools/lib/lockdep/include/liblockdep/rwlock.h
@@ -59,10 +59,10 @@ static inline int liblockdep_pthread_rwlock_tryrdlock(l=
iblockdep_pthread_rwlock_
 	return pthread_rwlock_tryrdlock(&lock->rwlock) =3D=3D 0 ? 1 : 0;
 }
=20
-static inline int liblockdep_pthread_rwlock_trywlock(liblockdep_pthread_rw=
lock_t *lock)
+static inline int liblockdep_pthread_rwlock_trywrlock(liblockdep_pthread_r=
wlock_t *lock)
 {
 	lock_acquire(&lock->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_trywlock(&lock->rwlock) =3D=3D 0 ? 1 : 0;
+	return pthread_rwlock_trywrlock(&lock->rwlock) =3D=3D 0 ? 1 : 0;
 }
=20
 static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *l=
ock)
@@ -78,7 +78,7 @@ static inline int liblockdep_rwlock_destroy(liblockdep_pt=
hread_rwlock_t *lock)
 #define pthread_rwlock_unlock		liblockdep_pthread_rwlock_unlock
 #define pthread_rwlock_wrlock		liblockdep_pthread_rwlock_wrlock
 #define pthread_rwlock_tryrdlock	liblockdep_pthread_rwlock_tryrdlock
-#define pthread_rwlock_trywlock		liblockdep_pthread_rwlock_trywlock
+#define pthread_rwlock_trywrlock	liblockdep_pthread_rwlock_trywrlock
 #define pthread_rwlock_destroy		liblockdep_rwlock_destroy
=20
 #endif
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 178b88ae3d2f..e538999bc23f 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -166,7 +166,7 @@ static void add_man_viewer(const char *name)
 	while (*p)
 		p =3D &((*p)->next);
 	*p =3D zalloc(sizeof(**p) + len + 1);
-	strncpy((*p)->name, name, len);
+	strcpy((*p)->name, name);
 }
=20
 static int supported_man_viewer(const char *name, size_t len)
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 1c8b9afd5d6e..976f528109e8 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -22,7 +22,7 @@ static void tui_helpline__push(const char *msg)
 	SLsmg_set_color(0);
 	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
 	SLsmg_refresh();
-	strncpy(ui_helpline__current, msg, sz)[sz - 1] =3D '\0';
+	strlcpy(ui_helpline__current, msg, sz);
 }
=20
 static int tui_helpline__show(const char *format, va_list ap)
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a9d48aa70afc..16adba0da5f5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1217,7 +1217,7 @@ static void print_symbol_events(const char *event_glo=
b, unsigned type,
 		if (strlen(syms->alias))
 			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
 		else
-			strncpy(name, syms->symbol, MAX_NAME_LEN);
+			strlcpy(name, syms->symbol, MAX_NAME_LEN);
=20
 		printf("  %-50s [%s]\n", name, event_type_descriptors[type]);
=20
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f819c23744f5..d17f80a8c1d7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -107,7 +107,7 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias =
*alias, char *dir, char *
 	char path[PATH_MAX];
 	const char *lc;
=20
-	snprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
=20
 	fd =3D open(path, O_RDONLY);
 	if (fd =3D=3D -1)
@@ -150,7 +150,7 @@ static int perf_pmu__parse_unit(struct perf_pmu_alias *=
alias, char *dir, char *n
 	ssize_t sret;
 	int fd;
=20
-	snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
=20
 	fd =3D open(path, O_RDONLY);
 	if (fd =3D=3D -1)
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 6a0a13d07a28..cd25de9690e1 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -257,7 +257,7 @@ static char *cpu_model(void)
 	if (file) {
 		while (fgets(buf, 255, file)) {
 			if (strstr(buf, "model name")) {
-				strncpy(cpu_m, &buf[13], 255);
+				strlcpy(cpu_m, &buf[13], 255);
 				break;
 			}
 		}
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 111663da72ad..ad0c85a63c80 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1555,31 +1555,33 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, stru=
ct gfn_to_hva_cache *ghc,
 	gfn_t end_gfn =3D (gpa + len - 1) >> PAGE_SHIFT;
 	gfn_t nr_pages_needed =3D end_gfn - start_gfn + 1;
 	gfn_t nr_pages_avail;
+	int r =3D start_gfn <=3D end_gfn ? 0 : -EINVAL;
=20
 	ghc->gpa =3D gpa;
 	ghc->generation =3D slots->generation;
 	ghc->len =3D len;
-	ghc->memslot =3D gfn_to_memslot(kvm, start_gfn);
-	ghc->hva =3D gfn_to_hva_many(ghc->memslot, start_gfn, NULL);
-	if (!kvm_is_error_hva(ghc->hva) && nr_pages_needed <=3D 1) {
+	ghc->hva =3D KVM_HVA_ERR_BAD;
+
+	/*
+	 * If the requested region crosses two memslots, we still
+	 * verify that the entire region is valid here.
+	 */
+	while (!r && start_gfn <=3D end_gfn) {
+		ghc->memslot =3D gfn_to_memslot(kvm, start_gfn);
+		ghc->hva =3D gfn_to_hva_many(ghc->memslot, start_gfn,
+					   &nr_pages_avail);
+		if (kvm_is_error_hva(ghc->hva))
+			r =3D -EFAULT;
+		start_gfn +=3D nr_pages_avail;
+	}
+
+	/* Use the slow path for cross page reads and writes. */
+	if (!r && nr_pages_needed =3D=3D 1)
 		ghc->hva +=3D offset;
-	} else {
-		/*
-		 * If the requested region crosses two memslots, we still
-		 * verify that the entire region is valid here.
-		 */
-		while (start_gfn <=3D end_gfn) {
-			ghc->memslot =3D gfn_to_memslot(kvm, start_gfn);
-			ghc->hva =3D gfn_to_hva_many(ghc->memslot, start_gfn,
-						   &nr_pages_avail);
-			if (kvm_is_error_hva(ghc->hva))
-				return -EFAULT;
-			start_gfn +=3D nr_pages_avail;
-		}
-		/* Use the slow path for cross page reads and writes. */
+	else
 		ghc->memslot =3D NULL;
-	}
-	return 0;
+
+	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_gfn_to_hva_cache_init);
=20

--xvzyoln6y5yjpv3x--

--ov3su3gvsvvxachn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlymVOkACgkQ57/I7JWG
EQlAHw/+NGX2ExP4QckSQhcD6TfPm806W+M9pre/MxCaT4IXJUDnK3Mzxd0ESQ2H
Bo92+y/3COCE3VcGP5W8Yz1oPsEr6NZf2khPNkRMVBBudZNokXU3TSoGZlkSB67x
PByjmgCo4b3Oz70N2ok2AktbuTWg0RgFpJP/OlECNZEsOB2FtfmkzeLAE1yfYXMf
u6u7gDo8TEC5GlVS/qksBc2blf12Pt2iqzqF6ThlQyP4WjCPF9emK6C3kzMOBLnv
MepM1CwRUFwHSFOzLHZBdIQftGOQxF0L/QWEYynkv+d68OL+or+glo4QvJpV/izt
TRHv/2dl84Kft2cHW/BAPQ4L7ylsJhWqWRJJiqzbRlyyV+tcFbm6Nm/z786Q29ED
B+mIV4y48OVOC3Jou3SUirjHjjutP4tGWj4eGWUftFIKyXfO6vj2XLp9B7pjTOMJ
Es3wNuRqjOqk0JEWCPX9AbHtHDzsFK1t0WaFAl+MDj4IEwz6sFnPahHhCZNEmH/8
fV+Cmuf7ixsE7t2UJjrSM1/6zacZlmldqtZzsowc/9PVNAxjpgB5/Dbht9ch3EBX
6VG3aGXuGqcOzPypwoLjANZ4uBkuJn4qcPg5NeBIyrlz+f9hY/NTx4Rzvj4yG3VJ
6f/TI9h0v/wMC6r1QJzZuVIsPF8DEqK7aY/PShLOuZocUGhZBds=
=7+Dn
-----END PGP SIGNATURE-----

--ov3su3gvsvvxachn--
