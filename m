Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8023AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5649120850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCSPkm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:40:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33070 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCSPkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:40:41 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h6Gqx-0007Yd-Fw; Tue, 19 Mar 2019 16:40:35 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH -next] phy: rockchip-typec: Make usb3_pll_cfg and dp_pll_cfg static
Date:   Tue, 19 Mar 2019 16:40:35 +0100
Message-ID: <9533465.g4Uc9Oev60@diego>
In-Reply-To: <20190319153028.22452-1-yuehaibing@huawei.com>
References: <20190319153028.22452-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 19. März 2019, 16:30:28 CET schrieb Yue Haibing:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/phy/rockchip/phy-rockchip-typec.c:403:16: warning: symbol 'usb3_pll_cfg' was not declared. Should it be static?
> drivers/phy/rockchip/phy-rockchip-typec.c:420:16: warning: symbol 'dp_pll_cfg' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

looks good,
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


