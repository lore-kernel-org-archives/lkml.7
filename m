Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4790C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F22B20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552200924;
	bh=IeDvIQYBgBgyOC6tMFBR5j2ONW4Y/n1/wic7RO3iBEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lr0Mn1t+RG3kC0jm7Jyyf6us5UaIZxKkNDEWuRVECbNvwsHA+xx8LY6EzS7GZIiDv
	 QlNG4+xZIWH8hDSUT6ckrwMoK+o1JfB+8KK2rNLedP36bMYZ0aJlwoPU0pDb/HDbdg
	 24imqvWZh8ya5r+Jf9w2X3Rmt8rDf/m8kZR462uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfCJGzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 01:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfCJGzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 01:55:22 -0500
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF4D220657;
        Sun, 10 Mar 2019 06:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552200921;
        bh=IeDvIQYBgBgyOC6tMFBR5j2ONW4Y/n1/wic7RO3iBEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPIOgPPok5xpLBt66a+DgtFF9GhPv8qUXeTYunB01D+1nqW75PqaRlSgd+NXd7k46
         DBuiLkU/Kvw89rMkDXTUao6EzNSj+FFO9BYEsP0SwQs+0Qk6TS4196j79oZVnHQMxV
         uH77SEVkHGGrxkVHSGcBbwdEi+Vf90D2TVLCGtZI=
Date:   Sun, 10 Mar 2019 07:55:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.0.1
Message-ID: <20190310065519.GA25495@kroah.com>
References: <20190310065110.GA24816@kroah.com>
 <20190310065203.GB24816@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310065203.GB24816@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 07:52:03AM +0100, Greg KH wrote:
> On Sun, Mar 10, 2019 at 07:51:10AM +0100, Greg KH wrote:
> > I'm announcing the release of the 5.0.1 kernel.
> > 
> > All users of the 5.0.1 kernel series must upgrade.
> > 
> > The updated 5.0.1.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.0.1.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------
> > 
> >  Makefile |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Ugh, something went obviously wrong here with my scripts, that's not
> good...

Ok, the release was made correctly, my local scripts didn't know about
"5.x" yet, when making the email messages up.

Here's the "real" diffstat and release announcement:

-------------

I'm announcing the release of the 5.0.1 kernel.

All users of the 5.0 kernel series must upgrade.

The updated 5.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.0.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/alpha/kernel/syscalls/syscall.tbl            |    1 
 arch/mips/kernel/irq.c                            |    4 
 arch/x86/boot/compressed/pgtable_64.c             |   19 +++
 arch/x86/kernel/cpu/amd.c                         |    8 -
 arch/xtensa/kernel/process.c                      |    4 
 drivers/android/binder.c                          |  106 +++++++++++++++++-----
 drivers/base/dd.c                                 |    2 
 drivers/bluetooth/btrtl.c                         |   10 +-
 drivers/char/applicom.c                           |   35 ++++---
 drivers/cpufreq/cpufreq.c                         |    6 -
 drivers/cpufreq/intel_pstate.c                    |   23 ++--
 drivers/gnss/sirf.c                               |   32 +++---
 drivers/net/dsa/mv88e6xxx/chip.c                  |   13 +-
 drivers/net/dsa/mv88e6xxx/port.c                  |    2 
 drivers/net/ethernet/marvell/sky2.c               |   24 ++++
 drivers/net/ethernet/mscc/ocelot_board.c          |   14 ++
 drivers/net/team/team_mode_loadbalance.c          |   15 +++
 drivers/net/usb/qmi_wwan.c                        |   26 +++--
 drivers/staging/android/ashmem.c                  |   67 +++++++++----
 drivers/staging/android/ion/ion_system_heap.c     |    2 
 drivers/staging/comedi/drivers/ni_660x.c          |    1 
 drivers/staging/erofs/inode.c                     |    8 -
 drivers/staging/erofs/internal.h                  |   11 +-
 drivers/staging/erofs/unzip_vle.c                 |   77 ++++++++++-----
 drivers/staging/erofs/xattr.c                     |   65 ++++++++++---
 drivers/staging/wilc1000/linux_wlan.c             |    4 
 drivers/usb/host/xhci-pci.c                       |    1 
 drivers/usb/host/xhci-tegra.c                     |    4 
 drivers/usb/serial/cp210x.c                       |   12 ++
 drivers/usb/serial/ftdi_sio.c                     |    2 
 drivers/usb/serial/ftdi_sio_ids.h                 |    6 +
 drivers/usb/serial/option.c                       |    2 
 fs/aio.c                                          |   12 +-
 fs/exec.c                                         |    2 
 include/linux/cpufreq.h                           |   12 --
 include/net/bluetooth/bluetooth.h                 |    2 
 include/net/sch_generic.h                         |   31 ++----
 include/uapi/linux/android/binder.h               |   19 +++
 kernel/trace/trace_events_filter.c                |    5 -
 net/bluetooth/af_bluetooth.c                      |   16 ++-
 net/bluetooth/l2cap_sock.c                        |    2 
 net/bluetooth/rfcomm/sock.c                       |    2 
 net/bluetooth/sco.c                               |    2 
 net/core/gen_stats.c                              |    2 
 net/core/net-sysfs.c                              |    3 
 net/ipv6/ip6mr.c                                  |    8 -
 net/sched/sch_generic.c                           |   13 +-
 net/sctp/socket.c                                 |    1 
 net/tipc/socket.c                                 |    2 
 tools/testing/selftests/firmware/config           |    1 
 tools/testing/selftests/firmware/fw_filesystem.sh |    9 +
 tools/testing/selftests/firmware/fw_lib.sh        |    2 
 53 files changed, 520 insertions(+), 234 deletions(-)

