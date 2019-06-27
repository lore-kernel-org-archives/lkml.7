Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D717C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4551216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595585;
	bh=+ZN2H1Rhb2nLG7GYH4zcFDSdXLZMZUmax+jn/se6dp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sax3ZKcJK3Fww/UGCBlNpT2gKlaWc01QmSukdnozjwNmBk2+QrQ9+PxAams58FanJ
	 A4dpTIoz5FxReJmR9wk0TG2AucvgRkglQWo8BAddbck1OC958CZ+s3M+vDZVDjqE/T
	 4mK3btif9fv03HK0iZ+VRtUVQdliXZWLt9csUW5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfF0AdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfF0Ac6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:32:58 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23CB217D7;
        Thu, 27 Jun 2019 00:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595577;
        bh=+ZN2H1Rhb2nLG7GYH4zcFDSdXLZMZUmax+jn/se6dp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XIXLJxSsYQoH3N99LtQjKbZeJaXSL5srr9aEaGWRveCrvkKBorycFsxRx5Ocg6mz
         7d4Fzz6388paREQz2cry/XxGWRbshdED+qfjPEKVXU/7t2bs91+CQz/CcGN2yrbKeW
         uV+Su3Tqe3ntRAZdkbrNZL1f4Vt+tH+XXLdjEEeM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Teresa Remmet <t.remmet@phytec.de>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 46/95] ARM: dts: am335x phytec boards: Fix cd-gpios active level
Date:   Wed, 26 Jun 2019 20:29:31 -0400
Message-Id: <20190627003021.19867-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teresa Remmet <t.remmet@phytec.de>

[ Upstream commit 8a0098c05a272c9a68f6885e09755755b612459c ]

Active level of the mmc1 cd gpio needs to be low instead of high.
Fix PCM-953 and phyBOARD-WEGA.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-pcm-953.dtsi | 2 +-
 arch/arm/boot/dts/am335x-wega.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
index 1ec8e0d80191..572fbd254690 100644
--- a/arch/arm/boot/dts/am335x-pcm-953.dtsi
+++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi
@@ -197,7 +197,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 8ce541739b24..83e4fe595e37 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -157,7 +157,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.20.1

