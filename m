Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C284C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2107208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R2INQf1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbfFLKA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:00:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46807 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbfFLKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:00:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190612100025euoutp0289dbe8cc84a846df915f41e8bdb8bc3d~naypT6Xcb2858828588euoutp02Q
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 10:00:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190612100025euoutp0289dbe8cc84a846df915f41e8bdb8bc3d~naypT6Xcb2858828588euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560333625;
        bh=+95owVZmp1Gj8EZQw0Lxjw/FhUz68n4Zw/5vSmcwGH4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R2INQf1yPpWuqEpZ37skedlp2MnXQzgf1fPL6FhLNu/puWWYEVKqXR12NurATDQaU
         tu9rr4JzC1fpUN0LXmBZ/kKSXPn2hZ0NiSy0T/0VcpnbaftQjuqknE0Jp9yV5Vm2v3
         bLNcIJG0pEiAcdnMghSot7zp8yDy8EpsarXBWFEI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190612100024eucas1p2f3595f8f18cd4c97a371232b05b72f01~nayoTr9J82796727967eucas1p2N;
        Wed, 12 Jun 2019 10:00:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CF.43.04377.83DC00D5; Wed, 12
        Jun 2019 11:00:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190612100023eucas1p26e1f39a703337d41ec8d28fdac7db277~naynehX3P2796727967eucas1p2M;
        Wed, 12 Jun 2019 10:00:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190612100023eusmtrp13c6005fd4dad96f0cef04f8a2cb66b5b~naynPinYP0608606086eusmtrp1u;
        Wed, 12 Jun 2019 10:00:23 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-05-5d00cd389b9d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.9C.04140.73DC00D5; Wed, 12
        Jun 2019 11:00:23 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190612100022eusmtip29b340996d9997b176a6add45d8922e9e~naymgAZbt1110211102eusmtip2n;
        Wed, 12 Jun 2019 10:00:22 +0000 (GMT)
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345
 bridge on Teres-I
To:     Torsten Duwe <duwe@lst.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Harald Geyer <harald@ccbib.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
Date:   Wed, 12 Jun 2019 12:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607094030.GA12373@lst.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTlzU5jdVpArktcmmjirsSPFxeiRpPxz/jhbrTqCAZasAPusY3I
        otRoNYpUqBiKmkqEFARaAiUFQUGqRFyQKMQtbijRtlojKGU08nfuuefcd07yOFJdyIzn9ujT
        RINem6xhFFRVc+j+HNwesXX+oJnGp3x3CZzZ/Bbh31UWEl9u8tG4M/CFwcHOVgJnFJcxuNLd
        TuNvV14Q+ITFzmLnq8c0fuguYHDJkw4C9773IJxZ18Ti5+XtCFc4z5M45LZROOS9TyyLEopD
        g4RQaitFgq30sPCm8SMrXDJ1UEL5yxu0UBcsogSX9fkQl5NPC07HCUb47POxQnWwlxY8haWs
        0JPbQggVdqNQ22Vi1qg2KZbsEpP37BMN8+K3KxIf9tWhVPuEAzZzgDWh7zEnUSQH/ELoeVzG
        nkQKTs1fRxC45yflwY/A96OZkIdvCLIabPQ/y6PMQiQvriFoLTYx8tCH4GLBTTasiuI3wWlP
        3pCd46L51dBfOT2sIflqGo7VDAxfYvgZMFDRxYSxko+Hd3YLEcYUPw066sM5IrkYfgP4XU4k
        a1RwN/81FcaR/GwIXAwN3yH5yVDdV0DKOBaevb48HBv4Tg48GQ2kHHslZDm6GRlHwYeWSlbG
        E6HtnJmSsRF6rh8nZXMOglvlrr/mxdDY0kGH25BDqcvc82R6Ofzs9w7TwI+Gp30qOcNoOFuV
        R8q0EnKy1LJ6KvS03/p7MBZKHgSYM0hjHdHMOqKNdUQb6/93ixDlQLFiuqRLEKU4vbh/rqTV
        Sen6hLk7U3RONPRp2wZb/DXI/WuHF/Ec0oxSNuT93qKmtfukgzovAo7URCvjkiK2qpW7tAcP
        iYaUbYb0ZFHyogkcpYlVHo7o3azmE7RpYpIopoqGf1uCixxvQuqJOxaOO2JZteit52vG2Dcr
        LEsb711IVTWZ3R8Vpnhf94cUe//P3KIHUz7FTGnYEnAVz8q9c0NSGatbb6dmd+Wf0SdduOQf
        U6sLrs/hNcGSnY6a/Y6kta7zocS9X6dm0xvXtcXtNhd9j/a8PEAtn/Xs0JErR8Wr0QPG+uxF
        R39MMsZrKClRu2AmaZC0fwDl2tdzsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe+7brtbgbio+rA/FaIVhqztbe5SaUQS3D0EQRVlmyy6aui12
        p2ZCDUqq9UKjN5s6DSdaDhxOtCZmLVMsNjN7s8xELRLThJqxsGy6Ar/9OOf/45wDh8alblJG
        HzWYeZNBlyenoolnf7oG12j8i9LXXb+xGF0KdGOopPMzQLPNNhxVdgRI9DL4jULTL59i6HR1
        A4WavH4Sfb89iKHzNqcINY68JlGft5xCNW96MTQ01g5QSVuHCH1w+wHyNF7HUcjrIFDI14Nt
        juGqQ38wzuVwAc7hKuY+PR4XcWWWXoJzD9eTXNt0FcHdt38I187dIrnGu+cpbjIQEHEt00Mk
        117hEnEfL3RhnMd5imvtt1A7JWnKjSZjvplfnm0UzJvk+1mkUrLJSKlan6xkkzTpKSq1fK12
        4xE+72gBb1qrPaTM7ptoA8ecS487LgZFFvAzzgqiaMish69KKoAVRNNSpgbAs3emyEgjHrZW
        TuARjoEzr61UJDQO4D3HkGiuEcOkweftp8Mhmo5ltsOpppVzGZxpJeHl+itEROjGoWfSi80J
        FJMAf3v6qTkWM1r4xWmbrxOMAvY++DE/LY7ZC8u8FiKSkcDuW6PzHMUkwmBpaH47nFkFZxwv
        8Agvgy0T5f84Hr4brcSuAKl9gW5foNgXKPYFShUg7oJYPl/QZ+kFlVLQ6YV8Q5Yy06hvBOFv
        ae4MNd0D1sldPsDQQL5E/PDm7AEpqSsQivQ+AGlcHitW5S5Kl4qP6IpO8CZjhik/jxd8QB0+
        zobL4jKN4d8zmDNYNatByawmSZO0AcnjxeeYRwekTJbOzOfy/DHe9N/D6CiZBei2oR3SnoHC
        0MjlaIW+MBrNlOIrYF3OYqZgtKNy+W53ArblGW661lmmLt9XXG3sGs65+iQ0+9unOFjasO6w
        itb6v444fW9/Bd2BFH2q5Hste4aSST71WMYyBEXAmXqy9z3YMpDjXJm5Yk+qZ3ttXkKXaGui
        a3A4xdJeX9ctJ4RsHbsaNwm6v9efuIxDAwAA
