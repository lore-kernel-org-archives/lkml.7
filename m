Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A98C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B56B20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050523;
	bh=fcHqqWc9lbWSvHxmwK9b+Hyn2kcN8XtqajsIGv+FQK0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eBQ19tA6FC5KCVzsL/4DL0+D1V6Fs7PtGhPQ382Ca+FSQ10o59CbY9ouH0UWgF+Cn
	 7dDeTBJBwPgdu4mF4K2JVDpXzvfxr0wTSOBpcg7WBUsNkXZOJ0B2Bc6Uq/t/1mnbCm
	 cGfodiyVIR05Ocy0u2Gkp0p9FqqkH8vKdEvezzuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCHMwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfCHMwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C102085A;
        Fri,  8 Mar 2019 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049564;
        bh=fcHqqWc9lbWSvHxmwK9b+Hyn2kcN8XtqajsIGv+FQK0=;
        h=From:To:Cc:Subject:Date:From;
        b=n6/ZCQeahA1WpOiIP38xDNb9XbIK8qBunDRAGQIx4vU/D8Shr3l+7jrqk/Q1Sj9VZ
         Z7KFvnqD+KUYbHtDce80dKZBbFhnuEBwA2t8GLEkRowtxrJHlbF4YXMMHCg+3c3/TA
         UTnYTzrk7ww7o/Bzq8PW6zQbZKDV3ASnSiUfywxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 5.0 00/46] 5.0.1-stable review
Date:   Fri,  8 Mar 2019 13:49:33 +0100
Message-Id: <20190308124902.257040783@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.0.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.0.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.0.1-rc1
X-KernelTest-Deadline: 2019-03-10T12:49+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.0.1 release.
There are 46 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 10 12:48:36 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.1-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.0.1-rc1

YueHaibing <yuehaibing@huawei.com>
    exec: Fix mem leak in kernel_read_file

Matthias Kaehlcke <mka@chromium.org>
    Bluetooth: Fix locking in bt_accept_enqueue() for BH context

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Bluetooth: btrtl: Restore old logic to assume firmware is already loaded

Luis Chamberlain <mcgrof@kernel.org>
    selftests: firmware: fix verify_reqs() return value

Luis Chamberlain <mcgrof@kernel.org>
    Revert "selftests: firmware: remove use of non-standard diff -Z option"

Luis Chamberlain <mcgrof@kernel.org>
    Revert "selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config"

Karoly Pados <pados@pados.hu>
    USB: serial: cp210x: fix GPIO in autosuspend

Johan Hovold <johan@kernel.org>
    gnss: sirf: fix premature wakeup interrupt enable

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix get_wchan

Bart Van Assche <bvanassche@acm.org>
    aio: Fix locking in aio_poll()

Liu Xiang <liu.xiang6@zte.com.cn>
    MIPS: irq: Allocate accurate order pages for irq stack

Arnd Bergmann <arnd@arndb.de>
    alpha: wire up io_pgetevents system call

Gustavo A. R. Silva <gustavo@embeddedor.com>
    applicom: Fix potential Spectre v1 vulnerabilities

Balaji Manoharan <m.balaji@intel.com>
    usb: xhci: Fix for Enabling USB ROLE SWITCH QUIRK on INTEL_SUNRISEPOINT_LP_XHCI

Thierry Reding <treding@nvidia.com>
    xhci: tegra: Prevent error pointer dereference

Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
    tracing: Fix event filters and triggers to handle negative numbers

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/boot/compressed/64: Do not read legacy ROM on EFI system

Jiaxun Yang <jiaxun.yang@flygoat.com>
    x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Erik Hugne <erik.hugne@gmail.com>
    tipc: fix RDM/DGRAM connect() regression

Ido Schimmel <idosch@mellanox.com>
    team: Free BPF filter when unregistering netdev

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79

Xin Long <lucien.xin@gmail.com>
    sctp: call iov_iter_revert() after sending ABORT

Kristian Evensen <kristian.evensen@gmail.com>
    qmi_wwan: Add support for Quectel EG12/EM12

YueHaibing <yuehaibing@huawei.com>
    net-sysfs: Fix mem leak in netdev_register_kobject

Eric Dumazet <edumazet@google.com>
    net: sched: put back q.qlen into a single location

Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
    net: mscc: Enable all ports in QSGMII

Heiner Kallweit <hkallweit1@gmail.com>
    net: dsa: mv8e6xxx: fix number of internal PHYs for 88E6x90 family

Heiner Kallweit <hkallweit1@gmail.com>
    net: dsa: mv88e6xxx: handle unknown duplex modes gracefully in mv88e6xxx_port_set_duplex

Heiner Kallweit <hkallweit1@gmail.com>
    net: dsa: mv88e6xxx: add call to mv88e6xxx_ports_cmode_init to probe for new DSA framework

