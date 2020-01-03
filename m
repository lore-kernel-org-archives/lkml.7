Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5CEC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AE120866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578071595;
	bh=fPm5Yby+y1HvlcMvlRngQAQVaF5ytWsyr2iFrW2UnT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F5ltosUpA3yT4F+ej9EGbeo2b52xUiU8bJJwcikgvQ1Rv3kNUpPnrPrL538AMWdAf
	 qWxPT7SWu8dNU88SrRPIqjvAMBzk98PuOks5qVDZT1GnLu11QWHVOG3n4aje/pQc9u
	 m+MvE8xOYSBw82ugSJB6o4QhoWfnjJdFZ58eRjcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgACRNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgACRNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:13:06 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3AA215A4;
        Fri,  3 Jan 2020 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071585;
        bh=fPm5Yby+y1HvlcMvlRngQAQVaF5ytWsyr2iFrW2UnT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfU9D4Xqx4lG34UMVnNZSfUw6Ch56xCx/oZWiTm4y2AnbXl0SuB7flfJHj1RV9yKD
         +vAI0BN/BgtI9wncq/ea2fc3NJ6Ol6nFpOPt2mWtzp8AM4dxk29DLWEohMgdWWUk2n
         LcgyTE7qH6pAK7oYvUOlSI7+4SJwM+a/Kv+aOi/k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 19/19] regulator: samsung: Rename Samsung to lowercase
Date:   Fri,  3 Jan 2020 18:11:31 +0100
Message-Id: <20200103171131.9900-20-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
name.

"SAMSUNG" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/s2mpa01.c | 2 +-
 drivers/regulator/s2mps11.c | 2 +-
 drivers/regulator/s5m8767.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 51f7e8b74d8c..115f59530852 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -390,5 +390,5 @@ module_platform_driver(s2mpa01_pmic_driver);
 /* Module information */
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
 MODULE_AUTHOR("Sachin Kamat <sachin.kamat@samsung.com>");
-MODULE_DESCRIPTION("SAMSUNG S2MPA01 Regulator Driver");
+MODULE_DESCRIPTION("Samsung S2MPA01 Regulator Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 4f2dc5ebffdc..23d288278957 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1265,5 +1265,5 @@ module_platform_driver(s2mps11_pmic_driver);
 
 /* Module information */
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
-MODULE_DESCRIPTION("SAMSUNG S2MPS11/S2MPS14/S2MPS15/S2MPU02 Regulator Driver");
+MODULE_DESCRIPTION("Samsung S2MPS11/S2MPS14/S2MPS15/S2MPU02 Regulator Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 12d6b8d2e97e..4abd3ed31f60 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -1015,5 +1015,5 @@ module_exit(s5m8767_pmic_exit);
 
 /* Module information */
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
-MODULE_DESCRIPTION("SAMSUNG S5M8767 Regulator Driver");
+MODULE_DESCRIPTION("Samsung S5M8767 Regulator Driver");
 MODULE_LICENSE("GPL");
-- 
2.17.1

