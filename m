Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0221C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5562208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="Ir9CmDkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfKTSTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:19:51 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:11138 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfKTSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574273988;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=B1t/R73PXBi/xcZmdsHyecP+fHfXT1zfLtf97yMLTVQ=;
        b=Ir9CmDkzeLZCVeWkmtp4gqLUdEbmcT/zn5KuVG3xVtWP8HE5+l40QYQ7cRj9W+a1cg
        hfGJ2d7Vy6j1fMkf+aCzGAyYqLH+UMh9R9mCuxO5JnIwUIpyg1mfS0g1J2NZxj1vDuEv
        fqdv7GQZ3dbfJLDZvVB11EjyLBONBHWeA1j0PkLMQ9YGkJv5xF2zI25eDl6B+RJ7a8+h
        gVlzRt10Zgoh5uBRvGFzPyxEdHjCFqHV1JeAzc5hhOe+vTvje82YSHriPVbNs6k5HTyl
        pqKF/YS3/13iWG+fdDY67VqDFUrculERXr0So8XCWk6CkAc/7xucG4DQlfAZRDmquLCA
        NPgQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8Lvtn4="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAKIJlvAZ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Nov 2019 19:19:47 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 2/4] dt-bindings: vendor-prefixes: Deprecate "ste" and "st-ericsson"
Date:   Wed, 20 Nov 2019 19:18:55 +0100
Message-Id: <20191120181857.97174-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120181857.97174-1-stephan@gerhold.net>
References: <20191120181857.97174-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, device tree bindings for ST-Ericsson have been added
inconsistently with one of 3 possible vendor prefixes.

"stericsson" is the most commonly used vendor prefix,
so deprecate "ste" and "st-ericsson".

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2: new patch
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c9b0bab8ed23..490b5cc6b8e6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -907,10 +907,12 @@ patternProperties:
     description: Startek
   "^ste,.*":
     description: ST-Ericsson
+    deprecated: true
   "^stericsson,.*":
     description: ST-Ericsson
   "^st-ericsson,.*":
     description: ST-Ericsson
+    deprecated: true
   "^summit,.*":
     description: Summit microelectronics
   "^sunchip,.*":
-- 
2.24.0

