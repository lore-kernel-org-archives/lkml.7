Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CFE206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="JM+1QK0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfDAL4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:56:41 -0400
Received: from vps.xff.cz ([195.181.215.36]:57752 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfDAL4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554119780; bh=h7WWXjDTQhcdYdV4DjZ7htty8GUP8qIjlco+q4zG0wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JM+1QK0BZKbhUQGq+fEMWGoQvL1fEsMfB0cBqFkcgXm1pKm0lT6q3N8t5xA6VWeFG
         1idMBBGW8qf2x+fcpyr6+NFYTDPj+znJOVXsL2hXQ8IuxrJLnnX6y/CJCwiMw2Q/H+
         +deg+MINfR/KidlMBRzjiNHnifgTFXjMV5QjvhKw=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 2/5] ARM: dts: sun8i: a83t: Add UART2 PB pins
Date:   Mon,  1 Apr 2019 13:56:13 +0200
Message-Id: <20190401115616.21337-3-megous@megous.com>
In-Reply-To: <20190401115616.21337-1-megous@megous.com>
References: <20190401115616.21337-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Add pin definitions for UART2 PB pins. These are used on TBS-A711
tablet.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index fcb7ef5ce2df..0176049d9815 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -768,6 +768,12 @@
 				pins = "PG8", "PG9";
 				function = "uart1";
 			};
+
+			/omit-if-no-ref/
+			uart2_pb_pins: uart2-pb-pins {
+				pins = "PB0", "PB1";
+				function = "uart2";
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.21.0

