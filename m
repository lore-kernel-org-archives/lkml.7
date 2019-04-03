Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED46C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFFC21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554280886;
	bh=lkZMJsaZyqxXqsrXCNteGKfoDZdb5MqkdQvRjDRO+Bw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mYgz5/3pJfDSOOlAE1erOU0WK42K9gajNE84kfs+vdjHPk+Zv5i9Z6e2d4mYZGowY
	 cr299Tj3t2BuWLi70tYifsroEjymtb9J4HmW1bp4N1Aa6krEqoNRsc3sqSiLHyTXp1
	 biMCEnEFM9ktq9w13icZst7gdXiIjTfqI3/5cxL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfDCIlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfDCIlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:41:24 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D56321473;
        Wed,  3 Apr 2019 08:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554280882;
        bh=lkZMJsaZyqxXqsrXCNteGKfoDZdb5MqkdQvRjDRO+Bw=;
        h=Date:From:To:Cc:Subject:From;
        b=sW5DE9M0y92U0YkePhQee2Azx49MDb5tWouUFYGHP18ypWz+rQiToXQsA0Q77gceH
         jq5XLNYo/LMmM4pJQRS/4O71ra8SOdvcNSbOP1anQQQyFDFHmr1Oma9qsk3oWO4Q7j
         9hueoKgrnFKm9h2c8k/8GVTZ4Ah94is4+xL3GOI0=
Date:   Wed, 3 Apr 2019 10:40:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.167
Message-ID: <20190403084030.GA22606@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.167 kernel.

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

 Documentation/virtual/kvm/api.txt                   |   16 ++-
 Makefile                                            |    2=20
 arch/arm/mach-imx/cpuidle-imx6q.c                   |   27 ++----
 arch/arm64/Kconfig                                  |    4=20
 arch/powerpc/include/asm/ppc-opcode.h               |    2=20
 arch/powerpc/net/bpf_jit.h                          |   17 +---
 arch/powerpc/net/bpf_jit32.h                        |    4=20
 arch/powerpc/net/bpf_jit64.h                        |   20 ++++
 arch/powerpc/net/bpf_jit_comp64.c                   |   12 +-
 arch/x86/Kconfig                                    |    8 -
 arch/x86/include/asm/kvm_host.h                     |    1=20
 arch/x86/kvm/vmx.c                                  |   14 ---
 arch/x86/kvm/x86.c                                  |   12 ++
 drivers/gpio/gpio-adnp.c                            |    6 -
 drivers/isdn/hardware/mISDN/hfcmulti.c              |    3=20
 drivers/net/dsa/qca8k.c                             |   18 ----
 drivers/net/ethernet/8390/mac8390.c                 |   19 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |   16 +++
 drivers/net/tun.c                                   |   16 ++-
 drivers/net/vxlan.c                                 |    4=20
 drivers/s390/scsi/zfcp_erp.c                        |   17 ++++
 drivers/s390/scsi/zfcp_ext.h                        |    2=20
 drivers/s390/scsi/zfcp_scsi.c                       |    4=20
 drivers/scsi/sd.c                                   |   22 +++--
 drivers/staging/comedi/comedidev.h                  |    2=20
 drivers/staging/comedi/drivers.c                    |   33 ++++++-
 drivers/staging/comedi/drivers/ni_mio_common.c      |   10 +-
 drivers/staging/vt6655/device_main.c                |   11 +-
 drivers/tty/serial/atmel_serial.c                   |    4=20
 drivers/tty/serial/kgdboc.c                         |    4=20
 drivers/tty/serial/max310x.c                        |    2=20
 drivers/tty/serial/sh-sci.c                         |   12 --
 drivers/usb/common/common.c                         |    2=20
 drivers/usb/core/config.c                           |    9 --
 drivers/usb/gadget/function/f_hid.c                 |    6 -
 drivers/usb/host/xhci-rcar.c                        |    1=20
 drivers/usb/host/xhci-ring.c                        |    9 +-
 drivers/usb/host/xhci.h                             |    1=20
 drivers/usb/serial/cp210x.c                         |    1=20
 drivers/usb/serial/ftdi_sio.c                       |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                   |    4=20
 drivers/usb/serial/mos7720.c                        |    4=20
 drivers/usb/serial/option.c                         |   13 +--
 drivers/video/fbdev/goldfishfb.c                    |    2=20
 fs/btrfs/raid56.c                                   |    3=20
 fs/btrfs/tree-log.c                                 |   11 ++
 fs/nfs/nfs4proc.c                                   |    3=20
 fs/open.c                                           |    6 +
 fs/proc/proc_sysctl.c                               |    3=20
 include/net/sctp/checksum.h                         |    2=20
 include/net/sock.h                                  |    6 +
 kernel/cpu.c                                        |   20 ++++
 net/bluetooth/l2cap_core.c                          |   83 ++++++++++++---=
-----
 net/dccp/ipv6.c                                     |    4=20
 net/ipv6/tcp_ipv6.c                                 |    8 -
 net/packet/af_packet.c                              |    4=20
 net/rose/rose_subr.c                                |   21 ++---
 net/wireless/nl80211.c                              |   16 +--
 sound/core/oss/pcm_oss.c                            |   43 +++++-----
 sound/core/pcm_native.c                             |    9 +-
 sound/core/rawmidi.c                                |    2=20
 sound/core/seq/oss/seq_oss_synth.c                  |    7 -
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   20 +---
 virt/kvm/kvm_main.c                                 |    3=20
 64 files changed, 421 insertions(+), 251 deletions(-)

Aditya Pakki (1):
      serial: max310x: Fix to avoid potential NULL pointer dereference

