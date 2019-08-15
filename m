Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EB5C32759
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58593205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfHOIBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:01:50 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46883 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfHOIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:01:50 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C482E40004;
        Thu, 15 Aug 2019 08:01:47 +0000 (UTC)
Date:   Thu, 15 Aug 2019 10:01:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] clk: sunxi: Don't call clk_hw_get_name() on a hw that
 isn't registered
Message-ID: <20190815080146.4tkudfzus7uryoe6@flea>
References: <20190815041037.3470-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815041037.3470-1-sboyd@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:10:37PM -0700, Stephen Boyd wrote:
> The implementation of clk_hw_get_name() relies on the clk_core
> associated with the clk_hw pointer existing. If of_clk_hw_register()
> fails, there isn't a clk_core created yet, so calling clk_hw_get_name()
> here fails. Extract the name first so we can print it later.
>
> Fixes: 1d80c14248d6 ("clk: sunxi-ng: Add common infrastructure")
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Do you want to apply it yourself, or should I merge this and send you
a PR later?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
