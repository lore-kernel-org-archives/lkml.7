Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559FFC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151DD20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OrxYMy0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfDER3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56304 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfDER3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSuau130974;
        Fri, 5 Apr 2019 12:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485336;
        bh=hbpq4wY/xSLuA290tvxugCvCOnPOH5njRJ+/cZa0mBA=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=OrxYMy0Uoo9Sg/dq2bqY5FH8WaahwRpXu31dBvOHTql7MIT18DV9wBLx9SA/qr/Gz
         zXzFBaD80F6xm+PtDFsfXODiLoJAKSvktHkRB77MgP7/d9gWYg06obMQRawir+Yz54
         xk8QX2xFpORALHZqpV3l944TnASP3FEdip0JMAIk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HSufr096289
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:55 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuO095744;
        Fri, 5 Apr 2019 12:28:55 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 01/14] net: hsr: fix lines exceeding 80 characters
Date:   Fri, 5 Apr 2019 13:31:23 -0400
Message-ID: <20190405173136.18050-2-m-karicheri2@ti.com>
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

This patch fixes lines exceeding 80 characters. This is seen
when ran checkpatch.pl with -f option for files under
net/hsr.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_forward.c  |  3 ++-
 net/hsr/hsr_framereg.c |  8 +++++---
 net/hsr/hsr_main.c     |  3 ++-
 net/hsr/hsr_main.h     |  8 ++++----
 net/hsr/hsr_netlink.c  | 31 ++++++++++++++++++-------------
 5 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 04b5450c5a55..5346127708ae 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -75,7 +75,8 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 		hsrSupTag = &hsrV1Hdr->hsr_sup;
 	} else {
-		hsrSupTag = &((struct hsrv0_ethhdr_sp *) skb_mac_header(skb))->hsr_sup;
+		hsrSupTag =
+		     &((struct hsrv0_ethhdr_sp *) skb_mac_header(skb))->hsr_sup;
 	}
 
 	if ((hsrSupTag->HSR_TLV_Type != HSR_TLV_ANNOUNCE) &&
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 9af16cb68f76..5cd74d99abe9 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -255,7 +255,8 @@ void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 		if (!node_curr->time_in_stale[i] &&
 		    time_after(node_curr->time_in[i], node_real->time_in[i])) {
 			node_real->time_in[i] = node_curr->time_in[i];
-			node_real->time_in_stale[i] = node_curr->time_in_stale[i];
+			node_real->time_in_stale[i] =
+						node_curr->time_in_stale[i];
 		}
 		if (seq_nr_after(node_curr->seq_out[i], node_real->seq_out[i]))
 			node_real->seq_out[i] = node_curr->seq_out[i];
@@ -308,7 +309,8 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
 	if (!is_unicast_ether_addr(eth_hdr(skb)->h_dest))
 		return;
 
-	node_dst = find_node_by_AddrA(&port->hsr->node_db, eth_hdr(skb)->h_dest);
+	node_dst = find_node_by_AddrA(&port->hsr->node_db,
+				      eth_hdr(skb)->h_dest);
 	if (!node_dst) {
 		WARN_ONCE(1, "%s: Unknown node\n", __func__);
 		return;
@@ -419,7 +421,7 @@ void hsr_prune_nodes(struct timer_list *t)
 
 		/* Prune old entries */
 		if (time_is_before_jiffies(timestamp +
-					msecs_to_jiffies(HSR_NODE_FORGET_TIME))) {
+				msecs_to_jiffies(HSR_NODE_FORGET_TIME))) {
 			hsr_nl_nodedown(hsr, node->MacAddressA);
 			list_del_rcu(&node->mac_list);
 			/* Note that we need to free this entry later: */
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index cd37d0011b42..b7a4cf62286b 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -63,7 +63,8 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 
 		if (port->type == HSR_PT_SLAVE_A) {
 			ether_addr_copy(master->dev->dev_addr, dev->dev_addr);
-			call_netdevice_notifiers(NETDEV_CHANGEADDR, master->dev);
+			call_netdevice_notifiers(NETDEV_CHANGEADDR,
+						 master->dev);
 		}
 
 		/* Make sure we recognize frames from ourselves in hsr_rcv() */
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 9b9909e89e9e..6f05dc90aa9b 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -83,8 +83,8 @@ static inline u16 get_hsr_tag_LSDU_size(struct hsr_tag *ht)
 
 static inline void set_hsr_tag_path(struct hsr_tag *ht, u16 path)
 {
-	ht->path_and_LSDU_size = htons(
-			(ntohs(ht->path_and_LSDU_size) & 0x0FFF) | (path << 12));
+	ht->path_and_LSDU_size =
+		htons((ntohs(ht->path_and_LSDU_size) & 0x0FFF) | (path << 12));
 }
 
 static inline void set_hsr_tag_LSDU_size(struct hsr_tag *ht, u16 LSDU_size)
@@ -171,8 +171,8 @@ struct hsr_priv {
 	struct timer_list	prune_timer;
 	int announce_count;
 	u16 sequence_nr;
-	u16 sup_sequence_nr;			/* For HSRv1 separate seq_nr for supervision */
-	u8 protVersion;					/* Indicate if HSRv0 or HSRv1. */
+	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
+	u8 protVersion;		/* Indicate if HSRv0 or HSRv1. */
 	spinlock_t seqnr_lock;			/* locking for sequence_nr */
 	unsigned char		sup_multicast_addr[ETH_ALEN];
 };
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b9cce0fd5696..654d22dd428d 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -47,12 +47,14 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		netdev_info(dev, "HSR: Slave1 device not specified\n");
 		return -EINVAL;
 	}
-	link[0] = __dev_get_by_index(src_net, nla_get_u32(data[IFLA_HSR_SLAVE1]));
+	link[0] = __dev_get_by_index(src_net,
+				     nla_get_u32(data[IFLA_HSR_SLAVE1]));
 	if (!data[IFLA_HSR_SLAVE2]) {
 		netdev_info(dev, "HSR: Slave2 device not specified\n");
 		return -EINVAL;
 	}
-	link[1] = __dev_get_by_index(src_net, nla_get_u32(data[IFLA_HSR_SLAVE2]));
+	link[1] = __dev_get_by_index(src_net,
+				     nla_get_u32(data[IFLA_HSR_SLAVE2]));
 
 	if (!link[0] || !link[1])
 		return -ENODEV;
@@ -156,7 +158,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
 	if (!skb)
 		goto fail;
 
-	msg_head = genlmsg_put(skb, 0, 0, &hsr_genl_family, 0, HSR_C_RING_ERROR);
+	msg_head = genlmsg_put(skb, 0, 0, &hsr_genl_family, 0,
+			       HSR_C_RING_ERROR);
 	if (!msg_head)
 		goto nla_put_failure;
 
@@ -260,7 +263,7 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 		goto invalid;
 
 	hsr_dev = __dev_get_by_index(genl_info_net(info),
-					nla_get_u32(info->attrs[HSR_A_IFINDEX]));
+				     nla_get_u32(info->attrs[HSR_A_IFINDEX]));
 	if (!hsr_dev)
 		goto invalid;
 	if (!is_hsr_master(hsr_dev))
