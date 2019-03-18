Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEA5C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A6C2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901603;
	bh=k1zj/GapHblnrAS6xSfMQXODr2gzQHvb98FQH5EFHys=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NUs4lSnNn3gdxXMxiTLqOq+zdbxEqKi64/URTFzLty2g1VeRsQJqbkLnXTVbwamzp
	 GD5F9dqD2eTDy2nx+vgnNILsXdioxD+oNQk1vhQPUXJEvSSeqxkbRd0Y46IJw9+O6s
	 NDqzw5NdbbGtYa5QOg6WfIyixrahRhEHBwZaGFvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfCRJdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfCRJdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:33:21 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0D42083D;
        Mon, 18 Mar 2019 09:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901600;
        bh=k1zj/GapHblnrAS6xSfMQXODr2gzQHvb98FQH5EFHys=;
        h=From:To:Cc:Subject:Date:From;
        b=vjz2vCivm1DLKKAHAo7/ML08ryCLx6UDhq3/+YswLAUGgF46SSIqTYZytcilo8RUF
         flSKv/iLkaXNijNbkLdS8/55/tUXgNwvgLAs9avpiyXx7JXVFybPxEBvbHTaxaKcn7
         N0/z1g6daRdIMMLyWgX41zVHYo3aoLSH/Y/X+wYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/52] 4.19.30-stable review
Date:   Mon, 18 Mar 2019 10:24:57 +0100
Message-Id: <20190318084013.532280682@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.30-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.30-rc1
X-KernelTest-Deadline: 2019-03-20T08:40+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.30 release.
There are 52 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 20 08:39:59 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.30-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.30-rc1

Zha Bin <zhabin@linux.alibaba.com>
    vhost/vsock: fix vhost vsock cid hashing inconsistent

Björn Töpel <bjorn.topel@intel.com>
    i40e: report correct statistics when XDP is enabled

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix race when the managed cache is enabled

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm: Block fb changes for async plane updates

Xiao Ni <xni@redhat.com>
    It's wrong to add len to sector_nr in raid10 reshape twice

kbuild test robot <lkp@intel.com>
    perf/x86/intel: Make dev_attr_allow_tsx_force_abort static

Peter Zijlstra <peterz@infradead.org>
    perf/x86/intel: Fix memory corruption

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek: Enable headset MIC of Acer TravelMate X514-51T with ALC255

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Reduce click noise on Dell Precision 5820 headphone

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek: Enable audio jacks of ASUS UX362FA with ALC294

Jaroslav Kysela <perex@perex.cz>
    ALSA: hda - add more quirks for HP Z2 G4 and HP Z240

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Extend i915 component bind timeout

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-motu: fix construction of PCM frame for capture direction

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O against Liquid Saffire 56

Peter Zijlstra <peterz@infradead.org>
    perf/x86: Fixup typo in stub functions

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: wait on atomic writes to count F2FS_CP_WB_DATA

Vlad Buslov <vladbu@mellanox.com>
    net: sched: flower: insert new filter to idr after setting its mask

Al Viro <viro@zeniv.linux.org.uk>
    missing barriers in some of unix_sock ->addr and ->path accesses

Ursula Braun <ubraun@linux.ibm.com>
    net/smc: fix smc_poll in SMC_INIT state

Michal Soltys <soltys@ziu.info>
    bonding: fix PACKET_ORIGDEV regression

Paolo Abeni <pabeni@redhat.com>
    ipv6: route: enforce RCU protection in ip6_route_check_nh_onlink()

Paolo Abeni <pabeni@redhat.com>
    ipv6: route: enforce RCU protection in rt6_update_exception_stamp_rt()

Daniel Borkmann <daniel@iogearbox.net>
    ipvlan: disallow userns cap_net_admin to change global mode/flags

George Wilkie <gwilkie@vyatta.att-mail.com>
    team: use operstate consistently for linkup

Paolo Abeni <pabeni@redhat.com>
    ipv6: route: purge exception on removal

Kalash Nainwal <kalash@arista.com>
    net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

YueHaibing <yuehaibing@huawei.com>
    mdio_bus: Fix use-after-free on device_register fails

Eric Dumazet <edumazet@google.com>
    net/x25: fix a race in x25_bind()

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Fix qp mtt size calculation

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Fix locking in SRIOV mode when switching between events and polling

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Fix reset flow when in command polling mode

Eric Dumazet <edumazet@google.com>
    vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()

Stefano Brivio <sbrivio@redhat.com>
    vxlan: Fix GRO cells race condition between receive and link delete

