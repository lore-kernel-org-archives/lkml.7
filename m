Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED3FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4709220811
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553462467;
	bh=AhGng11S8GfKzejhbymBuQy17aRtxjxc8W9N9DD+CkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dbW1IsnUqioyB3xkLHD5R0eqBQG11fBlJeR2+Gb1OGYFlBa52mIahg0RdVmZsvhkt
	 XDxyfCXIYTAZj0dISNDnQ6rG+iSimJ34UTwH32CJP0ZMY+gjxu7RQwUIt/o4VRmHvF
	 g3jjg+8DRxiCh/UptaWL9dNeboJMyzMLug/0NeIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfCXVVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXVVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:21:06 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44134213F2;
        Sun, 24 Mar 2019 21:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553462465;
        bh=AhGng11S8GfKzejhbymBuQy17aRtxjxc8W9N9DD+CkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=in0uP12zH4L7hShnJRPZ2AgqcuTnJlcg8bTY6JDL3mBKp6zycQ1d00yKNp0jkQ4ls
         xaqdsH8hQ281H6uSeuA31aFLtWRNi+EuVzO96tC0Hraeq1CTfDCa+b2fCqArcuFtfZ
         57zzzi2mtiCoBnAHOKjMBanD52xUp1MQg0d4yOA0=
Received: by mail-qt1-f173.google.com with SMTP id w30so8150002qta.8;
        Sun, 24 Mar 2019 14:21:05 -0700 (PDT)
X-Gm-Message-State: APjAAAVNCC9PcBbcjvUj5GTYOq8x7x8rrDco5mGOAPbKCHwAaZTY00vZ
        UjLVwXVMt9QG3GZUVnxUWUdtxagg4HSGlB3oDw==
X-Google-Smtp-Source: APXvYqyGnNP5triHg/9bbns7Hc/kutIfzz4/fhkW/ZPtju/TYKVEwMWv0jTgMyL0cAu0vkn9LyY4R17aYtR8hLpEH4Y=
X-Received: by 2002:a0c:8685:: with SMTP id 5mr7485792qvf.246.1553462464518;
 Sun, 24 Mar 2019 14:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190322195924.70448-1-dianders@chromium.org>
In-Reply-To: <20190322195924.70448-1-dianders@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 24 Mar 2019 16:20:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKYH1yNE1vjppWirn13O0HawKCmveDAaHpgYuFxCwp_hw@mail.gmail.com>
Message-ID: <CAL_JsqKYH1yNE1vjppWirn13O0HawKCmveDAaHpgYuFxCwp_hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: ARM: dts: rockchip: Add
 rk3288-veyron-jerry rev 10-15
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alexis Ballier <aballier@gentoo.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 2:59 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> As far as I can tell/remember rev10 was originally created to support
> making a SKU of jerry that had a different LCD.  rev11-rev15 were
> added to give some wiggle room for future builds.  Downstream has a
> separate device tree for rev10-rev15 (compared to rev3-rev7) with the
> expectation that differences relating to the LCD would be accounted
> for there but nothing was ever added to the rev10-rev15 making it
> identical to the rev3-rev7 one.
>
> It's likely nothing actually shipped with rev10-rev15 but they are
> listed in the downstream kernel's device tree and it seems like it
> should add a little safety if we match them here just in case
> something actually shipped with one of these revisions and that device
> will break if we don't claim support.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