X-CMS-MailID: 20190612100023eucas1p26e1f39a703337d41ec8d28fdac7db277
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752
References: <20190604122150.29D6468B05@newverein.lst.de>
        <20190604122308.98D4868B20@newverein.lst.de>
        <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
        <20190605101317.GA9345@lst.de> <20190605120237.ekmytfxcwbjaqy3x@flea>
        <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at>
        <20190607062802.m5wslx3imiqooq5a@flea>
        <CGME20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752@epcas1p4.samsung.com>
        <20190607094030.GA12373@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 11:40, Torsten Duwe wrote:
> On Fri, Jun 07, 2019 at 08:28:02AM +0200, Maxime Ripard wrote:
>> On Thu, Jun 06, 2019 at 03:59:27PM +0200, Harald Geyer wrote:
>>> If think valid compatible properties would be:
>>> compatible = "innolux,n116bge", "simple-panel";
>>> compatible = "edp-connector", "simple-panel";
>> A connector isn't a panel.
>>
>>> compatible = "innolux,n116bge", "edp-connector", "simple-panel";
>> And the innolux,n116bge is certainly not a connector either.
>>
>>> compatible = "edp-connector", "innolux,n116bge", "simple-panel";
>>>
>>> I can't make up my mind which one I prefere. However neither of these
>>> variants requires actually implmenting an edp-connector driver.
>> No-one asked to do an edp-connector driver. You should use it in your
>> DT, but if you want to have some code in your driver that parses the
>> DT directly, I'm totally fine with that.
> I must admit I fail to understand what that extra node would be good for.
> Logically, the eDP far side is connected to the well-known n116bge.
> Inside the laptop case it might as well be a flat ribbon cable or
> soldered directly.
> In good intention, that's all I wanted to express in the DT. I don't
> know whether the relevant mechanical dimensions of the panel and the
> connector are standardised, so whether one could in theory assemble it
> with a different panel than the one it came with.
>
> OTOH, as I checked during the discussion with anarsoul, the panel's
> supply voltage is permanently connected to the main 3.3V rail.
> We already agreed that the eDP output port must not neccessarily be
> specified, this setup is a good example why: because the panel is
> always powered, the anx6345 can always pull valid EDID data from it
> so at this stage there's no need for any OS driver to reach beyond
> the bridge. IIRC even the backlight got switched off for the blank
> screen without.
>
> All I wanted to say is that "there's usually an n116bge behind it";
> but this is mostly redundant.
>
> So, shall we just drop the output port specification (along with the
> panel node) in order to get one step further?


I am not sure if I understand whole discussion here, but I also do not
understand whole edp-connector thing.

According to VESA[1] eDP is "Internal display interface" - there is no
external connector for eDP, the way it is connected is integrator's
decision, but it is fixed - ie end user do not plug/unplug it.

If I remember correctly in some boards eDP is connected to some DP
connector (odroid xu3 if I remember correctly), but this is non-standard
hack, and for this case in bindings there should be rather dp-connector
not edp-connector.

[1]:
https://www.vesa.org/wp-content/uploads/2010/12/DisplayPort-DevCon-Presentation-eDP-Dec-2010-v3.pdf


Regards

Andrzej


>
>> I guess you should describe why do you think it's "clear", because I'm
>> not sure this is obvious for everyone here. eDP allows to discover
>> which device is on the other side and its supported timings, just like
>> HDMI for example (or regular DP, for that matter). Would you think
>> it's clearly preferable to ship a DT with the DP/HDMI monitor
>> connected on the other side exposed as a panel as well?
> Well, as I wrote: "in good intention". That's the panel that comes with
> the kit but it is very well detected automatically, just like you describe.
>
> So, just leave it out?
>
> 	Torsten
>
>
>

