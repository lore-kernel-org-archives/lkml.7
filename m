Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E87CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6730021D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571994550;
	bh=uFG1cMRD5Tz8/465n9rsEA7W+2TvFw3woGFuCUmq66c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dcjk5/POZBlF8mkCWMkUs/TDgpI2z8dlGy+wRRhxDTPrxCQx2bfFjciwm9NO/GDuh
	 dileqccEOOLbH7/+9JBR6PL2s2b2AiWOoTNn3qCRWwxTiYQAXQKJfiOLwrU/gGBfOU
	 Igj80h9diq5NpyAPJrCdb6xLEx4qMwjxZUZbmOLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393324AbfJYJJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391119AbfJYJJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:09:09 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E1E21929;
        Fri, 25 Oct 2019 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571994549;
        bh=uFG1cMRD5Tz8/465n9rsEA7W+2TvFw3woGFuCUmq66c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sS4E7jSY86V/QEQRf2wcBiJnK740L0brYSrWpZYZfwXbiStuc+EE/veFVPSj5vqWW
         hI5yIV06HrfwU9JKBs4BhFpwG/76VnGpAt2wycyZiUWOUxfjk1fUc+NSJ9HqWN1RNL
         8nrpiNxTSa47S8GZoUDtcQzD3mYQj0Q+98sHgfGU=
Date:   Fri, 25 Oct 2019 17:08:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
Message-ID: <20191025090850.GK3208@dragon>
References: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
 <20191025060847.GD3208@dragon>
 <AM0PR04MB4481FA56EFA3C34193241D3D88650@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481FA56EFA3C34193241D3D88650@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 06:14:21AM +0000, Peng Fan wrote:
> Hi Shawn,
> 
> > Subject: Re: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
> > 
> > On Wed, Oct 09, 2019 at 09:58:14AM +0000, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > According Architecture definition guide, SYS_PLL1 is fixed at 800MHz,
> > > SYS_PLL2 is fixed at 1000MHz, so let's use imx_clk_fixed to register
> > > the clocks and drop code that could change the rate.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > Applied all, thanks.
> 
> I have a v2 https://patchwork.kernel.org/cover/11208131/ patch 
> based on Lenoard's v3 
> https://patchwork.kernel.org/patch/11193189/ to avoid conflicts
> when you apply Lenoard's v3 patch.

Okay, I replaced it with your v2 series.  Thanks!

Shawn
