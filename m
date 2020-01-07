Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7F0C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1231720715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGKA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:00:57 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:47980 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgAGKA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:00:56 -0500
Received: from localhost.localdomain (unknown [159.226.5.100])
        by APP-01 (Coremail) with SMTP id qwCowABXR5TEVhRet5vvEA--.36S3;
        Tue, 07 Jan 2020 18:00:36 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: [PATCH] mic: Remove unneeded NULL check
Date:   Tue,  7 Jan 2020 10:00:35 +0000
Message-Id: <1578391235-603-1-git-send-email-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowABXR5TEVhRet5vvEA--.36S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4UGry7Cw18KryrArWUArb_yoW8Ar1rpa
        1DuFyFyr1UZr4UG34kCw4DGFyfXa93Z3yagFy8Cw1rZrsxAF45tr4kKa4jvryrXFWUtFnI
        vF15C34UCw4UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8twCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j11v3UUUUU=
X-Originating-IP: [159.226.5.100]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwIIA1z4i+++3wABsi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove_recursive will do NULL check, so remove
the redundant null check.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/misc/mic/card/mic_debugfs.c  | 3 ---
 drivers/misc/mic/cosm/cosm_debugfs.c | 3 ---
 drivers/misc/mic/host/mic_debugfs.c  | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/misc/mic/card/mic_debugfs.c b/drivers/misc/mic/card/mic_debugfs.c
index 3ee3d24..b586088 100644
--- a/drivers/misc/mic/card/mic_debugfs.c
+++ b/drivers/misc/mic/card/mic_debugfs.c
@@ -65,9 +65,6 @@ void __init mic_create_card_debug_dir(struct mic_driver *mdrv)
  */
 void mic_delete_card_debug_dir(struct mic_driver *mdrv)
 {
-	if (!mdrv->dbg_dir)
-		return;
-
 	debugfs_remove_recursive(mdrv->dbg_dir);
 }
 
diff --git a/drivers/misc/mic/cosm/cosm_debugfs.c b/drivers/misc/mic/cosm/cosm_debugfs.c
index 2fc9f4b..68a731f 100644
--- a/drivers/misc/mic/cosm/cosm_debugfs.c
+++ b/drivers/misc/mic/cosm/cosm_debugfs.c
@@ -102,9 +102,6 @@ void cosm_create_debug_dir(struct cosm_device *cdev)
 
 void cosm_delete_debug_dir(struct cosm_device *cdev)
 {
-	if (!cdev->dbg_dir)
-		return;
-
 	debugfs_remove_recursive(cdev->dbg_dir);
 }
 
diff --git a/drivers/misc/mic/host/mic_debugfs.c b/drivers/misc/mic/host/mic_debugfs.c
index 8a8e416..ab0db7a 100644
--- a/drivers/misc/mic/host/mic_debugfs.c
+++ b/drivers/misc/mic/host/mic_debugfs.c
@@ -129,9 +129,6 @@ void mic_create_debug_dir(struct mic_device *mdev)
  */
 void mic_delete_debug_dir(struct mic_device *mdev)
 {
-	if (!mdev->dbg_dir)
-		return;
-
 	debugfs_remove_recursive(mdev->dbg_dir);
 }
 
-- 
2.7.4

