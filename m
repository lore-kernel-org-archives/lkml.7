Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D69C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7102073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820795;
	bh=uuXdCeHw8M7PF+g/FD8wgy9eJN6WWbVCdXJrPj2bZjY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IJu/R0hR7LsPtFI8XdiqIiJg/ebOUCVaZU2M0PwzRKYrPXzj2ceCLeQrFvE0Yr698
	 PtzJO0x+WFGLEphvugXIl2HQPnKXSPy/GtAb28xrb2U0Ojw9K3S2F5epf6cV7RBh3C
	 5tJri3YqPFEnHPKA8M8gnOZf2HMPJEjwt4dt/WMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfKOM0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:26:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32830 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfKOMZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=daHt2+8Hmvwc3q4oviLYlwCDGGFI8F6MVXhLSm92SYw=; b=N37ZirmfJhdE
        DgQuJBJ4gLC61qwuo3BGP1xiwQkaWamyFAVmkdIjZxA9mpEGb3CZnOaWqRWPs3sW5EWRcmdglRsva
        nINkULePgpdGc8gadnhT4H7jsmr5RmSnffRbAQE4t54q67cZBVqEAAWi5crLbryK4Gqs2misrV6a2
        VxGlo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaey-0000Ku-O8; Fri, 15 Nov 2019 12:25:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3BD982741609; Fri, 15 Nov 2019 12:25:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal Paillet <p.paillet@st.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, p.paillet@st.com
Subject: Applied "regulator: core: Let boot-on regulators be powered off" to the regulator tree
In-Reply-To: <20191113102737.27831-1-p.paillet@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122508.3BD982741609@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Let boot-on regulators be powered off

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

From 089b3f61ecfc43ca4ea26d595e1d31ead6de3f7b Mon Sep 17 00:00:00 2001
From: Pascal Paillet <p.paillet@st.com>
Date: Wed, 13 Nov 2019 11:27:37 +0100
Subject: [PATCH] regulator: core: Let boot-on regulators be powered off

Boot-on regulators are always kept on because their use_count value
is now incremented at boot time and never cleaned.

Only increment count value for alway-on regulators.
regulator_late_cleanup() is now able to power off boot-on regulators
when unused.

Fixes: 05f224ca6693 ("regulator: core: Clean enabling always-on regulators + their supplies")
Signed-off-by: Pascal Paillet <p.paillet@st.com>
Link: https://lore.kernel.org/r/20191113102737.27831-1-p.paillet@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a5b2a9b02108..5e6c629806e4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1403,7 +1403,9 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 			rdev_err(rdev, "failed to enable\n");
 			return ret;
 		}
-		rdev->use_count++;
+
+		if (rdev->constraints->always_on)
+			rdev->use_count++;
 	}
 
 	print_constraints(rdev);
-- 
2.20.1

