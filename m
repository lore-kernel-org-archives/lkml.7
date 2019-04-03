Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E26C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98D7206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554280796;
	bh=iDz9YZKVxTuJHcdX5pFN0gZ3CfOaFK8rwIlbDK8jOt8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=womEbmgadzx1ySx+4lACdD9/oWOhkeI7vWwbZbsv6etG0Qb1GrTVkf7T5gY9fQcjx
	 ea335TnS88txoZSQdfaVxc50P6VJuJaBbPRw1rPwAbn6VwXsBP3FBT7snNXHrmHC3a
	 tUiEOYsctBrF+VoWxCqgYje43D3DZDcatpdQziCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfDCIjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfDCIjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:39:55 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060F0206B7;
        Wed,  3 Apr 2019 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554280793;
        bh=iDz9YZKVxTuJHcdX5pFN0gZ3CfOaFK8rwIlbDK8jOt8=;
        h=Date:From:To:Cc:Subject:From;
        b=0yWNL4fzKWYpNNcdmFywdvBIaLILQ8L+5g5DiD1fGJmxqiCtUaJaoS60RENoOTcaE
         1vMOGAfAmSe8bfcybyh4Z12exOWUorPzL6B0ZeSdI14Iq2amswK5LX82+Pinu7VNSI
         +bvMKqEILujXhiTgPj9q9Rcu93oPKTxJ1cmWi0uo=
Date:   Wed, 3 Apr 2019 10:39:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.138
Message-ID: <20190403083950.GA22484@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.138 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/virtual/kvm/api.txt               |   16 +++-
 Makefile                                        |    2=20
 arch/arm/Kconfig                                |    6 -
 arch/arm/mach-imx/cpuidle-imx6q.c               |   27 ++-----
 arch/arm64/Kconfig                              |    5 +
 arch/arm64/include/asm/page.h                   |    2=20
 arch/arm64/include/asm/shmparam.h               |    2=20
 arch/arm64/kernel/entry.S                       |    2=20
 drivers/gpio/gpio-adnp.c                        |    6 +
 drivers/isdn/hardware/mISDN/hfcmulti.c          |    3=20
 drivers/media/usb/uvc/uvc_ctrl.c                |    2=20
 drivers/media/v4l2-core/v4l2-ctrls.c            |    2=20
 drivers/mmc/card/block.c                        |    7 --
 drivers/mmc/core/mmc_ops.c                      |    2=20
 drivers/mmc/host/tmio_mmc_pio.c                 |    8 --
 drivers/net/ethernet/8390/mac8390.c             |   19 +++--
 drivers/s390/scsi/zfcp_erp.c                    |   14 ++++
 drivers/s390/scsi/zfcp_ext.h                    |    2=20
 drivers/s390/scsi/zfcp_scsi.c                   |    4 +
 drivers/staging/android/ashmem.c                |    4 -
 drivers/staging/android/ion/ion_carveout_heap.c |    2=20
 drivers/staging/android/sync.c                  |    6 -
 drivers/staging/android/uapi/ashmem.h           |    1=20
 drivers/staging/goldfish/goldfish_audio.c       |    1=20
 drivers/tty/serial/kgdboc.c                     |    4 -
 drivers/tty/serial/max310x.c                    |    2=20
 drivers/usb/gadget/configfs.c                   |    2=20
 drivers/usb/host/xhci-ring.c                    |    9 +-
 drivers/usb/host/xhci.h                         |    1=20
 drivers/usb/serial/cp210x.c                     |    1=20
 drivers/usb/serial/ftdi_sio.c                   |    2=20
 drivers/usb/serial/ftdi_sio_ids.h               |    4 -
 drivers/usb/serial/mos7720.c                    |    4 -
 drivers/video/fbdev/goldfishfb.c                |    2=20
 fs/ext4/ext4_jbd2.h                             |    2=20
 fs/ext4/file.c                                  |    2=20
 fs/ext4/indirect.c                              |   12 ++-
 fs/proc/proc_sysctl.c                           |    3=20
 fs/udf/truncate.c                               |    3=20
 include/asm-generic/fixmap.h                    |   12 +--
 include/linux/rculist.h                         |   36 ++++++++++
 include/net/sctp/checksum.h                     |    2=20
 include/net/sock.h                              |    6 +
 kernel/futex.c                                  |    4 +
 net/bluetooth/l2cap_core.c                      |   83 +++++++++++++++----=
-----
 net/dccp/ipv6.c                                 |    4 -
 net/ipv6/icmp.c                                 |    2=20
 net/ipv6/tcp_ipv6.c                             |    8 +-
 net/packet/af_packet.c                          |    4 -
 net/rose/rose_subr.c                            |   21 +++---
 net/wireless/nl80211.c                          |   16 ++--
 sound/core/oss/pcm_oss.c                        |   43 ++++++------
 sound/core/pcm_native.c                         |    9 ++
 virt/kvm/kvm_main.c                             |    3=20
 54 files changed, 292 insertions(+), 159 deletions(-)

Aditya Pakki (1):
      serial: max310x: Fix to avoid potential NULL pointer dereference

Ard Biesheuvel (1):
      arm64/kernel: fix incorrect EL0 check in inv_entry macro

Arnd Bergmann (1):
      ARM: 8458/1: bL_switcher: add GIC dependency

Axel Lin (1):
      gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

