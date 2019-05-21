Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5884C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DA021743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dZS3JYNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfEUFOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:14:09 -0400
Received: from ozlabs.org ([203.11.71.1]:55889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfEUFOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:14:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457P7b1Sb0z9s55;
        Tue, 21 May 2019 15:14:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558415643;
        bh=VnEDVLACv385i2/zQaCBzBQ9JPTQu8eZRs8xW4DFSLA=;
        h=Date:From:To:Cc:Subject:From;
        b=dZS3JYNRUo/zZ0qro2IBLn+U33s4sGj7NOLr0Rr4Ls4nL7KPwnnR2eXmCX06vgNfa
         T2XWomFeOccdPYf/q76gBqiTUDn7hNKiHa77JhD+Ri/4czO7CX2xPb1J2u/3599pvk
         RLQVoFdhxyMlV/CPOQtuejvl5fhIJBrBF2qgkKJQhwZhHJXR2wmrXiJ9x3O48De2eg
         Frqj0DMpctH9Fl4dauxmVdYrx1Cj/fLYe3HBJp1Gio3fWGoyrSTO3d84Yr389ytlyJ
         6D7KbVWWSL7s/JMnJ7LGHzBXJk3iC6+TWtGL+LSujUfGDwSJhuafMD/9Cxl5o6M49a
         qgZM8Srb9xFJQ==
Date:   Tue, 21 May 2019 15:14:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 21
Message-ID: <20190521151402.19f22667@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u.myXXK_N9HI4moUKDCUIyK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u.myXXK_N9HI4moUKDCUIyK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190520:

New trees: soc-fsl, soc-fsl-fixes

Removed trees: (not updated for more than a year)
	alpine, samsung, sh, befs, kconfig, dwmw2-iommu, trivial,
	target-updates, target-bva, init_task

The imx-mxs tree gained a build failure so I used the version from
next-20190520.

The sunxi tree gained a conflict against the imx-mxs tree.

The drm-misc tree gained conflicts against Linis' and the amdgpu trees.

Non-merge commits (relative to Linus' tree): 991
 998 files changed, 29912 insertions(+), 14691 deletions(-)

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

I am currently merging 290 trees (counting Linus' and 70 trees of bug
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
Merging origin/master (f49aa1de9836 Merge tag 'for-5.2-rc1-tag' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fixes/master (2bbacd1a9278 Merge tag 'kconfig-v5.2' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kspp-gustavo/for-next/kspp (b324f1b28dc0 afs: yfsclient: Mark expec=
ted switch fall-throughs)
Merging kbuild-current/fixes (a2d635decbfa Merge tag 'drm-next-2019-05-09' =
of git://anongit.freedesktop.org/drm/drm)
Merging arc-current/for-curr (c5a1726d7383 ARC: entry: EV_Trap expects r10 =
(vs. r9) to have exception cause)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (7a0a93c51799 arm64: vdso: Explicitly ad=
d build-id option)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (672eaf37db9f powerpc/cacheinfo: Remove double =
free)
Merging sparc/master (f49aa1de9836 Merge tag 'for-5.2-rc1-tag' of git://git=
.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (fa2c52be7129 vlan: Mark expected switch fall-through)
Merging bpf/master (6a0a923dfa14 of_net: fix of_get_mac_address retval if c=
ompiled without CONFIG_OF)
Merging ipsec/master (9b3040a6aafd ipv4: Define __ipv4_neigh_lookup_noref w=
hen CONFIG_INET is disabled)
Merging netfilter/master (2c82c7e724ff netfilter: nf_tables: fix oops durin=
g rule dump)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (7a0f8ad5ff63 Merge ath-current from git://=
git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging mac80211/master (933b40530b4b mac80211: remove set but not used var=
iable 'old')
Merging rdma-fixes/for-rc (2557fabd6e29 RDMA/hns: Bugfix for mapping user d=
b)
Merging sound-current/for-linus (c7b55fabfa44 ALSA: hdac: fix memory releas=
e for SST and SOF drivers)
Merging sound-asoc-fixes/for-linus (08b9e0213aeb Merge branch 'asoc-5.1' in=
to asoc-linus)
Merging regmap-fixes/for-linus (1d6106cafb37 Merge branch 'regmap-5.1' into=
 regmap-linus)
Merging regulator-fixes/for-linus (0d183fc1760f Merge branch 'regulator-5.1=
' into regulator-linus)
Merging spi-fixes/for-linus (72e3b3285a43 Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (a188339ca5a3 Linux 5.2-rc1)
Merging driver-core.current/driver-core-linus (a188339ca5a3 Linux 5.2-rc1)
Merging tty.current/tty-linus (a188339ca5a3 Linux 5.2-rc1)
Merging usb.current/usb-linus (a188339ca5a3 Linux 5.2-rc1)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (a188339ca5a3 Linux 5.2-rc1)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (e6f32efb1b12 phy: sun4i-usb: Make sure to disable PHY0 p=
assby for peripheral mode)
Merging staging.current/staging-linus (fea699163604 staging: wilc1000: Fix =
some double unlock bugs in wilc_wlan_cleanup())
Merging char-misc.current/char-misc-linus (a188339ca5a3 Linux 5.2-rc1)
Merging soundwire-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging thunderbolt-fixes/fixes (e93c9c99a629 Linux 5.1)
Merging input-current/for-linus (145b11d1baa3 Input: elan_i2c - increment w=
akeup count if wake source)
Merging crypto-current/master (357d065a44cd crypto: vmx - ghash: do nosimd =
fallback manually)
Merging ide/master (f49aa1de9836 Merge tag 'for-5.2-rc1-tag' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (15ade5d2e777 Linux 5.1-rc4)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (9a8f612ca0d6 mtd: rawnand: marvell: Clean the =
controller state before each operation)
Merging mfd-fixes/for-mfd-fixes (e93c9c99a629 Linux 5.1)
Merging v4l-dvb-fixes/fixes (fc8670d1f72b media: rockchip/vpu: Fix/re-order=
 probe-error/remove path)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (a1e8783db8e0 MIPS: perf: ath79: Fix perfcoun=
t IRQ assignment)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (4ee23cd76c0c Merge branch 'omap-for-v5.2/ti-sysc'=
 into fixes)
Merging kvm-fixes/master (94830f188a80 Merge tag 'kvm-s390-master-5.2-1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (b88c5049219a hwmon: (occ) Fix extended status bi=
ts)
Merging nvdimm-fixes/libnvdimm-fixes (c4703ce11c23 libnvdimm/namespace: Fix=
 label tracking error)
Merging btrfs-fixes/next-fixes (4792878ab434 Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (d8076bdb56af uapi: Wire up the mount API syscalls =
on non-x86 arches [ver #2])
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging samsung-krzk-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging devicetree-fixes/dt/linus (e10e55e9d933 dt-bindings: sifive: descri=
be sifive-blocks versioning)
Merging scsi-fixes/fixes (8acf608e602f Revert "scsi: sd: Keep disk read-onl=
y when re-reading partition")
Merging drm-fixes/drm-fixes (e93c9c99a629 Linux 5.1)
Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden s=
etting for vega family)
Merging drm-intel-fixes/for-linux-next-fixes (a491cc8e1597 drm/i915: Truly =
bump ready tasks ahead of busywaits)
Merging mmc-fixes/fixes (ec0970e0a1b2 mmc: sdhci-iproc: Set NO_HISPD bit to=
 fix HS50 data hold time problem)
Merging rtc-fixes/rtc-fixes (882c5e552ffd rtc: da9063: set uie_unsupported =
when relevant)
Merging gnss-fixes/gnss-linus (a188339ca5a3 Linux 5.2-rc1)
Merging hyperv-fixes/hyperv-fixes (69c8caafb72d hv: tools: fixed Python pep=
8/flake8 warnings for lsvmbus)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging drm-misc-fixes/for-linux-next-fixes (243c4b78923d Merge drm-misc-ne=
xt-fixes-2019-05-20 into drm-misc-fixes)
Merging kbuild/for-next (fc2694ec1ab7 kconfig: use 'else ifneq' for Makefil=
e to improve readability)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (13bf5ced9377 dma-mapping: add a Kconfig symbo=
l to indicate arch_dma_prep_coherent presence)
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (d486065b35e4 Merge branches 'fixes' and 'misc' into f=
or-next)
Merging arm64/for-next/core (6127bf372add Merge branch 'for-next/mmiowb' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux into for-next/co=
re)
Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU hot=
plug handling)
Merging arm-soc/for-next (7ad1b252cabe ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (26d65140e92a ARM: dts: meson8b: fix the operating=
 voltage of the Mali GPU)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (ac650130c227 Merge branches 'at91-soc', 'at91-dt' a=
nd 'at91-defconfig' into at91-next)
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (fcc5ebd68943 Merge branch 'imx/defconfig' into fo=
r-next)
$ git reset --hard HEAD^
Merging next-20190520 version of imx-mxs
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
[master 266c19ac07a4] next-20190520/imx-mxs
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (891f0f865c37 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (4ee23cd76c0c Merge branch 'omap-for-v5.2/ti-sysc' in=
to fixes)
Merging reset/reset/next (21a5d26b8164 reset: Switch to SPDX license identi=
fier for reset-simple)
Merging qcom/for-next (1d31c0b1a28a Merge tag 'qcom-arm64-for-5.2-1' into r=
eally-done-for-5.2)
Merging renesas/next (def26783aa95 Merge branches 'arm-dt-for-v5.3', 'arm64=
-defconfig-for-v5.3', 'arm64-dt-for-v5.3' and 'dt-bindings-for-v5.3' into n=
ext)
Merging rockchip/for-next (c3762b5d0e39 Merge branch 'v5.3-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (831c75782772 Merge branch 'next/dt64' into f=
or-next)
Merging sunxi/sunxi/for-next (e1152002eef6 Merge branches 'sunxi/dt64-for-5=
.3' and 'sunxi/dt-for-5.3' into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging tegra/for-next (0c0ffecf65fd Merge branch for-5.2/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (a188339ca5a3 Linux 5.2-rc1)
Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add ga=
te clock for ADC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (d2adb7b6249a csky: Select intc & timer drivers)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (fdd20ec8786a Documentation/features/time: Mark m68k =
having modern-timekeeping)
Merging m68knommu/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (b1e479e3dcbc MIPS: Alchemy: add DMA masks for on-ch=
ip ethernet)
Merging nds32/next (af9abd65983c nds32: Fix vDSO clock_getres())
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (200036a8e802 parisc: Allow building 64-bit kern=
el without -mlong-calls compiler option)
Merging powerpc/next (8150a153c013 powerpc/64s: Use early_mmu_has_feature()=
 in set_kuap())
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (5d1d046e2868 soc: fsl: qbman_portals: add APIs to ret=
rieve the probing status)
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (8fef9900d43f riscv: fix locking violation in page =
fault handler)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (f3e20ad67b4c s390: move arch/s390/defconfig to arch/=
s390/configs/defconfig)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (0542593fff0f Merge branch 'xtensa-for-next'=
 into xtensa-5.2-fixes)
Merging fscrypt/master (2c58d548f570 fscrypt: cache decrypted symlink targe=
t in ->i_link)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (00abf69dd24f ceph: flush dirty inodes before proceedin=
g with remount)
Merging cifs/for-next (63f538a448ce cifs: fix memory leak of pneg_inbuf on =
-EOPNOTSUPP ioctl case)
Merging configfs/for-next (35399f87e271 configfs: fix possible use-after-fr=
ee in configfs_register_group)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (38fa0e8e4a3b ext2: code cleanup by using test_opt() =
and clear_opt())
Merging ext4/dev (2c1d0e3631e5 ext4: avoid panic during forced reboot due t=
o aborted journal)
Merging f2fs/dev (e0654264c480 Merge tag 'backlight-next-5.2' of git://git.=
kernel.org/pub/scm/linux/kernel/git/lee/backlight)
Merging fuse/for-next (9031a69cf9f0 fuse: clean up fuse_alloc_inode)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (a188339ca5a3 Linux 5.2-rc1)
Merging nfs-anna/linux-next (5940d1cf9f42 SUNRPC: Rebalance a kref in auth_=
gss.c)
Merging nfsd/nfsd-next (1c73b9d24f80 nfsd: update callback done processing)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (acf3062a7e1c ovl: relax WARN_ON() for ove=
rlapping layers use case)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (8869a2d297cb Merge remote-tracking branch 'korg/iomap=
-5.2-merge' into for-next)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (967aa2217b6d Merge branch 'for-5.2-fixes' into for=
-next)
Merging pci/next (a188339ca5a3 Linux 5.2-rc1)
Merging pstore/for-next/pstore (6b1be4a047a0 pstore/ram: Improve backward c=
ompatibility with older Chromebooks)
Merging hid/for-next (eb18d1215405 Merge branch 'for-5.2/logitech' into for=
-next)
Merging i2c/i2c/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging i3c/i3c/next (476c7e1d34f2 i3c: Fix a shift wrap bug in i3c_bus_set=
_addr_slot_status())
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (39abe9d88b30 hwmon: (lm75) Add support fo=
r TMP75B)
Merging jc_docs/docs-next (d2f3bfb8beb1 Documentation: kdump: fix minor typ=
o)
Merging v4l-dvb/master (fc8670d1f72b media: rockchip/vpu: Fix/re-order prob=
e-error/remove path)
Merging v4l-dvb-next/master (a455eda33faa Merge branch 'linus' of git://git=
.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal)
Merging fbdev/fbdev-for-next (73ee89436047 Merge tag 'v5.2-rc1' of https://=
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into fbdev-for-next)
Merging pm/linux-next (03216f1a350e Merge branch 'acpi-pm' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (a02177a39344 dt-bindings: imx-c=
pufreq-dt: Document opp-supported-hw usage)
Merging cpupower/cpupower (21027e78e7c1 cpupower: correct spelling of inter=
val)
Merging opp/opp/linux-next (c0ab9e0812da opp: Allocate genpd_virt_devs from=
 dev_pm_opp_attach_genpd())
Merging thermal/next (6df24c3e81b9 Merge branches 'thermal-core', 'thermal-=
built-it' and 'thermal-intel' into next)
Merging thermal-soc/next (37bcec5d9f71 hwmon: (pwm-fan) Use devm_thermal_of=
_cooling_device_register)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (54cca4bad076 dlm: allow binding to all network interfaces)
Merging swiotlb/linux-next (063b8271ec8f swiotlb-xen: ensure we have a sing=
le callsite for xen_dma_map_page)
Merging rdma/for-next (c191f93454bc net/mlx5: Set completion EQs as shared =
resources)
Merging net-next/master (f49aa1de9836 Merge tag 'for-5.2-rc1-tag' of git://=
git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging bpf-next/master (35c99ffa20ed Merge tag 'for_linus' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging ipsec-next/master (601e6bcc4ef0 Merge git://git.kernel.org/pub/scm/=
linux/kernel/git/davem/net)
Merging mlx5-next/mlx5-next (a188339ca5a3 Linux 5.2-rc1)
Merging netfilter-next/master (601e6bcc4ef0 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/net)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (f9b628d61fae rtw88: add license for M=
akefile)
Merging bluetooth/master (62a91990f4c5 Bluetooth: hci_qca: Rename STATE_<fl=
ags> to QCA_<flags>)
Merging mac80211-next/master (80f232121b69 Merge git://git.kernel.org/pub/s=
cm/linux/kernel/git/davem/net-next)
Merging gfs2/for-next (fbcde197e1be gfs2: Fix error path kobject memory lea=
k)
Merging mtd/mtd/next (3008ba870938 mtd: part: fix incorrect format specifie=
r for an unsigned long long)
Merging nand/nand/next (84db7797ffd3 mtd: rawnand: fsmc: Use nand_op_trace =
for operation tracing)
Merging spi-nor/spi-nor/next (e43f53c22a93 spi-nor: intel-spi: Add support =
for Intel Comet Lake SPI serial flash)
Merging crypto/master (e59f755ceb6d crypto: ccree - use a proper le32 type =
for le32 val)
Merging drm/drm-next (a188339ca5a3 Linux 5.2-rc1)
Merging amdgpu/drm-next (56965ce261af drm/amdgpu: cancel late_init_work bef=
ore gpu reset)
Merging drm-intel/for-linux-next (5c000fb33b76 drm/i915: Bump gen7+ fb size=
 limits to 16kx16k)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_pipe_crc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_guc_submis=
sion.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.c
CONFLICT (modify/delete): drivers/gpu/drm/i915/intel_context.c deleted in d=
rm-intel/for-linux-next and modified in HEAD. Version HEAD of drivers/gpu/d=
rm/i915/intel_context.c left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_scheduler.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_request.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_context=
_types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_breadcr=
umbs.c
$ git rm -f drivers/gpu/drm/i915/intel_context.c
Merging drm-tegra/drm/tegra/for-next (61b51fb51c01 drm/tegra: gem: Fix CPU-=
cache maintenance for BO's allocated using get_pages())
Merging drm-misc/for-linux-next (201bd433bfa3 drm/bochs: fix ptr_ret.cocci =
warnings)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
CONFLICT (modify/delete): Documentation/devicetree/bindings/vendor-prefixes=
.txt deleted in HEAD and modified in drm-misc/for-linux-next. Version drm-m=
isc/for-linux-next of Documentation/devicetree/bindings/vendor-prefixes.txt=
 left in tree.
$ git rm -f Documentation/devicetree/bindings/vendor-prefixes.txt
Applying: dt-bindings: fix up for vendor prefixes file conversion
Merging drm-msm/msm-next (b02872df58ac drm/msm/a6xx: Don't enable GPU state=
 code if dependencies are missing)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (15e9122d9b5c drm/komeda: Mark the loc=
al functions as static)
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging regmap/for-next (a136e5257f67 Merge branch 'regmap-5.2' into regmap=
-next)
Merging sound/for-next (c4580f209715 ALSA: dice: add stream format paramete=
rs for PreSonus FireStudio)
Merging sound-asoc/for-next (d0723c9d845f Merge branch 'asoc-5.2' into asoc=
-next)
Merging modules/modules-next (dadec066d8fa module: add stubs for within_mod=
ule functions)
Merging input/next (b283d0c353de Input: eeti_ts -  read hardware state once=
 after wakeup)
Merging block/for-next (e35d0b782065 Merge branch 'for-5.2/block-post' into=
 for-next)
Merging device-mapper/for-next (8454fca4f53b dm: fix a couple brace coding =
style issues)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (0a49a619e7e1 mmc: sdhci-pci: Fix BYT OCP setting)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (ed835136ee67 mfd: Use dev_get_drvdata() directly)
Merging backlight/for-backlight-next (53fa0f87177d backlight: lm3630a: Add =
firmware node support)
Merging battery/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging regulator/for-next (16f26207b3b1 Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (5664f5faac11 Merge branch 'next-smack' into =
next-testing)
Merging apparmor/apparmor-next (06c13f554a71 apparmor: re-introduce a varia=
nt of PROFILE_MEDIATES_SAFE)
Merging integrity/next-integrity (5d99fe052ddd x86/ima: check EFI SetupMode=
 too)
Merging selinux/next (a188339ca5a3 Linux 5.2-rc1)
Merging tpmdd/next (ff89e2f4b34d tpm: Actually fail on TPM errors during "g=
et random")
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (b5531563e8a0 Merge branches 'arm/tegra', 'arm/mediatek'=
, 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging audit/next (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree/for-next (2a656cb5a4a3 of: unittest: Remove error printi=
ng on OOM)
Merging mailbox/mailbox-for-next (8fbbfd966efa mailbox: Add support for Arm=
ada 37xx rWTM mailbox)
Merging spi/for-next (aa459d194583 Merge remote-tracking branch 'spi/topic/=
bpw-check' into spi-next)
Merging tip/auto-latest (9883872cc373 Merge branch 'core/urgent')
Merging clockevents/clockevents/next (8c9374068ef6 misc: atmel_tclib: Do no=
t probe already used TCBs)
Merging edac-amd/for-next (8de9930a4618 Revert "EDAC/amd64: Support more th=
an two controllers for chip select handling")
Merging irqchip/irq/irqchip-next (16e32c3cde77 iommu/dma-iommu: Remove iomm=
u_dma_map_msi_msg())
Merging ftrace/for-next (693713cbdb3a x86: Hide the int3_emulate_call/jmp f=
unctions from UML)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (94830f188a80 Merge tag 'kvm-s390-master-5.2-1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (4894fbcce856 KVM: PPC: Book3S: Remove useless=
 checks in 'release' method of KVM device)
Merging kvms390/next (6e9b622d1c36 KVM: s390: change default halt poll time=
 to 50us)
Merging xen-tip/linux-next (fe846979d305 xen/arm: Use p2m entry with lock p=
rotection)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging chrome-platform/for-next (7dadf88f8d4e platform/chrome: cros_ec_spi=
: Move to real time priority for transfers)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (facb98c889f9 leds: spi-byte: add single byte SPI LED=
 driver)
Merging ipmi/for-next (dd7450cab711 ipmi_si: use bool type for initialized =
variable)
Merging driver-core/driver-core-next (a188339ca5a3 Linux 5.2-rc1)
Merging usb/usb-next (a188339ca5a3 Linux 5.2-rc1)
Merging usb-gadget/next (2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRAT=
A)
Merging usb-serial/usb-next (a188339ca5a3 Linux 5.2-rc1)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (708310711e6c dt-bindings: phy-qcom-qmp: Tweak qcom,m=
sm8998-qmp-ufs-phy)
Merging tty/tty-next (a188339ca5a3 Linux 5.2-rc1)
Merging char-misc/char-misc-next (a188339ca5a3 Linux 5.2-rc1)
Merging extcon/extcon-next (00053de52231 extcon: arizona: Disable mic detec=
t if running when driver is removed)
Merging soundwire/next (a188339ca5a3 Linux 5.2-rc1)
Merging thunderbolt/next (37209783c73a thunderbolt: Make priority unsigned =
in struct tb_path)
Merging staging/staging-next (e23fa431e77d Staging: mt7621-dma: Remove brac=
es around single if statement)
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (a188339ca5a3 Linux 5.2-rc1)
Merging cgroup/for-next (05b289263772 signal: unconditionally leave the fro=
zen state in ptrace_stop())
Merging scsi/for-next (faec2dda93d3 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (d4023db71108 scsi: qla2xxx: Avoid that lockdep c=
omplains about unsafe locking in tcm_qla2xxx_close_session())
Merging vhost/linux-next (82c80f76e9da virtio: Fix indentation of VIRTIO_MM=
IO)
CONFLICT (content): Merge conflict in drivers/pci/of.c
Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (0fbee1df2078 gpio: Update documentation)
Merging gpio-brgl/gpio/for-next (ef9ace6f8008 tools: gpio: Add include/linu=
x/gpio.h to .gitignore)
Merging pinctrl/for-next (e0e31695b53b pinctrl: mcp23s08: Do not complain a=
bout unsupported params)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (f41efceb46e6 pwm: meson: Add clock source configurati=
on for Meson G12A)
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (b7d5dc21072c random: add a spinlock_t to struct batched=
_entropy)
Merging kselftest/next (f23ad71e5535 selftests/x86: Support Atom for syscal=
l_arg_fault test)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (591be2f7f7b5 Merge branch 'for-5.2/core' int=
o for-next)
Merging coresight/next (64e77d2af2c0 perf tools: Properly set the value of =
'old' and 'head' in snapshot mode)
Merging rtc/rtc-next (dacb6a4035a0 rtc: snvs: Use __maybe_unused instead of=
 #if CONFIG_PM_SLEEP)
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (7210e060155b gcc-plugins: Fix build failures un=
der Darwin host)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (a188339ca5a3 Linux 5.2-rc1)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging xarray/xarray (dd12805ed1db XArray: Remove radix tree compatibility)
Merging hyperv/hyperv-next (a3fb7bf369ef drivers: input: serio: Add a modul=
e desription to the hyperv_keyboard driver)
Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make backl=
ight initial state configurable)
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (233ad92edbea pidfd: add polling selftests)
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging akpm-current/current (c20602b4a39f scripts/gdb: add hlist utilities)
CONFLICT (content): Merge conflict in include/linux/pid.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: mm, memcg: consider subtrees in memory.events
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (8839e03395e1 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/u.myXXK_N9HI4moUKDCUIyK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjiRoACgkQAVBC80lX
0Gw05Af+Kna14AUSKmygZVJlFR3ZZ/p4DkX0t2Enuxg/e8fVooS6srk2rcCcTs9O
G//O5qdUZz1CwJQ1Od2pl6iL9ggc0ZoqWOAwEyjY61HQDeBACjMp129Q/EW1CTSx
2bw8qFgdrIUNKGo+0v9S5ZdeT0HTzi5qiT1+zmqEl/DMyZUw5mzIHJaQz9CLCrP0
JIGytg1VvOp1MzJK2SoPNBO/CRf3rzXY/EwOB4ton4S7Ynnn9i0cnw8cP8NtjvjA
Rm5uLdWrQrvJ4iVTYUplydcQ6QZhs8NFa8woEAZ1KbRDC3EdRXFtrcVre9TElmMz
/Q5vilfDXI981r3vrVifryMfdKgLOQ==
=H0f5
-----END PGP SIGNATURE-----

--Sig_/u.myXXK_N9HI4moUKDCUIyK--
