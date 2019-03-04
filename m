Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EA3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9573D21019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551677196;
	bh=i1mdTNwlT+9/KI72W9F3JVKrnoPS7734UOheh/YqMtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o9YjOfx3mh7EVlrmj/gFguKrgdowdGOJMiG1DRIcOdkNj+AbNb7E3Utor6MFI8diV
	 BE0+vX5ttV0QPDgRki45qUygL9CfgHKgFnxJeHRhBdEFCs6hUV9ePyzYnjcu2dBKyO
	 EBPfkS5hFz3wKXIvrLbWamj/rp+1+O4qhKSDrlJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfCDF0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfCDF0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:26:35 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD112082F;
        Mon,  4 Mar 2019 05:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551677194;
        bh=i1mdTNwlT+9/KI72W9F3JVKrnoPS7734UOheh/YqMtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HD5lPhYN5Zuz62AYozgTry2GabnsPVnA0wtrNtrIq8RXftKzgVeb4nC3/4Xo+/paq
         wVI6e6yBEGfvx+F4WyBCXXv0pjZa5KUwu3A13Bm4NOWA2ms/SFx2r+B0XBSfZhRg3B
         UygDQO+XDJkq+PischFOfLtJ9RojGScjVZ6Sxl+A=
Date:   Mon, 4 Mar 2019 13:25:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/3] arm: dts: imx8mq: Add cpufreq support
Message-ID: <20190304052528.GW26041@dragon>
References: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 09:42:43PM +0000, Abel Vesa wrote:
> Changes since v2:
>  * renamed the regulator
>  * removed the useless enable-active-high from the regulator 
>  * renamed a53_0_opp_table to a53_opp_table
> 
> Abel Vesa (3):
>   arm64: dts: imx8mq: Add the clocks and the latencies for the A53 cores
>   arm64: dts: imx8mq: Add the buck vdd_arm regulator
>   arm64: dts: imx8mq: Add the opp table and cores opp properties

Applied all, thanks.
