Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F32DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE41206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKSAoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:44:44 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35886 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSAoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:44:44 -0500
Received: by mail-ot1-f50.google.com with SMTP id f10so16328528oto.3;
        Mon, 18 Nov 2019 16:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KK5FYD8PxRF0A+U6gGDQIfKZHAve6NPMN8YtVyh0Ls4=;
        b=TX7NBv3RMPn9zsA4hKKt9yCAudhBXoXrsk1080njT7aXGRA4iSr6DF7Ac7Rhvi+Qo2
         7DmmaebQw4bl7AV6yAvFf+QMqwhKLfobWh3o+lQTA0HM+gvsnFGM6YEpoxI5asGIuEPh
         rP5Z2gLEOzNSqXqhqmkSWJyNnrJiQK3DhI00oZCclZlGQg/TJ+bN0yknml+Vgj2KfKpN
         /tA6RT1kDOomgIdhAtHb+fqKT3wcKMnwYTPV5yCrJHvyk2iqxWRLwVt7cy840hsNpHHK
         QF2yoMgynVKLz7T4PpZ03HCTrj0sIrBbxLUaVZ6ByTU1lvcPcSNssY0+rRGBzMrne7nS
         yKWg==
X-Gm-Message-State: APjAAAVd3XN3hRlRwXr9y8clWjl952CtZu1QejKReglMf41J16QbmHCX
        ubh4d0ViMPZ2mwPn500C1oVGf+WbjJ90EI/oBnU=
X-Google-Smtp-Source: APXvYqz8vlbzWtw6HaYn2YK7CSJv8YIqAwxUC5AlU5cHaNxx+FVcsQ6Zxsu3Nnk0YdAKCbEdeBf9P5RAIwTpaJL28n8=
X-Received: by 2002:a9d:6649:: with SMTP id q9mr1568242otm.106.1574124283140;
 Mon, 18 Nov 2019 16:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20191117101545.6406-1-matwey@sai.msu.ru> <1784520.t1z2W423De@phil>
 <CAJs94EZPLedH4w3+5vfJA+f+1+zLETBdETpqNPytp3LG63az9Q@mail.gmail.com>
In-Reply-To: <CAJs94EZPLedH4w3+5vfJA+f+1+zLETBdETpqNPytp3LG63az9Q@mail.gmail.com>
From:   Tom Cubie <tom@radxa.com>
Date:   Tue, 19 Nov 2019 08:44:06 +0800
Message-ID: <CAFjve-AT6c-yweF0mOPea-caG3n43nZzVPcwef-qp+n35JN9ig@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 board
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Gajjar <akash@openedev.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matwey

On Tue, Nov 19, 2019 at 2:41 AM Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
>
> Current schematics
> (https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf)
> is controversial on 1.8 supply:
>
> On sheet 15 it says that 1.8 is supplied by VCC_1V8
> at the same time on sheet 3 it says that it is supplied by VCCA_1V8

I am sorry for the confusion of the schematic. Please ignore the power
tree on sheet 3, it's from the original reference design, I think we
have different power paths on ROCK Pi 4. Please refer the circuits
starting from sheet 5 below. It reflects the real hardware. We will
fix the power tree and upload a new version of the schematic.

>
> >
> > Thanks
> > Heiko
> >
> >
>
>
> --
> With best regards,
> Matwey V. Kornilov
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip



-- 
radxa rock pi 4 - the next generation Pi.

radxa.com
