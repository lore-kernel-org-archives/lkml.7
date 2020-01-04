Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26042C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE19321734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578151393;
	bh=fPm5Yby+y1HvlcMvlRngQAQVaF5ytWsyr2iFrW2UnT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aAix6GHZDFwbzGqZvVPofBpvwyjcGG3+59o11WsAfUyvLhHTqfe9huiK3g4snfnkO
	 YuXV/bhvj3DHUzFMs2K0D8VNAPlFX2HhMUWxD94gQsMA3VkSt9lNgFnQx7fzx/dMDS
	 XTuqyDGSpl2zQH1u9VfpKNDr1enNKErFieb0hfNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgADPXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbgADPXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:23:07 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3491924653;
        Sat,  4 Jan 2020 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151386;
        bh=fPm5Yby+y1HvlcMvlRngQAQVaF5ytWsyr2iFrW2UnT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRnEIqBFz3ecdBBFpdhhdeuo0qzMCLS33zMyTqxpMtJBBWvdpDrKv6oid5qDNV1h/
         FZS06F/cvB0aYglbFs50wIUvsvnK7KT+ENvxSkDE3OoZ55qzg/y9vPD55WK4pImpCa
         yapYXyBLUFiDb090v+yzTurdYX6u3rO8CLB94gxg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 20/20] regulator: samsung: Rename Samsung to lowercase
Date:   Sat,  4 Jan 2020 16:21:07 +0100
Message-Id: <20200104152107.11407-21-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
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

