Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F45C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E07F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jqP1isbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDLUKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:10:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60418 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfDLUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:10:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CKAoFS009652;
        Fri, 12 Apr 2019 15:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555099850;
        bh=naeODMw2JTB2zvbveGzI7NZUxJdvIvz0O8ekQwSm0jY=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=jqP1isbLYIK2uNnjdS5M9oeBxbvt4nFpt7ewbNLsVuUTQtSPJem49fqk9Xd6CEV2S
         Zvop/LzHZyRJYex9pHGdPyjzsl6xL88u+7mC/YMxssTGb+342ogSKnV3McmTpKb9bs
         O8INUn21YrG02z/uhFx3cIcGjzyeoohfyGaQl29k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CKAoF6110714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 15:10:50 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 15:10:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 15:10:49 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CKAnc7059487;
        Fri, 12 Apr 2019 15:10:49 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <arvid.brodin@alten.se>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next PATCH 1/3] net: hsr: fix naming of file and functions
Date:   Fri, 12 Apr 2019 16:13:23 -0400
Message-ID: <20190412201325.29001-2-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190412201325.29001-1-m-karicheri2@ti.com>
References: <20190412201325.29001-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the file name and functions to match with existing implementation.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/Makefile                             |  2 +-
 net/hsr/{hsr_prp_debugfs.c => hsr_debugfs.c} | 34 ++++++++++----------
 net/hsr/hsr_device.c                         |  4 +--
 net/hsr/hsr_main.h                           |  8 ++---
 4 files changed, 24 insertions(+), 24 deletions(-)
 rename net/hsr/{hsr_prp_debugfs.c => hsr_debugfs.c} (74%)

diff --git a/net/hsr/Makefile b/net/hsr/Makefile
index d74d89d013b0..e45757fc477f 100644
--- a/net/hsr/Makefile
+++ b/net/hsr/Makefile
@@ -6,4 +6,4 @@ obj-$(CONFIG_HSR)	+= hsr.o
 
 hsr-y			:= hsr_main.o hsr_framereg.o hsr_device.o \
 			   hsr_netlink.o hsr_slave.o hsr_forward.o
-hsr-$(CONFIG_DEBUG_FS) += hsr_prp_debugfs.o
+hsr-$(CONFIG_DEBUG_FS) += hsr_debugfs.o
diff --git a/net/hsr/hsr_prp_debugfs.c b/net/hsr/hsr_debugfs.c
similarity index 74%
rename from net/hsr/hsr_prp_debugfs.c
rename to net/hsr/hsr_debugfs.c
index b30e98734c61..b5a955013976 100644
--- a/net/hsr/hsr_prp_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -1,5 +1,5 @@
 /*
- * hsr_prp_debugfs code
+ * hsr_debugfs code
  * Copyright (C) 2017 Texas Instruments Incorporated
  *
  * Author(s):
@@ -26,9 +26,9 @@ static void print_mac_address(struct seq_file *sfp, unsigned char *mac)
 		   mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 }
 
-/* hsr_prp_node_table_show - Formats and prints node_table entries */
+/* hsr_node_table_show - Formats and prints node_table entries */
 static int
-hsr_prp_node_table_show(struct seq_file *sfp, void *data)
+hsr_node_table_show(struct seq_file *sfp, void *data)
 {
 	struct hsr_priv *priv = (struct hsr_priv *)sfp->private;
 	struct hsr_node *node;
@@ -52,40 +52,40 @@ hsr_prp_node_table_show(struct seq_file *sfp, void *data)
 	return 0;
 }
 
-/* hsr_prp_node_table_open - Open the node_table file
+/* hsr_node_table_open - Open the node_table file
  *
  * Description:
  * This routine opens a debugfs file node_table of specific hsr device
  */
 static int
-hsr_prp_node_table_open(struct inode *inode, struct file *filp)
+hsr_node_table_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, hsr_prp_node_table_show, inode->i_private);
+	return single_open(filp, hsr_node_table_show, inode->i_private);
 }
 
