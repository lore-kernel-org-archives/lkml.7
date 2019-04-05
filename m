Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E34AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D920989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fBccI9sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfDER3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48592 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbfDER3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HT00F063315;
        Fri, 5 Apr 2019 12:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485340;
        bh=BpabQybvVs/CpIyNgUC3/B5FJsvcZRLei28kYHT6SqE=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=fBccI9sCfQBLUNqybTE3BAqTNsk+cPVEV3FoTRImodnf40mUrkLpjWqZNz7f88e4R
         e2JvsF5jKHp2GZWEqCbIML97OulE8m+H1KjQLamPNBLMz2fXKYIcvafWkBxaDKCx79
         URh4miZwHU4vtY3oXKBMntwibF9rAncbrrW1T/s0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HT0Dk096269
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:29:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:59 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuW095744;
        Fri, 5 Apr 2019 12:28:59 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 09/14] net: hsr: add missing space around operator in code
Date:   Fri, 5 Apr 2019 13:31:31 -0400
Message-ID: <20190405173136.18050-10-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190405173136.18050-1-m-karicheri2@ti.com>
References: <20190405173136.18050-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add missing space around operator in code. This is
seen when ran checkpatch.pl -f on files under net/hsr.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_forward.c  | 2 +-
 net/hsr/hsr_framereg.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index c4dfc2966f62..43f91651ba10 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -105,7 +105,7 @@ static struct sk_buff *create_stripped_skb(struct sk_buff *skb_in,
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		skb->csum_start -= HSR_HLEN;
 
-	copylen = 2*ETH_ALEN;
+	copylen = 2 * ETH_ALEN;
 	if (frame->is_vlan)
 		copylen += VLAN_HLEN;
 	src = skb_mac_header(skb_in);
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 1571ac101757..e61892506c66 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -385,9 +385,9 @@ void hsr_prune_nodes(struct timer_list *t)
 		time_b = node->time_in[HSR_PT_SLAVE_B];
 
 		/* Check for timestamps old enough to risk wrap-around */
-		if (time_after(jiffies, time_a + MAX_JIFFY_OFFSET/2))
+		if (time_after(jiffies, time_a + MAX_JIFFY_OFFSET / 2))
 			node->time_in_stale[HSR_PT_SLAVE_A] = true;
-		if (time_after(jiffies, time_b + MAX_JIFFY_OFFSET/2))
+		if (time_after(jiffies, time_b + MAX_JIFFY_OFFSET / 2))
 			node->time_in_stale[HSR_PT_SLAVE_B] = true;
 
 		/* Get age of newest frame from node.
@@ -402,7 +402,7 @@ void hsr_prune_nodes(struct timer_list *t)
 
 		/* Warn of ring error only as long as we get frames at all */
 		if (time_is_after_jiffies(timestamp +
-					msecs_to_jiffies(1.5*MAX_SLAVE_DIFF))) {
+				msecs_to_jiffies(1.5 * MAX_SLAVE_DIFF))) {
 			rcu_read_lock();
 			port = get_late_port(hsr, node);
 			if (port)
-- 
2.17.0

