Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076A0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA65F20700
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553462339;
	bh=eKgTUmPtDUGVNq9kEaQ0D/81uFrfvaP0/LdERMJleeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cf8080rRdtZvgnKt6LqYeCg/jBz8MFPZYZB+M3RCCQQQjcmk4z3JZA4FsJ5nnJoqW
	 mf+ZfGRmRap+1I/21euVp2X+btBP6nUqIkKJokzQPzlc9DbY0fJ170/vWzPFLS/k2Z
	 gsUr6JiO31uP+i8CiyZ6PCbgHpbdeEWc+F5MiSyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfCXVS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXVS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:18:58 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533F22148D;
        Sun, 24 Mar 2019 21:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553462337;
        bh=eKgTUmPtDUGVNq9kEaQ0D/81uFrfvaP0/LdERMJleeQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hc2drgg+HJ8aGthfPdjQSxevvM9/7WXpBhQzyT/hkTeeMWm+/lH8xRfZ+Wj16x/AY
         vGGGnjBwbBCx7Q1xshmbmSSZFI+CAyRw9GOqqCfCVdDRgGZ5Cd5Sc0UHAb8NXoLPpS
         alwJ0qJSmNI4AJIHeRgZJCS1WqbHShZMyOm1WAGo=
Received: by mail-qt1-f172.google.com with SMTP id y36so8185008qtb.3;
        Sun, 24 Mar 2019 14:18:57 -0700 (PDT)
X-Gm-Message-State: APjAAAU+n8kvCH530qSPluJLX5kfYfphX9f36FM7dAM5M6bfhNAM8qR5
        Uful/9LZAdA1kfThskGtlGWJeWSwWRc2jBC5Sg==
X-Google-Smtp-Source: APXvYqzeXvi+Thx3V6zOXH20G8AkRXshLAJUcIGXwweALGrtrTXak7HiSrNBBaCuE2TIn1y5Xsdcxp8AIYINoC/K5wE=
X-Received: by 2002:a0c:c11c:: with SMTP id f28mr15691236qvh.106.1553462336595;
 Sun, 24 Mar 2019 14:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190322194310.61365-1-dianders@chromium.org>
In-Reply-To: <20190322194310.61365-1-dianders@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 24 Mar 2019 16:18:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK=kt3k=eXn6uuHoRboWMqLFbnqAvAveVmOjOC0+MK5gw@mail.gmail.com>
Message-ID: <CAL_JsqK=kt3k=eXn6uuHoRboWMqLFbnqAvAveVmOjOC0+MK5gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: ARM: dts: rockchip: Add bindings for rk3288-veyron-mighty
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alexis Ballier <aballier@gentoo.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 2:43 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Mighty is basically the same Chromebook as Jaq but it has a full-sized
> SD slot and some different (slightly more rugged) plastics around it.
> Like Jaq, Mighty may show up with various different brandings but all
> of them have the same board inside.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
