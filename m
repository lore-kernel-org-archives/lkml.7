Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C188C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB882080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfFQN4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:56:05 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:32918 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQN4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:56:05 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id Rpw32000b3XaVaC01pw3NU; Mon, 17 Jun 2019 15:56:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcs79-00025Y-Nb; Mon, 17 Jun 2019 15:56:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcs79-00005a-Ll; Mon, 17 Jun 2019 15:56:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] clk: Grammar missing "and", Spelling s/statisfied/satisfied/
Date:   Mon, 17 Jun 2019 15:56:02 +0200
Message-Id: <20190617135602.32766-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0529ac624ed73ba0..37b2d4041872d53b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2191,7 +2191,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 EXPORT_SYMBOL_GPL(clk_set_rate);
 
 /**
- * clk_set_rate_exclusive - specify a new rate get exclusive control
+ * clk_set_rate_exclusive - specify a new rate and get exclusive control
  * @clk: the clk whose rate is being changed
  * @rate: the new rate for clk
  *
@@ -2199,7 +2199,7 @@ EXPORT_SYMBOL_GPL(clk_set_rate);
  * within a critical section
  *
  * This can be used initially to ensure that at least 1 consumer is
- * statisfied when several consumers are competing for exclusivity over the
+ * satisfied when several consumers are competing for exclusivity over the
  * same clock provider.
  *
  * The exclusivity is not applied if setting the rate failed.
-- 
2.17.1