Adrian Hunter (1):
      perf intel-pt: Fix TSC slip

Andrea Righi (1):
      btrfs: raid56: properly unmap parity page in finish_parity_scrub()

Axel Lin (1):
      gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

Bart Van Assche (1):
      scsi: sd: Fix a race between closing an sd device and sd I/O

Bhadram Varka (1):
      stmmac: copy unicast mac address to MAC registers

Bjorn Helgaas (1):
      mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Bj=F8rn Mork (1):
      USB: serial: option: add Olicard 600

Christian Lamparter (1):
      net: dsa: qca8k: remove leftover phy accessors

Christoffer Dall (1):
      video: fbdev: Set pixclock =3D 0 in goldfishfb

Christoph Paasch (1):
      net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Eric Biggers (1):
      arm64: support keyctl() system call in 32-bit mode

Eric Dumazet (5):
      dccp: do not use ipv6 header for ipv4 flow
      net: rose: fix a possible stack overflow
      tcp: do not use ipv6 header for ipv4 flow
      tun: properly test for IFF_UP
      tun: add a missing rcu_read_unlock() in error path

Fabrizio Castro (1):
      usb: common: Consider only available nodes for dr_mode

Finn Thain (1):
      mac8390: Fix mmio access size probe

George McCollister (1):
      USB: serial: ftdi_sio: add additional NovaTech products

Greg Kroah-Hartman (3):
      USB: serial: cp210x: add new device id
      Revert "USB: core: only clean up what we allocated"
      Linux 4.9.167

Gustavo A. R. Silva (2):
      ALSA: rawmidi: Fix potential Spectre v1 vulnerability
      ALSA: seq: oss: Fix Spectre v1 vulnerability

Hoan Nguyen An (1):
      serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Ian Abbott (1):
      staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

Johannes Berg (1):
      cfg80211: size various nl80211 messages correctly

Josef Bacik (1):
      btrfs: remove WARN_ON in log_dir_items

Kangjie Lu (1):
      tty: atmel_serial: fix a potential NULL pointer dereference

Kohji Okuno (1):
      ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected t=
ime

Lin Yi (1):
      USB: serial: mos7720: fix mos_parport refcount imbalance on error path

Malcolm Priestley (2):
      staging: vt6655: Remove vif check from vnt_interrupt
      staging: vt6655: Fix interrupt race condition on device start up.

Mans Rullgard (1):
      USB: serial: option: set driver_info for SIM5218 and compatibles

Marcel Holtmann (2):
      Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt
      Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Martin K. Petersen (1):
      scsi: sd: Quiesce warning if device does not report optimal I/O size

Mathias Nyman (1):
      xhci: Fix port resume done detection for SS ports with LPM enabled

Maxime Chevallier (1):
      packets: Always register packet sk in the same order

Naveen N. Rao (1):
      powerpc: bpf: Fix generation of load/store DW instructions

Olga Kornievskaia (1):
      NFSv4.1 don't free interrupted slot on open

Radoslav Gerganov (1):
      USB: gadget: f_hid: fix deadlock in f_hidg_write()

Sean Christopherson (2):
      KVM: Reject device ioctls from processes other than the VM's creator
      KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts

Steffen Maier (2):
      scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host
      scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV =
FCP devices

Takashi Iwai (2):
      ALSA: pcm: Fix possible OOB access in PCM oss plugins
      ALSA: pcm: Don't suspend stream in unrecoverable PCM state

Tetsuo Handa (1):
      fs/open.c: allow opening only regular files during execve()

Thomas Gleixner (2):
      cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_C=
PU=3Dn
      x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=3Dy

Wentao Wang (1):
      Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/=
kgdboc

Xin Long (1):
      sctp: get sctphdr by offset in sctp_compute_cksum

Yasushi Asano (1):
      usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk

YueHaibing (1):
      fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Zhiqiang Liu (1):
      vxlan: Don't call gro_cells_destroy() before device is unregistered


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlykcX4ACgkQONu9yGCS
aT5Uhw/6A5wcyK24bkdIDxizvyLTDj3pmpThq4B35X63vVkddiRrqr3nYXBzn7fS
5t0rXeGFHfO8I/S0uCUDmfkipexmey3fHDI8aQ7TTMk7Vi8LmBBIJoKgcJFyO8zs
iwyTwaTeroujEJBXkjKdVTK4q2QCsEySzZ7pYEgQnHXs2e1KctohfkeG4AgZLYc6
1If7uhSXMB1fnczL4Ng4FiIClDa/t/Qyih1IxEbjtRop908VMKcYx7pFgEW4skO8
sBmI7BJFu/QAoWYllybPIrG84AwBZVnTVeqDue4WUXAWX9Agzy3STmcVQCI3EuiG
zETfdrmDPp2xPq9TRv0qtD8B7mRaCv7/1fVo/nTI3RxObDqRRMzJOmAV7JDaHUBq
i8HKGXKT7xjTgHRnPfyMKZTvO4KDJlHox9ollQzGF9SSVJlEIFh/ghDcOPFTidlp
wbayswutQi7KMLTZZ3Um4yL34GAghj5ZQp89RvS96oce2Zpf8a5Dj0mMJ9D1Lo3/
h9zMW/pn3o7gNHTtMEh8SqKzsXh1K8u8leH6BlFERfylD9ch9XBtDg1zkLC4jk9n
1OmxCYEfZ+Ukb1z7xlrb8Mjgg0xSN7EJVPWwBQEOHXhdaZ33V2VXmAomJKY3Fkq7
A+pTSUHbmCasS20OI/CceYDnYT4kOqy/6ow0zVlz6JhfWsjs588=
=h7IK
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
