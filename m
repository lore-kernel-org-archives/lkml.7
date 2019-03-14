Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B76C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F8A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="v8necy23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCNM0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:26:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56900 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfCNM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552566387; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=ZLqGHu1N7JWPKa258oaHXK+qM8hcy6vAmdg0sPuWsyg=;
        b=v8necy23x1smubWvhzt0AvCmtdDOq4858rRGcm8VY8+vPIv+lt2qXCCFaOg/ZjyehLfwYb
        sBpohXsqBMb+oV7GExkcZk4JnmnwQ4dlqojj2X/H6S/5KuJU0cPzupYCHxMqwW9kk3SBeF
        mgubVgOZAZPwIoLK4dfEsnZFBsAsqlA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/5] dt-bindings: display: Add Sharp LS020B1DD01D panel documentation
Date:   Thu, 14 Mar 2019 13:26:18 +0100
Message-Id: <20190314122622.7597-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS020B1DD01D is a 2.0" 240x160 16-bit TFT LCD panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 .../devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt b/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
new file mode 100644
index 000000000000..e45edbc565a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
@@ -0,0 +1,12 @@
+Sharp 2.0" (240x160 pixels) 16-bit TFT LCD panel
+
+Required properties:
+- compatible: should be "sharp,ls020b1dd01d"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.11.0

