Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8C3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C6B20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441667;
	bh=O582+0uusHpuUSZbSuZDi+SoMqjy1U5xSgrq+3E3hFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YpwwkF6AMM9rfXk6ty1fGxFXB+4oQzbZbNVUnw41jfs93CZ/cvZFie/Ro88HfU5w4
	 fOOlLCALjLioT3KD6CKvCUp7Oy+dSuJShlljh/1z0A7Z/ZoSq2nUVSWFuKlJZb7ufa
	 LP23DXrVNoHTdwsinPKN4cjV/Wv3YEDmKY6yVE/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390754AbfFMQBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731448AbfFMIso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:48:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8D4206BA;
        Thu, 13 Jun 2019 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415723;
        bh=O582+0uusHpuUSZbSuZDi+SoMqjy1U5xSgrq+3E3hFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xakMSmynr2FfkbHg0aKQSueRlgqLc4BdzwhdxSoOPagyHgDkP35+O+lcH6ZHgdS7T
         xgAhcCh5uscb4dmktZSkzPkiA8zYp0euDQHgRUSqv873oocxmKZhMbM6MBq8EBuwQa
         Vtotjb0en6vBc1ria2OY3hRnMhur4OH6VFVcridI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 104/155] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
Date:   Thu, 13 Jun 2019 10:33:36 +0200
Message-Id: <20190613075658.841957419@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit beea0f22566cb32c35de89ab0980852b5bbc1c60 ]

Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
to allow i.MX6 PCIe driver to use it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9155bd4784eb..aa051af23bd0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -240,7 +240,7 @@
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.20.1



