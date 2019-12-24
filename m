Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1841EC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99C9206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfLXLlK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:41:10 -0500
Received: from hermes.aosc.io ([199.195.250.187]:43186 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfLXLlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:41:10 -0500
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Dec 2019 06:41:10 EST
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 198A945CC4;
        Tue, 24 Dec 2019 11:35:39 +0000 (UTC)
Date:   Tue, 24 Dec 2019 19:35:36 +0800
In-Reply-To: <CAFBinCCDmCHQW+nBHzsodz0R=GKoqv1EEzB=UY=ypFs4Q6MFmQ@mail.gmail.com>
References: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com> <20191216154803.GA3921@kevin> <CAFBinCCDmCHQW+nBHzsodz0R=GKoqv1EEzB=UY=ypFs4Q6MFmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [Lima] [RFC v1 0/1] drm: lima: devfreq and cooling device support
To:     lima@lists.freedesktop.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
CC:     robh@kernel.org, tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        steven.price@arm.com, linux-rockchip@lists.infradead.org,
        wens@csie.org, yuq825@gmail.com, daniel@ffwll.ch,
        linux-amlogic@lists.infradead.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <54FE8BA3-BB70-4411-9FD9-4AE460097A95@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年12月24日 GMT+08:00 下午7:28:41, Martin Blumenstingl <martin.blumenstingl@googlemail.com> 写到:
>Hi Alyssa,
>
>On Mon, Dec 16, 2019 at 4:48 PM Alyssa Rosenzweig
><alyssa.rosenzweig@collabora.com> wrote:
>>
>> If so much code is being duplicated over, I'm wondering if it makes
>> sense for us to move some of the common devfreq code to core DRM
>> helpers?
>if you have any recommendation where to put it then please let me know
>(I am not familiar with the DRM subsystem at all)
>
>my initial idea was that the devfreq logic needs the same information
>that the scheduler needs (whether we're submitting something to be
>executed, there was a timeout, ...).
>however, looking at drivers/gpu/drm/scheduler/ this seems pretty
>stand-alone so I'm not sure it should go there
>also the Mali-4x0 GPUs have some "PMU" which *may* be used instead of

It's optional. We cannot promise its existance on a given
hardware, and I heard that at least on Allwinner H5 Mali PMU
is broken.

>polling the statistics internally
>so this is where I realize that with my current knowledge I don't know
>enough about lima, panfrost, DRM or the devfreq subsystem to get a
>good idea where to put the code.
>
>
>Martin
>_______________________________________________
>lima mailing list
>lima@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/lima

-- 
使用 K-9 Mail 发送自我的Android设备。
