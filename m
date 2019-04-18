Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219552183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbfDRJOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:14:05 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:43915 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfDRJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:14:04 -0400
X-Originating-IP: 90.88.160.238
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2ADDEFF813;
        Thu, 18 Apr 2019 09:13:58 +0000 (UTC)
Message-ID: <03187f79f37fdb45f3a774e200e21a29167776a8.camel@bootlin.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date:   Thu, 18 Apr 2019 11:13:57 +0200
In-Reply-To: <CAAFQd5Bou1abM4QMPFHqEcJnqGW7F1rZdAoLGmjZnVQTPh4WSw@mail.gmail.com>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
         <522d6a7734a29df47fe11f5f6311b49e14dabae0.camel@bootlin.com>
         <CAAFQd5Bou1abM4QMPFHqEcJnqGW7F1rZdAoLGmjZnVQTPh4WSw@mail.gmail.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-04-18 at 18:09 +0900, Tomasz Figa wrote:
> On Thu, Apr 18, 2019 at 5:55 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > Hi Daniel,
> > 
> > On Thu, 2019-04-18 at 10:18 +0200, Daniel Vetter wrote:
> > > On Wed, Apr 17, 2019 at 08:10:15PM +0200, Paul Kocialkowski wrote:
> > > > Hi Nicolas,
> > > > 
> > > > I'm detaching this thread from our V4L2 stateless decoding spec since
> > > > it has drifted off and would certainly be interesting to DRM folks as
> > > > well!
> > > > 
> > > > For context: I was initially talking about writing up support for the
> > > > Allwinner 2D engine as a DRM render driver, where I'd like to be able
> > > > to batch jobs that affect the same destination buffer to only signal
> > > > the out fence once when the batch is done. We have a similar issue in
> > > > v4l2 where we'd like the destination buffer for a set of requests (each
> > > > covering one H264 slice) to be marked as done once the set was decoded.
> > > > 
> 
> Out of curiosity, what area did you find a 2D blitter useful for?

The initial motivation is to bring up a DDX with that for platforms
that have 2D engines but no free software GPU drivers yet.

I also have a personal project in the works where I'd like to implement
accelerated UI rendering in 2D. The idea is to avoid using GL entirely.

That last point is in part because I have a GPU-less device that I want
to get going with mainline: http://linux-sunxi.org/F60_Action_Camera

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

