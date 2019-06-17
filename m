Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF28C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1BC2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfFQOz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:55:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33716 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFQOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:55:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id x2so11073965qtr.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLt9ZHlsi0Mo2ZjZlBll3f1E3rXQj8ngnIQB0JKvcQ8=;
        b=gMh4660+KviTRCOboPishI78lXOsLjIn8Sh9g8+Q046HGy/mw315yPLEfHrJitYUju
         gHE2e9Y7A05LQadQpvAG/RYjpONHaLOjnynMKk3uSySTjBIKYjVvhYtNp05j8wPIH+zO
         nylEeg/+BPzkodiXsAP1T3HicHbXtUIHKssmapPwerdW+WP16p7EZo0lkoEh1Xq8yj5w
         EQXXuS8owQyZO68QGjt67li2wx1IugB89+GM55Y8EVBRpJlKezIRuqjXSpuFpU9p0r9Y
         e5sfJD9EjYBNsP3TBSRWXKdvs77IV00TKbnnHWup5Ht7+RdlBbLcR1XGvHjtjD/VWKHe
         h3kw==
X-Gm-Message-State: APjAAAUvmQj9CZaG0Dgj8fcAX0ABuDqR1V6fnVI+IO3ItdNQIngqwyWx
        6Hd0mhwLDloGcXksM+e6HWT1d4XKfpkDNT5w34m6ZI7z
X-Google-Smtp-Source: APXvYqx3pBYXn/aH9OmUnV1E8DvaJlX+VwTvOQB7RTbuTrROkMdV/xIuWGgCG5AUexpYMZQTA9GZIYm4cMyrwmEQCVE=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr60323126qtd.18.1560783357568;
 Mon, 17 Jun 2019 07:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190617123915.926526-1-arnd@arndb.de> <20190617144109.GA14528@ravnborg.org>
In-Reply-To: <20190617144109.GA14528@ravnborg.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 16:55:40 +0200
Message-ID: <CAK8P3a2tPrYxDpP7EU34=+N3P5+jwSX4XkA1AV6K-YYCQNt_sw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: include missing linux/delay.h
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Lim <Thomas.Lim@amd.com>,
        Eric Yang <eric.yang2@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tony Cheng <tony.cheng@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 4:41 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Jun 17, 2019 at 02:38:55PM +0200, Arnd Bergmann wrote:
> > Some randconfig builds fail to compile the dcn10 code because of
> > a missing declaration:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function 'dcn10_apply_ctx_for_surface':
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
> >
> > Include the appropriate kernel header.
> >
> > Fixes: 9ed43ef84d9d ("drm/amd/display: Add Underflow Asserts to dc")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > index 1ac9a4f03990..d87ddc7de9c6 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > @@ -22,6 +22,7 @@
> >   * Authors: AMD
> >   *
> >   */
> > +#include <linux/delay.h>
> >
> >  #include <linux/delay.h>
> >  #include "dm_services.h"
>
> Something has gone wrong here, as you add a second include of linux/delay.h.
>
> We had this problem before, which Alex fixed by applying a patch to
> include linux/delay.h

My mistake, sorry about that. I had written and tested the patch on
last week's linux-next ernel and sent it out today after rebasing it, but did
not closely look at the resulting patch after the rebase.

           Arnd
