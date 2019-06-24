Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF73C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FAE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mK4fwiKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfFXMMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:12:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfFXMMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:12:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XSpb688lz9s4V;
        Mon, 24 Jun 2019 22:12:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561378343;
        bh=Mgg7mydgRzCebn7lkC4IL3kf58RN/mrojTsX7q/T6S8=;
        h=Date:From:To:Cc:Subject:From;
        b=mK4fwiKadwN/0YRuyx5++i2KGniTDiywuEfm3Q6aP4wK3O4LH/yiA1y5Ci5/hvwSk
         NLiezoHsN7RH/HUeC2ZA0xLHH3GRSP87BavmQy8jsapWQPo13AWP5jKgKHxXAdRLb9
         SFv69mW871G9wXh/vRX7NTsIT+57GYdTXxovI+96idy58T/KqfHPmlVpYnYUP2PMUf
         DyMy+E5P5XSAvqyT0v3iG8ylNGR0zJY0cDfuXtemnDznrUYyrRBw3sq/AgU5XRBH6q
         lkwgE1kxs+OLuBWxV+Kin0B3Jd7c5t/+s4yt7QikG6apjxMbszbT9p8deDOIZoQ0ZI
         nRwgRpNzxJlhQ==
Date:   Mon, 24 Jun 2019 22:12:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 24
Message-ID: <20190624221222.5a17f6f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BD1L_oQfiXjPoqe_W5e.SB9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BD1L_oQfiXjPoqe_W5e.SB9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190621:

The arm-soc tree gained a conflict against Linus' tree.

The hwmon-staging tree gained a conflict against Linus' tree.

The v4l-dvb tree gained a conflict against Linus' tree.

The fbdev tree gained a conflict against Linus' tree but still had its
build failure so I used the version from next-20190619.

The net-next tree still had its build failure for which I reverted a commit.

The netfilter-next tree gained a conflict against Linus' tree.

The spi-nor tree gained a conflict against Linus' tree.

The drm tree gained a conflict against the jc_docs tree and a build
failure due to merging the fbdev tree for which I reverted 2 commits.

The amdgpu tree gained a build failure so I used the version from
next-20190621.

The block tree lost its build failure.

The devicetree tree gained a conflict against Linus' tree.

The usb tree gained a conflict against the pci tree.

The staging tree gained a build failure for which I reverted a commit.

The cgroup tree gained a conflict against the block tree.

The akpm-current tree gained conflicts against the drm and tip trees.

