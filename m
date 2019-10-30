Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF228CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AE2208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450788;
	bh=ZL7L3CJKFf0IOsXrpyWRVtrO6wviIOigpKJ61ZGvbtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T1vkIV8YBUrpWW6uSZkIXhB7U6gc3O3e42U9eTA/18rkwVs2NOOR63uNaCAjrheei
	 VM14wpq4gRnhxrzCqq3h3yLcotUKng+lUEL5z7PBVxYcwi/vdCZShlbQjMIN1FNUwQ
	 otEu1VtOCIeK1NdKp3Ynmg0cYrWH9+cijk/7ZHdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfJ3Pwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfJ3Pwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:52:37 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7378020874;
        Wed, 30 Oct 2019 15:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450756;
        bh=ZL7L3CJKFf0IOsXrpyWRVtrO6wviIOigpKJ61ZGvbtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxLCqU0no+SUWO2Gz1GwVxYQXT8mFowJWrU/rSQYVC0jjJwGncz6DuNTcHGduW5nU
         kFW6072vEidOjFh+RlThlqFRBDwilhxkx7uYSd+IDAHxnvPnlGdIXP4corpLfMmtZv
         ZphVL6Z7b+nUz/R9GpOkPEMsxMaa5d4As4/iDCnk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vivek Unune <npcomplete13@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.3 42/81] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Date:   Wed, 30 Oct 2019 11:48:48 -0400
Message-Id: <20191030154928.9432-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

