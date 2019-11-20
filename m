Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DBB224CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="O9ZWOpUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfKTMTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:19:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:28059 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbfKTMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574252346;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=nRjRjb+1ekixEHhoSS1DNrxvmTlCCbOleOoilsPpvGI=;
        b=O9ZWOpUhQyM5oxobzlsIhcgbqK9OIzKQwPuwpiZh2JSa2ue6biAQG+fpkG3XH6+fM8
        TixCZVRa8S3DGQUyeODul8MSTKQN3IJcgKNE7T40Uh7PPkr8b73c7DdgN/1In8RQ2v5a
        AG5kHnbvRYk2Nx9WL9ypHH8rKU4VW70dFRVS+kufn4iylXV176LIiauQy9+zovVWr5oj
        idpfnjC65QFhkpTUrCy+WfKqH2T/TOjgJpY6Io4xSMSbbYMynt1bdpCTDNg+hGVI/ath
        rEfd+YaAWehl2oEVELJ9VG76/0qB+zkgRiuQuVXyG08SYPDLKj/X9853uyPuq6/cJ7ha
        6FbA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8Lvtn4="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAKCIvsCL
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Nov 2019 13:18:57 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/3] dt-bindings: arm: Document compatibles for Ux500 boards
Date:   Wed, 20 Nov 2019 13:17:20 +0100
Message-Id: <20191120121720.72845-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120121720.72845-1-stephan@gerhold.net>
References: <20191120121720.72845-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device-specific compatible values used by the Ux500 boards
were not documented so far. Add a new simple schema to document them.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/arm/ux500.yaml        | 31 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500.yaml

diff --git a/Documentation/devicetree/bindings/arm/ux500.yaml b/Documentation/devicetree/bindings/arm/ux500.yaml
new file mode 100644
index 000000000000..006cb4a5f331
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ux500.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ux500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ux500 platforms device tree bindings
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: ST-Ericsson HREF (pre-v60)
+        items:
+          - const: st-ericsson,mop500
+          - const: st-ericsson,u8500
+
+      - description: ST-Ericsson HREF (v60+)
+        items:
+          - const: st-ericsson,hrefv60+
+          - const: st-ericsson,u8500
+
+      - description: Calao Systems Snowball
+        items:
+          - const: calaosystems,snowball-a9500
+          - const: st-ericsson,u9500
diff --git a/MAINTAINERS b/MAINTAINERS
index e4f170d8bc29..a2fcbfca90de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2020,6 +2020,7 @@ F:	drivers/rtc/rtc-pl031.c
 F:	drivers/watchdog/coh901327_wdt.c
 F:	Documentation/devicetree/bindings/arm/ste-*
 F:	Documentation/devicetree/bindings/arm/ux500/
+F:	Documentation/devicetree/bindings/arm/ux500.yaml
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 
 ARM/NUVOTON NPCM ARCHITECTURE
-- 
2.24.0

