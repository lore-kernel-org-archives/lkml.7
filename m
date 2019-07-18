Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A0BC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E0D21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563430549;
	bh=RdebAFINFwGRd3fswkfBur49ClSa/w8Ovi61pshm760=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pTy/kBGoy1qiwifGLgMBlT+2xNffCBW2FNhyt6i9Pr3qkg9HoL2x1w/juvEyc3OeJ
	 3SCQjgkvBTTNuYDurk/uI31pyXWtEND8dU9DliE9bLZkDUS/TdXPwuL1mOev//9Dp2
	 1800R2aGqpDkNJAF4qjagrL0u1KxfSf7PHCUHDi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfGRGPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfGRGPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:15:47 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EFA21019;
        Thu, 18 Jul 2019 06:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563430546;
        bh=RdebAFINFwGRd3fswkfBur49ClSa/w8Ovi61pshm760=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljYbDYhJ4xVqrCpTFJY/3ishKDOVoQHHBW2ZDakxhOFV94K9Tu0lc5iewNEo4Ch8S
         2gtRRThD7GNxs9XpLHD7c0hqVRT9LZsNhUoop53dJgoZqPJUA49FyMbwUYOQELe2AH
         fed0iMZuQCFKEmqik+7Gsty3wvmLcTLEj+EaNZkc=
Date:   Thu, 18 Jul 2019 14:15:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Init rates and parents configs
 for clocks
Message-ID: <20190718061529.GH3738@dragon>
References: <1562155702-29809-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562155702-29809-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 03:08:22PM +0300, Abel Vesa wrote:
> Add the initial configuration for clocks that need default parent and rate
> setting. This is based on the vendor tree clock provider parents and rates
> configuration except this is doing the setup in dts rather than using clock
> consumer API in a clock provider driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
