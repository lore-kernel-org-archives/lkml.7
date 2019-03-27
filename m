Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C08E20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711189;
	bh=bnKrd5i5gsn5Sm5JgSE8mNT/Hm3JxSHqm9kiDJgGFTc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yKgcSJ7axVz67DmamYOx+8nL/N1H777NkXwudLGHp9ctK6W/eeAmgLTjCn8hG8j8n
	 AHdgxF0yA02qpFf0Qdb/n6jxE2CFOlW30Ar3OzmJLksvmvynTerrbLFfh+FpP2FY8l
	 ER5yQe72XLf6zPczUzdqgAM1FLNOMKj8YpMppAJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391690AbfC0S01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391661AbfC0S0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:09 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DEF82082F;
        Wed, 27 Mar 2019 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711167;
        bh=bnKrd5i5gsn5Sm5JgSE8mNT/Hm3JxSHqm9kiDJgGFTc=;
        h=Date:From:To:Cc:Subject:From;
        b=HjEnR3YXI4nxUIpKKwT/k8NfYU2zMjHVD5r3SOKXXKsg6uMOsURIQIAJ2W8LHa3Tw
         +xTNiQETK0+1kpOVC0v2cTya8twwFnNbzfPkag5vkyZYbe0sYLlqQTGfCMN6t4k/Bs
         zqBnIfKos8d2rjjFMO84plj/MQ2npu0mHdF0XCwI=
Date:   Wed, 27 Mar 2019 23:57:22 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.109
Message-ID: <20190327145722.GA8036@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.109 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                               |    2=20
 arch/mips/include/asm/jump_label.h     |    8 +-
 arch/mips/kernel/vmlinux.lds.S         |   12 +--
 arch/mips/loongson64/lemote-2f/irq.c   |    2=20
 arch/x86/include/asm/unwind.h          |    6 +
 arch/x86/kernel/unwind_frame.c         |   25 +++++-
 arch/x86/kernel/unwind_orc.c           |   17 ++++
 drivers/bluetooth/hci_h4.c             |    4 +
 drivers/bluetooth/hci_ldisc.c          |   24 +++---
 drivers/gpu/drm/drm_mode_object.c      |    5 -
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c     |   12 ---
 drivers/iommu/amd_iommu.c              |    7 +
 drivers/media/usb/uvc/uvc_ctrl.c       |    2=20
 drivers/media/v4l2-core/v4l2-ctrls.c   |    2=20
 drivers/mmc/host/pxamci.c              |    2=20
 drivers/net/wireless/ath/ath10k/wmi.c  |    2=20
 drivers/pci/dwc/pcie-designware-ep.c   |   12 ++-
 drivers/pci/dwc/pcie-designware.h      |    1=20
 drivers/pci/endpoint/pci-epc-core.c    |   10 --
 drivers/pci/endpoint/pci-epf-core.c    |    4 -
 drivers/power/supply/charger-manager.c |    3=20
 drivers/rtc/rtc-lib.c                  |    6 -
 drivers/scsi/ibmvscsi/ibmvscsi.c       |   23 ++++-
 drivers/scsi/ufs/ufshcd.c              |   14 ++-
 drivers/usb/core/config.c              |    9 +-
 drivers/video/backlight/pwm_bl.c       |    9 +-
 fs/ext4/ext4_jbd2.h                    |    2=20
 fs/ext4/file.c                         |    2=20
 fs/ext4/indirect.c                     |   12 ++-
 fs/udf/truncate.c                      |    3=20
 include/linux/ceph/libceph.h           |    2=20
 kernel/futex.c                         |    4 +
 kernel/locking/lockdep.c               |    3=20
 kernel/sched/cpufreq_schedutil.c       |    3=20
 lib/int_sqrt.c                         |    3=20
 net/bluetooth/hci_sock.c               |    3=20
 net/bridge/netfilter/ebtables.c        |  131 +++++++++-------------------=
-----
 net/ceph/ceph_common.c                 |   18 ++++
 net/ceph/mon_client.c                  |    9 ++
 sound/pci/hda/hda_codec.c              |   57 +++++++++++++-
 sound/x86/intel_hdmi_audio.c           |    1=20
 tools/objtool/check.c                  |    3=20
 tools/perf/util/probe-event.c          |    6 +
 43 files changed, 301 insertions(+), 184 deletions(-)

