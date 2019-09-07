Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE660C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91D921907
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567848049;
	bh=FKDNpqBcuyt8PrcvNXXOdfOUsrAaU52nYkpwBFFp2hw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n5D+dHwa+iUlMGIqZPPvcCniYUeckqXR7SIacxYi/FB8okJvw0K+//RIX1LS1edlx
	 zeO5i0IlvtYu+leBIQ3L90px3Th0aS8J8glAi4i317D7NlYRHeAtIkUkmy2Y+ZcWqt
	 WJFeqbHw+GyV4PJ2MZ3JCieaVEnKnvOLLGcJprgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406625AbfIGJUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 05:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406600AbfIGJUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 05:20:45 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB5A218AE;
        Sat,  7 Sep 2019 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567848044;
        bh=FKDNpqBcuyt8PrcvNXXOdfOUsrAaU52nYkpwBFFp2hw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jLsyVOCxyNfQThyEvBYXsqSUPxMD2FyRgLjXnwq+p9yFu/1cdHOQ1HGwWnI+rhA1S
         adTYpVVTsi2hhc2qCOqfmjCjBs343Y4p0/6mN+3/IMCQNhdmucZSY+cjcZvsH4tKmQ
         WMzI1vSGd4cDGBjz+ULrfv1+hY8AH/H0p/b4rhos=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH v2 05/11] dt-bindings: arm: samsung: Document missing Exynos7 boards bindings
Date:   Sat,  7 Sep 2019 11:20:01 +0200
Message-Id: <20190907092007.9946-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190907092007.9946-1-krzk@kernel.org>
References: <20190907092007.9946-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation of ARMv8 Samsung Exynos7 SoC based boards
bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 98401a6db2a0..63acd57c4799 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -171,5 +171,11 @@ properties:
               - samsung,tm2e                    # Samsung TM2E
           - const: samsung,exynos5433
 
+      - description: Exynos7 based boards
+        items:
+          - enum:
+              - samsung,exynos7-espresso        # Samsung Exynos7 Espresso
+          - const: samsung,exynos7
+
 required:
   - compatible
-- 
2.17.1

