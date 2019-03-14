Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC52C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFD421872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552580883;
	bh=3LkVU86POFkXsQsPt6DdCZREg1GjwDPJs9azIEV2mIY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iOB5tfiSvUazvyXQkiVYnRrOBI+CKqcgr+8P6Lo17g066MpBKG1ObO4zYCeWE2GZ+
	 TpMrBNBRIW/xA26+D+znj/6u/dG801gd5RN8n/SBiv36EjL4iYSFwD7dTe7irzz64X
	 yXMLZPtTTkyTBLS58CkNvxpHEyoez/B6B6AD9YQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfCNQ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfCNQ17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:27:59 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2687721872;
        Thu, 14 Mar 2019 16:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552580877;
        bh=3LkVU86POFkXsQsPt6DdCZREg1GjwDPJs9azIEV2mIY=;
        h=Date:From:To:Cc:Subject:From;
        b=NIiJg9Fe38myy+I5mkgHW0p0j1Cizv+z/CUjjNBorXoUebe+BdxXwox8aOHercoDM
         TeKAlCnzRh1chu9szwRUF4kOw2oH5pxMQGYVQrRbB/e7EBMisaUA2sr/Wg+pw4DAmz
         Ju+DEBDzrXj+oJpAtDTr++7/99fRnPeWJYntWR5Q=
Date:   Thu, 14 Mar 2019 09:27:56 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.2
Message-ID: <20190314162756.GA20704@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 5.0.2 kernel.

All users of the 5.0 kernel series must upgrade.

The updated 5.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-5.0.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                          |    2=20
 arch/arm/boot/dts/exynos3250.dtsi                 |    3=20
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi   |   13 -
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi     |    2=20
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts    |    2=20
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts |    1=20
 arch/x86/events/core.c                            |   13 -
 arch/x86/events/intel/core.c                      |  154 ++++++++++++++----
 arch/x86/events/perf_event.h                      |   17 +-
 arch/x86/include/asm/cpufeatures.h                |    1=20
 arch/x86/include/asm/msr-index.h                  |    6=20
 arch/x86/pci/fixup.c                              |   16 +
 drivers/firmware/iscsi_ibft.c                     |    1=20
 drivers/input/mouse/elan_i2c_core.c               |    1=20
 drivers/input/tablet/wacom_serial4.c              |    2=20
 drivers/media/rc/rc-main.c                        |   13 +
 drivers/media/usb/uvc/uvc_driver.c                |   14 +
 drivers/net/wireless/ath/ath9k/init.c             |    6=20
 drivers/pci/pcie/pme.c                            |   27 ---
 drivers/scsi/aacraid/commsup.c                    |    5=20
 drivers/staging/erofs/namei.c                     |  183 +++++++++++------=
-----
 drivers/staging/erofs/unzip_vle.c                 |   38 ++--
 drivers/staging/erofs/unzip_vle.h                 |    3=20
 drivers/staging/erofs/unzip_vle_lz4.c             |   19 --
 fs/gfs2/glock.c                                   |    2=20
 include/drm/drm_cache.h                           |   18 ++
 net/core/skmsg.c                                  |    1=20
 scripts/gdb/linux/constants.py.in                 |   12 -
 scripts/gdb/linux/proc.py                         |   12 -
 29 files changed, 365 insertions(+), 222 deletions(-)

Alexander Shishkin (1):
      x86/PCI: Fixup RTIT_BAR of Intel Denverton Trace Hub

Alistair Strachan (2):
      media: uvcvideo: Fix 'type' check leading to overflow
      arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"

Andreas Gruenbacher (1):
      gfs2: Fix missed wakeups in find_insert_glock

Ard Biesheuvel (1):
      drm: disable uncached DMA optimization for ARM and arm64

Daniel F. Dickinson (1):
      ath9k: Avoid OF no-EEPROM quirks without qca,no-eeprom

Gao Xiang (2):
      staging: erofs: keep corrupted fs from crashing kernel in erofs_namei=
()
      staging: erofs: compressed_pages should not be accessed again after f=
reed

Greg Kroah-Hartman (1):
      Linux 5.0.2

Gustavo A. R. Silva (2):
      iscsi_ibft: Fix missing break in switch statement
      scsi: aacraid: Fix missing break in switch statement

Jackie Liu (1):
      scripts/gdb: replace flags (MS_xyz -> SB_xyz)

Jakub Sitnicki (1):
      bpf: Stop the psock parser before canceling its work

Jan Kiszka (2):
      arm64: dts: zcu100-revC: Give wifi some time after power-on
      arm64: dts: hikey: Give wifi some time after power-on

Jason Gerecke (1):
      Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Marek Szyprowski (3):
      ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid=
 X2/U3
      ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU
      ARM: dts: exynos: Fix max voltage for buck8 regulator on Odroid XU3/X=
U4

Mika Westerberg (1):
      Revert "PCI/PME: Implement runtime PM callbacks"

Peter Zijlstra (Intel) (4):
      perf/x86/intel: Make cpuc allocations consistent
      perf/x86/intel: Generalize dynamic constraint creation
      x86: Add TSX Force Abort CPUID/MSR
      perf/x86/intel: Implement support for TSX Force Abort

Sean Young (1):
      media: Revert "media: rc: some events are dropped by userspace"

Vincent Batts (1):
      Input: elan_i2c - add id for touchpad found in Lenovo s21e-20


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyKgQwACgkQONu9yGCS
aT68hA//ctFv7tiNc6F/hZ+eX4OQIiDup9QcdCjNpDdgleV2Y+P53u8yggC8UVZU
+FSobF34pZUXyw1+AksRZHmTYbzqxBGGPJNcs/gR4pZ13fRUdz6fsf+Foj34rVEd
07lOfumwXjTYUTU+ecnoUB/DZLHkFPtk/wBeOhE/6jl9aMCA9TlWEWi25DfvmDaj
C1lYGS85qqiSYv5OOpefTJ4y7wwZA7l0El/UGgdqMfhdD2hIZaVRzmXUf2AgeYnL
HtAJXaNmX0LeUCDbG6CE9l3smNQcjDdS9OM81hVfYSaonpthm+3wQAlg1GZ0pJz1
/ebhpQo3TYfn/IQAOdeCTDeiSyYbNut9hCgXxx/o38x/rL20fg+dQIca14+Uql+5
11aay6Mx5ZtErqZLbVEE1GUhuL/iff/bzojD0m4qLjlDu0msHg8V4yk0QpOQAToA
k9n9wL0u9zSKlL9jXs8F7wvyA5QJyzjiXAhOPjVRiVZrPIRz80iifgUM605pOkbQ
7yzWdBeTZF4GFSPvOGtE+4PtZd4YgVvvknZ/sGye25aLRh8KJBXp5wGGmD5jqkcj
VQEihJTzw9kQEB1Y+wKUtEgawup0l3ALi/GJZZ36ylT+DLqxqj92Zpam3e9NXLBR
SmpztnoZh5omWZb1zhGZ7naaTCIhK91EzTAu2R56kwI5E5l/KRs=
=TYpQ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
