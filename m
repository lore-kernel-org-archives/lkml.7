Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4834820811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049981;
	bh=qDs0oOetwIz9q/V5C+N3my0MdpmHg9wuVbB8xj/C/io=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=so6uu8mc1wULwCdaKPyjKkrclnjyH/fla3mkdYmDjLXEljsbxNoru1w+h6dTB4TOW
	 mWP129+8LZQoTD/uOz5oxMH5GmsFiayN3vsYfmE9k6iB8+tzmv+Flar9Mg0suduCLS
	 H3tw2DLtvx/r6QcWIp0w8IS8mkdIZqtVsU4TpFtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfCHM7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbfCHM7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D60120661;
        Fri,  8 Mar 2019 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049974;
        bh=qDs0oOetwIz9q/V5C+N3my0MdpmHg9wuVbB8xj/C/io=;
        h=From:To:Cc:Subject:Date:From;
        b=0rHbyQu9LWOi/GWM3BTH8r6T2qmooZY/rh7K7sQtsEigpE34lI8ODfI8IsYrwt4eD
         RumACSfu0OQ9oAA7z+YR/DxIj5AlqhEQF1n+DhG5Uu8IklPg0GAL3tXEsKCOLVWJqr
         /EZo+XSAJCG/HRFKR+P1jAELLLB5RXDaa95WZEDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/68] 4.19.28-stable review
Date:   Fri,  8 Mar 2019 13:49:30 +0100
Message-Id: <20190308124910.696595153@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.28-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.28-rc1
X-KernelTest-Deadline: 2019-03-10T12:49+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.28 release.
There are 68 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 10 12:48:45 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.28-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.28-rc1

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix sanitation rewrite in case of non-pointers

Martin Wilck <mwilck@suse.com>
    scsi: core: reset host byte in DID_NEXUS_FAILURE case

YueHaibing <yuehaibing@huawei.com>
    exec: Fix mem leak in kernel_read_file

Matthias Kaehlcke <mka@chromium.org>
    Bluetooth: Fix locking in bt_accept_enqueue() for BH context

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Bluetooth: btrtl: Restore old logic to assume firmware is already loaded

Luis Chamberlain <mcgrof@kernel.org>
    selftests: firmware: fix verify_reqs() return value

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

Gustavo A. R. Silva <gustavo@embeddedor.com>
    applicom: Fix potential Spectre v1 vulnerabilities

Balaji Manoharan <m.balaji@intel.com>
    usb: xhci: Fix for Enabling USB ROLE SWITCH QUIRK on INTEL_SUNRISEPOINT_LP_XHCI

Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
    tracing: Fix event filters and triggers to handle negative numbers

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/boot/compressed/64: Do not read legacy ROM on EFI system

Jiaxun Yang <jiaxun.yang@flygoat.com>
    x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Vlad Buslov <vladbu@mellanox.com>
    net: sched: act_tunnel_key: fix NULL pointer dereference during init

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_skbedit: fix refcount leak when replace fails

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_ipt: fix refcount leak when replace fails

Heiner Kallweit <hkallweit1@gmail.com>
    net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: dsa: mv88e6xxx: power serdes on/off for 10G interfaces on 6390X

David Ahern <dsahern@gmail.com>
    ipv4: Pass original device to ip_rcv_finish_core

David Ahern <dsahern@gmail.com>
    mpls: Return error for RTA_GATEWAY attribute

David Ahern <dsahern@gmail.com>
    ipv6: Return error for RTA_VIA attribute

David Ahern <dsahern@gmail.com>
    ipv4: Return error for RTA_VIA attribute

Nazarov Sergey <s-nazarov@yandex.ru>
    net: avoid use IPCB in cipso_v4_error

Nazarov Sergey <s-nazarov@yandex.ru>
    net: Add __icmp_send helper.

Timur Celik <mail@timurcelik.de>
    tun: remove unnecessary memory barrier

Igor Druzhinin <igor.druzhinin@citrix.com>
    xen-netback: fix occasional leak of grant ref mappings under memory pressure

Igor Druzhinin <igor.druzhinin@citrix.com>
    xen-netback: don't populate the hash cache on XenBus disconnect

Timur Celik <mail@timurcelik.de>
    tun: fix blocking read

Tung Nguyen <tung.q.nguyen@dektech.com.au>
    tipc: fix race condition causing hung sendto

Eric Biggers <ebiggers@google.com>
    net: socket: set sock->sk to NULL after calling proto_ops::release()

Mao Wenan <maowenan@huawei.com>
    net: sit: fix memory leak in sit_init_net()

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: phylink: fix uninitialized variable in phylink_get_mac_state

Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
    net: phy: Micrel KSZ8061: link failure after cable connect

YueHaibing <yuehaibing@huawei.com>
    net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails

Sheng Lan <lansheng@huawei.com>
    net: netem: fix skb length BUG_ON in __skb_to_sgvec

Paul Moore <paul@paul-moore.com>
    netlabel: fix out-of-bounds memory accesses

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix u64 statistics

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix statistics on mv88e6161

Bryan Whitehead <Bryan.Whitehead@microchip.com>
    lan743x: Fix TX Stall Issue

Hangbin Liu <liuhangbin@gmail.com>
    ipv4: Add ICMPv6 support when parse route ipproto

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix IP header checksum for coalesced packets

Jiri Benc <jbenc@redhat.com>
    geneve: correctly handle ipv6.disable module parameter

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Drop oversize TX packets to prevent errors.

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

Heiner Kallweit <hkallweit1@gmail.com>
    net: dsa: mv8e6xxx: fix number of internal PHYs for 88E6x90 family

