Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BA1C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2F42087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfHSElB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:41:01 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:54342 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:41:01 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id DF6A080486;
        Mon, 19 Aug 2019 06:40:56 +0200 (CEST)
Date:   Mon, 19 Aug 2019 06:40:54 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     xinliang <z.liuxinliang@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>, xuyiping@hisilicon.com,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        lkml <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [RESEND][PATCH v3 00/26] drm: Kirin driver cleanups to prep for
 Kirin960 support
Message-ID: <20190819044054.GA8554@ravnborg.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
 <20190814194508.GA26866@ravnborg.org>
 <5D5A045C.5020707@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D5A045C.5020707@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=BTeA3XvPAAAA:8
        a=KKAkSRfTAAAA:8 a=e5mUnYsNAAAA:8 a=COxsePLIwNb3J7ku7MsA:9
        a=CjuIK1q_8ugA:10 a=tafbbOV3vt1XuEhzTjGK:22 a=cvBusfyB2V15izCimMoJ:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xinliang

> > As Maintainers can we please get some feedback from one of you.
> > Just an "OK to commit" would do it.
> > But preferably an ack or a review on the individual patches.
> 
> As I have done a pre-review and talked with the  author before sending out
> the patches.
> So, for this serial patches,
> Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>

Thanks!
We all know how it is to be busy, especially when trying to keep up
after role changes.
Unless someone beats me, then I will apply tonight or tomorrow.

> > If the reality is that John is the Maintainer today,
> > then we should update MAINTAINERS to reflect this.
> 
> I am assuming you are talking about the kirin[1] drm driver not the hibmc[2]
> one, right?
> I really appreciate John's awesome work at kirin drm driver all the way.
> Honestly, after my work change from mobile to server years ago, I am always
> waiting for some guy who is stably working at kirin drm driver to take the
> maintenance work.
> John, surely is a such guy.  Please add up a patch to update the maintainer
> as John, if John agree so.  Then John can push the patch set to drm
> maintainer himself.
> *Note* that the maintainer patch should break hisilicon drivers into kirin
> and hibmc two parts, like bellow:
> 
> DRM DRIVERS FOR HISILICON HIBMC
> M:  Xinliang Liu <z.liuxinliang@hisilicon.com>
> ...
> F:  drivers/gpu/drm/hisilicon/hibmc
> ...
> 
> DRM DRIVERS FOR HISILICON KIRIN
> M:  John Stultz <john.stultz@linaro.org>
> ...
> F:  drivers/gpu/drm/hisilicon/kirin
> ...
> 
> [1] drivers/gpu/drm/hisilicon/kirin # for kirin mobile display driver
> [2] drivers/gpu/drm/hisilicon/hibmc # for server VGA driver

Hi John

Up to the challenge?
If yes then please consider to apply for commit rights to drm-misc-next.

And read:
https://drm.pages.freedesktop.org/maintainer-tools/index.html

See this to get an account:
https://www.freedesktop.org/wiki/AccountRequests/

You will need an ssh account for drm-misc-next as it is not (yet?)
gitlab enabled.

	Sam
