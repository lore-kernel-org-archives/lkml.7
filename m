Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1155C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F3820844
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHSKw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:52:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:63592 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfHSKw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:52:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 03:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="189498050"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Aug 2019 03:52:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AAA49128; Mon, 19 Aug 2019 13:52:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Subject: [PATCH v1] reset: Remove copy'n'paste redundancy in the comments
Date:   Mon, 19 Aug 2019 13:52:52 +0300
Message-Id: <20190819105252.81020-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the commit bb475230b8e5
("reset: make optional functions really optional")
brought couple of redundant lines in the comments.

Drop them here.

Cc: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/reset/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 213ff40dda11..2badff33a0db 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -334,7 +334,6 @@ EXPORT_SYMBOL_GPL(reset_control_reset);
  * internal state to be reset, but must be prepared for this to happen.
  * Consumers must not use reset_control_reset on shared reset lines when
  * reset_control_(de)assert has been used.
- * return 0.
  *
  * If rstc is NULL it is an optional reset and the function will just
  * return 0.
@@ -393,7 +392,6 @@ EXPORT_SYMBOL_GPL(reset_control_assert);
  * After calling this function, the reset is guaranteed to be deasserted.
  * Consumers must not use reset_control_reset on shared reset lines when
  * reset_control_(de)assert has been used.
- * return 0.
  *
  * If rstc is NULL it is an optional reset and the function will just
  * return 0.
-- 
2.23.0.rc1

