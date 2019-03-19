Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7BF2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfCSC7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:59:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40523 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfCSC7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:59:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so4560695edw.7;
        Mon, 18 Mar 2019 19:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7ojKRYeZtXOJ5vfzkQgeS1VXXSdZA7o61qO8RoD8FI=;
        b=itCoDOFXXgO1it9bA7mLPQxe29PbxOXaoywf24enVIqUVDermi4eANxwE1TB5a9Jtu
         rbWHZIOtbncYv9dTMVWOKC6CbgCnxygti1tGDHYlkSS7dm65o91PLxahT5feA//K0wr2
         iogQ5VotaeODRz0VdenYYgvXpD3BSa9AsePeShqpqVTVPD+DqhxZ3OEl0N458eHgYA7X
         BYvlZLmnVqOJVQxFbFzRvn3Ucc7vlESCZVW9FZ0xEUgiUmH/RtmOqWnN4CaJAC2BulCT
         xJs/9FSHtGcW9PJgystn0SfKBpD81Kw6QAgVRG8kolVdgMu7jPIOZWyT/VrckNghJ9mJ
         b66A==
X-Gm-Message-State: APjAAAVjGpLL6Y6sQ/uulvqmOPCspJT2YiL3MNpgDUXLTRLzBVedhxiR
        37fmlOnryqUB0JzDaiHza6vFcd2Q4KU=
X-Google-Smtp-Source: APXvYqzWvsSMGYp7XF7+Rfg2dwL4XYAz6zYdUEAVuzMAg9m29XQIoU9Dl/cClLJzDcoNvBG8iPeudw==
X-Received: by 2002:a17:906:5583:: with SMTP id y3mr12820599ejp.42.1552964379782;
        Mon, 18 Mar 2019 19:59:39 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id o12sm3470502edt.58.2019.03.18.19.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:59:39 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id w2so19254999wrt.11;
        Mon, 18 Mar 2019 19:59:39 -0700 (PDT)
X-Received: by 2002:adf:ec87:: with SMTP id z7mr14526153wrn.44.1552964378892;
 Mon, 18 Mar 2019 19:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-5-jagan@amarulasolutions.com> <20190315133414.5zwc5qtrivrbrzow@flea>
 <CAMty3ZBn=MjB-VxwadkEDaM_==hGu1pzTv2A47cKitv0Vb5VXw@mail.gmail.com>
In-Reply-To: <CAMty3ZBn=MjB-VxwadkEDaM_==hGu1pzTv2A47cKitv0Vb5VXw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Mar 2019 10:59:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mkSTxhR_p4iRYR-hqzxw2QFK9iv3WsQ7NOQ2mT2mSiw@mail.gmail.com>
Message-ID: <CAGb2v66mkSTxhR_p4iRYR-hqzxw2QFK9iv3WsQ7NOQ2mT2mSiw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] dt-bindings: display: bridge: Add
 ICN6211 MIPI-DSI to RGB convertor bridge
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:58 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Mar 15, 2019 at 7:04 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Mar 15, 2019 at 06:38:23PM +0530, Jagan Teki wrote:
> > > ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > > It has a flexible configuration of MIPI DSI signal input
> > > and produce RGB565, RGB666, RGB888 output format.
> > >
> > > Add dt-bingings for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../display/bridge/chipone,icn6211.txt        | 36 +++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > > new file mode 100644
> > > index 000000000000..7f13efd7ee7f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > > @@ -0,0 +1,36 @@
> > > +Chipone ICN6211 MIPI-DSI to RGB Convertor Bridge
> > > +
> > > +ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > > +It has a flexible configuration of MIPI DSI signal input
> > > +and produce RGB565, RGB666, RGB888 output format.
> > > +
> > > +Required properties for RGB:
> > > +- compatible: must be "chipone,icn6211" and one of:
> > > +  * "bananapi,icn6211"
> >
> > Why is that compatible needed?
>
> chipone,icn6211 - generic compatible bridge controller IC
> bananapi,icn6211 -  compatible for icn6211 bridge using on bananapi panel
>
> I hope this would be proper bindings in terms of controller IC with
> associate device, anything wrong? Infact I used similar reference from
> Ilitek Bananapi panel from here
> Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
>
> This is what I understood based on dt-binding, correct if I'm wrong.
>
> ilitek,ili9881c - generic ilitek,ili9881c compatable
> bananapi,lhr050h41 - compatible for bananapi panel associated with
> this ilitek IC

ili9881c is an LCD driver chip with a MIPI DSI interface. It directly
drives the LCD panel, not outputting some RGB stuff. So it is a binding
and driver for a panel, not a bridge in your case.

> >
> > > +- reg: the virtual channel number of a DSI peripheral
> > > +- reset-gpios: a GPIO phandle for the reset pin
> > > +
> > > +The device node can contain following 'port' child nodes,
> > > +according to the OF graph bindings defined in [1]:
> > > +  0: DSI Input, not required, if the bridge is DSI controlled
> > > +  1: RGB Output, mandatory
> >
> > Your example doesn't have that input port
>
> Yes, I intentionally did this by referring existing bridge binding.
> Documentation/devicetree/bindings/display/bridge/toshiba,tc35876*.txt
>
> Do we really need? since the input port can be part of panel binding.

How could the input port of _your_ _bridge_ be part of the panel binding?

ChenYu
