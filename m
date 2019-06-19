Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60FF214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560946362;
	bh=NAR5e2T0Bu0IXN/1pBzm9vyI/lTeIXek/zrMuU88qw4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ReM0nmxCjlnQzNm9cpXl3+ZZGuVDRc+BRkep3UsM5p7LMtYoPmIg2XKStlozbMYLc
	 /E6z3/8DN32xbmWEx6eG+Kjj1rrfygIAAyFBBPI4o5vwk3E2FgnyQ3rZk4sK5rrwI6
	 JKfmak9TloYSaxUI7TdWR1Nj4GlBj0Vs4Z/l04TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfFSMMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:12:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Vx8I+bsO0Nrv82AoF/3bhniSe8YwVZKW+Vv3Am/EV04=; b=PAAtCXycd2bE
        771GayGvNaRqpb57uVu37MPQrWFPpn1jTPq5pv9/TkWF4Yp3bZI1H0+nRgCA9YZXquiezEkO8s9Ts
        rfjRPVyLsBc+gqfSlnsRnHTHyVZ4GYgpjQMZq6iwWC+CZgzuP3xzi2JlsvIZDC0XQvCHnWcrSFCnJ
        243KA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdZRc-0007CN-Os; Wed, 19 Jun 2019 12:12:04 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5633D440046; Wed, 19 Jun 2019 13:12:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ben Zhang <benzh@chromium.org>
Cc:     alsa-devel@alsa-project.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt5677: handle concurrent interrupts" to the asoc tree
In-Reply-To: <20190618234555.188955-3-fletcherw@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190619121204.5633D440046@finisterre.sirena.org.uk>
Date:   Wed, 19 Jun 2019 13:12:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5677: handle concurrent interrupts

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

From df9091e9d3f4500bc6fb15f5d2a1c2614f67004c Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Tue, 18 Jun 2019 17:45:55 -0600
Subject: [PATCH] ASoC: rt5677: handle concurrent interrupts

The rt5677 driver writes to the IRQ control register within the IRQ
handler in order to flip the polarity of the interrupts that have been
signalled.  If an interrupt fires in the interval between the
regmap_read and the regmap_write, it will not trigger a new call to
rt5677_irq.

Add a bounded loop to rt5677_irq that keeps checking interrupts until
none are seen, so that any interrupts that are signalled in that
interval are correctly handled.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 71 +++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index b5ae61ff87af..202af7135f07 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5072,38 +5072,57 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
 static irqreturn_t rt5677_irq(int unused, void *data)
 {
 	struct rt5677_priv *rt5677 = data;
-	int ret = 0, i, reg_irq, virq;
+	int ret = 0, loop, i, reg_irq, virq;
 	bool irq_fired = false;
 
 	mutex_lock(&rt5677->irq_lock);
-	/* Read interrupt status */
-	ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
-	if (ret) {
-		dev_err(rt5677->dev, "failed reading IRQ status: %d\n", ret);
-		goto exit;
-	}
 
-	for (i = 0; i < RT5677_IRQ_NUM; i++) {
-		if (reg_irq & rt5677_irq_descs[i].status_mask) {
-			irq_fired = true;
-			virq = irq_find_mapping(rt5677->domain, i);
-			if (virq)
-				handle_nested_irq(virq);
-
-			/* Clear the interrupt by flipping the polarity of the
-			 * interrupt source line that fired
-			 */
-			reg_irq ^= rt5677_irq_descs[i].polarity_mask;
+	/*
+	 * Loop to handle interrupts until the last i2c read shows no pending
+	 * irqs. The interrupt line is shared by multiple interrupt sources.
+	 * After the regmap_read() below, a new interrupt source line may
+	 * become high before the regmap_write() finishes, so there isn't a
+	 * rising edge on the shared interrupt line for the new interrupt. Thus,
+	 * the loop is needed to avoid missing irqs.
+	 *
+	 * A safeguard of 20 loops is used to avoid hanging in the irq handler
+	 * if there is something wrong with the interrupt status update. The
+	 * interrupt sources here are audio jack plug/unplug events which
+	 * shouldn't happen at a high frequency for a long period of time.
+	 * Empirically, more than 3 loops have never been seen.
+	 */
+	for (loop = 0; loop < 20; loop++) {
+		/* Read interrupt status */
+		ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
+		if (ret) {
+			dev_err(rt5677->dev, "failed reading IRQ status: %d\n",
+				ret);
+			goto exit;
 		}
-	}
 
-	if (!irq_fired)
-		goto exit;
-
-	ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
-	if (ret) {
-		dev_err(rt5677->dev, "failed updating IRQ status: %d\n", ret);
-		goto exit;
+		irq_fired = false;
+		for (i = 0; i < RT5677_IRQ_NUM; i++) {
+			if (reg_irq & rt5677_irq_descs[i].status_mask) {
+				irq_fired = true;
+				virq = irq_find_mapping(rt5677->domain, i);
+				if (virq)
+					handle_nested_irq(virq);
+
+				/* Clear the interrupt by flipping the polarity
+				 * of the interrupt source line that fired
+				 */
+				reg_irq ^= rt5677_irq_descs[i].polarity_mask;
+			}
+		}
+		if (!irq_fired)
+			goto exit;
+
+		ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
+		if (ret) {
+			dev_err(rt5677->dev, "failed updating IRQ status: %d\n",
+				ret);
+			goto exit;
+		}
 	}
 exit:
 	mutex_unlock(&rt5677->irq_lock);
-- 
2.20.1

