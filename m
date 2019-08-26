Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276DDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AD020874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbfHZPkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:40:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52791 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbfHZPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so15928413wmh.2;
        Mon, 26 Aug 2019 08:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMmbpncOJ0ZaEaTp6uD1F3mJKzNvU9i5QAcT7nrh4JY=;
        b=NtvH4toT+W7NXi5ABjtATrF5W685ALg4xltWgScToNc4u6D020xDuK2Db7Cj6hnk3n
         /bAFcf+MWY/9tlA2M+g/Ne8virVOhRfv+qKGakE/K6olC4e1wz74yf3B69r40nvMOGWj
         VlPNEA66BT8+TZH6nwIYozAhhcVfp6Vw+ouS2TZIPeKtRXHD/VX/Jk45SaqT+Ie5AuAf
         IRmsh1ibRyO6jJl2XzmJHSYm/oDfR6bZWL9Q0A8pbTX9DbHRWo1DZWC9u4MMpm05I+fm
         df1PEtaBpSHrchQ2zNk3JaniGEjrajVtUNaFZrsBydsZRYcoWT1G33XAzL0sxO9oLefm
         alcA==
X-Gm-Message-State: APjAAAUsame9kHgc7uwDG7+Z35RnRZd+rJrf1WTaP4vO37E68QArSZ+4
        YR1c7J9fOFuBhe5ePpknP2HxCBRu9bw=
X-Google-Smtp-Source: APXvYqzGJnbPj/aQN9vpELl8apyFyQZE5AG9D4gn7qkUgkt0R4z3A8KozlSMpWB1/cHyMGbBxQxjWQ==
X-Received: by 2002:a1c:1b42:: with SMTP id b63mr22828360wmb.46.1566833930681;
        Mon, 26 Aug 2019 08:38:50 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:50 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/12] ARM: dts: imx7d: cl-som-imx7: update UART1 (debug) clock
Date:   Mon, 26 Aug 2019 16:37:56 +0100
Message-Id: <20190826153800.35400-8-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assign OSC as uart1 (debug) clock to achieve low power,
so that the PLL doesn't need to be kept on

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index d4637a8ca223..f80be855b4ec 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -222,7 +222,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
 	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
-	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
 	status = "okay";
 };
 
-- 
2.23.0.rc1

