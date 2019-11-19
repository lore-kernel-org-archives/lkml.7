Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ACC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E40020672
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143721;
	bh=OS2+qgrCbkCbhxnpunNNpc1RfxAu+IH0Z3mHb8Di0xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cv8v/+bobUN3R+K/QtD08zZZy0o6qzWeRkcAJSPSOaqqZhmo8ZbQqqUvw8ipzdqgM
	 mNc4yqJhhIQdLS+cJjb7Y9L7CNZIC5F9KWl9W/Usi3tEPSnkd5AQly+TMw1dGowhcJ
	 pzxTdPtF3vrLys4jhC/DFB83OX4piAEuzPWpjk2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfKSGIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbfKSFa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:30:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87AB521939;
        Tue, 19 Nov 2019 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141428;
        bh=OS2+qgrCbkCbhxnpunNNpc1RfxAu+IH0Z3mHb8Di0xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eugRn+N7m9SoppSCHzWqQIlM/Fuk6k3EN6cqglWviVOMeoC5zCNh7zF1nEg5FEDZq
         MfbtSqiwWjmRo2rejJZMdnVo91ETiiDEayQMCqexou5eV/CbkaSdIQ86qexxGpVawL
         onFjHrw8jgbjXplx2M4XYHbU7TmyxTy+mGhuOP4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/422] ARM: dts: omap3-gta04: tvout: enable as display1 alias
Date:   Tue, 19 Nov 2019 06:15:37 +0100
Message-Id: <20191119051407.848146714@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Nikolaus Schaller <hns@goldelico.com>

[ Upstream commit 8905592b6e50cec905e6c6035bbd36201a3bfac1 ]

The omap dss susbystem takes the display aliases to find
out which displays exist. To enable tv-out we must define
an alias.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index eee5fa0035071..79d708ce3a93f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -28,6 +28,7 @@
 
 	aliases {
 		display0 = &lcd;
+		display1 = &tv0;
 	};
 
 	/* fixed 26MHz oscillator */
-- 
2.20.1



