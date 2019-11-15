Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E44BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40ECA2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOSQo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:16:44 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34949 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:16:44 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so9967634ilp.2;
        Fri, 15 Nov 2019 10:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rKdLjfAH1h2JYCzXLa2uKNlLJWREL+e9FB64JDOkPEo=;
        b=N8BWWbg+Q6rjmSSAuB31hgx2GDdp18Tup7UnwmlSsigvtwwkyCvSjp+3FiZ0U+RYcb
         LcY4Ed6LH7DPMJmT5Woieo7Z+YqPcqFVPnpc/lGRs3bsqi8CqyvJLuKbVDUJqNtnLolr
         GUHdKUJ0ST/CmW3qY6ZQDOd9GMyaieAoR/Wah9F/LY6yNNHUNFPYkmTh4uHBm/HDFnyn
         WD+2G7gIMWO135pDCvJG3YPLD94JapTwIYkI/XmKxMB6fZpv5XllcepZMBrTLs2ezROw
         bWF5AEAGnKns4tovqxSH5cSYe8tOlKUKk2iIwepbyLBNKEb19MX+dymuuZR9hm7xuvGX
         47mQ==
X-Gm-Message-State: APjAAAXCyfrCZ4ejF2UXTVislf8xcYsvLRzvag0Oo1oHgK27DL1jec7Y
        vVoVm3L6HgqwH+tFilF+lx8aKW4RSXdyo7fcXnc=
X-Google-Smtp-Source: APXvYqwdBJ8rNtN+EZdewVmchYbVuye3g8V5/SEW3mhTUGjUBd6v26ZhMBNZbxiFVwipN8ZIsSBw8LNVvdEOSPaXau0=
X-Received: by 2002:a92:8605:: with SMTP id g5mr2238459ild.172.1573841801481;
 Fri, 15 Nov 2019 10:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20191115180825.10526-1-matwey@sai.msu.ru> <1708909.MJzrS8JzXa@diego>
In-Reply-To: <1708909.MJzrS8JzXa@diego>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Fri, 15 Nov 2019 21:16:29 +0300
Message-ID: <CAJs94EYGmU3RYEP0bd387XEN=B_zA8rwGkJeSVqWycNPO95r=w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 board
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Akash Gajjar <akash@openedev.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

пт, 15 нояб. 2019 г. в 21:14, Heiko Stübner <heiko@sntech.de>:
>
> Hi Matwey,
>
> Am Freitag, 15. November 2019, 19:08:21 CET schrieb Matwey V. Kornilov:
> > Radxa Rock Pi 4 is equipped with M.2 PCIe slot,
> > so enable PCIe for the board.
> >
> > The changes has been tested with Intel SSD 660p series device.
> >
> >     01:00.0 Class 0108: Device 8086:f1a8 (rev 03)
> >
> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> > index 1ae1ebd4efdd..9c2927faba41 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> > @@ -463,6 +463,20 @@
> >       pmu1830-supply = <&vcc_3v0>;
> >  };
> >
> > +&pcie_phy {
> > +     status = "okay";
> > +};
> > +
> > +&pcie0 {
> > +     status = "okay";
> > +
> > +     ep-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;
> > +     num-lanes = <4>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pcie_clkreqnb_cpm>;
> > +     max-link-speed = <2>;
>
> the RockPi schematics should be available, so could you also check
> the supply regulators and add them please?
>
> Thanks
> Heiko

Hi,

What do you mean? pcie 3.3v regulator is already in dts. I've checked
that its gpio is correctly configured.

>
>
> > +};
> > +
> >  &pinctrl {
> >       bt {
> >               bt_enable_h: bt-enable-h {
> >
>
>
>
>


-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
