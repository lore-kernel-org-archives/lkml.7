Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D05C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5F4206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272177;
	bh=lkO6Rz2DiapVeRSd0t08iMd6FYynDAws5LZk6Y39F5M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yKF0GKXf16XfYUaulswP4LQabHGxjDl1ry+hP4k/yJ0XDi1/hw5IwpYiFuMIrGUap
	 mR4iYBNtu5H8XaBNEBivX+LcwkNeN4mavfs0Cbjl++JObbhm10zby1cxb7PBCr39Hi
	 pXDFD8eKeFq6BbUAo6/az/4JMh72l2Znjn2eRklI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDZJtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:49:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45424 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDZJkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RSLf2VHcn1xnUInCdFeL3Ts/cHHcDwd9UlEvJRmoBa0=; b=Jl4pnAdBKOu0
        5haoJmfDmPp9qh0lwmtR9Ks4/eO8AMAQkkTrB0/fjqum04nAJuBrgZv+8DCZdUk9b5/qErWCYHBY/
        hFbYDFJiMBMxEsLanZcCd+uQrF3sCaPoeLG/n3WGqIWguM+yKaRa2JiK0hai046YiQM2viFaaIKmH
        t+9Zk=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxL7-0003Hv-0H; Fri, 26 Apr 2019 09:40:17 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 071FC441D3D; Fri, 26 Apr 2019 10:40:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: sy8106a: Get rid of struct sy8106a" to the regulator tree
In-Reply-To: <20190420030125.6661-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190426094015.071FC441D3D@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:14 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: sy8106a: Get rid of struct sy8106a

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

From 5d7ebba38bafa8f6eba2540e8a36233ea6d6d0dc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 20 Apr 2019 11:01:25 +0800
Subject: [PATCH] regulator: sy8106a: Get rid of struct sy8106a

All the fields in struct sy8106a are only used in sy8106a_i2c_probe(), so
use local variables instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/sy8106a-regulator.c | 40 +++++++++------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
index 65fbd1f0b612..42e03b2c10a0 100644
--- a/drivers/regulator/sy8106a-regulator.c
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -22,12 +22,6 @@
  */
 #define SY8106A_GO_BIT			BIT(7)
 
-struct sy8106a {
-	struct regulator_dev *rdev;
-	struct regmap *regmap;
-	u32 fixed_voltage;
-};
-
 static const struct regmap_config sy8106a_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -70,36 +64,32 @@ static const struct regulator_desc sy8106a_reg = {
 static int sy8106a_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct sy8106a *chip;
 	struct device *dev = &i2c->dev;
-	struct regulator_dev *rdev = NULL;
+	struct regulator_dev *rdev;
 	struct regulator_config config = { };
+	struct regmap *regmap;
 	unsigned int reg, vsel;
+	u32 fixed_voltage;
 	int error;
 
-	chip = devm_kzalloc(&i2c->dev, sizeof(struct sy8106a), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
 	error = of_property_read_u32(dev->of_node, "silergy,fixed-microvolt",
-				     &chip->fixed_voltage);
+				     &fixed_voltage);
 	if (error)
 		return error;
 
-	if (chip->fixed_voltage < SY8106A_MIN_MV * 1000 ||
-	    chip->fixed_voltage > SY8106A_MAX_MV * 1000)
+	if (fixed_voltage < SY8106A_MIN_MV * 1000 ||
+	    fixed_voltage > SY8106A_MAX_MV * 1000)
 		return -EINVAL;
 
-	chip->regmap = devm_regmap_init_i2c(i2c, &sy8106a_regmap_config);
-	if (IS_ERR(chip->regmap)) {
-		error = PTR_ERR(chip->regmap);
+	regmap = devm_regmap_init_i2c(i2c, &sy8106a_regmap_config);
+	if (IS_ERR(regmap)) {
+		error = PTR_ERR(regmap);
 		dev_err(dev, "Failed to allocate register map: %d\n", error);
 		return error;
 	}
 
 	config.dev = &i2c->dev;
-	config.regmap = chip->regmap;
-	config.driver_data = chip;
+	config.regmap = regmap;
 
 	config.of_node = dev->of_node;
 	config.init_data = of_get_regulator_init_data(dev, dev->of_node,
@@ -109,15 +99,15 @@ static int sy8106a_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	/* Ensure GO_BIT is enabled when probing */
-	error = regmap_read(chip->regmap, SY8106A_REG_VOUT1_SEL, &reg);
+	error = regmap_read(regmap, SY8106A_REG_VOUT1_SEL, &reg);
 	if (error)
 		return error;
 
 	if (!(reg & SY8106A_GO_BIT)) {
-		vsel = (chip->fixed_voltage / 1000 - SY8106A_MIN_MV) /
+		vsel = (fixed_voltage / 1000 - SY8106A_MIN_MV) /
 		       SY8106A_STEP_MV;
 
-		error = regmap_write(chip->regmap, SY8106A_REG_VOUT1_SEL,
+		error = regmap_write(regmap, SY8106A_REG_VOUT1_SEL,
 				     vsel | SY8106A_GO_BIT);
 		if (error)
 			return error;
@@ -131,10 +121,6 @@ static int sy8106a_i2c_probe(struct i2c_client *i2c,
 		return error;
 	}
 
-	chip->rdev = rdev;
-
-	i2c_set_clientdata(i2c, chip);
-
 	return 0;
 }
 
-- 
2.20.1

