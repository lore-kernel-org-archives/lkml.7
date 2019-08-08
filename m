Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3FCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4370E21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291349;
	bh=mythW7S1Z7RXbOzhzL7g68fGp2IQlUOHoH75/kDHOSc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qnGXYMM/fTE8t6rmhnasDz6MjT0ms4t+gxG2waJQN8GckWIhnRMaP++ZYp7ZuQ7am
	 AkEWuKW+ZCLPJwzboEyfIwlOOAsOpmpDbgOYVPhZcFpRT5DLNj9JubES9jA4jWjpSK
	 /3uU0Ah6Tv9VJmk0K9ZlwgpiwlvtdDtc/AXNlKqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405052AbfHHTJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405040AbfHHTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:09:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE9CD2189F;
        Thu,  8 Aug 2019 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291344;
        bh=mythW7S1Z7RXbOzhzL7g68fGp2IQlUOHoH75/kDHOSc=;
        h=From:To:Cc:Subject:Date:From;
        b=UstiLB4tPaY5m39ORkjzO94kuUZ5lXqe5vnu+l8yr5rcM/q2xYrZf/G6D05J+tKFD
         LUaHiA6kdilk6Qdkx5WBiSMnWuaedew/IaOyaBHX5obZowJSJfWpf0qkxwllDI6GWs
         JJ/e7WK5ikQLBMSfCIoXM7oj04E9o9ePhP/+nHt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/45] 4.19.66-stable review
Date:   Thu,  8 Aug 2019 21:04:46 +0200
Message-Id: <20190808190453.827571908@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.66-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.66-rc1
X-KernelTest-Deadline: 2019-08-10T19:04+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.66 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat 10 Aug 2019 07:03:19 PM UTC.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.66-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.66-rc1

Lukas Wunner <lukas@wunner.de>
    spi: bcm2835: Fix 3-wire mode if DMA is enabled

Tejun Heo <tj@kernel.org>
    cgroup: Fix css_task_iter_advance_css_set() cset skip condition

Tejun Heo <tj@kernel.org>
    cgroup: css_task_iter_skip()'d iterators must be advanced before accessed

Tejun Heo <tj@kernel.org>
    cgroup: Include dying leaders with live threads in PROCS iterations

Tejun Heo <tj@kernel.org>
    cgroup: Implement css_task_iter_skip()

Tejun Heo <tj@kernel.org>
    cgroup: Call cgroup_release() before __exit_signal()

Arnd Bergmann <arnd@arndb.de>
    compat_ioctl: pppoe: fix PPPOEIOCSFWD handling

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: don't use MSI before RTL8168d

Ariel Levkovich <lariel@mellanox.com>
    net/mlx5e: Prevent encap flow counter update async to user query

Edward Srouji <edwards@mellanox.com>
    net/mlx5: Fix modify_cq_in alignment

Alexis Bauvin <abauvin@scaleway.com>
    tun: mark small packets as owned by the tap sock

Taras Kondratiuk <takondra@cisco.com>
    tipc: compat: allow tipc commands without arguments

Claudiu Manoil <claudiu.manoil@nxp.com>
    ocelot: Cancel delayed work before wq destruction

Johan Hovold <johan@kernel.org>
    NFC: nfcmrvl: fix gpio-handling regression

Ursula Braun <ubraun@linux.ibm.com>
    net/smc: do not schedule tx_work in SMC_CLOSED state

Dmytro Linkin <dmitrolin@mellanox.com>
    net: sched: use temporary variable for actions indexes

Roman Mashak <mrv@mojatatu.com>
    net sched: update vlan action for batched events operations

Jia-Ju Bai <baijiaju1990@gmail.com>
    net: sched: Fix a possible null-pointer dereference in dequeue_func()

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    net: qualcomm: rmnet: Fix incorrect UL checksum offload logic

René van Dorst <opensource@vdorst.com>
    net: phylink: Fix flow control for fixed-link

Mark Zhang <markz@mellanox.com>
    net/mlx5: Use reversed order when unregister devices

Qian Cai <cai@lca.pw>
    net/mlx5e: always initialize frag->last_in_page

Jiri Pirko <jiri@mellanox.com>
    net: fix ifindex collision during namespace removal

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: mcast: don't delete permanent entries when fast leave is enabled

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: delete local fdb on device init failure

Matteo Croce <mcroce@redhat.com>
    mvpp2: refactor MTU change code

Matteo Croce <mcroce@redhat.com>
    mvpp2: fix panic on module removal

Jiri Pirko <jiri@mellanox.com>
    mlxsw: spectrum: Fix error path in mlxsw_sp_module_init()

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ipip: validate header length in ipip_tunnel_xmit

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip6_tunnel: fix possible use-after-free on xmit

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip6_gre: reload ipv6h in prepare_ip6gre_xmit_ipv6

Cong Wang <xiyou.wangcong@gmail.com>
    ife: error out when nla attributes are empty

Sudarsana Reddy Kalluru <skalluru@marvell.com>
    bnx2x: Disable multi-cos feature.

