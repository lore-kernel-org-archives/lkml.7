Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED598C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C093F20828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfCZHyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:54:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39107 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfCZHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:54:37 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1h8guo-0004en-SI; Tue, 26 Mar 2019 08:54:34 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <sha@pengutronix.de>)
        id 1h8gun-0003iB-DY; Tue, 26 Mar 2019 08:54:33 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] quota: remove trailing whitespaces
Date:   Tue, 26 Mar 2019 08:54:31 +0100
Message-Id: <20190326075431.14198-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes all trailing whitespaces in fs/quota/.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/quota/dquot.c    | 10 +++++-----
 fs/quota/quota_v1.c |  2 +-
 fs/quota/quota_v2.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06c56ba..0036d27206a8 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -9,7 +9,7 @@
  * on the Melbourne quota system as used on BSD derived systems. The internal
  * implementation is based on one of the several variants of the LINUX
  * inode-subsystem with added complexity of the diskquota system.
- * 
+ *
  * Author:	Marco van Wieringen <mvw@planets.elm.net>
  *
  * Fixes:   Dmitry Gorodchanin <pgmdsg@ibi.com>, 11 Feb 96
@@ -51,7 +51,7 @@
  *		Added journalled quota support, fix lock inversion problems
  *		Jan Kara, <jack@suse.cz>, 2003,2004
  *
- * (C) Copyright 1994 - 1997 Marco van Wieringen 
+ * (C) Copyright 1994 - 1997 Marco van Wieringen
  */
 
 #include <linux/errno.h>
@@ -197,7 +197,7 @@ static struct quota_format_type *find_quota_format(int id)
 		int qm;
 
 		spin_unlock(&dq_list_lock);
-		
+
 		for (qm = 0; module_names[qm].qm_fmt_id &&
 			     module_names[qm].qm_fmt_id != id; qm++)
 			;
@@ -2397,7 +2397,7 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 out_fmt:
 	put_quota_format(fmt);
 
-	return error; 
+	return error;
 }
 
 /* Reenable quotas on remount RW */
@@ -2775,7 +2775,7 @@ int dquot_get_state(struct super_block *sb, struct qc_state *state)
 	struct qc_type_state *tstate;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int type;
-  
+
 	memset(state, 0, sizeof(*state));
 	for (type = 0; type < MAXQUOTAS; type++) {
 		if (!sb_has_quota_active(sb, type))
diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
index 7ac5298aba70..9f2b2573b83c 100644
--- a/fs/quota/quota_v1.c
+++ b/fs/quota/quota_v1.c
@@ -127,7 +127,7 @@ static int v1_check_quota_file(struct super_block *sb, int type)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
 	ulong blocks;
-	size_t off; 
+	size_t off;
 	struct v2_disk_dqheader dqhead;
 	ssize_t size;
 	loff_t isize;
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index a73e5b34db41..3c30034e733f 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -78,7 +78,7 @@ static int v2_check_quota_file(struct super_block *sb, int type)
 	struct v2_disk_dqheader dqhead;
 	static const uint quota_magics[] = V2_INITQMAGICS;
 	static const uint quota_versions[] = V2_INITQVERSIONS;
- 
+
 	if (v2_read_header(sb, type, &dqhead))
 		return 0;
 	if (le32_to_cpu(dqhead.dqh_magic) != quota_magics[type] ||
-- 
2.20.1

