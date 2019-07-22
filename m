Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E77A21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798146;
	bh=AH1rN22MWnOtJGzzxUM0mGHTCFWGRW+b242orbfrIXU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MLOucGUV7oHLwkVz/1SPv53eZb+i7xyANzZdtinFKRag3AvVVaWmCAMz0Yfdt+6sW
	 uBTKLIornvXrTuW3TPqPyRRlZ57ZB4dRmlOZLQZLyKbWNb6YczuKuo4JAPHoVZAELF
	 qWrRsXD0ls0210h8s2SjQro9XxQTpFXWlp1xanjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfGVMWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:22:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbfGVMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZCIlTgADNq9hLb3aLbqzku2IjkLw0pl/FAYJnv5lKfw=; b=Z0iwAG4c1dP/
        aYQLcs9zZ0XOvFTmBGkrlxyaqofQ1yZPmJfGUboYK9xx0WDB1T+xWOw2ujC3mptJSqASU6FkKhuTN
        xAP2CTCcVjuU44nZ3goHR0MNBpJ2fvqQ31zabWJlHauCGz/e15i2y5JJ4g0/Aie9pL5sTRx7rb0NX
        rQwg0=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKa-0007fY-7s; Mon, 22 Jul 2019 12:22:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A335E2740463; Mon, 22 Jul 2019 13:22:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: rk808: Return REGULATOR_MODE_INVALID for invalid mode" to the regulator tree
In-Reply-To: <20190711122138.5221-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122215.A335E2740463@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rk808: Return REGULATOR_MODE_INVALID for invalid mode

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From d850c6f5fad60b6edec08300977303aae855ffff Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Jul 2019 20:21:38 +0800
Subject: [PATCH] regulator: rk808: Return REGULATOR_MODE_INVALID for invalid
 mode

-EINVAL is not a valid return value for .of_map_mode, return
REGULATOR_MODE_INVALID instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20190711122138.5221-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e7af0c53d449..61bd5ef0806c 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -606,7 +606,7 @@ static unsigned int rk8xx_regulator_of_map_mode(unsigned int mode)
 	case 2:
 		return REGULATOR_MODE_NORMAL;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
-- 
2.20.1

