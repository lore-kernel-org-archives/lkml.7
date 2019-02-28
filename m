Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6998C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84BC2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S0KHlnB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbfB1Ra5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:30:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35375 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfB1Ra5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:30:57 -0500
Received: by mail-it1-f195.google.com with SMTP id 188so16928808itb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxsfEy8QIwi5UtCMRHdl1vmnvf9J7WKcthBi5S4gM9k=;
        b=S0KHlnB6ibdEy70rkjjelRCQ4ipwqcaar0MtLGA//5B3Ls3zuvsRXeJmrYpDPOkT7b
         XX57m5Cyb2TAAugtoIK78lKUSYe2rIONVxFR7JuAwpyc0MkjyorDjT7paQffARkhKYb5
         WLiiAWh//0KOlSqAuGSZ5SW7YfuzNYSB/tYZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxsfEy8QIwi5UtCMRHdl1vmnvf9J7WKcthBi5S4gM9k=;
        b=n/kz5QjiOPQ8SWzULPt4wwn3mQtr3PVrPb6P8PEvG+/tNqHVZm1kql6PHU3XYkmaUy
         5d3nVQKRKdSmsr0CJcbglVggdA4h3322eP6eM7LAXvwf7q4agSgvs7+pW2+UNi3lfXVH
         BtutGrv2mzpo2es4aHVsnVtq1SAj9MT0DxlxEaeVpGnAS7/i+++t9MKlmJ8ZE0b6P0q4
         zKchMWUYM4iqrURxzCps3MY74WngYEqlmvWxcTMvV/WIIbd5cbTAj1LIcsP3B0nytQ/u
         ymfY5e9ykKE6ilDwiZRq6N+OG98KL8AZoQ9yfUzmwOZSPSvaNSZyaRAFm7/t7SjR/4d/
         uDHQ==
X-Gm-Message-State: AHQUAuZnSAJoTLswGZqTtj7BPX3n+41AIXpe3EHqm+yUbP+bzIgE8qm3
        qiq4JedJMdWUI0S/jkBkSJU0te+Sw6qUJXiVpAwf1w==
X-Google-Smtp-Source: AHgI3IYszOofLgE7fLNMTjxiJZVzAU9FtNSowW4N8ZYiBcFQpnRTHBL64NrPJwDEFR2ZztqKVcKcxXeSv/9nzB59djQ=
X-Received: by 2002:a24:e4d:: with SMTP id 74mr397241ite.32.1551375055773;
 Thu, 28 Feb 2019 09:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20190212113808.3040-1-jagan@amarulasolutions.com> <20190228151543.GA18597@bogus>
In-Reply-To: <20190228151543.GA18597@bogus>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 28 Feb 2019 23:00:44 +0530
Message-ID: <CAMty3ZDR_Vnutobg=wjzwPZ_pkD4pLA76Lpec9u4OR8OtmuLGA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: hwmon: Add missing documentation for lm75
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 8:45 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 12, 2019 at 05:08:08PM +0530, Jagan Teki wrote:
> > Add missing dt-binding documentation for lm75 hwmon sensor.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > -  Add all compatible nodes available in lm75.
> >
> >  .../devicetree/bindings/hwmon/lm75.txt        | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
> > new file mode 100644
> > index 000000000000..12d8cf7cf592
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/lm75.txt
> > @@ -0,0 +1,37 @@
> > +*LM75 hwmon sensor.
> > +
> > +Required properties:
> > +- compatible: manufacturer and chip name, one of
> > +             "adi,adt75",
> > +             "dallas,ds1775",
> > +             "dallas,ds75",
> > +             "dallas,ds7505",
> > +             "gmt,g751",
> > +             "national,lm75",
> > +             "national,lm75a",
> > +             "national,lm75b",
> > +             "maxim,max6625",
> > +             "maxim,max6626",
> > +             "maxim,max31725",
> > +             "maxim,max31726",
> > +             "maxim,mcp980x",
> > +             "st,stds75",
> > +             "st,stlm75",
> > +             "microchip,tcn75",
> > +             "ti,tmp100",
> > +             "ti,tmp101",
> > +             "ti,tmp105",
> > +             "ti,tmp112",
> > +             "ti,tmp175",
> > +             "ti,tmp275",
> > +             "ti,tmp75",
> > +             "ti,tmp75c",
>
> Some of these are in trivial-devices.yaml already. So you either need to
> remove them from there. Or you can move all these to trivial-devices and
> benefit from having a schema. I prefer the latter, but either way is
> fine. You can remove them from trivial-devices.yaml in a separate patch,
> so:

Thanks, Rob.

I will remove trivial devices from here wrt trivial-devices.yaml in
separate patch.

Guenter, could you please pick this.