@@ -289,13 +292,14 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 
 	hsr = netdev_priv(hsr_dev);
 	res = hsr_get_node_data(hsr,
-			(unsigned char *) nla_data(info->attrs[HSR_A_NODE_ADDR]),
-			hsr_node_addr_b,
-			&addr_b_ifindex,
-			&hsr_node_if1_age,
-			&hsr_node_if1_seq,
-			&hsr_node_if2_age,
-			&hsr_node_if2_seq);
+				(unsigned char *)
+				nla_data(info->attrs[HSR_A_NODE_ADDR]),
+					 hsr_node_addr_b,
+					 &addr_b_ifindex,
+					 &hsr_node_if1_age,
+					 &hsr_node_if1_seq,
+					 &hsr_node_if2_age,
+					 &hsr_node_if2_seq);
 	if (res < 0)
 		goto nla_put_failure;
 
@@ -306,11 +310,12 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 
 	if (addr_b_ifindex > -1) {
 		res = nla_put(skb_out, HSR_A_NODE_ADDR_B, ETH_ALEN,
-								hsr_node_addr_b);
+			      hsr_node_addr_b);
 		if (res < 0)
 			goto nla_put_failure;
 
-		res = nla_put_u32(skb_out, HSR_A_ADDR_B_IFINDEX, addr_b_ifindex);
+		res = nla_put_u32(skb_out, HSR_A_ADDR_B_IFINDEX,
+				  addr_b_ifindex);
 		if (res < 0)
 			goto nla_put_failure;
 	}
-- 
2.17.0

