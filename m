Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD6C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD22721951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfGVVo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:44:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41130 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbfGVVo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:44:27 -0400
Received: from 084035110054.static.ipv4.infopact.nl ([84.35.110.54] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hpg6V-0001tM-PU; Mon, 22 Jul 2019 23:44:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nathan Huckleberry <nhuck@google.com>, andy.yan@rock-chips.com,
        mturquette@baylibre.com, zhangqing@rock-chips.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] clk: rockchip: Fix -Wunused-const-variable
Date:   Mon, 22 Jul 2019 23:44:18 +0200
Message-ID: <19079299.fd1ZiCyHlL@phil>
In-Reply-To: <20190722213519.910D321900@mail.kernel.org>
References: <20190627222220.89175-1-nhuck@google.com> <20190722213519.910D321900@mail.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Am Montag, 22. Juli 2019, 23:35:18 CEST schrieb Stephen Boyd:
> Quoting Nathan Huckleberry (2019-06-27 15:22:20)
> > Clang produces the following warning
> > 
> > drivers/clk/rockchip/clk-rv1108.c:125:7: warning: unused variable
> > 'mux_pll_src_3plls_p' [-Wunused-const-variable]
> > PNAME(mux_pll_src_3plls_p)      = { "apll", "gpll", "dpll" };
> > 
> > Looks like this variable was never used. Deleting it to remove the
> > warning.
> > 
> > Cc: clang-built-linux@googlegroups.com
> > Link: https://github.com/ClangBuiltLinux/linux/issues/524
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >  drivers/clk/rockchip/clk-rv1108.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Heiko, can you pick this up? Looks like v5.4 material.

yep ... I'm planning to do that :-)

Heiko


> > diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
> > index 96cc6af5632c..5947d3192866 100644
> > --- a/drivers/clk/rockchip/clk-rv1108.c
> > +++ b/drivers/clk/rockchip/clk-rv1108.c
> > @@ -122,7 +122,6 @@ PNAME(mux_usb480m_pre_p)    = { "usbphy", "xin24m" };
> >  PNAME(mux_hdmiphy_phy_p)       = { "hdmiphy", "xin24m" };
> >  PNAME(mux_dclk_hdmiphy_pre_p)  = { "dclk_hdmiphy_src_gpll", "dclk_hdmiphy_src_dpll" };
> >  PNAME(mux_pll_src_4plls_p)     = { "dpll", "gpll", "hdmiphy", "usb480m" };
> > -PNAME(mux_pll_src_3plls_p)     = { "apll", "gpll", "dpll" };
> >  PNAME(mux_pll_src_2plls_p)     = { "dpll", "gpll" };
> >  PNAME(mux_pll_src_apll_gpll_p) = { "apll", "gpll" };
> >  PNAME(mux_aclk_peri_src_p)     = { "aclk_peri_src_gpll", "aclk_peri_src_dpll" };




