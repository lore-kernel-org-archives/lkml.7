Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71780C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E931222ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142885;
	bh=53PUyJaNZYK0oeRLvc+fYR/x3wIhJ/IcdmR/TmGCqtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HW9EX6Mri0N2DVUzkBlfasVdApZgCbZWGI4iG5VnGA1d4/SBfyRGbFcc2Q3J6Xtgm
	 KqPKeOgXTW8zFC5pA96Tq3g5B/VZpwHJyP7P+gatVNXrR2+2eZsA7WpYuPw3qv0iDn
	 hTfv7l5QgxRGhjVb6O6SLQ0wVUZ/9pR7xOz5fY3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbfKSFyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbfKSFyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:54:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17B1D208C3;
        Tue, 19 Nov 2019 05:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142880;
        bh=53PUyJaNZYK0oeRLvc+fYR/x3wIhJ/IcdmR/TmGCqtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpSJqvus9r3vn+hudkudZ/BVMBr5p/ttOtcY3FXd9tkAfDl7jnbOJNNmLSXbZ9YCh
         j5Yxp8S6IYnO/76Udmc2/ho/2V8ulB6ztC09dSHejehx4TpvtZLNjedgAguCNtXJwC
         +L0F9SnVQ2jVt0xWVY1bRbNOhRv2I6EqpX1U294c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 232/239] arm64: dts: rockchip: enable display nodes on rk3328-rock64
Date:   Tue, 19 Nov 2019 06:20:32 +0100
Message-Id: <20191119051341.958142630@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



