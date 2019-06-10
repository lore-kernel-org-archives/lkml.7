Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC07DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9592086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560188091;
	bh=fcm35JOA6ZapFfDwSJbUiZT06l0PsXp6oUU4RnwG7Do=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cxMoECwL0GAYQv831WmRZR1ZpgcHtPTaCV0XlGJ6wHfkU72SDo+x3hgQzzJkjGgkX
	 Ro0LxqhXEo0nyvUNnRM36qC1ZazBTv6pkjkbp1+OrFgV2h5lmlGrJ9gFi3+tlyKEBE
	 sL6lC/STXNWOb3+jPfez1UH25Kutz6mswvg+CP1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfFJRev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:34:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52992 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbfFJRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WmWx1d5ZiY2U4Nqy7aAua5rzNc7jtyqb64fzhepsCbs=; b=ejX2a8rT1GNj
        L6p7eJrhEy61yaaxVHEJDbji7wV5Atg4xjp49wZfJA3VaSfcAfuWKI83Wc/J8MtPutJutQKGRcGGR
        W+3X3vvV97fVaQD93g+BmOSKPuCJdv569Eg+hg3WHkcPvWgVSzotuT3HwOfme6/hkAlNm6hTRcCuN
        8iQ0E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1haOBz-0006G3-4e; Mon, 10 Jun 2019 17:34:47 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B100A440046; Mon, 10 Jun 2019 18:34:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max8952: simplify getting the adapter of a client" to the regulator tree
In-Reply-To: <20190608105619.593-26-wsa+renesas@sang-engineering.com>
X-Patchwork-Hint: ignore
Message-Id: <20190610173446.B100A440046@finisterre.sirena.org.uk>
Date:   Mon, 10 Jun 2019 18:34:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8952: simplify getting the adapter of a client

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

From 6b96092a6bfa65566dda2f5a68a559a743b8d132 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sat, 8 Jun 2019 12:56:04 +0200
Subject: [PATCH] regulator: max8952: simplify getting the adapter of a client

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8952.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index cf2a2912cb1b..451237efb359 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -192,7 +192,7 @@ static struct max8952_platform_data *max8952_parse_dt(struct device *dev)
 static int max8952_pmic_probe(struct i2c_client *client,
 		const struct i2c_device_id *i2c_id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct max8952_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct regulator_config config = { };
 	struct max8952_data *max8952;
-- 
2.20.1

