Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E44BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F89215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfJCNVj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:21:39 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58653 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJCNVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:21:38 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 321258236F;
        Thu,  3 Oct 2019 13:21:35 +0000 (UTC)
Date:   Thu, 03 Oct 2019 21:21:30 +0800
In-Reply-To: <20191003131916.4bm22krapo5tz6oz@gilmour>
References: <20191001080253.6135-1-icenowy@aosc.io> <20191001080253.6135-2-icenowy@aosc.io> <CAMty3ZCjrM4MajJLyLwt-31mNnfVWghwatogtwVOvCt4gY0LZA@mail.gmail.com> <20191003131916.4bm22krapo5tz6oz@gilmour>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH 1/3] Revert "drm/sun4i: dsi: Change the start delay calculation"
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
CC:     David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <E0DBDA94-FA7C-4ED6-AE84-BE1FC5463C0E@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年10月3日 GMT+08:00 下午9:19:16, Maxime Ripard <mripard@kernel.org> 写到:
>On Thu, Oct 03, 2019 at 12:38:43PM +0530, Jagan Teki wrote:
>> On Tue, Oct 1, 2019 at 1:33 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>> >
>> > This reverts commit da676c6aa6413d59ab0a80c97bbc273025e640b2.
>> >
>> > The original commit adds a start parameter to the calculation of
>the
>> > start delay according to some old BSP versions from Allwinner.
>However,
>> > there're two ways to add this delay -- add it in DSI controller or
>add
>> > it in the TCON. Add it in both controllers won't work.
>> >
>> > The code before this commit is picked from new versions of BSP
>kernel,
>> > which has a comment for the 1 that says "put start_delay to tcon".
>By
>> > checking the sun4i_tcon0_mode_set_cpu() in sun4i_tcon driver, it
>has
>> > already added this delay, so we shouldn't repeat to add the delay
>in DSI
>> > controller, otherwise the timing won't match.
>>
>> Thanks for this change. look like this is proper reason for adding +
>> 1. also adding bsp code links here might help for future reference.
>>
>> Otherwise,
>>
>> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
>
>The commit log was better in this one. I ended up merging this one,
>with your R-b.

Please note that Jagan's v11 3/7 is still needed.

>
>Maxime

-- 
使用 K-9 Mail 发送自我的Android设备。
