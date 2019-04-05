Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0FFC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D64520651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u7yjIHDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfDERau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:30:50 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39402 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfDER3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSvoI084520;
        Fri, 5 Apr 2019 12:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485337;
        bh=wLbTMB6JvlGhkudiqJaytzAf01DjFeR3t1p8ZD+MzoQ=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=u7yjIHDrw/YEEiG4R01D9gyDUa2ynDzyldXYBwEe3u/q8AV8U0xEVP/SPPazsqAK3
         jbdBVuhYPu/ZRj7VivP0iGxkbK3b5cQGBTX0T0OBImQpu1baTorWs7GcMY8wxMyRnm
         fU87ll70nnBFvbCyc4kim2X2btAD2LZzi08Q4tA8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HSvOM096328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:57 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:56 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuQ095744;
        Fri, 5 Apr 2019 12:28:56 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 03/14] net: hsr: remove unnecessary paranthesis from the code
Date:   Fri, 5 Apr 2019 13:31:25 -0400
Message-ID: <20190405173136.18050-4-m-karicheri2@ti.com>
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

This patch fixes unnecessary paranthesis from the code. This is
seen when ran checkpatch.pl -f option on files under net/hsr.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_device.c  |  7 +++----
 net/hsr/hsr_forward.c | 23 +++++++++++------------
 net/hsr/hsr_slave.c   |  4 ++--
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 34b6d6e8020f..cf5c3951d35a 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -67,7 +67,7 @@ static bool hsr_check_carrier(struct hsr_port *master)
 
 	rcu_read_lock();
 	hsr_for_each_port(master->hsr, port)
-		if ((port->type != HSR_PT_MASTER) && is_slave_up(port->dev)) {
+		if (port->type != HSR_PT_MASTER && is_slave_up(port->dev)) {
 			has_carrier = true;
 			break;
 		}
@@ -88,15 +88,14 @@ static void hsr_check_announce(struct net_device *hsr_dev,
 
 	hsr = netdev_priv(hsr_dev);
 
-	if ((hsr_dev->operstate == IF_OPER_UP)
-			&& (old_operstate != IF_OPER_UP)) {
+	if (hsr_dev->operstate == IF_OPER_UP && old_operstate != IF_OPER_UP) {
 		/* Went up */
 		hsr->announce_count = 0;
 		mod_timer(&hsr->announce_timer,
 			  jiffies + msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
 	}
 
-	if ((hsr_dev->operstate != IF_OPER_UP) && (old_operstate == IF_OPER_UP))
+	if (hsr_dev->operstate != IF_OPER_UP && old_operstate == IF_OPER_UP)
 		/* Went down */
 		del_timer(&hsr->announce_timer);
 }
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 70220e5a389a..fdc191015208 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -77,12 +77,11 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 		     &((struct hsrv0_ethhdr_sp *) skb_mac_header(skb))->hsr_sup;
 	}
 
-	if ((hsrSupTag->HSR_TLV_Type != HSR_TLV_ANNOUNCE) &&
-	    (hsrSupTag->HSR_TLV_Type != HSR_TLV_LIFE_CHECK))
+	if (hsrSupTag->HSR_TLV_Type != HSR_TLV_ANNOUNCE &&
+	    hsrSupTag->HSR_TLV_Type != HSR_TLV_LIFE_CHECK)
 		return false;
-	if ((hsrSupTag->HSR_TLV_Length != 12) &&
-			(hsrSupTag->HSR_TLV_Length !=
-					sizeof(struct hsr_sup_payload)))
+	if (hsrSupTag->HSR_TLV_Length != 12 &&
+	    hsrSupTag->HSR_TLV_Length != sizeof(struct hsr_sup_payload))
 		return false;
 
 	return true;
@@ -191,7 +190,7 @@ static struct sk_buff *frame_get_tagged_skb(struct hsr_frame_info *frame,
 	if (frame->skb_hsr)
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
 
-	if ((port->type != HSR_PT_SLAVE_A) && (port->type != HSR_PT_SLAVE_B)) {
+	if (port->type != HSR_PT_SLAVE_A && port->type != HSR_PT_SLAVE_B) {
 		WARN_ONCE(1, "HSR: Bug: trying to create a tagged frame for a non-ring port");
 		return NULL;
 	}
@@ -255,11 +254,11 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 			continue;
 
 		/* Don't deliver locally unless we should */
-		if ((port->type == HSR_PT_MASTER) && !frame->is_local_dest)
+		if (port->type == HSR_PT_MASTER && !frame->is_local_dest)
 			continue;
 
 		/* Deliver frames directly addressed to us to master only */
-		if ((port->type != HSR_PT_MASTER) && frame->is_local_exclusive)
+		if (port->type != HSR_PT_MASTER && frame->is_local_exclusive)
 			continue;
 
 		/* Don't send frame over port where it has been sent before */
@@ -267,7 +266,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 					   frame->sequence_nr))
 			continue;
 
-		if (frame->is_supervision && (port->type == HSR_PT_MASTER)) {
+		if (frame->is_supervision && port->type == HSR_PT_MASTER) {
 			hsr_handle_sup_frame(frame->skb_hsr,
 					     frame->node_src,
 					     frame->port_rcv);
@@ -301,9 +300,9 @@ static void check_local_dest(struct hsr_priv *hsr, struct sk_buff *skb,
 		frame->is_local_exclusive = false;
 	}
 
-	if ((skb->pkt_type == PACKET_HOST) ||
-	    (skb->pkt_type == PACKET_MULTICAST) ||
-	    (skb->pkt_type == PACKET_BROADCAST)) {
+	if (skb->pkt_type == PACKET_HOST ||
+	    skb->pkt_type == PACKET_MULTICAST ||
+	    skb->pkt_type == PACKET_BROADCAST) {
 		frame->is_local_dest = true;
 	} else {
 		frame->is_local_dest = false;
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 80151c255a1d..d506c694ee25 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -63,8 +63,8 @@ bool hsr_port_exists(const struct net_device *dev)
 static int hsr_check_dev_ok(struct net_device *dev)
 {
 	/* Don't allow HSR on non-ethernet like devices */
-	if ((dev->flags & IFF_LOOPBACK) || (dev->type != ARPHRD_ETHER) ||
-	    (dev->addr_len != ETH_ALEN)) {
+	if ((dev->flags & IFF_LOOPBACK) || dev->type != ARPHRD_ETHER ||
+	    dev->addr_len != ETH_ALEN) {
 		netdev_info(dev, "Cannot use loopback or non-ethernet device as HSR slave.\n");
 		return -EINVAL;
 	}
-- 
2.17.0

