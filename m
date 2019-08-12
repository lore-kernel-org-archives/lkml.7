Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D0DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4D82070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565629164;
	bh=Ci82lONq88I3sucz76yHUJovvhW4UMeWeK/z+hWWIaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h70l4vuAtVfyLBhIfBY5cL+8Q+dcZQ30V9tM5CDPD9i1Yb8owzKFPiC99t+C//zxJ
	 RxtyYlGEmkeveY4TB+6Upc+iVyOLNMi1gqv3ZJgGzqQWbJ5aUuZD1bWf1u7/qdF1/Y
	 OVG5jqw/n4gnuRsPLtEUFuxwclsY7EZrEogltQBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfHLQ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLQ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:59:22 -0400
Received: from localhost.localdomain (unknown [194.230.155.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C5B02070C;
        Mon, 12 Aug 2019 16:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565629161;
        bh=Ci82lONq88I3sucz76yHUJovvhW4UMeWeK/z+hWWIaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVc7swFB2gvBEN8sHIIC2yxSfxMS0vHNLNlyFG5ZotexZ8VHm51rJsBaeUzzL0iip
         uwuaFY4R4yXLUc5jZpz2o5CX7apIoByQ7mUEv04ZQZx0QpFtrP5w0ijH4b9uJYS/L6
         TJBvHCfOPeNmoQZUr6M2faySX/lrRlxjvbXJAaC8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: eeprom: at25: Add Anvo ANV32E61W
Date:   Mon, 12 Aug 2019 18:59:08 +0200
Message-Id: <20190812165909.12387-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812165909.12387-1-krzk@kernel.org>
References: <20190812165909.12387-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for ANV32E61W 64kb Serial SPI non-volatile SRAM.
Although it is a SRAM device, it can be accessed through EEPROM
interface. At least until there is no proper SRAM driver support for
it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes since v4:
1. Update commit msg.
---
 Documentation/devicetree/bindings/eeprom/at25.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index b3bde97dc199..42577dd113dd 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.txt
+++ b/Documentation/devicetree/bindings/eeprom/at25.txt
@@ -3,6 +3,7 @@ EEPROMs (SPI) compatible with Atmel at25.
 Required properties:
 - compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
   Example "<vendor>,<type>" values:
+    "anvo,anv32e61w"
     "microchip,25lc040"
     "st,m95m02"
     "st,m95256"
-- 
2.17.1

