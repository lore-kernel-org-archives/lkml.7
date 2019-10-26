Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4CCA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDCA21D7F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572077839;
	bh=z3MpLB+xELO0dgBsp/trPGrwsDL2LK34945azngzhgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c96Jx0WnxNqFqfozvObJX8v36VlohAl2XaiU6NvueJ+jmvkQFi6ckpCQMmoq+pz0N
	 p/sVWuDPnpeekx6ggdWemmPDWmRSPmhnpWfWe8lCYur7P2EhrhdBgRZUOSFFXjhpxu
	 7zxk6wt7javCv6wMWrwHD52/WjiyJjXLCu2h2324=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJZIRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 04:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfJZIRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 04:17:18 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D054C205F4;
        Sat, 26 Oct 2019 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572077837;
        bh=z3MpLB+xELO0dgBsp/trPGrwsDL2LK34945azngzhgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rA20J243awBpAOyf+i9/SIbrZAqIvm3X/jw4VdNHLnf+jVhsx2r8rXDfExzGecFN3
         HYvDNsvOIy9CF1Y80e3AR8L4hmBS0qwvy7iFPx2nmFqvCCxj9jOmGrlTrmY1sb2K+R
         mRFaLo5Vq3F9hC8IgPQU3YFpo6OZLg35rG21czbw=
Date:   Sat, 26 Oct 2019 16:17:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        gustavo@embeddedor.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx7ulp: Correct DDR clock mux options
Message-ID: <20191026081658.GD14401@dragon>
References: <1570784940-5965-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570784940-5965-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 05:09:00PM +0800, Anson Huang wrote:
> In the latest reference manual Rev.0,06/2019, the DDR clock mux
> is extended to 2 bits, and the clock options are also changed,
> correct them accordingly.
> 
> Fixes: b1260067ac3d ("clk: imx: add imx7ulp clk driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
