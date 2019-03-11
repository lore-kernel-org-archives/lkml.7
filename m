Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7957EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4744F214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="t+opiwYX";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="t+opiwYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCKXrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:47:09 -0400
Received: from node.akkea.ca ([192.155.83.177]:39798 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfCKXrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:47:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id E396F4E204D;
        Mon, 11 Mar 2019 23:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552348027; bh=srsvZVp+c552T3kQqDRjifVUlSmZxGIfneH0iQtox7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=t+opiwYXiKL5OZadx2f3yPCcfMFknC09RYIRs/bwAFLW7+q+LdlYmaVXdVy5thQmt
         21g1DY3INgvygsvXdhEjI9nAyQpLY6Rph8wZvSzK6+RVPzA4LVaCwE3S9v8WbsuEeK
         8IykoaS6fu4oYsHEcP23+qVsALYY3q7cmEXx8CJA=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dm7wup46eFQA; Mon, 11 Mar 2019 23:47:07 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 0B53D4E204B;
        Mon, 11 Mar 2019 23:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552348027; bh=srsvZVp+c552T3kQqDRjifVUlSmZxGIfneH0iQtox7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=t+opiwYXiKL5OZadx2f3yPCcfMFknC09RYIRs/bwAFLW7+q+LdlYmaVXdVy5thQmt
         21g1DY3INgvygsvXdhEjI9nAyQpLY6Rph8wZvSzK6+RVPzA4LVaCwE3S9v8WbsuEeK
         8IykoaS6fu4oYsHEcP23+qVsALYY3q7cmEXx8CJA=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        Lucas Stach <l.stach@pengutronix.de>, abel.vesa@nxp.com,
        daniel.baluta@nxp.com, agx@sigxcpu.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 2/3] arm64: dts: fsl: Build the Librem5 devkit devicetree
Date:   Mon, 11 Mar 2019 16:46:54 -0700
Message-Id: <20190311234655.30357-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311234655.30357-1-angus@akkea.ca>
References: <20190311234655.30357-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile the Librem5 devkit device tree

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 13604e558dc1..95526ee3c27a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -22,3 +22,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
-- 
2.17.1

