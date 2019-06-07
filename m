Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80262C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A95208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559910452;
	bh=RghxblOdxAl9vT+fMODN3C4V+Nv+9rHWY6u/K7RysWs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Z2S00zkW5/9dKQgKYnSAcDd4kIRos45e1II8Ke6Lo9+6bCU/zDNGJbB8u0n+h2Sha
	 HzCJk9fs75VAiSy+g4Gsnfe+5iEOXWWVx/3T2p8XpvwEm8lPE74dCz5xiTDtpFyP7A
	 vzTRUNUIP8esKcrfTGUqBjoP29iNUExOfQGbFFv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfFGM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:27:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45950 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfFGM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fT9pSf+IL07UlUK5BjK6jBDL0c+x4KokMXc+n2SMsnk=; b=NEKqh4F6JOnL
        ciErXnfiiBTQIXlHBNc7IuyXgTjcDsW3RGA8pwVmDSAL+6GxTghkoMIdGZg1np5077NKUzM0jjCtm
        553Pc8IJ0pIA801UjZWiChf7M4ARj6xBDA6DwEHNDDiATS6wirkRfNNNw08Yrxab9vsCeHJToalyh
        T5sW8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZDxu-0002Bc-7V; Fri, 07 Jun 2019 12:27:26 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2ECD9440046; Fri,  7 Jun 2019 13:27:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: cpcap: Spelling s/configuraion/configuration/" to the regulator tree
In-Reply-To: <20190607112640.13842-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20190607122725.2ECD9440046@finisterre.sirena.org.uk>
Date:   Fri,  7 Jun 2019 13:27:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: cpcap: Spelling s/configuraion/configuration/

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 25a7d03dae3ac8dcc3fa00cc0ec17935eb08260d Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 7 Jun 2019 13:26:40 +0200
Subject: [PATCH] regulator: cpcap: Spelling s/configuraion/configuration/

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/cpcap-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index d3284361e594..f80781d58a28 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -90,7 +90,7 @@
 #define CPCAP_REG_OFF_MODE_SEC		BIT(15)
 
 /**
- * SoC specific configuraion for CPCAP regulator. There are at least three
+ * SoC specific configuration for CPCAP regulator. There are at least three
  * different SoCs each with their own parameters: omap3, omap4 and tegra2.
  *
  * The assign_reg and assign_mask seem to allow toggling between primary
-- 
2.20.1

