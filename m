Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AC82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711419;
	bh=4wpS7aCtDJ+C/Gp+xfyCDQZzpBcqudvMIL44bqPyvBc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ek+nk5kiihWYWq9rdkrA/QEWNiS6DySju2rI1/HRLkUwFHMbeDM474U2DyqmCxR9y
	 xDKOH4twsCmb7mea02XQmFUk3dfyv+AwPIFVgLzlWNF5MggkzqirF41POQ0aw/xE1X
	 fBGr1dczhVQQ0W6N3V0V9YKImtqd+WLLc2pLc2Pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391743AbfC0SaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387691AbfC0S0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:14 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145FD21850;
        Wed, 27 Mar 2019 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711173;
        bh=4wpS7aCtDJ+C/Gp+xfyCDQZzpBcqudvMIL44bqPyvBc=;
        h=Date:From:To:Cc:Subject:From;
        b=xPMY+M3Xv483q9JOS2gaxz2EQL9OIX2I6wjQ/V2fMSkyQ38A55ls9IghK619JkgrS
         UBMhHrurzBREFViEL756TqVk04HVfTw2M2+FWwPWFCVKIi6AckfLKqfFQpnhwLl6Yp
         IP+f4VtD1m+kwjEFuJ/VlWZ2qWVcZocRV/S1aqq0=
Date:   Wed, 27 Mar 2019 23:57:40 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.32
Message-ID: <20190327145740.GA8072@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.32 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                      |    2=20
 arch/mips/include/asm/jump_label.h            |    8 -
 arch/mips/kernel/vmlinux.lds.S                |   12 +-
 arch/mips/loongson64/lemote-2f/irq.c          |    2=20
 arch/powerpc/include/asm/vdso_datapage.h      |    8 -
 arch/powerpc/kernel/vdso64/gettimeofday.S     |    4=20
 arch/x86/include/asm/unwind.h                 |    6 +
 arch/x86/kernel/unwind_frame.c                |   25 ++++
 arch/x86/kernel/unwind_orc.c                  |   17 +++
 drivers/block/loop.c                          |    2=20
 drivers/bluetooth/h4_recv.h                   |    4=20
 drivers/bluetooth/hci_h4.c                    |    4=20
 drivers/bluetooth/hci_ldisc.c                 |   24 ++--
 drivers/gpu/drm/drm_mode_object.c             |    5=20
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c            |   12 --
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |    2=20
 drivers/infiniband/core/cma.c                 |   13 ++
 drivers/iommu/amd_iommu.c                     |    7 +
 drivers/irqchip/irq-gic-v3-its.c              |    2=20
 drivers/media/usb/uvc/uvc_ctrl.c              |    2=20
 drivers/media/v4l2-core/v4l2-ctrls.c          |    2=20
 drivers/mmc/host/mxcmmc.c                     |   16 ---
 drivers/mmc/host/pxamci.c                     |    2=20
 drivers/mmc/host/renesas_sdhi_core.c          |    8 +
 drivers/power/supply/charger-manager.c        |    3=20
 drivers/scsi/ibmvscsi/ibmvscsi.c              |   23 +++-
 fs/cifs/smb2pdu.c                             |   11 +-
 fs/ext4/ext4_jbd2.h                           |    2=20
 fs/ext4/file.c                                |    2=20
 fs/ext4/indirect.c                            |   12 +-
 fs/f2fs/segment.c                             |   43 ++++++--
 fs/udf/truncate.c                             |    3=20
 include/linux/ceph/libceph.h                  |    2=20
 kernel/futex.c                                |    4=20
 kernel/locking/lockdep.c                      |    3=20
 net/bluetooth/hci_sock.c                      |    3=20
 net/bridge/netfilter/ebtables.c               |  131 +++++++--------------=
-----
 net/ceph/ceph_common.c                        |   18 +++
 net/ceph/mon_client.c                         |    9 +
 sound/ac97/bus.c                              |    2=20
 sound/firewire/motu/motu.c                    |   20 +--
 sound/pci/hda/hda_codec.c                     |   57 ++++++++++-
 sound/pci/hda/hda_intel.c                     |    6 -
 sound/pci/hda/patch_ca0132.c                  |    2=20
 sound/x86/intel_hdmi_audio.c                  |    1=20
 tools/objtool/check.c                         |    3=20
 tools/perf/util/probe-event.c                 |    6 -
 47 files changed, 353 insertions(+), 202 deletions(-)

Adrian Hunter (1):
      perf probe: Fix getting the kernel map

Alexander Shiyan (1):
      mmc: mxcmmc: "Revert mmc: mxcmmc: handle highmem pages"

Archer Yan (1):
      MIPS: Fix kernel crash for R6 in jump label branch function

Arnd Bergmann (2):
      mmc: pxamci: fix enum type confusion
      ALSA: hda/ca0132 - make pci_iounmap() call conditional

Baolin Wang (1):
      power: supply: charger-manager: Fix incorrect return value

Chao Yu (1):
      f2fs: fix to avoid deadlock of atomic file operations

