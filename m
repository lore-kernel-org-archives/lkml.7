Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A6AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9132A20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nwP4seM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfDERbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:31:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48576 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDER3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSuA6063296;
        Fri, 5 Apr 2019 12:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485336;
        bh=RmJLF95n3S9mjBjc3QNZt/Dfc7HeqSQHMON4v9t/6Z4=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=nwP4seM5ROoTaF7jMnJRFgEgLbrWBmk4CeyInlsHhImCLLxpxp3U9JfNK7oyJaPAQ
         XIAYjpqv67rt+WBrbmfEJCZ+bbsF/Mo5+pzJvoueEammBj7bRR0mTs83Xt5iE0xUhJ
         l8tsUtTBI4h2e5+iZDIL5K+y6+LxpBJgmVEseELw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HSuar096319
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:56 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:55 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuP095744;
        Fri, 5 Apr 2019 12:28:55 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 02/14] net: hsr: fix multiple blank lines in the code
Date:   Fri, 5 Apr 2019 13:31:24 -0400
Message-ID: <20190405173136.18050-3-m-karicheri2@ti.com>
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

This patch fixes multiple blank lines in the code. This is seen
when ran checkpatch.pl -f option for files under net/hsr

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_device.c   | 10 ----------
 net/hsr/hsr_forward.c  |  8 --------
 net/hsr/hsr_framereg.c | 12 ------------
 net/hsr/hsr_main.c     |  3 ---
 net/hsr/hsr_main.h     |  7 -------
 net/hsr/hsr_netlink.c  | 12 ------------
 net/hsr/hsr_slave.c    |  3 ---
 7 files changed, 55 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index a97bf326b231..34b6d6e8020f 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -23,7 +23,6 @@
 #include "hsr_main.h"
 #include "hsr_forward.h"
 
-
 static bool is_admin_up(struct net_device *dev)
 {
 	return dev && (dev->flags & IFF_UP);
@@ -82,7 +81,6 @@ static bool hsr_check_carrier(struct hsr_port *master)
 	return has_carrier;
 }
 
-
 static void hsr_check_announce(struct net_device *hsr_dev,
 			       unsigned char old_operstate)
 {
@@ -136,7 +134,6 @@ int hsr_get_max_mtu(struct hsr_priv *hsr)
 	return mtu_max - HSR_HLEN;
 }
 
-
 static int hsr_dev_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct hsr_priv *hsr;
@@ -191,14 +188,12 @@ static int hsr_dev_open(struct net_device *dev)
 	return 0;
 }
 
-
 static int hsr_dev_close(struct net_device *dev)
 {
 	/* Nothing to do here. */
 	return 0;
 }
 
-
 static netdev_features_t hsr_features_recompute(struct hsr_priv *hsr,
 						netdev_features_t features)
 {
@@ -231,7 +226,6 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
 	return hsr_features_recompute(hsr, features);
 }
 
-
 static int hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct hsr_priv *hsr = netdev_priv(dev);
@@ -244,7 +238,6 @@ static int hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-
 static const struct header_ops hsr_header_ops = {
 	.create	 = eth_header,
 	.parse	 = eth_header_parse,
@@ -324,7 +317,6 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	kfree_skb(skb);
 }
 
-
 /* Announce (supervision frame) timer function
  */
 static void hsr_announce(struct timer_list *t)
@@ -357,7 +349,6 @@ static void hsr_announce(struct timer_list *t)
 	rcu_read_unlock();
 }
 
-
 /* According to comments in the declaration of struct net_device, this function
  * is "Called from unregister, can be used to call free_netdev". Ok then...
  */
@@ -423,7 +414,6 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->features |= NETIF_F_NETNS_LOCAL;
 }
 
