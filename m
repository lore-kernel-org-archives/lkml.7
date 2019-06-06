Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D1EC28D1A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A60020868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RVtsYUOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFFGqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:46:42 -0400
Received: from ozlabs.org ([203.11.71.1]:60033 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFGql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:46:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45KGR10h9vz9s4Y;
        Thu,  6 Jun 2019 16:46:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559803597;
        bh=R2hqB6QOfi1jIZEXkmQ79PpmgpC2JPIloz1l6ekWCns=;
        h=Date:From:To:Cc:Subject:From;
        b=RVtsYUOM+ywIQuxFdYRQeSxq0salz4MallzuAPlXPOO65jJD8ntHZZdd7xCCZrck/
         YR4Zz60Vqv6kMmk/CwktFUIlEoWNrgoQle7vMMaWavbMHORGVqB9TBe0i2ch70pU0B
         eWCVhqDtzAf42CLpT6OCRvycviAhPoZGfD1NIj+ISvZ+4JQbMMG/gSqAr/QUJOnesm
         T3ulunorfdeemxDijbTDjynbrrQoxXG8u9GUotMkFNqfQrwmo8yznk9L1Nqpm5i+KE
         EJ91Y+qhX34wmVcCsqxAStoI96eGWj79rMwKlWDStbAPc+nv4yHU+91OL7M5rfMq0I
         evmfUsRs0ve8w==
Date:   Thu, 6 Jun 2019 16:46:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 6
Message-ID: <20190606164635.71837116@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jEA+Z=B=ORPPk/BI7fMoMbz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jEA+Z=B=ORPPk/BI7fMoMbz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190605:

The hwmon-fixes tree gained a build failure for which I reverted a commit.

The hwmon-staging tree gained a conflict against Linus' tree.

The v4l-dvb tree gained conflicts against Linus' tree.

The net-next tree gained a conflict against the bpf tree.

The tpmdd tree still had its build failure so I used the version from
next-20190604.

The pidfd tree gained a conflict against Linus' tree.

Non-merge commits (relative to Linus' tree): 4210
 4643 files changed, 166987 insertions(+), 163412 deletions(-)

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

I am currently merging 293 trees (counting Linus' and 71 trees of bug
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
Merging origin/master (156c05917e09 Merge tag 'linux-kselftest-5.2-rc4' of =
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (4f45d62a5229 scripts/checkstack.pl: Fix arm64=
 wrong or unknown architecture)
Merging arc-current/for-curr (46e04c25e72f ARC: [plat-hsdk] Get rid of inap=
propriate PHY settings)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (f31e98bfae1c arm64: arch_timer: mark fu=
nctions as __always_inline)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (8b909e354870 powerpc/kexec: Fix loading of ker=
nel + initramfs with kexec_file_load())
Merging s390-fixes/fixes (962f0af83c23 s390/mm: fix address space detection=
 in exception handling)
Merging sparc/master (30d1d92a888d Merge tag 'nds32-for-linux-5.2-rc3' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (e7a9fe7b0df7 Merge branch 's390-qeth-fixes')
Merging bpf/master (1884c066579a tools: bpftool: Fix JSON output when looku=
p fails)
Merging ipsec/master (7c80eb1c7e2b af_key: fix leaks in key_pol_get_resp an=
d dump_sp.)
Merging netfilter/master (a0d56cb911ca netfilter: ipv6: nf_defrag: fix leak=
age of unqueued fragments)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (69ae4f6aac15 mwifiex: Fix heap overflow in=
 mwifiex_uap_parse_tail_ies())
Merging mac80211/master (180aa422ef27 nl80211: fill all policy .type entrie=
s)
Merging rdma-fixes/for-rc (4f240dfec6bc RDMA/efa: Remove MAYEXEC flag check=
 from mmap flow)
Merging sound-current/for-linus (717f43d81afc ALSA: hda/realtek - Update he=
adset mode for ALC256)
Merging sound-asoc-fixes/for-linus (b3e5ab9f5656 Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (38ee2a8cc70e Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (9a917498e18a Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (4e197466e664 Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (a188339ca5a3 Linux 5.2-rc1)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (bd21f0222ada USB: Fix chipmunk-like voice wh=
en using Logitech C270 for recording audio.)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (f3dfd4072c3e USB: serial: option: add T=
elit 0x1260 and 0x1261 compositions)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (700ffe3c92c2 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging char-misc.current/char-misc-linus (8aa75b72e3e6 Merge tag 'misc-hab=
analabs-fixes-2019-05-24' of git://people.freedesktop.org/~gabbayo/linux in=
to char-misc-linus)
Merging soundwire-fixes/fixes (03ecad90d379 soundwire: stream: fix out of b=
oundary access on port properties)
Merging thunderbolt-fixes/fixes (f2c7c76c5d0a Linux 5.2-rc3)
Merging input-current/for-linus (7c7da40da164 Input: uinput - add compat io=
ctl number translation for UI_*_FF_UPLOAD)
Merging crypto-current/master (7829a0c1cb9c crypto: hmac - fix memory leak =
in hmac_init_tfm())
Merging ide/master (54dee406374c Merge tag 'arm64-fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/arm64/linux)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (e2e88325f4bc selftests: vm: Fix test build f=
ailure when built by itself)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (8243b87c3abb dt-bindings: dma: uart: rename =
binding)
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (b2b5921fe4b3 mtd: rawnand: initialize ntargets=
 with maxchips)
Merging mfd-fixes/for-mfd-fixes (e93c9c99a629 Linux 5.1)
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (f532beeeff0c MIPS: uprobes: remove set but n=
ot used variable 'epc')
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (4ee23cd76c0c Merge branch 'omap-for-v5.2/ti-sysc'=
 into fixes)
Merging kvm-fixes/master (f8d221d2e0e1 Merge tag 'kvm-s390-master-5.2-2' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-maste=
r)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (15deb1d9b599 hwmon: (pmbus/core) Treat parameter=
s as paged if on multiple pages)
Merging nvdimm-fixes/libnvdimm-fixes (52f476a323f9 libnvdimm/pmem: Bypass C=
ONFIG_HARDENED_USERCOPY overhead)
Merging btrfs-fixes/next-fixes (8b1d37b7b32d Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (d8076bdb56af uapi: Wire up the mount API syscalls =
on non-x86 arches [ver #2])
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (d6423bd03031 platform/x86: pmc_atom: Add s=
everal Beckhoff Automation boards to critclk_systems DMI table)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (cc8f52609bb4 scsi: smartpqi: unlock on error in p=
qi_submit_raid_request_synchronous())
Merging drm-fixes/drm-fixes (2a3e0b716296 Merge tag 'imx-drm-fixes-2019-05-=
29' of git://git.pengutronix.de/git/pza/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (fa2eb819ddf9 Merge tag 'gvt-f=
ixes-2019-06-05' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (739799314587 mmc: sdhci_am654: Fix SLOTTYPE write)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (283f1e383e91 udmabuf: actually=
 unmap the scatterlist)
Applying: Revert "hwmon: (pmbus/core) mutex_lock write in pmbus_set_samples"
Merging kbuild/for-next (9208119be1c3 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (2e96e04d25ca MIPS: use the generic uncached s=
egment support in dma-direct)
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (ef94e8ea94ed ARC: entry: EV_Trap expects r10 (vs. r9)=
 to have exception cause)
Merging arm/for-next (439ae50145bf Merge commit 'riscpc^{/ARM: riscpc: dma:=
 use __iomem pointers for writing DMA}' into for-next)
Merging arm64/for-next/core (f086f67485c5 arm64: ptrace: add support for sy=
scall emulation)
Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU hot=
plug handling)
Merging arm-soc/for-next (7ad1b252cabe ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (6c8055ecf4e7 Merge branch 'v5.3/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (130413736376 ARM: dts: aspeed: Add Microsoft Olymp=
us BMC)
Merging at91/at91-next (32dfd9cfa4c6 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (83d02ffe0144 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (07eb35473c64 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (4ee23cd76c0c Merge branch 'omap-for-v5.2/ti-sysc' in=
to fixes)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging qcom/for-next (d1b240beca65 Merge branch 'drivers-for-5.3' into all=
-for-5.3)
Merging renesas/next (f7918626c158 Merge branches 'arm-soc-for-v5.3' and 'a=
rm64-dt-for-v5.3' into next)
Merging rockchip/for-next (89185e6d0dc7 Merge branch 'v5.3-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (d68c44eaa535 Merge branch 'next/defconfig' i=
nto for-next)
Merging sunxi/sunxi/for-next (f8bca8339e6b Merge branch 'sunxi/clk-for-5.3'=
 into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging tegra/for-next (1cad9fdb86d5 Merge branch for-5.3/arm64/dt into for=
-next)
Merging clk/clk-next (f191a146bcee Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (c304b8d2f9aa clk: samsung: exynos5433: Use of=
_clk_get_parent_count())
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (6b436744a0b7 csky: Fixup no panic in kernel for so=
me traps)
Merging h8300/h8300-next (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linu=
x-nfs.org/~bfields/linux)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f67d667213ba m68k: defconfig: Update defconfigs for =
v5.2-rc1)
Merging m68knommu/for-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (361686288213 MIPS: replace MBIT_ULL() with BIT_ULL(=
))
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (ed48f3f23273 parisc: Use lpa instruction to loa=
d physical addresses in driver code)
Merging powerpc/next (a3bf9fbdad60 powerpc/pseries: Fix xive=3Doff command =
line)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (8fef9900d43f riscv: fix locking violation in page =
fault handler)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (753469a23b42 Merge tag 'vfio-ccw-20190603' of https:=
//git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into features)
Merging sh/sh-next (860dbce3d8dd Merge branch 'master' of git://git.kernel.=
org/pub/scm/linux/kernel/git/torvalds/linux)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (2ba543d3e7db Merge branch 'xtensa-5.2-fixes=
' into xtensa-for-next)
Merging fscrypt/master (5858bdad4d0d fscrypt: don't set policy for a dead d=
irectory)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (7b2f936fc828 ceph: fix error handling in ceph_get_caps=
())
Merging cifs/for-next (32ba80cdd186 cifs: Use kmemdup in SMB2_ioctl_init())
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (3803f4dc265f Merge ext2 bitmap bh leak fix.)
Merging ext4/dev (a49773064bc2 jbd2: fix typo in comment of journal_submit_=
inode_data_buffers)
Merging f2fs/dev (f14f319eb1a1 f2fs: add a rw_sem to cover quota flag chang=
es)
Merging fuse/for-next (26eb3bae5003 fuse: extract helper for range writebac=
k)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging nfs-anna/linux-next (ba851a39c970 NFSv4.1: Fix bug only first CB_NO=
TIFY_LOCK is handled)
Merging nfsd/nfsd-next (f420eae8f7c9 nfsd: Spelling s/EACCESS/EACCES/)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (5d3211b651a0 ovl: doc: add non-standard c=
orner cases)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (025197ebb08a xfs: inode btree scrubber should calcula=
te im_boffset correctly)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (967aa2217b6d Merge branch 'for-5.2-fixes' into for=
-next)
Merging pci/next (bf593ef5d4c4 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (e070e380c674 Merge branch 'for-linus/pstore=
' into for-next/pstore)
Merging hid/for-next (e72e014cd305 Merge branch 'for-5.2/fixes' into for-ne=
xt)
Merging i2c/i2c/for-next (6e2700c656e5 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (5e343fbb7176 dt-bindings: i3c: Document dropped suppo=
rt for I2C 10 bit devices)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (b14a1f7369f2 hwmon: (pmbus) Add Infineon =
IRPS5401 driver)
CONFLICT (content): Merge conflict in drivers/hwmon/tc654.c
CONFLICT (content): Merge conflict in drivers/hwmon/nct7904.c
Merging jc_docs/docs-next (18e1572419d6 docs: Completely fix the remote bui=
ld tree case)
Merging v4l-dvb/master (edadd68031e5 media: MAINTAINERS: update email addre=
ss)
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/ven=
c_vpu_if.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/ven=
c_vpu_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/ven=
c_ipi_msg.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/ven=
c_drv_if.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/ven=
c_drv_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/ven=
c_drv_base.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/ven=
c/venc_vp8_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/ven=
c/venc_h264_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c_vpu_if.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c_vpu_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c_ipi_msg.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c_drv_if.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c_drv_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c_drv_base.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c/vdec_vp9_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c/vdec_vp8_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/vde=
c/vdec_h264_if.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_util.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_util.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_intr.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_intr.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_enc_pm.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_enc_pm.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_enc_drv.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_enc.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_enc.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_drv.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_dec_pm.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_dec_pm.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_dec_drv.c
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_dec.h
CONFLICT (content): Merge conflict in drivers/media/platform/mtk-vcodec/mtk=
_vcodec_dec.c
CONFLICT (content): Merge conflict in drivers/media/i2c/cx25840/cx25840-cor=
e.c
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (73ee89436047 Merge tag 'v5.2-rc1' of https://=
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into fbdev-for-next)
Merging pm/linux-next (b4e3258c27cd Merge branch 'devprop' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (4c5681fcc684 cpufreq: brcmstb-a=
vs-cpufreq: Fix types for voltage/frequency)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (c0ab9e0812da opp: Allocate genpd_virt_devs from=
 dev_pm_opp_attach_genpd())
Merging thermal/next (6df24c3e81b9 Merge branches 'thermal-core', 'thermal-=
built-it' and 'thermal-intel' into next)
Merging thermal-soc/next (cd6c84d8f0cd Linux 5.2-rc2)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (54cca4bad076 dlm: allow binding to all network interfaces)
Merging swiotlb/linux-next (4e7372e0dc5d xen/swiotlb: don't initialize swio=
tlb twice on arm64)
Merging rdma/for-next (97545b10221a RDMA/hns: Bugfix for posting multiple s=
rq work request)
Merging net-next/master (2bd229df5e2e net: phy: remove state PHY_FORCING)
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/Makefile
CONFLICT (modify/delete): drivers/isdn/hisax/hfc_usb.c deleted in net-next/=
master and modified in HEAD. Version HEAD of drivers/isdn/hisax/hfc_usb.c l=
eft in tree.
CONFLICT (modify/delete): drivers/isdn/gigaset/i4l.c deleted in net-next/ma=
ster and modified in HEAD. Version HEAD of drivers/isdn/gigaset/i4l.c left =
in tree.
$ git rm -f drivers/isdn/gigaset/i4l.c drivers/isdn/hisax/hfc_usb.c
Merging bpf-next/master (07c3bbdb1a9b samples: bpf: print a warning about h=
eaders_install)
Merging ipsec-next/master (2a99283cb7c1 Merge branch 'net-dsa-mv88e6xxx-sup=
port-for-mv88e6250')
Merging mlx5-next/mlx5-next (8693115af4c2 {IB,net}/mlx5: Constify rep ops f=
unctions pointers)
Merging netfilter-next/master (b7034146756b net: fix use-after-free in kfre=
e_skb_list)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (ec2e93cf1910 b43: Avoid possible doub=
le calls to b43_one_core_detach())
Merging bluetooth/master (b33bc2b878e0 nexthop: Add entry to MAINTAINERS)
Merging mac80211-next/master (a3ce17d1495b cfg80211: Handle bss expiry duri=
ng connection)
Merging gfs2/for-next (d8e126ba276a gfs2: Clean up freeing struct gfs2_sbd)
Merging mtd/mtd/next (a188339ca5a3 Linux 5.2-rc1)
Merging nand/nand/next (5dc353d306bf mtd: onenand_base: Avoid fall-through =
warnings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/brcm,brcmnand.txt
Merging spi-nor/spi-nor/next (a188339ca5a3 Linux 5.2-rc1)
Merging crypto/master (0adb0c99594b dt-bindings: move Atmel ECC508A I2C cry=
pto processor to trivial-devices)
CONFLICT (content): Merge conflict in drivers/crypto/talitos.c
CONFLICT (modify/delete): crypto/crypto_wq.c deleted in crypto/master and m=
odified in HEAD. Version HEAD of crypto/crypto_wq.c left in tree.
$ git rm -f crypto/crypto_wq.c
Merging drm/drm-next (91c1ead6aee2 Merge branch 'drm-next-5.3' of git://peo=
ple.freedesktop.org/~agd5f/linux into drm-next)
Merging amdgpu/drm-next (137a7da92557 Revert "drm/amdgpu: add DRIVER_SYNCOB=
J_TIMELINE to amdgpu")
Merging drm-intel/for-linux-next (b71438606343 drm/i915/ehl: Support HBR3 o=
n EHL combo PHY)
Merging drm-tegra/drm/tegra/for-next (e923ec31d67e drm/tegra: dpaux: Make V=
DD supply optional)
Merging drm-misc/for-linux-next (50f9495efe30 drm/bridge/synopsys: dw-hdmi:=
 Add "unwedge" for ddc bus)
Merging drm-msm/msm-next (981f2aabeae6 drm/msm/a6xx: Rename a6xx_gmu_probe =
to a6xx_gmu_init)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (15e9122d9b5c drm/komeda: Mark the loc=
al functions as static)
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging regmap/for-next (38ee2a8cc70e Merge branch 'regmap-5.2' into regmap=
-linus)
Merging sound/for-next (e046b64b1547 ALSA: hda/ca0132: Use struct_size())
CONFLICT (content): Merge conflict in sound/pci/rme9652/hdspm.c
Merging sound-asoc/for-next (1ca88875f8a3 Merge branch 'asoc-5.3' into asoc=
-next)
Merging modules/modules-next (6e6de3dee51a kernel/module.c: Only return -EE=
XIST for modules that have finished loading)
Merging input/next (b02f6b6b711b Input: tca8418 - remove set but not used v=
ariable 'max_keys')
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (51af912e51dd Merge branch 'io_uring-next' into for-=
next)
Merging device-mapper/for-next (51b86f9a8d1c dm: make sure to obey max_io_l=
en_target_boundary)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (a78b6dc2b410 mmc: sdhci-pci: remove redundant check of sl=
ots =3D=3D 0)
CONFLICT (content): Merge conflict in drivers/mmc/host/meson-mx-sdio.c
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (c769c3cb70e0 mfd: cros_ec: Update I2S API)
Merging backlight/for-backlight-next (53fa0f87177d backlight: lm3630a: Add =
firmware node support)
Merging battery/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging regulator/for-next (71ebdf157a12 Merge branch 'regulator-5.3' into =
regulator-next)
Merging security/next-testing (5664f5faac11 Merge branch 'next-smack' into =
next-testing)
Merging apparmor/apparmor-next (06c13f554a71 apparmor: re-introduce a varia=
nt of PROFILE_MEDIATES_SAFE)
Merging integrity/next-integrity (2cd4737bc850 ima: prevent a file already =
mmap'ed write to be mmap'ed execute)
Merging selinux/next (beee56f3543a selinux: remove some no-op BUG_ONs)
Merging tpmdd/next (3ed5d6926f08 efi: Attempt to get the TCG2 event log in =
the boot stub)
$ git reset --hard HEAD^
Merging next-20190604 version of tpmdd
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (d6f11edc3bf7 Merge branches 'iommu/fixes', 'x86/vt-d', =
'x86/amd', 'arm/renesas', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (b361797f3d0b dt-bindings: vendor: Fix simtek v=
endor compatible)
Merging mailbox/mailbox-for-next (8fbbfd966efa mailbox: Add support for Arm=
ada 37xx rWTM mailbox)
Merging spi/for-next (2b6b4e109653 Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (6830f996dc6b Merge branch 'irq/core')
Merging clockevents/clockevents/next (a9b144553852 driver: clocksource: Add=
 nxp system counter timer driver support)
Merging edac-amd/for-next (8de9930a4618 Revert "EDAC/amd64: Support more th=
an two controllers for chip select handling")
Merging irqchip/irq/irqchip-next (4770533f71de irqchip/renesas-irqc: Conver=
t to managed initializations)
Merging ftrace/for-next (a124692b698b ftrace: Enable trampoline when rec co=
unt returns back to one)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (94830f188a80 Merge tag 'kvm-s390-master-5.2-1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (4894fbcce856 KVM: PPC: Book3S: Remove useless=
 checks in 'release' method of KVM device)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
Merging xen-tip/linux-next (1d5c76e66433 xen-blkfront: switch kcalloc to kv=
calloc for large array allocation)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (ef071bab655b power: supply: olpc_battery: All=
ow building the driver on non-x86)
Merging chrome-platform/for-next (81bc8c03e1b0 platform/chrome: cros_ec: Ma=
ke some symbols static)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (1916ebfdfbac leds: max77650: Remove set but not used=
 variable 'parent')
Merging ipmi/for-next (3559c3270aa3 drivers: ipmi: Drop device reference)
Merging driver-core/driver-core-next (c9c2c27d7cec debugfs: make debugfs_cr=
eate_u32_array() return void)
Merging usb/usb-next (32adeab3e3b5 usb: phy: mv-usb: Remove set but not use=
d variable 'phy')
Merging usb-gadget/next (2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRAT=
A)
Merging usb-serial/usb-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (6ef72bc036bc phy: qcom: Add Qualcomm PCIe2 PHY drive=
r)
Merging tty/tty-next (15b3cd8ef46a Revert "consolemap: Fix a memory leaking=
 bug in drivers/tty/vt/consolemap.c")
Merging char-misc/char-misc-next (381e9760ee87 firmware: google: coreboot: =
Drop unnecessary headers)
Merging extcon/extcon-next (fbdc60b2a787 extcon: arizona: Correct error han=
dling on regmap_update_bits_check)
Merging soundwire/next (be1038846b80 docs: soundwire: locking: fix tags for=
 a code-block)
Merging thunderbolt/next (f2c7c76c5d0a Linux 5.2-rc3)
Merging staging/staging-next (7acc77d20892 staging: rtl8188eu: remove ODM_P=
hyStatusQuery() wrapper)
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (2fe5575f36ca dmaengine: sun6i: Add support for H6 D=
MA)
CONFLICT (content): Merge conflict in drivers/dma/dma-jz4780.c
Merging cgroup/for-next (155fef3bc7cd Merge branch 'for-5.3' into for-next)
Merging scsi/for-next (b214814924c2 Merge branch 'misc' into for-next)
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
CONFLICT (content): Merge conflict in include/scsi/iscsi_proto.h
CONFLICT (content): Merge conflict in include/scsi/iscsi_if.h
CONFLICT (content): Merge conflict in drivers/scsi/st.c
CONFLICT (content): Merge conflict in drivers/scsi/sr.c
CONFLICT (content): Merge conflict in drivers/scsi/sg.c
CONFLICT (content): Merge conflict in drivers/scsi/ses.c
CONFLICT (content): Merge conflict in drivers/scsi/sd.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_spi.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_sas.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_iscsi.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_fc.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysfs.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysctl.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_pm.c
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
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_ata.c
CONFLICT (content): Merge conflict in drivers/scsi/libiscsi_tcp.c
CONFLICT (content): Merge conflict in drivers/scsi/libiscsi.c
CONFLICT (content): Merge conflict in drivers/scsi/hosts.c
$ git rm -f drivers/scsi/osst.c
Merging scsi-mkp/for-next (91a801703de8 scsi: ibmvscsi: Don't use rc uninit=
ialized in ibmvscsi_do_work)
Merging vhost/linux-next (2de01b71e7fd iommu/virtio: Add event queue)
Merging rpmsg/for-next (c3a261f27133 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (8b74ae41f1ee gpio: pca953x: Add support for the TI T=
CA9539)
Merging gpio-brgl/gpio/for-next (2674700c4c0e gpio: max732x: use devm_gpioc=
hip_add_data())
Merging pinctrl/for-next (8219ffa1e232 pinctrl: u300: Fix SPDX tags)
CONFLICT (content): Merge conflict in drivers/pinctrl/pinctrl-u300.c
CONFLICT (content): Merge conflict in drivers/pinctrl/pinctrl-coh901.c
CONFLICT (content): Merge conflict in drivers/pinctrl/nomadik/pinctrl-abx50=
0.c
CONFLICT (content): Merge conflict in drivers/pinctrl/nomadik/Kconfig
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
Merging livepatching/for-next (95def8fe33ed Merge branch 'for-5.2/fixes' in=
to for-next)
Merging coresight/next (8f35caae1e1f coresight: acpi: Support for platform =
devices)
Merging rtc/rtc-next (a3094fc1a15e rtc: imx-sc: add rtc alarm support)
Merging nvdimm/libnvdimm-for-next (cd6c84d8f0cd Linux 5.2-rc2)
Merging at24/at24/for-next (9ae9d9bfb72c eeprom: at24: use struct_size() in=
 devm_kzalloc())
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (2dcbe7fe2265 lib/test_stackinit: Handle Clang a=
uto-initialization pattern)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (c8d087d040cf nvmem: Broaden the selection of NVMEM_=
SNVS_LPGPR)
Merging xarray/xarray (12fd2aee6db7 XArray tests: Add check_insert)
Merging hyperv/hyperv-next (a3fb7bf369ef drivers: input: serio: Add a modul=
e desription to the hyperv_keyboard driver)
Merging auxdisplay/auxdisplay (f4cd7203c1d4 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (08f2abef168d tests: add pidfd_open() tests)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/pidfd_t=
est.c
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging akpm-current/current (88b28c8504ba include/linux/lz4.h: fix spellin=
g and copy-paste errors in documentation)
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (content): Merge conflict in include/linux/genalloc.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: mm/hmm.c: suppress compilation warnings when CONFIG_HUGETLB_PAGE =
is not set
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (f01c8e6b4049 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/jEA+Z=B=ORPPk/BI7fMoMbz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz4tssACgkQAVBC80lX
0Gx1PQf+O27oaBGHBUgYgqG8eSd3nQ8lDPXO+c+4bvxtH1Vm8BghN3PRctmqgqhy
mHdlISQ1g9CfUnoJcE349LPcGGIBCxLP2N3Uhr9+f3EOpSuCK1vxfXPyXvIkb1in
lD0/TlWAFJRaTFJxx747nfFJzpqpuurzokHmv7dBOCLvH/Kxuzv6BQpLxj0+V9b9
A7Gnj6YCup+QMDDUoaBQtyycnXLRFoBlEO4D8R4SsFii+mHjQ3Ityy4cLzmUl2Ss
hHJpTFCHidHQFUFtNjDY03ICHG4ArXPS4kcMRsHIg03GzX7n570CXMIhSUrqcBDt
jXXCZkWrui1eNDA4cKjERfQH2srP/w==
=95Mz
-----END PGP SIGNATURE-----

--Sig_/jEA+Z=B=ORPPk/BI7fMoMbz--
