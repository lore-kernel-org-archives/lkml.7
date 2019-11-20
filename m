Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C715C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751D122506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f9v0k+tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfKTNpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:45:55 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36435 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbfKTNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:45:54 -0500
Received: by mail-il1-f194.google.com with SMTP id s75so23461333ilc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CgtC9U1pFRMoXuEqIqpJlmsw3VQlHrD4MMxLF0Vx8xg=;
        b=f9v0k+tmuEKwj5AFNUmMvv40wkogZJAKmCuPbUcRSyVSro9EOqDDGQUbGbNnFxuafy
         M8+nR8SfAxXQSWe5lkbuIRV42ZNm0BUahg5Pa7RSMFMqj4aT1Prn3NpFgDUDOxzOIBz2
         S4kZCLvmzc+qOhteX9wJjgzlrGNGsYocmCcus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CgtC9U1pFRMoXuEqIqpJlmsw3VQlHrD4MMxLF0Vx8xg=;
        b=blz/bjBcgxG7Z8rDEf+kwwTuV69ycxDcxrOKRrsOGXGNJotZKa10o5vP4OLKTIYgYU
         4LrPb/xnfB7PycOxYJ3bjFui6UQwWIVr/8RtoZusojZgAt5sDA08Dep7dqgyhs96DXpO
         CqJA+1sh5xezaZFUnMI9stEIXc0nstwIqWHajmv0P+4ZtK32JYZz0K11JSojCK5R3tMu
         B9tdaIXAJhsWOZYfE6IfZVfHk3UVdSDC9XNu4YK+jkQtLU3ao2d3RwiwMYMDi6xV0HgX
         D0zzUCITXXPYtUmgsBQdTqmkWt/ZqFmnNnAbIo8iKzbP22P7swXjFZEgjB9aV+l2ivmW
         1sVg==
X-Gm-Message-State: APjAAAXnvLzrtgWNNoKZzZFLreRRLEnbJj84N/cZpWHtbfbmS2dnkoTE
        RHReEUc5P3YFpE/fwiybVQeGcxWvcwCvt/CwrGOMsA==
X-Google-Smtp-Source: APXvYqw3MjUmdfjEYcoiBovAQmlP74ZDtmiuO4AZQCwKvD8ckXU62L4h/ai9eP9F51LEWbRnEd7dIEmZ63LdAHGL5Ac=
X-Received: by 2002:a92:5d8f:: with SMTP id e15mr3572412ilg.173.1574257548126;
 Wed, 20 Nov 2019 05:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20191120113923.11685-1-jagan@amarulasolutions.com>
 <20191120113923.11685-5-jagan@amarulasolutions.com> <5644395.EDGZVd1YuU@diego>
In-Reply-To: <5644395.EDGZVd1YuU@diego>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 20 Nov 2019 19:15:35 +0530
Message-ID: <CAMty3ZA+p2pWokLrwnkv6_q0G8d76AntE5Kar4JN8MN48O9VSw@mail.gmail.com>
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

On Wed, Nov 20, 2019 at 6:55 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Jagan,
>
> Am Mittwoch, 20. November 2019, 12:39:22 CET schrieb Jagan Teki:
> > Carrier board often referred as baseboard. For making
> > complete SBC, the associated SOM will mount on top of
> > this carrier board.
> >
> > Radxa has a carrier board which supports on board
> > peripherals, ports like USB-2.0, USB-3.0, HDMI, MIPI DSI/CSI,
> > eDP, Ethernet, PCIe, USB-C, 40-Pin GPIO header and etc.
> >
> > Currently this carrier board can be used together with
> > VMARC RK3399Por SOM for making Rock PI N10 SBC.
> >
> > So add this carrier board dtsi as a separate file in
> > ARM directory, so-that the same can reuse it in both
> > arm32 and arm64 variants of Rockchip SOMs.
>
> Do you really think someone will create an arm32 soc using that
> carrier board?

Yes, we have Rock Pi N8 which is using same carrier board design with
(+ external codec) on top of RK3288 SOM. I didn't mentioned on the
commit message since radxa doesn't officially announced on the
website.

>
> Similarly so far I don't think we haven't even seen a lot of reuse
> of existing carrier boards at all, other than their initial combination.
>
> So maybe just having the content of your
>         rockchip-radxa-carrierboard.dtsi
> in
>         rockchip/rk3399pro-rock-pi-n10.dts
> from patch 5 might be a better start - at least until there is any
> further usage - if at all?

But, this particular design has proper use case.
1. rk3399pro SOM + carrier board (Rock Pi N10)
2. rk3288 SOM + carrier board (Rock Pi N8)

>
> Also rockchip-radxa-carrierboard might even be overly generic
> as there may be multiple carrierboards from Radxa later on.

I'm slightly disagree of having overlay here, since these are fixed
design combinations. where SOM with respective carrier board is
mandatory to make final board. Understand that we can have a
maintenance over-ahead if we have multiple carrier boards, but right
now radxa has only one carrier board with 2 sets of SOM's combinations
that indeed fit like a dev board, so there is unused carrier board.

Jagan.
