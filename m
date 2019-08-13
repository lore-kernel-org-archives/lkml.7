Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40241C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2420663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfHMIJB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:09:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42606 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfHMIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:09:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so16918005qtp.9;
        Tue, 13 Aug 2019 01:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3QYn8xVPbDnU8yCH5QG2DkGvPPJ9yAG+CBaSbT63l5s=;
        b=iJneErmhHSA8ngZdte/oUIlKi1cEx3iAt6/kzCBDMCiaSipNogDSey8W6B4iGCRlyA
         KFy+B4v1nZx5a9vJGASB5T2/ZWSlz8kzQPhvv6Q5ZtlHCHD731eh5zaOw1zb5l4Lri3p
         YXHvyuR5DwwZ9f8dbL5ivYK7FrAngXHApqsQ37UzcJZNf4OSLMjoeFAorRC0khw8hO2i
         dIeUK45MdzPXqEVWex2gWldGPy+DNrrNaR91PSo6WTvtA6MccaM5JhxXhaFLjmh/qQXu
         h7SS2WQvcnCM/veU0ZZCvyntl5jOuH6UoJcx6728wYojyGenroTW/NqeM8Qb9i51rgWg
         wMSQ==
X-Gm-Message-State: APjAAAXPmfBwZRWcrCtTeC2+aBEcPuZdfpgpGYDfJtiQHlxa4XuBhEDa
        PuQLdPwMZ1/tF06z8UnYRqGhsHOgw0QLTYuIpzY=
X-Google-Smtp-Source: APXvYqzQY3jw5cidojWGquR6Ywd0UV4rVnIr4Q175ebPJlWm5I+ETbY/lAleI6WDMLSOu84QmW6hk+yfSbxvjbk+0xI=
X-Received: by 2002:ac8:117:: with SMTP id e23mr17771674qtg.18.1565683740433;
 Tue, 13 Aug 2019 01:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565367567.git.agx@sigxcpu.org> <e0562d8bb4098dc4cdb4023b41fb75b312be22a5.1565367567.git.agx@sigxcpu.org>
In-Reply-To: <e0562d8bb4098dc4cdb4023b41fb75b312be22a5.1565367567.git.agx@sigxcpu.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Aug 2019 10:08:44 +0200
Message-ID: <CAK8P3a3Vrd+sttJrQwD-jA9p_egG4x-hc41eGK8H-_aVm-uoYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: imx8mq: add imx8mq iomux-gpr field defines
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 6:24 PM Guido Günther <agx@sigxcpu.org> wrote:
>
> This adds all the gpr registers and the define needed for selecting
> the input source in the imx-nwl drm bridge.
>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> +
> +#define IOMUXC_GPR0    0x00
> +#define IOMUXC_GPR1    0x04
> +#define IOMUXC_GPR2    0x08
> +#define IOMUXC_GPR3    0x0c
> +#define IOMUXC_GPR4    0x10
> +#define IOMUXC_GPR5    0x14
> +#define IOMUXC_GPR6    0x18
> +#define IOMUXC_GPR7    0x1c
(more of the same)

huh?

> +/* i.MX8Mq iomux gpr register field defines */
> +#define IMX8MQ_GPR13_MIPI_MUX_SEL              BIT(2)

I think this define should probably be local to the pinctrl driver, to
ensure that no other drivers fiddle with the registers manually.

     Arnd
