Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A3BC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D40221479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEIIqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:46:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50434 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfEIIqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:46:19 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hOegx-00020s-6J; Thu, 09 May 2019 10:46:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, hal@halemmerich.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Use clk_hw_get_rate() in MMC phase calculation
Date:   Thu, 09 May 2019 10:46:14 +0200
Message-ID: <23276655.4tYWeNrtuJ@phil>
In-Reply-To: <20190507204935.256982-1-dianders@chromium.org>
References: <20190507204935.256982-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. Mai 2019, 22:49:35 CEST schrieb Douglas Anderson:
> When calculating the MMC phase we can just use clk_hw_get_rate()
> instead of clk_get_rate().  This avoids recalculating the rate.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.3

Thanks
Heiko


