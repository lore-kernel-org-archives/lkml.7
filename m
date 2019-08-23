Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6ECC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0311723427
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="L06V5E+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405291AbfHWKcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:32:18 -0400
Received: from vps.xff.cz ([195.181.215.36]:52632 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390545AbfHWKbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1566556306; bh=m2aKtRbkPTkJVuTP8zfANK/QWGiSc2Jdal4+JCozxGg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=L06V5E+mkypAmZdneB6hYyjjUgHu1laLiD9Wh+yKZ0GS6HqU85zz3VnR2U5Yqh8Cs
         wQLUPAQ/M5iElTZD+whjM+wQATeeHAFO7fXvdYhIHPm6F8VcsCcB0Upvp7zNkXFcqX
         fDbww4+L2ojZKXMHD7vkME/9BukKozBvzSOCNKMk=
From:   megous@megous.com
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>
Subject: [RESEND PATCH 1/5] dt-bindings: net: Add compatible for BCM4345C5 bluetooth device
Date:   Fri, 23 Aug 2019 12:31:35 +0200
Message-Id: <20190823103139.17687-2-megous@megous.com>
In-Reply-To: <20190823103139.17687-1-megous@megous.com>
References: <20190823103139.17687-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This is present in the AP6526 WiFi/Bluetooth 5.0 module.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index c26f4e11037c..4fa00e2eafcf 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -13,6 +13,7 @@ Required properties:
    * "brcm,bcm20702a1"
    * "brcm,bcm4330-bt"
    * "brcm,bcm43438-bt"
+   * "brcm,bcm4345c5"
 
 Optional properties:
 
-- 
2.23.0

