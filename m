Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6984CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BFB2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfJVQ1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:27:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55927 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731132AbfJVQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:27:48 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMx0c-00027u-VS; Tue, 22 Oct 2019 18:27:47 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>, kernel@pengutronix.de
Subject: [PATCH] reset: fix of_reset_control_get_count kerneldoc comment
Date:   Tue, 22 Oct 2019 18:27:42 +0200
Message-Id: <20191022162742.9908-1-p.zabel@pengutronix.de>
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

Add a newline and remove a superfluous kerneldoc marker before the
of_reset_control_get_count kerneldoc comment, to fix documentation
build warnings:

  ./drivers/reset/core.c:832: warning: Incorrect use of kernel-doc format:  * of_reset_control_get_count - Count number of resets available with a device
  ./drivers/reset/core.c:840: warning: Function parameter or member 'node' not described in 'of_reset_control_get_count'

Fixes: 17c82e206d2a ("reset: Add APIs to manage array of resets")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7c95cafcdf08..660e0b07feca 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -824,9 +824,10 @@ int __device_reset(struct device *dev, bool optional)
 }
 EXPORT_SYMBOL_GPL(__device_reset);
 
-/**
+/*
  * APIs to manage an array of reset controls.
  */
+
 /**
  * of_reset_control_get_count - Count number of resets available with a device
  *
-- 
2.20.1

