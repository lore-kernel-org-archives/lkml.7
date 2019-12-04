Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF9BC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA56F20674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575461743;
	bh=1ED1R/cUDd4gwFpkgu7qT90wPlhKtqXVaWit5W7jXR4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Kji3ZF5/4WyQJl4lRL1gRiKawytbGehOohXdMiRHiEKHys34EgzxOprl+hJWmM69n
	 L10f0888zOBou6F62mHYQ9EBknNSZTLnCnSPcTECpCHxK1Q/ivUHM1Sa0taSyEmTqx
	 /XmLW51seoPAZ7ynLPzbM/JI15UFzcVJf90F5kEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfLDMPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:15:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52450 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nJI9bFopWb7W81ncH/qoxkAYT5bre4TUTX6Zr90oAKg=; b=mDD+AJe531Ju
        DCfXeQkdUwL0LFlYTBn7QHCuvSeLMKpcpFQmbvXvjyXtFSdhThL7SO72Bwt6RRx/XewFtnUX/qC2x
        ZZhxsIYFVcxkKnHj+Jhiwn8Fe2k6T2oFtZUzPX3Md+cshV1PbHLcEOHM9CzDjSf64LmoiIaP1w3kv
        kakwI=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1icTZA-0000AV-ST; Wed, 04 Dec 2019 12:15:36 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 383D3D003B4; Wed,  4 Dec 2019 12:15:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     broonie@kernel.org, b.zolnierkie@samsung.com,
        kernel-janitors@vger.kernel.org, krzk@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        sbkim73@samsung.com
Subject: Applied "regulator: s5m8767: Fix a warning message" to the regulator tree
In-Reply-To: <20191203214838.9680-1-christophe.jaillet@wanadoo.fr>
Message-Id: <applied-20191203214838.9680-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Date:   Wed,  4 Dec 2019 12:15:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s5m8767: Fix a warning message

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

From f3c7f7b636ef5061906aa119eccc2b8dbbaf7199 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 3 Dec 2019 22:48:38 +0100
Subject: [PATCH] regulator: s5m8767: Fix a warning message

Axe a duplicated word ("property") in a warning message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20191203214838.9680-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s5m8767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index bdc07739e9a2..12d6b8d2e97e 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -588,7 +588,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 		if (of_property_read_u32(reg_np, "op_mode",
 				&rmode->mode)) {
 			dev_warn(iodev->dev,
-				"no op_mode property property at %pOF\n",
+				"no op_mode property at %pOF\n",
 				reg_np);
 
 			rmode->mode = S5M8767_OPMODE_NORMAL_MODE;
-- 
2.20.1

