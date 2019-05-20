Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4BDC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB29A20851
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558333821;
	bh=guWiZhnrQX5XOmYv/2WvChjs/sYiaG71enI6UFsxEOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BsPgBbwlkNTd2RBNmd2QPM3+3GF7I+0qh4W5uYsOBrieVYCFwtCUeIMwGpKUXLkcZ
	 jQVEvfADycKTte7YX4oLmoymSRMEST6Kz1alqEEakTJ/aPvsrnxrqdlIxwhsBvbHdI
	 I057i3m6woOzeQhikpfyg4zDd4Jvz9cgLCIeqCjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfETGaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfETGaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:30:19 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CF6206B6;
        Mon, 20 May 2019 06:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558333819;
        bh=guWiZhnrQX5XOmYv/2WvChjs/sYiaG71enI6UFsxEOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTu87tyvie8buwqB1PTc6WMdWlduuQC6RyhF+N3zWBG2GTx4xxBmwsx0/7et1hXkl
         9xeK3A1BcbLjpJmDBRC7Ae25lDilDfDbin1iGo7PWvS60rHzpoiFNGEQM4+YGkp8VJ
         2TOKZU9Q6oVcMRoh4tLwLdqUj2n749/98WNgHeMU=
Date:   Mon, 20 May 2019 14:29:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND] clk: imx7ulp: update nic1_bus_clk parent info
Message-ID: <20190520062926.GQ15856@dragon>
References: <1557656739-13120-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557656739-13120-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 10:30:41AM +0000, Anson Huang wrote:
> Since i.MX7ULP B0 chip, nic1_bus_clk's parent is changed to
> from nic0_clk directly, update it accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
