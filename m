Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591A6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E43F2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551864180;
	bh=eo/XRTCu3mGL3b2htQYUTujWjZltA7MQ9tnC4uJRfvc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hGdB3hOwU+ozVTZ3Qo6Ka1RtUgr4Wb41t2WT/eQyQBclGIDXmT6slGgo2g7i2GbuT
	 dqUtpTU9grRgATBHnT6gYAVdqrSGvtjqciw5252GQdC/DRr4tPPWridUQ1Ss/JaC+S
	 yqOdVdXdsWXKJLorqsjn23h4Nw/zcuWJFBFd/RLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfCFJW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfCFJW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:22:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45CA7206DD;
        Wed,  6 Mar 2019 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551864176;
        bh=eo/XRTCu3mGL3b2htQYUTujWjZltA7MQ9tnC4uJRfvc=;
        h=Date:From:To:Cc:Subject:From;
        b=t4k3iLBwru62/OSDvnEK5BH9gnqw4Ul2Mor6TIj6HUVEpLdWIX8j/L1GD005ZZOAj
         x4+0YyJP8boGNHK2+CRnTGluT4F6gVsxtGau0qNDOwULyQ+OLC1zy7RiMo8gyi4QOM
         /jmnQl8+GU/Ch+cUsZQundBZOFKZpCuS8IA+Z57Q=
Date:   Wed, 6 Mar 2019 10:22:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.162
Message-ID: <20190306092254.GA29122@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.162 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                   |    2=20
 arch/arc/include/asm/bitops.h                              |    6 -
 arch/powerpc/include/asm/epapr_hcalls.h                    |   12 +--
 arch/x86/include/asm/uaccess.h                             |    7 +
 arch/x86/kvm/svm.c                                         |   27 +++----
 drivers/block/loop.c                                       |   47 ++++++--=
-----
 drivers/gpu/drm/msm/msm_rd.c                               |    7 +
 drivers/mmc/host/mmc_spi.c                                 |    1=20
 drivers/net/ethernet/altera/altera_tse_main.c              |    4 -
 drivers/net/ethernet/ibm/ibmveth.c                         |    2=20
 drivers/net/usb/asix_devices.c                             |    9 +-
 drivers/scsi/csiostor/csio_attr.c                          |    2=20
 drivers/scsi/libsas/sas_expander.c                         |    2=20
 drivers/thermal/int340x_thermal/processor_thermal_device.c |   30 ++++----
 drivers/tty/serial/fsl_lpuart.c                            |    2=20
 drivers/usb/dwc3/gadget.c                                  |    3=20
 drivers/usb/gadget/function/f_sourcesink.c                 |    2=20
 fs/direct-io.c                                             |    5 -
 kernel/locking/rwsem-xadd.c                                |   11 ++-
 mm/mmap.c                                                  |    7 -
 net/mac80211/cfg.c                                         |    4 +
 net/mac80211/rx.c                                          |    6 +
 net/wireless/reg.c                                         |    4 -
 sound/core/compress_offload.c                              |    3=20
 sound/soc/fsl/imx-audmux.c                                 |   24 +++---
 sound/soc/intel/boards/broadwell.c                         |    2=20
 sound/soc/intel/boards/haswell.c                           |    2=20
 sound/soc/soc-dapm.c                                       |   10 +-
 28 files changed, 138 insertions(+), 105 deletions(-)

Aaron Hill (1):
      drivers: thermal: int340x_thermal: Fix sysfs race condition

Andy Lutomirski (1):
      x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

Atsushi Nemoto (1):
      net: altera_tse: fix connect_local_phy error path

Balaji Pothunoori (1):
      mac80211: don't initiate TDLS connection if station is not associated=
 to AP

Bo He (1):
      usb: dwc3: gadget: synchronize_irq dwc irq in suspend

Bob Copeland (1):
      mac80211: fix miscounting of ttl-dropped frames

Chaitanya Tata (1):
      cfg80211: extend range deviation for DMG

Dan Carpenter (3):
      ALSA: compress: prevent potential divide by zero bugs
      thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
      usb: gadget: Potential NULL dereference on allocation error

Ernesto A. Fern=E1ndez (1):
      direct-io: allow direct writes to empty inodes

Eugeniy Paltsev (1):
      ARC: fix __ffs return value to avoid build warnings

Greg Kroah-Hartman (4):
      Revert "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_contro=
l_ioctl()"
      Revert "loop: Get rid of loop_index_mutex"
      Revert "loop: Fold __loop_release into loop_release"
      Linux 4.9.162

Jann Horn (1):
      mm: enforce min addr even if capable() in expand_downwards()

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attac=
hed

Jonathan Neusch=E4fer (1):
      mmc: spi: Fix card detection during probe

Kristian H. Kristensen (1):
      drm/msm: Unblock writer if reader closes file

Mathieu Malaterre (1):
      mac80211: Add attribute aligned(2) to struct 'action'

Rander Wang (1):
      ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Seth Forshee (1):
      powerpc: Always initialize input array when calling epapr_hypercall()

Silvio Cesare (2):
      ASoC: dapm: change snprintf to scnprintf for possible overflow
      ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Suravee Suthikulpanit (1):
      svm: Fix AVIC incomplete IPI emulation

Thomas Falcon (1):
      ibmveth: Do not process frames after calling napi_reschedule

Tomonori Sakita (1):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampli=
ng

Varun Prakash (1):
      scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Vitaly Kuznetsov (1):
      KVM: nSVM: clear events pending from svm_complete_interrupts() when e=
xiting to L1

Xie Yongji (1):
      locking/rwsem: Fix (possible) missed wakeup

Zeng Tao (1):
      usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Zhang Run (1):
      net: usb: asix: ax88772_bind return error when hw_reset fail


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlx/kWsACgkQONu9yGCS
aT7pdA//arM6z0wCVNqGiRP6Kjb6ssbmnN2WivvEuxSqEJ3Y5af6IE0MEgiNBlqR
XX+seY6YMGg9HaQWw37Iz1X88c2R0Coylk5ocKJvgLsAWnUUKmrosBLSz2lcSiQj
GEYqv4+KWDBgxspGOdHiMrcvXFk58ZJzK4arNC2Rh+n/Nwwgcp6vAEJ1h+lm0LZR
VP76u16KRpkpHRZLyMEfG+iv8pkA/RFfaEJP3KD36XirOoSjWuHk+92mKTTXZgUh
jklBo/xnk68bPsR9VDOr8bPNigHG8Wgw/n6B2ZOljFuo2OG+8uI0FRdE+XpULpdb
hjJBbYPh+sJzo1Yt6eKGV2G6fvZ/P0WCcNfAkyL1ZtYgNYLf8BrjBBK6N7X64f4n
cv4Fl+1MgLDeez/Rr29CaSRjAgDOIh89sQDWlMr0xGUBU1qNI52XpYV73CuXt3UH
sM2D/VIxafaYoaKlAyyQbGKSFl5+uVpfPopF21P7pC52n5UYemMaIbYIU/fDWRFV
KtVeUo5FqHfjT4U1/EyN9JsrEEf2STyC2jBBXm8urAAGBiaZ0YcP8uoM8uURVO0A
oXciY7H7Q0vxzme2dxSeFW/0a3tvfh8cYszFywPEcSCxwlC2ffNjOYr1MscZQ023
4FUsg6o28EU5PAYbpHELdCQHsXrzsfTyDt/AV3w60Pk68X7JFTE=
=9OeY
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
