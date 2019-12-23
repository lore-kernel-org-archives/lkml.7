Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD2C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E322073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hc43iZkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLWQos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:44:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37306 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLWQos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:44:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so4601809wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 08:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xz4QttoGSZMNzHsoQ2oRSp3hgFmNlArUTi27jCKVI2E=;
        b=hc43iZkjfH0OUTYKjWomh+9SENA1fOyHO9Hd+ZYCvOrhmiHkVFDvEqpg6Uvkwieozz
         TqMNEWevj+8aVqSxYDK+PjblNx6uAC1ZscAuU0A3eSb8Qq2IkDFt34MXMOmiynH0Dh80
         gH5I86szOUlV53ssgoBoE2Nnj6CHusAh8eV/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xz4QttoGSZMNzHsoQ2oRSp3hgFmNlArUTi27jCKVI2E=;
        b=NTmgheMBt+Ql8DdF7OtWX4DBmb0cQJkTzkUZ4rRMdrZEeNIR73zrn4OcmuRP5Up6v9
         Xs99HwA4DyU93ZLtRMHDd5e3WpCfEJ3PkfrN7kFO6R2MKc9WWatqdTa+buVQG+RonGfx
         XY8+C+Ba2vjlmNTuujZUT4n7y2h/lzM4fSaneA/+MgiP1h7YafQyMOpksf9oDKZfzuVU
         sSnxXJj4p+tUSTxeQzUcHjaL+s/AfcAeE/WeFE4+RgFLB1XOwZ9PfO29VMK7ZlWv/Avo
         Rk9SdjnCENk9Gs0sxt26FnBUUxCpO/oLIza2BATn95lRkN7MkYONqa/g49FOHD1cSnce
         nYgQ==
X-Gm-Message-State: APjAAAW7Oyo7wf+hV3+lOHTDFPm7JrN42r9D9S1iP7czI26GTNU4yPog
        5fD0lOFYsJvY7PZ6YbBUwcSNLebYUTGo2CrtDq/bfw==
X-Google-Smtp-Source: APXvYqzjY5Ndxdkg90YTTgT83bomZvha4HtdaAVrcqNGOwiJ5sZ1UY0BVyKQt2vKuUjueRbYrq6Cu1T+lJ4Xqse+S0A=
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr28408842wrs.179.1577119485955;
 Mon, 23 Dec 2019 08:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20191223163546.29637-1-michael@amarulasolutions.com>
 <20191223163546.29637-2-michael@amarulasolutions.com> <CAOMZO5CzZvDSEkYcz3LzMCnLp8ZW7zNBd18LkKZWtbh0PMQvdg@mail.gmail.com>
In-Reply-To: <CAOMZO5CzZvDSEkYcz3LzMCnLp8ZW7zNBd18LkKZWtbh0PMQvdg@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 23 Dec 2019 17:44:34 +0100
Message-ID: <CAOf5uw=aRpyJPRB5kv8iGv1TkPQH_vMRSy0UoA6POWgsUiechA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6dl: Fix typo in i.CoreM6 1.5 Dual MIPI
 starter kit
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Dec 23, 2019 at 5:43 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Michael,
>
> On Mon, Dec 23, 2019 at 1:35 PM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Fix the file to be included in dual mipi starter kit. This
> > fix ethernet probing
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >  arch/arm/boot/dts/imx6dl-icore-mipi.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> > index e43bccb78ab2..d8f3821a0ffd 100644
> > --- a/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> > +++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> > @@ -8,7 +8,7 @@
> >  /dts-v1/;
> >
> >  #include "imx6dl.dtsi"
> > -#include "imx6qdl-icore.dtsi"
> > +#include "imx6qdl-icore-1.5.dtsi"
>
> Jagan submitted the same fix today:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-December/701895.html

Sorry, was not in copy. He said to me but I was not aware about one of my queue

Michael
