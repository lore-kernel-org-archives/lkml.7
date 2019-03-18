Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8720857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pm9MsKMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCRC4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:56:32 -0400
Received: from ozlabs.org ([203.11.71.1]:53577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfCRC4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 22:56:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44N16K3Wn1z9s9N;
        Mon, 18 Mar 2019 13:56:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552877785;
        bh=Yf/IhJp72u1DIldVZpRk6RisvQCoIwPOf0PF45X5xQY=;
        h=Date:From:To:Cc:Subject:From;
        b=pm9MsKMYJxfiAZBfOdkKYiMlv3nt34r+aEPQ7CMUqIoh48WQDfaFTt1kO99pqH0mk
         FrBWQhhy4ez2X2yOeKUcafrYqymRQ10ATg2g16LBfegj1ykQs4k4ybMoxGX0pUTuo7
         Yuw5vz+XhYIwj7vFg+U2UCESGh4FZvHexDEca4kJUKwnk4hIKHcMKFmvaa4UxI448t
         8jHEDVkIVDP5VqXlW3tgL17GXAJg5TxKroBsxYcgnAT+F/RpCQgnXuyHjZX1GUmi6G
         OOTgJPBFe45Y+a51MYcd4aZ7RPkY8R6A4ZOCpdln/ngefkz9co5AnLvEg4DAop+oh7
         feRMtqLx+YtUQ==
Date:   Mon, 18 Mar 2019 13:56:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 18
Message-ID: <20190318135624.28e63858@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vzgSiKzT65deR/2hqzg97nO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vzgSiKzT65deR/2hqzg97nO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190306:

The cisco tree gained a conflict against Linus' tree.

Non-merge commits (relative to Linus' tree): 591
 502 files changed, 14759 insertions(+), 4153 deletions(-)

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

I am currently merging 297 trees (counting Linus' and 69 trees of bug
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
Merging origin/master (9e98c678c2d6 Linux 5.1-rc1)
Merging fixes/master (2648624cfe7f adfs: mark expected switch fall-throughs)
Merging kspp-gustavo/for-next/kspp (1f7ae812f87e x86/syscalls: Mark expecte=
d switch fall-throughs)
Merging kbuild-current/fixes (5453a3df2a5e Merge tag 'kconfig-v5.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging arc-current/for-curr (9a18b5a412ba arch: arc: Kconfig: pedantic for=
matting)
Merging arm-current/fixes (d410a8a49e3e ARM: 8849/1: NOMMU: Fix encodings f=
or PMSAv8's PRBAR4/PRLAR4)
Merging arm64-fixes/for-next/fixes (74698f6971f2 arm64: Relax GIC version c=
heck during early boot)
Merging m68k-current/for-linus (28713169d879 m68k: Add -ffreestanding to CF=
LAGS)
Merging powerpc-fixes/fixes (8f5b27347e88 powerpc/powernv/sriov: Register I=
OMMU groups for VFs)
Merging sparc/master (7d762d69145a afs: Fix manually set volume location se=
rver list)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (517ccc2aa50d net: tipc: fix a missing check for nla_nes=
t_start)
Merging bpf/master (86be36f6502c powerpc: bpf: Fix generation of load/store=
 DW instructions)
Merging ipsec/master (6ee02a54ef99 xfrm6_tunnel: Fix potential panic when u=
nloading xfrm6_tunnel module)
Merging netfilter/master (b8b27498659c netfilter: nf_tables: return immedia=
tely on empty commit)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (688cd8bd2c0f iwlwifi: fix 64-bit division)
Merging mac80211/master (d235c48b40d3 net: dsa: mv88e6xxx: power serdes on/=
off for 10G interfaces on 6390X)
Merging rdma-fixes/for-rc (f09ef134a7ca iw_cxgb4: cq/qp mask depends on bar=
2 pages in a host page)
Merging sound-current/for-linus (2d012c65a9ca ALSA: firewire-motu: use 'ver=
sion' field of unit directory to identify model)
Merging sound-asoc-fixes/for-linus (5b4e1c6a68b0 Merge branch 'asoc-5.0' in=
to asoc-linus)
CONFLICT (content): Merge conflict in sound/soc/codecs/tlv320aic3x.c
Merging regmap-fixes/for-linus (f17b5f06cb92 Linux 5.0-rc4)
Merging regulator-fixes/for-linus (078d354f8d7f Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (8d0e51ac6f8c Merge branch 'spi-5.0' into spi-l=
inus)
Merging pci-current/for-linus (f57a98e1b713 PCI: Work around Synopsys dupli=
cate Device ID (HAPS USB3, NXP i.MX))
Merging driver-core.current/driver-core-linus (a9dce6679d73 Merge tag 'pidf=
d-v5.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging tty.current/tty-linus (a9dce6679d73 Merge tag 'pidfd-v5.1-rc1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging usb.current/usb-linus (a9dce6679d73 Merge tag 'pidfd-v5.1-rc1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging usb-gadget-fixes/fixes (a53469a68eb8 usb: phy: am335x: fix race con=
dition in _probe)
Merging usb-serial-fixes/usb-linus (8d7fa3d4ea3f USB: serial: ftdi_sio: add=
 ID for Hjelmslund Electronics USB485)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (827cb0323928 phy: ath79-usb: Fix the main reset name to =
match the DT binding)
Merging staging.current/staging-linus (a9dce6679d73 Merge tag 'pidfd-v5.1-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging char-misc.current/char-misc-linus (a9dce6679d73 Merge tag 'pidfd-v5=
.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (1c163f4c7b3f Linux 5.0)
Merging input-current/for-linus (44fc95e218a0 Input: wacom_serial4 - add su=
pport for Wacom ArtPad II tablet)
Merging crypto-current/master (00e87449430d crypto: caam - add missing put_=
device() call)
Merging ide/master (dc5c37736d16 drivers: ide: Kconfig: pedantic formatting)
Merging vfio-fixes/for-linus (9a71ac7e15a7 vfio-pci/nvlink2: Fix ancient gc=
c warnings)
Merging kselftest-fixes/fixes (7d4e591bc051 selftests: timers: use LDLIBS i=
nstead of LDFLAGS)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (d13937116f1e Linux 5.0-rc6)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (3e35730dd754 mtd: powernv_flash: Fix device regis=
tration error)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (7bdf2c8fee51 media: v4l: ioctl: Sanitize num_p=
lanes before using it)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (f6cab793d4a7 MIPS: Remove custom MIPS32 __ke=
rnel_fsid_t type)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (dc30e7039137 ARM: OMAP2+: Variable "reg" in funct=
ion omap4_dsi_mux_pads() could be uninitialized)
Merging kvm-fixes/master (de3ccd26fafc KVM: MMU: record maximum physical ad=
dress width in kvm_mmu_extended_role)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (8d0139ae5973 hwmon: (w83773g) Select REGMAP_I2C =
to fix build error)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (8c297773d54c Merge branch 'misc-5.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (d3d6a18d7d35 aio: Fix locking in aio_poll())
Merging dma-mapping-fixes/for-linus (60d8cd572f65 arm64/xen: fix xen-swiotl=
b cache flushing)
Merging i3c-fixes/master (f36c1f9a8dfd i3c: master: dw: fix deadlock)
Merging drivers-x86-fixes/fixes (6a730fcb9cb4 Documentation/ABI: Correct ml=
xreg-io KernelVersion for 5.0)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (388b4e6a00bb scsi: core: Avoid that system resume=
 triggers a kernel warning)
Merging drm-fixes/drm-fixes (1c163f4c7b3f Linux 5.0)
Merging drm-intel-fixes/for-linux-next-fixes (1c163f4c7b3f Linux 5.0)
Merging mmc-fixes/fixes (e30be063d6db mmc: sdhci-esdhc-imx: correct the fix=
 of ERR004536)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (bfeffd155283 Linux 5.0-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (3fc6bb043dac drm/vkms: fix use=
-after-free when drm_gem_handle_create() fails)
Merging kbuild/for-next (6fb7ef5a343d kbuild: pkg: grep include/config/auto=
.conf instead of $KCONFIG_CONFIG)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9ac060a708e0 leaking_addresses: Completely remove=
 --version flag)
Merging dma-mapping/for-next (9eb9e96e97b3 Documentation/DMA-API-HOWTO: upd=
ate dma_mask sections)
Merging asm-generic/master (d724444ab97d asm-generic/page.h: fix typo in #e=
rror text requiring a real asm/page.h)
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (4c2741ac5e10 Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (b855b58ac1b7 arm64: mmu: drop paging_init comm=
ents)
Merging arm-perf/for-next/perf (cf2d65ec1d21 perf: xgene: Remove set but no=
t used variable 'config')
Merging arm-soc/for-next (48d1dbf3918f arm-soc: document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (b32ed5ad1eb8 Merge branch 'v5.2/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (69dd6b9f7d58 Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (fe0b295f61af Merge branch 'imx/maintainers' into =
for-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (d542127adb0c Merge branch 'v5.0-next/soc' into f=
or-next)
Merging mvebu/for-next (c51f7f863552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (af3b69ea03a2 Merge branch 'omap-for-v5.1/cpsw' into =
for-next)
Merging reset/reset/next (dbfc54534dfc dt-bindings: reset: meson: add g12a =
bindings)
Merging qcom/for-next (75920dd0498d Merge tag 'qcom-fixes-for-5.0-rc8' into=
 doof)
Merging renesas/next (f4435b0d605e Merge branch 'fixes-for-v5.1' into next)
Merging rockchip/for-next (fa178db056d0 Merge branch 'v5.1-armsoc/dts-fixes=
' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (8ecb112edde9 Merge branch 'fixes-late-dt' in=
to for-next)
Merging sunxi/sunxi/for-next (1fc3dc289134 Merge remote-tracking branches '=
korg/sunxi/sunxi/dt-for-5.1', 'korg/sunxi/sunxi/dt64-for-5.1' and 'korg/sun=
xi/sunxi/h3-h5-for-5.1' into sunxi/for-next)
Merging tegra/for-next (d92dde4f12f1 Merge branch for-5.1/fixes into for-ne=
xt)
Merging clk/clk-next (010d5166bbe9 dt-bindings: clock: imx8mq: Fix numberin=
g overlaps and gaps)
Merging clk-samsung/for-next (81faa30df9b6 clk: samsung: exynos5433: Add se=
lected IMEM clocks)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (88d5f20a8139 csky: Fixup vdsp&fpu issues in kernel)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (28713169d879 m68k: Add -ffreestanding to CFLAGS)
Merging m68knommu/for-next (d7e9d01ac292 m68k: add ColdFire mcf5441x eDMA p=
latform support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (aeb669d41ffa MIPS: lantiq: Remove separate GPHY Fir=
mware loader)
Merging nds32/next (4e8fa54d3d99 nds32: fix semicolon code style issue)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (1c163f4c7b3f Linux 5.0)
Merging powerpc/next (de3c83c2fd2b powerpc/64s: Include <asm/nmi.h> header =
file to fix a warning)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (13fd5de06514 RISC-V: Fixmap support and MM cleanup=
s)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (152e9b8676c6 s390/vtime: steal time exponential movi=
ng average)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (aea05eb56e47 um: Fix for a possible OOPS in ubd ini=
tialization)
Merging xtensa/xtensa-for-next (036ef74b3ecb Merge branch 'xtensa-5.1' into=
 xtensa-for-next)
Merging fscrypt/master (129ca2d2a83f MAINTAINERS: add Eric Biggers as an fs=
crypt maintainer)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (836b12f8c30d Merge branch 'for-next-next-v5.0=
-20190228' into for-next-20190228)
CONFLICT (content): Merge conflict in fs/btrfs/transaction.c
Merging ceph/master (d11ae8e0a76a Documentation: modern versions of ceph ar=
e not backed by btrfs)
Merging cifs/for-next (e84b8372f041 [SMB3] fix incorrect error code mapping=
 for OBJECTID_NOT_FOUND)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (2337494f7c0f Merge udf cleanup.)
Merging ext4/dev (6c7328400e04 ext4: report real fs size after failed resiz=
e)
Merging f2fs/dev (aff7b628ac2d f2fs: set pin_file under CAP_SYS_ADMIN)
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (5e3863fd597e SUNRPC: Remove redundant check for the=
 reply length in call_decode())
Merging nfs-anna/linux-next (a3b22b9f11d9 Linux 5.0-rc7)
Merging nfsd/nfsd-next (f875a792abe9 nfsd: allow nfsv3 readdir request to b=
e larger.)
Merging orangefs/for-next (6e356d45950e orangefs: remove two un-needed BUG_=
ONs...)
Merging overlayfs/overlayfs-next (993a0b2aec52 ovl: Do not lose security.ca=
pability xattr over metadata file copy-up)
Merging ubifs/linux-next (5578e48e5c0b ubi: wl: Silence uninitialized varia=
ble warning)
Merging v9fs/9p-next (bb06c388fa20 9p/net: fix memory leak in p9_client_cre=
ate)
Merging xfs/for-next (6ef50fe9afae xfs: clean up xfs_dir2_leaf_addname)
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (c0abe5af7341 Merge branches 'work.mount', 'work.misc'=
 and 'work.iov_iter' into for-next)
Merging printk/for-next (943ca6ad81e5 printk/docs: Add extra integer types =
to printk-formats)
Merging pci/next (dd92b6677e3d Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (54f97b456ef4 Merge branch 'for-5.1/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (560c09843e4f Merge branch 'i2c/for-current-fixed'=
 into i2c/for-next)
Merging i3c/i3c/next (988bb4a1937b i3c: master: dw-i3c-master: mark expecte=
d switch fall-through)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (985e225142cf dt-bindings: hwmon: Add miss=
ing documentation for lm75)
Merging jc_docs/docs-next (4064174becc0 docs: Bring some order to filesyste=
m documentation)
Merging v4l-dvb/master (15d90a6ae98e media: dvb/earth-pt1: fix wrong initia=
lization for demod blocks)
Merging v4l-dvb-next/master (9fabe1d108ca media: ipu3-mmu: fix some kernel-=
doc macros)
Merging fbdev/fbdev-for-next (9a9f1d1a81a9 fbdev: mbx: fix a misspelled var=
iable name)
Merging pm/linux-next (fa59d1e0bc51 Merge branches 'acpi-scan', 'acpi-misc'=
 and 'acpi-debug' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (0334906c0696 cpufreq: kryo: Rel=
ease OPP tables on module removal)
Merging cpupower/cpupower (ae2917093fb6 tools/power/cpupower: Display boost=
 frequency separately)
Merging opp/opp/linux-next (a9a744dd5b82 cpufreq: OMAP: Register an Energy =
Model)
Merging thermal/next (b537f89a9e4b Merge branches 'fixes' and 'thermal-inte=
l' into next)
CONFLICT (content): Merge conflict in drivers/thermal/tegra/soctherm.c
CONFLICT (content): Merge conflict in drivers/thermal/mtk_thermal.c
Merging thermal-soc/next (8834f5600cf3 Linux 5.0-rc5)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (8526e331c56f dlm: Fix test for -ERESTARTSYS)
Merging swiotlb/linux-next (22cb45d7692a swiotlb: drop pointless static qua=
lifier in swiotlb_create_debugfs())
Merging rdma/for-next (fca22e7e595f net/mlx5: ODP support for XRC transport=
 is not enabled by default in FW)
Merging net-next/master (3b319ee220a8 Merge tag 'acpi-5.1-rc1-2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging bpf-next/master (d9862cfbe209 Merge tag 'mips_5.1' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/mips/linux)
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (37b6bb77c6fd net/mlx5: Factor out HCA capabili=
ties functions)
Merging netfilter-next/master (8c4238df4d0c Merge branch 'mlxsw-minimal-Add=
-ethtool-and-resource-query-support')
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (501faf710230 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (e057ab715f1e Bluetooth: Add return check for L2CA=
P security level set)
Merging mac80211-next/master (be9cefe796f3 selftests: rtnetlink: use intern=
al netns switch for ip commands)
Merging gfs2/for-next (12ad143e1b80 Merge branch 'perf-urgent-for-linus' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging mtd/mtd/next (9220d7befc9c Merge tag 'nand/for-5.1' of git://git.in=
fradead.org/linux-mtd into mtd/next)
Merging nand/nand/next (53bcbb839438 mtd: rawnand: denali_dt: remove single=
 anonymous clock support)
Merging spi-nor/spi-nor/next (225c0eda36bd mtd: spi-nor: Fix wrong abbrevia=
tion HWCPAS)
Merging crypto/master (0918f18c7179 crypto: s5p - add AES support for Exyno=
s5433)
Merging drm/drm-next (0f1d37e65a59 Merge branch 'drm-next-5.1' of git://peo=
ple.freedesktop.org/~agd5f/linux into drm-next)
Merging drm-intel/for-linux-next (ca22f32a6296 drm/i915: Relax mmap VMA che=
ck)
Merging drm-tegra/drm/tegra/for-next (ca52507efc03 drm/tegra: vic: Fix impl=
icit function declaration warning)
Merging drm-misc/for-linux-next (c34674a23d1e drm/qxl: remove conflicting f=
ramebuffers earlier)
Merging drm-msm/msm-next (745b19d74716 drm/msm/dpu: check split role for si=
ngle flush)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (b4a650fb0d72 drm/komeda: Add debugfs =
node "register" for register dump)
Merging imx-drm/imx-drm/next (a0ea4ffff266 drm/imx: only send commit done e=
vent when all state has been applied)
Merging etnaviv/etnaviv/next (9e05352340d3 drm/etnaviv: potential NULL dere=
ference)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (66fb181d6f82 Merge remote-tracking branch 'regmap/=
topic/irq' into regmap-next)
Merging sound/for-next (2d012c65a9ca ALSA: firewire-motu: use 'version' fie=
ld of unit directory to identify model)
Merging sound-asoc/for-next (6e37e89c3d0f Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (1c163f4c7b3f Linux 5.0)
Merging input/next (6d3a41ab0c37 Input: edt-ft5x06 - convert to use SPDX id=
entifier)
Merging block/for-next (602d674ce90f nvme-tcp: support C2HData with SUCCESS=
 flag)
Merging device-mapper/for-next (225557446856 dm integrity: limit the rate o=
f error messages)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (d4721339dcca mmc:fix a bug when max_discard is 0)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (d2d833e0bf2b mfd: mxs-lradc: Mark expected switch=
 fall-through)
Merging backlight/for-backlight-next (cec2b18832e2 backlight: pwm_bl: Use g=
piod_get_value_cansleep() to get initial state)
Merging battery/for-next (655ab0bc462d power: reset: at91-reset: add suppor=
t for sam9x60 SoC)
Merging regulator/for-next (93f8d88098bc Merge branch 'regulator-5.1' into =
regulator-next)
Merging security/next-testing (3963bdb87e66 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (6c07c1c74394 apparmor: fix blob compression=
 when ns is forced on a policy load)
Merging integrity/next-integrity (e7fde070f39b evm: Use defined constant fo=
r UUID representation)
Merging selinux/next (45189a1998e0 selinux: fix avc audit messages)
Merging tpmdd/next (5812f97c0a22 tpm: Fix the type of the return value in c=
alc_tpm2_event_size())
Merging watchdog/master (458c8961c194 watchdog: w83877f_wdt: Mark expected =
switch fall-through)
Merging iommu/next (d05e4c8600c3 Merge branches 'iommu/fixes', 'arm/msm', '=
arm/tegra', 'arm/mediatek', 'x86/vt-d', 'x86/amd', 'hyper-v' and 'core' int=
o next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0cfd027be1d6 vfio_pci: Enable memory accesses before cal=
ling pci_map_rom)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (131d34cb0795 audit: mark expected switch fall-through)
Merging devicetree/for-next (935665c1a117 of: unittest: unflatten device tr=
ee on UML when testing)
Merging mailbox/mailbox-for-next (17b860bbfc84 mailbox: imx: keep MU irq wo=
rking during suspend/resume)
Merging spi/for-next (8cb790a1f4f1 Merge branch 'spi-5.1' into spi-next)
Merging tip/auto-latest (2d8fdbb66245 Merge branch 'x86/uv')
Merging clockevents/clockevents/next (dbfc6db7ba46 soc/tegra: default selec=
t TEGRA_TIMER for Tegra210)
Merging edac-amd/for-next (580b5cf50ca8 EDAC/altera: Add separate SDRAM EDA=
C config)
Merging irqchip/irq/irqchip-next (b41fdc4a7bf9 irqchip/gic: Drop support fo=
r secondary GIC in non-DT systems)
Merging ftrace/for-next (85f726a35e50 tracing: Use strncpy instead of memcp=
y when copying comm in trace.c)
Merging rcu/rcu/next (e880edadc149 Merge LKMM and RCU)
Merging kvm/linux-next (4a605bc08e98 kvm: vmx: fix formatting of a comment)
Merging kvm-arm/next (c88b093693cc arm64: KVM: Fix architecturally invalid =
reset value for FPEXC32_EL2)
Merging kvm-ppc/kvm-ppc-next (2b57ecd0208f KVM: PPC: Book3S: Add count cach=
e flush parameters to kvmppc_get_cpu_char())
Merging kvms390/next (11ba5961a215 KVM: s390: add debug logging for cpu mod=
el subfunctions)
Merging xen-tip/linux-next (0266def91377 xen/balloon: Fix mapping PG_offlin=
e pages to user space)
Merging percpu/for-next (d33d9f3dd96b percpu: use chunk scan_hint to skip s=
ome scanning)
Merging workqueues/for-next (a2775bbc1d58 kernel/workqueue: Use __printf ma=
rkup to silence compiler in function 'alloc_workqueue')
Merging drivers-x86/for-next (9c22cc020db6 MAINTAINERS: Include mlxreg.h in=
 Mellanox Platform Driver files)
Merging chrome-platform/for-next (86777c37f05b platform/chrome: Fix locking=
 pattern in wilco_ec_mailbox())
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (5ddb0869bfc1 leds: lp55xx: fix null deref on firmwar=
e load failure)
Merging ipmi/for-next (487ecb21fa66 ipmi: fix sleep-in-atomic in free_user =
at cleanup SRCU user->release_barrier)
Merging driver-core/driver-core-next (a9dce6679d73 Merge tag 'pidfd-v5.1-rc=
1' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging usb/usb-next (a9dce6679d73 Merge tag 'pidfd-v5.1-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (6431866b6707 USB: serial: option: add Telit ME=
910 ECM composition)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (203d9b11928c phy: qcom-qmp: Add QMP UFS PHY support =
for msm8998)
Merging tty/tty-next (a9dce6679d73 Merge tag 'pidfd-v5.1-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging char-misc/char-misc-next (a9dce6679d73 Merge tag 'pidfd-v5.1-rc1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging extcon/extcon-next (69266982d2ed extcon: Fix build warning for extc=
on_unregister_notifier comment)
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (2a6d2af3ec96 thunderbolt: Fix a missing check of =
kmemdup)
Merging staging/staging-next (a9dce6679d73 Merge tag 'pidfd-v5.1-rc1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (fcf9d0b7d2f5 drm/msm/a6xx: Add support for an interco=
nnect path)
Merging slave-dma/next (58810c58b9e7 Merge branch 'for-linus' into next)
Merging cgroup/for-next (6a613d24effc cpuset: remove unused task_has_mempol=
icy())
Merging scsi/for-next (c589c80ade7c Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (2ee60cf005d8 scsi: ia64: simscsi: use request ta=
g instead of serial_number)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (3fbdb54c7d5a arch: move common mmap flags to linu=
x/mman.h)
CONFLICT (content): Merge conflict in drivers/iommu/Makefile
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
Merging rpmsg/for-next (6a4ac1cc9997 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gpio-brgl/gpio/for-next (2aa9cd1cb702 gpio: vf610: Don't use explic=
it &pdev->dev in vf610_gpio_probe())
Merging pinctrl/for-next (9bc8fee96e9a pinctrl: imx: fix scu link errors)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (d7d96312fe10 pwm: atmel: Remove useless symbolic defi=
nitions)
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (0e27ded1159f selftests/ftrace: Handle the absence o=
f tput)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (b420648f103d Merge branch 'for-5.1-atomic-re=
place' into for-next)
Merging coresight/next (9127ceeca5eb coresight: catu: fix clang build warni=
ng)
Merging rtc/rtc-next (e91b94fd2bc4 rtc: pic32: convert to SPDX identifier)
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (950bcbbe3154 eeprom: at24: implement support fo=
r 'num-addresses' property)
Merging ntb/ntb-next (8af642c76ef5 NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (50ceaa95ea09 lib: Introduce test_stackinit modu=
le)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (84a401a27506 Merge branch 'for-x86' into for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
CONFLICT (content): Merge conflict in arch/powerpc/configs/skiroot_defconfig
Merging gnss/gnss-next (d4584bbfcf2a gnss: add driver for mediatek receiver=
s)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (81648d8bc222 slimbus: core: add missing spin_lock=
_init on txn_lock)
Merging nvmem/for-next (c86d78c459db nvmem: allow to select i.MX nvmem driv=
er for i.MX 7D)
Merging xarray/xarray (4a5c8d898948 XArray: Fix xa_reserve for 2-byte align=
ed entries)
Merging hyperv/hyperv-next (396ae57ef1ef Drivers: hv: vmbus: Expose counter=
s for interrupts and full conditions)
Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make backl=
ight initial state configurable)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (f67dcc84eb36 selftests: add tests for pidfd_send_si=
gnal())
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Merging devfreq/for-next (ca740a8f3e7f PM / devfreq: Fix static checker war=
ning in try_then_request_governor)
Merging akpm-current/current (097770be40ca ipc: do cyclic id allocation wit=
h ipcmni_extend mode)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: scripts/atomic/gen-atomics.sh: don't assume that scripts are exec=
utable
Applying: fs: fs_parser: fix printk format warning
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm, memcg: consider subtrees in memory.events
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (a8bf82af9f12 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/vzgSiKzT65deR/2hqzg97nO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyPCNgACgkQAVBC80lX
0Gw5Kgf/T7Re/AdV90BM0WEI7u69g6nMaPkmvJml7Oygsw+OskMT/3yGVO6txpTJ
7myIdr2jqD2z1HmHtQzfLl09co1H371e7uvzCo0VxnUAfGCCiW7B8Yt2nnV+nHlS
5fxNY60ny5Cu+7sTGMiBUZfQnKx88K7OFI0HBNzCyVObE+10n41bdIspT2ksQZRc
Qa7GOX3CjHdKxhFqGkoJhGELNOy6lNXEERZLaJfwedVbTrTZLbH0XuFwhbR6xWme
45je86TMYYQK7JtAD84IRL2l7OuNOj/bKEGLGSklW8uCs/D0cQjzdYBNX4V/gBC2
ghLqV4qxxUEav1bA6gI5uHGbCDhBVA==
=WQz0
-----END PGP SIGNATURE-----

--Sig_/vzgSiKzT65deR/2hqzg97nO--
