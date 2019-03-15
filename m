Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DC7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F18921872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfCOO7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:59:52 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:41894 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbfCOO7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:59:51 -0400
Received: from localhost.localdomain (85-171-63-107.rev.numericable.fr [85.171.63.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aballier)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 6DAF3335C97;
        Fri, 15 Mar 2019 14:59:49 +0000 (UTC)
From:   Alexis Ballier <aballier@gentoo.org>
Cc:     Alexis Ballier <aballier@gentoo.org>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: rk3399-orangepi: Specify vid supply for the compass (AK09911)
Date:   Fri, 15 Mar 2019 15:58:19 +0100
Message-Id: <20190315145818.23610-3-aballier@gentoo.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190315145818.23610-1-aballier@gentoo.org>
References: <20190315145818.23610-1-aballier@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite this not being mentioned in the binding documentation, this
generates a log at boot about it being missing.

Signed-off-by: Alexis Ballier <aballier@gentoo.org>
Cc: devicetree@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---

Should the binding doc be updated ?
---
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index 6bc2e545f2fb..96ccbe5c4f0c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -472,6 +472,7 @@
 		compatible = "asahi-kasei,ak09911";
 		reg = <0x0c>;
 		vdd-supply = <&vcc3v3_s3>;
+		vid-supply = <&vcc3v3_s3>;
 	};
 
 	mpu6500@68 {
-- 
2.21.0

