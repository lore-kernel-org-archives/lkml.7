Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF25C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C42F2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555396854;
	bh=kKsOYcI2T6VAiFUjbXkORPJNFR29l8ahg+ZcFe9Kg10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KnMC1MJg/MMIIuiF4G1buu4wEs3ct+dp3NNTcAfOMlCNszkxqAlhpdQv+PAR8yrGy
	 PsjVBstWnMYB0PIh6i5LLeXqRV5io0nWjHyRcsRk4LR6QzQ90coJT1jGijAzJuWJX3
	 GTfrTlOPLDtoLSXc6DJZgxLTzgkUgbLU7sqXGcQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfDPGke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:40:34 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33984 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPGk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:40:29 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 87E1F5FAAE; Tue, 16 Apr 2019 14:40:25 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/7] dt-bindings: power: supply: axp20x_usb_power: add axp813 compatible
Date:   Tue, 16 Apr 2019 14:40:18 +0800
Message-Id: <20190416064024.20414-2-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416064024.20414-1-wens@kernel.org>
References: <20190416064024.20414-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

This adds the "x-powers,axp813-usb-power-supply" to the list of
compatibles for AXP20X VBUS power supply driver.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---
Changes since v2:

  - Collected Rob's Reviewed-by
---
 .../devicetree/bindings/power/supply/axp20x_usb_power.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
index ba8d35f66cbe..b2d4968fde7d 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
@@ -4,6 +4,7 @@ Required Properties:
 -compatible: One of: "x-powers,axp202-usb-power-supply"
                      "x-powers,axp221-usb-power-supply"
                      "x-powers,axp223-usb-power-supply"
+		     "x-powers,axp813-usb-power-supply"
 
 The AXP223 PMIC shares most of its behaviour with the AXP221 but has slight
 variations such as the former being able to set the VBUS power supply max
-- 
2.20.1

