Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF859C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF162075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="gRH4vPr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfC0A1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:27:35 -0400
Received: from vps.xff.cz ([195.181.215.36]:53774 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfC0A1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553645936; bh=UzU+qsNACtfxcYu/73bvogl1+uKb4UDhIEXNrk+9P9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRH4vPr/SU/IcJ6p/gDJrwcDsUfdZW9C8p9BARKASolUnGWiefwuJBu3wxpKnaBov
         Gibb7/R02rM5KnhcBd5BCv6QZM/w5/akd3TEDua8cQn7kd/s0FXPeRJRNs8bBAVH7A
         eIVbfxfwHynecSb8Mj1H0LnuQi139D8FsY+xlM8Q=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 6/7] dt-bindings: gnss: Add u-blox,neo-6m compatible
Date:   Wed, 27 Mar 2019 01:18:42 +0100
Message-Id: <20190327001843.2420-7-megous@megous.com>
In-Reply-To: <20190327001843.2420-1-megous@megous.com>
References: <20190327001843.2420-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Add compatible for u-blox NEO-6M GPS module.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/gnss/u-blox.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
index e475659cb85f..7cdefd058fe0 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox.txt
+++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
@@ -9,6 +9,7 @@ Required properties:
 
 - compatible	: Must be one of
 
+			"u-blox,neo-6m"
 			"u-blox,neo-8"
 			"u-blox,neo-m8"
 
-- 
2.21.0

