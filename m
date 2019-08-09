Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C380AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986AF21783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565336281;
	bh=xJ06Rw2bD98VbzbDaAf9MrgpGSViWRaA7VrMXNT/U6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DA+EFPCmUUjkdaerLg/+2Oxx5NSad3lirqI63bxbTycLJ87nn5kAlmoDwovFH1MSe
	 Kmq9lUc0yi4OKwc+Ujntm2FTqM5V/L6DYAsWf1IuMU0TcZRoyqIzMA0BNYb8Goujlj
	 EBmDEuPfJ+DJGbKMeYMFmrdssDN4Nefp2ehI6RjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405924AbfHIHh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfHIHh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:37:58 -0400
Received: from localhost.localdomain (unknown [122.167.65.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167E42173E;
        Fri,  9 Aug 2019 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565336277;
        bh=xJ06Rw2bD98VbzbDaAf9MrgpGSViWRaA7VrMXNT/U6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWM/JM1+NhPmxd8fC6vvqkbglJ7pLii3xhqL4DpFDZJxPEhilA7zXwIQbZchu4vT2
         INu6QlP6AGqqhx2zmI1IdxcqxMDJXRjm4jIBHNQJhEgAMX/IvkPFNy8pQh4Fv3FTCf
         2SsjXOW9jSdWhkN8BIHe6DVTbI3dHAvUDsjT3kCw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/4] regulator: qcom-rpmh: Sort the compatibles
Date:   Fri,  9 Aug 2019 13:06:14 +0530
Message-Id: <20190809073616.1235-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809073616.1235-1-vkoul@kernel.org>
References: <20190809073616.1235-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It helps to keep sorted order for compatibles, so sort them

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 693ffec62f3e..0ef2716da3bd 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -878,18 +878,14 @@ static int rpmh_regulator_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rpmh_regulator_match_table[] = {
-	{
-		.compatible = "qcom,pm8998-rpmh-regulators",
-		.data = pm8998_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmi8998-rpmh-regulators",
-		.data = pmi8998_vreg_data,
-	},
 	{
 		.compatible = "qcom,pm8005-rpmh-regulators",
 		.data = pm8005_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8009-rpmh-regulators",
+		.data = pm8009_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8150-rpmh-regulators",
 		.data = pm8150_vreg_data,
@@ -899,8 +895,12 @@ static const struct of_device_id rpmh_regulator_match_table[] = {
 		.data = pm8150l_vreg_data,
 	},
 	{
-		.compatible = "qcom,pm8009-rpmh-regulators",
-		.data = pm8009_vreg_data,
+		.compatible = "qcom,pm8998-rpmh-regulators",
+		.data = pm8998_vreg_data,
+	},
+	{
+		.compatible = "qcom,pmi8998-rpmh-regulators",
+		.data = pmi8998_vreg_data,
 	},
 	{}
 };
-- 
2.20.1