Adrian Hunter (1):
      perf probe: Fix getting the kernel map

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

Chris Wilson (1):
      drm: Reorder set_property_atomic to avoid returning with an active ww=
_ctx

Enric Balletbo i Serra (1):
      pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.

Florian Westphal (1):
      netfilter: ebtables: remove BUGPRINT messages

Greg Kroah-Hartman (1):
      Linux 4.14.109

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

Jeremy Cline (1):
      Bluetooth: hci_ldisc: Initialize hci_dev before open()

Jiufei Xue (1):
      ext4: fix NULL pointer dereference while journal is aborted

Josh Poimboeuf (1):
      objtool: Move objtool_file struct off the stack

Jules Maselbas (1):
      sched/cpufreq/schedutil: Fix error path mutex unlock

Kefeng Wang (1):
      Bluetooth: hci_ldisc: Postpone HCI_UART_PROTO_READY bit set in hci_ua=
rt_set_proto()

Kishon Vijay Abraham I (1):
      PCI: endpoint: Use EPC's device in dma_alloc_coherent()/dma_free_cohe=
rent()

Lukas Czerner (1):
      ext4: fix data corruption caused by unaligned direct AIO

Myungho Jung (2):
      Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf=
()
      Bluetooth: Fix decrementing reference count twice in releasing socket

Niklas Cassel (2):
      PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
      PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be writa=
ble

Peter Zijlstra (1):
      lib/int_sqrt: optimize small argument

Stanislaw Gruszka (1):
      iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE

Takashi Iwai (1):
      ALSA: hda - Record the current power state before suspend/resume calls

Thomas Zimmermann (1):
      drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Tyrel Datwyler (2):
      scsi: ibmvscsi: Protect ibmvscsi_head from concurrent modificaiton
      scsi: ibmvscsi: Fix empty event pool access during host removal

Ville Syrj=E4l=E4 (1):
      ALSA: x86: Fix runtime PM for hdmi-lpe-audio

Waiman Long (1):
      locking/lockdep: Add debug_locks check in __lock_downgrade()

Yasha Cherikovsky (1):
      MIPS: Ensure ELF appended dtb is relocated

Yifeng Li (1):
      mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqacti=
on.

kehuanlin (1):
      scsi: ufs: fix wrong command type of UTRD for UFSHCI v2.1

zhangyi (F) (1):
      ext4: brelse all indirect buffer in ext4_ind_remove_space()


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlybj1IACgkQONu9yGCS
aT4MBQ//fT/Z3YZL1nQMTM59QSdqhsY94vt2kuG4IGUx/z3O/1g9V7KMf9lVc1Fc
mmBjmf1lVfuVROmllEpvBWcwCUZpfW2CN47EQFb8Nv8OUuj7DTkmikeJWuHYF1B6
PIFa4rxCL9zWyTkI09H9VMC0xfi+9ICm5ZbVZVDSYK93oX0uVS8sUYYRS/PnWjk/
/CxgfGdBqk1nECWpSJC5SAV69Jv4gAmWWIBwSVAc1j4lwOO+avjmuhYAsRXBQ7ya
r5hBuKogTl9K9j3C1p/nFxhSYzjMoHklXvlY+skeJidFiOlC9qEegwYlpCfMfWWU
evmBd1D2+BvywFSyNuMQb6kdSecstATk4ZAVrtmXXCxkCeuyg58WI98sVZkDqboU
gU/ULjplK5d52oWu6Zl1Abip8+pwZT6+52nWrHjfDs8tb869VSk+wtpC3dzXCEvA
pub42CE9CkAIuBiRbbB7m1WVpUkIAx0FbfR3z6qX79I6l6/+JRwTuDJUVTZXkipT
/nVTcIQiOObygxvczWqM0Y4i+utev4mVZnV6OXRpFgnj/bBMtAk5FwiWU5RdPHN6
7ScH6uCqq2anoHhCoIAZM9LEYT66lP+Cv1q4SXrgjd3QDIItEmzRIxYfwjTM2mz5
aEPHmyK3ViUV5kzw+ftBwEsaOJPyytEbcjFZcAZROrNWr2sOj1c=
=hBGB
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
