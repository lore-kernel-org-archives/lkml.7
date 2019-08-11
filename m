Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD30C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 09:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B647217D4
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 09:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHKJFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 05:05:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38888 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfHKJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 05:05:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id z14so10783708pga.5;
        Sun, 11 Aug 2019 02:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DfWUrSqQwgPvfj5wOOKm7TdPELNExyWS4lWHPaxFdi0=;
        b=g4q31ygIcXH5lZpT9nbUDAitkSqORG0X+XUotkTRBUBNWoOHcv+SOlynEYB5Bn3LhT
         cam0DGHmkiVbmEnMiUMeSn6VwJwswjFdSWj+wt9q/SeWF7Ol/nfYNnLAa1i9xOz8WEkb
         gVrm1vhA9RvWqJT6sHQl0G7DXKnq3m/cGEoft6WIasrxEjxJ1hPyO737DnxC8DAMfSxk
         SSPWtHKWe0SoR1cDg18Oq016quUJqYx/ch2ROP7a98qzFsS9ABa14zdWHmGkjtBofjDh
         3h2Kj6XCgrjKZrBNKSg8/TJmkToI5mILxgwdMUyn8g34VTj4ZCkpABEIuXUsapjhhsBG
         w/sA==
X-Gm-Message-State: APjAAAUhREbGzjndghOSIYKCAJ7qpCHuaxAv3VvmGGXl1+66fhxcxTJv
        PsWe6lbohfy6sL20nBkO8mo=
X-Google-Smtp-Source: APXvYqySWWqv4fBguoluEQVEtCnzmJWQIrOn4zc+LscMyjnZJH79c32tcsOXqXbfufs9etIHIFwKbA==
X-Received: by 2002:aa7:85d6:: with SMTP id z22mr4472397pfn.262.1565514322676;
        Sun, 11 Aug 2019 02:05:22 -0700 (PDT)
Received: from archbox.localdomain ([203.88.145.156])
        by smtp.gmail.com with ESMTPSA id f27sm87287978pgm.60.2019.08.11.02.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Aug 2019 02:05:22 -0700 (PDT)
From:   Bhushan Shah <bshah@kde.org>
To:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhushan Shah <bshah@kde.org>
Subject: [PATCH 2/2] arm64: allwinner: h6: enable i2c0 in PineH64
Date:   Sun, 11 Aug 2019 14:35:03 +0530
Message-Id: <20190811090503.32396-3-bshah@kde.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190811090503.32396-1-bshah@kde.org>
References: <20190811090503.32396-1-bshah@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c0 bus is exposed by PI-2 BUS in the PineH64, model B.

Signed-off-by: Bhushan Shah <bshah@kde.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 684d1daa3081..a184361bc10d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -160,6 +160,14 @@
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
+&i2c0 {
+	status = "okay";
+};
+
+&i2c0_pins {
+	bias-pull-up;
+};
+
 &r_i2c {
 	status = "okay";
 
-- 
2.17.1

