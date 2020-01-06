Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0172C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DF72072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578343876;
	bh=VVzOQqRYfdWh0OkpoDZO9s2m89D+PC5M/quLlEkvZbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=GQ+WZ8JqMOtj9bd23hkKSgZ9HR94+o1mFwhGYI4gVpt6m8hSIyfDNwdwPKMk0tIUU
	 UiPFtEULD4aInDFHyC9FIpuDb0zN1lXnnBAtv3M0mWOsu7xOhmW9VDZ/DqjRkiImiO
	 CcPMVR8DUTc8QLwrS8bjhw9cf6SsA0v9qsT3WS20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgAFUvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:51:15 -0500
Received: from foss.arm.com ([217.140.110.172]:49256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgAFUvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:51:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9201C106F;
        Mon,  6 Jan 2020 12:51:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18DFD3F534;
        Mon,  6 Jan 2020 12:51:13 -0800 (PST)
Date:   Mon, 06 Jan 2020 20:51:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>
Subject: Applied "regulator: samsung: Rename Samsung to lowercase" to the regulator tree
In-Reply-To: <20200103171131.9900-20-krzk@kernel.org>
Message-Id: <applied-20200103171131.9900-20-krzk@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: samsung: Rename Samsung to lowercase

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From fc2b10d13602d3e9c8a5f671898b8c77c205a36a Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 3 Jan 2020 18:11:31 +0100
Subject: [PATCH] regulator: samsung: Rename Samsung to lowercase

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
Link: https://lore.kernel.org/r/20200103171131.9900-20-krzk@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index bdc07739e9a2..f5c5177bdb0a 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -1015,5 +1015,5 @@ module_exit(s5m8767_pmic_exit);
 
 /* Module information */
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
-MODULE_DESCRIPTION("SAMSUNG S5M8767 Regulator Driver");
+MODULE_DESCRIPTION("Samsung S5M8767 Regulator Driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

