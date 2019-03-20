Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E34C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86572218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553102976;
	bh=VBn8U8iX7R+SefDj+Uj7FKU7du0t+PjelTqr7TBKtaM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZRrmp6OW9SeB6oHmkjSdnRTeg/azm8LwhdwgIG3oCoWd62Z+YejCJnIzG8Q/DugCZ
	 QJ/vzWSvY3AfTrU1vZTx7FimLISbvSOyWkziQcJScudeZ4KCWEArBD/1OhLm04pxE/
	 If3XAYtPQZgQz7jJw8BPcs39B9IfLL7PGi9rb9HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCTR3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:29:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rp6NB9xNNh4uX2mxx8BntkrwhxEbDT3leRORdwcGVvU=; b=NA11nkwnF+k+
        0iSdQCMJMnQcqTYmyitGs3kGpHBOOnQZ8BKSccnaRK6qDEweou6Qlv/JpoyuYuexvvTEBoBNep5d+
        MHfL4AX6FLH5n53hDtcRlOzUF3uuZFzXv9IcXEZnarqXDILVLqvD10/puaj/XoHMpaOcCJ0enJyjr
        kfEk0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f1s-00018C-DV; Wed, 20 Mar 2019 17:29:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EADBE1126E4D; Wed, 20 Mar 2019 17:29:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org, krzk@kernel.org,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Don't use register read to determine slave/master mode" to the asoc tree
In-Reply-To:  <20190319121102.28069-1-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190320172927.EADBE1126E4D@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Don't use register read to determine slave/master mode

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From f29eec793d4d16a1019abac1ac0702d07adae78e Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 19 Mar 2019 13:11:02 +0100
Subject: [PATCH] ASoC: samsung: i2s: Don't use register read to determine
 slave/master mode

We can simplify the code by caching the CPU DAI master/slave
information rather than reading previously set register bit.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index ab471d550d17..9722940da6a4 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -88,12 +88,6 @@ struct samsung_i2s_priv {
 	struct platform_device *pdev;
 	struct platform_device *pdev_sec;
 
-	/* Memory mapped SFR region */
-	void __iomem *addr;
-
-	/* Spinlock protecting access to the device's registers */
-	spinlock_t lock;
-
 	/* Lock for cross interface checks */
 	spinlock_t pcm_lock;
 
@@ -122,6 +116,15 @@ struct samsung_i2s_priv {
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
+
+	/* Spinlock protecting member fields below */
+	spinlock_t lock;
+
+	/* Memory mapped SFR region */
+	void __iomem *addr;
+
+	/* A flag indicating the I2S slave mode operation */
+	bool slave_mode;
 };
 
 /* Returns true if this is the 'overlay' stereo DAI */
@@ -130,15 +133,6 @@ static inline bool is_secondary(struct i2s_dai *i2s)
 	return i2s->drv->id == SAMSUNG_I2S_ID_SECONDARY;
 }
 
-/* If operating in SoC-Slave mode */
-static inline bool is_slave(struct i2s_dai *i2s)
-{
-	struct samsung_i2s_priv *priv = i2s->priv;
-
-	u32 mod = readl(priv->addr + I2SMOD);
-	return (mod & (1 << priv->variant_regs->mss_off)) ? true : false;
-}
-
 /* If this interface of the controller is transmitting data */
 static inline bool tx_active(struct i2s_dai *i2s)
 {
@@ -715,6 +709,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	mod &= ~(sdf_mask | lrp_rlow | mod_slave);
 	mod |= tmp;
 	writel(mod, priv->addr + I2SMOD);
+	priv->slave_mode = (mod & mod_slave);
 	spin_unlock_irqrestore(&priv->lock, flags);
 	pm_runtime_put(dai->dev);
 
@@ -917,7 +912,7 @@ static int config_setup(struct i2s_dai *i2s)
 	set_rfs(i2s, rfs);
 
 	/* Don't bother with PSR in Slave mode */
-	if (is_slave(i2s))
+	if (priv->slave_mode)
 		return 0;
 
 	if (!(priv->quirks & QUIRK_NO_MUXPSR)) {
-- 
2.20.1

