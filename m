Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F89AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB09F2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482340;
	bh=TOV0UK0piw0Hanyoyx8YpCbQcv2tT6LiX7Adeaopczg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+Ur+ovFERclJaX6j/gOitpowu6DsTYB3oFsgXQIrYZWt3smk325uMBAh4101CjCI
	 e/KXoXCGTeIWhmd3ZoFM3ssu/tPFrhlFRfqE0fX2MblDqmScndJe1AJX/CawdyvAyx
	 J1953+N63469AKsTuTkUHpbIM1hFYk1f8gmS3fTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfLDR67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfLDR6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:58:54 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC282073B;
        Wed,  4 Dec 2019 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482333;
        bh=TOV0UK0piw0Hanyoyx8YpCbQcv2tT6LiX7Adeaopczg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzC9yhVYg1nynPJGdkfaQ0qjv7w71IkFFOWf0niS5R4b6yl7gCv7fvf+t8lQbbikz
         lMWgvtKcQIkmBBhnJQiOhLlknbR6GufLfeoQ9reiIIut1b+dsIxOig0xRJzUDMryHv
         /Dmn4kdPZuGeg8giIA3kx00pL0PM2nYBPyvShxi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 11/92] ARM: dts: imx53-voipac-dmm-668: Fix memory node duplication
Date:   Wed,  4 Dec 2019 18:49:11 +0100
Message-Id: <20191204174329.777890837@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 998a84c27a7f3f9133d32af64e19c05cec161a1a ]

imx53-voipac-dmm-668 has two memory nodes, but the correct representation
would be to use a single one with two reg entries - one for each RAM chip
select, so fix it accordingly.

Reported-by: Marco Franchi <marco.franchi@nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index ba689fbd0e413..301cf8d45947f 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -17,12 +17,8 @@
 
 	memory@70000000 {
 		device_type = "memory";
-		reg = <0x70000000 0x20000000>;
-	};
-
-	memory@b0000000 {
-		device_type = "memory";
-		reg = <0xb0000000 0x20000000>;
+		reg = <0x70000000 0x20000000>,
+		      <0xb0000000 0x20000000>;
 	};
 
 	regulators {
-- 
2.20.1



