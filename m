Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F1C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E202133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfFZMnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:43:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfFZMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:43:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hg7Gl-0004vr-F0; Wed, 26 Jun 2019 12:43:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvme-trace: fix spelling mistake "spcecific" -> "specific"
Date:   Wed, 26 Jun 2019 13:43:23 +0100
Message-Id: <20190626124323.5925-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes in trace_seq_printf messages, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/nvme/host/trace.c   | 2 +-
 drivers/nvme/target/trace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index f01ad0fd60bb..6980ab827233 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -178,7 +178,7 @@ static const char *nvme_trace_fabrics_common(struct trace_seq *p, u8 *spc)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
 
-	trace_seq_printf(p, "spcecific=%*ph", 24, spc);
+	trace_seq_printf(p, "specific=%*ph", 24, spc);
 	trace_seq_putc(p, 0);
 	return ret;
 }
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index cdcdd14c6408..6af11d493271 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -146,7 +146,7 @@ static const char *nvmet_trace_fabrics_common(struct trace_seq *p, u8 *spc)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
 
-	trace_seq_printf(p, "spcecific=%*ph", 24, spc);
+	trace_seq_printf(p, "specific=%*ph", 24, spc);
 	trace_seq_putc(p, 0);
 	return ret;
 }
-- 
2.20.1

