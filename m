Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F690C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCDB2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="dPeAcA1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbfC0Cdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:33:52 -0400
Received: from vps.xff.cz ([195.181.215.36]:55120 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732617AbfC0Cdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553654028; bh=S1jLp574hnK0CY+FYoqQJqxFPycojWM2CD1ibwebjmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPeAcA1qatRKERktzEeiXuxUhqQGkumIC1xIbULGNwQbnDLqBiCyEAxhDpr0hEPG1
         vR7iFC86CXNOrnolFSv2K0C28lYH/yZ96DpUnqY9QsoSw/jNYBlB7R95GuKJI/zpTp
         YkPwifAESPBmS5QNXqBfFXvjqWkn1fnLlA/KvFsw=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mark.rutland@arm.com
Cc:     Ziping Chen <techping.chan@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-input@vger.kernel.org,
        hdegoede@redhat.com
Subject: [PATCH RESEND v4 2/4] dt-bindings: input: Add R_LRADC support for A83T
Date:   Wed, 27 Mar 2019 03:33:37 +0100
Message-Id: <20190327023339.25975-3-megous@megous.com>
In-Reply-To: <20190327023339.25975-1-megous@megous.com>
References: <20190327023339.25975-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziping Chen <techping.chan@gmail.com>

Allwinner A83T SoC has a low res ADC like the one in Allwinner A10 SoC.

Add binding for it.

Signed-off-by: Ziping Chen <techping.chan@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/sun4i-lradc-keys.txt          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
index 1458c3179a63..496125c6bfb7 100644
--- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
+++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
@@ -2,12 +2,14 @@ Allwinner sun4i low res adc attached tablet keys
 ------------------------------------------------
 
 Required properties:
- - compatible: "allwinner,sun4i-a10-lradc-keys"
+ - compatible: should be one of the following string:
+		"allwinner,sun4i-a10-lradc-keys"
+		"allwinner,sun8i-a83t-r-lradc"
  - reg: mmio address range of the chip
  - interrupts: interrupt to which the chip is connected
  - vref-supply: powersupply for the lradc reference voltage
 
-Each key is represented as a sub-node of "allwinner,sun4i-a10-lradc-keys":
+Each key is represented as a sub-node of the compatible mentioned above:
 
 Required subnode-properties:
 	- label: Descriptive name of the key.
-- 
2.21.0

