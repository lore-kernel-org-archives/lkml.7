Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4185C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED1E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="GXYu8RiI";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="GXYu8RiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfFTRFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:05:47 -0400
Received: from node.akkea.ca ([192.155.83.177]:57056 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfFTRFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:05:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C9FF14E204D;
        Thu, 20 Jun 2019 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1561050346; bh=DbHJKltugQqhptZWGL9LmNE+0Ii6tGA8ooe0jZKVPC4=;
        h=From:To:Cc:Subject:Date;
        b=GXYu8RiIpIiSVdyd5M9kCt1hInVJd8HO7NJkgdbMKVu7anVkmhCmi+BiALLAXOBue
         4XtkZ1y0SqBEOlygGskB5+kAgZa4CtzdDLsx1kJbubiqNvCpVRTcxxwYFPY+LpoLXH
         xEBQ0LtZCzMscgxSwpFhZrxH8SygQXuMrPKzg/ew=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qgvb6qYfPgiY; Thu, 20 Jun 2019 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id AB07A4E204B;
        Thu, 20 Jun 2019 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1561050346; bh=DbHJKltugQqhptZWGL9LmNE+0Ii6tGA8ooe0jZKVPC4=;
        h=From:To:Cc:Subject:Date;
        b=GXYu8RiIpIiSVdyd5M9kCt1hInVJd8HO7NJkgdbMKVu7anVkmhCmi+BiALLAXOBue
         4XtkZ1y0SqBEOlygGskB5+kAgZa4CtzdDLsx1kJbubiqNvCpVRTcxxwYFPY+LpoLXH
         xEBQ0LtZCzMscgxSwpFhZrxH8SygQXuMrPKzg/ew=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: fsl: librem5: enable the SNVS power key
Date:   Thu, 20 Jun 2019 11:05:32 -0600
Message-Id: <20190620170532.18845-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the snvs power key.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 93b3830e5406..e21215b01a62 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -715,6 +715,9 @@
 	status = "okay";
 };
 
+&snvs_pwrkey {
+	status = "okay";
+};
 
 &uart1 { /* console */
 	pinctrl-names = "default";
-- 
2.17.1

