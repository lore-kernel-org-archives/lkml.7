Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FCAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D820656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fkEqJ8fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfDXJMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:12:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42883 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfDXJMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:12:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pvjM23ghz9s47;
        Wed, 24 Apr 2019 19:12:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556097159;
        bh=iaGgKiuPS/vkpgiKxJQ/7OjxoWyju0IgBF7E8Cg7mbo=;
        h=Date:From:To:Cc:Subject:From;
        b=fkEqJ8fuhsvR5KfxUJXOnwPTyIf89XZqAONxCv/HHi39xriDa7Mn99ogvuZup2y5E
         dLv84rI5TMbCmc+Ts4f+krZjbwCHCsZdg+jj8nV0PGAhuWDNgLowqeyMJPMW+Pmbno
         VNMKXtS/uhkKaSS5EQP/5BxIZcWivjcd7FFxg1fnR7aFpJyuzdKWitFzzj97UDlHdQ
         vZnoi2UjXLi50xLx+ErGBnxQ1YA2EV0SkALqWS+Jz1bIshBw30MY5swvAG/XyDo66E
         smBw3dezrf4mtNROAzTtwjyiR8DuTRci/N9HCF+NjSl93VGOlpClO+C3hJPFL3EgfH
         z9vRR6Zxwxdfg==
Date:   Wed, 24 Apr 2019 19:12:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 24
Message-ID: <20190424191237.0a327e70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qyaC_rvjDy=LDlA.RF/igE3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qyaC_rvjDy=LDlA.RF/igE3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: there will be no linux-next release on Thursday April 25.

Changes since 20190423:

The at91 tree lost its build failure.

The mediatek tree gained a conflict against Linus' tree.

The qcom tree gained a build failure so I used the version from
next-20190423.

The rockchip tree gained a conflict against the amlogic tree.

The tegra tree gained a conflict against the rockchip tree.

The next-next tree still had its build failure for which I applied a patch.

The drm tree lost its build failure.

The tip tree gained a conflict against the asm-generic tree.

The akpm-current tree gained a conflict against the s390 tree.

