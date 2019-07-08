Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB83C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AC920665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uan8TKJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfGHMmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:42:49 -0400
Received: from ozlabs.org ([203.11.71.1]:42323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfGHMms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:42:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45j4q502Xcz9sP0;
        Mon,  8 Jul 2019 22:42:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562589761;
        bh=udLsmnIJ0qwVGpQW9u2Ltgq/VleqBX6ctVIFrhhYAYc=;
        h=Date:From:To:Cc:Subject:From;
        b=uan8TKJ2+ii3D9JdmeZ4sCQVby1lijgqT/XMZRuhia6mUiXdJ5WPigrnkAW8nicyp
         He1Mpx4OyD10YDQ4Jl1/dIt99GpKuZX1jqSuRIXGKm9ntX/KD9oq2U2qJ3gup8SSpS
         zq6EiUhNnmr4/JrvcxHYV1tPTYNcQCocaSEho1pHNdbuG+ydVa//MEpD7fn1/c6mjA
         /UWkwNkk029RKmrBupzcct/sPxDPJhikMDvzdeV1++xrtf5649Y1beseZBLo0SNvUK
         W2qTX5s6aQDo+sa56eoO6x4gUnWx8HI9UNh1Dvn7Op+3/II38fnX+oKmqqup4Er4kt
         EhePTWyVbiELQ==
Date:   Mon, 8 Jul 2019 22:42:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 8
Message-ID: <20190708224238.60bd0aff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hHWpiKlbUjC7WZS2GJqvGUX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hHWpiKlbUjC7WZS2GJqvGUX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190705:

The kbuild tree lost its build failure.

The vfs tree gained a conflict against the nfsd tree.

The jc_docs tree gained a conflict against the vfs tree.

The rdma tree lost its build failures but gained another so I used the
version from next-20190628.

The netfilter-next tree gained a build failure due to an interaction
with the kbuild tree for which I applied a merge fix patch.

The gfs2 tree gained a conflict against the vfs tree.

The drm tree gained a conflict against the vfs tree and a build failure
due to an interaction with the vfs tree for which I applied a merge
fix patch.

The slave-dma tree lost its build failure.

The edac-amd tree gained a conflict against the risc-v tree.

The kvm-arm tree gained a conflict against the arm64 tree.

The driver-core tree gained conflicts against the vfs and nfs trees.

The char-misc tree gained a build failure due to an interaction with
the vfs tree for which I applied a merge fix patch.

The nvdimm tree lost its build failure.

The akpm-current tree gained a conflict against the powerpc tree.

Non-merge commits (relative to Linus' tree): 11928
 11172 files changed, 863413 insertions(+), 322536 deletions(-)

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

I am currently merging 299 trees (counting Linus' and 72 trees of bug
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
Merging origin/master (46713c3d2f8d Merge tag 'for-linus-20190706' of git:/=
/git.kernel.dk/linux-block)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging arc-current/for-curr (5c100a5d6245 ARC: hide unused function unw_hd=
r_alloc)
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm-soc-fixes/arm/fixes (2659dc8d225c Merge tag 'davinci-fixes-for-=
v5.2-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-=
davinci into arm/fixes)
Merging arm64-fixes/for-next/fixes (aa69fb62bea1 arm64/efi: Mark __efistub_=
stext_offset as an absolute symbol explicitly)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (b7cbb5240130 Merge tag 'powerpc-5.2-6' into fi=
xes)
Merging s390-fixes/fixes (11aff183225c vfio-ccw: Destroy kmem cache region =
on module exit)
Merging sparc/master (15d5dfaf4adb sparc: fix unknown type name u_int in ua=
pi header)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (ccd1479e4839 Merge branch 'net-tls-fix-poll-wake-up')
Merging bpf/master (9d1bc24b52fb bonding: validate ip header before check I=
PPROTO_IGMP)
Merging ipsec/master (56c5ee1a5823 xfrm interface: fix memory leak on creat=
ion)
Merging netfilter/master (1c5ec78272e3 netfilter: nfnetlink: avoid deadlock=
 due to synchronous request_module)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (2a92b08b1855 mt76: usb: fix rx A-MSDU supp=
ort)
Merging mac80211/master (d2ce8d6bfcfe nl80211: Fix undefined behavior in bi=
t shift)
Merging rdma-fixes/for-rc (4b972a01a7da Linux 5.2-rc6)
Merging sound-current/for-linus (3450121997ce ALSA: line6: Fix write on zer=
o-sized buffer)
Merging sound-asoc-fixes/for-linus (0dceaf7c798d Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (ea09b3e21f18 Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (f0386617dca6 Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (2337ff45293f Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (6dbbd053e6ae PCI/P2PDMA: Ignore root complex=
 whitelist when an IOMMU is present)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (4b972a01a7da Linux 5.2-rc6)
Merging usb-gadget-fixes/fixes (42de8afc40c9 usb: dwc2: Use generic PHY wid=
th in params setup)
Merging usb-serial-fixes/usb-linus (f8377eff5481 USB: serial: ftdi_sio: add=
 ID for isodebug v1)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (4b972a01a7da Linux 5.2-rc6)
Merging char-misc.current/char-misc-linus (4b972a01a7da Linux 5.2-rc6)
Merging soundwire-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging thunderbolt-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging input-current/for-linus (f0dd687815f9 Input: atmel_mxt_ts - fix lea=
k in mxt_update_cfg())
Merging crypto-current/master (21d4120ec6f5 crypto: user - prevent operatin=
g on larval algorithms)
Merging ide/master (54dee406374c Merge tag 'arm64-fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/arm64/linux)
Merging vfio-fixes/for-linus (5715c4dd66a3 vfio/mdev: Synchronize device cr=
eate/remove with parent removal)
Merging kselftest-fixes/fixes (e2e88325f4bc selftests: vm: Fix test build f=
ailure when built by itself)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (f6034225442c dmaengine: qcom: bam_dma: Fix c=
ompleted descriptors count)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (c7a87ceb17ae mtd: rawnand: sunxi: Add A23/A33 =
DMA support with extra MBUS configuration)
Merging mfd-fixes/for-mfd-fixes (63b2de12b7ee mfd: stmfx: Fix an endian bug=
 in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (a71dcd3757e2 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (f2ff671f8941 MAINTAINERS: Correct path to mo=
ved files)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (fb59ee37cfe2 ARM: dts: am57xx: Disable voltage sw=
itching for SD card)
Merging kvm-fixes/master (e644fa18e2ff KVM: arm64/sve: Fix vq_present() mac=
ro to yield a bool)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (5696e4aaabf2 hwmon: (pwm-fan) Check return value=
 from devm_add_action_or_reset)
Merging nvdimm-fixes/libnvdimm-fixes (a4a357fd4477 Merge branch 'for-5.2/da=
x' into libnvdimm-fixes)
Merging btrfs-fixes/next-fixes (02252ea054b8 Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (75f2d86b20bf fs: VALIDATE_FS_PARSER should default=
 to n)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (6fbc7275c7a9 Linux 5.2-rc7)
Merging drivers-x86-fixes/fixes (9e0babf2c06c Linux 5.2-rc5)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (5dd6c4933912 scsi: iscsi: set auth_protocol back =
to NULL if CHAP_A value is not supported)
Merging drm-fixes/drm-fixes (a0b2cf792ac9 Merge tag 'imx-drm-fixes-2019-07-=
04' of git://git.pengutronix.de/git/pza/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (4b972a01a7da Linux 5.2-rc6)
Merging mmc-fixes/fixes (83293386bc95 mmc: core: Prevent processing SDIO IR=
Qs when the card is suspended)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (0db7f5cd4aeb riscv: mm: Fix code comment)
Merging drm-misc-fixes/for-linux-next-fixes (2f040d27080d drm/panfrost: Fix=
 a double-free error)
Merging kbuild/for-next (eb401e30035f Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (2ee7a4ef98e3 MIPS: only select ARCH_HAS_UNCAC=
HED_SEGMENT for non-coherent platforms)
CONFLICT (content): Merge conflict in include/linux/genalloc.h
CONFLICT (content): Merge conflict in include/linux/dma-iommu.h
CONFLICT (content): Merge conflict in drivers/iommu/dma-iommu.c
CONFLICT (content): Merge conflict in arch/arm64/mm/dma-mapping.c
Merging asm-generic/master (7f3a8dff1219 asm-generic: remove ptrace.h)
Merging arc/for-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging arm/for-next (17f21d9b3e70 Merge commit commit 'drm-armada-devel^{/=
drm/armada: no need to check parent of remote}' into for-next)
Merging arm64/for-next/core (0c61efd322b7 Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
CONFLICT (content): Merge conflict in mm/vmalloc.c
CONFLICT (content): Merge conflict in arch/arm64/kernel/module.c
CONFLICT (content): Merge conflict in arch/arm64/include/asm/thread_info.h
Merging arm-perf/for-next/perf (d482e575fbf0 perf: arm_spe: Enable ACPI/Pla=
tform automatic module loading)
Merging arm-soc/for-next (242af9ac5b32 ARM: Document merges)
CONFLICT (modify/delete): arch/arm/include/debug/netx.S deleted in arm-soc/=
for-next and modified in HEAD. Version HEAD of arch/arm/include/debug/netx.=
S left in tree.
CONFLICT (content): Merge conflict in arch/arm/configs/exynos_defconfig
$ git rm -f arch/arm/include/debug/netx.S
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (11343d25a03b Merge branch 'v5.3/fixes' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (a1f5c11ddb7d Merge branches 'dt-for-v5.3', 'defcon=
fig-for-v5.3' and 'soc-for-v5.3' into for-next)
Merging at91/at91-next (7eb505978425 Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (2a7f6c1a5376 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (78145dbeaea1 Merge branch 'for_5.3/driver-soc' into =
next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (e1b0b32a5ad6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (7376d6a65730 Merge branch 'fixes' into for-next)
Merging qcom/for-next (07c1ef894030 Merge tag 'qcom-dts-for-5.3-2' into ini=
tial-for-5.3)
Merging renesas/next (a16ecb14d0b0 Merge branches 'arm-dt-for-v5.3', 'arm-s=
oc-for-v5.3', 'arm-defconfig-for-v5.3', 'arm64-defconfig-for-v5.3', 'arm64-=
dt-for-v5.3' and 'dt-bindings-for-v5.3' into next)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (13622a50d8db Merge branch 'v5.3-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (cf6664323e0f Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging sunxi/sunxi/for-next (6c6b5d7650d9 Merge branch 'sunxi/dt64-for-5.3=
' into sunxi/for-next)
Merging tegra/for-next (033de83170dd Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (491933274860 Merge branch 'clk-lochnagar' into clk-ne=
xt)
CONFLICT (content): Merge conflict in drivers/clk/ingenic/Makefile
CONFLICT (content): Merge conflict in drivers/clk/bcm/Kconfig
CONFLICT (modify/delete): arch/mips/include/asm/mach-jz4740/clock.h deleted=
 in clk/clk-next and modified in HEAD. Version HEAD of arch/mips/include/as=
m/mach-jz4740/clock.h left in tree.
$ git rm -f arch/mips/include/asm/mach-jz4740/clock.h
Applying: clk: consoldiate the __clk_get_hw() declarations
Merging clk-samsung/for-next (7ef91224c486 clk: samsung: Add bus clock for =
GPU/G3D on Exynos4412)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (9f98b3142d22 csky: Improve string operations perfo=
rmance by glibc code)
Merging h8300/h8300-next (38ef0515e1e8 H8300: remove unused barrier defines)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (69878ef47562 m68k: Implement arch_dma_prep_coherent(=
))
Merging m68knommu/for-next (ad97f9df0fee riscv: add binfmt_flat support)
CONFLICT (content): Merge conflict in arch/m68k/Kconfig
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (c9093486f283 mips/kprobes: Export kprobe_fault_hand=
ler())
CONFLICT (content): Merge conflict in arch/mips/include/asm/mach-ralink/pin=
mux.h
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (f017da5c7077 nios2: configs: Remove useless UEVENT_=
HELPER_PATH)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (f4ed27e065b3 parisc: Ensure userspace privilege=
 for ptraced processes in regset functions)
Merging powerpc/next (a2b6f26c264e powerpc/module64: Use symbolic instructi=
ons names.)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (2ebca1cbb4a5 riscv: remove free_initrd_mem)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (499723d12063 docs: s390: s390dbf: typos and formatti=
ng, update crash command)
Merging sh/sh-next (d3023897b437 arch/sh: Check for kprobe trap number befo=
re trying to handle a kprobe trap)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (b482e48d29f1 um: fix build without CONFIG_UML_TIME_=
TRAVEL_SUPPORT)
Merging xtensa/xtensa-for-next (89f4357b0a55 Merge branch 'xtensa-5.3' into=
 xtensa-for-next)
Merging fscrypt/master (0564336329f0 fscrypt: document testing with xfstest=
s)
Merging afs/afs-next (fb2b827702ba afs: Fix loop index mixup in afs_deliver=
_vl_get_entry_by_name_u())
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (80dfdbfd37d2 Merge branch 'for-next-current-v=
5.2-20190705' into for-next-20190705)
Merging ceph/master (59cb2c2b2d01 ceph: don't NULL terminate virtual xattrs)
Merging cifs/for-next (4a487736783c cifs: refactor and clean up arguments i=
n the reparse point parsing)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (7451c54abc91 ecryptfs: Change return type of ecryptf=
s_process_flags)
Merging ext3/for_next (2d2043cbdb20 Pull XGETQSTAT fix from Eric Sandeen.)
Merging ext4/dev (96fcaf86c3cb ext4: fix coverity warning on error path of =
filename setup)
Merging f2fs/dev (d4811492eb30 f2fs: fix to avoid long latency during umoun=
t)
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (c433a7975cfc Merge tag 'nfs-rdma-for-5.3-1' of git:=
//git.linux-nfs.org/projects/anna/linux-nfs)
Merging nfs-anna/linux-next (68f461593f76 NFS/flexfiles: Use the correct TC=
P timeout for flexfiles I/O)
Merging nfsd/nfsd-next (791234448d47 nfsd: decode implementation id)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (6dde1e42f497 ovl: make i_ino consistent w=
ith st_ino in more cases)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (036f463fe15d xfs: online scrub needn't bother zeroing=
 its temporary buffer)
Merging iomap/iomap-for-next (36a7347de097 iomap: fix page_done callback fo=
r short writes)
Merging djw-vfs/vfs-for-next (7e328e5930ad mm/fs: don't allow writes to imm=
utable files)
Merging file-locks/locks-next (6ef048fd5955 locks: eliminate false positive=
 conflicts for write lease)
Merging vfs/for-next (966673013617 Merge branch 'work.adfs' into for-next)
CONFLICT (content): Merge conflict in fs/nfsd/nfsctl.c
Merging printk/for-next (f0cc370ab74d Merge branch 'for-5.3' into for-next)
Merging pci/next (2f6473d83031 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (0ac3735fce80 pstore: Fix double-free in pst=
ore_mkfile() failure path)
Merging hid/for-next (bf4945efabdf Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (9a74c745c689 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
Merging i3c/i3c/next (ede2001569c3 i3c: master: Use struct_size() helper)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (8383a5ee88fd hwmon: gpio-fan: fix sysfs n=
otifications and udev events for gpio-fan alarms)
Merging jc_docs/docs-next (acb6258acc4f doc: RCU callback locks need only _=
bh, not necessarily _irq)
CONFLICT (modify/delete): Documentation/filesystems/vfs.txt deleted in jc_d=
ocs/docs-next and modified in HEAD. Version HEAD of Documentation/filesyste=
ms/vfs.txt left in tree.
CONFLICT (content): Merge conflict in Documentation/fb/fbcon.rst
$ git rm -f Documentation/filesystems/vfs.txt
Applying: docs: filesystems: vfs: update for "vfs: Kill mount_single()"
Merging v4l-dvb/master (f81cbfc4f82a media: allegro: use new v4l2_m2m_ioctl=
_try_encoder_cmd funcs)
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-vmal=
loc.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-dma-=
sg.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-dma-=
contig.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-core=
.c
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (732146a3f1dc video: fbdev: imxfb: fix a typo =
in imxfb_probe())
CONFLICT (modify/delete): drivers/video/fbdev/omap2/omapfb/dss/rfbi.c delet=
ed in fbdev/fbdev-for-next and modified in HEAD. Version HEAD of drivers/vi=
deo/fbdev/omap2/omapfb/dss/rfbi.c left in tree.
CONFLICT (content): Merge conflict in drivers/media/pci/ivtv/ivtvfb.c
$ git rm -f drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
Merging pm/linux-next (4608e922009e Merge branch 'pm-cpufreq-new' into linu=
x-next)
CONFLICT (content): Merge conflict in Documentation/power/pm_qos_interface.=
rst
Merging cpufreq-arm/cpufreq/arm/linux-next (f9020441dbc3 cpufreq: s5pv210: =
Don't flood kernel log after cpufreq change)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (560d1bcad715 opp: Don't use IS_ERR on invalid s=
upplies)
Merging thermal/next (ff9b011ad143 Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (4cb9f043447e thermal: thermal_mmio: remove some d=
ead code)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (6051531997ed dlm: no need to check return value of debugf=
s_create functions)
Merging swiotlb/linux-next (dd853b2dfa65 Merge branch 'stable/for-linus-5.2=
' into linux-next)
Merging rdma/for-next (bcde9a83b13e RDMA/efa: Entropy in admin commands id)
$ git reset --hard HEAD^
Merging next-20190628 version of rdma
CONFLICT (content): Merge conflict in include/rdma/ib_verbs.h
CONFLICT (content): Merge conflict in include/linux/mlx5/eswitch.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/cmd.c
CONFLICT (modify/delete): drivers/infiniband/hw/nes/Makefile deleted in 779=
6d2a3bb4037f9c51b8d91d059f1d690ed301f and modified in HEAD. Version HEAD of=
 drivers/infiniband/hw/nes/Makefile left in tree.
CONFLICT (modify/delete): drivers/infiniband/hw/nes/Kconfig deleted in 7796=
d2a3bb4037f9c51b8d91d059f1d690ed301f and modified in HEAD. Version HEAD of =
drivers/infiniband/hw/nes/Kconfig left in tree.
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_std_ty=
pes_cq.c
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
$ git rm -f drivers/infiniband/hw/nes/Kconfig drivers/infiniband/hw/nes/Mak=
efile
[master afcfd7b1c8ce] next-20190628/rdma
Merging net-next/master (ad7b134f6538 Merge branch 'net-dsa-Add-Vitesse-VSC=
73xx-parallel-mode')
CONFLICT (content): Merge conflict in tools/testing/selftests/net/config
CONFLICT (content): Merge conflict in net/ipv4/devinet.c
CONFLICT (content): Merge conflict in include/linux/mlx5/eswitch.h
CONFLICT (modify/delete): drivers/infiniband/hw/nes/nes.c deleted in HEAD a=
nd modified in net-next/master. Version net-next/master of drivers/infiniba=
nd/hw/nes/nes.c left in tree.
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/cq.c
CONFLICT (content): Merge conflict in arch/sh/configs/titan_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7721_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7712_defconfig
$ git rm -f drivers/infiniband/hw/nes/nes.c
Merging bpf-next/master (c3ec002e633e selftests/bpf: add test_tcp_rtt to .g=
itignore)
Merging ipsec-next/master (c7b37c769d2a xfrm: remove get_mtu indirection fr=
om xfrm_type)
Merging mlx5-next/mlx5-next (1dd7382b1bb6 net/mlx5: Introduce VHCA tunnel d=
evice capability)
Merging netfilter-next/master (2a3a93ef0ba5 netfilter: nft_meta_bridge: Add=
 NFT_META_BRI_IIFVPROTO support)
Applying: don't test build another netfilter header
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (5adcdab6ae1b Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (9ce67c3235be Bluetooth: btusb: Add protocol suppo=
rt for MediaTek MT7663U USB devices)
Merging mac80211-next/master (17c74d7c5f0d nl80211: fix VENDOR_CMD_RAW_DATA)
Merging gfs2/for-next (f29e62eed261 gfs2: replace more printk with calls to=
 fs_info and friends)
CONFLICT (content): Merge conflict in fs/gfs2/super.c
Merging mtd/mtd/next (46ce10df799f Merge tag 'spi-nor/for-5.3-v2' of gitoli=
te.kernel.org:pub/scm/linux/kernel/git/mtd/linux into mtd/next)
CONFLICT (content): Merge conflict in include/linux/platform_data/intel-spi=
.h
CONFLICT (modify/delete): drivers/mtd/spi-nor/stm32-quadspi.c deleted in mt=
d/mtd/next and modified in HEAD. Version HEAD of drivers/mtd/spi-nor/stm32-=
quadspi.c left in tree.
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.h
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-platfor=
m.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-pci.c
CONFLICT (content): Merge conflict in drivers/mtd/nand/raw/mtk_ecc.h
$ git rm -f drivers/mtd/spi-nor/stm32-quadspi.c
Merging nand/nand/next (bce9437a0a48 mtd: rawnand: stm32_fmc2: increase DMA=
 completion timeouts)
Merging spi-nor/spi-nor/next (8d1336c241bd mtd: spi-nor: cadence-quadspi: a=
dd reset control)
Merging crypto/master (f3880a23564e crypto: stm32/hash - remove interruptib=
le condition for dma)
CONFLICT (content): Merge conflict in drivers/crypto/vmx/vmx.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_xts.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_ctr.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_cbc.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes.c
CONFLICT (content): Merge conflict in drivers/crypto/talitos.c
CONFLICT (content): Merge conflict in drivers/crypto/stm32/Makefile
CONFLICT (content): Merge conflict in drivers/crypto/ccp/sp-platform.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/sp-pci.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/sp-dev.h
CONFLICT (content): Merge conflict in drivers/crypto/ccp/sp-dev.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/psp-dev.h
CONFLICT (content): Merge conflict in drivers/crypto/ccp/psp-dev.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-ops.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-dmaengine.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-dev.h
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-dev.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-dev-v5.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-dev-v3.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-debugfs.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto.h
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-sha.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-rsa.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-main.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-des3.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-aes.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-aes-xts=
.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-aes-gal=
ois.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-aes-cma=
c.c
CONFLICT (modify/delete): crypto/crypto_wq.c deleted in crypto/master and m=
odified in HEAD. Version HEAD of crypto/crypto_wq.c left in tree.
$ git rm -f crypto/crypto_wq.c
Merging drm/drm-next (4cf643a39221 Merge tag 'drm-next-5.3-2019-06-27' of g=
it://people.freedesktop.org/~agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in include/uapi/linux/magic.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Makefile.header-=
test
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
CONFLICT (content): Merge conflict in Documentation/fb/modedb.rst
Applying: dma-buf: convert to new mount api
Merging amdgpu/drm-next (55d6158bd0e9 drm/amdgpu: properly guard DC support=
 in navi code)
Merging drm-intel/for-linux-next (15e7facb7b42 drm/i915: Pull assert_forcew=
ake_active() underneath the lock)
Merging drm-tegra/drm/tegra/for-next (eb7cf945a8da host1x: debugfs_create_d=
ir() can never return NULL)
Merging drm-misc/for-linux-next (e5704b3fe9d5 drm: connector: remove bogus =
NULL check)
Merging drm-msm/msm-next (648fdc3f6475 drm/msm: add dirty framebuffer helpe=
r)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (8f2501e643bc drm/komeda: Enable write=
back split support)
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/ko=
meda_framebuffer.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/ko=
meda_crtc.c
Merging imx-drm/imx-drm/next (fee77829083a gpu: ipu-v3: image-convert: Enab=
le double write reduction)
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-ic-prpe=
ncvf.c
Merging etnaviv/etnaviv/next (57bdd4057516 drm/etnaviv: Use devm_platform_i=
oremap_resource())
Merging regmap/for-next (aaccf3863ce2 Merge branch 'regmap-5.3' into regmap=
-next)
Merging sound/for-next (b89b889a326a Merge branch 'topic/hda-refresh-cleanu=
p' into for-next)
CONFLICT (content): Merge conflict in sound/pci/rme9652/hdspm.c
Merging sound-asoc/for-next (a98429acadef Merge remote-tracking branch 'aso=
c/topic/meson' into asoc-next)
Merging modules/modules-next (93651f80dcb6 modules: fix compile error if do=
n't have strict module rwx)
Merging input/next (593fdd4fb44e Input: gpio_keys_polled - allow specifying=
 name of input device)
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (6a42ac2da18f Merge branch 'for-5.3/block' into for-=
next)
CONFLICT (content): Merge conflict in fs/xfs/xfs_aops.c
CONFLICT (modify/delete): Documentation/fault-injection/nvme-fault-injectio=
n.txt deleted in HEAD and modified in block/for-next. Version block/for-nex=
t of Documentation/fault-injection/nvme-fault-injection.txt left in tree.
$ git rm -f Documentation/fault-injection/nvme-fault-injection.txt
Applying: Documentation: nvme: fix for change to rst
Merging device-mapper/for-next (a8a9f1434a86 dm snapshot: add optional disc=
ard support features)
CONFLICT (content): Merge conflict in Documentation/device-mapper/snapshot.=
rst
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (4f8c162a9570 mmc: sdhci-pci: Add support for Intel EHL)
CONFLICT (content): Merge conflict in drivers/mmc/host/meson-gx-mmc.c
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (7efd105c27fd mfd: hi655x-pmic: Fix missing return=
 value check for devm_regmap_init_mmio_clk)
CONFLICT (content): Merge conflict in include/linux/mfd/cros_ec_commands.h
Merging backlight/for-backlight-next (73fbfc499448 backlight: pwm_bl: Fix h=
euristic to determine number of brightness levels)
CONFLICT (content): Merge conflict in drivers/video/backlight/pwm_bl.c
Merging battery/for-next (3f57fe28f84d power_supply: wilco_ec: Add charging=
 config driver)
CONFLICT (content): Merge conflict in drivers/power/supply/Makefile
CONFLICT (content): Merge conflict in drivers/power/supply/Kconfig
CONFLICT (modify/delete): Documentation/power/power_supply_class.txt delete=
d in HEAD and modified in battery/for-next. Version battery/for-next of Doc=
umentation/power/power_supply_class.txt left in tree.
$ git rm -f Documentation/power/power_supply_class.txt
Applying: power: supply: update for conversion to .rst
Merging regulator/for-next (0ed4513c9a32 Merge remote-tracking branch 'regu=
lator/topic/coupled' into regulator-next)
Merging security/next-testing (286e47a07799 Merge branch 'next-lsm' into ne=
xt-testing)
Merging apparmor/apparmor-next (136db994852a apparmor: increase left match =
history buffer size)
Merging integrity/next-integrity (650b29dbdf2c integrity: Introduce struct =
evm_xattr)
Merging keys/keys-next (20adf5593389 Merge tag 'keys-acl-20190703' into key=
s-next)
CONFLICT (content): Merge conflict in security/integrity/digsig.c
CONFLICT (content): Merge conflict in fs/ecryptfs/keystore.c
Merging selinux/next (ea74a685ad81 selinux: format all invalid context as u=
ntrusted)
Merging tpmdd/next (166a2809d65b tpm: Don't duplicate events from the final=
 event log in the TCG2 log)
Merging watchdog/master (46713c3d2f8d Merge tag 'for-linus-20190706' of git=
://git.kernel.dk/linux-block)
Merging iommu/next (d95c3885865b Merge branches 'x86/vt-d', 'x86/amd', 'arm=
/smmu', 'arm/omap', 'generic-dma-ops' and 'core' into next)
CONFLICT (content): Merge conflict in drivers/iommu/dma-iommu.c
CONFLICT (content): Merge conflict in arch/arm64/mm/dma-mapping.c
Merging vfio/next (b46c820f8f5a sample/mdev/mbochs: remove set but not used=
 variable 'mdev_state')
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (5ff88144f588 dt-bindings: usb: ehci: Fix examp=
le warnings)
CONFLICT (content): Merge conflict in scripts/dtc/libfdt/Makefile.libfdt
CONFLICT (content): Merge conflict in scripts/dtc/Makefile.dtc
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/net=
/ethernet.txt
Merging mailbox/mailbox-for-next (35110e38e6c5 Merge tag 'media/v5.2-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging spi/for-next (26ac56506b0e Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (ba1a1e6257c2 Merge branch 'core/debugobjects')
CONFLICT (content): Merge conflict in drivers/hwmon/coretemp.c
Applying: p54: fix up for ktime_get_boot_ns() name change
Merging clockevents/clockevents/next (b0c74b96d177 clocksource/drivers/davi=
nci: Add support for clocksource)
Merging edac-amd/for-next (b2572772d13e EDAC: Make edac_debugfs_create_x*()=
 return void)
CONFLICT (content): Merge conflict in arch/riscv/Kconfig
Merging irqchip/irq/irqchip-next (3dae67ce600c irqchip/gic-pm: Remove PM_CL=
K dependency)
Merging ftrace/for-next (a124692b698b ftrace: Enable trampoline when rec co=
unt returns back to one)
Merging rcu/rcu/next (b989ff070574 Merge LKMM and RCU commits)
Merging kvm/linux-next (9824c83f92bc Documentation: kvm: document CPUID bit=
 for MSR_KVM_POLL_CONTROL)
Merging kvm-arm/next (fbe48cf55971 KVM: arm/arm64: Initialise host's MPIDRs=
 by reading the actual register)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpufeature.h
CONFLICT (content): Merge conflict in Documentation/arm64/silicon-errata.rst
Merging kvm-ppc/kvm-ppc-next (3bda7f0ae0f7 KVM: PPC: Book3S PR: Fix softwar=
e breakpoints)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
Merging xen-tip/linux-next (8b13dee43393 xen/events: fix binding user event=
 channels to cpus)
Merging percpu/for-next (e0afe6d4d12c Merge branch 'for-5.4' into for-next)
Merging workqueues/for-next (be69d00d9769 workqueue: Remove GPF argument fr=
om alloc_workqueue_attrs())
Merging drivers-x86/for-next (8e8fe446a91c platform/x86: asus-wmi: Use dev_=
get_drvdata())
Merging chrome-platform/for-next (8c3166e17cf1 mfd / platform: cros_ec_debu=
gfs: Expose resume result via debugfs)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (2605085fba22 dt: leds-lm36274.txt: fix a broken refe=
rence to ti-lmu.txt)
Merging ipmi/for-next (ac499fba98c3 docs: ipmb: place it at driver-api and =
convert to ReST)
Merging driver-core/driver-core-next (0979cf95d201 orangefs: fix build warn=
ing from debugfs cleanup patch)
CONFLICT (content): Merge conflict in net/sunrpc/debugfs.c
CONFLICT (content): Merge conflict in fs/ceph/super.c
CONFLICT (content): Merge conflict in drivers/acpi/sleep.c
Merging usb/usb-next (2bc8bb813cba Merge tag 'usb-ci-v5.3-rc1' of git://git=
.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next)
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging usb-gadget/next (b2357839c56a usb: renesas_usbhs: add a workaround =
for a race condition of workqueue)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (520602640419 phy: qcom-qmp: Raise qcom_qmp_phy_enabl=
e() polling delay)
Merging tty/tty-next (35a4ed0164e9 tty: serial: fsl_lpuart: add imx8qxp sup=
port)
Merging char-misc/char-misc-next (2f4281f4dce1 Merge tag 'soundwire-5.3-rc1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into cha=
r-misc-next)
CONFLICT (content): Merge conflict in drivers/misc/vmw_balloon.c
CONFLICT (content): Merge conflict in drivers/misc/mei/debugfs.c
CONFLICT (modify/delete): drivers/hwtracing/coresight/of_coresight.c delete=
d in char-misc/char-misc-next and modified in HEAD. Version HEAD of drivers=
/hwtracing/coresight/of_coresight.c left in tree.
$ git rm -f drivers/hwtracing/coresight/of_coresight.c
Applying: coresight: fix for "bus_find_device: Unify the match callback wit=
h class_find_device"
Applying: coresight: Make the coresight_device_fwnode_match declaration's f=
wnode parameter const
Applying: convert vmwballoon to use the new mount API
Merging extcon/extcon-next (0937fbb7abeb extcon: fsa9480: Fix Kconfig warni=
ng and build errors)
Merging soundwire/next (2aeac95d1a4c soundwire: add module_sdw_driver helpe=
r macro)
Merging thunderbolt/next (6fbc7275c7a9 Linux 5.2-rc7)
Merging staging/staging-next (5d1532482943 staging: kpc2000: simplify compa=
rison to NULL in fileops.c)
Merging mux/for-next (05fb8284a417 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (5c274ca4cfb2 dmaengine: Revert "dmaengine: fsl-edma=
: add i.mx7ulp edma2 version support")
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
Merging scsi/for-next (8fdf518974b5 Merge branch 'fixes' into for-next)
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
Merging scsi-mkp/for-next (893ca250edfc Merge branch '5.3/scsi-sg' into scs=
i-next)
Merging vhost/linux-next (169a126c6e88 iommu/virtio: Add event queue)
Applying: iommu/virtio: Constify data parameter in viommu_match_node
Merging rpmsg/for-next (9b20f211a525 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (9b3b623804a6 Revert "gpio: tegra: Clean-up debugfs i=
nitialisation")
CONFLICT (content): Merge conflict in drivers/gpio/Makefile
Merging gpio-brgl/gpio/for-next (f360dcd4ef7f gpio: mockup: no need to chec=
k return value of debugfs_create functions)
Merging pinctrl/for-next (bc87d22918b0 Merge branch 'devel' into for-next)
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
Merging pwm/for-next (3d25025ce9c2 pwm: fsl-ftm: Make sure to unlock mutex =
on failure)
Merging userns/for-next (318759b4737c signal/x86: Move tsk inside of CONFIG=
_MEMORY_FAILURE in do_sigbus)
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arc/mm/fault.c
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (f4fb8a97dc90 kselftests: cgroup: remove duplicated =
include from test_freezer.c)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (28f28ea4343a Merge branch 'for-5.3-core' int=
o for-next)
Merging coresight/next (60e8523e2ea1 ocxl: Allow contexts to be attached wi=
th a NULL mm)
Merging rtc/rtc-next (3572e8aea3bf rtc: pcf8563: Clear event flags and disa=
ble interrupts before requesting irq)
Merging nvdimm/libnvdimm-for-next (7c40cc44161a Merge branch 'for-5.3/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in include/uapi/linux/virtio_ids.h
Merging at24/at24/for-next (dce91ba39c76 eeprom: at24: modify a comment ref=
erring to platform data)
Merging ntb/ntb-next (d9c53aa440b3 NTB: Describe the ntb_msi_test client in=
 the documentation.)
Merging kspp/for-next/kspp (2dcbe7fe2265 lib/test_stackinit: Handle Clang a=
uto-initialization pattern)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging fsi/master (6fbc7275c7a9 Linux 5.2-rc7)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (341f8ae0f820 dt-bindings: nvmem: SID: Fix the examp=
les node names)
CONFLICT (content): Merge conflict in drivers/nvmem/meson-mx-efuse.c
CONFLICT (content): Merge conflict in drivers/nvmem/meson-efuse.c
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/nvm=
em/allwinner,sun4i-a10-sid.yaml
Merging xarray/xarray (91abab83839a XArray: Fix xas_next() with a single en=
try at 0)
Merging hyperv/hyperv-next (674eecb3d35a drivers: hv: Add a module descript=
ion line to the hv_vmbus driver)
Merging auxdisplay/auxdisplay (f4bb1f895aa0 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (4382fc438ca5 Merge branch 'clone' into for-next)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/pidfd_t=
est.c
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
CONFLICT (content): Merge conflict in kernel/fork.c
Merging devfreq/for-next (f6274181714d PM / devfreq: events: add Exynos PPM=
U new events)
Merging hmm/hmm (cc5dfd59e375 Merge branch 'hmm-devmem-cleanup.4' into rdma=
.git hmm)
CONFLICT (content): Merge conflict in include/linux/ioport.h
Applying: mm/hmm: fixup for "locking/lockdep: Rename lockdep_assert_held_ex=
clusive() -> lockdep_assert_held_write()"
Applying: drm/amdgpu: adopt to hmm_range_register API change
Applying: merge fix for conflict between the s390 and driver-core tree
Merging akpm-current/current (730dc4ad74ff include/linux/lz4.h: fix spellin=
g and copy-paste errors in documentation)
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in mm/Kconfig
CONFLICT (content): Merge conflict in lib/Makefile
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in kernel/dma/remap.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (content): Merge conflict in fs/binfmt_flat.c
CONFLICT (content): Merge conflict in arch/x86/Kconfig
CONFLICT (content): Merge conflict in arch/powerpc/mm/book3s64/radix_pgtabl=
e.c
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/pgtable.h
Applying: merge fixup for "mm: Add an apply_to_pfn_range interface"
Applying: another fixup for "mm: Add an apply_to_pfn_range interface"
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: device-dax: fix memory and resource leak if hotplug fails
Applying: mm/hotplug: make remove_memory() interface usable
Applying: device-dax: "Hotremove" persistent memory that is used like norma=
l RAM
Applying: mm: move MAP_SYNC to asm-generic/mman-common.h
Applying: mm/mmap: move common defines to mman-common.h
Applying: mm: section numbers use the type "unsigned long"
Applying: mm-section-numbers-use-the-type-unsigned-long-fix
Applying: mm-section-numbers-use-the-type-unsigned-long-v3
Applying: drivers/base/memory: Use "unsigned long" for block ids
Applying: mm: make register_mem_sect_under_node() static
Applying: mm/memory_hotplug: rename walk_memory_range() and pass start+size=
 instead of pfns
Applying: mm/memory_hotplug: move and simplify walk_memory_blocks()
Applying: drivers/base/memory.c: Get rid of find_memory_block_hinted()
Applying: drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3
Applying: drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3-fix
Applying: mm: clean up is_device_*_page() definitions
Applying: mm: introduce ARCH_HAS_PTE_DEVMAP
Applying: arm64: mm: implement pte_devmap support
Applying: arm64-mm-implement-pte_devmap-support-fix
Applying: mm/sparsemem: introduce struct mem_section_usage
Applying: mm/sparsemem: introduce a SECTION_IS_EARLY flag
Applying: mm/sparsemem: add helpers track active portions of a section at b=
oot
Applying: mm/hotplug: prepare shrink_{zone, pgdat}_span for sub-section rem=
oval
Applying: mm/sparsemem: convert kmalloc_section_memmap() to populate_sectio=
n_memmap()
Applying: mm/hotplug: kill is_dev_zone() usage in __remove_pages()
Applying: mm: kill is_dev_zone() helper
Applying: mm/sparsemem: prepare for sub-section ranges
Applying: mm/sparsemem: support sub-section hotplug
Applying: mm: document ZONE_DEVICE memory-model implications
Applying: docs/vm: update ZONE_DEVICE memory model documentation
Applying: mm/devm_memremap_pages: enable sub-section remap
Applying: libnvdimm/pfn: fix fsdax-mode namespace info-block zero-fields
Applying: libnvdimm/pfn: stop padding pmem namespaces to section alignment
Applying: mm/sparsemem: cleanup 'section number' data types
Applying: mm-sparsemem-cleanup-section-number-data-types-fix
Applying: mm: add account_locked_vm utility function
Applying: mm-add-account_locked_vm-utility-function-v3
Applying: mm-add-account_locked_vm-utility-function-v3-fix
Applying: proc/sysctl: add shared variables for range check
Applying: tipc: remove two unused variables
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-2-fix
Applying: proc/sysctl: make firmware loader table conditional
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-4
Applying: drivers/tty/serial/sh-sci.c: suppress warning
Applying: fs/select.c: use struct_size() in kmalloc()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (2c255e0df977 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/hHWpiKlbUjC7WZS2GJqvGUX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jOj4ACgkQAVBC80lX
0GwbSAf/c1vL+wHhtTzKk9eS2gYEznFcd/WV2kS9I83aepyE76kbQmuw/064bb2d
/mwXp0FZt9Ng163c/X7XaTh2E8/1hwAb2BnqN2RUt7uOVWa758Zw1NWkoaeXSLQ9
cvHl4r6nfnsrH853oxOpTRo7ONnKHnjT/UcPP2xKpjl9J+z9SyK1btT0IScf0Ms1
jNpMt1X+Djq5oh6+nXIHsnCfp4RCqpZbRbM+g0ezHpsIsOjpc1P673+6YXfX9nDz
qpWosOi4yJyW4CzmewRoEyjuL8TX37vDoyg+fD3jb5wsI5I4bHHDyyo13v/mJiys
IT+gzbc5e0hytLh9wy0lLoF/+DeGVQ==
=1E1w
-----END PGP SIGNATURE-----

--Sig_/hHWpiKlbUjC7WZS2GJqvGUX--
