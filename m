Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8BCC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7D621773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oxobgwIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfDERaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:30:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56312 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbfDER3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSxQL130992;
        Fri, 5 Apr 2019 12:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485339;
        bh=CzFVshVULoR1rH4g4J+1/7WSH6F0ebNlHTIesHtRbks=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=oxobgwIqNdmbx6Tq1Cg/DviQkMPlFT8Ia0xCvp+ZRP9KSELsbLI3w0FaiP2DUC6pp
         V8wMXPk25jJl8SmT7De0B5Qj9ueUuV6JrBcPTJCC0CGNkyRSdFxdE3rp1VbxqooBVf
         FNLH+K23Jln48gTTTZMOtWHWQ/wGlyl7DLeR+VRM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HSxI2050693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:59 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:58 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuU095744;
        Fri, 5 Apr 2019 12:28:58 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 07/14] net: hsr: remove unnecessary space after a cast
Date:   Fri, 5 Apr 2019 13:31:29 -0400
Message-ID: <20190405173136.18050-8-m-karicheri2@ti.com>
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

This patch removes unnecessary space after a cast. This is seen
when ran checkpatch.pl -f on files under net/hsr.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_forward.c  | 10 +++++-----
 net/hsr/hsr_framereg.c | 10 +++++-----
 net/hsr/hsr_main.h     | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 68ca775d3be8..71ffbfd6d740 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -53,7 +53,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	struct hsrv1_ethhdr_sp *hsrV1Hdr;
 
 	WARN_ON_ONCE(!skb_mac_header_was_set(skb));
-	ethHdr = (struct ethhdr *) skb_mac_header(skb);
+	ethHdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* Correct addr? */
 	if (!ether_addr_equal(ethHdr->h_dest,
@@ -67,14 +67,14 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 	/* Get the supervision header from correct location. */
 	if (ethHdr->h_proto == htons(ETH_P_HSR)) { /* Okay HSRv1. */
-		hsrV1Hdr = (struct hsrv1_ethhdr_sp *) skb_mac_header(skb);
+		hsrV1Hdr = (struct hsrv1_ethhdr_sp *)skb_mac_header(skb);
 		if (hsrV1Hdr->hsr.encap_proto != htons(ETH_P_PRP))
 			return false;
 
 		hsrSupTag = &hsrV1Hdr->hsr_sup;
 	} else {
 		hsrSupTag =
-		     &((struct hsrv0_ethhdr_sp *) skb_mac_header(skb))->hsr_sup;
+		     &((struct hsrv0_ethhdr_sp *)skb_mac_header(skb))->hsr_sup;
 	}
 
 	if (hsrSupTag->HSR_TLV_Type != HSR_TLV_ANNOUNCE &&
@@ -140,7 +140,7 @@ static void hsr_fill_tag(struct sk_buff *skb, struct hsr_frame_info *frame,
 	if (frame->is_vlan)
 		lsdu_size -= 4;
 
-	hsr_ethhdr = (struct hsr_ethhdr *) skb_mac_header(skb);
+	hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
 
 	set_hsr_tag_path(&hsr_ethhdr->hsr_tag, lane_id);
 	set_hsr_tag_LSDU_size(&hsr_ethhdr->hsr_tag, lsdu_size);
@@ -320,7 +320,7 @@ static int hsr_fill_frame_info(struct hsr_frame_info *frame,
 	if (!frame->node_src)
 		return -1; /* Unknown node and !is_supervision, or no mem */
 
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	frame->is_vlan = false;
 	if (ethhdr->h_proto == htons(ETH_P_8021Q)) {
 		frame->is_vlan = true;
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index c1b0e62af0f1..1929a8dfd292 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -44,10 +44,10 @@ static bool seq_nr_after(u16 a, u16 b)
 	/* Remove inconsistency where
 	 * seq_nr_after(a, b) == seq_nr_before(a, b)
 	 */
-	if ((int) b - a == 32768)
+	if ((int)b - a == 32768)
 		return false;
 
-	return (((s16) (b - a)) < 0);
+	return (((s16)(b - a)) < 0);
 }
 #define seq_nr_before(a, b)		seq_nr_after((b), (a))
 #define seq_nr_after_or_eq(a, b)	(!seq_nr_before((a), (b)))
@@ -176,7 +176,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 	if (!skb_mac_header_was_set(skb))
 		return NULL;
 
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	list_for_each_entry_rcu(node, node_db, mac_list) {
 		if (ether_addr_equal(node->MacAddressA, ethhdr->h_source))
@@ -218,7 +218,7 @@ void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 	struct list_head *node_db;
 	int i;
 
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* Leave the ethernet header. */
 	skb_pull(skb, sizeof(struct ethhdr));
@@ -230,7 +230,7 @@ void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 	/* And leave the HSR sup tag. */
 	skb_pull(skb, sizeof(struct hsr_sup_tag));
 
-	hsr_sp = (struct hsr_sup_payload *) skb->data;
+	hsr_sp = (struct hsr_sup_payload *)skb->data;
 
 	/* Merge node_curr (registered on MacAddressB) into node_real */
 	node_db = &port_rcv->hsr->node_db;
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 1b640731d705..5d28a5371765 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -109,22 +109,22 @@ struct hsr_sup_payload {
 
 static inline u16 get_hsr_stag_path(struct hsr_sup_tag *hst)
 {
-	return get_hsr_tag_path((struct hsr_tag *) hst);
+	return get_hsr_tag_path((struct hsr_tag *)hst);
 }
 
 static inline u16 get_hsr_stag_HSR_ver(struct hsr_sup_tag *hst)
 {
-	return get_hsr_tag_LSDU_size((struct hsr_tag *) hst);
+	return get_hsr_tag_LSDU_size((struct hsr_tag *)hst);
 }
 
 static inline void set_hsr_stag_path(struct hsr_sup_tag *hst, u16 path)
 {
-	set_hsr_tag_path((struct hsr_tag *) hst, path);
+	set_hsr_tag_path((struct hsr_tag *)hst, path);
 }
 
 static inline void set_hsr_stag_HSR_Ver(struct hsr_sup_tag *hst, u16 HSR_Ver)
 {
-	set_hsr_tag_LSDU_size((struct hsr_tag *) hst, HSR_Ver);
+	set_hsr_tag_LSDU_size((struct hsr_tag *)hst, HSR_Ver);
 }
 
 struct hsrv0_ethhdr_sp {
@@ -179,7 +179,7 @@ static inline u16 hsr_get_skb_sequence_nr(struct sk_buff *skb)
 {
 	struct hsr_ethhdr *hsr_ethhdr;
 
-	hsr_ethhdr = (struct hsr_ethhdr *) skb_mac_header(skb);
+	hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
 	return ntohs(hsr_ethhdr->hsr_tag.sequence_nr);
 }
 
-- 
2.17.0

