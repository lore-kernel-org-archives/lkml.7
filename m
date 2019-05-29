Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6947723B05
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfE2Pm0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:42:26 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37331 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE2Pm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:42:26 -0400
Received: by mail-it1-f193.google.com with SMTP id s16so4312819ita.2;
        Wed, 29 May 2019 08:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/j7gWc8iISYWxGlnTZ+LY1ElrHO5aM1K4ex0tPbofbE=;
        b=B/RRMPUKUApeaYKft0QoYUBC5VzOTf2pMIqlpodaEjubpmljUbmzKdPBg+fydFJefn
         XK+HygnMZt/5vXwHJmWZmnQOzmuzHc5nehMzvNnuMR4GcE9SEiCSqYBq4QP0t/aa79bY
         etrqQbn7S1/SbpsBu1Nvhurcvz0/n2C7VKjvO7ZoXSt+loAkC28udOomgAEKM5dEggZ6
         OEcez4bQW2pC7sVdhpSqDTMUzSzVBTmyKqSzXM2admlT1HC0aKBGVHQVzLU7BiMx5hD3
         2NqvpvgQwdQhU0kZw0xuwfkaIgc/VSFpj8R0cIQE2tpEdqKqX7v4v3vCuYMEF0KMeE9R
         c1mg==
X-Gm-Message-State: APjAAAWyZ2A2Hu3JIiR4nm3ebdh4neGf3VTa+kAKFvQjpXrGs8AkHALe
        9Qo2kH1KFtmMDUsCNj211IEaa0uE/8ljzwPZAEs=
X-Google-Smtp-Source: APXvYqxx5oCnY0ckeXgGB+mbjowC9PFLcxwUeTiuKxwAnSfLcvoimR2T5iJwjxqjFjmj4DF/QeOL++us1RCXTMjmKUU=
X-Received: by 2002:a24:6583:: with SMTP id u125mr7911125itb.168.1559144543170;
 Wed, 29 May 2019 08:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com> <20190529153255.40038-1-tomeu.vizoso@collabora.com>
 <CAJiuCccFG1SATp7QuSOi11MmbjmgX0ZHsTv=4zuXqXMG+=-7Dw@mail.gmail.com>
In-Reply-To: <CAJiuCccFG1SATp7QuSOi11MmbjmgX0ZHsTv=4zuXqXMG+=-7Dw@mail.gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Wed, 29 May 2019 17:42:12 +0200
Message-ID: <CAAObsKCWJmx-TKyiHFvUaDtGOpz8SXNOBFK3AbmUWW7KprD2Rw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add GPU operating points for H6
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 at 17:37, Clément Péron <peron.clem@gmail.com> wrote:
>
> Hi Tomeu,
>
> On Wed, 29 May 2019 at 17:33, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> >
> > The GPU driver needs them to change the clock frequency and regulator
> > voltage depending on the load.
>
> As requested by Maxime, I have dropped these OPP table as It's taken
> from vendor and untested with Panfrost.
>
> https://lore.kernel.org/patchwork/patch/1060374/

Ok, guess this series should wait then until we can run Panfrost on it
and check how DVFS is working.

Thanks,

Tomeu

> Regards,
> Clément
>
> >
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Cc: Clément Péron <peron.clem@gmail.com>
> >
> > ---
> >
> > Feel free to pick up this patch if you are going to keep pushing this
> > series forward.
> >
> > Thanks,
> >
> > Tomeu
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 66 ++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > index 6aad06095c40..decf7b56e2df 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -157,6 +157,71 @@
> >                         allwinner,sram = <&ve_sram 1>;
> >                 };
> >
> > +               gpu_opp_table: opp-table2 {
> > +                       compatible = "operating-points-v2";
> > +
> > +                       opp00 {
> > +                               opp-hz = /bits/ 64 <756000000>;
> > +                               opp-microvolt = <1040000>;
> > +                       };
> > +                       opp01 {
> > +                               opp-hz = /bits/ 64 <624000000>;
> > +                               opp-microvolt = <950000>;
> > +                       };
> > +                       opp02 {
> > +                               opp-hz = /bits/ 64 <576000000>;
> > +                               opp-microvolt = <930000>;
> > +                       };
> > +                       opp03 {
> > +                               opp-hz = /bits/ 64 <540000000>;
> > +                               opp-microvolt = <910000>;
> > +                       };
> > +                       opp04 {
> > +                               opp-hz = /bits/ 64 <504000000>;
> > +                               opp-microvolt = <890000>;
> > +                       };
> > +                       opp05 {
> > +                               opp-hz = /bits/ 64 <456000000>;
> > +                               opp-microvolt = <870000>;
> > +                       };
> > +                       opp06 {
> > +                               opp-hz = /bits/ 64 <432000000>;
> > +                               opp-microvolt = <860000>;
> > +                       };
> > +                       opp07 {
> > +                               opp-hz = /bits/ 64 <420000000>;
> > +                               opp-microvolt = <850000>;
> > +                       };
> > +                       opp08 {
> > +                               opp-hz = /bits/ 64 <408000000>;
> > +                               opp-microvolt = <840000>;
> > +                       };
> > +                       opp09 {
> > +                               opp-hz = /bits/ 64 <384000000>;
> > +                               opp-microvolt = <830000>;
> > +                       };
> > +                       opp10 {
> > +                               opp-hz = /bits/ 64 <360000000>;
> > +                               opp-microvolt = <820000>;
> > +                       };
> > +                       opp11 {
> > +                               opp-hz = /bits/ 64 <336000000>;
> > +                               opp-microvolt = <810000>;
> > +                       };
> > +                       opp12 {
> > +                               opp-hz = /bits/ 64 <312000000>;
> > +                               opp-microvolt = <810000>;
> > +                       };
> > +                       opp13 {
> > +                               opp-hz = /bits/ 64 <264000000>;
> > +                               opp-microvolt = <810000>;
> > +                       };
> > +                       opp14 {
> > +                               opp-hz = /bits/ 64 <216000000>;
> > +                               opp-microvolt = <810000>;
> > +                       };
> > +               };
> > +
> >                 gpu: gpu@1800000 {
> >                         compatible = "allwinner,sun50i-h6-mali",
> >                                      "arm,mali-t720";
> > @@ -168,6 +233,7 @@
> >                         clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> >                         clock-names = "core", "bus";
> >                         resets = <&ccu RST_BUS_GPU>;
> > +                       operating-points-v2 = <&gpu_opp_table>;
> >                         status = "disabled";
> >                 };
> >
> > --
> > 2.20.1
> >
