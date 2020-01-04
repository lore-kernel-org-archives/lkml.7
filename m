Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F7EC32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048D021734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 17:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgADRMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 12:12:13 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:49738 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADRMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 12:12:12 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C07202002C;
        Sat,  4 Jan 2020 18:12:06 +0100 (CET)
Date:   Sat, 4 Jan 2020 18:12:05 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     alexandre.belloni@bootlin.com, airlied@linux.ie,
        nicolas.ferre@microchip.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        lee.jones@linaro.org, peda@axentia.se,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/6] drm: atmel-hlcdc: prefer a lower pixel-clock than
 requested
Message-ID: <20200104171205.GA8724@ravnborg.org>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
 <1576672109-22707-6-git-send-email-claudiu.beznea@microchip.com>
 <20200102090848.GC29446@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102090848.GC29446@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8
        a=e5mUnYsNAAAA:8 a=Qn5YEMP7ln1rRxY8a6QA:9 a=CjuIK1q_8ugA:10
        a=E8ToXWR_bxluHZ7gmE-Z:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu

On Thu, Jan 02, 2020 at 10:08:48AM +0100, Sam Ravnborg wrote:
> On Wed, Dec 18, 2019 at 02:28:28PM +0200, Claudiu Beznea wrote:
> > From: Peter Rosin <peda@axentia.se>
> > 
> > The intention was to only select a higher pixel-clock rate than the
> > requested, if a slight overclocking would result in a rate significantly
> > closer to the requested rate than if the conservative lower pixel-clock
> > rate is selected. The fixed patch has the logic the other way around and
> > actually prefers the higher frequency. Fix that.
> > 
> > Fixes: f6f7ad323461 ("drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested")
> The id is wrong here - the right one is: 9946a3a9dbedaaacef8b7e94f6ac144f1daaf1de
> The wrong id above was used before - so I think it is a copy'n'paste
> thing.
> 
> Hint: try "dim fixes 9946a3a9dbedaaacef8b7e94f6ac144f1daaf1de"
> 
> If I get a quick response from Lee I can fix it up while applying.
> 
> 	Sam
> 
> > Reported-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > Signed-off-by: Peter Rosin <peda@axentia.se>

One other detail.
The patch has passed through your hands, so you have to add your s-o-b
to document this.
The chain of s-o-b shall document the path the patch has taken towards
the kernel.

In this case:
Peter => Claudiu => Sam => Applied.

Please resend or reply where you say OK that I add your s-o-b.

PS. And happy new year!

	Sam


> > ---
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > index 721fa88bf71d..10985134ce0b 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > @@ -121,8 +121,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
> >  		int div_low = prate / mode_rate;
> >  
> >  		if (div_low >= 2 &&
> > -		    ((prate / div_low - mode_rate) <
> > -		     10 * (mode_rate - prate / div)))
> > +		    (10 * (prate / div_low - mode_rate) <
> > +		     (mode_rate - prate / div)))
> >  			/*
> >  			 * At least 10 times better when using a higher
> >  			 * frequency than requested, instead of a lower.
> > -- 
> > 2.7.4
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
