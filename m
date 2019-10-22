Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EE5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C359B2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfJVQ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:28:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39929 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731277AbfJVQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:28:39 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMx1S-0002KF-7f; Tue, 22 Oct 2019 18:28:38 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel@pengutronix.de
Subject: [PATCH] reset: fix reset_control_lookup kerneldoc comment
Date:   Tue, 22 Oct 2019 18:28:34 +0200
Message-Id: <20191022162834.12568-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing colon to fix a documentation build warning:

  ./include/linux/reset-controller.h:45: warning: Function parameter or member 'con_id' not described in 'reset_control_lookup'

Fixes: 6691dffab0ab ("reset: add support for non-DT systems")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/reset-controller.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 9326d671b6e6..984f625d5593 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -33,7 +33,7 @@ struct of_phandle_args;
  * @provider: name of the reset controller device controlling this reset line
  * @index: ID of the reset controller in the reset controller device
  * @dev_id: name of the device associated with this reset line
- * @con_id name of the reset line (can be NULL)
+ * @con_id: name of the reset line (can be NULL)
  */
 struct reset_control_lookup {
 	struct list_head list;
-- 
2.20.1

