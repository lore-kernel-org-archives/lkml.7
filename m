Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C3CC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60E2205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLQWxf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:53:35 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48316 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQWxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:53:34 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ihLiZ-0001PQ-VJ; Tue, 17 Dec 2019 23:53:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, sam@ravnborg.org
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: Add binding document for Xinpeng XPP055C272
Date:   Tue, 17 Dec 2019 23:53:27 +0100
Message-ID: <2955240.JQMRd6mdPG@diego>
In-Reply-To: <20191217160122.psxwdd6accn7soed@gilmour.lan>
References: <20191217140703.23867-1-heiko@sntech.de> <1823876.MjdJyG0ANN@diego> <20191217160122.psxwdd6accn7soed@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Am Dienstag, 17. Dezember 2019, 17:01:22 CET schrieb Maxime Ripard:
> On Tue, Dec 17, 2019 at 04:08:49PM +0100, Heiko Stübner wrote:
> > Am Dienstag, 17. Dezember 2019, 15:24:46 CET schrieb Maxime Ripard:
> > > Hi,
> > >
> > > On Tue, Dec 17, 2019 at 03:07:02PM +0100, Heiko Stuebner wrote:
> > > > From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > > >
> > > > The XPP055C272 is a 5.5" 720x1280 DSI display.
> > > >
> > > > changes in v2:
> > > > - add size info into binding title (Sam)
> > > > - add more required properties (Sam)
> > > >
> > > > Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > > > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > > > ---
> > > >  .../display/panel/xinpeng,xpp055c272.yaml     | 48 +++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> > > > new file mode 100644
> > > > index 000000000000..2d0fc97d735c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> > > > @@ -0,0 +1,48 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/panel/sony,acx424akp.yaml#
> > >
> > > The ID doesn't match the file name.
> > >
> > > Did you run dt_bindings_check?
> >
> > Thanks for that pointer ... I did run dtbs_check on the binding and was
> > sooo happy to not find any panel errors in the pages of other dt errors
> > but till now didn't realize that there's also a dtbinding_check.
> 
> dt_bindings_check is a sanity check on the bindings
> themselves. dtbs_check is using those bindings to check the device
> trees.
> 
> dtbs_check used to have a dependency on dt_bindings_check, but it got
> removed recently.
> 
> Maxime
> 
> >
> > Will keep that in mind for future bindings  - and of course fix things
> > in the next version.
> >
> >
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Xinpeng XPP055C272 5.5in 720x1280 DSI panel
> > > > +
> > > > +maintainers:
> > > > +  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: panel-common.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: xinpeng,xpp055c272
> > > > +  reg: true
> > > > +  backlight: true
> > > > +  port: true
> > >
> > > What is the port supposed to be doing?
> >
> > Hooking the display up to the dsi controller. But you're right,
> > works without port as well with these single-dsi displays.
> >
> > I just remember needing one for the Gru-Scarlet display that needed
> > to connect to two dsi controllers.
> >
> > So I'll drop the port node here and from my board devicetree.
> 
> It's not really what I meant though :)
> 
> If it's needed then we should definitely have it, but we should
> document our expectations here: is it the input port ? output? in
> which case do we want to use it since it's optional, etc.

The port was actually unnecessary. As far as I understand dsi stuff,
the common case is the panel as subnode of the dsi controller and
the controller then finding the display itself automatically.

If you look at
	"drm/bridge/synopsys: dsi: use mipi_dsi_device to find panel or bridge" [0]
I just sent, you'll see that the dw-mipi-dsi used drm_of_find_panel_or_bridge
to find its panel/bridge thus requiring port connections in all cases where
it had the dsi-device available already, so wouldn't need to use ports for it.

Or I'm completely wrong and port usage is better, we'll see :-D


Heiko


[0] https://patchwork.freedesktop.org/patch/345666/


