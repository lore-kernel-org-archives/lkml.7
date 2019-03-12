Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBBFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3472075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfCLKuU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:50:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58792 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfCLKuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:50:19 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3ez9-0001AP-59; Tue, 12 Mar 2019 11:50:15 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: rockchip: fix wrong clock definitions for rk3328
Date:   Tue, 12 Mar 2019 11:50:14 +0100
Message-ID: <6485520.7NIxTtDDeN@phil>
In-Reply-To: <AM3PR03MB0966A06101CACDAEA4ECD72BAC4F0@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <AM3PR03MB0966A06101CACDAEA4ECD72BAC4F0@AM3PR03MB0966.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 10. März 2019, 13:00:45 CET schrieb Jonas Karlman:
> This patch fixes definition of several clock gate and select register
> that is wrong for rk3328 referring to the TRM and vendor kernel.
> Also use correct number of softrst registers.
> 
> Fix clock definition for:
> - clk_crypto
> - aclk_h265
> - pclk_h265
> - aclk_h264
> - hclk_h264
> - aclk_axisram
> - aclk_gmac
> - aclk_usb3otg
> 
> Fixes: fe3511ad8a1c ("clk: rockchip: add clock controller for rk3328")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

applied for 5.2 after checking the TRM

Thanks for fixing this
Heiko


