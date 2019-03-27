Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44891C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1142147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711365;
	bh=4ISOc76UY+jP512zmxAG+RzBiF9GYusv/lmOIq1AP30=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Q0GZxb2W5Kllm1LjBqhKZ+S/Qpha9PPgnrrYQS0e+lZ48syKUN8H0Hnh8Hy3mtHKf
	 qFBMjS2Q4oOhK7a1fxNWHai9KxgyBeaL0FPZCvZ8Z/NNOHSGkazNh3wPT3IDvbmrrE
	 lenWzK33Ei6CrQ+D0+fHQ5HYfd0/tp6AFukUwJ+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391955AbfC0S3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391140AbfC0S0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:20 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750EC2070B;
        Wed, 27 Mar 2019 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711180;
        bh=4ISOc76UY+jP512zmxAG+RzBiF9GYusv/lmOIq1AP30=;
        h=Date:From:To:Cc:Subject:From;
        b=G2OFUbmMADAAsZDL3jF3cchbe8TrjD66yq7nSWb+Noh6QqvDi3OJ3hPg9MmG8b0s4
         7JjKt7ALCNKoT7brHCBW5BvUbpknLLwDOrdHWz9PHsYGqvRB9Qb30iVRFybAlFuZZn
         N5LDGwMIRXWSJTdKgCk9Oi73sd9m25O/bk4uWyb8=
Date:   Wed, 27 Mar 2019 23:58:02 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.5
Message-ID: <20190327145802.GA8107@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 5.0.5 kernel.

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

 Makefile                                      |    2=20
 arch/mips/include/asm/jump_label.h            |    8 -
 arch/mips/kernel/vmlinux.lds.S                |   12 +-
 arch/mips/loongson64/lemote-2f/irq.c          |    2=20
 arch/powerpc/include/asm/vdso_datapage.h      |    8 -
 arch/powerpc/kernel/security.c                |   23 +---
 arch/powerpc/kernel/vdso64/gettimeofday.S     |    4=20
 arch/x86/include/asm/unwind.h                 |    6 +
 arch/x86/kernel/unwind_frame.c                |   25 ++++
 arch/x86/kernel/unwind_orc.c                  |   17 +++
 drivers/block/loop.c                          |    2=20
 drivers/bluetooth/h4_recv.h                   |    4=20
 drivers/bluetooth/hci_h4.c                    |    4=20
 drivers/bluetooth/hci_ldisc.c                 |   24 ++--
 drivers/clocksource/timer-riscv.c             |    5=20
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    2=20
 drivers/gpu/drm/vkms/vkms_crtc.c              |    1=20
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c            |   12 --
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |    2=20
 drivers/infiniband/core/cma.c                 |   13 ++
 drivers/iommu/amd_iommu.c                     |    7 +
 drivers/iommu/iova.c                          |    5=20
 drivers/irqchip/irq-gic-v3-its.c              |    2=20
 drivers/media/usb/uvc/uvc_ctrl.c              |    2=20
 drivers/media/v4l2-core/v4l2-ctrls.c          |    2=20
 drivers/mmc/host/alcor.c                      |   25 +++-
 drivers/mmc/host/mxcmmc.c                     |   16 ---
 drivers/mmc/host/pxamci.c                     |    2=20
 drivers/mmc/host/renesas_sdhi_core.c          |    8 +
 drivers/net/ethernet/mellanox/mlx5/core/qp.c  |   66 +++++++------
 drivers/scsi/ibmvscsi/ibmvscsi.c              |   23 +++-
 drivers/scsi/qla2xxx/qla_init.c               |    7 +
 drivers/scsi/scsi_lib.c                       |    6 -
 fs/aio.c                                      |   72 +++++---------
 fs/cifs/smb2pdu.c                             |   11 +-
 fs/ext4/ext4_jbd2.h                           |    2=20
 fs/ext4/file.c                                |    2=20
 fs/ext4/indirect.c                            |   12 +-
 fs/f2fs/segment.c                             |   43 ++++++--
 fs/udf/truncate.c                             |    3=20
 include/linux/ceph/libceph.h                  |    2=20
 include/linux/fs.h                            |    8 +
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
 sound/pci/hda/hda_intel.c                     |   14 +-
 tools/objtool/check.c                         |    3=20
 tools/perf/util/probe-event.c                 |    6 -
 54 files changed, 469 insertions(+), 303 deletions(-)

Adrian Hunter (1):
      perf probe: Fix getting the kernel map

Alexander Shiyan (1):
      mmc: mxcmmc: "Revert mmc: mxcmmc: handle highmem pages"

