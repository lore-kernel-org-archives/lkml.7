Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E94C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974CC2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355067;
	bh=+BAOdvuUEmUZsP3tgXQda1UdJ6bp8jxQAcKu+IIA3kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMoG5K5hLqXyDGNJOtl4bhqB7V/ihHFM9inB8sCYLn4sSLBiB6N2UtW2+LyfMVJyF
	 iK3kANGJv+UJ/iKJM00o6GyDnXN/8pfy3m1YQ7HyQJMPXAcHCWuUs4T/IDDPha9s6I
	 /9Jq2Ph2a75yEaXlR1iwsmzfOfRCSHn3FI24SrV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfDOTE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbfDOTEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37A52087C;
        Mon, 15 Apr 2019 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355064;
        bh=+BAOdvuUEmUZsP3tgXQda1UdJ6bp8jxQAcKu+IIA3kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iELYfodN4j1PAz206GomqX1LMjRsU9Qb5GbG76dk591Al+LjUvfmrAYiAVpnpdBie
         JHF6KgzvtwI9+yZK2ciQfWFMvQ0t3WcWXspJ9YohZY/UZzhTvAC1WshmTlWHUpKXEv
         RcVbGvsMwaUR2lEcTirmLa80pkAOQ1Z8JzWedLkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Tomohiro Mayama <parly-gh@iris.mystia.org>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.14 69/69] arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64
Date:   Mon, 15 Apr 2019 20:59:27 +0200
Message-Id: <20190415183736.922082181@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
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
@@ -82,8 +82,7 @@
 
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";


