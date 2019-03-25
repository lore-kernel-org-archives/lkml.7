Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BE8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0329820848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfCYUdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:33:09 -0400
Received: from sauhun.de ([88.99.104.3]:48898 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbfCYUdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:33:09 -0400
Received: from localhost (p54B33284.dip0.t-ipconnect.de [84.179.50.132])
        by pokefinder.org (Postfix) with ESMTPSA id 05A772C0963;
        Mon, 25 Mar 2019 21:33:06 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] regulator: da9063: convert header to SPDX
Date:   Mon, 25 Mar 2019 21:31:55 +0100
Message-Id: <20190325203155.8885-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covnert the header of the source file to SPDX.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since V1: use C++ comments everywhere

 drivers/regulator/da9063-regulator.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 06ee844a969d..82107c9e09f0 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -1,18 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator driver for DA9063 PMIC series
+//
+// Copyright 2012 Dialog Semiconductors Ltd.
+// Copyright 2013 Philipp Zabel, Pengutronix
+//
+// Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
 
-/*
- * Regulator driver for DA9063 PMIC series
- *
- * Copyright 2012 Dialog Semiconductors Ltd.
- * Copyright 2013 Philipp Zabel, Pengutronix
- *
- * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-- 
2.19.1