Non-merge commits (relative to Linus' tree): 7697
 7880 files changed, 313875 insertions(+), 256644 deletions(-)

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

I am currently merging 296 trees (counting Linus' and 71 trees of bug
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
Merging origin/master (4b972a01a7da Linux 5.2-rc6)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging arc-current/for-curr (ec9b4feb1e41 ARC: [plat-hsdk]: unify memory a=
pertures configuration)
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm64-fixes/for-next/fixes (615c48ad8f42 arm64/mm: don't initialize=
 pgd_cache twice)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (500871125920 KVM: PPC: Book3S HV: Invalidate E=
RAT when flushing guest TLB entries)
Merging s390-fixes/fixes (11aff183225c vfio-ccw: Destroy kmem cache region =
on module exit)
Merging sparc/master (15d5dfaf4adb sparc: fix unknown type name u_int in ua=
pi header)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (45d5cb137c36 net/sched: cbs: Fix error path of cbs_modu=
le_init)
Merging bpf/master (56f0f84e69c7 bpf: fix the check that forwarding is enab=
led in bpf_ipv6_fib_lookup)
Merging ipsec/master (b8d6d0079757 xfrm: fix sa selector validation)
Merging netfilter/master (cf47a0b882a4 ipvs: defer hook registration to avo=
id leaks)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (69ae4f6aac15 mwifiex: Fix heap overflow in=
 mwifiex_uap_parse_tail_ies())
Merging mac80211/master (6be8e297f9bc lapb: fixed leak of control-blocks.)
Merging rdma-fixes/for-rc (7a5834e456f7 RDMA/efa: Handle mmap insertions ov=
erflow)
Merging sound-current/for-linus (17d304604a88 Revert "ALSA: hda/realtek - I=
mprove the headset mic for Acer Aspire laptops")
Merging sound-asoc-fixes/for-linus (bce2c75dd03f Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (2217d05161cb Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (934670c20b85 Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (639a25e80d40 Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (6dbbd053e6ae PCI/P2PDMA: Ignore root complex=
 whitelist when an IOMMU is present)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (4b972a01a7da Linux 5.2-rc6)
Merging usb-gadget-fixes/fixes (42de8afc40c9 usb: dwc2: Use generic PHY wid=
th in params setup)
Merging usb-serial-fixes/usb-linus (aed2a2628352 USB: serial: option: add s=
upport for GosunCn ME3630 RNDIS mode)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (4b972a01a7da Linux 5.2-rc6)
Merging char-misc.current/char-misc-linus (4b972a01a7da Linux 5.2-rc6)
Merging soundwire-fixes/fixes (39194128701b soundwire: intel: set dai min a=
nd max channels correctly)
Merging thunderbolt-fixes/fixes (0d53827d7c17 thunderbolt: Implement CIO re=
set correctly for Titan Ridge)
Merging input-current/for-linus (9843f3e08e21 Input: synaptics - enable SMB=
us on ThinkPad E480 and E580)
Merging crypto-current/master (7829a0c1cb9c crypto: hmac - fix memory leak =
in hmac_init_tfm())
Merging ide/master (54dee406374c Merge tag 'arm64-fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/arm64/linux)
Merging vfio-fixes/for-linus (5715c4dd66a3 vfio/mdev: Synchronize device cr=
eate/remove with parent removal)
Merging kselftest-fixes/fixes (e2e88325f4bc selftests: vm: Fix test build f=
ailure when built by itself)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (191f5c2ed4b6 mtd: spi-nor: use 16-bit WRR comm=
and when QE is set on spansion flashes)
Merging mfd-fixes/for-mfd-fixes (cd49b84d61b2 mfd: stmfx: Uninitialized var=
iable in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (637dfa0fad6d MIPS: have "plain" make calls b=
uild dtbs for selected platforms)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (f6192c664e21 Merge commit '79499bb11db508' into f=
ixes)
Merging kvm-fixes/master (f8d221d2e0e1 Merge tag 'kvm-s390-master-5.2-2' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-maste=
r)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (48b5b6d53b28 hwmon: (pwm-fan) Check return value=
 from devm_add_action_or_reset)
Merging nvdimm-fixes/libnvdimm-fixes (a4a357fd4477 Merge branch 'for-5.2/da=
x' into libnvdimm-fixes)
Merging btrfs-fixes/next-fixes (02252ea054b8 Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (d728cf79164b fs/namespace: fix unprivileged mount =
propagation)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (9e0babf2c06c Linux 5.2-rc5)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (240b4cc8fd5d scsi: vmw_pscsi: Fix use-after-free =
in pvscsi_queue_lck())
Merging drm-fixes/drm-fixes (5eab9cf87b6c Merge tag 'imx-drm-fixes-2019-06-=
20' of git://git.pengutronix.de/git/pza/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (475df5d0f3eb drm/i915: Don't =
clobber M/N values during fastset check)
Merging mmc-fixes/fixes (83293386bc95 mmc: core: Prevent processing SDIO IR=
Qs when the card is suspended)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (259931fd3b96 riscv: remove unused barrier defin=
es)
Merging drm-misc-fixes/for-linux-next-fixes (74b67efa8d7b drm: return -EFAU=
LT if copy_to_user() fails)
Merging kbuild/for-next (cfdee6945bc8 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (591fcf3b301b iommu/dma: Apply dma_{alloc,free=
}_contiguous functions)
CONFLICT (content): Merge conflict in include/linux/genalloc.h
CONFLICT (content): Merge conflict in include/linux/dma-iommu.h
CONFLICT (content): Merge conflict in drivers/iommu/dma-iommu.c
CONFLICT (content): Merge conflict in arch/arm64/mm/dma-mapping.c
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (1a42d1d8c766 ARCv2: entry: simplify return to Delay S=
lot via interrupt)
Merging arm/for-next (488da83be67d Merge commit commit 'drm-armada-devel^{/=
drm/armada: no need to check parent of remote}' into for-next)
Merging arm64/for-next/core (2a438ffa74c0 arm64: Allow selecting Pseudo-NMI=
 again)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/thread_info.h
Merging arm-perf/for-next/perf (ae9924667a7e MAINTAINERS: Add maintainer en=
try for the imx8 DDR PMU driver)
Merging arm-soc/for-next (e57f4f2c4506 ARM: Document merges)
CONFLICT (modify/delete): arch/arm/include/debug/netx.S deleted in arm-soc/=
for-next and modified in HEAD. Version HEAD of arch/arm/include/debug/netx.=
S left in tree.
$ git rm -f arch/arm/include/debug/netx.S
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (6aff64e5783f Merge branch 'v5.3/drivers' into tmp=
/aml-rebuild)
CONFLICT (content): Merge conflict in arch/arm/include/debug/meson.S
Merging aspeed/for-next (a1f5c11ddb7d Merge branches 'dt-for-v5.3', 'defcon=
fig-for-v5.3' and 'soc-for-v5.3' into for-next)
Merging at91/at91-next (7eb505978425 Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (beb58dd364d3 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (78145dbeaea1 Merge branch 'for_5.3/driver-soc' into =
next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (03fb10f2128a Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (1e16bc075913 Merge branch 'fixes' into for-next)
Merging qcom/for-next (ed26b50d39eb Merge tag 'qcom-arm64-for-5.3' into ini=
tial-for-5.3)
Merging renesas/next (a16ecb14d0b0 Merge branches 'arm-dt-for-v5.3', 'arm-s=
oc-for-v5.3', 'arm-defconfig-for-v5.3', 'arm64-defconfig-for-v5.3', 'arm64-=
dt-for-v5.3' and 'dt-bindings-for-v5.3' into next)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (bf0b34ecc3e7 Merge branch 'v5.3-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (fe0edb241723 Merge branch 'next/soc' into fo=
r-next)
CONFLICT (content): Merge conflict in arch/arm/configs/exynos_defconfig
Merging scmi/for-linux-next (d84dc98fad98 Merge branch 'for-next/scmi-updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging sunxi/sunxi/for-next (f0776d431adb Merge branch 'sunxi/dt64-for-5.3=
' into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging tegra/for-next (033de83170dd Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (e520e32f4117 Merge branch 'clk-fixes' into clk-next)
CONFLICT (content): Merge conflict in drivers/clk/bcm/Kconfig
Merging clk-samsung/for-next (7ef91224c486 clk: samsung: Add bus clock for =
GPU/G3D on Exynos4412)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (f4c19a4e669c csky: Improve tlb operation with help=
 of asid)
Merging h8300/h8300-next (38ef0515e1e8 H8300: remove unused barrier defines)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f67d667213ba m68k: defconfig: Update defconfigs for =
v5.2-rc1)
Merging m68knommu/for-next (b75d252a6322 riscv: add binfmt_flat support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (65eb3e4c1426 MIPS: configs: Remove useless UEVENT_H=
ELPER_PATH)
CONFLICT (content): Merge conflict in arch/mips/include/asm/mach-ralink/pin=
mux.h
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (d2ba3b1714d7 parisc: Fix module loading error w=
ith JUMP_LABEL feature)
Merging powerpc/next (e610a466d16a powerpc/pseries/mobility: rebuild cachei=
nfo hierarchy post-migration)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (e93c9c99a629 Linux 5.1)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (96e5aaf91406 s390/cio: move struct node_descriptor t=
o cio.h)
Merging sh/sh-next (7c04efc8d2ef sh: configs: Remove useless UEVENT_HELPER_=
PATH)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (61474c3685e1 Merge branch 'xtensa-5.3' into=
 xtensa-for-next)
Merging fscrypt/master (0bb06cac060d fscrypt: remove unnecessary includes o=
f ratelimit.h)
Merging afs/afs-next (ee102584efd5 fs/afs: use struct_size() in kzalloc())
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (7b2f936fc828 ceph: fix error handling in ceph_get_caps=
())
Merging cifs/for-next (65ff681a4285 cifs: Properly handle auto disabling of=
 serverino option)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (c036061be907 ecryptfs: Make ecryptfs_xattr_handler s=
tatic)
Merging ext3/for_next (a846d996a243 Pull nameremove cleanups from Amir.)
Merging ext4/dev (c708b1c6de7f ext4: remove redundant assignment to node)
Merging f2fs/dev (2143ad386c4c f2fs: add a rw_sem to cover quota flag chang=
es)
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (29f785ff76b6 Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging nfs-anna/linux-next (19d55046cd82 SUNRPC: Fix a credential refcount=
 leak)
Merging nfsd/nfsd-next (b8f73eb8b491 nfs: fix out-of-date connectathon talk=
 URL)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (6dde1e42f497 ovl: make i_ino consistent w=
ith st_ino in more cases)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (f5b999c03f4c xfs: remove unused flag arguments)
Merging file-locks/locks-next (6ef048fd5955 locks: eliminate false positive=
 conflicts for write lease)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (753637b2039f Merge branch 'for-5.3' into for-next)
Merging pci/next (253e08d0a265 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (a72920efb18f pstore: no need to check retur=
n value of debugfs_create functions)
Merging hid/for-next (b0153147e2d7 Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (dcd4072a2e0b Merge branch 'i2c/for-5.3' into i2c/=
for-next)
CONFLICT (content): Merge conflict in drivers/i2c/busses/i2c-meson.c
Merging i3c/i3c/next (f467907c1c38 i3c: dw: add limited bus mode support)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (2119f92b6b66 hwmon: Convert remaining dri=
vers to use SPDX identifier)
CONFLICT (content): Merge conflict in drivers/hwmon/max197.c
CONFLICT (content): Merge conflict in drivers/hwmon/iio_hwmon.c
CONFLICT (content): Merge conflict in drivers/hwmon/adt7475.c
CONFLICT (content): Merge conflict in drivers/hwmon/adt7411.c
Merging jc_docs/docs-next (0f48a2441613 doc-rst: Add missing newline at end=
 of file)
CONFLICT (content): Merge conflict in Documentation/fb/fbcon.rst
Merging v4l-dvb/master (3a959dcd11a4 media: mt9m111: add regulator support)
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-vmal=
loc.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-dma-=
sg.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-dma-=
contig.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-core=
.c
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (76c47323c151 video: fbdev: omap2: remove rfbi)
CONFLICT (modify/delete): drivers/video/fbdev/omap2/omapfb/dss/rfbi.c delet=
ed in fbdev/fbdev-for-next and modified in HEAD. Version HEAD of drivers/vi=
deo/fbdev/omap2/omapfb/dss/rfbi.c left in tree.
$ git rm -f drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
$ git reset --hard HEAD^
Merging next-20190619 version of fbdev
CONFLICT (modify/delete): drivers/video/fbdev/mxsfb.c deleted in 0f5a5712ad=
1e3b8472b1c1459681dadad9277067 and modified in HEAD. Version HEAD of driver=
s/video/fbdev/mxsfb.c left in tree.
$ git rm -f drivers/video/fbdev/mxsfb.c
[master ead2c6d3f0f2] next-20190619/fbdev
Merging pm/linux-next (d6d7a0819420 Merge branch 'pm-sleep' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (d3df18a97e58 cpufreq: add drive=
r for Raspberry Pi)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (cd7ea582866f opp: Make dev_pm_opp_set_rate() ha=
ndle freq =3D 0 to drop performance votes)
Merging thermal/next (6df24c3e81b9 Merge branches 'thermal-core', 'thermal-=
built-it' and 'thermal-intel' into next)
Merging thermal-soc/next (4cb9f043447e thermal: thermal_mmio: remove some d=
ead code)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (6051531997ed dlm: no need to check return value of debugf=
s_create functions)
Merging swiotlb/linux-next (dd853b2dfa65 Merge branch 'stable/for-linus-5.2=
' into linux-next)
Merging rdma/for-next (a49b1dc7ae44 RDMA: Convert destroy_wq to be void)
CONFLICT (content): Merge conflict in include/rdma/ib_verbs.h
CONFLICT (content): Merge conflict in include/linux/mlx5/eswitch.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/cmd.c
CONFLICT (modify/delete): drivers/infiniband/hw/nes/Makefile deleted in rdm=
a/for-next and modified in HEAD. Version HEAD of drivers/infiniband/hw/nes/=
Makefile left in tree.
CONFLICT (modify/delete): drivers/infiniband/hw/nes/Kconfig deleted in rdma=
/for-next and modified in HEAD. Version HEAD of drivers/infiniband/hw/nes/K=
config left in tree.
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_std_ty=
pes_cq.c
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
$ git rm -f drivers/infiniband/hw/nes/Kconfig drivers/infiniband/hw/nes/Mak=
efile
Merging net-next/master (7d30a7f6424e Merge branch 'ipv6-avoid-taking-refcn=
t-on-dst-during-route-lookup')
CONFLICT (modify/delete): drivers/infiniband/hw/nes/nes.c deleted in HEAD a=
nd modified in net-next/master. Version net-next/master of drivers/infiniba=
nd/hw/nes/nes.c left in tree.
CONFLICT (content): Merge conflict in arch/sh/configs/titan_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7721_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7712_defconfig
$ git rm -f drivers/infiniband/hw/nes/nes.c
Applying: Revert "macb: Add support for SiFive FU540-C000"
Merging bpf-next/master (dca73a65a683 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/bpf/bpf-next)
Merging ipsec-next/master (8928aa6a007d xfrm: remove empty xfrmi_init_net)
Merging mlx5-next/mlx5-next (82b11f071936 net/mlx5: Expose eswitch encap mo=
de)
Merging netfilter-next/master (dbb5281a1f84 netfilter: nf_tables: add suppo=
rt for matching IPv4 options)
CONFLICT (content): Merge conflict in net/netfilter/xt_set.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_list_set.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_netpo=
rtnet.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_netpo=
rt.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_netne=
t.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_netif=
ace.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_net.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_mac.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_ippor=
tnet.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_ippor=
tip.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_ippor=
t.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_ipmar=
k.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_ip.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_hash_gen.h
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_getport.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_core.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_bitmap_por=
t.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_bitmap_ipm=
ac.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_bitmap_ip.c
CONFLICT (content): Merge conflict in net/netfilter/ipset/ip_set_bitmap_gen=
.h
CONFLICT (content): Merge conflict in include/linux/netfilter/ipset/ip_set_=
timeout.h
CONFLICT (content): Merge conflict in include/linux/netfilter/ipset/ip_set_=
skbinfo.h
CONFLICT (content): Merge conflict in include/linux/netfilter/ipset/ip_set_=
counter.h
CONFLICT (content): Merge conflict in include/linux/netfilter/ipset/ip_set.h
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (ec2e93cf1910 b43: Avoid possible doub=
le calls to b43_one_core_detach())
Merging bluetooth/master (92ad6325cb89 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/davem/net)
Merging mac80211-next/master (f464100f5766 selftests/net: fix warnings in T=
FO key rotation selftest)
Merging gfs2/for-next (a4262eaf3df3 gfs2: Use IS_ERR_OR_NULL)
Merging mtd/mtd/next (a188339ca5a3 Linux 5.2-rc1)
Merging nand/nand/next (5dc353d306bf mtd: onenand_base: Avoid fall-through =
warnings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/brcm,brcmnand.txt
Merging spi-nor/spi-nor/next (62de37da9f38 mtd: spi-nor: intel-spi: Convert=
 to use SPDX identifier)
CONFLICT (content): Merge conflict in include/linux/platform_data/intel-spi=
.h
CONFLICT (modify/delete): drivers/mtd/spi-nor/stm32-quadspi.c deleted in sp=
i-nor/spi-nor/next and modified in HEAD. Version HEAD of drivers/mtd/spi-no=
r/stm32-quadspi.c left in tree.
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.h
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-platfor=
m.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-pci.c
$ git rm -f drivers/mtd/spi-nor/stm32-quadspi.c
Merging crypto/master (576d152ccc56 crypto: nx - no need to check return va=
lue of debugfs_create functions)
CONFLICT (content): Merge conflict in drivers/crypto/vmx/vmx.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_xts.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_ctr.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_cbc.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes.c
CONFLICT (content): Merge conflict in drivers/crypto/talitos.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-ops.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-aes.c
CONFLICT (modify/delete): crypto/crypto_wq.c deleted in crypto/master and m=
odified in HEAD. Version HEAD of crypto/crypto_wq.c left in tree.
$ git rm -f crypto/crypto_wq.c
Merging drm/drm-next (417f2544f48c Merge tag 'drm-intel-next-2019-06-19' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Makefile.header-=
test
CONFLICT (content): Merge conflict in Documentation/fb/modedb.rst
Applying: Revert "fbcon: Call con2fb_map functions directly"
Applying: Revert "vgaswitcheroo: call fbcon_remap_all directly"
Merging amdgpu/drm-next (f3f48d7331cf drm/amdgpu: drop unused df init callb=
ack)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_audio.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
$ git reset --hard HEAD^
Merging next-20190621 version of amdgpu
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_audio.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
[master 07837ecb3ec2] next-20190621/amdgpu
Merging drm-intel/for-linux-next (b2dbf8d982a4 drm/i915/blt: Remove recursi=
ve vma->lock)
Merging drm-tegra/drm/tegra/for-next (eb7cf945a8da host1x: debugfs_create_d=
ir() can never return NULL)
Merging drm-misc/for-linux-next (b1622cb3be45 drm/bridge: tfp410: fix use o=
f cancel_delayed_work_sync)
Merging drm-msm/msm-next (2aa317672597 drm/msm: Re-order uninit function to=
 work during probe defer)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (8f2501e643bc drm/komeda: Enable write=
back split support)
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/ko=
meda_dev.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/d7=
1/d71_dev.c
Merging imx-drm/imx-drm/next (fee77829083a gpu: ipu-v3: image-convert: Enab=
le double write reduction)
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-ic-prpe=
ncvf.c
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging regmap/for-next (0a19fcccf3ed Merge branch 'regmap-5.3' into regmap=
-next)
Merging sound/for-next (3f2ce83ddba9 ALSA: oxfw: ensure to release isochron=
ous resources in pcm.hw_params callback)
CONFLICT (content): Merge conflict in sound/pci/rme9652/hdspm.c
Merging sound-asoc/for-next (f1a783c2bfcd Merge remote-tracking branch 'aso=
c/topic/meson' into asoc-next)
Merging modules/modules-next (bc6f2a757d52 kernel/module: Fix mem leak in m=
odule_add_modinfo_attrs)
Merging input/next (002cdb95dc39 Input: gpio_keys - use struct_size() in de=
vm_kzalloc())
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (a6d5141ea08b Merge branch 'for-5.3/block' into for-=
next)
Merging device-mapper/for-next (51b86f9a8d1c dm: make sure to obey max_io_l=
en_target_boundary)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (4f8c162a9570 mmc: sdhci-pci: Add support for Intel EHL)
CONFLICT (content): Merge conflict in drivers/mmc/host/meson-gx-mmc.c
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (a65d642f93f8 mfd: madera: Add supply mapping for =
MICVDD)
CONFLICT (content): Merge conflict in include/linux/mfd/cros_ec_commands.h
Merging backlight/for-backlight-next (53fa0f87177d backlight: lm3630a: Add =
firmware node support)
Merging battery/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging regulator/for-next (bcb271f661d5 Merge branch 'regulator-5.3' into =
regulator-next)
Merging security/next-testing (ba9bfa0e4809 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (136db994852a apparmor: increase left match =
history buffer size)
Merging integrity/next-integrity (8c655784e2cf integrity: Fix __integrity_i=
nit_keyring() section mismatch)
Merging keys/keys-next (4a486e0b3656 Merge tag 'keys-misc-20190619' into ke=
ys-next)
Merging selinux/next (464c258aa45b selinux: fix empty write to keycreate fi=
le)
Merging tpmdd/next (3ba18a217340 tpm: Don't duplicate events from the final=
 event log in the TCG2 log)
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (9f5bd253b728 Merge branches 'iommu/fixes', 'x86/vt-d', =
'x86/amd', 'arm/renesas', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (12869ecd5eef scripts/dtc: Update to upstream v=
ersion v1.5.0-30-g702c1b6c0e73)
CONFLICT (content): Merge conflict in scripts/dtc/libfdt/Makefile.libfdt
CONFLICT (content): Merge conflict in scripts/dtc/Makefile.dtc
Merging mailbox/mailbox-for-next (35110e38e6c5 Merge tag 'media/v5.2-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging spi/for-next (738c1f9266a3 Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (861c7db57e49 Merge branch 'efi/urgent')
Merging clockevents/clockevents/next (21c768d5ef2f clocksource/drivers/arm_=
arch_timer: Extract elf_hwcap use to arch-helper)
Merging edac-amd/for-next (b2572772d13e EDAC: Make edac_debugfs_create_x*()=
 return void)
Merging irqchip/irq/irqchip-next (0bdd0047ec94 irqchip/mbigen: Stop printin=
g kernel addresses)
Merging ftrace/for-next (a124692b698b ftrace: Enable trampoline when rec co=
unt returns back to one)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (a251fb90ab8a KVM: x86: Fix apic dangling pointer in=
 vcpu)
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (3bda7f0ae0f7 KVM: PPC: Book3S PR: Fix softwar=
e breakpoints)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
Merging xen-tip/linux-next (1d5c76e66433 xen-blkfront: switch kcalloc to kv=
calloc for large array allocation)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (a2558e247804 platform/x86: hp_accel: Add supp=
ort for HP ProBook 450 G0)
Merging chrome-platform/for-next (9eecd07b3450 platform/chrome: cros_ec_lpc=
_mec: Fix kernel-doc comment first line)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (25529edef561 Merge tag 'ti-lmu-led-drivers' into for=
-next)
Merging ipmi/for-next (a88b6d5668be fix platform_no_drv_owner.cocci warning=
s)
Merging driver-core/driver-core-next (65bbdd49b472 lkdtm: remove redundant =
initialization of ret)
Merging usb/usb-next (58ee01007c9e Merge 5.2-rc6 into usb-next)
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging usb-gadget/next (aa23ce847dda usb: dwc3: remove unused @lock member=
 of dwc3_ep struct)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (f4c8116e294b phy: Add driver for mixel mipi dphy fou=
nd on NXP's i.MX8 SoCs)
Merging tty/tty-next (84872dc448fe serial: stm32: add RX and TX FIFO flush)
Merging char-misc/char-misc-next (8083f3d78825 Merge 5.2-rc6 into char-misc=
-next)
CONFLICT (content): Merge conflict in drivers/misc/vmw_balloon.c
CONFLICT (content): Merge conflict in drivers/misc/mei/debugfs.c
Merging extcon/extcon-next (bad5b5e707a5 extcon: Add fsa9480 extcon driver)
Merging soundwire/next (be1038846b80 docs: soundwire: locking: fix tags for=
 a code-block)
Merging thunderbolt/next (9e0babf2c06c Linux 5.2-rc5)
Merging staging/staging-next (90b45399b441 Merge 5.2-rc6 into staging-next)
Applying: Revert "staging: ks7010: Fix build error"
Merging mux/for-next (05fb8284a417 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (0eaab70a7a1b dmagengine: pl330: add code to get res=
et property)
CONFLICT (modify/delete): include/linux/sudmac.h deleted in slave-dma/next =
and modified in HEAD. Version HEAD of include/linux/sudmac.h left in tree.
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
CONFLICT (content): Merge conflict in drivers/dma/dma-jz4780.c
CONFLICT (content): Merge conflict in drivers/dma/dma-axi-dmac.c
$ git rm -f include/linux/sudmac.h
Merging cgroup/for-next (22a0b83583ab Merge branch 'for-5.3' into for-next)
CONFLICT (content): Merge conflict in Documentation/cgroup-v1/blkio-control=
ler.rst
CONFLICT (content): Merge conflict in Documentation/block/bfq-iosched.txt
Merging scsi/for-next (6eedc3f97ef7 Merge branch 'fixes' into for-next)
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_spi.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_iscsi.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_fc.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport.h
CONFLICT (content): Merge conflict in include/scsi/scsi_bsg_iscsi.h
CONFLICT (content): Merge conflict in include/scsi/sas_ata.h
CONFLICT (content): Merge conflict in include/scsi/sas.h
CONFLICT (content): Merge conflict in include/scsi/libsas.h
CONFLICT (content): Merge conflict in include/scsi/libiscsi_tcp.h
CONFLICT (content): Merge conflict in include/scsi/libiscsi.h
CONFLICT (content): Merge conflict in include/scsi/libfcoe.h
CONFLICT (content): Merge conflict in include/scsi/libfc.h
CONFLICT (content): Merge conflict in include/scsi/iscsi_proto.h
CONFLICT (content): Merge conflict in include/scsi/iscsi_if.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_ms.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_fcp.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_fcoe.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_fc2.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_encaps.h
CONFLICT (content): Merge conflict in drivers/scsi/st.c
CONFLICT (content): Merge conflict in drivers/scsi/sr.c
CONFLICT (content): Merge conflict in drivers/scsi/sg.c
CONFLICT (content): Merge conflict in drivers/scsi/ses.c
CONFLICT (content): Merge conflict in drivers/scsi/sd_zbc.c
CONFLICT (content): Merge conflict in drivers/scsi/sd_dif.c
CONFLICT (content): Merge conflict in drivers/scsi/sd.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_srp.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_spi.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_sas.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_iscsi.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_fc.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_trace.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysfs.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysctl.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_pm.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_logging.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_lib.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_ioctl.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_error.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi.c
CONFLICT (modify/delete): drivers/scsi/osst.c deleted in scsi/for-next and =
modified in HEAD. Version HEAD of drivers/scsi/osst.c left in tree.
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_task.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_scsi_host.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_internal.h
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_init.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_host_smp.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_ata.c
CONFLICT (content): Merge conflict in drivers/scsi/libiscsi_tcp.c
CONFLICT (content): Merge conflict in drivers/scsi/libiscsi.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_rport.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_npiv.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_lport.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_libfc.h
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_libfc.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_frame.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_fcp.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_exch.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_elsct.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_disc.c
CONFLICT (content): Merge conflict in drivers/scsi/hosts.c
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe_transport.c
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe_sysfs.c
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe_ctlr.c
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe.h
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe.c
$ git rm -f drivers/scsi/osst.c
Merging scsi-mkp/for-next (7cbc991b966c Merge branch '5.3/scsi-sg' into scs=
i-next)
Merging vhost/linux-next (169a126c6e88 iommu/virtio: Add event queue)
Merging rpmsg/for-next (b3e144584ac2 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (c8ecfd6caa1e Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (2674700c4c0e gpio: max732x: use devm_gpioc=
hip_add_data())
Merging pinctrl/for-next (7de3a67d5751 Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson8b-gpio=
.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson8-gpio.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson-gxl-gp=
io.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson-gxbb-g=
pio.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8b=
.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8-=
pmx.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8-=
pmx.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson-g=
xl.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson-g=
xbb.c
Merging pinctrl-samsung/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging pwm/for-next (f41efceb46e6 pwm: meson: Add clock source configurati=
on for Meson G12A)
Merging userns/for-next (318759b4737c signal/x86: Move tsk inside of CONFIG=
_MEMORY_FAILURE in do_sigbus)
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arc/mm/fault.c
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (fe48319243a6 selftests/timers: Add missing fflush(s=
tdout) calls)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (28f28ea4343a Merge branch 'for-5.3-core' int=
o for-next)
Merging coresight/next (1a044213fc64 slimbus: core: generate uevent for non=
-dt only)
Merging rtc/rtc-next (3572e8aea3bf rtc: pcf8563: Clear event flags and disa=
ble interrupts before requesting irq)
Merging nvdimm/libnvdimm-for-next (241e39004581 nfsd: replace Jeff by Chuck=
 as nfsd co-maintainer)
Merging at24/at24/for-next (9ae9d9bfb72c eeprom: at24: use struct_size() in=
 devm_kzalloc())
Merging ntb/ntb-next (d9c53aa440b3 NTB: Describe the ntb_msi_test client in=
 the documentation.)
Merging kspp/for-next/kspp (2dcbe7fe2265 lib/test_stackinit: Handle Clang a=
uto-initialization pattern)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (c8d087d040cf nvmem: Broaden the selection of NVMEM_=
SNVS_LPGPR)
CONFLICT (content): Merge conflict in drivers/nvmem/meson-mx-efuse.c
CONFLICT (content): Merge conflict in drivers/nvmem/meson-efuse.c
Merging xarray/xarray (12fd2aee6db7 XArray tests: Add check_insert)
Merging hyperv/hyperv-next (674eecb3d35a drivers: hv: Add a module descript=
ion line to the hv_vmbus driver)
Merging auxdisplay/auxdisplay (f4bb1f895aa0 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (ec8dce301980 Merge branch 'clone' into for-next)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/pidfd_t=
est.c
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
Merging devfreq/for-next (5bbc419e5ec4 PM / devfreq: events: add Exynos PPM=
U new events)
Merging hmm/hmm (9b1ae605c8e2 mm/hmm: Only set FAULT_FLAG_ALLOW_RETRY for n=
on-blocking)
Merging akpm-current/current (f9623ef862c8 Revert "lib/debugobjects.c: move=
 printk out of db lock critical sections")
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in kernel/dma/remap.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (content): Merge conflict in fs/binfmt_flat.c
Applying: merge fixup for "mm: Add an apply_to_pfn_range interface"
Applying: merge fix for "locking/lockdep: Rename lockdep_assert_held_exclus=
ive() -> lockdep_assert_held_write()"
Applying: another fixup for "mm: Add an apply_to_pfn_range interface"
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: proc/sysctl: add shared variables for range check
Applying: tipc: remove two unused variables
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-2-fix
Applying: proc/sysctl: make firmware loader table conditional
Applying: fs/select.c: use struct_size() in kmalloc()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (3e5923285ca1 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/BD1L_oQfiXjPoqe_W5e.SB9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QviYACgkQAVBC80lX
0GwiVgf/XcR2Lq8fP/Ipnt+K9E8ILZnDwBECfBbKtzzKWanrwsnkwGnDkqkUvNnU
NPT5OX8EcMRsM6WB7sQIWkkcJLoiletGEo31HgsNe0XUn4Jr1m4JiiW/BwNFT7UW
R9Rq9D1Ci4Fcri+Oa+VG6SRwr9Vygxw8G4TkuoYy1ccIFsUyfGRrPqfnDl4rlj53
McGsr3RsGSE7bTgLQmMgNds4/Mkyj4kmvuLusEOsRRxyd4wewzUzhtTj8bDqXOiM
w028kHVfiUKlmPOiJ8IBzKp7dGi2G3cANwDLX9tV8KLSoMB6sDsdwMQRH0YTERNp
syVtcDZUFaxqlx6R7CGfjcCBj7dZBg==
=iw0l
-----END PGP SIGNATURE-----

--Sig_/BD1L_oQfiXjPoqe_W5e.SB9--
