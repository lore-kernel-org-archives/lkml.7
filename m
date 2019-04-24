Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D204CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE920652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfDXSLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:11:39 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:33151 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387908AbfDXRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:36 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 67B0B200A7;
        Wed, 24 Apr 2019 19:13:34 +0200 (CEST)
Date:   Wed, 24 Apr 2019 19:13:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        YiPing Xu <xuyiping@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [PATCH 00/25] drm: Kirin driver cleanups to prep for Kirin960
 support
Message-ID: <20190424171333.GA21290@ravnborg.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=IGTIv24Nbv7dL3wi-kUA:9 a=EWHTBGwkDhwldNGC:21 a=VLI2K6fxoBHR71k2:21
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

On Tue, Apr 23, 2019 at 04:20:31PM -0700, John Stultz wrote:
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
I have been through all 25 patches and it triggered a few minor
comments here and there.
I know nothing about the hisilicon driver but based on the fact
that I know nothing about the driver you can give them all
a (smallish)
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I trust your judgement to decide the feedback you want to address and
what to ignore.

One request:
Could you please in a follow-up patch kill the use of drmP.h.
We want to get rid of it one day and three fewer users are one
small step towards this goal.

Thanks,

	Sam
