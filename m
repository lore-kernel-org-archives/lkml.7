Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC092190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569927686;
	bh=WFo4AOUfzZaJbgEqFa0H+5dWz8gP0vH+XT9yDB8pn74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AkQytVh71Zoceo1bQ/Tvoq/uSaprvmvQqNy6flUdhZo9EGnAALtU7BiKcbiVmkk0w
	 pdUWGvP3ZewAWXwC8FbjB3ZuW9P6K2RSMYxomcNY/nVbtc8MquC7V+7Jj72g6XcLzs
	 iwlAweVqf3cLwMa/SH4YtmMWNM5Af+gdl1lCLqX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfJALB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfJALBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:01:25 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11BBA21924;
        Tue,  1 Oct 2019 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569927684;
        bh=WFo4AOUfzZaJbgEqFa0H+5dWz8gP0vH+XT9yDB8pn74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DKAOAjhhZQekV/U0rf1A61tna9L0itLTk3ksZxH/4x8NGaaPEMB6wFbrRuMk0nE04
         pmYtJv/BtN/snI8o56m6K6S3SNSX+TmnxsyTYPmUmLs0860AYsKNWKF8bA4kBcxDS0
         YByxPCIlMdIoRWs6B2VsNN9AfxWvOcIyagdW+dRY=
Received: by mail-wm1-f42.google.com with SMTP id 5so2865632wmg.0;
        Tue, 01 Oct 2019 04:01:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWMdUNuB/GarppTaX4wdGIJGyNMIp07vwdO2a/xIiGJNmEwBnwg
        hENOsPIrybNPvpudeMcnBa9ASTgz9my4kEvjCH4=
X-Google-Smtp-Source: APXvYqxTkPFr419qtuPFWbkgNrsF7CMpg7mB9lJniQFsAuSfCSwlMLaZF7coguK/T5VVCPX6kxCP/gJgub/cxMZOwAw=
X-Received: by 2002:a1c:2b41:: with SMTP id r62mr3025307wmr.47.1569927682563;
 Tue, 01 Oct 2019 04:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
 <20190919052822.10403-5-jagan@amarulasolutions.com> <4177305.6QI6aNXrAv@phil> <CAMty3ZBZ0kXsc-4EwUwy9rAHcDvhhYL1JWkyhhdvSvfRdyvvwA@mail.gmail.com>
In-Reply-To: <CAMty3ZBZ0kXsc-4EwUwy9rAHcDvhhYL1JWkyhhdvSvfRdyvvwA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 1 Oct 2019 19:01:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v67J_Dir72==ZxLmW-yeEsryWEJduVnHQiL96nn0vJEMcg@mail.gmail.com>
Message-ID: <CAGb2v67J_Dir72==ZxLmW-yeEsryWEJduVnHQiL96nn0vJEMcg@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: Rename roc-pc with libretech notation
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Da Xue <da@lessconfused.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Gajjar <akash@openedev.com>,
        Levin Du <djw@t-chip.com.cn>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 6:34 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Mon, Sep 30, 2019 at 3:02 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Hi Jagan,
> >
> > Am Donnerstag, 19. September 2019, 07:28:20 CEST schrieb Jagan Teki:
> > > Though the ROC-PC is manufactured by firefly, it is co-designed
> > > by libretch like other Libretech computer boards from allwinner,
> > > amlogic does.
> > >
> > > So, it is always meaningful to keep maintain those vendors who
> > > are part of design participation so-that the linux mainline
> > > code will expose outside world who are the makers of such
> > > hardware prototypes.
> > >
> > > So, rename the existing rk3399-roc-pc.dts with libretch notation,
> > > rk3399-libretech-roc-rk3399-pc.dts
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/Makefile                           | 2 +-
> > >  .../{rk3399-roc-pc.dts => rk3399-libretech-roc-rk3399-pc.dts}   | 0
> >
> > Somewhat "randomly" renaming files for "exposure" of the maker isn't the
> > way to go. Especially as the file name itself is merely a handle and not
> > meant for fame. The board filename should mainly enable developers to
> > hopefully the correct board file to use/change - and "rk3399-roc-pc"
> > is sufficiently unique to do that.
> >
> > Similar to how the NanoPi boards do that.
> >
> > And renames not only loose the history of changes but also in this case
> > the file is in the kernel since july 2018 - more than a year, so this might
> > actually affect the workflow of someone.
>
> Yes, I agreed this point.
>
> >
> > So I'd really expect an actual technical reason for a rename.
>
> This changes purely based on the recent changes on naming conventions
> that have been followed in amlogic and allwinner with regards to
> libretech [1]. I have seen few Bananapi boards from Allwinner H3 has
> been converted as per Libretech computer recently. I assume these

The DTS file for AML-S905X-CC has never been renamed.

The ALL-H3-CC was only reworked to split out the common bits to accommodate
the different SoC (H3 vs H5) variants for the same board. Even after the
rework, the board DTS files retained their original naming scheme. Same
goes for the Bananapi M2+. However we have never renamed Bananapi files
to Libretech.

Since Libre Computer and Firefly both have the ROC-RK3399-PC, renaming
it is likely to cause some confusion.

ChenYu

> changes are because libretech has part of co-designed vendor and also
> open source forum supported for these hardware.
>
> For further information, may be Da Xue can comment on this.
>
> [1] https://libre.computer/products/boards/
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