-static const struct file_operations hsr_prp_fops = {
+static const struct file_operations hsr_fops = {
 	.owner	= THIS_MODULE,
-	.open	= hsr_prp_node_table_open,
+	.open	= hsr_node_table_open,
 	.read	= seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-/* hsr_prp_debugfs_init - create hsr-prp node_table file for dumping
+/* hsr_debugfs_init - create hsr node_table file for dumping
  * the node table
  *
  * Description:
  * When debugfs is configured this routine sets up the node_table file per
- * hsr/prp device for dumping the node_table entries
+ * hsr device for dumping the node_table entries
  */
-int hsr_prp_debugfs_init(struct hsr_priv *priv)
+int hsr_debugfs_init(struct hsr_priv *priv)
 {
 	int rc = -1;
 	struct dentry *de = NULL;
 
 	de = debugfs_create_dir("hsr", NULL);
 	if (!de) {
-		pr_err("Cannot create hsr-prp debugfs root\n");
+		pr_err("Cannot create hsr debugfs root\n");
 		return rc;
 	}
 
@@ -93,9 +93,9 @@ int hsr_prp_debugfs_init(struct hsr_priv *priv)
 
 	de = debugfs_create_file("node_table", S_IFREG | 0444,
 				 priv->node_tbl_root, priv,
-				 &hsr_prp_fops);
+				 &hsr_fops);
 	if (!de) {
-		pr_err("Cannot create hsr-prp node_table directory\n");
+		pr_err("Cannot create hsr node_table directory\n");
 		return rc;
 	}
 	priv->node_tbl_file = de;
@@ -104,14 +104,14 @@ int hsr_prp_debugfs_init(struct hsr_priv *priv)
 	return rc;
 }
 
-/* hsr_prp_debugfs_term - Tear down debugfs intrastructure
+/* hsr_debugfs_term - Tear down debugfs intrastructure
  *
  * Description:
  * When Debufs is configured this routine removes debugfs file system
- * elements that are specific to hsr-prp
+ * elements that are specific to hsr
  */
 void
-hsr_prp_debugfs_term(struct hsr_priv *priv)
+hsr_debugfs_term(struct hsr_priv *priv)
 {
 	debugfs_remove(priv->node_tbl_file);
 	priv->node_tbl_file = NULL;
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index b47a621e3f4e..58cf500ebf94 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -354,7 +354,7 @@ static void hsr_dev_destroy(struct net_device *hsr_dev)
 
 	hsr = netdev_priv(hsr_dev);
 
-	hsr_prp_debugfs_term(hsr);
+	hsr_debugfs_term(hsr);
 
 	rtnl_lock();
 	hsr_for_each_port(hsr, port)
@@ -485,7 +485,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 		goto fail;
 
 	mod_timer(&hsr->prune_timer, jiffies + msecs_to_jiffies(PRUNE_PERIOD));
-	res = hsr_prp_debugfs_init(hsr);
+	res = hsr_debugfs_init(hsr);
 	if (res)
 		goto fail;
 
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 778213f07fe0..6cd4dff58727 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -184,15 +184,15 @@ static inline u16 hsr_get_skb_sequence_nr(struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-int hsr_prp_debugfs_init(struct hsr_priv *priv);
-void hsr_prp_debugfs_term(struct hsr_priv *priv);
+int hsr_debugfs_init(struct hsr_priv *priv);
+void hsr_debugfs_term(struct hsr_priv *priv);
 #else
-static inline int hsr_prp_debugfs_init(struct hsr_priv *priv)
+static inline int hsr_debugfs_init(struct hsr_priv *priv)
 {
 	return 0;
 }
 
-static inline void hsr_prp_debugfs_term(struct hsr_priv *priv)
+static inline void hsr_debugfs_term(struct hsr_priv *priv)
 {}
 #endif
 
-- 
2.17.0

