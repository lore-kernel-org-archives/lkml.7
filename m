Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06823C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9B021874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565256926;
	bh=6XujZRThlT20ujUIgPR3BdV/8GT656Lkz4URvZkvsdI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=erh1yGBpBu7IB8wJra2XlblA1ynw+KwM7nARmsV7SlY5vGO2Ab5iywJ3wQ/B5PfKu
	 BmU4FS8KVYb+QHAUCMQKWDIFaT+Pg820T8jRo60+vBabUwyxRghiRFm/GsL4Vu7EHT
	 T5gxcB02XLzVE8B09RCtHf7YedYQQPT8H8g7YHCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfHHJfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfHHJfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:35:25 -0400
Received: from localhost.localdomain (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D45A62173C;
        Thu,  8 Aug 2019 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565256924;
        bh=6XujZRThlT20ujUIgPR3BdV/8GT656Lkz4URvZkvsdI=;
        h=From:To:Cc:Subject:Date:From;
        b=H9FF7FUn2hcsKngjJGg0WVZxpX96jBrujUR9qDIZ2LoLPYBVq4oxeA7AOeSXTqDR2
         biaL7SAU4RVIpw7f3pP8/SOgPxqLE+uvTEO9ikAdx3d+ZRxUtEVbvoNQESFtXSd2Nc
         bmrwjN4olSkab5/ARhLb1FltonZ668yroJxQxu0E=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] regulator: dt-bindings: Add PM8150x compatibles
Date:   Thu,  8 Aug 2019 15:03:42 +0530
Message-Id: <20190808093343.5600-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PM8150, PM8150L and PM8009 compatibles for these PMICs found
in some Qualcomm platforms.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
index 14d2eee96b3d..1a9cab50503a 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
@@ -25,6 +25,9 @@ Supported regulator node names:
 	PM8998:		smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
 	PMI8998:	bob
 	PM8005:		smps1 - smps4
+	PM8150:		smps1 - smps10, ldo1 - ldo18
+	PM8150L:	smps1 - smps8, ldo1 - ldo11, bob, flash, rgb
+	PM8009:		smps1 - smps2, ld01 - ldo7
 
 ========================
 First Level Nodes - PMIC
@@ -35,7 +38,10 @@ First Level Nodes - PMIC
 	Value type: <string>
 	Definition: Must be one of: "qcom,pm8998-rpmh-regulators",
 		    "qcom,pmi8998-rpmh-regulators" or
-		    "qcom,pm8005-rpmh-regulators".
+		    "qcom,pm8005-rpmh-regulators" or
+		    "qcom,pm8150-rpmh-regulators" or
+		    "qcom,pm8150l-rpmh-regulators" or
+		    "qcom,pm8009-rpmh-regulators".
 
 - qcom,pmic-id
 	Usage:      required
-- 
2.20.1

