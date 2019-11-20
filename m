Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41724C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EB72168B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574270312;
	bh=q/FmY1XA9xjnGVLfdldaagZGKlxHfboow3m+zHgLD/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=FHVexbjcYPcNGoGRgNwqXf/kzLGc66MNRF3v2KZsBAPlxB4l5q+HVMNYUQhYVYX6j
	 UkQV+z4XR+6Ke3iO7NXFXpWYLSe5/xWlEIsSra9gIp/0ipYHZyLDmoe+YJn1KJ4tDn
	 NypGyz+Hw75PNc6LOZVWVF3pvx+Sq+jBSsbuEtfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfKTRSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:18:31 -0500
Received: from foss.arm.com ([217.140.110.172]:43390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKTRSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:18:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBC791045;
        Wed, 20 Nov 2019 09:18:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A5573F703;
        Wed, 20 Nov 2019 09:18:29 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:18:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: Fix Kconfig indentation" to the regulator tree
In-Reply-To: <20191120133949.13996-1-krzk@kernel.org>
Message-Id: <applied-20191120133949.13996-1-krzk@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fix Kconfig indentation

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 76bec25b32363f47225d35a70ccb97d6d0f09dd9 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 20 Nov 2019 21:39:49 +0800
Subject: [PATCH] regulator: Fix Kconfig indentation

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20191120133949.13996-1-krzk@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 3ee63531f6d5..74eb5af7295f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -841,10 +841,10 @@ config REGULATOR_SKY81452
 	  will be called sky81452-regulator.
 
 config REGULATOR_SLG51000
-        tristate "Dialog Semiconductor SLG51000 regulators"
-        depends on I2C
-        select REGMAP_I2C
-        help
+	tristate "Dialog Semiconductor SLG51000 regulators"
+	depends on I2C
+	select REGMAP_I2C
+	help
 	  Say y here to support for the Dialog Semiconductor SLG51000.
 	  The SLG51000 is seven compact and customizable low dropout
 	  regulators.
-- 
2.20.1

