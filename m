Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23B0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB3620833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FH2vMp2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfEPNnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:43:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36862 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:43:24 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 85D3E320;
        Thu, 16 May 2019 15:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1558014201;
        bh=R3GCz5NYOn5z9188GbAXj3i4ePg/ZQ54wfppbrWV8jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FH2vMp2irks66vtpBn2+2Xt8IBp/vU7Fdzrxj9RzOYh0WeeRePyDsk4qIKgO9j3lw
         aLaGOt7frAvZDQyAhjAscwZW0Cm+nfuigy54EjwiE2dC4P6JhD/wzhDupAsAfa+BIr
         Qa3+YAFyFohxmtPzUe1wzMvlM3ytBAeuvXA24IHE=
Date:   Thu, 16 May 2019 16:43:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        Souptick Joarder <jrdr.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Remove duplicate header
Message-ID: <20190516134304.GK14820@pendragon.ideasonboard.com>
References: <5cda6ee2.1c69fb81.2949b.d3e7@mx.google.com>
 <20190514073542.GA4969@pendragon.ideasonboard.com>
 <CAJr6mf0zy37MTuZQV2YLLQ7dY4a0r6LpSRTKByX0dBBfxuA4_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJr6mf0zy37MTuZQV2YLLQ7dY4a0r6LpSRTKByX0dBBfxuA4_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sabyasachi,

On Thu, May 16, 2019 at 06:45:04PM +0530, Sabyasachi Gupta wrote:
> On Tue, May 14, 2019 at 1:05 PM Laurent Pinchart wrote:
> > On Tue, May 14, 2019 at 01:01:41PM +0530, Sabyasachi Gupta wrote:
> > > Remove drm/drm_panel.h which is included more than once
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > > ---
> > >  drivers/gpu/drm/bridge/panel.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> > > index 7cbaba2..402b318 100644
> > > --- a/drivers/gpu/drm/bridge/panel.c
> > > +++ b/drivers/gpu/drm/bridge/panel.c
> > > @@ -15,7 +15,6 @@
> > >  #include <drm/drm_crtc_helper.h>
> > >  #include <drm/drm_encoder.h>
> > >  #include <drm/drm_modeset_helper_vtables.h>
> > > -#include <drm/drm_panel.h>
> >
> > Which tree is this against ? The patch applies on neither drm-next nor
> > drm-misc-next.
> >
> 
> It is against linux-next tree

You will likely have to rebase it on top of the drm-next or
drm-next-misc branch.

> > While at it, could you you reorder the other header alphabetically to
> > make this kind of issue easier to notice ?
>
> It is already arranged in alphabetical order

There's an #include <drm/drm_panel.h> at the top of the list of
includes. That's the one that is out of place.

> > >
> > >  struct panel_bridge {
> > >       struct drm_bridge bridge;

-- 
Regards,

Laurent Pinchart