Bjorn Helgaas (1):
      mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Chaotian Jing (1):
      mmc: mmc: fix switch timeout issue caused by jiffies precision

Chen Jie (1):
      futex: Ensure that futex address is aligned in handle_futex_death()

Christoffer Dall (1):
      video: fbdev: Set pixclock =3D 0 in goldfishfb

Christoph Paasch (1):
      net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Colin Cross (1):
      mmc: block: Allow more than 8 partitions per card

David S. Miller (1):
      Add hlist_add_tail_rcu() (Merge git://git.kernel.org/.../davem/net)

Dmitry Torokhov (1):
      android: unconditionally remove callbacks in sync_fence_free()

Eric Biggers (1):
      arm64: support keyctl() system call in 32-bit mode

Eric Dumazet (3):
      dccp: do not use ipv6 header for ipv4 flow
      net: rose: fix a possible stack overflow
      tcp: do not use ipv6 header for ipv4 flow

Ezequiel Garcia (1):
      arm64: kconfig: drop CONFIG_RTC_LIB dependency

Finn Thain (1):
      mac8390: Fix mmio access size probe

George McCollister (1):
      USB: serial: ftdi_sio: add additional NovaTech products

Greg Hackmann (1):
      staging: goldfish: audio: fix compiliation on arm

Greg Kroah-Hartman (2):
      USB: serial: cp210x: add new device id
      Linux 3.18.138

Hannes Frederic Sowa (1):
      ipv6: fix endianness error in icmpv6_err

Hans Verkuil (1):
      media: v4l2-ctrls.c/uvc: zero v4l2_event

James Morse (1):
      arm64: kernel: Include _AC definition in page.h

Jan Kara (1):
      udf: Fix crash on IO error during truncate

Jiufei Xue (1):
      ext4: fix NULL pointer dereference while journal is aborted

Johannes Berg (1):
      cfg80211: size various nl80211 messages correctly

Kohji Okuno (1):
      ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected t=
ime

Laura Abbott (1):
      staging: ashmem: Avoid deadlock with mmap/shrink

Lin Yi (1):
      USB: serial: mos7720: fix mos_parport refcount imbalance on error path

Lorenzo Pieralisi (1):
      ARM: 8510/1: rework ARM_CPU_SUSPEND dependencies

Lukas Czerner (1):
      ext4: fix data corruption caused by unaligned direct AIO

Marcel Holtmann (2):
      Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt
      Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Mark Rutland (1):
      asm-generic: Fix local variable shadow in __set_fixmap_offset

Mathias Nyman (1):
      xhci: Fix port resume done detection for SS ports with LPM enabled

Maxime Chevallier (1):
      packets: Always register packet sk in the same order

Rajmal Menariya (1):
      staging: ion: Set minimum carveout heap allocation order to PAGE_SHIFT

Rom Lemarchand (1):
      staging: ashmem: Add missing include

Sean Christopherson (1):
      KVM: Reject device ioctls from processes other than the VM's creator

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts

Steffen Maier (1):
      scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV =
FCP devices

Takashi Iwai (2):
      ALSA: pcm: Fix possible OOB access in PCM oss plugins
      ALSA: pcm: Don't suspend stream in unrecoverable PCM state

Wentao Wang (1):
      Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/=
kgdboc

Winter Wang (1):
      usb: gadget: configfs: add mutex lock before unregister gadget

Xin Long (1):
      sctp: get sctphdr by offset in sctp_compute_cksum

YueHaibing (1):
      fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Yury Norov (1):
      arm64: fix COMPAT_SHMLBA definition for large pages

zhangyi (F) (1):
      ext4: brelse all indirect buffer in ext4_ind_remove_space()


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlykcVQACgkQONu9yGCS
aT4qlA/+L21Me4ezOTMy3q74BvNpREiVCVMwY8+Tzn37/N9aUaMLj2PrfTuH8PRR
mfVlbgDB1xsJcEZ5FFR8hOZwTSW4I2hYVbTsIOrkngEwT8kkLL+xHXM2Rhb824rk
HOrD6rvDedkFxAGwRN/6f8iwHRkhZ+RHtF+hLVTUQxVXhSYT+bNTxUa5Yp8J6e9F
Bc7cVOoGBENGRz6QkbzlYcU0sH5E8j1TwpIMsFjoTRnZQAYR98KsW3NmAg8clOid
GDFhGap71yAEqguv0cP9h66dHNNkVYRlOprTFFIPeU3Dj27Xufz39oC9BG9DYBhQ
3zzChv9nnMswmfPj3p2A7eEte387MzJ545kMq6jnbiais5mZq5ZbKWRxYIZdameM
xsyNodsSGNzU8jUYVNc6K0y8n8Qmbee/BLsXluQTLm17O7g52Tbwt4olL8PV73bI
IoZ77+FeZ+jnDcNy9A6SzVmcnAwJHXe/5LoxVmkX3MKq3pfzopPy1IuStP/kPaWz
sQp0BipOaEk6Z8hwTAgaWoeqJfkvrO9Paubhlrn0tc+jH4qwd/61h9rHSt0TFzMf
E+GmygIK5gGNL2P3CPGoyWJl+dNNW4imPf6/br1qoY8yHESjY+XIfI/mA2aBkCxG
4YBZQjfUt9lhqBFgIZBqFaCCrVRGXkAiRGrDQH7jl+gIn4Utz/M=
=eU3a
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
