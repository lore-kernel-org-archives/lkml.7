Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278A7C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0602A21848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfHZPi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:38:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52775 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733045AbfHZPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so15928111wmh.2;
        Mon, 26 Aug 2019 08:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4whMVybYrFM/VJAJPt+RDbk4EyD/C4nT92WrUXXMMQ=;
        b=ZDWDgNtaoGKZJN5ZCD3CwmHdeDT3qs2bA3TXB/jgRVJDt5q+75f0nrdxGIogtwwbO+
         wML7v86408gOdV22Ea18QyyLnwosgia+jhQCV8nNFtGA55ubad36HE29Xih6yauRG7OZ
         Z1+ywFKANxvNhbpdLQNSXZ8hZY4NQUtA9EeCJgH6HcX5nXwX6DdHQ7rXjws4BLAmck/5
         EOBp016BJLsQRKofJ+t1p2rm/RTsJYSMfigun92bAPywGtw4mKlFFZtzgRV5PaSRDBwI
         eCxgAzUyoFNjY59HenVknekxPCkwAyZhKXwydfXqfsE8i5gpx88LOLXP6ETqgc4qrGum
         Ltog==
X-Gm-Message-State: APjAAAVbDS/PJ/uNAd5DDGzjuV3Y/lhO1vcUG+b2wsYXv/+pJVhaXC9x
        FtdJQ4u+ppu/MiAYmAAhKtZrPPKpftw=
X-Google-Smtp-Source: APXvYqygTRJ64Z2TySzhfxKxSjAmfAcggoIVmXZ4r3Dc/XwC55KuebNCr5QYo+MM+8TDE2dGCd2iUw==
X-Received: by 2002:a05:600c:40f:: with SMTP id q15mr23039886wmb.88.1566833926763;
        Mon, 26 Aug 2019 08:38:46 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:46 -0700 (PDT)
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
Subject: [PATCH 04/12] ARM: dts: imx7d: cl-som-imx7: add emmicro,em3027 RTC
Date:   Mon, 26 Aug 2019 16:37:52 +0100
Message-Id: <20190826153800.35400-4-git@andred.net>
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

add/enable RTC support using the on-board EM3027 real time
clock on i2c2.

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ec82f4738c4f..481bd3971c55 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -181,6 +181,11 @@
 		reg = <0x50>;
 		pagesize = <16>;
 	};
+
+	rtc@56 {
+		compatible = "emmicro,em3027";
+		reg = <0x56>;
+	};
 };
 
 &uart1 {
-- 
2.23.0.rc1

