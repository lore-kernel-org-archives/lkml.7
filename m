Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F7BC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F88820836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCCNxS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:53:18 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41460 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCCNxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:53:18 -0500
Received: from p54b26aa0.dip0.t-ipconnect.de ([84.178.106.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h0RYI-00050O-LA; Sun, 03 Mar 2019 14:53:14 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: enable HDMI CEC on rk3328
Date:   Sun, 03 Mar 2019 14:53:14 +0100
Message-ID: <1731736.AI9y7MdPiA@phil>
In-Reply-To: <AM3PR03MB0966D220C0FEB19CBAE0D913AC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <AM3PR03MB0966D220C0FEB19CBAE0D913AC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 2. März 2019, 17:37:09 CET schrieb Jonas Karlman:
> This patch enables HDMI CEC on RK3328 devices
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

applied for 5.2. I've added another sentence to the commit messsage for the
origin of the (unusual) cec clock, marking the vendor-kernel as source.

Heiko



