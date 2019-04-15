Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF21AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835BF20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356091;
	bh=NsL31rVx1hMnkEnWkCH3tBcxUQpezHUptctZGGTHrww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9GqKoZb+RbtYnIBywrcyjxd40ZxypVlsVE73A0JfzAdaJjp9b5zaw3ECVnOT8zZg
	 l7o4OvujBVieFYrSGp28OBoVna+oFG/py+0QWY3lcWBMoG/c5FjNfxflx7g8YW1i6K
	 MNM7+QwNzPB8ZiGdL6TVxuSD+pbyS3ZB5hrdm9w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfDOTVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbfDOTJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7EE120651;
        Mon, 15 Apr 2019 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355353;
        bh=NsL31rVx1hMnkEnWkCH3tBcxUQpezHUptctZGGTHrww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bheJ29zLM/FLXBflbxa0c8qom/Fg4FIJXOUVT05Vy7XrREvUFStc0grYsB8AuYbNg
         Oq36kFQJVMjZlLRSvIO8xuLI4xZ+jPWQ+cEhcyWQexvBUIUqBFdrwlpnZnBokiEmh9
         qcDZbc/VwvbEV8STjf9X6O5IU1D+TElzy1Nx24P8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Tomohiro Mayama <parly-gh@iris.mystia.org>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 098/101] arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64
Date:   Mon, 15 Apr 2019 20:59:36 +0200
Message-Id: <20190415183745.544465464@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomohiro Mayama <parly-gh@iris.mystia.org>

commit a8772e5d826d0f61f8aa9c284b3ab49035d5273d upstream.

This patch makes USB ports functioning again.

Fixes: 955bebde057e ("arm64: dts: rockchip: add rk3328-rock64 board")
Cc: stable@vger.kernel.org
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Tomohiro Mayama <parly-gh@iris.mystia.org>
Tested-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -45,8 +45,7 @@
 
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";


