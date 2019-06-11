Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E55DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D7C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406594AbfFKRk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:40:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32800 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406576AbfFKRkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:40:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id p4so9511719oti.0;
        Tue, 11 Jun 2019 10:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6Szud1QEL0uh5kFNy/KSdJS6Ul+00nLiWCBMgcVJGg=;
        b=NTJD9bBgB2aqvXng6wQFqVU6IsnEqUKF9FDnAglicSbnt78mJVqXqBypVAh+G+8k/e
         V+aXdetrKDoWZolUKYEqGo40yj60xYCt1iyjQoCiMikuQ4ncwECJ/Y6AvEBR1QjUViip
         /o5r5h36dxG91hoXPrktgDFdGGwdrvGBdyscLMYyaf6/n3AIy82MAB9mva+vG0DCCV2z
         NZ5OGETTKD2U2ranexte6Me+wbN0tnXMKfIN2f007uk/zhqeuLYazOPb9i/Fmvb9sSuF
         rPQTCc14us658vj2W3kEnExkEPvrchod6IKtmjWPzewnZjj9MRlY7mmr0xhuifBHf0XV
         qMEw==
X-Gm-Message-State: APjAAAWl/lPTJAj9JG5fsyiKZfV7fKosHmRr6Hx21rDEEAkSVHZ3G9uC
        SYyWophzdtp142UHdakbQ4PBvso8
X-Google-Smtp-Source: APXvYqwa/UX77db97w+uoRAGEUNsOHUDnl+71hdH+emFpgIfqCH53BgzhJbNPyn7KOeVf1soY1Sb7A==
X-Received: by 2002:a05:6830:157:: with SMTP id j23mr17662523otp.198.1560274854241;
        Tue, 11 Jun 2019 10:40:54 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id v198sm4016961oif.0.2019.06.11.10.40.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 10:40:53 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id l15so12693650otn.9;
        Tue, 11 Jun 2019 10:40:53 -0700 (PDT)
X-Received: by 2002:a05:6830:1192:: with SMTP id u18mr30452660otq.74.1560274853474;
 Tue, 11 Jun 2019 10:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190517045753.3709-1-ran.wang_1@nxp.com> <20190523085104.GP9261@dragon>
In-Reply-To: <20190523085104.GP9261@dragon>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 11 Jun 2019 12:40:42 -0500
X-Gmail-Original-Message-ID: <CADRPPNRa11z98Rw5cgApn-2ZFMSTGj-h73wZThmgp9w8dQD4iw@mail.gmail.com>
Message-ID: <CADRPPNRa11z98Rw5cgApn-2ZFMSTGj-h73wZThmgp9w8dQD4iw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Fix CPU idle fail.
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 3:52 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, May 17, 2019 at 12:57:53PM +0800, Ran Wang wrote:
> > PSCI spec define 1st parameter's bit 16 of function CPU_SUSPEND to
> > indicate CPU State Type: 0 for standby, 1 for power down. In this
> > case, we want to select standby for CPU idle feature. But current
> > setting wrongly select power down and cause CPU SUSPEND fail every
> > time. Need this fix.
> >
> > Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
>
> Leo, Bhaskar,
>
> Do you guys agree with it?

Sorry that I missed this email previously.  I agree with this change.
CPU idle should use a low power state that could be waked up by
interrupts and that should be PW20. And Ran is right that both PW20
and PH20 are actually not power down state.

- Leo

>
> Shawn
>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   18 +++++++++---------
> >  1 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index b045812..bf7f845 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -28,7 +28,7 @@
> >                       enable-method = "psci";
> >                       clocks = <&clockgen 1 0>;
> >                       next-level-cache = <&l2>;
> > -                     cpu-idle-states = <&CPU_PH20>;
> > +                     cpu-idle-states = <&CPU_PW20>;
> >               };
> >
> >               cpu1: cpu@1 {
> > @@ -38,7 +38,7 @@
> >                       enable-method = "psci";
> >                       clocks = <&clockgen 1 0>;
> >                       next-level-cache = <&l2>;
> > -                     cpu-idle-states = <&CPU_PH20>;
> > +                     cpu-idle-states = <&CPU_PW20>;
> >               };
> >
> >               l2: l2-cache {
> > @@ -53,13 +53,13 @@
> >                */
> >               entry-method = "arm,psci";
> >
> > -             CPU_PH20: cpu-ph20 {
> > -                     compatible = "arm,idle-state";
> > -                     idle-state-name = "PH20";
> > -                     arm,psci-suspend-param = <0x00010000>;
> > -                     entry-latency-us = <1000>;
> > -                     exit-latency-us = <1000>;
> > -                     min-residency-us = <3000>;
> > +             CPU_PW20: cpu-pw20 {
> > +                       compatible = "arm,idle-state";
> > +                       idle-state-name = "PW20";
> > +                       arm,psci-suspend-param = <0x0>;
> > +                       entry-latency-us = <2000>;
> > +                       exit-latency-us = <2000>;
> > +                       min-residency-us = <6000>;
> >               };
> >       };
> >
> > --
> > 1.7.1
> >
