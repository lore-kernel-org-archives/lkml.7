Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B911C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E574D2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UqMTCIjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfLBPlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:41:39 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40698 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLBPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575301295; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=opmmpLOcnRQMoL3meCkpQD25iFtikQvdlBCiDKKS/MY=;
        b=UqMTCIjfs1qWkxgO38KGlB350bsAhvMtLFgbZGKqH9zc2yszSKUuMhm3VGz+6NaUvboeBk
        xbosbDs3jX0AVCKF7cmGbS6+dwdJ5HZjfaEeOTRsC/fUPao/1tocvSaQDCpDmh7tgtx1mK
        jxQLQl+uecjeUJFGmpQBjdvwDYv/upc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Shenzhen Frida LCD Co., Ltd.
Date:   Mon,  2 Dec 2019 16:41:21 +0100
Message-Id: <20191202154123.64139-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Shenzhen Frida LCD Co., Ltd.

v2: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..9c6e1b42435b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -337,6 +337,8 @@ patternProperties:
     description: Firefly
   "^focaltech,.*":
     description: FocalTech Systems Co.,Ltd
+  "^frida,.*":
+    description: Shenzhen Frida LCD Co., Ltd.
   "^friendlyarm,.*":
     description: Guangzhou FriendlyARM Computer Tech Co., Ltd
   "^fsl,.*":
-- 
2.24.0

