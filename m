Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F6C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BC62075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="c4bPts9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLWQgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:36:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42400 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLWQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:35:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so17161614wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vPjEapO472fGuu6r9pn0273O+OdDnQWnbnL006wm7qI=;
        b=c4bPts9eLzdSmLo8BPbi0cJwCBXFHpIAtBqzxEAzbIiHuhGOfq8pm31YtE7QqLFBrW
         8faufW2tXVBPL25RSY0u3DuCoNIlwn8qYOKtqWjBwHgCiYP1SqUT1GtprP9tGYSn2Xhn
         /MyN47Ci5ZqaG2brFAwNpYSgczdSca6+xMeHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vPjEapO472fGuu6r9pn0273O+OdDnQWnbnL006wm7qI=;
        b=RqZDUiDzDQkaj1XWs6hO1CP9ylzbin6CuuJQX9g33eT6Ec0+gbq4uSE9G6b2/LXr9t
         ty2PtrbvQCjP/HNzuAmm6WpDP0767C7Gy1VvMDzjy2qCfsYreDxwgMRAuTogJbrUM/XZ
         auSPGUSKRG0V3pldO4D1l3DodrWbPn8i19/zl4xcLDVW19vIBTmvybA3Ng4yfsISa2AE
         qGsIU9O6nTNfx2zBHFKlTO8AKVsa0B7xQXk0yQw3C5HW6PPbRO/hzTWaNzhsyeSxCFZo
         XJiBuyNdw+Opmt/gqIuPszffcV3XFDW9AaMEvHtG4YmwgVLpjcgNRmKhofnzyk9zYiWM
         BQLA==
X-Gm-Message-State: APjAAAUhyqpYs6GteLjvfwJhPeMFqb6pOPfrmeFK+3DubuIUzohFpY1r
        /RjQ0t73Z4a5tkkESB8xyA+9Ypld4Bk=
X-Google-Smtp-Source: APXvYqwJjBQTL188ZZ/AP5tk5sNzzz79GHtu2hX6GCuvFT5Bhap94m3m5SMQCn6JD2CoQYJXssTz2Q==
X-Received: by 2002:a05:6000:1052:: with SMTP id c18mr30899895wrx.268.1577118953089;
        Mon, 23 Dec 2019 08:35:53 -0800 (PST)
Received: from localhost.localdomain ([37.160.152.81])
        by smtp.gmail.com with ESMTPSA id s8sm20412498wrt.57.2019.12.23.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 08:35:52 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: imx6dl: Remove duplication in Engicam i.CoreM6 1.5 Quad/Dual MIPI
Date:   Mon, 23 Dec 2019 17:35:45 +0100
Message-Id: <20191223163546.29637-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223163546.29637-1-michael@amarulasolutions.com>
References: <20191223163546.29637-1-michael@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid to re-define the reset gpio for ethernet multiple time. The
imx6qdl-icore-1.5.dtsi include imx6qdl-icore.dtsi that already
define the reset method

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
index d91d46b5898f..0fd7f2e24d9c 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
@@ -25,10 +25,8 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clks IMX6QDL_CLK_ENET>,
 		 <&clks IMX6QDL_CLK_ENET>,
 		 <&clks IMX6QDL_CLK_ENET_REF>;
-	phy-mode = "rmii";
 	status = "okay";
 };
-- 
2.17.1

