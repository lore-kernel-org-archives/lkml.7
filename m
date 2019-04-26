Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B0C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A723206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271838;
	bh=z7jl4q+Sz0t+e1M8+Mf9R0KwnwHIR4tHvwSzs8HTemg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XKj9p9yI8wYmaaybQFdRRXS6y423uGP5l9flu178WKf4qwmpwK63EIwf7gj94HsVw
	 TnYpJO9qeYBMTjSxnHPhZWh6v+5vBQH8GpAtEJ7PskJ5jjk4cmRGc3mp6y6Tk4ujte
	 cmrz6Qto07j9eqC2VUcDuhw7ODnytgG6RAG0cVDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfDZJn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:43:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45610 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfDZJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xyrB61ZcsA7w8QQMNTNsT4INetcMTolXtVi1jB7Rq/8=; b=GtA0Bl5VRBLR
        qAFBD0HucvTP/8Av/wiTwVIOkVhhdGcAeQXVO3qH6kavXkebELIThWJh3LnDIBMqVOfICYUY7ENXN
        /VHlARMkmPGuZ+0tuIvAnjFoPLpEPpjb/WZCmEWDAZteyLHKTOE5on2oXgGA02+3q5uWEyvQhgeiu
        mQFLc=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxL7-0003Hx-C8; Fri, 26 Apr 2019 09:40:17 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 80440441D3E; Fri, 26 Apr 2019 10:40:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     broonie@kernel.org, jorge.ramirez-ortiz@linaro.org,
        khasim.mohammed@linaro.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: do not report EPROBE_DEFER as error but as debug" to the regulator tree
In-Reply-To: <20190417192443.6501-1-jorge.ramirez-ortiz@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190426094015.80440441D3E@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: do not report EPROBE_DEFER as error but as debug

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

From b9816363c0e82f4cd8f9be8153fbc5b81b22911c Mon Sep 17 00:00:00 2001
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Date: Wed, 17 Apr 2019 21:24:43 +0200
Subject: [PATCH] regulator: core: do not report EPROBE_DEFER as error but as
 debug

Temporary failures to get a regulator (EPROBE_DEFER) should be logged
as debug information instead of errors.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5a9ebcf7fe7a..08ccabe07fe3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4345,8 +4345,6 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = PTR_ERR(consumers[i].consumer);
-			dev_err(dev, "Failed to get supply '%s': %d\n",
-				consumers[i].supply, ret);
 			consumers[i].consumer = NULL;
 			goto err;
 		}
@@ -4355,6 +4353,13 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 	return 0;
 
 err:
+	if (ret != -EPROBE_DEFER)
+		dev_err(dev, "Failed to get supply '%s': %d\n",
+			consumers[i].supply, ret);
+	else
+		dev_dbg(dev, "Failed to get supply '%s', deferring\n",
+			consumers[i].supply);
+
 	while (--i >= 0)
 		regulator_put(consumers[i].consumer);
 
-- 
2.20.1

