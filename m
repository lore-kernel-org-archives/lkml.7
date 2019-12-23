Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6734C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8522220663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rRJNtwwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfLWQf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:35:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37971 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLWQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:35:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so17222672wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0HQesosprpGmVlh0zbgZtCGyxB3GA8LKvF8lU1VAedI=;
        b=rRJNtwwRx+5RzgqTLIxJG6UsSQ6gC0jzvHt+rlkuEFTfdQiebonMWF/GFe43r2a5TX
         8gS7lH2OyXAleCyvXlW/U8KGovJ7a6Ruy+MdG8swhWoCeySn2ygRfRX5ZpbwC7UKm4+G
         lQtna3/Y/EyFQLrVGGEIENU6I7wDUF67zrhGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0HQesosprpGmVlh0zbgZtCGyxB3GA8LKvF8lU1VAedI=;
        b=WY2uN/ibuqp7cbAG3q/a05J5FjS1pd85OhKuK1FhcEIxGYJSZAA6/Bd44aKLnwfkbK
         ulkSBewjtqX5ceHsR310SNEiaJmb7+Tu9h+QfebKgZUfpmWF97c0PK6b8fliyviVJ91n
         psaYqOBuaL8UY9KFISdrHOSF8/vmNEd9jPu5UzX7FA2JYHJbnJ38m2312T2qa98AVnkb
         PBq05YBFXrNhtq3q4HN7kBk1zCGed6ZTqWwwMaRIARFIoYdNEsSLplXjgGGulnsIjymc
         t8zs1+68E6r/H9ndC8TOCC36Vyko/sbrMPwcTogiepX9LjRQm7nDmc9OrMYw0ToBtcUm
         VzEg==
X-Gm-Message-State: APjAAAX+lj3Yhd2rU21gvD2cYGAiPeHP6xbhRehu2Dfso5jPSl/cuou4
        63WTBVG8zF9QA6nLK4eMPOQhGQ==
X-Google-Smtp-Source: APXvYqz/MMNcrLqV4ANXvIxeIGXp4d50q4NXH/qBL523lAObZh+tywV09Z1VDphXKfwDb4wdAqaN6w==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr31306772wrv.364.1577118951849;
        Mon, 23 Dec 2019 08:35:51 -0800 (PST)
Received: from localhost.localdomain ([37.160.152.81])
        by smtp.gmail.com with ESMTPSA id s8sm20412498wrt.57.2019.12.23.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 08:35:51 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: imx6dl: Fix typo in i.CoreM6 1.5 Dual MIPI starter kit
Date:   Mon, 23 Dec 2019 17:35:44 +0100
Message-Id: <20191223163546.29637-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223163546.29637-1-michael@amarulasolutions.com>
References: <20191223163546.29637-1-michael@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the file to be included in dual mipi starter kit. This
fix ethernet probing

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6dl-icore-mipi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
index e43bccb78ab2..d8f3821a0ffd 100644
--- a/arch/arm/boot/dts/imx6dl-icore-mipi.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
-#include "imx6qdl-icore.dtsi"
+#include "imx6qdl-icore-1.5.dtsi"
 
 / {
 	model = "Engicam i.CoreM6 DualLite/Solo MIPI Starter Kit";
-- 
2.17.1

