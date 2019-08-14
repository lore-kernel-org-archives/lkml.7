Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E2AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A30208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565786215;
	bh=iw7/VOdW7KyurNi2mN9MCaftt4mJsQIbhD4ac/JMS08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c30qoS5PF8bsO6qJuSVyZl5QgnxMmzy+Y4aDeIJdNsJvOWNOBeh889fKqNhkaMLgF
	 2KPCAtQxD5N2F27hawoaXsUTeRqHhAbShL+qnygR9EeRteHV1ipz9MuHqlWjaDVDa/
	 8chxX+A/7qpFBtCrlU4quokk5OmsssmNQD1FsuOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfHNMgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:36:53 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DC8214DA;
        Wed, 14 Aug 2019 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565786212;
        bh=iw7/VOdW7KyurNi2mN9MCaftt4mJsQIbhD4ac/JMS08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYMGZ4F2C016+yIxESrvTfcGGu1G3m80KFPKMkBm585htPG2zIwAAQxEhwMpr7Vdx
         +1d28PXinWL+jnEdnJhsYMIRySOyt+o2y4ApGXuay/XlakUuKk31olwS4ticd+OGBo
         dx3zNuvBaI7MagLWcEEhDxOt9q9mVJ17arK2zlQY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm8150l support
Date:   Wed, 14 Aug 2019 18:05:12 +0530
Message-Id: <20190814123512.6017-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814123512.6017-1-vkoul@kernel.org>
References: <20190814123512.6017-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the PM8150l GPIO support to the Qualcomm PMIC GPIO
binding.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 1 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index 457459d17e79..c32bf3237545 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -99,6 +99,7 @@ to specify in a pin configuration subnode:
 		    gpio1-gpio10 for pm8150 (holes on gpio2, gpio5, gpio7
 					     and gpio8)
 		    gpio1-gpio12 for pm8150b (holes on gpio3, gpio4, gpio7)
+		    gpio1-gpio12 for pm8150l (hole on gpio7)
 
 - function:
 	Usage: required
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 931c9349f145..6f935e46f12c 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1159,6 +1159,8 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8150-gpio", .data = (void *) 10 },
 	/* pm8150b has 12 GPIOs with holes on 3, r and 7 */
 	{ .compatible = "qcom,pm8150b-gpio", .data = (void *) 12 },
+	/* pm8150l has 12 GPIOs with holes on 7 */
+	{ .compatible = "qcom,pm8150l-gpio", .data = (void *) 12 },
 	{ },
 };
 
-- 
2.20.1

