Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDBECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8F92133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570469411;
	bh=7BgONx2fxTCBerkz+kZbipHG1ITh4B74FEdi9hVq484=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CBqk9k2m1g7swblnobYftjHGvnOrTvRd1zuEwy/SQqu96MzqliueMVoeSw9FcodnZ
	 vIc4c9tKZgjWZVpVpXrH4dKhlHDqF2/u1piNgsPL0sX77SRGff1NGoWC7RKqeUifxr
	 nrWVpytbLEcD5L3ttw+yY2c0xQWNyRhhdiUzOP2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfJGRaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGRaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:30:08 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F5A22173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570469407;
        bh=7BgONx2fxTCBerkz+kZbipHG1ITh4B74FEdi9hVq484=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qWQvAQdNF/Y5LcuOkgQNFbrOYyT9zV8nGvQWGIalDCdrCIVR6/XSgL48CyNJqeOpW
         wkoJhtMz7y3IYD01mP1Wrjl9bN977MFW9mehzUiNsgxus43IHZn6NsBgmCM2nRA94W
         gP8kq+CEaHsP6v680i7rvL8uFTY1XraSbw5To80E=
Received: by mail-lj1-f173.google.com with SMTP id y23so14558468lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:30:07 -0700 (PDT)
X-Gm-Message-State: APjAAAUEXsBmq6UD0+x2AXtE0pquXoBZ5hFoXckRWwdW6D/qg5dNtINc
        KcBen6zGoUXLZ4jPudy6/C273vmEjUWCOzTZDfQ=
X-Google-Smtp-Source: APXvYqwmBhQ/7r1sccn69bdteEM2oYrlVQ4Im2gzzv/FHBYneH2khccdbHlxPWXIpivEwoFLYEN1637fU1HLJrcElvg=
X-Received: by 2002:a2e:9159:: with SMTP id q25mr376354ljg.225.1570469405263;
 Mon, 07 Oct 2019 10:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191004144549.3567-1-krzk@kernel.org> <87sgo4hjii.fsf@intel.com> <CADnq5_MqGehpWwOAxYg0T2x3qXisqmae2uGG5dijQX+Aa4NsoQ@mail.gmail.com>
In-Reply-To: <CADnq5_MqGehpWwOAxYg0T2x3qXisqmae2uGG5dijQX+Aa4NsoQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 7 Oct 2019 19:29:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeVFeSDpxPv-rDywCafWbN3mivtcM3UQX_+wZkyPcZwPQ@mail.gmail.com>
Message-ID: <CAJKOXPeVFeSDpxPv-rDywCafWbN3mivtcM3UQX_+wZkyPcZwPQ@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL v2] gpu: Fix Kconfig indentation
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 at 18:09, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Oct 7, 2019 at 7:39 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Fri, 04 Oct 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >  drivers/gpu/drm/i915/Kconfig             |  12 +-
> > >  drivers/gpu/drm/i915/Kconfig.debug       | 144 +++++++++++------------
> >
> > Please split these out to a separate patch. Can't speak for others, but
> > the patch looks like it'll be conflicts galore and a problem to manage
> > if merged in one big lump.
>
> Yes, it would be nice to have the amd patch separate as well.

I'll split the AMD and i915 although I am not sure if it is sense to
split such trivial patch per each driver.

Best regards,
Krzysztof
