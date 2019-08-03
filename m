Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB4DC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA92D206C1
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfHCORs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 10:17:48 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:51690 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfHCORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 10:17:47 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 56B8820024;
        Sat,  3 Aug 2019 16:17:43 +0200 (CEST)
Date:   Sat, 3 Aug 2019 16:17:42 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 00/26] drm: Kirin driver cleanups to prep for Kirin960
 support
Message-ID: <20190803141742.GA21935@ravnborg.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=KKAkSRfTAAAA:8
        a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=7gkXJVJtAAAA:8 a=BTeA3XvPAAAA:8
        a=mm5y-ppz5zUS1jQs-MMA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=tafbbOV3vt1XuEhzTjGK:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

On Thu, Aug 01, 2019 at 03:44:13AM +0000, John Stultz wrote:
> I was reminded I had sent this out a few months ago, but forgot
> all about it! Apologies! Anyway, I wanted to resubmit this patch
> set so I didn't have to continue carrying it forever to keep the
> HiKey960 board running.
> 
> This patchset contains one fix (in the front, so its easier to
> eventually backport), and a series of changes from YiPing to
> refactor the kirin drm driver so that it can be used on both
> kirin620 based devices (like the original HiKey board) as well
> as kirin960 based devices (like the HiKey960 board).
> 
> The full kirin960 drm support is still being refactored, but as
> this base kirin rework was getting to be substantial, I wanted
> to send out the first chunk for some initial review, so that the
> review burden wasn't overwhelming.
> 
> The full HiKey960 patch stack can be found here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey960-mainline-WIP
> 
> 
> Feedback would be greatly appreciated!
> 
> thanks
> -john
> 
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>

I am missing: Xinliang Liu <z.liuxinliang@hisilicon.com>
in your list of recipients.

Xinliang is listed at one of the maintainers of
hisilicon/

	Sam
