Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E6C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C7420989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TBNZCggI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfDER3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39432 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbfDER3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HT1lR084563;
        Fri, 5 Apr 2019 12:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485341;
        bh=4N8eqxzhFOQTeXsuqHB+hSmqOGNllSSVO6UF4aEi7SI=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=TBNZCggISyF5HWJfpTiQO7iiHZt489/mEqdvp/Sg2sVJX+VfR+k8iqsT+pvbH9p9l
         mA8+zNYPXhLdlHfeCNxayDf0Xa4a10pZobOBBCf1coR2yg/7V/AuwmQCvidx8e5E02
         SrW88Jl0xFuPG13r2/UhHNbEibRJFA3PoyIxA2OM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HT19q096362
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:29:01 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:29:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:29:00 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuX095744;
        Fri, 5 Apr 2019 12:29:00 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 10/14] net: hsr: remove camel case usage in the code
Date:   Fri, 5 Apr 2019 13:31:32 -0400
Message-ID: <20190405173136.18050-11-m-karicheri2@ti.com>
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

Current driver code uses camel case in many places. This is
seen when ran checkpatch.pl -f on files under net/hsr. This
patch fixes the code to remove camel case usage.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_device.c   | 29 ++++++++---------
 net/hsr/hsr_forward.c  | 38 +++++++++++------------
 net/hsr/hsr_framereg.c | 70 +++++++++++++++++++++---------------------
 net/hsr/hsr_main.h     | 14 ++++-----
 4 files changed, 76 insertions(+), 75 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 245fc531d39f..99142226622c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -243,7 +243,7 @@ static const struct header_ops hsr_header_ops = {
 };
 
 static void send_hsr_supervision_frame(struct hsr_port *master,
-				       u8 type, u8 hsrVer)
+				       u8 type, u8 hsr_ver)
 {
 	struct sk_buff *skb;
 	int hlen, tlen;
@@ -264,28 +264,28 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	skb_reserve(skb, hlen);
 
 	skb->dev = master->dev;
-	skb->protocol = htons(hsrVer ? ETH_P_HSR : ETH_P_PRP);
+	skb->protocol = htons(hsr_ver ? ETH_P_HSR : ETH_P_PRP);
 	skb->priority = TC_PRIO_CONTROL;
 
-	if (dev_hard_header(skb, skb->dev, (hsrVer ? ETH_P_HSR : ETH_P_PRP),
+	if (dev_hard_header(skb, skb->dev, (hsr_ver ? ETH_P_HSR : ETH_P_PRP),
 			    master->hsr->sup_multicast_addr,
 			    skb->dev->dev_addr, skb->len) <= 0)
 		goto out;
 	skb_reset_mac_header(skb);
 
-	if (hsrVer > 0) {
+	if (hsr_ver > 0) {
 		hsr_tag = skb_put(skb, sizeof(struct hsr_tag));
 		hsr_tag->encap_proto = htons(ETH_P_PRP);
 		set_hsr_tag_LSDU_size(hsr_tag, HSR_V1_SUP_LSDUSIZE);
 	}
 
 	hsr_stag = skb_put(skb, sizeof(struct hsr_sup_tag));
-	set_hsr_stag_path(hsr_stag, (hsrVer ? 0x0 : 0xf));
-	set_hsr_stag_HSR_Ver(hsr_stag, hsrVer);
+	set_hsr_stag_path(hsr_stag, (hsr_ver ? 0x0 : 0xf));
+	set_hsr_stag_HSR_ver(hsr_stag, hsr_ver);
 
 	/* From HSRv1 on we have separate supervision sequence numbers. */
 	spin_lock_irqsave(&master->hsr->seqnr_lock, irqflags);
-	if (hsrVer > 0) {
+	if (hsr_ver > 0) {
 		hsr_stag->sequence_nr = htons(master->hsr->sup_sequence_nr);
 		hsr_tag->sequence_nr = htons(master->hsr->sequence_nr);
 		master->hsr->sup_sequence_nr++;
@@ -296,13 +296,14 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	}
 	spin_unlock_irqrestore(&master->hsr->seqnr_lock, irqflags);
 
-	hsr_stag->HSR_TLV_Type = type;
+	hsr_stag->HSR_TLV_type = type;
 	/* TODO: Why 12 in HSRv0? */
-	hsr_stag->HSR_TLV_Length = hsrVer ? sizeof(struct hsr_sup_payload) : 12;
+	hsr_stag->HSR_TLV_length =
+				hsr_ver ? sizeof(struct hsr_sup_payload) : 12;
 
 	/* Payload: MacAddressA */
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-	ether_addr_copy(hsr_sp->MacAddressA, master->dev->dev_addr);
+	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
 
 	if (skb_put_padto(skb, ETH_ZLEN + HSR_HLEN))
 		return;
@@ -328,15 +329,15 @@ static void hsr_announce(struct timer_list *t)
 	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 
-	if (hsr->announce_count < 3 && hsr->protVersion == 0) {
+	if (hsr->announce_count < 3 && hsr->prot_version == 0) {
 		send_hsr_supervision_frame(master, HSR_TLV_ANNOUNCE,
-					   hsr->protVersion);
+					   hsr->prot_version);
 		hsr->announce_count++;
 
 		interval = msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
 	} else {
 		send_hsr_supervision_frame(master, HSR_TLV_LIFE_CHECK,
-					   hsr->protVersion);
+					   hsr->prot_version);
 
 		interval = msecs_to_jiffies(HSR_LIFE_CHECK_INTERVAL);
 	}
@@ -455,7 +456,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
 	hsr->sup_multicast_addr[ETH_ALEN - 1] = multicast_spec;
 
-	hsr->protVersion = protocol_version;
+	hsr->prot_version = protocol_version;
 
 	/* FIXME: should I modify the value of these?
 	 *
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 43f91651ba10..602029c44050 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -48,40 +48,40 @@ struct hsr_frame_info {
  */
 static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 {
-	struct ethhdr *ethHdr;
-	struct hsr_sup_tag *hsrSupTag;
-	struct hsrv1_ethhdr_sp *hsrV1Hdr;
+	struct ethhdr *eth_hdr;
+	struct hsr_sup_tag *hsr_sup_tag;
+	struct hsrv1_ethhdr_sp *hsr_V1_hdr;
 
 	WARN_ON_ONCE(!skb_mac_header_was_set(skb));
-	ethHdr = (struct ethhdr *)skb_mac_header(skb);
+	eth_hdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* Correct addr? */
-	if (!ether_addr_equal(ethHdr->h_dest,
+	if (!ether_addr_equal(eth_hdr->h_dest,
 			      hsr->sup_multicast_addr))
 		return false;
 
 	/* Correct ether type?. */
-	if (!(ethHdr->h_proto == htons(ETH_P_PRP) ||
-	      ethHdr->h_proto == htons(ETH_P_HSR)))
+	if (!(eth_hdr->h_proto == htons(ETH_P_PRP) ||
+	      eth_hdr->h_proto == htons(ETH_P_HSR)))
 		return false;
 
 	/* Get the supervision header from correct location. */
-	if (ethHdr->h_proto == htons(ETH_P_HSR)) { /* Okay HSRv1. */
-		hsrV1Hdr = (struct hsrv1_ethhdr_sp *)skb_mac_header(skb);
-		if (hsrV1Hdr->hsr.encap_proto != htons(ETH_P_PRP))
+	if (eth_hdr->h_proto == htons(ETH_P_HSR)) { /* Okay HSRv1. */
+		hsr_V1_hdr = (struct hsrv1_ethhdr_sp *)skb_mac_header(skb);
+		if (hsr_V1_hdr->hsr.encap_proto != htons(ETH_P_PRP))
 			return false;
 
-		hsrSupTag = &hsrV1Hdr->hsr_sup;
+		hsr_sup_tag = &hsr_V1_hdr->hsr_sup;
 	} else {
-		hsrSupTag =
+		hsr_sup_tag =
 		     &((struct hsrv0_ethhdr_sp *)skb_mac_header(skb))->hsr_sup;
 	}
 
-	if (hsrSupTag->HSR_TLV_Type != HSR_TLV_ANNOUNCE &&
-	    hsrSupTag->HSR_TLV_Type != HSR_TLV_LIFE_CHECK)
+	if (hsr_sup_tag->HSR_TLV_type != HSR_TLV_ANNOUNCE &&
+	    hsr_sup_tag->HSR_TLV_type != HSR_TLV_LIFE_CHECK)
 		return false;
-	if (hsrSupTag->HSR_TLV_Length != 12 &&
-	    hsrSupTag->HSR_TLV_Length != sizeof(struct hsr_sup_payload))
+	if (hsr_sup_tag->HSR_TLV_length != 12 &&
+	    hsr_sup_tag->HSR_TLV_length != sizeof(struct hsr_sup_payload))
 		return false;
 
 	return true;
@@ -125,7 +125,7 @@ static struct sk_buff *frame_get_stripped_skb(struct hsr_frame_info *frame,
 }
 
 static void hsr_fill_tag(struct sk_buff *skb, struct hsr_frame_info *frame,
-			 struct hsr_port *port, u8 protoVersion)
+			 struct hsr_port *port, u8 proto_version)
 {
 	struct hsr_ethhdr *hsr_ethhdr;
 	int lane_id;
@@ -146,7 +146,7 @@ static void hsr_fill_tag(struct sk_buff *skb, struct hsr_frame_info *frame,
 	set_hsr_tag_LSDU_size(&hsr_ethhdr->hsr_tag, lsdu_size);
 	hsr_ethhdr->hsr_tag.sequence_nr = htons(frame->sequence_nr);
 	hsr_ethhdr->hsr_tag.encap_proto = hsr_ethhdr->ethhdr.h_proto;
-	hsr_ethhdr->ethhdr.h_proto = htons(protoVersion ?
+	hsr_ethhdr->ethhdr.h_proto = htons(proto_version ?
 			ETH_P_HSR : ETH_P_PRP);
 }
 
@@ -176,7 +176,7 @@ static struct sk_buff *create_tagged_skb(struct sk_buff *skb_o,
 	memmove(dst, src, movelen);
 	skb_reset_mac_header(skb);
 
-	hsr_fill_tag(skb, frame, port, port->hsr->protVersion);
+	hsr_fill_tag(skb, frame, port, port->hsr->prot_version);
 
 	return skb;
 }
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index e61892506c66..cba4b2486050 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -24,10 +24,10 @@
 
 struct hsr_node {
 	struct list_head	mac_list;
-	unsigned char		MacAddressA[ETH_ALEN];
-	unsigned char		MacAddressB[ETH_ALEN];
+	unsigned char		macaddress_A[ETH_ALEN];
+	unsigned char		macaddress_B[ETH_ALEN];
 	/* Local slave through which AddrB frames are received from this node */
-	enum hsr_port_type	AddrB_port;
+	enum hsr_port_type	addr_B_port;
 	unsigned long		time_in[HSR_PT_PORTS];
 	bool			time_in_stale[HSR_PT_PORTS];
 	u16			seq_out[HSR_PT_PORTS];
@@ -64,9 +64,9 @@ bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 		return false;
 	}
 
-	if (ether_addr_equal(addr, node->MacAddressA))
+	if (ether_addr_equal(addr, node->macaddress_A))
 		return true;
-	if (ether_addr_equal(addr, node->MacAddressB))
+	if (ether_addr_equal(addr, node->macaddress_B))
 		return true;
 
 	return false;
@@ -74,13 +74,13 @@ bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 
 /* Search for mac entry. Caller must hold rcu read lock.
  */
-static struct hsr_node *find_node_by_AddrA(struct list_head *node_db,
-					   const unsigned char addr[ETH_ALEN])
+static struct hsr_node *find_node_by_addr_A(struct list_head *node_db,
+					    const unsigned char addr[ETH_ALEN])
 {
 	struct hsr_node *node;
 
 	list_for_each_entry_rcu(node, node_db, mac_list) {
-		if (ether_addr_equal(node->MacAddressA, addr))
+		if (ether_addr_equal(node->macaddress_A, addr))
 			return node;
 	}
 
@@ -100,8 +100,8 @@ int hsr_create_self_node(struct list_head *self_node_db,
 	if (!node)
 		return -ENOMEM;
 
-	ether_addr_copy(node->MacAddressA, addr_a);
-	ether_addr_copy(node->MacAddressB, addr_b);
+	ether_addr_copy(node->macaddress_A, addr_a);
+	ether_addr_copy(node->macaddress_B, addr_b);
 
 	rcu_read_lock();
 	oldnode = list_first_or_null_rcu(self_node_db,
@@ -132,7 +132,7 @@ void hsr_del_node(struct list_head *self_node_db)
 	}
 }
 
-/* Allocate an hsr_node and add it to node_db. 'addr' is the node's AddressA;
+/* Allocate an hsr_node and add it to node_db. 'addr' is the node's address_A;
  * seq_out is used to initialize filtering of outgoing duplicate frames
  * originating from the newly added node.
  */
@@ -147,7 +147,7 @@ struct hsr_node *hsr_add_node(struct list_head *node_db, unsigned char addr[],
 	if (!node)
 		return NULL;
 
-	ether_addr_copy(node->MacAddressA, addr);
+	ether_addr_copy(node->macaddress_A, addr);
 
 	/* We are only interested in time diffs here, so use current jiffies
 	 * as initialization. (0 could trigger an spurious ring error warning).
@@ -179,9 +179,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	list_for_each_entry_rcu(node, node_db, mac_list) {
-		if (ether_addr_equal(node->MacAddressA, ethhdr->h_source))
+		if (ether_addr_equal(node->macaddress_A, ethhdr->h_source))
 			return node;
-		if (ether_addr_equal(node->MacAddressB, ethhdr->h_source))
+		if (ether_addr_equal(node->macaddress_B, ethhdr->h_source))
 			return node;
 	}
 
@@ -205,8 +205,8 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 	return hsr_add_node(node_db, ethhdr->h_source, seq_out);
 }
 
-/* Use the Supervision frame's info about an eventual MacAddressB for merging
- * nodes that has previously had their MacAddressB registered as a separate
+/* Use the Supervision frame's info about an eventual macaddress_B for merging
+ * nodes that has previously had their macaddress_B registered as a separate
  * node.
  */
 void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
@@ -232,12 +232,12 @@ void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 
 	hsr_sp = (struct hsr_sup_payload *)skb->data;
 
-	/* Merge node_curr (registered on MacAddressB) into node_real */
+	/* Merge node_curr (registered on macaddress_B) into node_real */
 	node_db = &port_rcv->hsr->node_db;
-	node_real = find_node_by_AddrA(node_db, hsr_sp->MacAddressA);
+	node_real = find_node_by_addr_A(node_db, hsr_sp->macaddress_A);
 	if (!node_real)
 		/* No frame received from AddrA of this node yet */
-		node_real = hsr_add_node(node_db, hsr_sp->MacAddressA,
+		node_real = hsr_add_node(node_db, hsr_sp->macaddress_A,
 					 HSR_SEQNR_START - 1);
 	if (!node_real)
 		goto done; /* No mem */
@@ -245,7 +245,7 @@ void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 		/* Node has already been merged */
 		goto done;
 
-	ether_addr_copy(node_real->MacAddressB, ethhdr->h_source);
+	ether_addr_copy(node_real->macaddress_B, ethhdr->h_source);
 	for (i = 0; i < HSR_PT_PORTS; i++) {
 		if (!node_curr->time_in_stale[i] &&
 		    time_after(node_curr->time_in[i], node_real->time_in[i])) {
@@ -256,7 +256,7 @@ void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 		if (seq_nr_after(node_curr->seq_out[i], node_real->seq_out[i]))
 			node_real->seq_out[i] = node_curr->seq_out[i];
 	}
-	node_real->AddrB_port = port_rcv->type;
+	node_real->addr_B_port = port_rcv->type;
 
 	list_del_rcu(&node_curr->mac_list);
 	kfree_rcu(node_curr, rcu_head);
@@ -268,7 +268,7 @@ void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 /* 'skb' is a frame meant for this host, that is to be passed to upper layers.
  *
  * If the frame was sent by a node's B interface, replace the source
- * address with that node's "official" address (MacAddressA) so that upper
+ * address with that node's "official" address (macaddress_A) so that upper
  * layers recognize where it came from.
  */
 void hsr_addr_subst_source(struct hsr_node *node, struct sk_buff *skb)
@@ -278,7 +278,7 @@ void hsr_addr_subst_source(struct hsr_node *node, struct sk_buff *skb)
 		return;
 	}
 
-	memcpy(&eth_hdr(skb)->h_source, node->MacAddressA, ETH_ALEN);
+	memcpy(&eth_hdr(skb)->h_source, node->macaddress_A, ETH_ALEN);
 }
 
 /* 'skb' is a frame meant for another host.
@@ -303,16 +303,16 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
 	if (!is_unicast_ether_addr(eth_hdr(skb)->h_dest))
 		return;
 
-	node_dst = find_node_by_AddrA(&port->hsr->node_db,
-				      eth_hdr(skb)->h_dest);
+	node_dst = find_node_by_addr_A(&port->hsr->node_db,
+				       eth_hdr(skb)->h_dest);
 	if (!node_dst) {
 		WARN_ONCE(1, "%s: Unknown node\n", __func__);
 		return;
 	}
-	if (port->type != node_dst->AddrB_port)
+	if (port->type != node_dst->addr_B_port)
 		return;
 
-	ether_addr_copy(eth_hdr(skb)->h_dest, node_dst->MacAddressB);
+	ether_addr_copy(eth_hdr(skb)->h_dest, node_dst->macaddress_B);
 }
 
 void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
@@ -406,14 +406,14 @@ void hsr_prune_nodes(struct timer_list *t)
 			rcu_read_lock();
 			port = get_late_port(hsr, node);
 			if (port)
-				hsr_nl_ringerror(hsr, node->MacAddressA, port);
+				hsr_nl_ringerror(hsr, node->macaddress_A, port);
 			rcu_read_unlock();
 		}
 
 		/* Prune old entries */
 		if (time_is_before_jiffies(timestamp +
 				msecs_to_jiffies(HSR_NODE_FORGET_TIME))) {
-			hsr_nl_nodedown(hsr, node->MacAddressA);
+			hsr_nl_nodedown(hsr, node->macaddress_A);
 			list_del_rcu(&node->mac_list);
 			/* Note that we need to free this entry later: */
 			kfree_rcu(node, rcu_head);
@@ -431,13 +431,13 @@ void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
 		node = list_first_or_null_rcu(&hsr->node_db,
 					      struct hsr_node, mac_list);
 		if (node)
-			ether_addr_copy(addr, node->MacAddressA);
+			ether_addr_copy(addr, node->macaddress_A);
 		return node;
 	}
 
 	node = _pos;
 	list_for_each_entry_continue_rcu(node, &hsr->node_db, mac_list) {
-		ether_addr_copy(addr, node->MacAddressA);
+		ether_addr_copy(addr, node->macaddress_A);
 		return node;
 	}
 
@@ -458,13 +458,13 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 	unsigned long tdiff;
 
 	rcu_read_lock();
-	node = find_node_by_AddrA(&hsr->node_db, addr);
+	node = find_node_by_addr_A(&hsr->node_db, addr);
 	if (!node) {
 		rcu_read_unlock();
 		return -ENOENT;	/* No such entry */
 	}
 
-	ether_addr_copy(addr_b, node->MacAddressB);
+	ether_addr_copy(addr_b, node->macaddress_B);
 
 	tdiff = jiffies - node->time_in[HSR_PT_SLAVE_A];
 	if (node->time_in_stale[HSR_PT_SLAVE_A])
@@ -490,8 +490,8 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 	*if1_seq = node->seq_out[HSR_PT_SLAVE_B];
 	*if2_seq = node->seq_out[HSR_PT_SLAVE_A];
 
-	if (node->AddrB_port != HSR_PT_NONE) {
-		port = hsr_port_get_hsr(hsr, node->AddrB_port);
+	if (node->addr_B_port != HSR_PT_NONE) {
+		port = hsr_port_get_hsr(hsr, node->addr_B_port);
 		*addr_b_ifindex = port->dev->ifindex;
 	} else {
 		*addr_b_ifindex = -1;
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 5d28a5371765..d312e8c777ae 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -97,14 +97,14 @@ struct hsr_ethhdr {
  * Field names as defined in the IEC:2010 standard for HSR.
  */
 struct hsr_sup_tag {
-	__be16		path_and_HSR_Ver;
+	__be16		path_and_HSR_ver;
 	__be16		sequence_nr;
-	__u8		HSR_TLV_Type;
-	__u8		HSR_TLV_Length;
+	__u8		HSR_TLV_type;
+	__u8		HSR_TLV_length;
 } __packed;
 
 struct hsr_sup_payload {
-	unsigned char	MacAddressA[ETH_ALEN];
+	unsigned char	macaddress_A[ETH_ALEN];
 } __packed;
 
 static inline u16 get_hsr_stag_path(struct hsr_sup_tag *hst)
@@ -122,9 +122,9 @@ static inline void set_hsr_stag_path(struct hsr_sup_tag *hst, u16 path)
 	set_hsr_tag_path((struct hsr_tag *)hst, path);
 }
 
-static inline void set_hsr_stag_HSR_Ver(struct hsr_sup_tag *hst, u16 HSR_Ver)
+static inline void set_hsr_stag_HSR_ver(struct hsr_sup_tag *hst, u16 HSR_ver)
 {
-	set_hsr_tag_LSDU_size((struct hsr_tag *)hst, HSR_Ver);
+	set_hsr_tag_LSDU_size((struct hsr_tag *)hst, HSR_ver);
 }
 
 struct hsrv0_ethhdr_sp {
@@ -164,7 +164,7 @@ struct hsr_priv {
 	int announce_count;
 	u16 sequence_nr;
 	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
-	u8 protVersion;		/* Indicate if HSRv0 or HSRv1. */
+	u8 prot_version;		/* Indicate if HSRv0 or HSRv1. */
 	spinlock_t seqnr_lock;			/* locking for sequence_nr */
 	unsigned char		sup_multicast_addr[ETH_ALEN];
 };
-- 
2.17.0

