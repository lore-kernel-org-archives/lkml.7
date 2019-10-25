Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E72CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7277621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439996AbfJYOjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:39:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44867 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439966AbfJYOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:39:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id s71so1750796oih.11;
        Fri, 25 Oct 2019 07:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmrkU0EyW6ekd74l62CZisDPM7UJaBUWbHdpWgDUhRc=;
        b=P/ZaKQtVUQtPsJBR3LvKqInCe/v796yn8hfq0L0soz+WNvFnzxVzRTzIdCUIZUe1+h
         1on/i6g8HB9HmfLwHmfKbaXr5d0HFOguaWRFiM98qBRnbC8rnSiLyYKVYJICdMwzCsLK
         itm7YsUY73pJ/294mR8m2apSf1S+hNjcjqsqRqp0ug0tJ9bjOkNZ+PLdi1ElphINGkfR
         dCYRqqUU0eRwFpIILukXG4lywm9rclzBBMlg4EcmfkAJ2lOYbxQ+WVD3hLYCBHMP88no
         WVbiUEdcA3xAGk7wZOTfCp4INRMqu8uQ+gjs7ghnV3hA5egVWYg3rj53j7PyBaYWWHGW
         C4wg==
X-Gm-Message-State: APjAAAUBWP1tHzERBkxkx/6OTsADKwahWsBOVZs+9d4z3WRipzoyw3sr
        K9bTNSRRR2VPRwI1tMvRSfMuSoPxn+LeyVQqfE0=
X-Google-Smtp-Source: APXvYqwhRBxv9rM/yx1rcpTcB+QkajxAgUw7yDwGw6rzxQ2fmvIxjybPL4JMRVrqcbBtMQbzzKKpmFPIWK0NqnHKKg8=
X-Received: by 2002:aca:fc92:: with SMTP id a140mr3195975oii.153.1572014342793;
 Fri, 25 Oct 2019 07:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190705164221.4462-1-robh@kernel.org> <20190705164221.4462-2-robh@kernel.org>
 <CAMuHMdW86UOVp5vjdFBzjbqsG_wemjZ77LyVnc+oZ6ZDccv_cA@mail.gmail.com> <CAL_JsqJA_ZZ5CjoGrB4NofAcwMPXhnC0ddWZqZ9SXSTNAWB3cQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJA_ZZ5CjoGrB4NofAcwMPXhnC0ddWZqZ9SXSTNAWB3cQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Oct 2019 16:38:51 +0200
Message-ID: <CAMuHMdU-ubE9y3V9W_ij5OFyxNLu0LmdrH88=vkkr6uSAJrTPA@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] dt-bindings: display: Convert common panel
 bindings to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Oct 25, 2019 at 4:25 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Oct 25, 2019 at 8:07 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jul 5, 2019 at 6:46 PM Rob Herring <robh@kernel.org> wrote:
> > > Convert the common panel bindings to DT schema consolidating scattered
> > > definitions to a single schema file.
> > >
> > > The 'simple-panel' binding just a collection of properties and not a
> > > complete binding itself. All of the 'simple-panel' properties are
> > > covered by the panel-common.txt binding with the exception of the
> > > 'no-hpd' property, so add that to the schema.
> > >
> > > As there are lots of references to simple-panel.txt, just keep the file
> > > with a reference to common.yaml for now until all the bindings are
> > > converted.
> > >
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > This is now commit 821a1f7171aeea5e ("dt-bindings: display: Convert
> > common panel bindings to DT schema").
> >
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> >
> > > +  backlight:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      For panels whose backlight is controlled by an external backlight
> > > +      controller, this property contains a phandle that references the
> > > +      controller.
> >
> > This paragraph seems to apply to all nodes named "backlight", causing
> > e.g. (for ARCH=arm mach_shmobile_defconfig) "make dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/panel-common.yaml"
> > to start complaining:
> >
> >     arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: backlight:
> > {'compatible': ['pwm-backlight'], 'pwms': [[40, 2, 33333, 1]],
> > 'brightness-levels': [[0, 1, 2, 4, 8, 16, 32, 64, 128, 255]],
> > 'default-brightness-level': [[9]], 'pinctrl-0': [[41]],
> > 'pinctrl-names': ['default'], 'power-supply': [[42]], 'enable-gpios':
> > [[15, 61, 0]]} is not of type 'array'
> >     arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: backlight:
> > {'groups': ['tpu0_to2_1'], 'function': ['tpu0'], 'phandle': [[41]]} is
> > not of type 'array'
> >
> > Do you know what's wrong?
>
> I'm not seeing that. What does .../bindings/processed-schema.yaml look like?

I see it with both next-20191015 and v5.4-rc4.

- $filename: /scratch/geert/linux/linux-next/Documentation/devicetree/bindings/display/panel/panel-common.yaml
  $id: http://devicetree.org/schemas/display/panel/panel-common.yaml#
  $schema: http://devicetree.org/meta-schemas/core.yaml#
  dependencies:
    height-mm: [width-mm]
    width-mm: [height-mm]
  patternProperties: {'pinctrl-[0-9]+': true}
  properties:
    $nodename: true
    backlight: {$ref: /schemas/types.yaml#/definitions/phandle}
    ddc-i2c-bus: {$ref: /schemas/types.yaml#/definitions/phandle}
    enable-gpios: {maxItems: 1, minItems: 1}
    height-mm: {}
    label: {}
    no-hpd: {type: boolean}
    panel-timing: {type: object}
    phandle: true
    pinctrl-names: true
    port: {type: object}
    ports: {type: object}
    power-supply: {}
    reset-gpios: {maxItems: 1, minItems: 1}
    rotation:
      allOf:
      - {$ref: /schemas/types.yaml#/definitions/uint32}
      - additionalItems: false
        items:
          additionalItems: false
          items:
            enum: [0, 90, 180, 270]
          maxItems: 1
          minItems: 1
          type: array
        maxItems: 1
        minItems: 1
        type: array
    status: true
    width-mm: {}
  select:
    properties: {$nodename: true}
    required: [$nodename]
  title: Common Properties for Display Panels

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
