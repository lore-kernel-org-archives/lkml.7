Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24FACA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAB3205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674881;
	bh=Y7oaW/0nI72JG2ZWy1YcBEZ9QdOG7gwptvk2YsxdDrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S12IIXwxg6r+BGgUN6TN1QSa00fL3U20dkp6WIYnMiniuqal3G8IJWoynIzo1xsph
	 Mh5x0JhK500hJpJLrIsrGU61CRxLpPkU/CCiMUX4xlZ9FlxBvLvMVa7FO4PuAurCU6
	 rE2sf8zvhHtqc0H5qzJHu4hUCjH9GVRpIW73IxCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfJUQVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:21:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44483 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:21:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id r16so10452837edq.11;
        Mon, 21 Oct 2019 09:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7kXhyBYin2hNshrQsLbIqexvEmaaX5JxfmgulPDAhs=;
        b=CGr9u20Eu4lRUt+v0PYZHqyWvsAmExvqOXoupAx41lYGj2F5fY1Xz29lqY/18b1Nf1
         m1CBj5ETQ3XlPpUS+9nbmDuh44fkeGHJuX8Ab1xezRLekjUd1t8qxFRYC5gE32F0MHR9
         eVfRGZm2PVKM5FwaNDtaY/M/jFpUk45Fpfp6DOJQspMZonQnvyALEwoMeHRLBUVbrlJj
         L1oQDju4Djah1aAkkMrfFn50VibZ2ZV4qPIYXFMdE3/Eu+GV2xzpYO8+Uh35xo1WW8Eo
         fM9ikHCwiVJUSEjfaGcvpr4KAxFRl2hVzMCPW8oPTw/AddDwqmaiyNqcYAJXGi3xjYf6
         O0NA==
X-Gm-Message-State: APjAAAUOpcPwJO4PEXTpXJDsdizazoWfhlXnxqiH5NJCCo3GHBsGkJQN
        VHDZTsJAP6x+QSlEhAH5ZWs=
X-Google-Smtp-Source: APXvYqzJjaDGk3bh7Rvx5mKz/l/mNrNxKhU6SPIZK78xraCXfMm3Bl9vspYovV2bf8f1O66wvaY1DQ==
X-Received: by 2002:aa7:d915:: with SMTP id a21mr26132055edr.46.1571674877915;
        Mon, 21 Oct 2019 09:21:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id s4sm363303edt.34.2019.10.21.09.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 09:21:17 -0700 (PDT)
Date:   Mon, 21 Oct 2019 18:21:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alim Akhtar <alim.akhtar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: Rename children of SysRAM node to
 "sram"
Message-ID: <20191021162115.GA21883@kozik-lap>
References: <20191021151440.13505-1-krzk@kernel.org>
 <CAGOxZ531SdYcud3nQ-6hbCRZptUYznTRajVyxwEi-mFmm8-zPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGOxZ531SdYcud3nQ-6hbCRZptUYznTRajVyxwEi-mFmm8-zPg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:37:24PM +0530, Alim Akhtar wrote:
> On Mon, Oct 21, 2019 at 8:45 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > The device node name should reflect generic class of a device so rename
> > the children of SysRAM node to "smp-sysram".  This will be also in sync
> Typo "smp-sram"

Thanks, indeed.

> > with upcoming DT schema.  No functional change.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> Looks good to me.

Shall I add your review-tag?

Best regards,
Krzysztof