Archer Yan (1):
      MIPS: Fix kernel crash for R6 in jump label branch function

Arnd Bergmann (1):
      mmc: pxamci: fix enum type confusion

Atish Patra (1):
      clocksource/drivers/riscv: Fix clocksource mask

Bart Van Assche (1):
      scsi: core: Avoid that a kernel warning appears during system resume

Chao Yu (1):
      f2fs: fix to avoid deadlock of atomic file operations

Chen Jie (1):
      futex: Ensure that futex address is aligned in handle_futex_death()

Christian K=F6nig (1):
      drm/amdgpu: fix invalid use of change_bit

Daniel Drake (1):
      mmc: alcor: fix DMA reads

Deepak Rawat (1):
      drm/vmwgfx: Return 0 when gmrid::get_node runs out of ID's

Dongli Zhang (1):
      loop: access lo_backing_file only when the loop device is Lo_bound

Florian Westphal (1):
      netfilter: ebtables: remove BUGPRINT messages

Greg Kroah-Hartman (1):
      Linux 5.0.5

Hans Verkuil (1):
      media: v4l2-ctrls.c/uvc: zero v4l2_event

Hui Wang (2):
      ALSA: hda - Don't trigger jackpoll_work in azx_resume
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

Linus Torvalds (1):
      aio: simplify - and fix - fget/fput for io_submit()

Lukas Czerner (1):
      ext4: fix data corruption caused by unaligned direct AIO

Michael Ellerman (2):
      powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038
      powerpc/security: Fix spectre_v2 reporting

Myungho Jung (3):
      Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf=
()
      Bluetooth: Fix decrementing reference count twice in releasing socket
      RDMA/cma: Rollback source IP address if failing to acquire device

Quinn Tran (1):
      scsi: qla2xxx: Fix FC-AL connection target discovery

Rasmus Villemoes (1):
      irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp

Robert Richter (1):
      iommu/iova: Fix tracking of recently failed iova address

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

Tetsuo Handa (1):
      drm/vkms: Fix flush_work() without INIT_WORK().

Thomas Zimmermann (1):
      drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Tyrel Datwyler (2):
      scsi: ibmvscsi: Protect ibmvscsi_head from concurrent modificaiton
      scsi: ibmvscsi: Fix empty event pool access during host removal

Waiman Long (1):
      locking/lockdep: Add debug_locks check in __lock_downgrade()

Wolfram Sang (1):
      mmc: renesas_sdhi: limit block count to 16 bit for old revisions

Yasha Cherikovsky (1):
      MIPS: Ensure ELF appended dtb is relocated

Yifeng Li (1):
      mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqacti=
on.

Yishai Hadas (1):
      net/mlx5: Fix DCT creation bad flow

zhangyi (F) (1):
      ext4: brelse all indirect buffer in ext4_ind_remove_space()


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlybj3oACgkQONu9yGCS
aT5/MRAAnW7bdKvGm2hdZ16vGK2BGG6WKwMa5n+b1/halfY/9ApAhiDbCWbhach3
kwaeiO9bcl6RQJd8cuEiquycQa/k+CUNyVEoBbOPkCeySnHvmy645S4a0f07GfO4
OelYzNi/eRLv6QlFEtry1tm+i7cCHhme/q4dC8n39cR3Nu7/jv5MBt0iPzX3SGdP
EuJUFemvNSZcGWUfmBdC8HdDgUu4Y/je+5ZmKg+tm2YbOqSGHkmG317FqMzOPr+z
EnXwZTLzwyZk5X5D7PT3nhjA3RUe9bIzZgjafc2aPXQmNAXPu7xppxfrTPZP7CVL
foAEYsfus7xaW7ImXEo31rJpVLuw4e1wFQoQwO32quSIIxhp0SVL8IXdvPfCb0sv
cDYwpbxzspfH52wqsIltXRjnsTMzX67C/4oLqpN30ghwR+iJDqmK/SFCtwynjPDE
a4LBnIxyrQfvPwDft+CJeSbDM3bJ1sEMfOysJAFge0q/jJbzsAw09KVXLd+JF/Gn
0YmBDVHZlCA8Dqex1wPVZQsJwOBef/9kSkT4HEVXLqq95WEMxKu2of2SU9b/vuTt
QpXDGq3Y5jekAIDiMaUQNqr7igvQKiXVqZIdg1Ht2umQmjU9qnoIVCQ9IfQkjtJa
17ONdYhy7uHeJVVeav0KfSFpGT2QcTeq99AedQ6ZkXYcV2FpYpE=
=ZBBx
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
