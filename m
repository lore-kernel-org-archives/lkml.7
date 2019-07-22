Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CC3C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4915A218BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="RTqMFU9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfGVR4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:56:00 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43996 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbfGVR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563818157; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=dEazR+iu67LfkQOHtlmTPDOasaLnD+dV8gvSosW/A0E=;
        b=RTqMFU9vAEtHLKvPaM/+dEN07LHrhds/18V670+vLxfJ8PXq91+cHwLOP1yA9o/LvWBvuR
        9u8egaKtdbUQGCkutV+44b0OdVPcQni/p1P+LTlEAqz8pfTv9w5MsvCqA+XjyS79v+ZHFo
        xQtSxH1zX3NZD20qmQQWQAJDRQe8ZLs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt/bindings: mips: Document Ingenic SoCs binding
Date:   Mon, 22 Jul 2019 13:55:47 -0400
Message-Id: <20190722175548.18434-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the available properties for the root node and the cpu nodes of
the devicetree for the Ingenic SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/mips/ingenic-socs.txt      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/ingenic-socs.txt

diff --git a/Documentation/devicetree/bindings/mips/ingenic-socs.txt b/Documentation/devicetree/bindings/mips/ingenic-socs.txt
new file mode 100644
index 000000000000..fea2e6ec10a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/ingenic-socs.txt
@@ -0,0 +1,14 @@
+Bindings for Ingenic JZ47xx family of SoCs
+
+Required properties for root node:
+- compatible: One of:
+  * ingenic,jz4740
+  * ingenic,jz4725b
+  * ingenic,jz4770
+  * ingenic,jz4780
+
+Required properties for CPU nodes:
+- compatible: One of:
+  * ingenic,xburst-d0
+  * ingenic,xburst-d1
+  * ingenic,xburst-e1
-- 
2.21.0.593.g511ec345e18

