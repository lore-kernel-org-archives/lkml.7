Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D6AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED58021734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711183;
	bh=Hr5fvW4qF6e3AsBePJxkA5K50WFrR1urH+x4VoQhlH4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OcdAbpNJmWIQFsKcLvftPId5MPqwKFAdQCaoGIvUSYyHAfPw3ngQUeKWCb5RgZ1Xh
	 ST/W0P8lgXXjsqFaRceNqH2FxqOQYywKum05l1dpYgiD6DDnMgKGohw0qxIylejl/i
	 S+oC2GG4QbepniKA2lzt7CFVvRmNcN7pAfDfnVOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404090AbfC0S0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391630AbfC0S0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:03 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196EB2063F;
        Wed, 27 Mar 2019 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711161;
        bh=Hr5fvW4qF6e3AsBePJxkA5K50WFrR1urH+x4VoQhlH4=;
        h=Date:From:To:Cc:Subject:From;
        b=qt10nJ4nqTUJa29toLxr3H1pgQxTZIoVjNazLGF14rgM/2j3Z9E00/8QeG4/wnda6
         XzEzdx/CKOKNoAQt5m7NS8GE7bZBV3/k1S6BYhbjMoGlkTdbt1A3VLI8O4md8fvJWy
         0bQU5kAd6XFeYzNKyOGxPblIjZYReKPlx4tND7bg=
Date:   Wed, 27 Mar 2019 23:57:05 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.166
Message-ID: <20190327145705.GA7990@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.9.166 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                               |    2 -
 arch/arm64/kernel/traps.c              |    8 +++-
 arch/mips/include/asm/jump_label.h     |    8 ++--
 arch/mips/kernel/vmlinux.lds.S         |   12 ++++--
 arch/mips/loongson64/lemote-2f/irq.c   |    2 -
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c     |   12 +-----
 drivers/iommu/amd_iommu.c              |    7 +++-
 drivers/media/usb/uvc/uvc_ctrl.c       |    2 -
 drivers/media/v4l2-core/v4l2-ctrls.c   |    2 -
 drivers/mmc/host/pxamci.c              |    2 -
 drivers/net/wireless/ath/ath10k/wmi.c  |    2 -
 drivers/power/supply/charger-manager.c |    3 -
 drivers/rtc/rtc-lib.c                  |    6 +--
 drivers/scsi/ufs/ufshcd.c              |   14 ++++----
 drivers/tty/serial/sprd_serial.c       |    6 ++-
 drivers/usb/core/config.c              |    9 +++--
 drivers/video/backlight/pwm_bl.c       |    9 ++---
 fs/dcache.c                            |   10 ++---
 fs/ext4/ext4_jbd2.h                    |    2 -
 fs/ext4/file.c                         |    2 -
 fs/ext4/indirect.c                     |   12 ++++--
 fs/udf/truncate.c                      |    3 +
 include/linux/ceph/libceph.h           |    2 +
 include/net/inet_connection_sock.h     |    5 --
 kernel/futex.c                         |    4 ++
 kernel/locking/lockdep.c               |    3 +
 lib/int_sqrt.c                         |    3 +
 net/bluetooth/hci_sock.c               |    3 -
 net/ceph/ceph_common.c                 |   18 +++++++++-
 net/ceph/mon_client.c                  |    9 +++++
 net/dccp/ipv4.c                        |    8 ----
 net/dccp/ipv6.c                        |    2 -
 net/ipv4/tcp_input.c                   |    8 ----
 sound/pci/hda/hda_codec.c              |   57 +++++++++++++++++++++++++++++++--
 tools/objtool/check.c                  |    3 +
 35 files changed, 174 insertions(+), 86 deletions(-)

Al Viro (1):
      Hang/soft lockup in d_invalidate with simultaneous calls

Andrey Konovalov (1):
      USB: core: only clean up what we allocated

Archer Yan (1):
      MIPS: Fix kernel crash for R6 in jump label branch function

