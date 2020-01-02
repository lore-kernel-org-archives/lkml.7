Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75CDC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9BE215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgABQVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:21:40 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:49852 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgABQVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:21:39 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id ECD25804DA;
        Thu,  2 Jan 2020 17:21:35 +0100 (CET)
Date:   Thu, 2 Jan 2020 17:21:34 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        boris.brezillon@bootlin.com, airlied@linux.ie,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        peda@axentia.se, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] fixes for atmel-hlcdc
Message-ID: <20200102162134.GA13454@ravnborg.org>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
 <20200102090554.GB29446@ravnborg.org>
 <20200102160534.GJ22390@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102160534.GJ22390@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=sy_eDPmhS6KF6TahjTwA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee.

> > >   ("drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested")
> > > 
> > > Claudiu Beznea (5):
> > >   drm: atmel-hlcdc: use double rate for pixel clock only if supported
> > >   drm: atmel-hlcdc: enable clock before configuring timing engine
> > 
> > >   mfd: atmel-hlcdc: add struct device member to struct
> > >     atmel_hlcdc_regmap
> > >   mfd: atmel-hlcdc: return in case of error
> > 
> > Would it be OK to apply the to drm-misc-next, or shal they go in via
> > your mfd tree?
> 
> How are they related to the other patches?  Do they have build-time
> dependencies on any of the other patches, or vice versa? 
No build time dependencies.

But from the description of "atmel-hlcdc: return in case of error":
"
For HLCDC timing engine configurations bit ATMEL_HLCDC_SIP of
ATMEL_HLCDC_SR needs to be polled before applying new config.
"
I get that changing timing for the HLCDC may fail if these
patches are not applied.
So it is only to have updated hlcdc support in drm-misc-next
for further testing.

	Sam