-
 /* Return true if dev is a HSR master; return false otherwise.
  */
 inline bool is_hsr_master(struct net_device *dev)
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 5346127708ae..70220e5a389a 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -17,7 +17,6 @@
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
-
 struct hsr_node;
 
 struct hsr_frame_info {
@@ -32,7 +31,6 @@ struct hsr_frame_info {
 	bool is_local_exclusive;
 };
 
-
 /* The uses I can see for these HSR supervision frames are:
  * 1) Use the frames that are sent after node initialization ("HSR_TLV.Type =
  *    22") to reset any sequence_nr counters belonging to that node. Useful if
@@ -90,7 +88,6 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	return true;
 }
 
-
 static struct sk_buff *create_stripped_skb(struct sk_buff *skb_in,
 					   struct hsr_frame_info *frame)
 {
@@ -128,7 +125,6 @@ static struct sk_buff *frame_get_stripped_skb(struct hsr_frame_info *frame,
 	return skb_clone(frame->skb_std, GFP_ATOMIC);
 }
 
-
 static void hsr_fill_tag(struct sk_buff *skb, struct hsr_frame_info *frame,
 			 struct hsr_port *port, u8 protoVersion)
 {
@@ -203,7 +199,6 @@ static struct sk_buff *frame_get_tagged_skb(struct hsr_frame_info *frame,
 	return create_tagged_skb(frame->skb_std, frame, port);
 }
 
-
 static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
 			       struct hsr_node *node_src)
 {
@@ -238,7 +233,6 @@ static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 	return dev_queue_xmit(skb);
 }
 
-
 /* Forward the frame through all devices except:
  * - Back through the receiving device
  * - If it's a HSR frame: through a device where it has passed before
@@ -297,7 +291,6 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 	}
 }
 
-
 static void check_local_dest(struct hsr_priv *hsr, struct sk_buff *skb,
 			     struct hsr_frame_info *frame)
 {
@@ -317,7 +310,6 @@ static void check_local_dest(struct hsr_priv *hsr, struct sk_buff *skb,
 	}
 }
 
-
 static int hsr_fill_frame_info(struct hsr_frame_info *frame,
 			       struct sk_buff *skb, struct hsr_port *port)
 {
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 5cd74d99abe9..47dbaf2faefa 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -22,7 +22,6 @@
 #include "hsr_framereg.h"
 #include "hsr_netlink.h"
 
-
 struct hsr_node {
 	struct list_head	mac_list;
 	unsigned char		MacAddressA[ETH_ALEN];
@@ -35,10 +34,8 @@ struct hsr_node {
 	struct rcu_head		rcu_head;
 };
 
-
 /*	TODO: use hash lists for mac addresses (linux/jhash.h)?    */
 
-
 /* seq_nr_after(a, b) - return true if a is after (higher in sequence than) b,
  * false otherwise.
  */
@@ -56,7 +53,6 @@ static bool seq_nr_after(u16 a, u16 b)
 #define seq_nr_after_or_eq(a, b)	(!seq_nr_before((a), (b)))
 #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
 
-
 bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 {
 	struct hsr_node *node;
@@ -91,7 +87,6 @@ static struct hsr_node *find_node_by_AddrA(struct list_head *node_db,
 	return NULL;
 }
 
-
 /* Helper for device init; the self_node_db is used in hsr_rcv() to recognize
  * frames from self that's been looped over the HSR ring.
  */
@@ -270,7 +265,6 @@ void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 	skb_push(skb, sizeof(struct hsrv1_ethhdr_sp));
 }
 
-
 /* 'skb' is a frame meant for this host, that is to be passed to upper layers.
  *
  * If the frame was sent by a node's B interface, replace the source
@@ -321,7 +315,6 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
 	ether_addr_copy(eth_hdr(skb)->h_dest, node_dst->MacAddressB);
 }
 
-
 void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
 			   u16 sequence_nr)
 {
@@ -354,7 +347,6 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
 	return 0;
 }
 
-
 static struct hsr_port *get_late_port(struct hsr_priv *hsr,
 				      struct hsr_node *node)
 {
@@ -375,7 +367,6 @@ static struct hsr_port *get_late_port(struct hsr_priv *hsr,
 	return NULL;
 }
 
-
 /* Remove stale sequence_nr records. Called by timer every
  * HSR_LIFE_CHECK_INTERVAL (two seconds or so).
  */
@@ -431,7 +422,6 @@ void hsr_prune_nodes(struct timer_list *t)
 	rcu_read_unlock();
 }
 
-
 void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
 			unsigned char addr[ETH_ALEN])
 {
@@ -454,7 +444,6 @@ void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
 	return NULL;
 }
 
