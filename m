Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C9F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="mbtWQCSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbfCZUcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:32:33 -0400
Received: from vps.xff.cz ([195.181.215.36]:51040 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbfCZUcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:32:33 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 16:32:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553631994; bh=KSbTlKGKQo5g7XiP9W/kwjgCMbjOyvr5fk6KhXsUrGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbtWQCSg7uf6f3i9ynsk+7IZcPgKERPvxW7yHB+9uEUGYGzQDnoi9cCE0E1PrCanE
         /s0yrTLxchhS3lVLc02f1GlzkzkPNU/x0TNp76HLia3RkXYUTK000DRt5ehufeOhOp
         2ALWGWEPV2Iz8usVVjKg9/wnY0ZuZTGOuZyzMXDM=
Date:   Tue, 26 Mar 2019 21:26:34 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>
Cc:     Ziping Chen <techping.chan@gmail.com>, wens@csie.org,
        robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/3] input: sun4i-a10-lradc-keys:
 Add support for A83T
Message-ID: <20190326202634.di2rhacp2izeqyg3@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Ziping Chen <techping.chan@gmail.com>, wens@csie.org,
        robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20170624024515.4669-1-techping.chan@gmail.com>
 <20170624024515.4669-2-techping.chan@gmail.com>
 <20170626171342.pdr7xdiaki4i5bdt@flea.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626171342.pdr7xdiaki4i5bdt@flea.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 26, 2017 at 07:13:42PM +0200, Maxime Ripard wrote:
> On Sat, Jun 24, 2017 at 10:45:13AM +0800, Ziping Chen wrote:
> > From: Ziping Chen <techping.chan@gmail.com>
> > 
> > Allwinner A83T SoC has a low res adc like the one
> > in Allwinner A10 SoC, however, the A10 SoC's vref
> > of lradc internally is divided by 2/3 and the A83T
> > SoC's vref of lradc internally is divided by 3/4,
> > thus add a hardware variant for it to be compatible
> > with various devices.
> > 
> > Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Can we move on with this patch series? It's a few years and it doesn't seem that
there is any interest/progress with lradc iio based driver, and merging this
wouldn't block that effort anyway (as suggested in other replies).

I can re-send the series with the changed compatible name, and add a mainline
user of this driver (A83T based TBS-A711 tablet).

Any objections?

regards,
	o.

> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.


