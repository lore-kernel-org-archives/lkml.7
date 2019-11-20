Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F5422506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257201;
	bh=48KK0SLAaUeyUff4S3qn2YlPeutE7T2QR9bxIH2re6A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=L6yIla2/q7MEUcg0QGvcU7zywfIGv+S5Wjw+7yFigHxZ5j8PV0WMgituAZLS8xs5c
	 7b8nQXpYqSxHCuV/hkjfeGFr4XfpsxPnQP7ZSFU0bK/MHgkNw2ApJVrFugPrWSdyTt
	 zKs28cW2dydRe7LRAsmBYqZeksahBMSLed2t36BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfKTNkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfKTNj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:59 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13692251E;
        Wed, 20 Nov 2019 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257199;
        bh=48KK0SLAaUeyUff4S3qn2YlPeutE7T2QR9bxIH2re6A=;
        h=From:To:Cc:Subject:Date:From;
        b=iG2Q3aIcxDbYLfAS1EqiE7K5lJIUu8aW10Dq8IQnRfAULvAUWEz1hDUfz91Xo74iJ
         kXUgy55vbzgNO6iQTqtZCNKZ4S7MIqScZ4LT1f/LlqYtVwIqkGEhI/MDoL7M74eVag
         j63sHlOHurBD1S4p51WsCsQ5WykKxjUz9FjSM0YE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: reset: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:54 +0800
Message-Id: <20191120133954.14051-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/reset/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index c721939767eb..14a1d6d10ca9 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -144,11 +144,11 @@ config POWER_RESET_MT6323
        bool "MediaTek MT6323 power-off driver"
        depends on MFD_MT6397
        help
-         The power-off driver is responsible for externally shutdown down
-         the power of a remote MediaTek SoC MT6323 is connected to through
-         controlling a tiny circuit BBPU inside MT6323 RTC.
+	 The power-off driver is responsible for externally shutdown down
+	 the power of a remote MediaTek SoC MT6323 is connected to through
+	 controlling a tiny circuit BBPU inside MT6323 RTC.
 
-         Say Y if you have a board where MT6323 could be found.
+	 Say Y if you have a board where MT6323 could be found.
 
 config POWER_RESET_QNAP
 	bool "QNAP power-off driver"
-- 
2.17.1

