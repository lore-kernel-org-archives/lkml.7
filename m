Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F7BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D0B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="outW/Xh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfEUPeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:34:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53008 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfEUPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1558452869; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=KwEbE7zfggw/A9F2ZY+sYHeKejLXDsS/3Ae2CZCOs/Q=;
        b=outW/Xh/qhacDMNpTl8s1t5YpMliZaebIX2KRirgb1CTnsjTmPi2OuxFg2Y1RwcPZqYv2J
        kgQyBfw1OcKNBZm/eCUbvpro+SWfMDgSQLSF2mcFJOmwPQ32Usd9/gQjkycOR0KsTaTIbX
        f6Rao7LoQZIMkJNPbIo96PDBQ+MNvdw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/5] dt-bindings: Remove unused compatible strings
Date:   Tue, 21 May 2019 17:34:11 +0200
Message-Id: <20190521153415.14703-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now none of the Ingenic-based boards probe this driver from
devicetree. This driver defined three compatible strings for the exact
same behaviour. Before these strings are used, we can remove two of
them.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
index 7d9d3f90641b..493bec80d59b 100644
--- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
@@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
 =============================
 
 Required properties:
-- compatible: One of:
-  * "ingenic,jz4740-pwm"
-  * "ingenic,jz4770-pwm"
-  * "ingenic,jz4780-pwm"
+- compatible: Should be "ingenic,jz4740-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description
   of the cells format.
 - clocks : phandle to the external clock.
-- 
2.21.0.593.g511ec345e18