Heiner Kallweit <hkallweit1@gmail.com>
    net: dsa: mv88e6xxx: handle unknown duplex modes gracefully in mv88e6xxx_port_set_duplex

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
    staging: erofs: compressed_pages should not be accessed again after freed

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix illegal address access under memory pressure

Mans Rullgard <mans@mansr.com>
    USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485

Ivan Mironov <mironov.ivan@gmail.com>
    USB: serial: cp210x: add ID for Ingenico 3070

Daniele Palmas <dnlplm@gmail.com>
    USB: serial: option: add Telit ME910 ECM composition

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix mis-acted TAIL merging behavior

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: Use struct kobj_attribute instead of struct global_attr


-------------

Diffstat:

 Makefile                                      |   4 +-
 arch/mips/kernel/irq.c                        |   4 +-
 arch/x86/boot/compressed/pgtable_64.c         |  19 ++++-
 arch/x86/kernel/cpu/amd.c                     |   8 +-
 arch/xtensa/kernel/process.c                  |   4 +-
 drivers/bluetooth/btrtl.c                     |  10 ++-
 drivers/char/applicom.c                       |  35 +++++---
 drivers/cpufreq/cpufreq.c                     |   6 +-
 drivers/cpufreq/intel_pstate.c                |  23 +++---
 drivers/gnss/sirf.c                           |  32 ++++----
 drivers/net/dsa/mv88e6xxx/chip.c              |  26 ++++--
 drivers/net/dsa/mv88e6xxx/port.c              |  10 ++-
 drivers/net/dsa/mv88e6xxx/port.h              |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   6 ++
 drivers/net/ethernet/marvell/sky2.c           |  24 +++++-
 drivers/net/ethernet/microchip/lan743x_main.c |  16 +++-
 drivers/net/geneve.c                          |  11 ++-
 drivers/net/hyperv/netvsc_drv.c               |  22 ++++-
 drivers/net/phy/micrel.c                      |  13 ++-
 drivers/net/phy/phylink.c                     |   4 +
 drivers/net/team/team_mode_loadbalance.c      |  15 ++++
 drivers/net/tun.c                             |   4 +-
 drivers/net/usb/qmi_wwan.c                    |  26 ++++--
 drivers/net/xen-netback/hash.c                |   2 +
 drivers/net/xen-netback/interface.c           |   7 ++
 drivers/net/xen-netback/netback.c             |  10 +--
 drivers/scsi/scsi_lib.c                       |   1 +
 drivers/staging/android/ashmem.c              |  67 +++++++++------
 drivers/staging/android/ion/ion_system_heap.c |   2 +-
 drivers/staging/comedi/drivers/ni_660x.c      |   1 +
 drivers/staging/erofs/unzip_vle.c             | 114 ++++++++++++++++----------
 drivers/staging/erofs/unzip_vle.h             |   3 +-
 drivers/staging/erofs/unzip_vle_lz4.c         |  20 ++---
 drivers/staging/wilc1000/linux_wlan.c         |   4 +-
 drivers/usb/host/xhci-pci.c                   |   1 +
 drivers/usb/serial/cp210x.c                   |  12 +++
 drivers/usb/serial/ftdi_sio.c                 |   2 +
 drivers/usb/serial/ftdi_sio_ids.h             |   6 ++
 drivers/usb/serial/option.c                   |   2 +
 fs/aio.c                                      |  12 ++-
 fs/exec.c                                     |   2 +-
 include/linux/cpufreq.h                       |  12 +--
 include/net/bluetooth/bluetooth.h             |   2 +-
 include/net/icmp.h                            |   9 +-
 include/net/ip.h                              |   4 +-
 include/net/sch_generic.h                     |  31 +++----
 kernel/bpf/verifier.c                         |   3 +-
 kernel/trace/trace_events_filter.c            |   5 +-
 net/bluetooth/af_bluetooth.c                  |  16 +++-
 net/bluetooth/l2cap_sock.c                    |   2 +-
 net/bluetooth/rfcomm/sock.c                   |   2 +-
 net/bluetooth/sco.c                           |   2 +-
 net/core/gen_stats.c                          |   2 -
 net/core/net-sysfs.c                          |   3 +
 net/ipv4/cipso_ipv4.c                         |  20 ++++-
 net/ipv4/fib_frontend.c                       |   4 +
 net/ipv4/icmp.c                               |   7 +-
 net/ipv4/ip_input.c                           |   9 +-
 net/ipv4/ip_options.c                         |  22 +++--
 net/ipv4/netlink.c                            |  17 +++-
 net/ipv4/route.c                              |   2 +-
 net/ipv6/ip6mr.c                              |   8 +-
 net/ipv6/route.c                              |   7 +-
 net/ipv6/sit.c                                |   1 +
 net/mpls/af_mpls.c                            |   3 +
 net/netlabel/netlabel_kapi.c                  |   3 +-
 net/nfc/llcp_commands.c                       |  20 +++++
 net/nfc/llcp_core.c                           |  24 +++++-
 net/sched/act_ipt.c                           |   3 +-
 net/sched/act_skbedit.c                       |   3 +-
 net/sched/act_tunnel_key.c                    |   3 +-
 net/sched/sch_generic.c                       |  13 ++-
 net/sched/sch_netem.c                         |  10 ++-
 net/sctp/socket.c                             |   1 +
 net/socket.c                                  |   1 +
 net/tipc/socket.c                             |   8 +-
 tools/testing/selftests/firmware/fw_lib.sh    |   2 +-
 77 files changed, 604 insertions(+), 271 deletions(-)


