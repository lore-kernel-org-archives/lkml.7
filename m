Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE4FC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE632084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfCYV1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:27:39 -0400
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:56325 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730260AbfCYV1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:27:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EDFAA837F24D;
        Mon, 25 Mar 2019 21:27:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leg34_24d507964b950
X-Filterd-Recvd-Size: 3589
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:27:32 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sridhar Samudrala <sridhar.samudrala@intel.com>,
        netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Bad file pattern in MAINTAINERS section 'NET_FAILOVER MODULE'
Date:   Mon, 25 Mar 2019 14:27:32 -0700
Message-Id: <20190325212732.27253-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	10683	NET_FAILOVER MODULE
	10684	M:	Sridhar Samudrala <sridhar.samudrala@intel.com>
	10685	L:	netdev@vger.kernel.org
	10686	S:	Supported
-->	10687	F:	driver/net/net_failover.c
	10688	F:	include/net/net_failover.h
	10689	F:	Documentation/networking/net_failover.rst

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'driver/net/net_failover.c':

commit cfc80d9a11635404a40199a1c9471c96890f3f74
Author: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date:   Thu May 24 09:55:15 2018 -0700

    net: Introduce net_failover driver
    
    The net_failover driver provides an automated failover mechanism via APIs
    to create and destroy a failover master netdev and manages a primary and
    standby slave netdevs that get registered via the generic failover
    infrastructure.
    
    The failover netdev acts a master device and controls 2 slave devices. The
    original paravirtual interface gets registered as 'standby' slave netdev and
    a passthru/vf device with the same MAC gets registered as 'primary' slave
    netdev. Both 'standby' and 'failover' netdevs are associated with the same
    'pci' device. The user accesses the network interface via 'failover' netdev.
    The 'failover' netdev chooses 'primary' netdev as default for transmits when
    it is available with link up and running.
    
    This can be used by paravirtual drivers to enable an alternate low latency
    datapath. It also enables hypervisor controlled live migration of a VM with
    direct attached VF by failing over to the paravirtual datapath when the VF
    is unplugged.
    
    Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

 Documentation/networking/net_failover.rst |  26 +
 MAINTAINERS                               |   8 +
 drivers/net/Kconfig                       |  12 +
 drivers/net/Makefile                      |   1 +
 drivers/net/net_failover.c                | 836 ++++++++++++++++++++++++++++++
 include/net/net_failover.h                |  40 ++
 6 files changed, 923 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'driver/net/net_failover.c' was found
