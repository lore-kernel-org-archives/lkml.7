Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF167C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99DB2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCLKvO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:51:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58836 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfCLKvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:51:14 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3f01-0001B2-T7; Tue, 12 Mar 2019 11:51:09 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Akash Gajjar <akash@openedev.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add Nanopi NEO4 initial support
Date:   Tue, 12 Mar 2019 11:51:09 +0100
Message-ID: <14002714.JsTqZNVDqa@phil>
In-Reply-To: <20190308181202.11607-1-jagan@amarulasolutions.com>
References: <20190308181202.11607-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. März 2019, 19:12:02 CET schrieb Jagan Teki:
> FriendlyElec NanoPi NEO4 is known to be a revision 4 based
> NanoPi4 series of boards.
> 
> Most of know peripherals are shared between Nanopi M4 vs NEO4, except
> - 1GB DDR3
> - USB Host ports
> - Missing DSI port
> - USB 2.0 Host with USB2PHY0 (no USB2PH1)
> 
> Add support for it, by reusing existing rk3399-nanopi4.dtsi
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Akash Gajjar <akash@openedev.com>

applied for 5.2

Thanks
Heiko