Guillaume Nault <gnault@redhat.com>
    tcp: handle inet_csk_reqsk_queue_add() failures

Christoph Paasch <cpaasch@apple.com>
    tcp: Don't access TCP_SKB_CB before initializing it

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: do not report TCP_CM_INQ of 0 for closed connections

Xin Long <lucien.xin@gmail.com>
    sctp: remove sched init from sctp_stream_init

David Howells <dhowells@redhat.com>
    rxrpc: Fix client call queueing, waiting for channel

Xin Long <lucien.xin@gmail.com>
    route: set the deleted fnhe fnhe_daddr to 0 in ip_del_fnhe to fix a race

Masaru Nagai <masaru.nagai.vx@renesas.com>
    ravb: Decrease TxFIFO depth of Q3 and Q2 to one

Xin Long <lucien.xin@gmail.com>
    pptp: dst_release sk_dst_cache in pptp_sock_destruct

Eric Dumazet <edumazet@google.com>
    net/x25: reset state in x25_connect()

Eric Dumazet <edumazet@google.com>
    net/x25: fix use-after-free in x25_device_event()

Miaohe Lin <linmiaohe@huawei.com>
    net: sit: fix UBSAN Undefined behaviour in check_6rd

Eric Dumazet <edumazet@google.com>
    net/hsr: fix possible crash in add_timer()

Mao Wenan <maowenan@huawei.com>
    net: hsr: fix memory leak in hsr_dev_finalize()

Bryan Whitehead <Bryan.Whitehead@microchip.com>
    lan743x: Fix TX Stall Issue

Bryan Whitehead <Bryan.Whitehead@microchip.com>
    lan743x: Fix RX Kernel Panic

Eric Dumazet <edumazet@google.com>
    l2tp: fix infoleak in l2tp_ip6_recvmsg()

Paolo Abeni <pabeni@redhat.com>
    ipv4/route: fail early when inet dev is missing

Eric Dumazet <edumazet@google.com>
    gro_cells: make sure device is up in gro_cells_receive()

Li RongQing <lirongqing@baidu.com>
    connector: fix unsafe usage of ->real_parent


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/x86/events/intel/core.c                       |   4 +-
 arch/x86/events/perf_event.h                       |   4 +-
 drivers/connector/cn_proc.c                        |  22 +++-
 drivers/gpu/drm/drm_atomic_helper.c                |   9 ++
 drivers/md/raid10.c                                |   1 -
 drivers/net/bonding/bond_main.c                    |  35 +++---
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  24 ++--
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |   9 ++
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |   6 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  55 ++++----
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   4 +
 drivers/net/phy/mdio_bus.c                         |   1 -
 drivers/net/ppp/pptp.c                             |   1 +
 drivers/net/team/team.c                            |   4 +-
 drivers/net/vxlan.c                                |  14 ++-
 drivers/staging/erofs/internal.h                   |   1 +
 drivers/staging/erofs/utils.c                      | 139 +++++++++++++++------
 drivers/vhost/vsock.c                              |   2 +-
 fs/f2fs/file.c                                     |  12 +-
 net/core/gro_cells.c                               |  22 +++-
 net/hsr/hsr_device.c                               |  18 +--
 net/hsr/hsr_framereg.c                             |  12 ++
 net/hsr/hsr_framereg.h                             |   1 +
 net/ipv4/route.c                                   |  13 +-
 net/ipv4/syncookies.c                              |   7 +-
 net/ipv4/tcp.c                                     |   5 +
 net/ipv4/tcp_input.c                               |   8 +-
 net/ipv4/tcp_ipv4.c                                |   9 +-
 net/ipv6/route.c                                   |  32 +++--
 net/ipv6/sit.c                                     |   5 +-
 net/l2tp/l2tp_ip6.c                                |   4 +-
 net/rxrpc/conn_client.c                            |   4 +-
 net/sched/cls_flower.c                             |  43 +++----
 net/sctp/stream.c                                  |   2 -
 net/smc/smc.h                                      |   6 +-
 net/unix/af_unix.c                                 |  57 +++++----
 net/unix/diag.c                                    |   3 +-
 net/x25/af_x25.c                                   |  20 ++-
 security/lsm_audit.c                               |  10 +-
 sound/firewire/bebob/bebob.c                       |  14 ++-
 sound/firewire/motu/amdtp-motu.c                   |   4 +-
 sound/hda/hdac_i915.c                              |   4 +-
 sound/pci/hda/patch_conexant.c                     |   3 +
 sound/pci/hda/patch_realtek.c                      |  80 ++++++++----
 46 files changed, 488 insertions(+), 251 deletions(-)


