Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157DCC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDA7218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103002;
	bh=f0OYkMKaH/beRppJ2OTFANbQskNXXJqk2ZhBixDyRUI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qiEUgNF2vJF3QWCa8qli4ev/othWhR7321RULNFb2j8WmSaFhZGr5IZu3wIHO99DB
	 qLAsSJJ6FKg3HFf1L2QM6zIgYZRnWZ+1byhAtYtXdip9EuzqJvrJWgLjxM5iaIQqX4
	 M0Nrlp92byOLV0jJm5/rugPwqjyvvPMTIORFoMhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfCTRaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44300 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCTR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XtyXEiiV7HtUwRyDVlL7/GxpPLGCd++wTmtcOX0310Y=; b=HI++VmBubKre
        kwXKlD2WpRWSzjsxGEkyv0C+K/CfC4cjQQahrULqt0GI1XDGP3U9mFhQZwTGga6HW9dyTHJrzksF3
        TJxfWzoHZqtrTf6XGlPzmBQXXqbn/jrZGmYy1oQpslTSvj8BQKbOph3nkK7VUfLaHDVyAPshD/6Av
        EcdJM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2H-00019Y-Bl; Wed, 20 Mar 2019 17:29:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DAA9F1126E4C; Wed, 20 Mar 2019 17:29:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: of: Make regulator_of_get_init_node static" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190320172952.DAA9F1126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: of: Make regulator_of_get_init_node static

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 7a67eb1d3abefe16b491b0e9801f98a98f15a3bf Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 19 Mar 2019 23:23:19 +0800
Subject: [PATCH] regulator: of: Make regulator_of_get_init_node static

Fix sparse warning:

drivers/regulator/of_regulator.c:374:20:
 warning: symbol 'regulator_of_get_init_node' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/of_regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 7b6bf3536271..6dca0ba044d8 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -371,8 +371,9 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(of_regulator_match);
 
-struct device_node *regulator_of_get_init_node(struct device *dev,
-					       const struct regulator_desc *desc)
+static struct
+device_node *regulator_of_get_init_node(struct device *dev,
+					const struct regulator_desc *desc)
 {
 	struct device_node *search, *child;
 	const char *name;
-- 
2.20.1

