Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386EC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E141D212F5
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfF3UzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 16:55:19 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36638 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfF3UzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 16:55:19 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 73E048032E;
        Sun, 30 Jun 2019 22:55:15 +0200 (CEST)
Date:   Sun, 30 Jun 2019 22:55:14 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, mka@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override
 typical timing
Message-ID: <20190630205514.GA17046@ravnborg.org>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org>
 <20190630202246.GB15102@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630202246.GB15102@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=zWgoevcLopjZgIZCDrAA:9 a=kLCGM-lqtgZHwNan:21 a=6SVaLwYTUbKinDPI:21
        a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas.

> > +
> > +	/* Only add timings if override was not there or failed to validate */
> > +	if (num == 0 && panel->desc->num_timings)
> > +		num = panel_simple_get_timings_modes(panel);
> > +
> > +	/*
> > +	 * Only add fixed modes if timings/override added no mode.
> 
> This part I fail to understand.
> If we have a panel where we in panel-simple have specified the timings,
> and done so using display_timing so with proper {min, typ, max} then it
> should be perfectly legal to specify a more precise variant in the DT
> file.
> Or what did I miss here?

Got it now.
If display_mode is used for timings this is what you call "fixed mode".
Hmm, if I got confused someone else may also be confused by this naming.

	Sam
