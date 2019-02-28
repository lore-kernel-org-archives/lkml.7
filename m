Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8525C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A21218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366537;
	bh=AWbP3AmfwOCRX+SXOHqcRZw/sp4To/uc6AMIMDXS5ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vkeggO1KOBJQ4al1v4it7AKFr+sjLZcryj/jiomCqB7mz9UktfYvrdsDr6FREwc7z
	 JKPA+iWcH6W206RKOsKgqEXY98itCODv+YSms1dlmOFVA24a6Knh5RlZVAw4Qxx/Ff
	 Kvn6aymIjFrnD4obW56XaCIkQD9ITvIIXJ8LL96E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbfB1PI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733112AbfB1PIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1624218D3;
        Thu, 28 Feb 2019 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366527;
        bh=AWbP3AmfwOCRX+SXOHqcRZw/sp4To/uc6AMIMDXS5ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhLmaG1Le4KFjWp4yj+uMKGh1cb2Q0Mw5skzuCfmELlLKJWoqWCz5JSMv/0ZvK2XC
         vt79D3IOw7nNGC8F2qOKb6G2ytNJRQajUai5pBL56hSXfNZKJsVb+IwFXBlvYR43M4
         8JwZgR7N0K9kKrNgM0+oMJ+apxKI0/so2QOT+dag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 21/81] ARM: dts: am335x-shc.dts: fix wrong cd pin level
Date:   Thu, 28 Feb 2019 10:07:13 -0500
Message-Id: <20190228150813.10256-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Schocher <hs@denx.de>

[ Upstream commit 063c20e12f8bbbc10cabc2413606b140085beb62 ]

cd pin on mmc1 is GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH

Fixes: e63201f19438 ("mmc: omap_hsmmc: Delete platform data GPIO CD and WP")
Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-shc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 1d925ed2b102c..8fbbad11a80c9 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -215,7 +215,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <0x4>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	cd-inverted;
 	max-frequency = <26000000>;
 	vmmc-supply = <&vmmcsd_fixed>;
-- 
2.19.1

