Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC2FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AB1206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbfDXQ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:56:33 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:60762 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfDXQ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:56:32 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7107B20067;
        Wed, 24 Apr 2019 18:56:30 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:56:29 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [PATCH 02/25] drm: kirin: Remove HISI_KIRIN_DW_DSI config option
Message-ID: <20190424165629.GA21067@ravnborg.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-3-git-send-email-john.stultz@linaro.org>
 <20190424163908.GB20110@ravnborg.org>
 <CALAqxLXeU7skJiy2J4ZYOFtym6pDUuzY3QT+e3F1D8jE4pYC0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXeU7skJiy2J4ZYOFtym6pDUuzY3QT+e3F1D8jE4pYC0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=zDsAw1fcauD1RcUsUdMA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

> >
> > Nice simplification. We are now down to two very small Kconfig files.
> > Consider to merge them into one Kconfig file in the top-level dir.
> >
> 
> Part of this cleanup is so that we can add another device option in a
> later commit (though not in this series), so unless folks are
> generally wanting to consolidate Kconfigs into the top level, it may
> be premature to do so now only to later undo it when there are more
> kirin specific options. I'm fine with whichever, I just want to make
> sure that's clear.
I am just passing my reflections forward in a mail as I read the
patches.
Unless there is something that resemble a real bug then always do what
you consider best. In this case keep the two Kconfig files.

	Sam
