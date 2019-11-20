Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D6C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FA2206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XhcSuygs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfKTPdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:33:49 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37817 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfKTPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:33:49 -0500
Received: by mail-oi1-f178.google.com with SMTP id y194so126491oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XIz71A93vT2GZir/cbd6mjWyCS4Rwn+5UeGeUtq83rI=;
        b=XhcSuygsIBwuCOL9xXeVVWfKx6OA4pTVpYUr5oiWXKDaiMqAXeLa0e4xJYBglzpgLi
         /r50b5WVPxR45+xRT0n1oir0gfEkbzcVd2at+obobIM1v+1voNKef59puPe7oDc0pqZw
         I1kaR9TPOL61ysviDLLLtf8BsXgRYZaBPZF0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XIz71A93vT2GZir/cbd6mjWyCS4Rwn+5UeGeUtq83rI=;
        b=hAGqmep1rgp/3aNm5ntNd1EVXziuF+atbN0tU/5xvTsVjwZMLYhcd7k/LO/uEZ3gYw
         gIOgmsYgsB7RTcDxly0CSmZQYoHaLOMtuCaCEoRM9cMO1lnmmBNm/anra9Hka+rD1QoC
         3eB6B9eclRFD6OTPTGTBLX+54GxbrWPi9JIhhgJeRmBjgI1+U/BFy6SjOLSU488JPWCs
         BjMyauduuZ8u0AxBITwQKf72uwD9PKxh5kSV9bpQr/y5CYYmNmNyUx1UD5t6Ai8PNw7s
         jnehER2cfDKwCWg4a/SzTu5DC1FWC2UUEf46VVT3SP3T0nLkIlB9OYZ2kmAaCQf4yOHd
         y7RQ==
X-Gm-Message-State: APjAAAWAkCmIFqivkN4v8XUihZTxQaXIYiViSyFTpJmJMLzX4TRLH2v3
        Hq2WwnkBlmwp56oWmTSJ+Am+IDCQzaa3QJZZBkOEFWZDfpxDng==
X-Google-Smtp-Source: APXvYqzFZ1Nv/DhX4G1ZPrfrmut25uY1BdnJKjyKvD6eMew7XmgYRuai2w90HTpHiKhhksOu8ivhmtv9cpmYUF09//4=
X-Received: by 2002:aca:320a:: with SMTP id y10mr3250705oiy.152.1574264024897;
 Wed, 20 Nov 2019 07:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20191120113923.11685-1-jagan@amarulasolutions.com>
 <5644395.EDGZVd1YuU@diego> <CAMty3ZA+p2pWokLrwnkv6_q0G8d76AntE5Kar4JN8MN48O9VSw@mail.gmail.com>
 <12496011.EUIoF19S7S@diego>
In-Reply-To: <12496011.EUIoF19S7S@diego>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 20 Nov 2019 21:03:33 +0530
Message-ID: <CAMty3ZCLYQYvOuOzRXjxDmLsFbYBYOQjymsn+pCvctTaQG2Y0g@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: dts: rockchip: Add Radxa Carrier board
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Tom Cubie <tom@radxa.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Gajjar <akash@openedev.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Nov 20, 2019 at 7:23 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Jagan,
>
> Am Mittwoch, 20. November 2019, 14:45:35 CET schrieb Jagan Teki:
> > On Wed, Nov 20, 2019 at 6:55 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > > Am Mittwoch, 20. November 2019, 12:39:22 CET schrieb Jagan Teki:
> > > > Carrier board often referred as baseboard. For making
> > > > complete SBC, the associated SOM will mount on top of
> > > > this carrier board.
> > > >
> > > > Radxa has a carrier board which supports on board
> > > > peripherals, ports like USB-2.0, USB-3.0, HDMI, MIPI DSI/CSI,
> > > > eDP, Ethernet, PCIe, USB-C, 40-Pin GPIO header and etc.
> > > >
> > > > Currently this carrier board can be used together with
> > > > VMARC RK3399Por SOM for making Rock PI N10 SBC.
> > > >
> > > > So add this carrier board dtsi as a separate file in
> > > > ARM directory, so-that the same can reuse it in both
> > > > arm32 and arm64 variants of Rockchip SOMs.
> > >
> > > Do you really think someone will create an arm32 soc using that
> > > carrier board?
> >
> > Yes, we have Rock Pi N8 which is using same carrier board design with
> > (+ external codec) on top of RK3288 SOM. I didn't mentioned on the
> > commit message since radxa doesn't officially announced on the
> > website.
> >
> > >
> > > Similarly so far I don't think we haven't even seen a lot of reuse
> > > of existing carrier boards at all, other than their initial combinati=
on.
> > >
> > > So maybe just having the content of your
> > >         rockchip-radxa-carrierboard.dtsi
> > > in
> > >         rockchip/rk3399pro-rock-pi-n10.dts
> > > from patch 5 might be a better start - at least until there is any
> > > further usage - if at all?
> >
> > But, this particular design has proper use case.
> > 1. rk3399pro SOM + carrier board (Rock Pi N10)
> > 2. rk3288 SOM + carrier board (Rock Pi N8)
> >
> > >
> > > Also rockchip-radxa-carrierboard might even be overly generic
> > > as there may be multiple carrierboards from Radxa later on.
> >
> > I'm slightly disagree of having overlay here, since these are fixed
> > design combinations. where SOM with respective carrier board is
> > mandatory to make final board. Understand that we can have a
> > maintenance over-ahead if we have multiple carrier boards, but right
> > now radxa has only one carrier board with 2 sets of SOM's combinations
> > that indeed fit like a dev board, so there is unused carrier board.
>
> All is good ... with that information from above (rk3288) this definitly
> makes more sense :-)
>
> The naming of the file is still a tiny struggle though. Does this board
> maybe have some actual product name or is it really just called
> "carrierboard"? :-)

True, I felt the same. Just now Tom has named this as 'Dalang Carrier
board' so we can have rockchip-radxa-dalang.dtsi or
rockchip-radxa-dalang-carrier.dtsi as file names. or let me know if
you have any suggestions on the file name?

Jagan.
