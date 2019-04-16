Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5661206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfDPL4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:56:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57458 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfDPL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:56:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGMhE-0004Mf-Rg; Tue, 16 Apr 2019 11:56:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mvebu: fix spelling mistake "gatable" -> "gateable"
Date:   Tue, 16 Apr 2019 12:56:16 +0100
Message-Id: <20190416115616.31861-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a few spelling mistakes in comments and a pr_err
error message. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/mvebu/common.c                  | 2 +-
 drivers/clk/mvebu/cp110-system-controller.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 6ab3c2e627c7..785dbede4835 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -240,7 +240,7 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 	int n;
 
 	if (ctrl) {
-		pr_err("mvebu-clk-gating: cannot instantiate more than one gatable clock device\n");
+		pr_err("mvebu-clk-gating: cannot instantiate more than one gateable clock device\n");
 		return;
 	}
 
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 9235a331b588..b6de283f45e3 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -21,7 +21,7 @@
  *    - Equal to SDIO clock
  *    - 2/5 PLL0
  *
- * CP110 has 32 gatable clocks, for the various peripherals in the IP.
+ * CP110 has 32 gateable clocks, for the various peripherals in the IP.
  */
 
 #define pr_fmt(fmt) "cp110-system-controller: " fmt
@@ -57,7 +57,7 @@ enum {
 #define CP110_CORE_NAND			4
 #define CP110_CORE_SDIO			5
 
-/* A number of gatable clocks need special handling */
+/* A number of gateable clocks need special handling */
 #define CP110_GATE_AUDIO		0
 #define CP110_GATE_COMM_UNIT		1
 #define CP110_GATE_NAND			2
-- 
2.20.1

