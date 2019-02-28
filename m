Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AB220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367671;
	bh=6JOlrSoCtIOY1Lh7kM727lF8OSXKGL8M/SH78SuWTV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l7Y0MpyfAsHzFtfjslU0ixGrxJ+tvHzs2S158g8QYda/DwxDvMs8uiBG3jueB9ySs
	 TH1z5ckVBPHJ1W50q+8h1DnAWgzXdvqSDIYBh1d1yI8dst+wk+9HP03up3KICw90vu
	 HlvI159Nv3nXVuYsoW3+GN0cjoHFC2seJ37fOYfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbfB1P1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387876AbfB1PLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA48218D8;
        Thu, 28 Feb 2019 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366668;
        bh=6JOlrSoCtIOY1Lh7kM727lF8OSXKGL8M/SH78SuWTV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCuFiP9ixBfE4tpis0W8jL8xSoLLAPnw0EemfdyKU4Htm+S0vLYLyXulXxwOgpiai
         lAGWKfVQdMXR5Z+AZa28rGA2RacqMxBf3KOClr5nT646m5/cc58TqmFgGSqau+1JK/
         VFY8+EXJjKoBrqgj+w/OLwy4MlbugQ7Lojc8XJsQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/64] ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
Date:   Thu, 28 Feb 2019 10:10:03 -0500
Message-Id: <20190228151105.11277-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit ef4a55b9197a8f844ea0663138e902dcce3e2f36 ]

We're now getting the following error:

genirq: Setting trigger mode 1 for irq 230 failed
(regmap_irq_set_type+0x0/0x15c)
cpcap-usb-phy cpcap-usb-phy.0: could not get irq dp: -524

Cc: Sebastian Reichel <sre@kernel.org>
Reported-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index ddc7a7bb33c0d..f57acf8f66b95 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -105,7 +105,7 @@
 			interrupts-extended = <
 				&cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
 				&cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
-				&cpcap 48 1
+				&cpcap 48 0
 			>;
 			interrupt-names =
 				"id_ground", "id_float", "se0conn", "vbusvld",
-- 
2.19.1

