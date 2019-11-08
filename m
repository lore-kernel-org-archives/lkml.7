Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C89C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07AB222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239965;
	bh=ZL7L3CJKFf0IOsXrpyWRVtrO6wviIOigpKJ61ZGvbtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kRywg3HVKuqLxJq2V8R3G0GdDCnbGYNUyeuVwteGKQZ0Kxc/AZGvTffPhxj8C6H4m
	 76fv89NIEoruV6OZlF3opCnWHx0aaUJQmHsmu9H23pxoJtjzg1G3pphXbo57FhS58V
	 H3b7mi0K+2ySIE01tz3RXHtGlHIX+zgAIzgXm/3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391196AbfKHTGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389306AbfKHTGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:06:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D132087E;
        Fri,  8 Nov 2019 19:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239961;
        bh=ZL7L3CJKFf0IOsXrpyWRVtrO6wviIOigpKJ61ZGvbtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SneTrQXvQqMDlOOLhpYvhqRLKiAz9jhZK6d3aHAO8dIunr/oHGJiefGGFXkcRKAwZ
         ruTcNpZRne4cL7kEKXCLohHzCE1Xgy70Yt5mlKfrUuwCCvaSd8xT8nT8LbPS3wqoW2
         ri6buzSvbmRgGudKPOPMHb28/XwzLNwZbA9soOFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vivek Unune <npcomplete13@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 042/140] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Date:   Fri,  8 Nov 2019 19:49:30 +0100
Message-Id: <20191108174908.116909413@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Unune <npcomplete13@gmail.com>

[ Upstream commit 389206e806d892d36de0df6e7b07721432957801 ]

Fix usb-c on X99 TV Box. Tested with armbian w/ kernel 5.3

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
Link: https://lore.kernel.org/r/20190929032230.24628-1-npcomplete13@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index 0d1f5f9a0de95..c133e8d64b2a3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -644,7 +644,7 @@
 	status = "okay";
 
 	u2phy0_host: host-port {
-		phy-supply = <&vcc5v0_host>;
+		phy-supply = <&vcc5v0_typec>;
 		status = "okay";
 	};
 
@@ -712,7 +712,7 @@
 
 &usbdrd_dwc3_0 {
 	status = "okay";
-	dr_mode = "otg";
+	dr_mode = "host";
 };
 
 &usbdrd3_1 {
-- 
2.20.1



