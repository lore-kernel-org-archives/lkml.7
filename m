Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D5C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAF721019
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354905;
	bh=53PUyJaNZYK0oeRLvc+fYR/x3wIhJ/IcdmR/TmGCqtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VcBC5mxP/lNRpiTGwOXU/07eTUPU6ghpYnZPzhLvKwU3/tdSC+azn1HbfNC1+xTiX
	 6khBBOdCKTO5doQhyS64fXzZUSJO8znqZ8arREDtXt/567QLSquHu5okEisS2oWe93
	 cZDUSsB1Qe/efZ3G0dNl341egSktF3+p9uUfB+tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfKJDBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfKJC4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:56:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280F622517;
        Sun, 10 Nov 2019 02:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354114;
        bh=53PUyJaNZYK0oeRLvc+fYR/x3wIhJ/IcdmR/TmGCqtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8axQSLdugOWb+FVBhaFWD0sjR5imbWWnNVQdnnOMaaS+PEkGK/D9JedjLEwX6LzF
         JisJa8+oNjkho36lOTf+z21y94/vhJzydfshXoF2snWXokBmDf+pqTOvgydZC/1x2Q
         16iuijR/65D+srW+nm6S5d0GKtn+Rqhmhfo9siTw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 103/109] arm64: dts: rockchip: enable display nodes on rk3328-rock64
Date:   Sat,  9 Nov 2019 21:45:35 -0500
Message-Id: <20191110024541.31567-103-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit e78d53c7b2873e0724eb765a88ccde42560b0e05 ]

Enable necessary nodes to get output on the hdmi port of the board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 3f8f528099a80..19c086f1bf6db 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -146,6 +146,14 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmiphy {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -333,3 +341,11 @@
 &usb_host0_ohci {
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
-- 
2.20.1

