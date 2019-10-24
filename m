Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7DDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40A420650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503261AbfJXPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:30:47 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:54128 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503247AbfJXPaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:30:46 -0400
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id HTWk2100E5USYZQ01TWkdw; Thu, 24 Oct 2019 17:30:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf4W-00078p-Ef; Thu, 24 Oct 2019 17:30:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf4W-00084V-Bf; Thu, 24 Oct 2019 17:30:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] tipc: Spelling s/enpoint/endpoint/
Date:   Thu, 24 Oct 2019 17:30:43 +0200
Message-Id: <20191024153043.30982-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelling of "endpoint".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 net/tipc/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 999eab592de8fe1b..7d7a661786078577 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1873,7 +1873,7 @@ void tipc_link_failover_prepare(struct tipc_link *l, struct tipc_link *tnl,
 
 	tipc_link_create_dummy_tnl_msg(tnl, xmitq);
 
-	/* This failover link enpoint was never established before,
+	/* This failover link endpoint was never established before,
 	 * so it has not received anything from peer.
 	 * Otherwise, it must be a normal failover situation or the
 	 * node has entered SELF_DOWN_PEER_LEAVING and both peer nodes
-- 
2.17.1