Arnd Bergmann (2):
      mmc: pxamci: fix enum type confusion
      ath10k: avoid possible string overflow

Baolin Wang (2):
      rtc: Fix overflow when converting time64_t to rtc_time
      power: supply: charger-manager: Fix incorrect return value

Chen Jie (1):
      futex: Ensure that futex address is aligned in handle_futex_death()

Enric Balletbo i Serra (1):
      pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.

Eric Dumazet (1):
      tcp/dccp: drop SYN packets if accept queue is full

Greg Kroah-Hartman (1):
      Linux 4.9.166

Hans Verkuil (1):
      media: v4l2-ctrls.c/uvc: zero v4l2_event

Hui Wang (1):
      ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec

Ilya Dryomov (1):
      libceph: wait for latest osdmap in ceph_monc_blacklist_add()

Jan Kara (1):
      udf: Fix crash on IO error during truncate

Jiufei Xue (1):
      ext4: fix NULL pointer dereference while journal is aborted

Josh Poimboeuf (1):
      objtool: Move objtool_file struct off the stack

Lanqing Liu (1):
      serial: sprd: clear timeout interrupt only rather than all interrupts

Lukas Czerner (1):
      ext4: fix data corruption caused by unaligned direct AIO

Myungho Jung (1):
      Bluetooth: Fix decrementing reference count twice in releasing socket

Peter Zijlstra (1):
      lib/int_sqrt: optimize small argument

Qiao Zhou (1):
      arm64: traps: disable irq in die()

Stanislaw Gruszka (1):
      iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE

Takashi Iwai (1):
      ALSA: hda - Record the current power state before suspend/resume calls

Thomas Zimmermann (1):
      drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Waiman Long (1):
      locking/lockdep: Add debug_locks check in __lock_downgrade()

Wei Qiao (1):
      serial: sprd: adjust TIMEOUT to a big value

Yasha Cherikovsky (1):
      MIPS: Ensure ELF appended dtb is relocated

Yifeng Li (1):
      mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqaction.

kehuanlin (1):
      scsi: ufs: fix wrong command type of UTRD for UFSHCI v2.1

zhangyi (F) (1):
      ext4: brelse all indirect buffer in ext4_ind_remove_space()


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlybjz8ACgkQONu9yGCS
aT7ccQ/9GkVwQqeYcisVDBVntteuDBJNfHEgddh76l1eHhRzcgVwxrB9lI3Ya7Ca
c40+Xp3sxAXuzAe01RmWLr4r+Ms82qf7dU+drNjvzbL+Y3960u4rgKmSEJ6HSu7X
EtIqnLe54cSWkF+aUIHSNc0VPQ4+gFSJukGPPHRfODe7d/QFnVNPWsLmQEqXazvu
4Gu+qAJ9zbPrZnerQOAIKbKx7AdPJ7kSiq5rftZTcQTvBYKp9NbXXmBvCTC6CZ4J
h+mFB2IL8WGO0EFbo6+NwJw6RF4ZEFCSbB1dQ9PtjxQ/yc8Kow1b62k/Acx9IMlZ
4QU+9YwpbQ8b7/7fx7iEUQz+w1ChrsAE8k1yfdm0wu3CHAKqi2ZHnJ38YbSxZ1vn
/9CRJOndB8XyORUypcu8lIC6Y409x/e1CR/8O6VNfNIvChPDVB8aLL0SnzVNkik9
Fhp/UtdZtve/qLvVMS63wBQdkK6rWUhciUyWpvfV3lpY/Boi+mUvYUnxTtvs+phQ
v+7jn7sseiKsanuQ5GdTI/FqXAjV7DvjsFYpLctlxE6B3v/9/WLfpyRAIboZDyMI
5xHuvbZ3iUg7YeI2PbAuAQyJHi7jAE2rkQ9VtGyt/ckI3LmILbGBqE3BUNXRsyB4
/JrkOYhQyzk5VoR0Z0w7nZX/Dxzs4S4ic0zBRamoneEQXCSOVB0=
=qH8p
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