> 
> >  arch/arm/boot/dts/exynos3250.dtsi               | 4 ++--
> >  arch/arm/boot/dts/exynos4210-universal_c210.dts | 6 +++---
> >  arch/arm/boot/dts/exynos4210.dtsi               | 4 ++--
> >  arch/arm/boot/dts/exynos4412.dtsi               | 4 ++--
> >  arch/arm/boot/dts/exynos5250.dtsi               | 4 ++--
> >  arch/arm/boot/dts/exynos54xx.dtsi               | 4 ++--
> >  6 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> > index b016b0b68306..044e5da64a76 100644
> > --- a/arch/arm/boot/dts/exynos3250.dtsi
> > +++ b/arch/arm/boot/dts/exynos3250.dtsi
> > @@ -145,12 +145,12 @@
> >                         #size-cells = <1>;
> >                         ranges = <0 0x02020000 0x40000>;
> >
> > -                       smp-sysram@0 {
> > +                       smp-sram@0 {
> >                                 compatible = "samsung,exynos4210-sysram";
> >                                 reg = <0x0 0x1000>;
> >                         };
> >
> > -                       smp-sysram@3f000 {
> > +                       smp-sram@3f000 {
> >                                 compatible = "samsung,exynos4210-sysram-ns";
> >                                 reg = <0x3f000 0x1000>;
> >                         };
> > diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > index 09d3d54d09ff..a1bdf7830a87 100644
> > --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > @@ -590,16 +590,16 @@
> >  };
> >
> >  &sysram {
> > -       smp-sysram@0 {
> > +       smp-sram@0 {
> >                 status = "disabled";
> >         };
> >
> > -       smp-sysram@5000 {
> > +       smp-sram@5000 {
> >                 compatible = "samsung,exynos4210-sysram";
> >                 reg = <0x5000 0x1000>;
> >         };
> >
> > -       smp-sysram@1f000 {
> > +       smp-sram@1f000 {
> >                 status = "disabled";
> >         };
> >  };
> > diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> > index 554819ae1446..b4466232f0c1 100644
> > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > @@ -79,12 +79,12 @@
> >                         #size-cells = <1>;
> >                         ranges = <0 0x02020000 0x20000>;
> >
> > -                       smp-sysram@0 {
> > +                       smp-sram@0 {
> >                                 compatible = "samsung,exynos4210-sysram";
> >                                 reg = <0x0 0x1000>;
> >                         };
> >
> > -                       smp-sysram@1f000 {
> > +                       smp-sram@1f000 {
> >                                 compatible = "samsung,exynos4210-sysram-ns";
> >                                 reg = <0x1f000 0x1000>;
> >                         };
> > diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> > index 5022aa574b26..48868947373e 100644
> > --- a/arch/arm/boot/dts/exynos4412.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412.dtsi
> > @@ -195,12 +195,12 @@
> >                         #size-cells = <1>;
> >                         ranges = <0 0x02020000 0x40000>;
> >
> > -                       smp-sysram@0 {
> > +                       smp-sram@0 {
> >                                 compatible = "samsung,exynos4210-sysram";
> >                                 reg = <0x0 0x1000>;
> >                         };
> >
> > -                       smp-sysram@2f000 {
> > +                       smp-sram@2f000 {
> >                                 compatible = "samsung,exynos4210-sysram-ns";
> >                                 reg = <0x2f000 0x1000>;
> >                         };
> > diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> > index e1f0215e3985..ec983283f573 100644
> > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > @@ -171,12 +171,12 @@
> >                         #size-cells = <1>;
> >                         ranges = <0 0x02020000 0x30000>;
> >
> > -                       smp-sysram@0 {
> > +                       smp-sram@0 {
> >                                 compatible = "samsung,exynos4210-sysram";
> >                                 reg = <0x0 0x1000>;
> >                         };
> >
> > -                       smp-sysram@2f000 {
> > +                       smp-sram@2f000 {
> >                                 compatible = "samsung,exynos4210-sysram-ns";
> >                                 reg = <0x2f000 0x1000>;
> >                         };
> > diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
> > index f78dee801cd9..8aa5117e58ce 100644
> > --- a/arch/arm/boot/dts/exynos54xx.dtsi
> > +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> > @@ -62,12 +62,12 @@
> >                         #size-cells = <1>;
> >                         ranges = <0 0x02020000 0x54000>;
> >
> > -                       smp-sysram@0 {
> > +                       smp-sram@0 {
> >                                 compatible = "samsung,exynos4210-sysram";
> >                                 reg = <0x0 0x1000>;
> >                         };
> >
> > -                       smp-sysram@53000 {
> > +                       smp-sram@53000 {
> >                                 compatible = "samsung,exynos4210-sysram-ns";
> >                                 reg = <0x53000 0x1000>;
> >                         };
> > --
> > 2.17.1
> >
> 
> 
> -- 
> Regards,
> Alim