Ido Schimmel <idosch@mellanox.com>
    ip6mr: Do not call __IP6_INC_STATS() from preemptible context

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    staging: android: ashmem: Avoid range_alloc() allocation with ashmem_mutex held.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    staging: android: ashmem: Don't call fallocate() with ashmem_mutex held.

Qing Xia <saberlily.xia@hisilicon.com>
    staging: android: ion: fix sys heap pool's gfp_flags

Ajay Singh <ajay.kathat@microchip.com>
    staging: wilc1000: fix to set correct value for 'vif_num'

Gustavo A. R. Silva <gustavo@embeddedor.com>
    staging: comedi: ni_660x: fix missing break in switch statement

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix illegal address access under memory pressure

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix race of initializing xattrs of a inode at the same time

Sheng Yong <shengyong1@huawei.com>
    staging: erofs: fix memleak of inode's shared xattr array

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix fast symlink w/o xattr when fs xattr is on

Geert Uytterhoeven <geert+renesas@glider.be>
    driver core: Postpone DMA tear-down until after devres release

Mans Rullgard <mans@mansr.com>
    USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485

Ivan Mironov <mironov.ivan@gmail.com>
    USB: serial: cp210x: add ID for Ingenico 3070

Daniele Palmas <dnlplm@gmail.com>
    USB: serial: option: add Telit ME910 ECM composition

Todd Kjos <tkjos@android.com>
    binder: create node flag to request sender's security context

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix mis-acted TAIL merging behavior

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: Use struct kobj_attribute instead of struct global_attr


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/alpha/kernel/syscalls/syscall.tbl            |   1 +
 arch/mips/kernel/irq.c                            |   4 +-
 arch/x86/boot/compressed/pgtable_64.c             |  19 +++-
 arch/x86/kernel/cpu/amd.c                         |   8 +-
 arch/xtensa/kernel/process.c                      |   4 +-
 drivers/android/binder.c                          | 106 +++++++++++++++++-----
 drivers/base/dd.c                                 |   2 +-
 drivers/bluetooth/btrtl.c                         |  10 +-
 drivers/char/applicom.c                           |  35 ++++---
 drivers/cpufreq/cpufreq.c                         |   6 +-
 drivers/cpufreq/intel_pstate.c                    |  23 ++---
 drivers/gnss/sirf.c                               |  32 ++++---
 drivers/net/dsa/mv88e6xxx/chip.c                  |  13 +--
 drivers/net/dsa/mv88e6xxx/port.c                  |   2 +-
 drivers/net/ethernet/marvell/sky2.c               |  24 ++++-
 drivers/net/ethernet/mscc/ocelot_board.c          |  14 ++-
 drivers/net/team/team_mode_loadbalance.c          |  15 +++
 drivers/net/usb/qmi_wwan.c                        |  26 ++++--
 drivers/staging/android/ashmem.c                  |  67 +++++++++-----
 drivers/staging/android/ion/ion_system_heap.c     |   2 +-
 drivers/staging/comedi/drivers/ni_660x.c          |   1 +
 drivers/staging/erofs/inode.c                     |   8 +-
 drivers/staging/erofs/internal.h                  |  11 ++-
 drivers/staging/erofs/unzip_vle.c                 |  77 ++++++++++------
 drivers/staging/erofs/xattr.c                     |  65 ++++++++++---
 drivers/staging/wilc1000/linux_wlan.c             |   4 +-
 drivers/usb/host/xhci-pci.c                       |   1 +
 drivers/usb/host/xhci-tegra.c                     |   4 +-
 drivers/usb/serial/cp210x.c                       |  12 +++
 drivers/usb/serial/ftdi_sio.c                     |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                 |   6 ++
 drivers/usb/serial/option.c                       |   2 +
 fs/aio.c                                          |  12 ++-
 fs/exec.c                                         |   2 +-
 include/linux/cpufreq.h                           |  12 +--
 include/net/bluetooth/bluetooth.h                 |   2 +-
 include/net/sch_generic.h                         |  31 +++----
 include/uapi/linux/android/binder.h               |  19 ++++
 kernel/trace/trace_events_filter.c                |   5 +-
 net/bluetooth/af_bluetooth.c                      |  16 +++-
 net/bluetooth/l2cap_sock.c                        |   2 +-
 net/bluetooth/rfcomm/sock.c                       |   2 +-
 net/bluetooth/sco.c                               |   2 +-
 net/core/gen_stats.c                              |   2 -
 net/core/net-sysfs.c                              |   3 +
 net/ipv6/ip6mr.c                                  |   8 +-
 net/sched/sch_generic.c                           |  13 ++-
 net/sctp/socket.c                                 |   1 +
 net/tipc/socket.c                                 |   2 +-
 tools/testing/selftests/firmware/config           |   1 -
 tools/testing/selftests/firmware/fw_filesystem.sh |   9 +-
 tools/testing/selftests/firmware/fw_lib.sh        |   2 +-
 53 files changed, 521 insertions(+), 235 deletions(-)