Ajay Singh (1):
      staging: wilc1000: fix to set correct value for 'vif_num'

Arnd Bergmann (1):
      alpha: wire up io_pgetevents system call

Balaji Manoharan (1):
      usb: xhci: Fix for Enabling USB ROLE SWITCH QUIRK on INTEL_SUNRISEPOINT_LP_XHCI

Bart Van Assche (1):
      aio: Fix locking in aio_poll()

Daniele Palmas (1):
      USB: serial: option: add Telit ME910 ECM composition

Eric Dumazet (1):
      net: sched: put back q.qlen into a single location

Erik Hugne (1):
      tipc: fix RDM/DGRAM connect() regression

Gao Xiang (4):
      staging: erofs: fix mis-acted TAIL merging behavior
      staging: erofs: fix fast symlink w/o xattr when fs xattr is on
      staging: erofs: fix race of initializing xattrs of a inode at the same time
      staging: erofs: fix illegal address access under memory pressure

Geert Uytterhoeven (1):
      driver core: Postpone DMA tear-down until after devres release

Greg Kroah-Hartman (1):
      Linux 5.0.1

Gustavo A. R. Silva (2):
      staging: comedi: ni_660x: fix missing break in switch statement
      applicom: Fix potential Spectre v1 vulnerabilities

Heiner Kallweit (3):
      net: dsa: mv88e6xxx: add call to mv88e6xxx_ports_cmode_init to probe for new DSA framework
      net: dsa: mv88e6xxx: handle unknown duplex modes gracefully in mv88e6xxx_port_set_duplex
      net: dsa: mv8e6xxx: fix number of internal PHYs for 88E6x90 family

Ido Schimmel (2):
      ip6mr: Do not call __IP6_INC_STATS() from preemptible context
      team: Free BPF filter when unregistering netdev

Ivan Mironov (1):
      USB: serial: cp210x: add ID for Ingenico 3070

Jiaxun Yang (1):
      x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Johan Hovold (1):
      gnss: sirf: fix premature wakeup interrupt enable

Kai-Heng Feng (2):
      sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79
      Bluetooth: btrtl: Restore old logic to assume firmware is already loaded

Karoly Pados (1):
      USB: serial: cp210x: fix GPIO in autosuspend

Kavya Sree Kotagiri (1):
      net: mscc: Enable all ports in QSGMII

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Do not read legacy ROM on EFI system

Kristian Evensen (1):
      qmi_wwan: Add support for Quectel EG12/EM12

Liu Xiang (1):
      MIPS: irq: Allocate accurate order pages for irq stack

Luis Chamberlain (3):
      Revert "selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config"
      Revert "selftests: firmware: remove use of non-standard diff -Z option"
      selftests: firmware: fix verify_reqs() return value

Mans Rullgard (1):
      USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485

Matthias Kaehlcke (1):
      Bluetooth: Fix locking in bt_accept_enqueue() for BH context

Max Filippov (1):
      xtensa: fix get_wchan

Pavel Tikhomirov (1):
      tracing: Fix event filters and triggers to handle negative numbers

Qing Xia (1):
      staging: android: ion: fix sys heap pool's gfp_flags

Sheng Yong (1):
      staging: erofs: fix memleak of inode's shared xattr array

Tetsuo Handa (2):
      staging: android: ashmem: Don't call fallocate() with ashmem_mutex held.
      staging: android: ashmem: Avoid range_alloc() allocation with ashmem_mutex held.

Thierry Reding (1):
      xhci: tegra: Prevent error pointer dereference

Todd Kjos (1):
      binder: create node flag to request sender's security context

Viresh Kumar (1):
      cpufreq: Use struct kobj_attribute instead of struct global_attr

Xin Long (1):
      sctp: call iov_iter_revert() after sending ABORT

YueHaibing (2):
      net-sysfs: Fix mem leak in netdev_register_kobject
      exec: Fix mem leak in kernel_read_file

