Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E2C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623EA24249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="D380ACd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfLEQIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:08:11 -0500
Received: from gateway30.websitewelcome.com ([50.116.127.1]:17440 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730020AbfLEQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:08:08 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 3FCC1B225
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 09:45:20 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id ctJgiILiH3Qi0ctJgiXL6S; Thu, 05 Dec 2019 09:45:20 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=faNX9C9K+X/+IvNp0Q5Wq0vZzNGNC8bDF+b+08Xm8wA=; b=D380ACd5gmryPszwzDQhqDCa9B
        3pBH1IoPYC4vx+qnyJb0Xz8siwpmZq8PP3rN4d355eUOCiNsnXKeOjkEROTiSXvvhv2TuDRMSQr3A
        5481ouXy3UnDZ+WVen9AAQejhJZFanQhdvIAWRWPqnMtZf1rDFUFXfW3yAx6e+ucCo7vyPrKE87XT
        ZuOxaxUh1Lx5dk+tVtXBTDgXYDlPCa7m5dxEvaM8SnbtT0dmg6DfzExo4nYfZqXtMpi2swuhFKA/m
        udEpDy0MWyWAuBdvwcL729KAQGOvbDQboDhXos70703BEOj+HqgbY7PtyadZsIS8aaByPb1ecBaTy
        h1p8Ntsw==;
Received: from [191.31.196.215] (port=35544 helo=castello.bz.toradex.local)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1ictJf-001jEH-91; Thu, 05 Dec 2019 12:45:19 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 3/5] devicetree: mfd: max14577: Add reference to max14040_battery.txt descriptions
Date:   Thu,  5 Dec 2019 12:44:08 -0300
Message-Id: <20191205154410.29462-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191205154410.29462-1-matheus@castello.eng.br>
References: <20191205154410.29462-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.215
X-Source-L: No
X-Exim-ID: 1ictJf-001jEH-91
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.bz.toradex.local) [191.31.196.215]:35544
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 36
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max77836 MFD has a fuel gauge that has a low SOC alert feature that is
described in Documentation/devicetree/bindings/power/supply/max17040_battery.txt.
Adding the reference to de documentation here.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/max14577.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
index fc6f0f4e8beb..45c7f414aee0 100644
--- a/Documentation/devicetree/bindings/mfd/max14577.txt
+++ b/Documentation/devicetree/bindings/mfd/max14577.txt
@@ -5,6 +5,8 @@ Battery Charger and SFOUT LDO output for powering USB devices. It is
 interfaced to host controller using I2C.

 MAX77836 additionally contains PMIC (with two LDO regulators) and Fuel Gauge.
+For the description of Fuel Gauge low SOC alert interrupt see:
+power/supply/max17040_battery.txt


 Required properties:
--
2.24.0.rc2

