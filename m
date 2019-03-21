Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC0B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553158145;
	bh=kKsOYcI2T6VAiFUjbXkORPJNFR29l8ahg+ZcFe9Kg10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cfwkUB2jvZhaDCS0ka06yzC3PkiCk0E7oek/2KKxfMZVOMWl1qcTNItfKtOHlh7tN
	 HX/J2j0trk51m/gfbn67ySGcWuBHJGqLR+9UcINpcJzDxlABzx5psAqMS+TSor+I2x
	 vyHunrpqARtMbY6jwm1/yqGzcA12n+IAvHSZ23tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfCUItD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:49:03 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:41414 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfCUItD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:49:03 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 298D95FB44; Thu, 21 Mar 2019 16:48:59 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/9] dt-bindings: power: supply: axp20x_usb_power: add axp813 compatible
Date:   Thu, 21 Mar 2019 16:48:42 +0800
Message-Id: <20190321084850.20769-2-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321084850.20769-1-wens@kernel.org>
References: <20190321084850.20769-1-wens@kernel.org>
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

