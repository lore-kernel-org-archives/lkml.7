Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F1C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D1A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560355175;
	bh=OIdZ1uJDmv06+6Jl9DM2rcn7ZXE6lXFDiN5OfEB9HkU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bw5RPNO8bDx0QgTLygE/neMXw+YvqxNf5wvqDmme/0NFjCdkqpUC+S99XD3EUt9DV
	 aYKcDIaIi1woN7JCtvYeyg3n/PdJt4SVsOHH4DjHXA+vOg6r1cRJ1xYCoTh+oXBTXP
	 NRz98ht1tDfi12j7uzCA0hiIrZSGlb1CY1BOKkZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440368AbfFLP7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:59:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44160 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438056AbfFLP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=F4hBM2hnudeTw3rmBj2H/vr2wvVOT3QCsFB/lvau9Gc=; b=uqWfxXgcMiTw
        X3AY60kodtH7UiiyRr8zVSRRMMe+Psd5GnL8JcvB0NmMNaVe1wX+VUSU+VYBjKA6RE8brRnk9mZRx
        2A9e0liTKkyGumR9rRKLzInOhI0faJd1eQViAJUfMyRItaRvALFsmTLgIos/ROtJyUIquAyTgsNcZ
        1vcQg=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hb5eq-000367-DK; Wed, 12 Jun 2019 15:59:28 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 970D7440049; Wed, 12 Jun 2019 16:59:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, jsarha@ti.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        misael.lopez@ti.com, robh+dt@kernel.org
Subject: Applied "bindings: sound: davinci-mcasp: Add support for optional auxclk-fs-ratio" to the asoc tree
In-Reply-To: <20190611122941.10708-2-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20190612155927.970D7440049@finisterre.sirena.org.uk>
Date:   Wed, 12 Jun 2019 16:59:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   bindings: sound: davinci-mcasp: Add support for optional auxclk-fs-ratio

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From b7e47f48f1197c24f5347327afc2a4f7f6da9ca5 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 11 Jun 2019 15:29:40 +0300
Subject: [PATCH] bindings: sound: davinci-mcasp: Add support for optional
 auxclk-fs-ratio

When McASP is bus master it's reference clock (AUXCLK) might not be a
static clock, but running at a specific FS ratio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/davinci-mcasp-audio.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index a58f79f5345c..c483dcec01f8 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -44,6 +44,9 @@ Optional properties:
   		 please refer to pinctrl-bindings.txt
 - fck_parent : Should contain a valid clock name which will be used as parent
 	       for the McASP fck
+- auxclk-fs-ratio: When McASP is bus master indicates the ratio between AUCLK
+		   and FS rate if applicable:
+		   AUCLK rate = auxclk-fs-ratio * FS rate
 
 Optional GPIO support:
 If any McASP pin need to be used as GPIO then the McASP node must have:
-- 
2.20.1

