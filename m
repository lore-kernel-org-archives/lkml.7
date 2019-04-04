Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2365AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DE02171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfDDSzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:55:25 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:34529 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727398AbfDDSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:55:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E60031802EFE0;
        Thu,  4 Apr 2019 18:55:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hope54_11554c3f8d22c
X-Filterd-Recvd-Size: 3107
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Apr 2019 18:55:18 +0000 (UTC)
Message-ID: <ab5f36952d2125f5ed9706aa58b64ab10fecf531.camel@perches.com>
Subject: Re: [PATCH] drm/panel: Rocktech jh057n00900: Add terminating
 newlines to logging
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Apr 2019 11:55:17 -0700
In-Reply-To: <20190404170040.GA23897@ravnborg.org>
References: <cover.1554114302.git.agx@sigxcpu.org>
         <20190403161735.GN5238@ulmo>
         <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
         <20190404105359.GA8255@bogon.m.sigxcpu.org>
         <da6f2344396555034cf2476c8338b0ce1c56e0a7.camel@perches.com>
         <20190404170040.GA23897@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-04 at 19:00 +0200, Sam Ravnborg wrote:
> Hi Joe.
> 
> On Thu, Apr 04, 2019 at 08:06:09AM -0700, Joe Perches wrote:
> > These were missing '\n' terminations, add them.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > index 158a6d548068..d88ea8da2ec2 100644
> > --- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > +++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > @@ -123,7 +123,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
> >  
> >  	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> >  	if (ret < 0) {
> > -		DRM_DEV_ERROR(dev, "Failed to exit sleep mode");
> > +		DRM_DEV_ERROR(dev, "Failed to exit sleep mode\n");
> 
> I was under the impression that newlines was optional these days.
> Should we always use them with logging?

Yes.

The general problem is KERN_CONT/pr_cont uses where interleaving
is still possible from multiple threads.

> I did not find any obvious clues in linux/printk.h

I'll see about adding something one day to the Documentation.
Likely in coding-style.rst.



