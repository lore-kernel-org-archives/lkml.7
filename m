Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A97C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BCB22476
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610203;
	bh=ZCHLhni9I5Hq8zgWjDgMU4vLfAwPEpoV4JgK5zdxmCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wlfj+mC1Qu8+KDMkfhM4jgXZVDNV8bFOHSN9dZ/SlBl1i8hcQs2srkN3btKqCOR0E
	 xlmPlGQ2rFjh8cmiLIP1arI0jGjRXmq0zWhaAW1i3yW5yyfWDd1xcOyDCPf0/e8pbd
	 Cbp+SOf6yarPcxT9dz4rTNVOJeu7mbjQxNiiBIcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfKMB4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbfKMB4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:56:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87CDD2247A;
        Wed, 13 Nov 2019 01:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610193;
        bh=ZCHLhni9I5Hq8zgWjDgMU4vLfAwPEpoV4JgK5zdxmCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtpW8Xoe/cYF/I57Z3TV1MMDh038cSdm+TBOwqEs0gDGIutW6qQPim6I0w/vvIQeJ
         DUxgotY5K/n8DKoFn8h+3avkylEaRPVwKolc/PehTXZec5vx5nYY3AgfNgQ2IrSzpT
         3UP9F595211oHjWgsOpHNOZrRm9LbnWBzD0tPS60=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Rossak <embed3d@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 007/115] ARM: dts: sun8i: h3-h5: ir register size should be the whole memory block
Date:   Tue, 12 Nov 2019 20:54:34 -0500
Message-Id: <20191113015622.11592-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Rossak <embed3d@gmail.com>

[ Upstream commit 6c700289a3e84d5d3f2a95cf27732a7f7fce105b ]

The size of the register should be the size of the whole memory block,
not just the registers, that are needed.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 11240a8313c26..03f37081fc64e 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -594,7 +594,7 @@
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x01f02000 0x40>;
+			reg = <0x01f02000 0x400>;
 			status = "disabled";
 		};
 
-- 
2.20.1

