Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFE2C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F92021906
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbfJVLy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:54:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58251 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388306AbfJVLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:54:56 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMskY-0005LU-Dn; Tue, 22 Oct 2019 13:54:54 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH] reset: hisilicon: hi3660: Make reset_control_ops const
Date:   Tue, 22 Oct 2019 13:54:53 +0200
Message-Id: <20191022115453.19781-1-p.zabel@pengutronix.de>
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

The hi3660_reset_ops structure is never modified. Make it const.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/hisilicon/reset-hi3660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
index f690b1878071..a7d4445924e5 100644
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -56,7 +56,7 @@ static int hi3660_reset_dev(struct reset_controller_dev *rcdev,
 	return hi3660_reset_deassert(rcdev, idx);
 }
 
-static struct reset_control_ops hi3660_reset_ops = {
+static const struct reset_control_ops hi3660_reset_ops = {
 	.reset    = hi3660_reset_dev,
 	.assert   = hi3660_reset_assert,
 	.deassert = hi3660_reset_deassert,
-- 
2.20.1

