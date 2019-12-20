Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFAE24684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="U9XjgjFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTMZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:25:12 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:48404 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfLTMY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hNBxo3WruCWru8MJuOpnvDdHkmmTti3FR1KFZs6vrOo=; b=U9XjgjFgP1hWnMV4YVzrSk2Q1
        6d3R1PK0KRSJc4eRQyY6sGDWPadyagSOFlh6V4f41GSjCUQZWZzFxkznsbY2mkXcNT4d1tKlHYrRf
        DUGwbm0B+z9TxbBQky5eX5osALGzw2actE4iGkWz+hk71srcstUGzwgnMVp8BYJfEp5XY=;
Received: from [2a02:790:ff:1019:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iiHKp-0001zM-Bk; Fri, 20 Dec 2019 13:24:47 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iiHKl-0008Td-CJ; Fri, 20 Dec 2019 13:24:43 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5 1/5] dt-bindings: mfd: rn5t618: Document optional property interrupts
Date:   Fri, 20 Dec 2019 13:24:12 +0100
Message-Id: <20191220122416.31881-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191220122416.31881-1-andreas@kemnade.info>
References: <20191220122416.31881-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These chips use interrupts for various things like RTC alarm.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v4: add refernce to interrupt binding
documentation
 Documentation/devicetree/bindings/mfd/rn5t618.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
index b74e5e94d1cb..16778ea00dbc 100644
--- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
+++ b/Documentation/devicetree/bindings/mfd/rn5t618.txt
@@ -15,6 +15,8 @@ Required properties:
  - reg: the I2C slave address of the device
 
 Optional properties:
+ - interrupts: interrupt mapping for IRQ
+   See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
  - system-power-controller:
    See Documentation/devicetree/bindings/power/power-controller.txt
 
@@ -32,6 +34,8 @@ Example:
 	pmic@32 {
 		compatible = "ricoh,rn5t618";
 		reg = <0x32>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		system-power-controller;
 
 		regulators {
-- 
2.11.0

