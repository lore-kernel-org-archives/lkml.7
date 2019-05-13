Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92A6C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A105720879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="IukaJtGQ";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="IukaJtGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfEMRlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:41:06 -0400
Received: from node.akkea.ca ([192.155.83.177]:42374 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbfEMRlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:41:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id ECAAE4E2051;
        Mon, 13 May 2019 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557769264; bh=5WGZvgnOgbtI9aZLQxQtQRD9C4sXKS1AVhuBgV7LlJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IukaJtGQq4ORbIubREdBi87lC0hoYGJMMfsyXVz7U6f8ErteTShZ5qPmI3itBli6T
         W60sUbIBoAKfUGwodIhAFlKzfFxD4cSO0SgB8qHwt9eF+PSmOXtRkhEVzNjGDUfu+I
         0nPueV6KpFei3X4sLI+4zTi+nQ/WmQ2W6yjnBL4I=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wgDf5xvIsCj0; Mon, 13 May 2019 17:41:04 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 1CC9D4E204D;
        Mon, 13 May 2019 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557769264; bh=5WGZvgnOgbtI9aZLQxQtQRD9C4sXKS1AVhuBgV7LlJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IukaJtGQq4ORbIubREdBi87lC0hoYGJMMfsyXVz7U6f8ErteTShZ5qPmI3itBli6T
         W60sUbIBoAKfUGwodIhAFlKzfFxD4cSO0SgB8qHwt9eF+PSmOXtRkhEVzNjGDUfu+I
         0nPueV6KpFei3X4sLI+4zTi+nQ/WmQ2W6yjnBL4I=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v10 1/4] MAINTAINERS: add an entry for for arm64 imx devicetrees
Date:   Mon, 13 May 2019 10:40:54 -0700
Message-Id: <20190513174057.4410-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513174057.4410-1-angus@akkea.ca>
References: <20190513174057.4410-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explicit reference to imx* devicetrees

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7707c28628b9..0871a21a5bbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1648,6 +1648,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
 F:	arch/arm/boot/dts/ls1021a*
 F:	arch/arm64/boot/dts/freescale/fsl-*
 F:	arch/arm64/boot/dts/freescale/qoriq-*
+F:	arch/arm64/boot/dts/freescale/imx*
 
 ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
2.17.1

