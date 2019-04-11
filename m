Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A10C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52689206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554981596;
	bh=z9LxgHDzoaYo2AU+gqlnUhvlog2VbTnMftZO/xOhVis=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gvLnnPcFJLEOlVosLvhC5AeTpGseUtG3yzw6LmrOFFxiwvjmL7Kv3pGt5AJ5fVudn
	 6MPJmQbxEgrPwkIDXhUncgWtSt7xpJ5mQDsbALEU0WEnTMZxxs2ciDpEuClKC6Rmzs
	 +Np7cSNTQCqRRyq2gzkwNMiTR6JFj7Y2SnWqVBEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDKLTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:19:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKLTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JfKdKSW69jjP9EDsRB+iv6YSvZKc1YLqpAGrnwMztbY=; b=kNriQxbFitu6
        kaftqSw7o+o08Vu/aVO08ZMsv6Pq8uJCovCrd/rPk8kE93FE+rO1P1jFM/W48Yq2+8eWUHEb3bCGy
        6K09gP47gNgW7oh3KmCnjcxePScwNdaEPSyEQEzjCh7g84tZOw3v0ch6mUSCEadym3+FI7sN13L/u
        k96wA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEXkF-00006z-9q; Thu, 11 Apr 2019 11:19:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7B2711126DD5; Thu, 11 Apr 2019 12:19:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Applied "regulator: vexpress: Constify regulator_ops" to the regulator tree
In-Reply-To: <20190410161937.17224-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190411111949.7B2711126DD5@debutante.sirena.org.uk>
Date:   Thu, 11 Apr 2019 12:19:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: vexpress: Constify regulator_ops

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

From ab54a4d7b0dd5f36cb6c2da83894590bc8bda5a5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Apr 2019 00:19:37 +0800
Subject: [PATCH] regulator: vexpress: Constify regulator_ops

vexpress_regulator_ops_ro and vexpress_regulator_ops are never changed,
make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/vexpress-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index c810cbbd463f..ca4230fe9e77 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -46,11 +46,11 @@ static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
 	return regmap_write(reg->regmap, 0, min_uV);
 }
 
-static struct regulator_ops vexpress_regulator_ops_ro = {
+static const struct regulator_ops vexpress_regulator_ops_ro = {
 	.get_voltage = vexpress_regulator_get_voltage,
 };
 
-static struct regulator_ops vexpress_regulator_ops = {
+static const struct regulator_ops vexpress_regulator_ops = {
 	.get_voltage = vexpress_regulator_get_voltage,
 	.set_voltage = vexpress_regulator_set_voltage,
 };
-- 
2.20.1