-
 int hsr_get_node_data(struct hsr_priv *hsr,
 		      const unsigned char *addr,
 		      unsigned char addr_b[ETH_ALEN],
@@ -468,7 +457,6 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 	struct hsr_port *port;
 	unsigned long tdiff;
 
-
 	rcu_read_lock();
 	node = find_node_by_AddrA(&hsr->node_db, addr);
 	if (!node) {
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index b7a4cf62286b..0d4ab8fc0aa1 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -19,7 +19,6 @@
 #include "hsr_framereg.h"
 #include "hsr_slave.h"
 
-
 static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 			     void *ptr)
 {
@@ -98,7 +97,6 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_DONE;
 }
 
-
 struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt)
 {
 	struct hsr_port *port;
@@ -113,7 +111,6 @@ static struct notifier_block hsr_nb = {
 	.notifier_call = hsr_netdev_notify,	/* Slave event notifications */
 };
 
-
 static int __init hsr_init(void)
 {
 	int res;
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 6f05dc90aa9b..3504f0647942 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -15,7 +15,6 @@
 #include <linux/netdevice.h>
 #include <linux/list.h>
 
-
 /* Time constants as specified in the HSR specification (IEC-62439-3 2010)
  * Table 8.
  * All values in milliseconds.
@@ -24,7 +23,6 @@
 #define HSR_NODE_FORGET_TIME		60000 /* ms */
 #define HSR_ANNOUNCE_INTERVAL		  100 /* ms */
 
-
 /* By how much may slave1 and slave2 timestamps of latest received frame from
  * each node differ before we notify of communication problem?
  */
@@ -32,17 +30,14 @@
 #define HSR_SEQNR_START			(USHRT_MAX - 1024)
 #define HSR_SUP_SEQNR_START		(HSR_SEQNR_START / 2)
 
-
 /* How often shall we check for broken ring and remove node entries older than
  * HSR_NODE_FORGET_TIME?
  */
 #define PRUNE_PERIOD			 3000 /* ms */
 
-
 #define HSR_TLV_ANNOUNCE		   22
 #define HSR_TLV_LIFE_CHECK		   23
 
-
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
  * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
@@ -99,7 +94,6 @@ struct hsr_ethhdr {
 	struct hsr_tag	hsr_tag;
 } __packed;
 
-
 /* HSR Supervision Frame data types.
  * Field names as defined in the IEC:2010 standard for HSR.
  */
@@ -145,7 +139,6 @@ struct hsrv1_ethhdr_sp {
 	struct hsr_sup_tag	hsr_sup;
 } __packed;
 
-
 enum hsr_port_type {
 	HSR_PT_NONE = 0,	/* Must be 0, used by framereg */
 	HSR_PT_SLAVE_A,
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 654d22dd428d..39768382be24 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -28,7 +28,6 @@ static const struct nla_policy hsr_policy[IFLA_HSR_MAX + 1] = {
 	[IFLA_HSR_SEQ_NR]		= { .type = NLA_U16 },
 };
 
-
 /* Here, it seems a netdevice has already been allocated for us, and the
  * hsr_dev_setup routine has been executed. Nice!
  */
@@ -121,8 +120,6 @@ static struct rtnl_link_ops hsr_link_ops __read_mostly = {
 	.fill_info	= hsr_fill_info,
 };
 
-
-
 /* attribute policy */
 static const struct nla_policy hsr_genl_policy[HSR_A_MAX + 1] = {
 	[HSR_A_NODE_ADDR] = { .len = ETH_ALEN },
@@ -140,8 +137,6 @@ static const struct genl_multicast_group hsr_mcgrps[] = {
 	{ .name = "hsr-network", },
 };
 
-
-
 /* This is called if for some node with MAC address addr, we only get frames
  * over one of the slave interfaces. This would indicate an open network ring
  * (i.e. a link has failed somewhere).
@@ -204,7 +199,6 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
 	if (!msg_head)
 		goto nla_put_failure;
 
-
 	res = nla_put(skb, HSR_A_NODE_ADDR, ETH_ALEN, addr);
 	if (res < 0)
 		goto nla_put_failure;
@@ -224,7 +218,6 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
 	rcu_read_unlock();
 }
 
-
 /* HSR_C_GET_NODE_STATUS lets userspace query the internal HSR node table
  * about the status of a specific node in the network, defined by its MAC
  * address.
@@ -269,9 +262,7 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 	if (!is_hsr_master(hsr_dev))
 		goto invalid;
 
-
 	/* Send reply */
-
 	skb_out = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb_out) {
 		res = -ENOMEM;
@@ -397,9 +388,7 @@ static int hsr_get_node_list(struct sk_buff *skb_in, struct genl_info *info)
 	if (!is_hsr_master(hsr_dev))
 		goto invalid;
 
-
 	/* Send reply */
-
 	skb_out = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb_out) {
 		res = -ENOMEM;
@@ -449,7 +438,6 @@ static int hsr_get_node_list(struct sk_buff *skb_in, struct genl_info *info)
 	return res;
 }
 
-
 static const struct genl_ops hsr_ops[] = {
 	{
 		.cmd = HSR_C_GET_NODE_STATUS,
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 56080da4aa77..80151c255a1d 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -18,7 +18,6 @@
 #include "hsr_forward.h"
 #include "hsr_framereg.h"
 
-
 static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
@@ -61,7 +60,6 @@ bool hsr_port_exists(const struct net_device *dev)
 	return rcu_access_pointer(dev->rx_handler) == hsr_handle_frame;
 }
 
-
 static int hsr_check_dev_ok(struct net_device *dev)
 {
 	/* Don't allow HSR on non-ethernet like devices */
@@ -99,7 +97,6 @@ static int hsr_check_dev_ok(struct net_device *dev)
 	return 0;
 }
 
-
 /* Setup device to be added to the HSR bridge. */
 static int hsr_portdev_setup(struct net_device *dev, struct hsr_port *port)
 {
-- 
2.17.0

