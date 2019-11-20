Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910C1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F335224CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="mwe1Z5uT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfKTMTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:19:00 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:13778 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfKTMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574252338;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Dzh8SFoA3sNROsDXQ3RrtKvhSUXT8MqRPyWi4MJ3Gtc=;
        b=mwe1Z5uT9HnvDnTSs1D8aBmxSZpOQ3JsXWxmVrg7oVkYxIP4GPJgRmXK7f2HmY5NxJ
        XLffGuwho6o543r1nvWYuK1TyKuyPQBmp4IU6yPJv1kfoAuHfU07FArWGJVmIAic9Z5u
        JB80uxPsNN8MUw+g8jivj5xGnZ1Ie9rU370FVkD1JXr3ivz80j8PonFe0+e9elhppojk
        jgfX6nK/r5Dld9vE+HtslNbAy3B74m/HLIYYdJE+ODPUcsGSSAT5HDgZdmss1Hdgh9CY
        kGCLSRGWQfEQF6M9b8dA1GtjuM8tYGLWUtEfuchLVH7idGmvhTE1PTwlNREUz4fOJ9Ir
        wDXw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8Lvtn4="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAKCIusCI
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Nov 2019 13:18:56 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add yet another for ST-Ericsson
Date:   Wed, 20 Nov 2019 13:17:18 +0100
Message-Id: <20191120121720.72845-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately the vendor prefix for ST-Ericsson is used very
inconsistently. "ste," and "stericsson," are already documented,
but some things in the kernel use "st-ericsson," which is not
documented yet.

st-ericsson,u8500 is documented in bindings/arm/ux500/boards.txt,
and is used to match the machine code and the generic DT cpufreq
driver.

Add it to the list of vendor prefixes.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..c9b0bab8ed23 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -909,6 +909,8 @@ patternProperties:
     description: ST-Ericsson
   "^stericsson,.*":
     description: ST-Ericsson
+  "^st-ericsson,.*":
+    description: ST-Ericsson
   "^summit,.*":
     description: Summit microelectronics
   "^sunchip,.*":
-- 
2.24.0

