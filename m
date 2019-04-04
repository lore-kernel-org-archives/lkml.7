Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79900C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CB32075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfDDTJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:09:07 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:37960 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfDDTJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:09:06 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5BB1D20025;
        Thu,  4 Apr 2019 21:09:00 +0200 (CEST)
Date:   Thu, 4 Apr 2019 21:08:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joe Perches <joe@perches.com>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
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
Subject: Re: [PATCH] drm/panel: Rocktech jh057n00900: Add terminating
 newlines to logging
Message-ID: <20190404190858.GA8008@ravnborg.org>
References: <cover.1554114302.git.agx@sigxcpu.org>
 <20190403161735.GN5238@ulmo>
 <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
 <20190404105359.GA8255@bogon.m.sigxcpu.org>
 <da6f2344396555034cf2476c8338b0ce1c56e0a7.camel@perches.com>
 <20190404170040.GA23897@ravnborg.org>
 <ab5f36952d2125f5ed9706aa58b64ab10fecf531.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab5f36952d2125f5ed9706aa58b64ab10fecf531.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=Wvc7zV2IR4HhXB_Na8QA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe.

> > >  
> > >  	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> > >  	if (ret < 0) {
> > > -		DRM_DEV_ERROR(dev, "Failed to exit sleep mode");
> > > +		DRM_DEV_ERROR(dev, "Failed to exit sleep mode\n");
> > 
> > I was under the impression that newlines was optional these days.
> > Should we always use them with logging?
> 
> Yes.
> 
> The general problem is KERN_CONT/pr_cont uses where interleaving
> is still possible from multiple threads.
> 
> > I did not find any obvious clues in linux/printk.h
> 
> I'll see about adding something one day to the Documentation.
> Likely in coding-style.rst.

Thanks for the clarification.
A seperate doc on logging would be awesome.

	Sam
