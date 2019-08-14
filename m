Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A24C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6795D208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565786211;
	bh=N+bESiPHdBuUSXfODkzFtGLhH2/mdS9C7M3DN19vQC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rSOzzu2qMBp88Z4P5QmwMmGazNYO5G9j1Tz/2pDQ3WKBcxlHEqXxU8Swjk/I96KTM
	 BAr7OpubI2TQ+tndLhNysgfTyp5nlFWBkzmg4HHAd4ax0C5+kkxuPBgocLLlioWtUu
	 N+/SrpeOYrqoJgAAdClOG/b9Awuq8DmEJbM8I150=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfHNMgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:36:48 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C468D21721;
        Wed, 14 Aug 2019 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565786208;
        bh=N+bESiPHdBuUSXfODkzFtGLhH2/mdS9C7M3DN19vQC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7n7REfud2nmzAOkRdjU/gg2LpxyolmZMimtTo3WA8mySoaEcpNCCkolx+HxsrAG6
         LUKiILBoBW12upKDPCBDR1G194XDriSGTmvFtO2Fdm23vjiF494Ac93/59lpbgoWlL
         boFd+xKWtkTwL0SfXX9daNFWdGccriG5Qkkr20iE=
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm8150b support
Date:   Wed, 14 Aug 2019 18:05:11 +0530
Message-Id: <20190814123512.6017-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814123512.6017-1-vkoul@kernel.org>
References: <20190814123512.6017-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the PM8150b GPIO support to the Qualcomm PMIC GPIO
binding.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index 56553c06f129..457459d17e79 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -22,6 +22,7 @@ PMIC's from Qualcomm.
 		    "qcom,pmi8998-gpio"
 		    "qcom,pms405-gpio"
 		    "qcom,pm8150-gpio"
+		    "qcom,pm8150b-gpio"
 
 		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
 		    if the device is on an spmi bus or an ssbi bus respectively
@@ -97,6 +98,7 @@ to specify in a pin configuration subnode:
 		    gpio1-gpio12 for pms405 (holes on gpio1, gpio9 and gpio10)
 		    gpio1-gpio10 for pm8150 (holes on gpio2, gpio5, gpio7
 					     and gpio8)
+		    gpio1-gpio12 for pm8150b (holes on gpio3, gpio4, gpio7)
 
 - function:
 	Usage: required
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 5286ec060894..931c9349f145 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1157,6 +1157,8 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pms405-gpio", .data = (void *) 12 },
 	/* pm8150 has 10 GPIOs with holes on 2, 5, 7 and 8 */
 	{ .compatible = "qcom,pm8150-gpio", .data = (void *) 10 },
+	/* pm8150b has 12 GPIOs with holes on 3, r and 7 */
+	{ .compatible = "qcom,pm8150b-gpio", .data = (void *) 12 },
 	{ },
 };
 
-- 
2.20.1

