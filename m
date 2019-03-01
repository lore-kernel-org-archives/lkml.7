Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF4D2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I0grtkRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfCAKyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:54:36 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47750 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:54:35 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2987F10C0EC8;
        Fri,  1 Mar 2019 02:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551437675; bh=A7GvTCKvRm6k75hbgGFs8Pd2A7AD1MnitEd+jE2Sa00=;
        h=From:To:Cc:Subject:Date:From;
        b=I0grtkRGSTQqajLVyBSfKAEqZWpRAthEaFZKvTW3hiH22cvNOivGfmChjLFFfhkh0
         b/O5FN7NEOEOp3TdqrpZL39gRnq/IsMmAf1RM1/Lq/TBjU9wh4x3sgD5ujvbK7LykG
         H4PUYPeh7+801SY2vr0UM/PwHNsk6qRh+fVOJ9wXu1exxWSL8tALK2nIKwV7YrdvB3
         RDJXTijLDef77WUY9PtiyAIsXya+1AT2dVRVsw8QdITtQUhzy1ypcPUG4/ysaFKlDw
         inYBNvbgZDJ2IeHnOq9BflgIY6CQpm6gXeU1TeaYsMw8+20i+Rwx35z3gifweWzVmd
         c+ihpuE4awykA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id E75E8501B;
        Fri,  1 Mar 2019 02:54:31 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [PATCH net 0/2] Use C45 Helpers when possible
Date:   Fri,  1 Mar 2019 11:54:22 +0100
Message-Id: <cover.1551437561.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For -net. Please review!

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Joao Pinto <joao.pinto@synopsys.com>

Jose Abreu (2):
  net: phy: Use C45 Helpers in phy_read_status()
  net: phy: Use C45 Helpers in PHY_FORCING state

 drivers/net/phy/phy.c |  2 +-
 include/linux/phy.h   | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.7.4

