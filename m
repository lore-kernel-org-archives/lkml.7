Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933F1C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B261214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JEn2Nqo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfHAGOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:14:44 -0400
Received: from ozlabs.org ([203.11.71.1]:51231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHAGOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:14:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zg4F1tN3z9sNy;
        Thu,  1 Aug 2019 16:14:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564640077;
        bh=swKq7cQL8Mup7hCqiZsqgX8aDFQASjPgWgLDh3n9etE=;
        h=Date:From:To:Cc:Subject:From;
        b=JEn2Nqo6n2hLtf2Ar7FYVkHTLXYoypV2giVSY5pKYR853PBYEkTy7r4+2jBE2nPU2
         h9teEBGZti+d/Tjmge36/Hi2fe4HwB2TvX4tbzYF0c03B5B+e2AhcHpAgtCOdVEe6r
         VyDJ0qhlhlMLagW/Z1UwuQzpnttiqb63vOuNy5hvr5FnXAfwVeGLTOGuduJ6khCVM5
         IwKweC87Hx1e9iG3hdOL4wl3xs0E+XvEL/Fc4mOB/oTSMlQSlYIdJrPF2VR1ebqUbC
         yB4mIMIqej1ecgGD1snO8+o714gY8uv1oes3E15IBB271FhlnJSJecKph/BW87Bnh+
         CWkKDEGUluAdA==
Date:   Thu, 1 Aug 2019 16:14:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 1
Message-ID: <20190801161436.5ccc0bea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k.0nWG0D7p0I199R/ynx1V/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k.0nWG0D7p0I199R/ynx1V/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190731:

New trees: pidfd-fixes, renesas-geert

My fixes tree contains:

  15b9fc624ba4 ("drivers/macintosh/smu.c: Mark expected switch fall-through=
")

The pm tree lost its build failure.

The drm-misc tree gained a build failure so I used the version from
next-20190731.

The sound-asoc tree gained a conflict against the sound tree.

The tip tree gained a build failure for which I applied a patch.

Non-merge commits (relative to Linus' tree): 3508
 4105 files changed, 218561 insertions(+), 98912 deletions(-)

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

I am currently merging 304 trees (counting Linus' and 74 trees of bug
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
Merging origin/master (5c6207539aea Merge branch 'fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/viro/vfs)
Merging fixes/master (15b9fc624ba4 drivers/macintosh/smu.c: Mark expected s=
witch fall-through)
Merging kbuild-current/fixes (e8de12fb7cde kbuild: Check for unknown option=
s with cc-option usage in Kconfig and clang)
Merging arc-current/for-curr (24a20b0a443f ARC: [plat-hsdk]: Enable AXI DW =
DMAC in defconfig)
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm-soc-fixes/arm/fixes (7bd9d465140a Merge tag 'imx-fixes-5.3' of =
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes)
Merging arm64-fixes/for-next/fixes (97d5db366224 arm64: Lower priority mask=
 for GIC_PRIO_IRQON)
Merging m68k-current/for-linus (f28a1f16135c m68k: Don't select ARCH_HAS_DM=
A_PREP_COHERENT for nommu or coldfire)
Merging powerpc-fixes/fixes (da1115fdbd6e powerpc/nvdimm: Pick nearby onlin=
e node if the device node is not online)
Merging s390-fixes/fixes (8480657280ee vfio-ccw: make vfio_ccw_async_region=
_ops static)
Merging sparc/master (038029c03e21 sparc: remove unneeded uapi/asm/statfs.h)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (d8a1de3d5bb8 isdn: hfcsusb: Fix mISDN driver crash caus=
ed by transfer buffer on the stack)
Merging bpf/master (5d01ab7bac46 libbpf: fix erroneous multi-closing of BTF=
 FD)
Merging ipsec/master (22d6552f827e xfrm interface: fix management of phydev)
Merging netfilter/master (7cdc44122847 Merge branch 'master' of git://black=
hole.kfki.hu/nf)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (66f5772ee29d Merge tag 'iwlwifi-fixes-for-=
kvalo-2019-07-30' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/=
iwlwifi-fixes)
Merging mac80211/master (d8a1de3d5bb8 isdn: hfcsusb: Fix mISDN driver crash=
 caused by transfer buffer on the stack)
Merging rdma-fixes/for-rc (708637e65abd Do not dereference 'siw_crypto_shas=
h' before checking)
Merging sound-current/for-linus (5d78e1c2b7f4 ALSA: usb-audio: Fix gpf in s=
nd_usb_pipe_sanity_check)
Merging sound-asoc-fixes/for-linus (f9eeb39b6ad2 Merge branch 'asoc-5.3' in=
to asoc-linus)
Merging regmap-fixes/for-linus (5f9e832c1370 Linus 5.3-rc1)
Merging regulator-fixes/for-linus (3630a287d13c Merge branch 'regulator-5.3=
' into regulator-linus)
Merging spi-fixes/for-linus (d24f33303ad1 Merge branch 'spi-5.3' into spi-l=
inus)
Merging pci-current/for-linus (5f9e832c1370 Linus 5.3-rc1)
Merging driver-core.current/driver-core-linus (ac43432cb1f5 driver core: Fi=
x use-after-free and double free on glue directory)
Merging tty.current/tty-linus (81eaadcae81b kgdboc: disable the console loc=
k when in kgdb)
Merging usb.current/usb-linus (12ca7297b885 usb: typec: tcpm: remove tcpm d=
ir if no children)
Merging usb-gadget-fixes/fixes (42de8afc40c9 usb: dwc2: Use generic PHY wid=
th in params setup)
Merging usb-serial-fixes/usb-linus (f8377eff5481 USB: serial: ftdi_sio: add=
 ID for isodebug v1)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (609488bc979f Linux 5.3-rc2)
Merging staging.current/staging-linus (09f6109ff4f8 Merge tag 'iio-fixes-fo=
r-5.3a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into sta=
ging-linus)
Merging char-misc.current/char-misc-linus (1dd38ae96973 MAINTAINERS: Move l=
inux-fpga tree to new location)
Merging soundwire-fixes/fixes (5f9e832c1370 Linus 5.3-rc1)
Merging thunderbolt-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging input-current/for-linus (e77ff779a0c6 Input: applespi - add depende=
ncy on LEDS_CLASS)
Merging crypto-current/master (cf144f81a99d padata: use smp_mb in padata_re=
order to avoid orphaned padata jobs)
Merging ide/master (baf6722aa0cb ide: Use dev_get_drvdata where possible)
Merging vfio-fixes/for-linus (5715c4dd66a3 vfio/mdev: Synchronize device cr=
eate/remove with parent removal)
Merging kselftest-fixes/fixes (fbb01c52471c selftests/livepatch: push and p=
op dynamic debug config)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (d105ef8120dd dmaengine: tegra210-adma: Fix u=
nused function warnings)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (5f9e832c1370 Linus 5.3-rc1)
Merging mfd-fixes/for-mfd-fixes (63b2de12b7ee mfd: stmfx: Fix an endian bug=
 in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (92f5b0313e37 media: vivid: fix missing cec ada=
pter name)
Merging reset-fixes/reset/fixes (a71dcd3757e2 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (2d291e6cc183 MIPS: OProfile: Mark expected s=
witch fall-throughs)
Merging at91-fixes/at91-fixes (5f9e832c1370 Linus 5.3-rc1)
Merging omap-fixes/fixes (fb59ee37cfe2 ARM: dts: am57xx: Disable voltage sw=
itching for SD card)
Merging kvm-fixes/master (30cd8604323d KVM: x86: Add fixed counters to PMU =
filter)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (4c3c79f79e5c hwmon: (nct7802) Fix wrong detectio=
n of in4 presence)
Merging nvdimm-fixes/libnvdimm-fixes (61c30c98ef17 dax: Fix missed wakeup i=
n put_unlocked_entry())
Merging btrfs-fixes/next-fixes (042693442aa6 Merge branch 'misc-5.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (c2c44ec20a84 Unbreak mount_capable())
Merging dma-mapping-fixes/for-linus (f46cc0152501 dma-contiguous: page-alig=
n the size in dma_free_contiguous())
Merging i3c-fixes/master (6fbc7275c7a9 Linux 5.2-rc7)
Merging drivers-x86-fixes/fixes (f14312a93b34 platform/x86: pcengines-apuv2=
: use KEY_RESTART for front button)
Merging samsung-krzk-fixes/fixes (5f9e832c1370 Linus 5.3-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5f9e832c1370 Linus 5.3-rc1)
Merging devicetree-fixes/dt/linus (740ce365a4dc dt-bindings: Fix generated =
example files getting added to schemas)
Merging scsi-fixes/fixes (e82f04ec6ba9 scsi: qla2xxx: Fix possible fcport n=
ull-pointer dereferences)
Merging drm-fixes/drm-fixes (4d5308e78527 Merge tag 'drm-fixes-5.3-2019-07-=
24' of git://people.freedesktop.org/~agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (ee6fa8584656 drm/amd/amdgpu/vcn_v2_0: Move =
VCN 2.0 specific dec ring test to vcn_v2_0)
Merging drm-intel-fixes/for-linux-next-fixes (cf4a459031f2 Merge tag 'gvt-f=
ixes-2019-07-30' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (3a6ffb3c8c32 mmc: mmc_spi: Enable stable writes)
Merging rtc-fixes/rtc-fixes (5f9e832c1370 Linus 5.3-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (5d14de4c6ce5 hv: Use the correct style f=
or SPDX License Identifier)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (30d9a7b74aa0 riscv: kbuild: add virtual memory =
system selection)
Merging pidfd-fixes/fixes (97112e283da5 exit: make setting exit_state consi=
stent)
Merging fpga-fixes/fixes (7721f61d2e76 fpga: altera-ps-spi: Fix getting of =
optional confd gpio)
Merging drm-misc-fixes/for-linux-next-fixes (7e9e5ead55be drm/vgem: fix cac=
he synchronization on arm/arm64)
Merging kspp-gustavo/for-next/kspp (50235e41ab35 watchdog: riowd: Mark expe=
cted switch fall-through)
Merging kbuild/for-next (cc6ff7162ef4 Kbuild: Handle PREEMPT_RT for version=
 string and magic)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (ad3c7b18c5b3 arm: use swiotlb for bounce buff=
ering on LPAE configs)
Merging asm-generic/master (7f3a8dff1219 asm-generic: remove ptrace.h)
Merging arc/for-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging arm/for-next (b7a735f3a606 Merge branch 'for-arm-soc' into for-next)
Merging arm64/for-next/core (0c61efd322b7 Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
Merging arm-perf/for-next/perf (ca786b8db751 arm64: perf: Remove unused mac=
ro)
Merging arm-soc/for-next (1439dbf17e9e Merge branch 'arm/fixes' into for-ne=
xt)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (7671b33bcaa8 Merge branch 'v5.3/fixes' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (ed2a2abc6334 Merge branch 'dt-for-v5.4' into for-n=
ext)
Merging at91/at91-next (90fbe456b5f0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (f83e5000db15 Merge branch 'bcm2835-dt-next' into =
for-next)
Merging imx-mxs/for-next (1596861583cb Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (78145dbeaea1 Merge branch 'for_5.3/driver-soc' into =
next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (e1b0b32a5ad6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (7376d6a65730 Merge branch 'fixes' into for-next)
Merging qcom/for-next (9f407b8ad181 Merge branches 'arm64-for-5.4' and 'dri=
vers-for-5.3' into for-next)
Merging renesas/next (a16ecb14d0b0 Merge branches 'arm-dt-for-v5.3', 'arm-s=
oc-for-v5.3', 'arm-defconfig-for-v5.3', 'arm64-defconfig-for-v5.3', 'arm64-=
dt-for-v5.3' and 'dt-bindings-for-v5.3' into next)
Merging renesas-geert/next (229a4cd46ddf Merge branch 'renesas-arm64-dt-for=
-v5.4' into renesas-next)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (55d674eec75b Merge branch 'v5.4-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging scmi/for-linux-next (609488bc979f Linux 5.3-rc2)
Merging sunxi/sunxi/for-next (b184e1e79e6d Merge branches 'sunxi/config64-f=
or-5.4' and 'sunxi/dt-for-5.4' into sunxi/for-next)
Merging tegra/for-next (033de83170dd Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (03d7036efa4a Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (ada384a7fd2d csky: Optimize arch_sync_dma_for_cpu/=
device with dma_inv_range)
Merging h8300/h8300-next (a5de8865cb3e h8300: move definition of __kernel_s=
ize_t etc. to posix_types.h)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f28a1f16135c m68k: Don't select ARCH_HAS_DMA_PREP_CO=
HERENT for nommu or coldfire)
Merging m68knommu/for-next (609488bc979f Linux 5.3-rc2)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (dc7077f89ad9 mips: remove nargs from __SYSCALL)
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (f017da5c7077 nios2: configs: Remove useless UEVENT_=
HELPER_PATH)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (740f05f30a8c parisc: fix race condition in patc=
hing code)
Merging powerpc/next (5f9e832c1370 Linus 5.3-rc1)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (f51edcec5288 MAINTAINERS: Add an entry for generic=
 architecture topology)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (019a09a26310 Documentation/s390: remove outdated deb=
ugging390 documentation)
Merging sh/sh-next (cd10afbc932d sh: remove unneeded uapi asm-generic wrapp=
ers)
CONFLICT (modify/delete): arch/sh/include/uapi/asm/types.h deleted in sh/sh=
-next and modified in HEAD. Version HEAD of arch/sh/include/uapi/asm/types.=
h left in tree.
CONFLICT (modify/delete): arch/sh/include/uapi/asm/setup.h deleted in sh/sh=
-next and modified in HEAD. Version HEAD of arch/sh/include/uapi/asm/setup.=
h left in tree.
$ git rm -f arch/sh/include/uapi/asm/setup.h arch/sh/include/uapi/asm/types=
.h
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (b482e48d29f1 um: fix build without CONFIG_UML_TIME_=
TRAVEL_SUPPORT)
Merging xtensa/xtensa-for-next (1386dcaa9226 Merge branch 'xtensa-5.3' into=
 xtensa-for-next)
Merging fscrypt/master (0564336329f0 fscrypt: document testing with xfstest=
s)
Merging afs/afs-next (852c1d04f6d0 afs: Support RCU pathwalk)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (80dfdbfd37d2 Merge branch 'for-next-current-v=
5.2-20190705' into for-next-20190705)
Merging ceph/master (d31d07b97a5e ceph: fix end offset in truncate_inode_pa=
ges_range call)
Merging cifs/for-next (ee7340d63f98 smb3: add missing flag definitions)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (7451c54abc91 ecryptfs: Change return type of ecryptf=
s_process_flags)
Merging ext3/for_next (56db1991690f udf: prevent allocation beyond UDF part=
ition)
Merging ext4/dev (96fcaf86c3cb ext4: fix coverity warning on error path of =
filename setup)
Merging f2fs/dev (01ff2b3740a6 f2fs: Support case-insensitive file name loo=
kups)
Merging fsverity/fsverity (60d7bf0f790f f2fs: add fs-verity support)
CONFLICT (content): Merge conflict in fs/f2fs/inode.c
CONFLICT (content): Merge conflict in fs/f2fs/file.c
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (d5b9216fd511 pnfs/flexfiles: Add tracepoints for de=
tecting pnfs fallback to MDS)
Merging nfs-anna/linux-next (68f461593f76 NFS/flexfiles: Use the correct TC=
P timeout for flexfiles I/O)
Merging nfsd/nfsd-next (64a38e840ce5 SUNRPC: Track writers of the 'channel'=
 file to improve cache_listeners_exist)
Merging orangefs/for-next (e65682b55956 orangefs: eliminate needless variab=
le assignments)
Merging overlayfs/overlayfs-next (0be0bfd2de9d ovl: fix regression caused b=
y overlapping layers detection)
Merging ubifs/linux-next (8009ce956c3d ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (afa1d96d1430 xfs: Fix possible null-pointer dereferen=
ces in xchk_da_btree_block_check_sibling())
Merging iomap/iomap-for-next (5d907307adc1 iomap: move internal declaration=
s into fs/iomap/)
Merging djw-vfs/vfs-for-next (7e328e5930ad mm/fs: don't allow writes to imm=
utable files)
Merging file-locks/locks-next (43e4cb942e88 locks: Fix procfs output for fi=
le leases)
Merging vfs/for-next (dad5ea4bac62 ceph_real_mount(): missing initializatio=
n)
CONFLICT (content): Merge conflict in fs/ubifs/super.c
CONFLICT (content): Merge conflict in fs/gfs2/super.c
CONFLICT (content): Merge conflict in fs/ceph/super.c
CONFLICT (modify/delete): Documentation/filesystems/vfs.txt deleted in HEAD=
 and modified in vfs/for-next. Version vfs/for-next of Documentation/filesy=
stems/vfs.txt left in tree.
$ git rm -f Documentation/filesystems/vfs.txt
Applying: docs: filesystems: vfs: update for "vfs: Kill mount_single()"
Merging printk/for-next (ba174ef6d224 Merge branch 'for-5.3-fixes' into for=
-next)
Merging pci/next (5f9e832c1370 Linus 5.3-rc1)
Merging pstore/for-next/pstore (609488bc979f Linux 5.3-rc2)
Merging hid/for-next (bf4945efabdf Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (9a74c745c689 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
Merging i3c/i3c/next (934d24a5e150 i3c: move i3c_device_match_id to device.=
c and export it)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (637b16e0744a hwmon: (npcm750-pwm-fan) Rem=
ove dev_err() usage after platform_get_irq())
Merging jc_docs/docs-next (e9bb62756153 docs: w1: convert to ReST and add t=
o the kAPI group of docs)
Merging v4l-dvb/master (4590c07462fb media: via-camera: convert to the vb2 =
framework)
Merging v4l-dvb-next/master (5f9e832c1370 Linus 5.3-rc1)
Merging fbdev/fbdev-for-next (732146a3f1dc video: fbdev: imxfb: fix a typo =
in imxfb_probe())
Merging pm/linux-next (9c77b777925f Merge branch 'pm-cpuidle' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (cfef2846f785 Merge branch 'cpuf=
req/qcom-updates' into cpufreq/arm/linux-next)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (0203c0343a1f Merge branch 'opp/qcom-updates' in=
to opp/linux-next)
Merging thermal/next (d093f91ff7d0 Merge branch 'for-rc' into next)
CONFLICT (rename/add): Rename Documentation/thermal/index.rst->Documentatio=
n/driver-api/thermal/index.rst in HEAD. Documentation/driver-api/thermal/in=
dex.rst added in thermal/next
Merging thermal-soc/next (4cb9f043447e thermal: thermal_mmio: remove some d=
ead code)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (a48f9721e6db dlm: no need to check return value of debugf=
s_create functions)
Merging swiotlb/linux-next (4cdfb27ba80d xen/swiotlb: remember having calle=
d xen_create_contiguous_region())
Merging rdma/for-next (16e9111e9ee3 RDMA/efa: Expose device statistics)
Merging net-next/master (6a7ce95d752e staging/octeon: Fix build error witho=
ut CONFIG_NETDEVICES)
CONFLICT (content): Merge conflict in drivers/net/can/flexcan.c
CONFLICT (content): Merge conflict in Documentation/PCI/pci-error-recovery.=
rst
Merging bpf-next/master (a98bf57391a2 tools: bpftool: add support for repor=
ting the effective cgroup progs)
Merging ipsec-next/master (c7b37c769d2a xfrm: remove get_mtu indirection fr=
om xfrm_type)
Merging mlx5-next/mlx5-next (0470e5e38c9d net/mlx5: fix -Wtype-limits compi=
lation warnings)
Merging netfilter-next/master (5133f36cef46 Merge branch 'net-dsa-ksz-Add-M=
icrochip-KSZ87xx-support')
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
CONFLICT (content): Merge conflict in drivers/nfc/st21nfca/se.c
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (15e830e90fde mwifiex: use eth_broadca=
st_addr() to assign broadcast address)
Merging bluetooth/master (fa9ccaf84f5d Bluetooth: hidp: Let hidp_send_messa=
ge return number of queued bytes)
Merging mac80211-next/master (6a7ce95d752e staging/octeon: Fix build error =
without CONFIG_NETDEVICES)
Merging gfs2/for-next (5d69e57fa9cc gfs2: Minor gfs2_alloc_inode cleanup)
Merging mtd/mtd/next (5f9e832c1370 Linus 5.3-rc1)
Merging nand/nand/next (1670e678a8a7 mtd: rawnand: ingenic: Add of_node_put=
() before return)
Merging spi-nor/spi-nor/next (5f9e832c1370 Linus 5.3-rc1)
Merging crypto/master (82cb54856874 asm-generic: make simd.h a mandatory in=
clude/asm header)
Merging drm/drm-next (609488bc979f Linux 5.3-rc2)
Merging amdgpu/drm-next (d40d959129f6 drm/amdkfd/kfd_mqd_manager_v10: Avoid=
 fall-through warning)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/navi10_=
ppt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/inc/amd=
gpu_smu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/amdgpu_=
smu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn20/=
dcn20_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_stream.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/clk_mg=
r/dcn20/dcn20_clk_mgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_vcn=
.h
Merging drm-intel/for-linux-next (c2052d6e242c drm/i915/ehl: Ungate DDIC an=
d DDID)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_trace.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gpu_error.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem_gtt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/selftest_work=
arounds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_workaro=
unds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_ringbuf=
fer.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_engine_=
cs.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_context=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power.c
Merging drm-tegra/drm/tegra/for-next (2a6fc3cb5cb6 drm/tegra: Fix gpiod_get=
_from_of_node() regression)
Merging drm-misc/for-linux-next (bed7a2182de6 drm/radeon: Provide ddc symli=
nk in connector sysfs directory)
$ git reset --hard HEAD^
Merging next-20190731 version of drm-misc
Merging drm-msm/msm-next (4cf643a39221 Merge tag 'drm-next-5.3-2019-06-27' =
of git://people.freedesktop.org/~agd5f/linux into drm-next)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (4cf643a39221 Merge tag 'drm-next-5.3-=
2019-06-27' of git://people.freedesktop.org/~agd5f/linux into drm-next)
Merging imx-drm/imx-drm/next (fee77829083a gpu: ipu-v3: image-convert: Enab=
le double write reduction)
Merging etnaviv/etnaviv/next (57bdd4057516 drm/etnaviv: Use devm_platform_i=
oremap_resource())
Merging regmap/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging sound/for-next (c1c0c032c785 Merge branch 'topic/hda-dmic' into for=
-next)
Merging sound-asoc/for-next (6382f3d3a859 Merge branch 'asoc-5.4' into asoc=
-next)
CONFLICT (content): Merge conflict in sound/soc/intel/skylake/skl.h
CONFLICT (content): Merge conflict in sound/soc/intel/skylake/skl-nhlt.c
Merging modules/modules-next (38f054d549a8 modules: always page-align modul=
e section allocations)
Merging input/next (c394159310d0 Input: soc_button_array - add support for =
newer surface devices)
Merging block/for-next (5b9ddbdf2f36 Merge branch 'for-linus' into for-next)
Merging device-mapper/for-next (9c50a98f55f4 dm table: fix various whitespa=
ce issues with recent DAX code)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (979f97f2771b mmc: host: sdhci: Fix the incorrect soft res=
et operation when runtime resuming)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (b5e29aa880be mfd: davinci_voicecodec: Remove poin=
tless #include)
Merging backlight/for-backlight-next (73fbfc499448 backlight: pwm_bl: Fix h=
euristic to determine number of brightness levels)
Merging battery/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging regulator/for-next (6b7c449ffaa0 Merge branch 'regulator-5.4' into =
regulator-next)
Merging security/next-testing (286e47a07799 Merge branch 'next-lsm' into ne=
xt-testing)
Merging apparmor/apparmor-next (136db994852a apparmor: increase left match =
history buffer size)
Merging integrity/next-integrity (650b29dbdf2c integrity: Introduce struct =
evm_xattr)
Merging keys/keys-next (8cf8684e0d24 Merge branch 'keys-acl' into keys-next)
CONFLICT (content): Merge conflict in include/linux/key.h
CONFLICT (content): Merge conflict in fs/afs/security.c
Applying: fsverity: merge fix for keyring_alloc API change
Merging selinux/next (5f9e832c1370 Linus 5.3-rc1)
Merging tpmdd/next (166a2809d65b tpm: Don't duplicate events from the final=
 event log in the TCG2 log)
Merging watchdog/master (a18670f4617d watchdog: ath79_wdt: fix a typo in th=
e name of a function)
Merging iommu/next (66929812955b iommu/amd: Add support for X2APIC IOMMU in=
terrupts)
Merging vfio/next (1e4d09d2212d mdev: Send uevents around parent device reg=
istration)
Merging audit/next (5f9e832c1370 Linus 5.3-rc1)
Merging devicetree/for-next (bf1c0ac6a8bc docs: writing-schema.md: convert =
from markdown to ReST)
Merging mailbox/mailbox-for-next (25777e5784a7 mailbox: handle failed named=
 mailbox channel request)
Merging spi/for-next (1bda625684d2 Merge branch 'spi-5.4' into spi-next)
Merging tip/auto-latest (243961b422fc Merge branch 'locking/core')
Applying: hrtimer: fix typo in hrtimer_init_sleeper_on_stack() conversion
Merging clockevents/clockevents/next (b0c74b96d177 clocksource/drivers/davi=
nci: Add support for clocksource)
Merging edac/edac-for-next (3123c5c4ca15 edac: altera: Move Stratix10 SDRAM=
 ECC to peripheral)
Merging irqchip/irq/irqchip-next (3dae67ce600c irqchip/gic-pm: Remove PM_CL=
K dependency)
Merging ftrace/for-next (6d54ceb539aa tracing: Fix user stack trace "??" ou=
tput)
Merging rcu/rcu/next (b989ff070574 Merge LKMM and RCU commits)
Merging kvm/linux-next (30cd8604323d KVM: x86: Add fixed counters to PMU fi=
lter)
Merging kvm-arm/next (1e0cf16cdad1 KVM: arm/arm64: Initialise host's MPIDRs=
 by reading the actual register)
Merging kvm-ppc/kvm-ppc-next (3bda7f0ae0f7 KVM: PPC: Book3S PR: Fix softwar=
e breakpoints)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
Merging xen-tip/linux-next (a78d14a31666 xen: avoid link error on ARM)
Merging percpu/for-next (03ed70fb0e5e Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (be69d00d9769 workqueue: Remove GPF argument fr=
om alloc_workqueue_attrs())
Merging drivers-x86/for-next (6fe9363b1576 platform/x86: acer-wmi: Switch t=
o acpi_dev_get_first_match_dev())
Merging chrome-platform/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging hsi/for-next (c1030cd45619 HSI: Remove dev_err() usage after platfo=
rm_get_irq())
Merging leds/for-next (be7fc2cc8617 Merge tag 'generic_lookup_helpers' into=
 for-next)
Merging ipmi/for-next (fec88ab0af97 Merge tag 'for-linus-hmm' of git://git.=
kernel.org/pub/scm/linux/kernel/git/rdma/rdma)
Merging driver-core/driver-core-next (98051ba2b28b coccinelle: Add script t=
o check for platform_get_irq() excessive prints)
Merging usb/usb-next (b33f37064b74 usb: Remove dev_err() usage after platfo=
rm_get_irq())
Merging usb-gadget/next (b2357839c56a usb: renesas_usbhs: add a workaround =
for a race condition of workqueue)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (609488bc979f Linux 5.3-rc2)
Merging tty/tty-next (9d4742136a26 xilinx_uartps.c: suppress "may be used u=
ninitialised" warning)
Merging char-misc/char-misc-next (509ce4c85bd0 ppdev: add header include gu=
ard)
Merging extcon/extcon-next (a3fc57233977 extcon: adc-jack: Remove dev_err()=
 usage after platform_get_irq())
Merging soundwire/next (5f9e832c1370 Linus 5.3-rc1)
Merging thunderbolt/next (6fbc7275c7a9 Linux 5.2-rc7)
Merging staging/staging-next (9a675a13c3bb Revert "staging: kpc2000: Conver=
t put_page() to put_user_page*()")
Merging mux/for-next (05fb8284a417 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (57dbd0e4b97d dmaengine: stm32-mdma: Switch to use d=
evice_property_count_u32())
Merging cgroup/for-next (a581563f1bef cgroup: minor tweak for logic to get =
cgroup css)
Merging scsi/for-next (03ed974738a0 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (99b7132e18fd scsi: qla2xxx: Update driver versio=
n to 10.01.00.18-k)
Merging vhost/linux-next (73f628ec9e6b vhost: disable metadata prefetch opt=
imization)
Merging rpmsg/for-next (7f1345e9efcc Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (c058275cfa13 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (61059b7048ee gpio: ixp4xx: remove redundan=
t dev_err message)
Merging pinctrl/for-next (87cdf194fbfb Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging pwm/for-next (3d25025ce9c2 pwm: fsl-ftm: Make sure to unlock mutex =
on failure)
Merging userns/for-next (318759b4737c signal/x86: Move tsk inside of CONFIG=
_MEMORY_FAILURE in do_sigbus)
Merging ktest/for-next (aecea57f84b0 ktest: Fix some typos in config-bisect=
.pl)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (5f9e832c1370 Linus 5.3-rc1)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
CONFLICT (content): Merge conflict in arch/riscv/include/uapi/asm/unistd.h
Merging livepatching/for-next (28f28ea4343a Merge branch 'for-5.3-core' int=
o for-next)
Merging coresight/next (d1aa58c4baa7 coresight: etm4x: improve clarity of e=
tm4_os_unlock comment)
Merging rtc/rtc-next (06c8e550a84e rtc: s5m: convert to i2c_new_dummy_devic=
e)
Merging nvdimm/libnvdimm-for-next (cb3110f7452d Merge branch 'for-5.3/dax' =
into libnvdimm-for-next)
Merging at24/at24/for-next (10742fee98eb eeprom: at24: remove unneeded incl=
ude)
Merging ntb/ntb-next (5f9e832c1370 Linus 5.3-rc1)
Merging kspp/for-next/kspp (60f2c82ed20b randstruct: Check member structs i=
n is_pure_ops_struct())
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging fsi/next (371975b0b075 fsi/core: Fix error paths on CFAM init)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (341f8ae0f820 dt-bindings: nvmem: SID: Fix the examp=
les node names)
CONFLICT (content): Merge conflict in drivers/nvmem/meson-mx-efuse.c
CONFLICT (content): Merge conflict in drivers/nvmem/meson-efuse.c
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/freescale/fsl,scu.txt
Merging xarray/xarray (91abab83839a XArray: Fix xas_next() with a single en=
try at 0)
Merging hyperv/hyperv-next (221f6df008ab hv_balloon: Reorganize the probe f=
unction)
Merging auxdisplay/auxdisplay (f4bb1f895aa0 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (5c4b37bb4972 pidfd: add pidfd_wait tests)
Merging devfreq/for-next (27c17be8e488 PM / devfreq: tegra20: add COMMON_CL=
K dependency)
Merging hmm/hmm (cc374377a19d mm/hmm: remove hmm_range vma)
Merging fpga/for-next (7d62460b4060 MAINTAINERS: Move linux-fpga tree to ne=
w location)
Merging akpm-current/current (160350afba05 ipc/msg.c: consolidate all xxxct=
l_down() functions)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: mm: treewide: clarify pgtable_page_{ctor,dtor}() naming
Applying: drivers/tty/serial/sh-sci.c: suppress warning
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (89ff87954200 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/k.0nWG0D7p0I199R/ynx1V/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1Cg0wACgkQAVBC80lX
0GzNVwf+K4HzKYNCyvwl+FhRHvqyHXQBIAUtX9UOIwmC6d7DuACxU6/kiteKK/Xk
wl+nIHPGeUM+P9zsNtzHE/UJHCnE9tiTDWqa11m2kZYtFSQaktcaFdN1f3n2gfY8
/5Vo07W7Wz9czAznaKRw6mHqkMwfdjvUqBSO/dJrpBVWSVivUdCuyFIfNyWwq7/z
ogmSwMoe4OE/+Y/pTyrVYgqlWrUu6BgZBsnNul1uK6l+KdP2vmueNVwpqOIUs95k
mPR8VhbXbfcBeJC2QAtZQ0PWe9/OjJJV7ARkL0iTqZpW/h9qv9NE3FmQ73+afDwI
6bgoarYwT4/C43i21UyQ9lzS9w+LXQ==
=eylo
-----END PGP SIGNATURE-----

--Sig_/k.0nWG0D7p0I199R/ynx1V/--
