Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21F3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3220678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbfIQITP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:19:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41759 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIQITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:19:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id g13so2249463otp.8;
        Tue, 17 Sep 2019 01:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2J+JQRXAUMCmWNHYDvwwUgeEBMmyLbfnHjhrSTs8DY=;
        b=P8fIwR8e/ln45RA/JSw9MPiezjsLL7qsIL4EsHsSxjwSik0BIizPvYHGsPRk6Nm9RG
         X/2UZZh+lGxfVxN1WGPdE0lNAcISntnhktTJY1nWWWUtHBau8uO+GP625OnZU6nBNyZa
         Om7m8+FH+Fx/23PjBlj7KPUkmI2v4uCR5Uk9NCD4LLrDcVU9nXY45ByngDgNN0gAncco
         C8ODUJl28BgLJUg8BRtoVViiZhzdNB/XPhotTOgML6pORU+k5n0vd5KrIb7eWI7SMTt0
         UhvMKfPY0RWzwbuffauxiVGnxQT1Xr4SA1IGSs1OAkidQ2yAGAolvpHngN2HnEG3oYNU
         sdEA==
X-Gm-Message-State: APjAAAXCBOpVIgg85QHAtxKT5ivYxH5bA/S4dE8Fk2MeZWx6PVJC1AlJ
        K2hbet2vwQtk4MdWGok7iakBt/zLbBJfUE8gCPpkkw==
X-Google-Smtp-Source: APXvYqzq2Yu5MnzUslhoUU254YRm1rz6c6w8pUTj86P5+gh+qLMOEWNJURu/rUMkdYyg2KOe+cTHO6eoPQb2Xat9ERs=
X-Received: by 2002:a9d:5a06:: with SMTP id v6mr1760766oth.250.1568708354577;
 Tue, 17 Sep 2019 01:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190917075850.40039-1-biwen.li@nxp.com>
In-Reply-To: <20190917075850.40039-1-biwen.li@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Sep 2019 10:19:03 +0200
Message-ID: <CAMuHMdUWue6-51Za7vejk=QkhV80iBXdc1E+6aTmQsvpB5AP-A@mail.gmail.com>
Subject: Re: [PATCH] devicetree: property-units: Add kohms unit
To:     Biwen Li <biwen.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biwen,

On Tue, Sep 17, 2019 at 10:09 AM Biwen Li <biwen.li@nxp.com> wrote:
> The patch adds kohms unit
>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -27,6 +27,7 @@ Electricity
>  -microamp      : microampere
>  -microamp-hours : microampere hour
>  -ohms          : ohm
> +-kohms         : kiloohm
>  -micro-ohms    : microohm
>  -microwatt-hours: microwatt hour
>  -microvolt     : microvolt

What's your rationale for adding "kohms"?
Do you need to specify resistance values that do not fit in 32-bit, and
thus cannot be specified using "ohms"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
