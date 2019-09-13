Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91126C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A8820644
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfIMIVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:21:34 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42672 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbfIMIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:21:34 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 2568725AEB1;
        Fri, 13 Sep 2019 18:21:32 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 167D9940513; Fri, 13 Sep 2019 10:21:30 +0200 (CEST)
Date:   Fri, 13 Sep 2019 10:21:29 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: rcar-du: Add r8a77980 support
Message-ID: <20190913082129.lvusbp6pbcayqh5r@verge.net.au>
References: <20190911192502.16609-1-kieran.bingham+renesas@ideasonboard.com>
 <70b94265-69f3-d18f-1b67-b5b814723b1b@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b94265-69f3-d18f-1b67-b5b814723b1b@cogentembedded.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 01:00:41PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 11.09.2019 22:25, Kieran Bingham wrote:
> 
> > Add direct support for the r8a77980 (V3H).
> > 
> > The V3H shares a common, compatible configuration with the r8a77970
> > (V3M) so that device info structure is reused.
> 
>    Do we really need to add yet another compatible in this case?
> I just added r8a77970 to the compatible prop in the r8a77980 DT. That's why
> a patch like this one didn't get posted by me.

The reason for having per-SoC compat strings is that the IP blocks
are not versioned and while we can observe that there are similarities
between, f.e. the DU on the r8a77970 and r8a77980, we can't be certain that
differences may not emerge at some point. By having per-SoC compat strings
we have the flexibility for the driver to address any such differences as
the need arises.

My recollection is that this scheme has been adopted for non-versioned
Renesas IP blocks since June 2015 and uses of this scheme well before that.

> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> [...]
> 
> MBR, Sergei
> 
