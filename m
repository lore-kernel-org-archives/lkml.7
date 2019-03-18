Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C86C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9273F214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901865;
	bh=7m5dmVFKpCUFsYem41vi9OL7GkeooCnx11/g4/x2Gi0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IEQaJVq+sW+QVLUXJp8F3MuKOsMS9ADqFvU3ay05EbqBft6xwbRUUM/NCD6cUSUnv
	 IbIZrXTOYgUj8pCupjhPYYi+vuWKP63McA82PPb6zlSHGU9mf+oIKED4ZEEMU0Ej1J
	 xP4wvkNsIIc9TLfgvgJCPyX/RmYw+mjQxTEbqewk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfCRJho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387498AbfCRJhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:37:41 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D3AA2075C;
        Mon, 18 Mar 2019 09:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901860;
        bh=7m5dmVFKpCUFsYem41vi9OL7GkeooCnx11/g4/x2Gi0=;
        h=From:To:Cc:Subject:Date:From;
        b=SK18XYOsbp5W64YbYdaIbX6tNY7gVQ9qBX5DNtNkd6qgKHKLVsdv2iHZTmftQAyJg
         k94ScyNm7Qbz0XyxF6hG1FyOK0sX3DickWuSV+c37KQKPiNgjhlXgmm9MLxfdcUiDw
         Od4ubC+pRjgNpVo9bP2HHngAhIEpee06ASYyu1fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/31] 4.9.164-stable review
Date:   Mon, 18 Mar 2019 10:25:35 +0100
Message-Id: <20190318084210.397476003@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.164-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.164-rc1
X-KernelTest-Deadline: 2019-03-20T08:42+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.164 release.
There are 31 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 20 08:42:01 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.164-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.164-rc1

Zha Bin <zhabin@linux.alibaba.com>
    vhost/vsock: fix vhost vsock cid hashing inconsistent

Sakari Ailus <sakari.ailus@linux.intel.com>
    of: Support const and non-const use for to_of_node()

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    mmc: tmio_mmc_core: don't claim spurious interrupts

Xiao Ni <xni@redhat.com>
    It's wrong to add len to sector_nr in raid10 reshape twice

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O against Liquid Saffire 56

Peter Zijlstra <peterz@infradead.org>
    perf/x86: Fixup typo in stub functions

Eric Dumazet <edumazet@google.com>
    tcp/dccp: remove reqsk_put() from inet_child_forget()

Eric Dumazet <edumazet@google.com>
    gro_cells: make sure device is up in gro_cells_receive()

David Howells <dhowells@redhat.com>
    rxrpc: Fix client call queueing, waiting for channel

Stefano Brivio <sbrivio@redhat.com>
    vxlan: Fix GRO cells race condition between receive and link delete

Daniel Borkmann <daniel@iogearbox.net>
    ipvlan: disallow userns cap_net_admin to change global mode/flags

Al Viro <viro@zeniv.linux.org.uk>
    missing barriers in some of unix_sock ->addr and ->path accesses

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

Guillaume Nault <gnault@redhat.com>
    tcp: handle inet_csk_reqsk_queue_add() failures

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

Eric Dumazet <edumazet@google.com>
    l2tp: fix infoleak in l2tp_ip6_recvmsg()

Eric Biggers <ebiggers@google.com>
    KEYS: restrict /proc/keys by credentials at open time

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: Reference Counts: increase max to 0x4000 for large servers


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/x86/events/perf_event.h                       |  4 +-
 drivers/md/raid10.c                                |  1 -
 drivers/mmc/host/tmio_mmc_pio.c                    | 11 +++--
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |  9 ++++
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |  6 +--
 drivers/net/ethernet/renesas/ravb_main.c           |  2 +-
 drivers/net/ipvlan/ipvlan_main.c                   |  9 +++-
 drivers/net/phy/mdio_bus.c                         |  1 -
 drivers/net/ppp/pptp.c                             |  1 +
 drivers/net/vxlan.c                                | 14 ++++++-
 drivers/vhost/vsock.c                              |  2 +-
 include/acpi/acconfig.h                            |  2 +-
 include/linux/of.h                                 | 20 +++++----
 include/net/gro_cells.h                            | 22 ++++++++--
 net/hsr/hsr_device.c                               | 18 ++++----
 net/hsr/hsr_framereg.c                             | 12 ++++++
 net/hsr/hsr_framereg.h                             |  1 +
 net/ipv4/inet_connection_sock.c                    |  2 +-
 net/ipv4/route.c                                   |  4 ++
 net/ipv4/syncookies.c                              |  7 +++-
 net/ipv4/tcp_input.c                               |  8 +++-
 net/ipv6/route.c                                   |  2 +-
 net/ipv6/sit.c                                     |  5 ++-
 net/l2tp/l2tp_ip6.c                                |  4 +-
 net/rxrpc/conn_client.c                            |  4 +-
 net/unix/af_unix.c                                 | 48 +++++++++++++---------
 net/unix/diag.c                                    |  3 +-
 net/x25/af_x25.c                                   | 20 ++++++---
 security/keys/proc.c                               |  8 +---
 security/lsm_audit.c                               | 10 +++--
 sound/firewire/bebob/bebob.c                       | 14 ++++++-
 32 files changed, 191 insertions(+), 87 deletions(-)


