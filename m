Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1ECC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE652073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i298LxGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDQHbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:31:25 -0400
Received: from ozlabs.org ([203.11.71.1]:37353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQHbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:31:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kYnf25Kmz9s71;
        Wed, 17 Apr 2019 17:31:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555486278;
        bh=12pIEbVpuYUIDBLLLqLgiF+4Jf4CZkS/0HGdcu99MQY=;
        h=Date:From:To:Cc:Subject:From;
        b=i298LxGMoL8KnbPYGR5L0+eXHRz/6yNCDc7FZ5KcjyZQFzPRmsRXi0mmyPyLrKzyE
         yapoQrpbryVe5J1vT3G0HJ3mBzlWL8kC9nGhyOlTQo/tSgFASN4GX30Cw54NHZTXPi
         NrtcvUTLPpeWDLe/G1nZZbt6ZHaW8rTEoISMZPEqSycGJdPD5QH4PfRNt4ri+mxQsk
         PChNvO+WpGGDcArMNiOH9968pcyPNwSFTqLK8PQJtxFU7lBxbImAbjcJg+uPds2F9O
         4MtnTYEaoVr2tXSmbUFZN4dgKF9DA6cPzBIFggatL0AwU4p1AJwwXTdzesN+fBJxPA
         fQuwx2AEZVsLg==
Date:   Wed, 17 Apr 2019 17:31:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 17
Message-ID: <20190417173117.196b5ac6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lRtAr3jfa7_+8HSot6n3qTW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lRtAr3jfa7_+8HSot6n3qTW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: there will be no linux-next release on Friday, Monday or Thursday
April 25.

Changes since 20190416:

The bpf-next tree gained a conflict against the bpf tree.

The drm tree still had its build failure for which I disabled a driver.
The fix is in the drm-misc tree where I reenabled the driver.

The tpmdd tree lost its build failure.

The akpm-current tree gained 2 build failures for which I applied patches.

Non-merge commits (relative to Linus' tree): 7350
 7007 files changed, 245009 insertions(+), 121458 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
and sparc64 defconfig. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 298 trees (counting Linus' and 69 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (444fe9913539 Merge tag 'riscv-for-linus-5.1-rc6' of =
git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux)
Merging fixes/master (1995fa480636 kernel/compat.c: mark expected switch fa=
ll-throughs)
Merging kspp-gustavo/for-next/kspp (322b38ce3dd6 drm/nouveau/nvkm: mark exp=
ected switch fall-throughs)
Merging kbuild-current/fixes (79a3aaa7b82e Linux 5.1-rc3)
Merging arc-current/for-curr (55c0c4c793b5 ARC: memset: fix build with L1_C=
ACHE_SHIFT !=3D 6)
Merging arm-current/fixes (d410a8a49e3e ARM: 8849/1: NOMMU: Fix encodings f=
or PMSAv8's PRBAR4/PRLAR4)
Merging arm64-fixes/for-next/fixes (045afc24124d arm64: futex: Fix FUTEX_WA=
KE_OP atomic ops with non-zero result value)
Merging m68k-current/for-linus (28713169d879 m68k: Add -ffreestanding to CF=
LAGS)
Merging powerpc-fixes/fixes (cf7cf6977f53 powerpc/mm: Define MAX_PHYSMEM_BI=
TS for all 64-bit configs)
Merging sparc/master (7d762d69145a afs: Fix manually set volume location se=
rver list)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (614c70f35cd7 bnx2x: fix spelling mistake "dicline" -> "=
decline")
Merging bpf/master (fed68833fc53 libbpf: add binary to gitignore)
Merging ipsec/master (837f74116585 xfrm: update doc about xfrm[46]_gc_thres=
h)
Merging netfilter/master (5bdac418f33f netfilter: nat: fix icmp id randomiz=
ation)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (614c70f35cd7 bnx2x: fix spelling mistake "=
dicline" -> "decline")
Merging mac80211/master (e9f33a8fee53 mac80211: fix RX STBC override byte o=
rder)
Merging rdma-fixes/for-rc (d737b25b1ae0 IB/hfi1: Do not flush send queue in=
 the TID RDMA second leg)
Merging sound-current/for-linus (183ab39eb0ea ALSA: hda: Initialize power_s=
tate field properly)
Merging sound-asoc-fixes/for-linus (dc4060a5dc25 Linux 5.1-rc5)
Merging regmap-fixes/for-linus (dc1546f108cf Merge branch 'regmap-5.1' into=
 regmap-linus)
Merging regulator-fixes/for-linus (071c08c8e3e2 Merge branch 'regulator-5.1=
' into regulator-linus)
Merging spi-fixes/for-linus (a1bfbb10900d Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (d5bc73f34cc9 PCI: Fix issue with "pci=3Ddisa=
ble_acs_redir" parameter being ignored)
Merging driver-core.current/driver-core-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging tty.current/tty-linus (e00164a0f000 sc16is7xx: move label 'err_spi'=
 to correct section)
Merging usb.current/usb-linus (c01c348ecdc6 USB: core: Fix unterminated str=
ing returned by usb_string())
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (d5d60c3f25ab phy: fix platform_no_drv_owner.cocci warnin=
gs)
Merging staging.current/staging-linus (f4e97f5d4c9e staging: erofs: fix une=
xpected out-of-bound data access)
Merging char-misc.current/char-misc-linus (bb0925b283fe Merge tag 'extcon-f=
ixes-for-5.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/=
extcon into char-misc-linus)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (dc4060a5dc25 Linux 5.1-rc5)
Merging input-current/for-linus (bf2a7ca39fd3 Input: snvs_pwrkey - initiali=
ze necessary driver data before enabling IRQ)
Merging crypto-current/master (678cce4019d7 crypto: x86/poly1305 - fix over=
flow during partial reduction)
Merging ide/master (dc5c37736d16 drivers: ide: Kconfig: pedantic formatting)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (15ade5d2e777 Linux 5.1-rc4)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (79a3aaa7b82e Linux 5.1-rc3)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/mtd/fixes (d9b8a67b3b95 mtd: cfi: fix deadloop in cfi_cmd=
set_0002.c do_write_buffer)
Merging mfd-fixes/for-mfd-fixes (a05a2e7998ab mfd: sun6i-prcm: Allow to com=
pile with COMPILE_TEST)
Merging v4l-dvb-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging reset-fixes/reset/fixes (13e8a05b9224 reset: meson-audio-arb: Fix m=
issing .owner setting of reset_controller_dev)
Merging mips-fixes/mips-fixes (79b4a9cf0e2e MIPS: scall64-o32: Fix indirect=
 syscall number load)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (11e600a8c79d ARM: OMAP1: ams-delta: fix early boo=
t crash when LED support is disabled)
Merging kvm-fixes/master (7a223e06b1a4 KVM: x86: avoid misreporting level-t=
riggered irqs as edge-triggered in tracing)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (b88c5049219a hwmon: (occ) Fix extended status bi=
ts)
Merging nvdimm-fixes/libnvdimm-fixes (a7de824d947a Merge branch 'for-5.1/da=
x' into libnvdimm-for-next)
Merging btrfs-fixes/next-fixes (55a74492ebf1 Merge branch 'misc-5.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (f51dcd0f621c apparmorfs: fix use-after-free on sym=
link traversal)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (57f634b76a95 platform/x86: dell-laptop: fi=
x rfkill functionality)
Merging samsung-krzk-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (be549d491154 scsi: core: set result when the comm=
and cannot be dispatched)
Merging drm-fixes/drm-fixes (dc4060a5dc25 Linux 5.1-rc5)
Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden s=
etting for vega family)
Merging drm-intel-fixes/for-linux-next-fixes (f5c58ba18ab8 drm/i915: Restor=
e correct bxt_ddi_phy_calc_lane_lat_optim_mask() calculation)
Merging mmc-fixes/fixes (dc4060a5dc25 Linux 5.1-rc5)
Merging rtc-fixes/rtc-fixes (882c5e552ffd rtc: da9063: set uie_unsupported =
when relevant)
Merging gnss-fixes/gnss-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging hyperv-fixes/hyperv-fixes (a0033bd1eae4 Drivers: hv: vmbus: Remove =
the undesired put_cpu_ptr() in hv_synic_cleanup())
Merging drm-misc-fixes/for-linux-next-fixes (d15d9fd02575 drm: bridge: dw-h=
dmi: Fix overflow workaround for Rockchip SoCs)
Merging kbuild/for-next (c3236fb5a5fc Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (e43e2657fe77 x86/dma: Remove the x86_dma_fall=
back_dev hack)
Merging asm-generic/master (39036cd27273 arch: add pidfd and io_uring sysca=
lls everywhere)
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (4c2741ac5e10 Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (f645d37e281f Merge remote-tracking branch 'arm=
64/for-next/mmiowb' into for-next/core)
Merging arm-perf/for-next/perf (3d659e7d6513 arm64: perf_event: Remove wron=
gfully used inline)
Merging arm-soc/for-next (81b901d9009a ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (c779b69692d8 Merge branch 'v5.2/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (11c0dbdbf11b Merge branches 'at91-soc', 'at91-dt' a=
nd 'at91-defconfig' into at91-next)
CONFLICT (content): Merge conflict in arch/arm/mach-at91/pm.c
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (c42a3b7bd776 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (d542127adb0c Merge branch 'v5.0-next/soc' into f=
or-next)
Merging mvebu/for-next (c51f7f863552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (55099f43446e Merge branch 'omap-for-v5.1/fixes' into=
 for-next)
Merging reset/reset/next (d005aa750c9b reset: fix linux/reset.h errors)
Merging qcom/for-next (52669757a5ac Merge branch 'drivers-for-5.2' into all=
-for-5.2)
Merging renesas/next (1b4daf1a0893 Merge branch 'arm64-dt-for-v5.2' into ne=
xt)
Merging rockchip/for-next (ea1f8feb26d3 Merge branch 'v5.2-clk/next' into f=
or-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (0b428d14b485 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (202fcc634b84 Merge branches 'sunxi/dt-for-5.2=
', 'sunxi/dt64-for-5.2' and 'sunxi/h3-h5-for-5.2' into sunxi/for-next)
Merging tegra/for-next (08746b5db23d Merge branch for-5.2/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (21eb35a1ae4d Merge commit 'tags/clk-fixes-for-linus^0=
' into clk-next)
Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add ga=
te clock for ADC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (cd51a044aa0d csky: Support vmlinux bootup with MMU=
 off)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (733df11cfc36 m68k: defconfig: Update defconfigs for =
v5.1-rc1)
Merging m68knommu/for-next (dc4060a5dc25 Linux 5.1-rc5)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (16b22f85bca2 Revert "MIPS: ralink: fix cpu clock of=
 mt7621 and add dt clk devices")
Merging nds32/next (4e8fa54d3d99 nds32: fix semicolon code style issue)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (da1c1c649745 parisc: Use ldcw instruction for S=
MP spinlock release barrier)
Merging powerpc/next (8c2ffd917477 Linux 5.1-rc2)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (15ade5d2e777 Linux 5.1-rc4)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (913140e22156 s390: zcrypt: initialize variables befo=
re_use)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (aea05eb56e47 um: Fix for a possible OOPS in ubd ini=
tialization)
Merging xtensa/xtensa-for-next (a26a70426e9b Merge branch 'xtensa-5.1-fixes=
' into xtensa-for-next)
Merging fscrypt/master (129ca2d2a83f MAINTAINERS: add Eric Biggers as an fs=
crypt maintainer)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (db73037d863b Merge branch 'for-next-stale-201=
90415' into for-next-20190415)
Merging ceph/master (daf5cc27eed9 ceph: fix use-after-free on symlink trave=
rsal)
Merging cifs/for-next (dfd6bc409925 cifs: fix bi-directional fsctl passthro=
ugh calls)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (9328d3efaed3 Pull reiserfs cleanup.)
Merging ext4/dev (742b06b5628f jbd2: check superblock mapped prior to commi=
tting)
Merging f2fs/dev (a96108b10198 f2fs: fix to consider multiple device for re=
adonly check)
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (dc4060a5dc25 Linux 5.1-rc5)
Merging nfs-anna/linux-next (5602c11defd6 NFS: Remove redundant open contex=
t from nfs_page)
Merging nfsd/nfsd-next (b8fab687541c nfsd: knfsd must use the container use=
r namespace)
Merging orangefs/for-next (7dccb4027ef9 orangefs: copy Orangefs-sized block=
s into the pagecache if possible.)
Merging overlayfs/overlayfs-next (993a0b2aec52 ovl: Do not lose security.ca=
pability xattr over metadata file copy-up)
Merging ubifs/linux-next (5578e48e5c0b ubi: wl: Silence uninitialized varia=
ble warning)
Merging v9fs/9p-next (bb06c388fa20 9p/net: fix memory leak in p9_client_cre=
ate)
Merging xfs/for-next (2032a8a27b5c xfs: serialize unaligned dio writes agai=
nst all other dio writes)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (af467ef6c590 Merge branches 'work.misc' and 'work.dca=
che' into for-next)
Merging printk/for-next (0142ada02a43 Merge branch 'for-5.2' into for-next)
CONFLICT (content): Merge conflict in mm/memblock.c
CONFLICT (content): Merge conflict in include/trace/events/sunrpc.h
CONFLICT (content): Merge conflict in drivers/base/power/main.c
Merging pci/next (5cb8ce806319 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (6659efec5011 Merge branch 'for-5.2/u2fzero' into for-=
next)
Merging i2c/i2c/for-next (1ec408609eca Merge branch 'i2c/for-5.2' into i2c/=
for-next)
Merging i3c/i3c/next (124dbd750da4 i3c: master: dw: remove dead code from d=
w_i3c_master_*_xfers())
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (d2a9b01ff682 hwmon: (occ) Add more detail=
s to Kconfig help text)
Merging jc_docs/docs-next (5d2a2c59108a docs: speculation.txt: mark example=
 blocks as such)
Merging v4l-dvb/master (1c3ec30bb230 media: index.rst: exclude Indexes sect=
ion from latex/pdf output)
Merging v4l-dvb-next/master (81527254e151 media: seco: depend on CONFIG_RC_=
CORE=3Dy when not a module)
Merging fbdev/fbdev-for-next (261ac4ddfa9f video: fbdev: atmel_lcdfb: remov=
e set but not used variable 'pdata')
Merging pm/linux-next (4d3219aee908 Merge branch 'pm-misc' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c1d1090c3c76 cpufreq: maple: Re=
move redundant code from maple_cpufreq_init())
Merging cpupower/cpupower (8c2ffd917477 Linux 5.1-rc2)
Merging opp/opp/linux-next (2f36bde0fc8f OPP: Introduce dev_pm_opp_find_fre=
q_ceil_by_volt())
Merging thermal/next (2d7c4e17811f Merge branches 'fixes' and 'thermal-inte=
l' into next)
Merging thermal-soc/next (8834f5600cf3 Linux 5.0-rc5)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (54cca4bad076 dlm: allow binding to all network interfaces)
Merging swiotlb/linux-next (8395c154abb7 swiotlb: dump used and total slots=
 when swiotlb buffer is full (v2))
Merging rdma/for-next (fb652d329902 RDMA/mlx5: Remove VF representor profil=
e)
Merging net-next/master (432bc230700f Merge branch 'hsr-next')
CONFLICT (content): Merge conflict in tools/testing/selftests/netfilter/nft=
_nat.sh
CONFLICT (content): Merge conflict in tools/testing/selftests/netfilter/Mak=
efile
CONFLICT (content): Merge conflict in net/smc/af_smc.c
CONFLICT (content): Merge conflict in .mailmap
Merging bpf-next/master (02a8c817a316 bpf: add map helper functions push, p=
op, peek in more BPF programs)
CONFLICT (content): Merge conflict in tools/bpf/bpftool/map.c
Merging ipsec-next/master (e54d1527658f xfrm: kconfig: make xfrm depend on =
inet)
Merging mlx5-next/mlx5-next (d9cb06759eca net/mlx5: E-Switch, add a new pri=
o to be used by the RDMA side)
Merging netfilter-next/master (432bc230700f Merge branch 'hsr-next')
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (bdfc4027de15 rtlwifi: rtl8723ae: Make=
 rtl8723e_dm_refresh_rate_adaptive_mask static)
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/pc=
ie/drv.c
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/iw=
l-trans.h
Merging bluetooth/master (bbcece3d418c Bluetooth: mediatek: Fixed incorrect=
 type in assignment)
Merging mac80211-next/master (9eae47c5d122 cfg80211: don't pass pointer to =
pointer unnecessarily)
CONFLICT (content): Merge conflict in net/mac80211/tx.c
Merging gfs2/for-next (684349df4d42 gf2: Rename gfs2_trans_{add_unrevoke =
=3D> remove_revoke})
Merging mtd/mtd/next (9e98c678c2d6 Linux 5.1-rc1)
Merging nand/nand/next (e6a35ef45a03 mtd: nand: Remove useless line in Kcon=
fig)
Merging spi-nor/spi-nor/next (dcb4b22eeaf4 spi-nor: s25fl512s supports regi=
on locking)
Merging crypto/master (f1b70d16389d crypto: mxc-scc - Remove broken driver)
Merging drm/drm-next (f06ddb53096b BackMerge v5.1-rc5 into drm-next)
Applying: disable the ASPEED GFX driver due to powerpc build failure
Merging amdgpu/drm-next (f55be0be5b72 drm/amd/display: Add profiling tools =
for bandwidth validation)
Merging drm-intel/for-linux-next (b16b2a2f70b1 drm/i915: fully convert the =
IRQ initialization macros to intel_uncore)
Merging drm-tegra/drm/tegra/for-next (11c632e1cfd3 drm/tegra: sor: Implemen=
t acquire/release for reset)
Merging drm-misc/for-linux-next (f3fb20074e02 drm/lima: Use the drm_gem_fen=
ce_array_add helpers for our deps.)
CONFLICT (content): Merge conflict in drivers/gpu/drm/aspeed/Kconfig
Merging drm-msm/msm-next (5f280964c0ad drm/msm: a5xx: fix possible object r=
eference leak)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (e8e3cc7d39ff MAINTAINERS: Fix pattern=
 for Documentation path for Arm Mali Komeda)
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (9e05352340d3 drm/etnaviv: potential NULL dere=
ference)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (533df0884d83 Merge branch 'regmap-5.2' into regmap=
-next)
Merging sound/for-next (b5fd12d6c0fc ALSA: seq: Correct unlock sequence at =
snd_seq_client_ioctl_unlock())
Merging sound-asoc/for-next (f33cd67d22df Merge branch 'asoc-5.2' into asoc=
-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging modules/modules-next (41e72eeff32c module: add stubs for within_mod=
ule functions)
Merging input/next (a5f50c501321 Input: goodix - add GT5663 CTP support)
Merging block/for-next (f605c48a086c Merge branch 'for-5.2/block' into for-=
next)
Merging device-mapper/for-next (4ed319c6ac08 dm integrity: fix deadlock wit=
h overlapping I/O)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (71c733c4e1ae mmc: tegra: add sdhci tegra suspend and resu=
me)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (7f042743306c mfd: cros_ec: Instantiate the CrOS U=
SB PD logger driver)
Merging backlight/for-backlight-next (a6d6a589cb09 video: lcd: Remove usele=
ss BACKLIGHT_CLASS_DEVICE dependencies)
Merging battery/for-next (7d90fcc14a25 power: supply: cpcap-charger: Fix po=
intless EPROBE_DEFER warnings)
Merging regulator/for-next (ada2be980cca Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (d6d060788e0a Merge branch 'next-smack' into =
next-testing)
Merging apparmor/apparmor-next (145a0ef21c8e apparmor: fix blob compression=
 when ns is forced on a policy load)
Merging integrity/next-integrity (a2ffe5774e8e selftests/kexec: update get_=
secureboot_mode)
Merging selinux/next (c750e6929d3c selinux: Check address length before rea=
ding address family)
Merging tpmdd/next (ff89e2f4b34d tpm: Actually fail on TPM errors during "g=
et random")
Merging watchdog/master (458c8961c194 watchdog: w83877f_wdt: Mark expected =
switch fall-through)
Merging iommu/next (9c39a1abe297 Merge branches 'iommu/fixes', 'arm/tegra',=
 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0cfd027be1d6 vfio_pci: Enable memory accesses before cal=
ling pci_map_rom)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (7e8eda734d30 ntp: Audit NTP parameters adjustment)
CONFLICT (content): Merge conflict in kernel/seccomp.c
CONFLICT (content): Merge conflict in arch/mips/kernel/ptrace.c
Merging devicetree/for-next (af3be70a3211 of: Improve of_phandle_iterator_n=
ext() error message)
Merging mailbox/mailbox-for-next (17b860bbfc84 mailbox: imx: keep MU irq wo=
rking during suspend/resume)
Merging spi/for-next (d337d253f3f1 Merge branch 'spi-5.2' into spi-next)
Merging tip/auto-latest (c8d9806ebb40 Merge branch 'core/core')
CONFLICT (content): Merge conflict in mm/kasan/Makefile
CONFLICT (content): Merge conflict in arch/s390/include/asm/Kbuild
Merging clockevents/clockevents/next (dbfc6db7ba46 soc/tegra: default selec=
t TEGRA_TIMER for Tegra210)
Merging edac-amd/for-next (74676a8e247a arm64: dts: stratix10: Use new Stra=
tix10 EDAC bindings)
Merging irqchip/irq/irqchip-next (fca269f201a8 irqchip/mbigen: Don't clear =
eventid when freeing an MSI)
Merging ftrace/for-next (4f5fbd78a7b4 rcu: validate arguments for rcu trace=
points)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (c110ae578ca0 kvm: move KVM_CAP_NR_MEMSLOTS to commo=
n code)
Merging kvm-arm/next (5d8d4af24460 arm64: KVM: Fix system register enumerat=
ion)
Merging kvm-ppc/kvm-ppc-next (2b57ecd0208f KVM: PPC: Book3S: Add count cach=
e flush parameters to kvmppc_get_cpu_char())
Merging kvms390/next (11ba5961a215 KVM: s390: add debug logging for cpu mod=
el subfunctions)
Merging xen-tip/linux-next (42d8644bd77d xen: Prevent buffer overflow in pr=
ivcmd ioctl)
Merging percpu/for-next (cb453ce4846b Merge branch 'for-5.2' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (98e2630284ab platform/x86: alienware-wmi: fix=
 kfree on potentially uninitialized pointer)
Merging chrome-platform/for-next (2de89fd98958 platform/chrome: cros_ec: Ad=
d EC host command support using rpmsg)
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (174c9526ac89 Merge tag 'lm3532-driver-improvements' =
into for-next)
Merging ipmi/for-next (ac04cad9f5e6 ipmi: avoid atomic_inc in exit function)
Merging driver-core/driver-core-next (5de363b66a37 drivers: base: power: ad=
d proper SPDX identifiers on files that did not have them.)
Merging usb/usb-next (8cdfd068c1ea Merge 5.1-rc3 into usb-next)
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (f64c3ab23068 USB: serial: pl2303: fix tranceiv=
er suspend mode)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (46c12f846a2a dt-bindings: phy: Add a new property dr=
ive-impedance-ohm for RK's emmc PHY)
Merging tty/tty-next (f16aa97d3f57 tty: fix up a few remaining files withou=
t SPDX identifiers)
Merging char-misc/char-misc-next (d358b1733fc3 chardev: update comment base=
d on the code)
CONFLICT (content): Merge conflict in drivers/misc/fastrpc.c
Merging extcon/extcon-next (00053de52231 extcon: arizona: Disable mic detec=
t if running when driver is removed)
Merging soundwire/next (4abbd783d126 soundwire: intel: fix implicit header =
use of module.h/export.h)
Merging thunderbolt/next (fd21b79e541e thunderbolt: Fix to check the return=
 value of kmemdup)
Merging staging/staging-next (e1f79c148c65 Staging: rtl8723bs: Remove an un=
used struct tx_pending_t)
CONFLICT (modify/delete): drivers/staging/mt7621-spi/Makefile deleted in HE=
AD and modified in staging/staging-next. Version staging/staging-next of dr=
ivers/staging/mt7621-spi/Makefile left in tree.
CONFLICT (modify/delete): drivers/staging/mt7621-spi/Kconfig deleted in HEA=
D and modified in staging/staging-next. Version staging/staging-next of dri=
vers/staging/mt7621-spi/Kconfig left in tree.
CONFLICT (modify/delete): drivers/staging/media/mt9t031/Makefile deleted in=
 HEAD and modified in staging/staging-next. Version staging/staging-next of=
 drivers/staging/media/mt9t031/Makefile left in tree.
CONFLICT (modify/delete): drivers/staging/media/mt9t031/Kconfig deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/mt9t031/Kconfig left in tree.
CONFLICT (content): Merge conflict in drivers/spi/spi-mt7621.c
CONFLICT (content): Merge conflict in drivers/iio/industrialio-buffer.c
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ven=
dor-prefixes.txt
$ git rm -f drivers/staging/media/mt9t031/Kconfig drivers/staging/media/mt9=
t031/Makefile drivers/staging/mt7621-spi/Kconfig drivers/staging/mt7621-spi=
/Makefile
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (3901460f7782 Merge branch 'icc-qcs404' into icc-next)
Merging slave-dma/next (23b846396b95 dmaengine: axi-dmac: extend support fo=
r ZynqMP arch)
Merging cgroup/for-next (4c38f5ca8455 Merge branch 'for-5.2' into for-next)
Merging scsi/for-next (94a8f3980a4e Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/sd.c
CONFLICT (content): Merge conflict in drivers/scsi/lpfc/lpfc_els.c
Merging scsi-mkp/for-next (948e922fc446 scsi: core: map PQ=3D1, PDT=3Dother=
 values to SCSI_SCAN_TARGET_PRESENT)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (4e76105b74c1 virtio: use dependent_ptr_mb)
CONFLICT (content): Merge conflict in drivers/pci/of.c
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (fad71ca20f45 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (b0d2569d8276 gpio: mlxbf: remove unused in=
cluding <linux/version.h>)
Merging pinctrl/for-next (96900dd31306 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (9ff06679e109 pwm: sysfs: fix typo "its" -> "it's")
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (e14d314c7a48 selftests: cgroup: fix cleanup path in=
 test_memcg_subtree_control())
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (55ac3597df3f Merge branch 'for-5.1-upstream-=
fixes' into for-next)
Merging coresight/next (d5d246a56af0 coresight: Merge the static and dynami=
c replicator drivers)
Merging rtc/rtc-next (9fc0fd5077ba rtc: mc13xxx: fix style issue)
CONFLICT (content): Merge conflict in drivers/rtc/rtc-omap.c
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (d333bad1f6f3 dt-bindings: at24: add Renesas R1E=
X24016)
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (50ceaa95ea09 lib: Introduce test_stackinit modu=
le)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (7cc10c5cb143 gnss: ubx: add u-blox,neo-6m compatibl=
e)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (80471330ec58 slimbus: fix a NULL pointer derefere=
nce in of_qcom_slim_ngd_register)
Merging nvmem/for-next (f7e49c81df8e nvmem: sunxi_sid: Support SID on H6)
Merging xarray/xarray (dd12805ed1db XArray: Remove radix tree compatibility)
Merging hyperv/hyperv-next (396ae57ef1ef Drivers: hv: vmbus: Expose counter=
s for interrupts and full conditions)
Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make backl=
ight initial state configurable)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging akpm-current/current (d0dca67d9dfd ipc-do-cyclic-id-allocation-for-=
the-ipc-object-fix)
Applying: fix "mm: fix inactive list balancing between NUMA nodes and cgrou=
ps"
Applying: fix "fs/binfmt_elf.c: move brk out of mmap when doing direct load=
er exec"
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: scripts/atomic/gen-atomics.sh: don't assume that scripts are exec=
utable
Applying: fs/coda/psdev.c: remove duplicate header
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: fs/cachefiles/namei.c: remove duplicate header
Applying: fs/block_dev.c: Remove duplicate header
Applying: kernel, resource: use resource_overlaps() to simplify region_inte=
rsects()
Applying: treewide: replace #include <asm/sizes.h> with #include <linux/siz=
es.h>
Applying: arch: remove <asm/sizes.h> amd <asm-generic/sizes.h>
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm-rename-ambiguously-named-memorystat-counters-and-functions-fix
Applying: mm, memcg: consider subtrees in memory.events
Applying: drivers/virt/fsl_hypervisor.c: dereferencing error pointers in io=
ctl
Applying: drivers/virt/fsl_hypervisor.c: prevent integer overflow in ioctl
Applying: mm: memcontrol: make cgroup stats and events query API explicitly=
 local
Applying: mm: memcontrol: move stat/event counting functions out-of-line
Applying: mm: memcontrol: fix recursive statistics correctness & scalabilty
Applying: mm: memcontrol: fix NUMA round-robin reclaim at intermediate level
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (c60c0508aa38 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/lRtAr3jfa7_+8HSot6n3qTW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly21kUACgkQAVBC80lX
0GxG4AgAoFLcjTGvBr7awmVC8F0nUQSPgSp5lMb8Pl/EtqAlI/Z7WgZ6pWs+NmPa
s7gEclYEAUMrqCx7F3L5LOeCBs9PZqTIuSjV4BGbALdtkvcUX3JGDj6j4C4JHjvB
QP+vs7Gj1mD7jusiiuSsXKq00V7Hrl3bD7ZGLCVUzh4UICHp91yVQq4Ml5tg1ilA
W3BnYSu2OU10FZMPNO6F+2EE9AixEOWiAnWi+ys9uDIyDNKEU7unWYRhT7titeMQ
wvXpmBrYZ3u1S8Q/AxEC8OTl6Zvc6yLg6d5+xgKsip6DA6Ypt7vt2VyTnWQW+Q4E
1eCfQ3QZ+YF0X95JJYCZNYuhuDHOTg==
=Z01v
-----END PGP SIGNATURE-----

--Sig_/lRtAr3jfa7_+8HSot6n3qTW--
