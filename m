Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4873C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E7124685
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781048;
	bh=vKGtRTAO9OrO2yKIbWWQ9WkANzVXLGsOgVLPAQ7WQCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lW24OLdnUvsRUH8ET1o+YxmzsfelBxIuYwjV/rvb5XC9miegdBBhm6lGApZ5SpU2b
	 u5fZlrwqRnVd4GI7XB1bbf5XFRpZXzhnT9sBOSjaooaLyMwzDZACfBEmwjbH9//HvA
	 Y8pl9cEuvcl0sJU5PXemD4XGSbr8eyNcYQk4ggVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfLSSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:44:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfLSSoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:44:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5575C24679;
        Thu, 19 Dec 2019 18:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781043;
        bh=vKGtRTAO9OrO2yKIbWWQ9WkANzVXLGsOgVLPAQ7WQCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXeETxqkuucWvHixDOEmUD/rBU9n2TUwkESdlR8EFUfj9l2flJ4KOdksOsfpwW9sZ
         LhStwhTYuY8tPuy6gHphZNMwWUw27oaNyZ+AgWHcm+RrgQqDnw/AOWNg8ve5jqhFVY
         3hhloBQSLooEDC2/gDu+sxfFfNr2crOhWjIvE9GM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Sergey Yanovich <ynvich@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 059/199] ARM: dts: pxa: clean up USB controller nodes
Date:   Thu, 19 Dec 2019 19:32:21 +0100
Message-Id: <20191219183218.257793815@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit c40ad24254f1dbd54f2df5f5f524130dc1862122 ]

PXA25xx SoCs don't have a USB controller, so drop the node from the
common pxa2xx.dtsi base file. Both pxa27x and pxa3xx have a dedicated
node already anyway.

While at it, unify the names for the nodes across all pxa platforms.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Reported-by: Sergey Yanovich <ynvich@gmail.com>
Link: https://patchwork.kernel.org/patch/8375421/
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/pxa27x.dtsi | 2 +-
 arch/arm/boot/dts/pxa2xx.dtsi | 7 -------
 arch/arm/boot/dts/pxa3xx.dtsi | 2 +-
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 0e1320afa1562..d629948000db1 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -34,7 +34,7 @@
 			clocks = <&clks CLK_NONE>;
 		};
 
-		pxa27x_ohci: usb@4c000000 {
+		usb0: usb@4c000000 {
 			compatible = "marvell,pxa-ohci";
 			reg = <0x4c000000 0x10000>;
 			interrupts = <3>;
diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 3ff077ca44002..5a6f4ed92dac3 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -117,13 +117,6 @@
 			status = "disabled";
 		};
 
-		usb0: ohci@4c000000 {
-			compatible = "marvell,pxa-ohci";
-			reg = <0x4c000000 0x10000>;
-			interrupts = <3>;
-			status = "disabled";
-		};
-
 		mmc0: mmc@41100000 {
 			compatible = "marvell,pxa-mmc";
 			reg = <0x41100000 0x1000>;
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 9d6f3aacedb70..4aee150626902 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -187,7 +187,7 @@
 			status = "disabled";
 		};
 
-		pxa3xx_ohci: usb@4c000000 {
+		usb0: usb@4c000000 {
 			compatible = "marvell,pxa-ohci";
 			reg = <0x4c000000 0x10000>;
 			interrupts = <3>;
-- 
2.20.1



