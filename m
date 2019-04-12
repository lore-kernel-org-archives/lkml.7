Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B8C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798A02082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="KWTTdQla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfDLMHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:07:39 -0400
Received: from vps.xff.cz ([195.181.215.36]:36282 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLMHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555070852; bh=ZePg86QLSHLd6l6zE255/BrqStNwQhYuYFE5kZyPWpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWTTdQla6yIDgI0bvXcCtZnsQhxGLAhQnbgDV4cKphLAN1ikSgXop98KquKcLpXYj
         EsjOlQgToZCKJOatKYC6otFvT3kS6qIQMr6yDAxkjutRiceuwP5UoEYEoRCN7Ac3z7
         26vKwsCwlzbBh3ARCdeuwZBAXwUixlzTdLpD8ejg=
From:   megous@megous.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 1/3] dt-bindings: Add compatible for H6 RTC
Date:   Fri, 12 Apr 2019 14:07:28 +0200
Message-Id: <20190412120730.473-2-megous@megous.com>
In-Reply-To: <20190412120730.473-1-megous@megous.com>
References: <20190412120730.473-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

RTC on H6 is similar to the one on H5 SoC, but incompatible in small
details. See the driver for description of differences. For example
H6 RTC needs to enable the external low speed oscillator. Add new
compatible for this RTC.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index 6b732c41392b..291505b84e7b 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -11,6 +11,7 @@ Required properties:
 		    - "allwinner,sun8i-v3-rtc"
 		    - "allwinner,sun50i-a64-rtc", "allwinner,sun8i-h3-rtc"
 		    - "allwinner,sun50i-h5-rtc"
+		    - "allwinner,sun50i-h6-rtc"
 
 		  Where there are two or more compatible strings, this
 		  denotes the hardware covered by the most specific one
-- 
2.21.0

