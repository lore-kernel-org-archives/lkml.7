Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96A5217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfISVEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:04:30 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:53050 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbfISVE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:04:29 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 3B6037BC24D; Thu, 19 Sep 2019 23:04:28 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] trivial: lib/Kconfig: typo modertion -> moderation
Date:   Thu, 19 Sep 2019 23:03:14 +0200
Message-Id: <20190919210314.22110-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 4f75da3666c0 ("linux/dim: Move implementation to .c files")
Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 4e6b1c3e4c98..cc04124ed8f7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -559,7 +559,7 @@ config DIMLIB
 	default y
 	help
 	  Dynamic Interrupt Moderation library.
-	  Implements an algorithm for dynamically change CQ modertion values
+	  Implements an algorithm for dynamically change CQ moderation values
 	  according to run time performance.
 
 #
-- 
2.23.0

