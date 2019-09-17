Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1054AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1ED521852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfIQMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:43:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34231 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfIQMnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:43:07 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iACow-0000dJ-0E; Tue, 17 Sep 2019 14:43:02 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iACov-00039A-GF; Tue, 17 Sep 2019 14:43:01 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     support.opensource@diasemi.com, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        stwiss.opensource@diasemi.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: mfd: da9062: add regulator gpio enable/disable documentation
Date:   Tue, 17 Sep 2019 14:42:45 +0200
Message-Id: <20190917124246.11732-5-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917124246.11732-1-m.felsch@pengutronix.de>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the gpio-based regulator enable/disable documentation. This property
can be applied to each subnode within the 'regulators' node so each
regulator can be configured differently.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 Documentation/devicetree/bindings/mfd/da9062.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index 9d9820d8177d..3d4b90bf8ea6 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -75,6 +75,13 @@ Sub-nodes:
     same. Also the gpio phandle must refer to to the dlg,da9062-gpio device
     other gpios are not allowed and make no sense.
 
+  - dlg,ena-sense-gpios : The GPIO reference which should be used by the
+    regulator to enable/disable the output. If the signal is active the
+    regulator is on else it is off. Attention: Sharing the same gpio for other
+    purposes or across multiple regulators is possible but the gpio settings
+    must be the same. Also the gpio phandle must refer to to the
+    dlg,da9062-gpio device other gpios are not allowed and make no sense.
+
 - rtc : This node defines settings required for the Real-Time Clock associated
   with the DA9062. There are currently no entries in this binding, however
   compatible = "dlg,da9062-rtc" should be added if a node is created.
-- 
2.20.1

