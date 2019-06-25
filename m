Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3501C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DED21655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561472133;
	bh=CSPPQvXxxLJHjaf7mkYaItL0XCi+kuQqJ8aFZvaSQm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZVz81vFc3UHLzF7OdkNyyidkii9BTmv1xUkyEc5WEbv7cxzVxeGQoc7bI5wXSgRh5
	 Y8/cFtt+VHvVQKphqf4pP2oe5GGrufQGFJ2yFw4fXNoz5XNBxcRV7LJFGyISHqZUBp
	 tuq97CjYj56lbCcEtJgo5mYtqczY3Mupjtq94RbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfFYOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfFYOPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:15:32 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971C021655;
        Tue, 25 Jun 2019 14:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561472130;
        bh=CSPPQvXxxLJHjaf7mkYaItL0XCi+kuQqJ8aFZvaSQm4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V8WtBeSoOtEfNzciSHEA3eF3ej1jkECegr5DZ2OYjOzIPhWsp2Qh/VZPOSVHXnl1s
         l4cBB1coaSY9tOZx5+pqs2pK4cFlxPurht3JDscmUVkCZchTb663MaJM8pc/6EROaj
         vN1AoNoU+XADmmdcbUoLpBqIrw9UguN76bgTpxog=
Received: by mail-qk1-f179.google.com with SMTP id l128so12698492qke.2;
        Tue, 25 Jun 2019 07:15:30 -0700 (PDT)
X-Gm-Message-State: APjAAAUoz84m8BghnQeugmYDYcfAq58XWwR2kwTQ+Ohc74JHOqsIPPtW
        FRwyZMEwTNmX+nfMK5ynecfZYPIOfCiZM89OGA==
X-Google-Smtp-Source: APXvYqxa6TVufszE/k5zs2VqtcN0LZDhjRXpJC1lxui07oIGK8cq4yrxwm2/cWvAG89bDUtj9YcBt3/wHOVAhSm8bTM=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr55002727qke.223.1561472129808;
 Tue, 25 Jun 2019 07:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190624215649.8939-1-robh@kernel.org> <20190624215649.8939-7-robh@kernel.org>
 <20190625075542.u5kzex4cbrcss5ga@flea>
In-Reply-To: <20190625075542.u5kzex4cbrcss5ga@flea>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Jun 2019 08:15:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+OgNgS7yVgZaVLEo6=OeS9R9ebgBpUbPxz609C7G9oOw@mail.gmail.com>
Message-ID: <CAL_Jsq+OgNgS7yVgZaVLEo6=OeS9R9ebgBpUbPxz609C7G9oOw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] dt-bindings: display: Convert dlc,dlc0700yzg-1
 panel to DT schema
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 1:55 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Mon, Jun 24, 2019 at 03:56:40PM -0600, Rob Herring wrote:
> > Convert the dlc,dlc0700yzg-1 panel binding to DT schema.
> >
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../display/panel/dlc,dlc0700yzg-1.txt        | 13 ---------
> >  .../display/panel/dlc,dlc0700yzg-1.yaml       | 28 +++++++++++++++++++
> >  2 files changed, 28 insertions(+), 13 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
> > deleted file mode 100644
> > index bf06bb025b08..000000000000
> > --- a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
> > +++ /dev/null
> > @@ -1,13 +0,0 @@
> > -DLC Display Co. DLC0700YZG-1 7.0" WSVGA TFT LCD panel
> > -
> > -Required properties:
> > -- compatible: should be "dlc,dlc0700yzg-1"
> > -- power-supply: See simple-panel.txt
> > -
> > -Optional properties:
> > -- reset-gpios: See panel-common.txt
> > -- enable-gpios: See simple-panel.txt
> > -- backlight: See simple-panel.txt
> > -
> > -This binding is compatible with the simple-panel binding, which is specified
> > -in simple-panel.txt in this directory.
> > diff --git a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
> > new file mode 100644
> > index 000000000000..1b0b63d46f3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
> > @@ -0,0 +1,28 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/dlc,dlc0700yzg-1.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DLC Display Co. DLC0700YZG-1 7.0" WSVGA TFT LCD panel
> > +
> > +maintainers:
> > +  - Philipp Zabel <p.zabel@pengutronix.de>
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: dlc,dlc0700yzg-1
> > +
> > +  reset-gpios: true
> > +  enable-gpios: true
> > +  backlight: true
>
> Do we need to list them?
>
> Since we don't have additionalItems, it doesn't really change anything
> since it will be validated by panel-common.

I've gone back and forth on it. I think we need to express what
properties from the common properties apply for a particular panel.
I've been requiring panel bindings to be explicit here rather than
just say "uses the simple-panel binding." For example, if
'power-supply' is not listed, does the panel have a single supply or
multiple supplies that haven't haven't been considered?

> Either way, it should be consistent between your patches, and the
> previous patches in this series didn't list all the properties in the
> binding.

Indeed.

Rob
