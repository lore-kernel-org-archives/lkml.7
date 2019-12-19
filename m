Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B10DC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4202A2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="LM/garMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLSUVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:21:52 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:26188 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLSUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576786902;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Rg1wYXnRn/k+RIKPQ+i/0sUB5Vcf5b0Q6aPGnn8D5qM=;
        b=LM/garMZg6iB0EkPir6E49hZkxbTF9h25s7U4mZ0vq2we3kGDBeop/iBeAhdqwNGuM
        aeBoFMUhO6UWnc866SaweLVr3pG1HL/6oaWsT94n8Barlz8+Eq0hmJ3y863UZZu2Yv6B
        5VWr4J1OgMfggBR9fYZ6Kxpv4VVzAYrn4VBYCw8ia8Ss2RUhx3q/wdd6dgK2T/ynFst+
        plz2L+J7EM5Gc7Zr4D8R+/HyU1QEdC94QAUirzsDWZePPS08vjqSMUR6pTlJg9wmbqkI
        XdXHUOd225GPjRAZPVPle4bQ0VAB8/Wq0G14FFE+wA59xUJTWv0aTw1rLIdvAY4Ldvc6
        lAAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtszvsxM1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id f021e2vBJKLf3ZA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 21:21:41 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/9] dt-bindings: arm: ux500: Document samsung,golden compatible
Date:   Thu, 19 Dec 2019 21:20:46 +0100
Message-Id: <20191219202052.19039-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
References: <20191219202052.19039-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung Galaxy S III mini ("samsung-golden") can now boot
mainline Linux; document the samsung,golden compatible that is
used in its device tree.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/arm/ux500.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ux500.yaml b/Documentation/devicetree/bindings/arm/ux500.yaml
index 006cb4a5f331..accaee906050 100644
--- a/Documentation/devicetree/bindings/arm/ux500.yaml
+++ b/Documentation/devicetree/bindings/arm/ux500.yaml
@@ -29,3 +29,8 @@ properties:
         items:
           - const: calaosystems,snowball-a9500
           - const: st-ericsson,u9500
+
+      - description: Samsung Galaxy S III mini (GT-I8190)
+        items:
+          - const: samsung,golden
+          - const: st-ericsson,u8500
-- 
2.24.1

