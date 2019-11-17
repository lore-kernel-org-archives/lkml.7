Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544A9C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F1F206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="ltguKLde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKQPBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 10:01:45 -0500
Received: from gateway20.websitewelcome.com ([192.185.69.18]:49752 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfKQPBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 10:01:44 -0500
X-Greylist: delayed 1452 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 10:01:43 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 02D04400C74C1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 07:05:55 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id WLKSiP26RqNtvWLKSiCs8S; Sun, 17 Nov 2019 08:15:04 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=faNX9C9K+X/+IvNp0Q5Wq0vZzNGNC8bDF+b+08Xm8wA=; b=ltguKLde4Z3uadEKfjd+O+3kDi
        SEsZanYWYz4Mv7GqrzMQQIP4fClsNU2y52k/GghZ6J+DDrbfT+DeP2PTJg/3TISQoa5NNzCSEil3v
        rK8tW6QtsFdxHWvV81+FtSkAOT+BfyNMNCZ+Gisp2VsQHPk0/pYdakI2Z8xr60GFfMepDk2nVueUb
        BTypFw9caZTpRwqsCHHbz7Dl7UUzNCMNtrLriWZQmTMiaFL+BjDFjMIikm0ikZ3arIHEZUYcLd3b2
        +I5F9VXuV9fxvaatg/zdc061xjnot8RL8Y1U1+Z08H74jdSFaFkzhPXLkTPw4b4T1s6Ntdjs5Ez+Q
        +/grtFjA==;
Received: from [186.222.229.111] (port=47408 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iWLKP-001Ad4-Vk; Sun, 17 Nov 2019 11:15:03 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 3/5] devicetree: mfd: max14577: Add reference to max14040_battery.txt descriptions
Date:   Sun, 17 Nov 2019 11:13:33 -0300
Message-Id: <20191117141335.23404-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191117141335.23404-1-matheus@castello.eng.br>
References: <20191117141335.23404-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 186.222.229.111
X-Source-L: No
X-Exim-ID: 1iWLKP-001Ad4-Vk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [186.222.229.111]:47408
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

