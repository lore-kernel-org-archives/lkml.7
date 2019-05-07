Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF7C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CF8205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="fO9vlopf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfEGJfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:35:38 -0400
Received: from vps.xff.cz ([195.181.215.36]:60078 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfEGJfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1557221735; bh=ldoLNmoDFfbeja2q4a+Rh5QICPMhKBlbE7KGJkgYnvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fO9vlopfZxr3U78dgV0RXJxUiXqgiQfcDS0dXQA3Fe/vMCA9+DW3PyWSNIk8Cp0d9
         OTRKbUeidJ2E4+080m3bpyzxfqpXMliXGec0mzapVPD8iuS5e1ESFtyh/FDKNeqkeC
         QelJZ4Kg7S8J3krLQMFKbmOWVCjGFQ1sx0LgRkiY=
Date:   Tue, 7 May 2019 11:35:35 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Enable HDMI output on
 orangepi 3
Message-ID: <20190507093535.uapqhxduwtbdgbtq@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Yangtao Li <tiny.windzz@gmail.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190420145240.27400-1-tiny.windzz@gmail.com>
 <20190502073401.3l3fl4alicyzpud7@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502073401.3l3fl4alicyzpud7@flea>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, May 02, 2019 at 09:34:01AM +0200, Maxime Ripard wrote:
> On Sat, Apr 20, 2019 at 10:52:40AM -0400, Yangtao Li wrote:
> > Orangepi 3 has HDMI type A connector.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Queued for 5.3, thanks!
> Maxime

This patch is not enough. HDMI support on Orange Pi 3 also needs to
enable DDC IO. While the SoC will feed some default output singal
into the display, without DDC enabled it will not work reliably.

That support is part of my Orange Pi 3 series, and will be reworked
for v5 of that series.

While I can rebase on top of this, it would be easier if you dropped
this patch until the propper support is ready. I don't see any reason
why this should be rushed with half-working solution.

regards,
	o.

> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

