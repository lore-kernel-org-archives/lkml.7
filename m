Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FC6C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EF124687
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eiD5P2Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLTDWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:22:54 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:43036 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTDWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:22:54 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3794E97D;
        Fri, 20 Dec 2019 04:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1576812171;
        bh=GbjWOXoHbTc7o/70pzRDyb6harPQRgq/1uJqetbyvEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiD5P2Vs/QXwTU749YgX3ffncRsvHu/csSN90zm5CA5+AlOF58zlIMNsA70unsJOI
         eTeBk6rzNvZ3sY8nTxruTgXtU/2o65/rPpx0hz333tRbfP07RPFYLk3YE47zhV77oV
         Maus3i0cm/+PvRN9WVjB48J3KzFdIMLu27tzAQBE=
Date:   Fri, 20 Dec 2019 05:22:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH RESEND 1/4] dt-bindings: drm/bridge: analogix-anx7688:
 Add ANX7688 transmitter binding
Message-ID: <20191220032238.GA5342@pendragon.ideasonboard.com>
References: <20191211061911.238393-1-hsinyi@chromium.org>
 <20191211061911.238393-2-hsinyi@chromium.org>
 <20191219204524.GA7841@bogus>
 <CAJMQK-gYFJ-F9_rkPsxXS+qc40OwU-di2tdLLbL7x=smbRNujw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJMQK-gYFJ-F9_rkPsxXS+qc40OwU-di2tdLLbL7x=smbRNujw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On Fri, Dec 20, 2019 at 11:20:13AM +0800, Hsin-Yi Wang wrote:
> On Fri, Dec 20, 2019 at 4:45 AM Rob Herring wrote:
> > On Wed, Dec 11, 2019 at 02:19:08PM +0800, Hsin-Yi Wang wrote:
> > > From: Nicolas Boichat <drinkcat@chromium.org>
> > >
> > > Add support for analogix,anx7688
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > > Change from RFC to v1:
> > > - txt to yaml
> > > ---
> > >  .../bindings/display/bridge/anx7688.yaml      | 60 +++++++++++++++++++
> > >  1 file changed, 60 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> > > new file mode 100644
> > > index 000000000000..cf79f7cf8fdf
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/bridge/anx7688.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analogix ANX7688 SlimPort (Single-Chip Transmitter for DP over USB-C)
> > > +
> > > +maintainers:
> > > +  - Nicolas Boichat <drinkcat@chromium.org>
> > > +
> > > +description: |
> > > +  The ANX7688 is a single-chip mobile transmitter to support 4K 60 frames per
> > > +  second (4096x2160p60) or FHD 120 frames per second (1920x1080p120) video
> > > +  resolution from a smartphone or tablet with full function USB-C.
> > > +
> > > +  This binding only describes the HDMI to DP display bridge.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: analogix,anx7688
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: I2C address of the device
> > > +
> > > +  ports:
> > > +    type: object
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        type: object
> > > +        description: |
> > > +          Video port for HDMI input
> > > +
> > > +      port@1:
> > > +        type: object
> > > +        description: |
> > > +          Video port for eDP output
> > > +
> > > +    required:
> > > +      - port@0
> >
> > Sometimes you have no output?
>
> Yes, only input is required.

But what happens in that case ? What's the use of a bridge with a
non-connected output ? :-)

> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - ports
> >
> > The example will have errors because it is missing 'ports'. Run 'make
> > dt_binding_check'.
> >
> > Add:
> >
> > additionalProperties: false
> >
>
> Ack, will fix this. Thanks
>
> > > +
> > > +examples:
> > > +  - |
> > > +    anx7688: anx7688@2c {
> > > +      compatible = "analogix,anx7688";
> > > +      reg = <0x2c>;
> > > +
> > > +      port {
> > > +        anx7688_in: endpoint {
> > > +          remote-endpoint = <&hdmi0_out>;
> > > +        };
> > > +      };
> > > +    };

-- 
Regards,

Laurent Pinchart
