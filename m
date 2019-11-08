Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3905FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C2E206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213608;
	bh=Gr3SZ9VHa90+tcO5hNJcOPzYgigEHZhDGHk6WUMb78c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bde4VBkSnfoiQZIx8o7sn6EoJbMvhZY6gs77H8PkEhZSlo9CoSL/Mvswi9Kb/Fhuo
	 pvG3mMj+0alX3xm/8nakJiL1xEvLOVmpT4mieC54V5nG7hGyloNWjLAOPOEQ5cMwHz
	 Z2GiXT9fkEYjX3AUDaA7lEP4bmzh33FMy9r2xqus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391435AbfKHLqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391281AbfKHLq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C6521D82;
        Fri,  8 Nov 2019 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213586;
        bh=Gr3SZ9VHa90+tcO5hNJcOPzYgigEHZhDGHk6WUMb78c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hbnPyiJUFzgmNcsl+TGGyjQgv6KoRP7hbxey7u2f6vnAEkvMfOb5nO9FsfP9bqNc6
         /gGqrImQLn506VE154O96n2qVFh7vDSkez8xslw5fVP/mZwoB7em4LZzDulowHqDXq
         wOdcvym8NLcpE8fm4J/i3D3isKqEz9UaFa7uAqeY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 29/64] ARM: dts: omap3-gta04: fixes for tvout / venc
Date:   Fri,  8 Nov 2019 06:45:10 -0500
Message-Id: <20191108114545.15351-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit f6591391373dbff2c0200e1055d4ff86191578d2 ]

* fix connector compatibility (composite)
* add comment for gpio1 23
* add proper #address-cells
* we use only one venc_out channel for composite

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 95c6ac44e307f..67b50dbe28189 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -122,7 +122,7 @@
 	};
 
 	tv0: connector {
-		compatible = "svideo-connector";
+		compatible = "composite-video-connector";
 		label = "tv";
 
 		port {
@@ -134,7 +134,7 @@
 
 	tv_amp: opa362 {
 		compatible = "ti,opa362";
-		enable-gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;	/* GPIO_23 to enable video out amplifier */
 
 		ports {
 			#address-cells = <1>;
@@ -539,10 +539,14 @@
 
 	vdda-supply = <&vdac>;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	port {
+		reg = <0>;
 		venc_out: endpoint {
 			remote-endpoint = <&opa_in>;
-			ti,channels = <2>;
+			ti,channels = <1>;
 			ti,invert-polarity;
 		};
 	};
-- 
2.20.1

