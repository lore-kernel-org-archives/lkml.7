Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0A6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064A218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfLQPI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:08:59 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45248 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfLQPI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:08:57 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ihESw-0007uN-KC; Tue, 17 Dec 2019 16:08:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, sam@ravnborg.org
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: Add binding document for Xinpeng XPP055C272
Date:   Tue, 17 Dec 2019 16:08:49 +0100
Message-ID: <1823876.MjdJyG0ANN@diego>
In-Reply-To: <20191217142446.yexcmh5ox4336qmd@gilmour.lan>
References: <20191217140703.23867-1-heiko@sntech.de> <20191217140703.23867-2-heiko@sntech.de> <20191217142446.yexcmh5ox4336qmd@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. Dezember 2019, 15:24:46 CET schrieb Maxime Ripard:
> Hi,
> 
> On Tue, Dec 17, 2019 at 03:07:02PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> >
> > The XPP055C272 is a 5.5" 720x1280 DSI display.
> >
> > changes in v2:
> > - add size info into binding title (Sam)
> > - add more required properties (Sam)
> >
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > ---
> >  .../display/panel/xinpeng,xpp055c272.yaml     | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> > new file mode 100644
> > index 000000000000..2d0fc97d735c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/sony,acx424akp.yaml#
> 
> The ID doesn't match the file name.
> 
> Did you run dt_bindings_check?

Thanks for that pointer ... I did run dtbs_check on the binding and was
sooo happy to not find any panel errors in the pages of other dt errors
but till now didn't realize that there's also a dtbinding_check.

Will keep that in mind for future bindings  - and of course fix things
in the next version.


> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xinpeng XPP055C272 5.5in 720x1280 DSI panel
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: xinpeng,xpp055c272
> > +  reg: true
> > +  backlight: true
> > +  port: true
> 
> What is the port supposed to be doing?

Hooking the display up to the dsi controller. But you're right,
works without port as well with these single-dsi displays.

I just remember needing one for the Gru-Scarlet display that needed
to connect to two dsi controllers.

So I'll drop the port node here and from my board devicetree.

Thanks for the review
Heiko


> 
> > +  reset-gpios: true
> > +  iovcc-supply:
> > +     description: regulator that supplies the iovcc voltage
> > +  vci-supply:
> > +     description: regulator that supplies the vci voltage
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - backlight
> > +  - iovcc-supply
> > +  - vci-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    dsi@ff450000 {
> > +        panel@0 {
> > +            compatible = "xinpeng,xpp055c272";
> > +            reg = <0>;
> > +            backlight = <&backlight>;
> > +            iovcc-supply = <&vcc_1v8>;
> > +            vci-supply = <&vcc3v3_lcd>;
> > +        };
> > +    };
> > +
> > +...
> 
> Thanks!
> Maxime
> 




