Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB6CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCC722DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566315331;
	bh=IITaosdUtip46i/tGR7J7JYGDU+TS4TGSAhcJ3raD2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nq9v920i5TuCeHWlatNbggvtIjbbRkaMDa8STLzDV5HECToWENHIH9BZFn6l0jxxC
	 g7ev4DosLzgHidhfZG8gmnrCoioVaO4snkHp2iH671NC69bqx5qJl+hgqhpsuyfLQV
	 Mp6+Sogg6Q/aJ5OiFXFX8PSYsbB3m3V9kErZlV+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfHTPfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfHTPf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:35:29 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C64AD22DBF;
        Tue, 20 Aug 2019 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566315328;
        bh=IITaosdUtip46i/tGR7J7JYGDU+TS4TGSAhcJ3raD2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9tXkHjnPTTVz7Fo5NjOXrNaM3AjpRLDhi1k07DLYGOmTR5+VZWez+GD9ViSwAUgm
         ovhOLa+POiqbyOZQ/KEXmsZF6pNuVffQ+a3cpJlKVZSZbdUEj8PiNdyndJkevTT0up
         jGaMb8gYC2DDTR4eUjOg2fDQ8QKAZIwGL09MMICI=
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
Subject: [PATCH v6 2/4] dt-bindings: eeprom: at25: Add Anvo ANV32E61W
Date:   Tue, 20 Aug 2019 17:35:16 +0200
Message-Id: <1566315318-30320-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566315318-30320-1-git-send-email-krzk@kernel.org>
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
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
2.7.4