Gustavo A. R. Silva <gustavo@embeddedor.com>
    atm: iphase: Fix Spectre v1 vulnerability

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    IB: directly cast the sockaddr union to aockaddr

Sebastian Parschauer <s.parschauer@gmx.de>
    HID: Add quirk for HP X1200 PIXART OEM mouse

Aaron Armstrong Skomra <skomra@gmail.com>
    HID: wacom: fix bit shift for Cintiq Companion 2

Dan Williams <dan.j.williams@intel.com>
    libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle() ABBA deadlock

Dan Williams <dan.j.williams@intel.com>
    libnvdimm/bus: Prepare the nd_ioctl() path to be re-entrant

Dan Williams <dan.j.williams@intel.com>
    libnvdimm/region: Register badblocks before namespaces

Dan Williams <dan.j.williams@intel.com>
    libnvdimm/bus: Prevent duplicate device_unregister() calls

Dan Williams <dan.j.williams@intel.com>
    drivers/base: Introduce kill_device()

Alexander Duyck <alexander.h.duyck@linux.intel.com>
    driver core: Establish order of operations for device_add and device_del via bitflag

Linus Torvalds <torvalds@linux-foundation.org>
    gcc-9: don't warn about uninitialized variable

Hannes Reinecke <hare@suse.de>
    scsi: fcoe: Embed fc_rport_priv in fcoe_rport structure


-------------

Diffstat:

 Makefile                                           |   4 +-
 drivers/atm/iphase.c                               |   8 +-
 drivers/base/base.h                                |   4 +
 drivers/base/core.c                                |  22 +++++
 drivers/base/dd.c                                  |  22 ++---
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/wacom_wac.c                            |  12 +--
 drivers/i2c/i2c-core-base.c                        |   2 +-
 drivers/infiniband/core/sa_query.c                 |   9 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   3 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  46 +++------
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |   5 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   2 +-
 drivers/net/ethernet/mscc/ocelot.c                 |   1 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h    |   2 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_map_data.c   |  13 ++-
 drivers/net/ethernet/realtek/r8169.c               |   9 +-
 drivers/net/phy/phylink.c                          |   2 +
 drivers/net/ppp/pppoe.c                            |   3 +
 drivers/net/ppp/pppox.c                            |  13 +++
 drivers/net/ppp/pptp.c                             |   3 +
 drivers/net/tun.c                                  |   1 +
 drivers/nfc/nfcmrvl/main.c                         |   4 +-
 drivers/nfc/nfcmrvl/uart.c                         |   4 +-
 drivers/nfc/nfcmrvl/usb.c                          |   1 +
 drivers/nvdimm/bus.c                               |  98 +++++++++++++------
 drivers/nvdimm/region.c                            |  22 ++---
 drivers/nvdimm/region_devs.c                       |   4 +
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  51 ++++------
 drivers/scsi/libfc/fc_rport.c                      |   5 +-
 drivers/spi/spi-bcm2835.c                          |   3 +-
 fs/compat_ioctl.c                                  |   3 -
 include/linux/cgroup-defs.h                        |   1 +
 include/linux/cgroup.h                             |   4 +
 include/linux/device.h                             |   1 +
 include/linux/if_pppox.h                           |   3 +
 include/linux/mlx5/fs.h                            |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   7 +-
 include/scsi/libfcoe.h                             |   1 +
 kernel/cgroup/cgroup.c                             | 106 +++++++++++++++------
 kernel/exit.c                                      |   2 +-
 net/bridge/br_multicast.c                          |   3 +
 net/bridge/br_vlan.c                               |   5 +
 net/core/dev.c                                     |   2 +
 net/ipv4/ipip.c                                    |   3 +
 net/ipv6/ip6_gre.c                                 |   3 +-
 net/ipv6/ip6_tunnel.c                              |   6 +-
 net/l2tp/l2tp_ppp.c                                |   3 +
 net/sched/act_bpf.c                                |   9 +-
 net/sched/act_connmark.c                           |   9 +-
 net/sched/act_csum.c                               |   9 +-
 net/sched/act_gact.c                               |   8 +-
 net/sched/act_ife.c                                |  13 ++-
 net/sched/act_mirred.c                             |  13 +--
 net/sched/act_nat.c                                |   9 +-
 net/sched/act_pedit.c                              |  10 +-
 net/sched/act_police.c                             |   8 +-
 net/sched/act_sample.c                             |  10 +-
 net/sched/act_simple.c                             |  10 +-
 net/sched/act_skbedit.c                            |  11 ++-
 net/sched/act_skbmod.c                             |  11 ++-
 net/sched/act_tunnel_key.c                         |   8 +-
 net/sched/act_vlan.c                               |  25 +++--
 net/sched/sch_codel.c                              |   6 +-
 net/smc/af_smc.c                                   |   8 +-
 net/tipc/netlink_compat.c                          |  11 ++-
 70 files changed, 471 insertions(+), 262 deletions(-)


