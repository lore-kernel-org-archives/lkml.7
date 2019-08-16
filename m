Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0794C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C443021743
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="ivFNdZWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfHPGz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:55:27 -0400
Received: from letterbox.kde.org ([46.43.1.242]:53676 "EHLO letterbox.kde.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPGz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:55:27 -0400
Received: from archbox.localdomain (unknown [123.201.155.129])
        (Authenticated sender: bshah)
        by letterbox.kde.org (Postfix) with ESMTPSA id EF95728AB08;
        Fri, 16 Aug 2019 07:47:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
        t=1565938061; bh=+KZNkFmTsqn+l4u0Fc+nIo6LZ5lfXPcfahH2Jdhx5FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivFNdZWovpDuJwjgy3lvrhtJwogU7xZ7Khokimt/BJ34wMRZDIqKPg4UPzySyjysd
         tBLwqPnJII0n6SRoFKN3wTQkIvRW/3qcVns7pZh0x5D3DGyY3zxc5nFSpvXzkJQjRn
         fpZ7Dnnj7iTBqpuL7ArunIiRWEM6YPFKS2bHiO4HE4z5ygndwJp4nUq90kRtU4iGTi
         mhdDSmRXEo+GFwVF/pGF7PqDtfKyXRxbgC75ngV47hfKJX4P6xFMdsHR9R5w88MX9B
         6TMjH1+7N1laHg/oapxqzmPB0qxXG5FISSecSiLmu2DCd7Lnny6yvt2NfFVbAAg7/N
         eTNhMT7DkFsVg==
From:   Bhushan Shah <bshah@kde.org>
To:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Wolfram Sang <wsa@the-dreams.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Bhushan Shah <bshah@kde.org>
Subject: [PATCH v2 1/3] dt-bindings: i2c: mv64xxx: Add compatible for the H6 i2c node.
Date:   Fri, 16 Aug 2019 12:17:08 +0530
Message-Id: <20190816064710.18280-2-bshah@kde.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816064710.18280-1-bshah@kde.org>
References: <20190811090503.32396-1-bshah@kde.org>
 <20190816064710.18280-1-bshah@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 have a mv64xxx i2c interface available to be used.

Signed-off-by: Bhushan Shah <bshah@kde.org>
---
 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
index 001f2b7abad0..c779000515d6 100644
--- a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
@@ -26,6 +26,9 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2c
           - const: allwinner,sun6i-a31-i2c
+      - items:
+          - const: allwinner,sun50i-h6-i2c
+          - const: allwinner,sun6i-a31-i2c
 
       - const: marvell,mv64xxx-i2c
       - const: marvell,mv78230-i2c
-- 
2.17.1

