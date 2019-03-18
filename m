Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB90C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCRP6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:58:00 -0400
Received: from sauhun.de ([88.99.104.3]:36970 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbfCRP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:57:40 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id EED474A1346;
        Mon, 18 Mar 2019 16:57:38 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/4] regulator: da9063: convert header to SPDX
Date:   Mon, 18 Mar 2019 16:57:25 +0100
Message-Id: <20190318155728.28365-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covnert the header of the source file to SPDX.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/regulator/da9063-regulator.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2b0c7a85306a..42dca1cac077 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -1,4 +1,4 @@
-
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Regulator driver for DA9063 PMIC series
  *
@@ -6,12 +6,6 @@
  * Copyright 2013 Philipp Zabel, Pengutronix
  *
  * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.11.0

