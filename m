Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD565C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93B220866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576883444;
	bh=wR5may7mAUmZ/CfDdApD8FEoqLFXXveiSgTP3bUJqSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sDbgLfZ75UXdG+2vWJ8bO7h7HopulU4BMJp43zJEFvSkFrxH1ZbPM6m4adpC0aDbV
	 HUGZQ2IrzMztp8MNcQoKsIlWem+Xm34h42TWRcjg3qFKlofX4w0eU33ON2dUFqSdxw
	 q0sOpbPi6LoPjEw0rh0ii7INyRBA2GnEC2frLBAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfLTXKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:10:43 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45691 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfLTXKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:10:43 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so10985994ioi.12;
        Fri, 20 Dec 2019 15:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OIn6PrxteiiCCeumPwNHhx+bzoiO5dkpRtAE3G60zXE=;
        b=GvDFrEcjEUbkQgOH9NP/Cl/JRzkR0Vjpaz4/6BWmy+wcFRh3D3Q6Fk6+d/wSIpDBjO
         5UA7WW7mclAWJVTOSlo5o5fP7yvPYCD/SVCib1lcRNpFTNNSKLQclykCNebUZZCsPXXJ
         GriLZNFbttIkv0IsffRDCghGuVv8aPp6bkhI5ho2rDg569tsBWFPiD80ELbM7vvf5qLV
         TjPlJcRHDBXRpuFO+4arevvOJnNWGfvKSOr99nc9JxYEZubjKlCeWlF01f7SS88+GQ9G
         9aNVX9Lrxb7PcTi7Kx98YgX5JaDHWvVtSxqxAZSNlJBSpZLMgLzQ4DwI60nwLHpF1QZN
         Ve1A==
X-Gm-Message-State: APjAAAVnTj0lmjwSo1Igli+3XQ8+9hwARqVGFwWi+a8V1dTZj08Abvna
        zqtLmDXX6XYR5vupxXWuAg==
X-Google-Smtp-Source: APXvYqzCnCrDwqSr2I9ZY+upYlvbICf4o4U9kOYjx5cXQ5142+g7eav5whXMKaItjrPG0hOLydb1Cg==
X-Received: by 2002:a05:6602:2209:: with SMTP id n9mr10934138ion.62.1576883442554;
        Fri, 20 Dec 2019 15:10:42 -0800 (PST)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m27sm5505377ilb.53.2019.12.20.15.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 15:10:41 -0800 (PST)
Date:   Fri, 20 Dec 2019 16:10:40 -0700
From:   Rob Herring <robh@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrey Pronin <apronin@chromium.org>
Subject: Re: [PATCH] dt-bindings: tpm: Convert cr50 binding to YAML
Message-ID: <20191220231040.GA11384@bogus>
References: <20191217005424.226858-1-swboyd@chromium.org>
 <CAD=FV=UQAgd2R=ykTCnBZuOvFFKoWu4o-3Rq=GEdrc1KKSi9cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UQAgd2R=ykTCnBZuOvFFKoWu4o-3Rq=GEdrc1KKSi9cQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:45:02AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Dec 16, 2019 at 4:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > This allows us to validate the dt binding to the implementation. Add the
> > interrupt property too, because that's required but nobody noticed when
> > the non-YAML binding was introduced.
> >
> > Cc: Andrey Pronin <apronin@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../bindings/security/tpm/google,cr50.txt     | 19 -------
> >  .../bindings/security/tpm/google,cr50.yaml    | 52 +++++++++++++++++++
> >  2 files changed, 52 insertions(+), 19 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> >  create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> > deleted file mode 100644
> > index cd69c2efdd37..000000000000
> > --- a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
> > -
> > -H1 Secure Microcontroller running Cr50 firmware provides several
> > -functions, including TPM-like functionality. It communicates over
> > -SPI using the FIFO protocol described in the PTP Spec, section 6.
> > -
> > -Required properties:
> > -- compatible: Should be "google,cr50".
> > -- spi-max-frequency: Maximum SPI frequency.
> > -
> > -Example:
> > -
> > -&spi0 {
> > -       tpm@0 {
> > -               compatible = "google,cr50";
> > -               reg = <0>;
> > -               spi-max-frequency = <800000>;
> > -       };
> > -};
> > diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
> > new file mode 100644
> > index 000000000000..8bfff0e757af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: H1 Secure Microcontroller with Cr50 Firmware on SPI Bus
> > +
> > +description:
> > +  H1 Secure Microcontroller running Cr50 firmware provides several functions,
> > +  including TPM-like functionality. It communicates over SPI using the FIFO
> > +  protocol described in the PTP Spec, section 6.
> > +
> > +maintainers:
> > +  - Andrey Pronin <apronin@chromium.org>
> 
> Does Andrey agree to be the maintainer here?
> 
> 
> I'd like to see if we can delete most of what you've written here.
> Specifically in "spi/spi-controller.yaml" you can see a really nice
> description of what SPI devices ought to look like.  Can we just
> reference that?  To do that I _think_ we actually need to break that
> description into a separate YAML file and then include it from there
> and here.  Maybe someone on the list can confirm or we can just post
> some patches for that?
> 
> 
> > +properties:
> > +  compatible:
> > +    const: google,cr50
> > +
> > +  reg:
> > +    maxItems: 1
> 
> I'm curious if you need a minItems here.  ...and if we don't somehow
> include it, should we follow 'spi-controller.yaml' and treat this like
> an int?

Really, just 'true' is sufficient as you can't say which CS number it is 
here.
> 
> 
> > +  spi-max-frequency:
> > +    maxItems: 1
> 
> This is not an array type.  Why do you need maxItems?  Should treat
> like an int?  Do we have any ranges of sane values we can put here?
> I'm sure that there is a maximum that Cr50 can talk at.
> 
> 
> > +  interrupts:
> > +    maxItems: 1
> 
> I'm curious if you need a minItems here.

No. It's implied to be the same. (The tooling adds it because that's not 
how json-schema works).

> 
> ...also: should we be trying to validate the flags at all?  AKA that
> Cr50 expects a rising edge interrupt?

You can't really because you don't know how many cells.

> 
> 
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-max-frequency
> 
> Technically spi-max-frequency might not be required (the SPI binding
> doesn't list it as such), but I guess it was before...

Generally, we expect a device knows its max and this should only be used 
it a board has a lower value. However, sometimes there's exceptions. 

Shouldn't really be debate here unless the old binding doc was wrong.

> 
> 
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +      #address-cells = <0x1>;
> > +      #size-cells = <0x0>;
> > +      tpm@0 {
> > +          compatible = "google,cr50";
> > +          reg = <0>;
> > +          spi-max-frequency = <800000>;
> > +          interrupts = <50 IRQ_TYPE_EDGE_RISING>;
> 
> I would tend to prefer seeing the interrupt parent in the example
> since it's pretty likely that the GPIO controller isn't the overall
> parent and likely that our interrupt is a GPIO.  I'm not sure the
> convention, though.

Example is fine, but shouldn't be in the schema.

> > +      };
> > +    };
> > +
> > +...
> 
> Is the "..." important here?  I guess this is only if you're trying to
> jam two bindings into the same file, but I could be wrong.  I guess a
> bunch of arm ones owned by Rob have it at the end (though the example
> doesn't?), so maybe it's right?

We won't ever have 2 because '$ref' lookups wouldn't work. 

It only matters that we are consistent because if/when we want to 
programatically edit files, the ruamel yaml parser writes out what it is 
told, not what it read in. That also means fixing these is pretty easy.

My current position is to have them, but it's not anything I check ATM 
and I forget it too.

Rob
