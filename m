Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2609C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B62064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414681;
	bh=GQ1aUDkQgXt07bmBHvux87SSVhWhT1XezXNKdJSQGFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1iqTTWNrIIYgEuVpZ3+bInyiso2HAZlvcs15KOE90Q6krW2IqjLdWsqgIycZMgk9q
	 EG1AgnZWP6J6JcTbJIEgcy6aGkZjd+5SdOJSkhOrosUeBhlSUDnPft7aA1OtAdt7H6
	 6uIOzO01zRk5RPd96MWFepGNYKiaQTxPsVMbP40U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfLCWlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfLCWlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2909E2080A;
        Tue,  3 Dec 2019 22:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412867;
        bh=GQ1aUDkQgXt07bmBHvux87SSVhWhT1XezXNKdJSQGFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouzHQX7BKhut4hEjCZy1FA3kPZEyuaDxY/+6RJZwdJf3dJUWkrmLydZK/OZuMWSu6
         LoXPL8S2V74F/NjvB4PLg7LnO5i5a9rAGksTyJol8hpoJXucCrwt4cFD76Wz4b5iG1
         DpHwXdomZB97g7y8bChfNheI6cJephdWgkwMRDmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 040/135] arm64: dts: zii-ultra: fix ARM regulator GPIO handle
Date:   Tue,  3 Dec 2019 23:34:40 +0100
Message-Id: <20191203213014.496405796@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit f852497c9a07ec9913bb3f3db5f096a8e2ab7e03 ]

The GPIO handle is referencing the wrong GPIO, so the voltage did not
actually change as intended. The pinmux is already correct, so just
correct the GPIO number.

Fixes: 4a13b3bec3b4 (arm64: dts: imx: add Zii Ultra board support)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 3faa652fdf20d..c25be32ba37e4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -100,7 +100,7 @@
 		regulator-name = "0V9_ARM";
 		regulator-min-microvolt = <900000>;
 		regulator-max-microvolt = <1000000>;
-		gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 		states = <1000000 0x1
 		           900000 0x0>;
 		regulator-always-on;
-- 
2.20.1



