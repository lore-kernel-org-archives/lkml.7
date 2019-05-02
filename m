Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CBCC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9116320651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfEBIUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:20:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42849 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfEBIUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:20:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id l25so1309335eda.9;
        Thu, 02 May 2019 01:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCBHjKNMP3z5CUP9giN1XdvXNXR0qXaBWIcQDT1yIFw=;
        b=aaLW+J7U4U7zH5t3HJM4mADV2+GChTUW2rfyx7xGf96FzxVIPOCrDhXLUSVmOThJsz
         oZuB/oiFYPUybJOYu8wGeksU9HcSpA/OIU/+1BSvcN9wRiiNRkqCpr2y/OZ3i+KtTSxD
         OjpmWoVKPPZYNXjKN3cC7im1mhvnbJxZS17uk+KiizISjBYsEhQuaCBwZLMywgwrF7Ln
         A1EOHuyW3aix1NLDZmKDGzzatiaxBqEXTnIwWJj8BIj+OtFkEtB3GPqoCh+m/FqRLjbY
         mQEskbIklg9NdRWVp8lOob9dz5hvlJ9HCYLWQbR1XDBP0irss8xI1CwkzwE64LMdLJ7z
         l1fA==
X-Gm-Message-State: APjAAAXln7W3H++QxfPT49FveXMzKrCHjT3UVuueT7mxUEvow7DsB1KD
        Rt5IfcOJRddmywUmDNqeUeJ6EOo9fZ4=
X-Google-Smtp-Source: APXvYqzLYQ66yW2CWe56oyMwFeI62kpD26Dq6Zh+jxI7QGVzIIlH2PzIHQCqCNaQXpH4Uqh3cnF0Fg==
X-Received: by 2002:a17:906:7201:: with SMTP id m1mr1103925ejk.96.1556785216221;
        Thu, 02 May 2019 01:20:16 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id m7sm2608518edd.64.2019.05.02.01.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 01:20:15 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id c5so1991345wrs.11;
        Thu, 02 May 2019 01:20:15 -0700 (PDT)
X-Received: by 2002:a5d:4ec6:: with SMTP id s6mr1637882wrv.87.1556785214880;
 Thu, 02 May 2019 01:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
 <1556040365-10913-8-git-send-email-pgreco@centosproject.org> <20190502074103.vtuxmsl55u3ygyvl@flea>
In-Reply-To: <20190502074103.vtuxmsl55u3ygyvl@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 2 May 2019 16:20:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v65eaRLRkJ2hvoOc1Cr=ncSeqy7Tq2pzt4rk4uiWQeag2w@mail.gmail.com>
Message-ID: <CAGb2v65eaRLRkJ2hvoOc1Cr=ncSeqy7Tq2pzt4rk4uiWQeag2w@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v5 7/7] ARM: dts: sun8i: v40:
 bananapi-m2-berry: Add Bluetooth device node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Pablo Greco <pgreco@centosproject.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 3:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 23, 2019 at 02:26:04PM -0300, Pablo Greco wrote:
> > The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
> > identifies as BCM43430, while the Bluetooth side identifies as BCM43438.
> >
> > The Bluetooth side is connected to UART3 in a 4 wire configuration. Same
> > as the WiFi side, due to being the same chip and package, DLDO1 and
> > DLDO2 regulator outputs from the PMIC provide overall power via VBAT and
> > I/O power via VDDIO. The CLK_OUT_A clock output from the SoC provides
> > the LPO low power clock at 32.768 kHz.
> >
> > This patch enables Bluetooth on this board, and also adds the missing
> > LPO clock on the WiFi side. There is also a PCM connection for
> > Bluetooth, but this is not covered here.
> >
> > The LPO clock is fed from CLK_OUT_A, which needs to be muxed on pin
> > PI12. This can be represented in multiple ways. This patch puts the
> > pinctrl property in the pin controller node. This is due to limitations
> > in Linux, where pinmux settings, even the same one, can not be shared
> > by multiple devices. Thus we cannot put it in both the WiFi and
> > Bluetooth device nodes. Putting it the CCU node is another option, but
> > Linux's CCU driver does not handle pinctrl. Also the pin controller is
> > guaranteed to be initialized after the CCU, when clocks are available.
> > And any other devices that use muxed pins are guaranteed to be
> > initialized after the pin controller. Thus having the CLK_OUT_A pinmux
> > reference be in the pin controller node is a good choice without having
> > to deal with implementation issues.
> >
> > Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> > ---
> >  arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > index c87f2c0..15c22b0 100644
> > --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > @@ -96,6 +96,8 @@
> >       wifi_pwrseq: wifi_pwrseq {
> >               compatible = "mmc-pwrseq-simple";
> >               reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
> > +             clocks = <&ccu CLK_OUTA>;
> > +             clock-names = "ext_clock";
>
> So if you don't have that patch (that enables bluetooth) the wifi
> doesn't work (even though the previous patch is supposed to enable it)

Maybe we should just squash the two (WiFi and Bluetooth) together?
After all, they are in the same package, and depend on some of the
same things, such as clocks and regulators.

ChenYu

> >       };
> >  };
> >
> > @@ -173,6 +175,7 @@
> >
> >  &pio {
> >       pinctrl-names = "default";
> > +     pinctrl-0 = <&clk_out_a_pin>;
>
> This one should bein the previous one as well
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
