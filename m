Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89435C32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AF021BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfHGLnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:43:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729635AbfHGLnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:43:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC8CBACEF;
        Wed,  7 Aug 2019 11:43:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-ide@vger.kernel.org
Subject: [PATCH v2 2/4] ata: define AC_ERR_OK
Date:   Wed,  7 Aug 2019 13:43:10 +0200
Message-Id: <20190807114312.20883-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807114312.20883-1-jslaby@suse.cz>
References: <20190807114312.20883-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we will return enum ata_completion_errors from qc_prep in the next
patch, let's define AC_ERR_OK to mark the OK status.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
---
 include/linux/libata.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 207e7ee764ce..b63ce4ebcd66 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -484,6 +484,7 @@ enum hsm_task_states {
 };
 
 enum ata_completion_errors {
+	AC_ERR_OK		= 0,	    /* no error */
 	AC_ERR_DEV		= (1 << 0), /* device reported error */
 	AC_ERR_HSM		= (1 << 1), /* host state machine violation */
 	AC_ERR_TIMEOUT		= (1 << 2), /* timeout */
-- 
2.22.0

