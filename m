Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573FB20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553590242;
	bh=4sZI6hzMJn/kJR1eUOgb31e3FFfD4suHGkOxmSNodPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e3LPJWJuXAojzjp8cvoy7duvMqxGAuUx7E7grE8uDCBtBXuiPNdL8+Viav8zF3A8F
	 8q7fc7shfaNbe0pglTpYUKjnmuMnoFOylp9Og4x/rIUleevInVHzow6YvE9DGGpi04
	 vtSPNcliLcvH/hpwBZt113iVcE5DTENmdIt/MTGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfCZIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfCZIuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:50:40 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C342120856;
        Tue, 26 Mar 2019 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553590240;
        bh=4sZI6hzMJn/kJR1eUOgb31e3FFfD4suHGkOxmSNodPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzVfMuUmPJOygMx97dtW6C66lUPGN6FsyFTrD/H4cc4PGEfs/hScEBAb/Jf2cQQuQ
         YpXa+aR+JG6BhF5SZO0tK+1ac2ClT7+1I2kMWroBeJl+UkRTwpZWVoYlhJ9eO3Enw6
         XYla9K6ZxIf0w+EkRLMTSjcRMiLGyuAeXoXE3lsU=
Date:   Tue, 26 Mar 2019 16:50:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx: Remove unused imx_get_clk_hw_fixed
Message-ID: <20190326085001.GJ12513@dragon>
References: <1553181943-24123-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553181943-24123-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:25:54PM +0000, Abel Vesa wrote:
> This is never used and the imx_clk_hw_fixed does the same thing.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
