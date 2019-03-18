Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAA2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901970;
	bh=I7bkhA8Qtpt2hVnXc33UxArvc7yTXpNN6v6/UJBEOjE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=y6kPPqN8uc18OnpmxD/HPcdnrO/O0SNbyF4eKT/U5oChK5dSxVl3YlAyk5IkUsrIz
	 PyRTUdmPwnx6SZvmJGOEDtQu9XmI43Gb2fCNS5j7m+i2tT31F0k2HeCixicrbMayRL
	 5XktBKn+N4/BEucYuTAQu9UDPvtuy4g3W+qeX9aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbfCRJgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbfCRJgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:36:08 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7D042083D;
        Mon, 18 Mar 2019 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901767;
        bh=I7bkhA8Qtpt2hVnXc33UxArvc7yTXpNN6v6/UJBEOjE=;
        h=From:To:Cc:Subject:Date:From;
        b=Vlb7MEssgmcdipYSfJCAVrTZJlim3/nrigufrXv04kCACi7wpLlqKR0UTV6ox4zAJ
         sXi+s4qpvML5w0H0zz3wery5y0R9BeMKMnxypNAO6t41zfDXcxoKlH9YtrMgR2QELL
         ImV1xjpAHtHJ56MsOI7vkakCzdAoAc1oRTaZ06OY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/34] 4.14.107-stable review
Date:   Mon, 18 Mar 2019 10:25:24 +0100
Message-Id: <20190318084144.657740413@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.107-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.107-rc1
X-KernelTest-Deadline: 2019-03-20T08:41+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.107 release.
There are 34 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 20 08:41:26 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.107-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.107-rc1

Zha Bin <zhabin@linux.alibaba.com>
    vhost/vsock: fix vhost vsock cid hashing inconsistent

Xiao Ni <xni@redhat.com>
    It's wrong to add len to sector_nr in raid10 reshape twice

kbuild test robot <lkp@intel.com>
    perf/x86/intel: Make dev_attr_allow_tsx_force_abort static

Peter Zijlstra <peterz@infradead.org>
    perf/x86/intel: Fix memory corruption

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-motu: fix construction of PCM frame for capture direction

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O against Liquid Saffire 56

Peter Zijlstra <peterz@infradead.org>
    perf/x86: Fixup typo in stub functions

Daniel Borkmann <daniel@iogearbox.net>
    ipvlan: disallow userns cap_net_admin to change global mode/flags

Al Viro <viro@zeniv.linux.org.uk>
    missing barriers in some of unix_sock ->addr and ->path accesses

Michal Soltys <soltys@ziu.info>
    bonding: fix PACKET_ORIGDEV regression

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

Eric Dumazet <edumazet@google.com>
    l2tp: fix infoleak in l2tp_ip6_recvmsg()

Paolo Abeni <pabeni@redhat.com>
    ipv4/route: fail early when inet dev is missing

Eric Dumazet <edumazet@google.com>
    gro_cells: make sure device is up in gro_cells_receive()

Wang Nan <wangnan0@huawei.com>
    perf tools: Fix compile error with libunwind x86

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: Reference Counts: increase max to 0x4000 for large servers


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/x86/events/intel/core.c                       |  4 +-
 arch/x86/events/perf_event.h                       |  4 +-
 drivers/md/raid10.c                                |  1 -
 drivers/net/bonding/bond_main.c                    | 35 ++++++-------
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |  9 ++++
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |  6 +--
 drivers/net/ethernet/renesas/ravb_main.c           |  2 +-
 drivers/net/ipvlan/ipvlan_main.c                   |  9 +++-
 drivers/net/phy/mdio_bus.c                         |  1 -
 drivers/net/ppp/pptp.c                             |  1 +
 drivers/net/vxlan.c                                | 14 +++++-
 drivers/vhost/vsock.c                              |  2 +-
 include/acpi/acconfig.h                            |  2 +-
 net/core/gro_cells.c                               | 22 +++++++--
 net/hsr/hsr_device.c                               | 18 +++----
 net/hsr/hsr_framereg.c                             | 12 +++++
 net/hsr/hsr_framereg.h                             |  1 +
 net/ipv4/route.c                                   | 13 +++--
 net/ipv4/syncookies.c                              |  7 ++-
 net/ipv4/tcp_input.c                               |  8 ++-
 net/ipv4/tcp_ipv4.c                                |  9 +---
 net/ipv6/route.c                                   |  2 +-
 net/ipv6/sit.c                                     |  5 +-
 net/l2tp/l2tp_ip6.c                                |  4 +-
 net/rxrpc/conn_client.c                            |  4 +-
 net/unix/af_unix.c                                 | 57 +++++++++++++---------
 net/unix/diag.c                                    |  3 +-
 net/x25/af_x25.c                                   | 20 +++++---
 security/lsm_audit.c                               | 10 ++--
 sound/firewire/bebob/bebob.c                       | 14 +++++-
 sound/firewire/motu/amdtp-motu.c                   |  4 +-
 tools/perf/arch/x86/util/unwind-libunwind.c        |  2 +-
 33 files changed, 199 insertions(+), 110 deletions(-)