Chen Jie (1):
      futex: Ensure that futex address is aligned in handle_futex_death()

Chris Wilson (1):
      drm: Reorder set_property_atomic to avoid returning with an active ww=
_ctx

Deepak Rawat (1):
      drm/vmwgfx: Return 0 when gmrid::get_node runs out of ID's

Dongli Zhang (1):
      loop: access lo_backing_file only when the loop device is Lo_bound

Florian Westphal (1):
      netfilter: ebtables: remove BUGPRINT messages

Greg Kroah-Hartman (1):
      Linux 4.19.32

Hans Verkuil (1):
      media: v4l2-ctrls.c/uvc: zero v4l2_event

Hui Wang (1):
      ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec

Ilya Dryomov (1):
      libceph: wait for latest osdmap in ceph_monc_blacklist_add()

Jan Kara (1):
      udf: Fix crash on IO error during truncate

Jann Horn (2):
      x86/unwind: Handle NULL pointer calls better in frame unwinder
      x86/unwind: Add hardcoded ORC entry for NULL

Jaroslav Kysela (1):
      ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist

Jeremy Cline (1):
      Bluetooth: hci_ldisc: Initialize hci_dev before open()

Jiufei Xue (1):
      ext4: fix NULL pointer dereference while journal is aborted

Josh Poimboeuf (1):
      objtool: Move objtool_file struct off the stack

Kefeng Wang (1):
      Bluetooth: hci_ldisc: Postpone HCI_UART_PROTO_READY bit set in hci_ua=
rt_set_proto()

Lukas Czerner (1):
      ext4: fix data corruption caused by unaligned direct AIO

Michael Ellerman (1):
      powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038

Myungho Jung (3):
      Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf=
()
      Bluetooth: Fix decrementing reference count twice in releasing socket
      RDMA/cma: Rollback source IP address if failing to acquire device

Rasmus Villemoes (1):
      irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp

Ronnie Sahlberg (1):
      cifs: allow guest mounts to work for smb3.11

Stanislaw Gruszka (1):
      iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE

Steve French (1):
      SMB3: Fix SMB3.1.1 guest mounts to Samba

Takashi Iwai (2):
      ALSA: ac97: Fix of-node refcount unbalance
      ALSA: hda - Record the current power state before suspend/resume calls

Takashi Sakamoto (1):
      ALSA: firewire-motu: use 'version' field of unit directory to identif=
y model

Thomas Zimmermann (1):
      drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Tyrel Datwyler (2):
      scsi: ibmvscsi: Protect ibmvscsi_head from concurrent modificaiton
      scsi: ibmvscsi: Fix empty event pool access during host removal

Ville Syrj=E4l=E4 (1):
      ALSA: x86: Fix runtime PM for hdmi-lpe-audio

Waiman Long (1):
      locking/lockdep: Add debug_locks check in __lock_downgrade()

Wolfram Sang (1):
      mmc: renesas_sdhi: limit block count to 16 bit for old revisions

Yasha Cherikovsky (1):
      MIPS: Ensure ELF appended dtb is relocated

Yifeng Li (1):
      mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqacti=
on.

zhangyi (F) (1):
      ext4: brelse all indirect buffer in ext4_ind_remove_space()


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlybj2QACgkQONu9yGCS
aT4MiA/+IJ7JZ6fk3zkUZ4xEOvUCa969ejrx1fp4Oh0+CpO2Z+qRIPB97WK8KfTq
d3473RfpB8E3fdMTI6hYCLzFpLOhhIdU8TR+dPPkhdaulJwEIMkIeTlD9i6JcrKO
RBGlnzqsAbWC4qkfsld4qiLO467MLHnlUngc44Gw7eHmqeXb/glzGATqY8SWHkCq
j5HRqACdy8wU1Zte1NbTizxJHCkjSMHfUSP0FCYKy9V8H4rIxWYNi7T4zO8HcvRN
4Et2l2y160P50dqan4VFGyVJ5aqMNmWrLViHCVe3q0oqiAYomHsmuQ8a6l9X1TSS
ubUQxqHWidPQ4Rd3fbpEnF3eBC+6MbeUW51LvxWwk942sjSqLtNw4PDyjwuaHymD
P2GMnSSSaB1EMGXuWtUK13xyCVocNJJmSOWzsyX50vS+SbzN96Jz4lNOSiaMkaPp
lFY8ISs/YdtkfEYo4ih8WZhALqpTyewhAzQnkxyOBXw3QVGHJhHm8oZ/mV5AXfrB
xepvbwamFBEgh/Vfk9SLceh7ZX80/6EoSReZeKkENtGdYEP9A7cnvcnlwW0/+8JG
Now+pfigko1MiaLFBlHn0Q8MCVT1FHob8GoRpF9MP9eQgHQRxg0D4wLFrXANZR/h
3Zb3Wqrjd4P6VbvEz9LxtYQHMOa/heuwJt4dPrKfwEWqdRp5DZs=
=5Ff+
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