Non-merge commits (relative to Linus' tree): 8553
 8312 files changed, 309618 insertions(+), 141755 deletions(-)

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
Merging origin/master (12a54b150fb5 Merge tag 'nfsd-5.1-1' of git://linux-n=
fs.org/~bfields/linux)
Merging fixes/master (1995fa480636 kernel/compat.c: mark expected switch fa=
ll-throughs)
Merging kspp-gustavo/for-next/kspp (ccaa75187a5f memstick: mark expected sw=
itch fall-throughs)
Merging kbuild-current/fixes (79a3aaa7b82e Linux 5.1-rc3)
Merging arc-current/for-curr (55c0c4c793b5 ARC: memset: fix build with L1_C=
ACHE_SHIFT !=3D 6)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (4e69ecf4da1e arm64/module: ftrace: deal=
 with place relative nature of PLTs)
Merging m68k-current/for-linus (28713169d879 m68k: Add -ffreestanding to CF=
LAGS)
Merging powerpc-fixes/fixes (7a3a4d763837 powerpc/mm_iommu: Allow pinning l=
arge regions)
Merging sparc/master (7d762d69145a afs: Fix manually set volume location se=
rver list)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (d04830531d0c spi: ST ST95HF NFC: declare missing of tab=
le)
Merging bpf/master (fed68833fc53 libbpf: add binary to gitignore)
Merging ipsec/master (837f74116585 xfrm: update doc about xfrm[46]_gc_thres=
h)
Merging netfilter/master (b561af36b184 net: stmmac: move stmmac_check_ether=
_addr() to driver probe)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (614c70f35cd7 bnx2x: fix spelling mistake "=
dicline" -> "decline")
Merging mac80211/master (517879147493 mac80211: don't attempt to rename ERR=
_PTR() debugfs dirs)
Merging rdma-fixes/for-rc (7249c8ea227a IB/mlx5: Fix scatter to CQE in DCT =
QP creation)
Merging sound-current/for-linus (b26e36b7ef36 ALSA: hda/realtek - add two m=
ore pin configuration sets to quirk table)
Merging sound-asoc-fixes/for-linus (39a4d5d1d73c Merge branch 'asoc-5.1' in=
to asoc-linus)
Merging regmap-fixes/for-linus (dc1546f108cf Merge branch 'regmap-5.1' into=
 regmap-linus)
Merging regulator-fixes/for-linus (423cfbeb8f67 Merge branch 'regulator-5.1=
' into regulator-linus)
Merging spi-fixes/for-linus (b9b8656bc4aa Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (d5bc73f34cc9 PCI: Fix issue with "pci=3Ddisa=
ble_acs_redir" parameter being ignored)
Merging driver-core.current/driver-core-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging tty.current/tty-linus (085b7755808a Linux 5.1-rc6)
Merging usb.current/usb-linus (c2b71462d294 USB: core: Fix bug caused by du=
plicate interface PM usage counter)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (e6f32efb1b12 phy: sun4i-usb: Make sure to disable PHY0 p=
assby for peripheral mode)
Merging staging.current/staging-linus (085b7755808a Linux 5.1-rc6)
Merging char-misc.current/char-misc-linus (085b7755808a Linux 5.1-rc6)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (085b7755808a Linux 5.1-rc6)
Merging input-current/for-linus (bf2a7ca39fd3 Input: snvs_pwrkey - initiali=
ze necessary driver data before enabling IRQ)
Merging crypto-current/master (b257b48cd583 crypto: lrw - Fix atomic sleep =
when walking skcipher)
Merging ide/master (dc5c37736d16 drivers: ide: Kconfig: pedantic formatting)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (15ade5d2e777 Linux 5.1-rc4)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (6e7da7477534 dmaengine: sh: rcar-dmac: Fix g=
litch in dmaengine_tx_status)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/mtd/fixes (d9b8a67b3b95 mtd: cfi: fix deadloop in cfi_cmd=
set_0002.c do_write_buffer)
Merging mfd-fixes/for-mfd-fixes (a05a2e7998ab mfd: sun6i-prcm: Allow to com=
pile with COMPILE_TEST)
Merging v4l-dvb-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging reset-fixes/reset/fixes (13e8a05b9224 reset: meson-audio-arb: Fix m=
issing .owner setting of reset_controller_dev)
Merging mips-fixes/mips-fixes (a1e8783db8e0 MIPS: perf: ath79: Fix perfcoun=
t IRQ assignment)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (11e600a8c79d ARM: OMAP1: ams-delta: fix early boo=
t crash when LED support is disabled)
Merging kvm-fixes/master (b6aa57c69cb2 KVM: lapic: Convert guest TSC to hos=
t time domain if necessary)
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
Merging scsi-fixes/fixes (144ec97493af scsi: aic7xxx: fix EISA support)
Merging drm-fixes/drm-fixes (00fd14ff3017 Merge branch 'drm-fixes-5.1' of g=
it://people.freedesktop.org/~agd5f/linux into drm-fixes)
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
Merging drm-misc-fixes/for-linux-next-fixes (f5a9ed867c83 drm/sun4i: Fix co=
mponent unbinding and component master deletion)
Merging kbuild/for-next (c3236fb5a5fc Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (e43e2657fe77 x86/dma: Remove the x86_dma_fall=
back_dev hack)
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (3d3c616177cc Merge branches 'fixes' and 'misc' into f=
or-next)
Merging arm64/for-next/core (ca0c69b0d9d0 Merge remote-tracking branch 'arm=
64/for-next/mmiowb' into for-next/core)
Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU hot=
plug handling)
Merging arm-soc/for-next (81b901d9009a ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (c779b69692d8 Merge branch 'v5.2/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (ac650130c227 Merge branches 'at91-soc', 'at91-dt' a=
nd 'at91-defconfig' into at91-next)
CONFLICT (content): Merge conflict in arch/arm/mach-at91/pm.c
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (7119403f9617 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ser=
ial/mtk-uart.txt
Merging mvebu/for-next (f74621b369e6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (55099f43446e Merge branch 'omap-for-v5.1/fixes' into=
 for-next)
Merging reset/reset/next (d005aa750c9b reset: fix linux/reset.h errors)
Merging qcom/for-next (b1a8ddb51134 Merge branch 'dts-for-5.2' into done-fo=
r-5.2)
$ git reset --hard HEAD^
Merging next-20190423 version of qcom
Merging renesas/next (982700f80241 Merge branch 'arm-dt-for-v5.2' into next)
Merging rockchip/for-next (9c539071723e Merge branch 'v5.2-clk/next' into f=
or-next)
CONFLICT (content): Merge conflict in arch/arm/configs/multi_v7_defconfig
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (0b428d14b485 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (613c4ce8fddb Merge branch 'sunxi/dt-for-5.2' =
into sunxi/for-next)
Merging tegra/for-next (b31c477a9892 Merge branch for-5.2/arm64/defconfig i=
nto for-next)
CONFLICT (content): Merge conflict in arch/arm/configs/multi_v7_defconfig
Merging clk/clk-next (6e356fb02bae Merge branch 'clk-parent-rewrite-1' into=
 clk-next)
Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add ga=
te clock for ADC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (a691f3334d58 csky/syscall_trace: Fixup return proc=
essing flow)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (733df11cfc36 m68k: defconfig: Update defconfigs for =
v5.1-rc1)
Merging m68knommu/for-next (dc4060a5dc25 Linux 5.1-rc5)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (1e0221374e30 mips: vdso: drop unnecessary cc-ldopti=
on)
Merging nds32/next (4e8fa54d3d99 nds32: fix semicolon code style issue)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (05189d28af21 parisc: Use ldcw instruction for S=
MP spinlock release barrier)
Merging powerpc/next (26ad26718dfa powerpc/mm: Fix section mismatch warning)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (15ade5d2e777 Linux 5.1-rc4)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (1c410fd6a561 s390/cpum_cf_diag: Add support for CPU-=
MF SVN 6)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (aea05eb56e47 um: Fix for a possible OOPS in ubd ini=
tialization)
Merging xtensa/xtensa-for-next (a26a70426e9b Merge branch 'xtensa-5.1-fixes=
' into xtensa-for-next)
Merging fscrypt/master (b01531db6cec fscrypt: fix race where ->lookup() mar=
ks plaintext dentry as ciphertext)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (db73037d863b Merge branch 'for-next-stale-201=
90415' into for-next-20190415)
Merging ceph/master (37659182bff1 ceph: fix ci->i_head_snapc leak)
Merging cifs/for-next (8f665199fa70 SMB3: allowing extending size if alloca=
ting on non-sparse file)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (eba6a2e1e1d7 Pull udf cleanup.)
Merging ext4/dev (742b06b5628f jbd2: check superblock mapped prior to commi=
tting)
Merging f2fs/dev (fd3ebe90089a f2fs: fix to be aware of readonly device in =
write_checkpoint())
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (7142eaa58b49 Merge tag 'mips_fixes_5.1_3' of git://=
git.kernel.org/pub/scm/linux/kernel/git/mips/linux)
Merging nfs-anna/linux-next (27695c523244 xprtrdma: Remove stale comment)
Merging nfsd/nfsd-next (7869f7723009 nfsd: fh_drop_write in nfsd_unlink)
Merging orangefs/for-next (7dccb4027ef9 orangefs: copy Orangefs-sized block=
s into the pagecache if possible.)
Merging overlayfs/overlayfs-next (993a0b2aec52 ovl: Do not lose security.ca=
pability xattr over metadata file copy-up)
Merging ubifs/linux-next (5578e48e5c0b ubi: wl: Silence uninitialized varia=
ble warning)
Merging v9fs/9p-next (bb06c388fa20 9p/net: fix memory leak in p9_client_cre=
ate)
Merging xfs/for-next (3994fc489575 xfs: merge adjacent io completions of th=
e same type)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (af467ef6c590 Merge branches 'work.misc' and 'work.dca=
che' into for-next)
Merging printk/for-next (0142ada02a43 Merge branch 'for-5.2' into for-next)
CONFLICT (content): Merge conflict in mm/memblock.c
CONFLICT (content): Merge conflict in include/trace/events/sunrpc.h
CONFLICT (content): Merge conflict in drivers/base/power/main.c
Merging pci/next (4eb4f6e8c553 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (97a39ed4bfc4 Merge branch 'for-5.2/logitech' into for=
-next)
Merging i2c/i2c/for-next (5dc8e322f1a8 Merge branch 'i2c/for-current-fixed'=
 into i2c/for-next)
Merging i3c/i3c/next (124dbd750da4 i3c: master: dw: remove dead code from d=
w_i3c_master_*_xfers())
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (a60170000338 hwmon: (s3c) Use dev_get_drv=
data())
Merging jc_docs/docs-next (03f8264c9b60 docs/zh_CN: fix typos in 1.Intro.rs=
t file)
Merging v4l-dvb/master (a4dfc8a24796 media: MAINTAINERS: Update AO CEC with=
 ao-cec-g12a driver)
Merging v4l-dvb-next/master (81527254e151 media: seco: depend on CONFIG_RC_=
CORE=3Dy when not a module)
CONFLICT (content): Merge conflict in drivers/media/platform/Kconfig
Merging fbdev/fbdev-for-next (261ac4ddfa9f video: fbdev: atmel_lcdfb: remov=
e set but not used variable 'pdata')
Merging pm/linux-next (91b112cf3b59 Merge branch 'pm-devfreq' into linux-ne=
xt)
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
Merging rdma/for-next (ff5eefe6d3a3 RDMA/cxgb4: Fix spelling mistake "immed=
ate" -> "immediate")
Merging net-next/master (6b18bdfdba2c Merge branch 'ipv6-fib6_ref-conversio=
n-to-refcount_t')
CONFLICT (content): Merge conflict in tools/testing/selftests/netfilter/nft=
_nat.sh
CONFLICT (content): Merge conflict in tools/testing/selftests/netfilter/Mak=
efile
CONFLICT (content): Merge conflict in tools/bpf/bpftool/map.c
CONFLICT (content): Merge conflict in .mailmap
Applying: net: fix sparc64 compilation of sock_gettstamp
Merging bpf-next/master (a21b48a2f2af Merge branch 'bpf-proto-fixes')
Merging ipsec-next/master (e54d1527658f xfrm: kconfig: make xfrm depend on =
inet)
Merging mlx5-next/mlx5-next (d9cb06759eca net/mlx5: E-Switch, add a new pri=
o to be used by the RDMA side)
Merging netfilter-next/master (17f780b36426 Merge branch 'dpaa2-eth-Add-flo=
w-steering-support-without-masking')
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (db5e323feb5f Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (ecf2b768bd11 Bluetooth: hci_qca: Fix crash with n=
on-serdev devices)
Merging mac80211-next/master (b05d38fb98c1 nl80211: do a struct assignment =
to radar_chandef instead of memcpy())
CONFLICT (content): Merge conflict in net/mac80211/tx.c
Merging gfs2/for-next (8b9915bea3fa gfs2: Rename gfs2_trans_{add_unrevoke =
=3D> remove_revoke})
Merging mtd/mtd/next (9e98c678c2d6 Linux 5.1-rc1)
Merging nand/nand/next (1c14fe2167ef mtd: nandsim: switch to exec_op interf=
ace)
Merging spi-nor/spi-nor/next (dcb4b22eeaf4 spi-nor: s25fl512s supports regi=
on locking)
Merging crypto/master (6a1faa4a43f5 crypto: ccm - fix incompatibility betwe=
en "ccm" and "ccm_base")
Merging drm/drm-next (70b5f09e4389 Merge tag 'drm-msm-next-2019-04-21' of h=
ttps://gitlab.freedesktop.org/drm/msm into drm-next)
Merging amdgpu/drm-next (f83088981a43 drm/amd/display: Use a reasonable tim=
eout for framebuffer fence waits)
Merging drm-intel/for-linux-next (51eb1a1de7a9 drm/i915/icl: Fix clockgatin=
g issue when using scalers)
Merging drm-tegra/drm/tegra/for-next (61b51fb51c01 drm/tegra: gem: Fix CPU-=
cache maintenance for BO's allocated using get_pages())
Merging drm-misc/for-linux-next (9158e3c31163 drm/panel: simple: Add Evervi=
sion VGG804821 panel support)
Merging drm-msm/msm-next (b02872df58ac drm/msm/a6xx: Don't enable GPU state=
 code if dependencies are missing)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (50755fe5208a drm/komeda: Expose bus_w=
idth to Komeda-CORE)
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (fd2450a77d33 drm/etnaviv: clean up etnaviv_ge=
m_new_handle)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (533df0884d83 Merge branch 'regmap-5.2' into regmap=
-next)
Merging sound/for-next (442e321ed223 ALSA: ps3: Remove set but not used var=
iables 'start_vaddr' and 'pcm_index')
Merging sound-asoc/for-next (84fdefca04a7 Merge branch 'asoc-5.2' into asoc=
-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging modules/modules-next (41e72eeff32c module: add stubs for within_mod=
ule functions)
Merging input/next (4c4591173f68 Input: sun4i-a10-lradc-keys - add support =
for A83T)
Merging block/for-next (0a3d0d0be042 Merge branch 'for-5.2/block' into for-=
next)
Merging device-mapper/for-next (873f258becca dm thin metadata: do not write=
 metadata if no changes occurred)
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
Merging battery/for-next (231a13d93d51 Merge tag 'psy-olpc-1.75-battery-sig=
ned' into psy-next)
Merging regulator/for-next (8e15c9bdb851 Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (072b76a8fe2b Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (058c4f342582 apparmor: fix spelling mistake=
 "immutible" -> "immutable")
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
Merging vfio/next (41be3e261817 vfio: Fix WARNING "do not call blocking ops=
 when !TASK_RUNNING")
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (70c4cf17e445 audit: fix a memory leak bug)
CONFLICT (content): Merge conflict in kernel/seccomp.c
CONFLICT (content): Merge conflict in arch/mips/kernel/ptrace.c
Merging devicetree/for-next (af3be70a3211 of: Improve of_phandle_iterator_n=
ext() error message)
Merging mailbox/mailbox-for-next (17b860bbfc84 mailbox: imx: keep MU irq wo=
rking during suspend/resume)
Merging spi/for-next (96a9209ae8eb Merge branch 'spi-5.2' into spi-next)
Merging tip/auto-latest (4816f7bb878a Merge branch 'WIP.x86/alternatives')
CONFLICT (content): Merge conflict in mm/kasan/Makefile
CONFLICT (content): Merge conflict in arch/x86/kernel/irq_64.c
CONFLICT (content): Merge conflict in arch/s390/include/asm/Kbuild
CONFLICT (content): Merge conflict in arch/arm64/include/asm/Kbuild
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
Merging kvm-arm/next (43b8e1f08938 KVM: arm64: Clarify access behaviour for=
 out-of-range SVE register slice IDs)
Merging kvm-ppc/kvm-ppc-next (2b57ecd0208f KVM: PPC: Book3S: Add count cach=
e flush parameters to kvmppc_get_cpu_char())
Merging kvms390/next (2089df1fd348 KVM: s390: enable MSA9 keywrapping funct=
ions depending on cpu model)
Merging xen-tip/linux-next (42d8644bd77d xen: Prevent buffer overflow in pr=
ivcmd ioctl)
Merging percpu/for-next (cb453ce4846b Merge branch 'for-5.2' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (98e2630284ab platform/x86: alienware-wmi: fix=
 kfree on potentially uninitialized pointer)
Merging chrome-platform/for-next (58a2109f6eb4 platform/chrome: cros_ec_pro=
to: Add trace event to trace EC commands)
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (aedf809bfa22 leds: Add basic support for Turris Omni=
a LEDs)
Merging ipmi/for-next (b779ceadf548 char/ipmi: fix spelling mistake "receie=
ved_messages" -> "received_messages")
Merging driver-core/driver-core-next (5de363b66a37 drivers: base: power: ad=
d proper SPDX identifiers on files that did not have them.)
Merging usb/usb-next (1567d661b90f usb: mtu3: get optional clock by devm_cl=
k_get_optional())
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (74d8139582bd USB: serial: digi_acceleport: cle=
an up set_termios)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (708310711e6c dt-bindings: phy-qcom-qmp: Tweak qcom,m=
sm8998-qmp-ufs-phy)
Merging tty/tty-next (3b8a1f45e1b3 Merge 5.1-rc6 into tty-next)
Merging char-misc/char-misc-next (3a26172437bb Merge 5.1-rc6 into char-misc=
-next)
Merging extcon/extcon-next (00053de52231 extcon: arizona: Disable mic detec=
t if running when driver is removed)
Merging soundwire/next (4abbd783d126 soundwire: intel: fix implicit header =
use of module.h/export.h)
Merging thunderbolt/next (c4630d6ae6e3 thunderbolt: Start firmware on Titan=
 Ridge Apple systems)
Merging staging/staging-next (817de6b85914 Merge 5.1-rc6 into staging-next)
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
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ven=
dor-prefixes.txt
$ git rm -f drivers/staging/media/mt9t031/Kconfig drivers/staging/media/mt9=
t031/Makefile drivers/staging/mt7621-spi/Kconfig drivers/staging/mt7621-spi=
/Makefile
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (38a829a389e3 dmaengine: at_xdmac: only monitor over=
flow errors for peripheral xfer)
Merging cgroup/for-next (cd4f686eb6df Merge branch 'for-5.2' into for-next)
Merging scsi/for-next (6fb251c6f174 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/sd.c
CONFLICT (content): Merge conflict in drivers/scsi/lpfc/lpfc_els.c
CONFLICT (add/add): Merge conflict in drivers/phy/mediatek/phy-mtk-ufs.c
Merging scsi-mkp/for-next (a7634b6f7cbb scsi: aic7xxx: fix spelling mistake=
 "recevied" -> "received")
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (4e76105b74c1 virtio: use dependent_ptr_mb)
CONFLICT (content): Merge conflict in drivers/pci/of.c
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (ae3ba80ae856 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (b0d2569d8276 gpio: mlxbf: remove unused in=
cluding <linux/version.h>)
Merging pinctrl/for-next (b7cd97cd140f Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (9ff06679e109 pwm: sysfs: fix typo "its" -> "it's")
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (d917fb876f6e selftests: build and run gpio when out=
put directory is the src dir)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (55ac3597df3f Merge branch 'for-5.1-upstream-=
fixes' into for-next)
Merging coresight/next (66cc4ec18d85 coresight: etb10: Add support for CPU-=
wide trace scenarios)
Merging rtc/rtc-next (9fc0fd5077ba rtc: mc13xxx: fix style issue)
CONFLICT (content): Merge conflict in drivers/rtc/rtc-omap.c
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (d333bad1f6f3 dt-bindings: at24: add Renesas R1E=
X24016)
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (3b8bb160f4d1 security: Implement Clang's stack =
initialization)
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
Merging hyperv/hyperv-next (a3fb7bf369ef drivers: input: serio: Add a modul=
e desription to the hyperv_keyboard driver)
Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make backl=
ight initial state configurable)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (eb364bbe6791 samples: show race-free pidfd metadata=
 access)
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging akpm-current/current (222cf5b476c2 ipc-do-cyclic-id-allocation-for-=
the-ipc-object-fix)
CONFLICT (content): Merge conflict in kernel/fork.c
CONFLICT (modify/delete): arch/s390/mm/gup.c deleted in HEAD and modified i=
n akpm-current/current. Version akpm-current/current of arch/s390/mm/gup.c =
left in tree.
CONFLICT (content): Merge conflict in arch/powerpc/platforms/Kconfig.cputype
CONFLICT (content): Merge conflict in arch/powerpc/mm/mmu_context_iommu.c
CONFLICT (content): Merge conflict in arch/powerpc/mm/mem.c
$ git rm -f arch/s390/mm/gup.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: fs/coda/psdev.c: remove duplicate header
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: fs/cachefiles/namei.c: remove duplicate header
Applying: fs/block_dev.c: Remove duplicate header
Applying: treewide: replace #include <asm/sizes.h> with #include <linux/siz=
es.h>
Applying: arch: remove <asm/sizes.h> and <asm-generic/sizes.h>
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm-rename-ambiguously-named-memorystat-counters-and-functions-fix
Applying: mm, memcg: consider subtrees in memory.events
Applying: drivers/virt/fsl_hypervisor.c: dereferencing error pointers in io=
ctl
Applying: drivers/virt/fsl_hypervisor.c: prevent integer overflow in ioctl
Applying: mm: memcontrol: make cgroup stats and events query API explicitly=
 local
Applying: mm-memcontrol-make-cgroup-stats-and-events-query-api-explicitly-l=
ocal-fix
Applying: mm: memcontrol: move stat/event counting functions out-of-line
Applying: mm: memcontrol: fix recursive statistics correctness & scalabilty
Applying: mm: memcontrol: fix NUMA round-robin reclaim at intermediate level
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (c9e71a1a35d8 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/qyaC_rvjDy=LDlA.RF/igE3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzAKIUACgkQAVBC80lX
0Gwxzgf/Yaw9Iq1JwSgisva1nFlzXySuxo+PCPZFR7oOPg2Y6Pazd5jbd2vuT4TS
3M4LgOOzJxsy4uJ0HjT7jbsWgerrCVCaWskCKhzOkpMY8WU4o7evsrLxHFkriKjV
L/heaAjyMJ6eI9/T2QkDZdjMIYPDJPcJJwBIhLm2QzVKIwOF8eL8DGJTAfp22Sw5
EdxU76Srw2ajThwabKvxWMltAsMRl13UVTOoWpulXUlJXCLbZgoXGudpATUqtmzA
zy7bbvTn3vCEzrHVB1/AAmLHVrg871kF0ON5GT4agh+ayXTnZx7LKeLtryHgRZHM
srdVr7YR7CJcid37Xixo0KActHu1gw==
=ADt/
-----END PGP SIGNATURE-----

--Sig_/qyaC_rvjDy=LDlA.RF/igE3--
