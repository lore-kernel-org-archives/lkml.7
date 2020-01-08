Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C56C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C9A20678
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578470374;
	bh=O4Amm0qb2RUINtvaLuluBzRmt873weGN6kdJZSo05ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ikE3u5zLQrQX6Io97vUbMZ8VLoyyszUPRL67fsZjr+TSQms36Egqf6xn9jTXAI3Uq
	 oQgdUFMjjEgSd0cT7txy+QIs3SudRqV1bInw97BRISLrD/xpfUv3MN5miKF/+qFOvc
	 jUWqXwRj1y+jfZJHp+e6HF6WBzKQt2YSul0OseVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgAHH7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:59:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45690 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:59:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so1759909edw.12;
        Tue, 07 Jan 2020 23:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cMtj+4fElMhagL+EzReN9239oHGv4iNUyK/a8PqjjnQ=;
        b=KRjfhBH8Wc/RMzHhToQAuXOzWc3MF4+h308/OcV8JMfPTg4hy1iYM9Pqba4BkN5Yei
         64LuyHhOPmgfZYi/TN1WmRPhL1khGd5JYU0MZ44yQk2PjSsnvXMI7D7XsBfWLM4GY/ym
         D8+zLqJFKhMG+I8LBBI8C69k4Vzo3Te+/matx6IiCeBVf8Di/ohkl5me3V9f0o7o76R7
         WhY6229nSyJOsTMzWRmw+PWFkotLkWtHcEuXQiiftOT9h/Q7RFs7gvLXb1fpa6Z2siLS
         M88TaEzgAS8V87YuaMJv4l1spnZifYn3mYdiuhal+PSYv2olNH+ajG/Xn1tcORT6Sigj
         0prw==
X-Gm-Message-State: APjAAAUNZeoRdsfGnw0nCNQqrdTh9Y3UN1e9AjXQojpzi4kjF+LFJPQF
        Up6qKXgHdkP1a8eA0FYqh8c=
X-Google-Smtp-Source: APXvYqx1oeIDihha1MbvAq15cZlBUGgIhGRDf0dk1K6ypd+mZhyiUjjB1ZsQjTlzbZgvEOTKZctg/A==
X-Received: by 2002:a17:906:1d50:: with SMTP id o16mr3510203ejh.111.1578470371251;
        Tue, 07 Jan 2020 23:59:31 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id bm18sm58278edb.97.2020.01.07.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 23:59:30 -0800 (PST)
Date:   Wed, 8 Jan 2020 08:59:28 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: exynos: tiny4412: add proper panel node
Message-ID: <20200108075928.GA9911@pi3>
References: <20200106191003.21584-1-tiny.windzz@gmail.com>
 <20200106191003.21584-2-tiny.windzz@gmail.com>
 <20200107090449.GA32007@pi3>
 <CAEExFWvJx82h1c1QBrQ+DpT4kgEZ0o3q_O7JLbk-1L-iuMGPEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEExFWvJx82h1c1QBrQ+DpT4kgEZ0o3q_O7JLbk-1L-iuMGPEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 03:07:25AM +0800, Frank Lee wrote:
> On Tue, Jan 7, 2020 at 5:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Mon, Jan 06, 2020 at 07:10:03PM +0000, Yangtao Li wrote:
> > > This patch add at070tn92 panel for tiny4412 board.
> >
> > Please fix description as in patch 1.
> >
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/exynos4412-tiny4412.dts | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> > > index 2b62cb27420c..57f9d09233ad 100644
> > > --- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
> > > +++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> > > @@ -66,6 +66,16 @@
> > >                       clock-frequency = <24000000>;
> > >               };
> > >       };
> > > +
> > > +     panel {
> > > +             compatible = "innolux,at070tn92";
> > > +
> > > +             port {
> > > +                     panel_input: endpoint {
> > > +                             remote-endpoint = <&lcdc_output>;
> > > +                     };
> > > +             };
> > > +     };
> > >  };
> > >
> > >  &fimd {
> > > @@ -74,6 +84,12 @@
> > >       #address-cells = <1>;
> > >       #size-cells = <0>;
> > >       status = "okay";
> >
> > One empty space here.
> >
> > > +     port@3 {
> > > +             reg = <3>;
> >
> > Why starting from "3"? Why this is port@3, not just "port"?
> 
> From samsung-fimd.txt:
> ---
> The device node can contain 'port' child nodes according to the bindings defined
> in [2]. The following are properties specific to those nodes:
> - reg: (required) port index, can be:
>                 0 - for CAMIF0 input,
>                 1 - for CAMIF1 input,
>                 2 - for CAMIF2 input,
>                 3 - for parallel output,
>                 4 - for write-back interface
> ---
> 
> I guess it is influenced here.
> https://elixir.bootlin.com/linux/v5.5-rc5/source/drivers/gpu/drm/exynos/exynos_drm_dpi.c#L170
> Without it, lcd is completely black.

Thanks for explanation.

Best regards,
Krzysztof

