Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC29DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5472339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfICQyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:54:17 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:55545 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbfICQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:54:17 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 5248C3A32A; Tue,  3 Sep 2019 18:54:12 +0200 (CEST)
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] staging: exfat: fix spelling errors in comments
Date:   Tue,  3 Sep 2019 18:54:08 +0200
Message-Id: <20190903165408.16010-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings:

  CHECK: 'consistancy' may be misspelled - perhaps 'consistency'?
  CHECK: 'stuct' may be misspelled - perhaps 'struct'?

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/exfat/exfat_core.c  | 2 +-
 drivers/staging/exfat/exfat_super.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 46b9f4455da1..67e43499d522 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1754,7 +1754,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 	while (num_entries) {
 		/*
 		 * instead of copying whole sector, we will check every entry.
-		 * this will provide minimum stablity and consistancy.
+		 * this will provide minimum stablity and consistency.
 		 */
 		entry_type = p_fs->fs_func->get_entry_type(ep);
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 881cd85cf677..56d673ecb70c 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -480,7 +480,7 @@ static int ffsMountVol(struct super_block *sb)
 		goto out;
 	}
 
-	/* fill fs_stuct */
+	/* fill fs_struct */
 	for (i = 0; i < 53; i++)
 		if (p_pbr->bpb[i])
 			break;
-- 
2.20.1

