Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB30C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A356A22464
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575277259;
	bh=tVYMJnp1OdZaMK26bl6SySF2HHbOorpSfPdGqQkO36s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GU39hWiqFm+xpvwtnNPZsAPe7l7sth1x9dNB3+NS+nJW1UZdpGKFKXYhOEm+RkgKg
	 bCG88W4dm6TeHuWkPJuKwf8RU0631/QiP33NSRYkmfNEwBFkgPp8CR3afjTlZzV6T+
	 JPptuHM4vTa7u9rlpW8SP9QRGr2HXI6SzQqXZiOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLBJA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfLBJA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:00:57 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2DE2231B;
        Mon,  2 Dec 2019 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575277257;
        bh=tVYMJnp1OdZaMK26bl6SySF2HHbOorpSfPdGqQkO36s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdVEHvQArOPv081P1hWGHzhguheF0y/Yf2gsA8OdnQkCR7q/PG44qNY07q8GKdnSn
         cGS8aZwyHV5y9HnnItM53YISMZF+tu+BQMvdSYk+nKblP6KrAfEI93bp6VChfuLrlS
         x4r1Z4KPzDTzBkL6w6sRvLJLv53QDM+LvSUtA074=
Date:   Mon, 2 Dec 2019 17:00:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx: clk-divider-gate: typo fix
Message-ID: <20191202090041.GG9767@dragon>
References: <1572862200-29923-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572862200-29923-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:11:33AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> resue->reuse
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied it after updating the subject and commit log as below.

    clk: imx: clk-divider-gate: fix a typo in comment
    
    Fix a typo in comment: resue -> reuse.

Shawn

> ---
>  drivers/clk/imx/clk-divider-gate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-divider-gate.c b/drivers/clk/imx/clk-divider-gate.c
> index 2a8352a316c7..214e18eb2b22 100644
> --- a/drivers/clk/imx/clk-divider-gate.c
> +++ b/drivers/clk/imx/clk-divider-gate.c
> @@ -167,7 +167,7 @@ static const struct clk_ops clk_divider_gate_ops = {
>  };
>  
>  /*
> - * NOTE: In order to resue the most code from the common divider,
> + * NOTE: In order to reuse the most code from the common divider,
>   * we also design our divider following the way that provids an extra
>   * clk_divider_flags, however it's fixed to CLK_DIVIDER_ONE_BASED by
>   * default as our HW is. Besides that it supports only CLK_DIVIDER_READ_ONLY
> -- 
> 2.16.4
> 
