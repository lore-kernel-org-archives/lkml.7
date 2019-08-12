Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50519C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A11208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565615419;
	bh=ol7ncmy9e4hmMXc2jePY8wguNh6XQcQOwoiiOnTk8sg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zCSl8YHG6h6BofQyMhfkvp/RSAAQnlVzcN1qIp1P5YN7PUEBbMDZuXrH2Y+miOmHt
	 XGRs7LNKQW4zxpevj/xxecs46w5F/jdwU3BBji6MOmZL8CjG9wlsT+kvHXNJYEItDV
	 rNYcASMdThtcTNnTs6m6KSXFY9RkIE6Jd8Q4RCcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfHLNKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:10:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbfHLNKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gd9DyYbnFyPsG5Oa/SoWq+i9aBWOzldgmInHOmAKHtg=; b=b2SxXVLmnNQv
        eud1RiJ9tB7mHyjx/QJQGVUsF6U7TDFo1DmvcEz1R999e2pzQYoJkb/ORu9hSFbxMcPKR/8taE5Io
        V6gMqBUD/IRZK6g/8avKMEKU1WwPBQmOAilp2FkKQFk6TQmrYRkfDskrVPLzib7iEPDXVI0UkZkMi
        Y4F88=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxA5M-0001PY-QV; Mon, 12 Aug 2019 13:10:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 02C3B2740CB7; Mon, 12 Aug 2019 14:10:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        rafael@kernel.org
Subject: Applied "regmap-irq: Correct error paths in regmap_irq_thread for pm_runtime" to the regmap tree
In-Reply-To: <20190812092409.21593-1-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Message-Id: <20190812131004.02C3B2740CB7@ypsilon.sirena.org.uk>
Date:   Mon, 12 Aug 2019 14:10:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap-irq: Correct error paths in regmap_irq_thread for pm_runtime

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-5.3

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

From fba5b1e9ab527bd46bc529370d52a7b2b552dce1 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 12 Aug 2019 10:24:09 +0100
Subject: [PATCH] regmap-irq: Correct error paths in regmap_irq_thread for
 pm_runtime

Some error paths in regmap_irq_thread put the pm_runtime others do not,
there is no reason to leave the pm_runtime enabled in some cases so
update those paths to also put the pm_runtime.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190812092409.21593-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index c9dc70ceca5f..3d64c9331a82 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -370,7 +370,6 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (ret < 0) {
 			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
 				ret);
-			pm_runtime_put(map->dev);
 			goto exit;
 		}
 	}
@@ -425,8 +424,6 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 					dev_err(map->dev,
 						"Failed to read IRQ status %d\n",
 						ret);
-					if (chip->runtime_pm)
-						pm_runtime_put(map->dev);
 					goto exit;
 				}
 			}
@@ -478,8 +475,6 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				dev_err(map->dev,
 					"Failed to read IRQ status: %d\n",
 					ret);
-				if (chip->runtime_pm)
-					pm_runtime_put(map->dev);
 				goto exit;
 			}
 		}
@@ -513,10 +508,10 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		}
 	}
 
+exit:
 	if (chip->runtime_pm)
 		pm_runtime_put(map->dev);
 
-exit:
 	if (chip->handle_post_irq)
 		chip->handle_post_irq(chip->irq_drv_data);
 
-- 
2.20.1

