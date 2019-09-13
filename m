Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB2C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA10214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568402203;
	bh=AISYJ3NQvkwQVmNV8frCy190huYrvhaCspckip5zjQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NBT13xlOOGPelBa/Zzh3A3l7GYP4mer+DnB6kIR8Jo0BFfzNeoSEMdZa2bhEbWdy+
	 E8SJ3g7OXYg0QzcSs6sbiKiAW9OiFSC61wKDNS7HRmOfVwbmG+zfdYDgkltkx1mDdp
	 9NO1DQOkbpkrYVCGDMRnpWwERHVE3XzmTfVmTpHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbfIMTQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbfIMTQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:16:42 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C5B208C2;
        Fri, 13 Sep 2019 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568402201;
        bh=AISYJ3NQvkwQVmNV8frCy190huYrvhaCspckip5zjQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YDJGu4+c95xOSBSOGAj1+Zh7g8ei4vWKhhRouCm6dX6HVwOgamery8N4yoptpvH4r
         AeScyZO8AStKVZIKoew8XWSn8jDA7zbJ6RkBajQ/V02tTtD21Iqwji1ZuTd4xTDE8w
         HoSXvmlgh82FS7MAJmE/FQSYfwjRQsNDX4Q4pHhE=
Received: by mail-qt1-f178.google.com with SMTP id o12so35281449qtf.3;
        Fri, 13 Sep 2019 12:16:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVJ3BcP+TuJfPWJFqL5c6K4Far5Dc+pW9fnzznHZqb/MoBO6K72
        6OMS/FQvgTU4poVJTmHXXjtnn+KlgONA6UuSeA==
X-Google-Smtp-Source: APXvYqycYVJ08tWMMNjhro09EbkFdjZhvXMTSuliMWIbrz47QuGbCSu9TM/B1kgrl6h8xWYhrQiM27ufr4c8Ve0MxyM=
X-Received: by 2002:a0c:8a6d:: with SMTP id 42mr33214017qvu.138.1568402199814;
 Fri, 13 Sep 2019 12:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190910153409.111901-1-paul.kocialkowski@bootlin.com>
 <20190910153409.111901-2-paul.kocialkowski@bootlin.com> <20190913143510.GA9504@bogus>
 <20190913155815.GA1554@aptenodytes>
In-Reply-To: <20190913155815.GA1554@aptenodytes>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Sep 2019 20:16:28 +0100
X-Gmail-Original-Message-ID: <CAL_Jsq+dzT1xrfBy2QQHLx9MUNukWWq5eXyOecVV8h0z5ziC8g@mail.gmail.com>
Message-ID: <CAL_Jsq+dzT1xrfBy2QQHLx9MUNukWWq5eXyOecVV8h0z5ziC8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: Add xylon logicvc bindings documentation
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 4:58 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Rob and thanks for the review!
>
> On Fri 13 Sep 19, 15:35, Rob Herring wrote:
> > On Tue, Sep 10, 2019 at 05:34:08PM +0200, Paul Kocialkowski wrote:
> > > The Xylon LogiCVC is a display controller implemented as programmable
> > > logic in Xilinx FPGAs.
> > >
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  .../bindings/display/xylon,logicvc.txt        | 188 ++++++++++++++++++
> > >  1 file changed, 188 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc.txt
> >
> > Consider converting this to DT schema format. See
> > Documentation/devicetree/writing-schema.rst (.md in 5.3).
>
> Oh right, that would certainly be much more future-proof!
>
> > > diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc.txt b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > new file mode 100644
> > > index 000000000000..eb4b1553888a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > @@ -0,0 +1,188 @@
> > > +Xylon LogiCVC display controller
> > > +
> > > +The Xylon LogiCVC is a display controller that supports multiple layers.
> > > +It is usually implemented as programmable logic and was optimized for use
> > > +with Xilinx Zynq-7000 SoCs and Xilinx FPGAs.
> > > +
> > > +Because the controller is intended for use in a FPGA, most of the configuration
> > > +of the controller takes place at logic configuration bitstream synthesis time.
> > > +As a result, many of the device-tree bindings are meant to reflect the
> > > +synthesis configuration. These do not allow configuring the controller
> > > +differently than synthesis configuration.
> > > +
> > > +Layers are declared in the "layers" sub-node and have dedicated configuration.
> > > +In version 3 of the controller, each layer has fixed memory offset and address
> > > +starting from the video memory base address for its framebuffer. With version 4,
> > > +framebuffers are configured with a direct memory address instead.
> > > +
> > > +Matching synthesis parameters are provided when applicable.
> > > +
> > > +Required properties:
> > > +- compatible: Should be one of:
> > > +  "xylon,logicvc-3.02.a-display"
> > > +  "xylon,logicvc-4.01.a-display"
> > > +- reg: Physical base address and size for the controller registers.
> > > +- clocks: List of phandle and clock-specifier pairs, one for each entry
> > > +  in 'clock-names'
> > > +- clock-names: List of clock names that should at least contain:
> > > +  - "vclk": The VCLK video clock input.
> > > +- interrupts: The interrupt to use for VBLANK signaling.
> > > +- xylon,display-interface: Display interface in use, should be one of:
> > > +  - "lvds-4bits": 4-bit LVDS interface (C_DISPLAY_INTERFACE == 4).
> > > +- xylon,display-colorspace: Display output colorspace in use, should be one of:
> > > +  - "rgb": RGB colorspace (C_DISPLAY_COLOR_SPACE == 0).
> > > +- xylon,display-depth: Display output depth in use (C_PIXEL_DATA_WIDTH).
> > > +- xylon,row-stride: Fixed number of pixels in a framebuffer row (C_ROW_STRIDE).
> > > +- xylon,layers-count: The number of available layers (C_NUM_OF_LAYERS).
> >
> > Presumably some of this is determined by the display attached. Isn't it
> > safe to assume the IP was configured correctly for the intended display
> > and you can just get this from the panel?
>
> Layers are what corresponds to DRM planes, which are not actually indicated
> by the panel but are a charasteristic of the display controller. In our case,
> this is directly selected at bitstream synthesis time for the controller.
>
> So I'm afraid there is no way we can auto-detect this from the driver.

Sorry, I referring to the set of properties above. In particular,
xylon,display-interface and xylon,display-colorspace, though I don't
know if the latter is talking in memory format or on the wire format.

Actually for xylon,layers-count, You should just count the child nodes
of 'layers'.

> > > +Optional properties:
> > > +- memory-region: phandle to a node describing memory, as specified in:
> > > +  Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > +- clock-names: List of clock names that can optionally contain:
> > > +  - "vclk2": The VCLK2 doubled-rate video clock input.
> > > +  - "lvdsclk": The LVDS clock.
> > > +  - "lvdsclkn": The LVDS clock inverted.
> >
> > How are these really optional?
>
> Well, the controller currently only supports LVDS, but more interfaces may be
> added later, so the lvdsclk clock will be optional when another interface
> is used instead. Maybe I'm mistaken about how to categorize them though.
>
> My understanding is that the need for vclk2 and lvdsclkn depend on the target
> FPGA family. I've developped the driver without the need for them, but the
> datasheet states that they may be needed (but doesn't provide significant
> details about their role though).

Not sure what to tell you then. You'll see it becomes a bit messy to
describe in schema. Ideally we define the exact number, order, and
values possible (or sets of those).

> > > +- xylon,syscon: Syscon phandle representing the logicvc instance.
> > > +- xylon,dithering: Dithering module is enabled (C_XCOLOR).
> > > +- xylon,background-layer: The last layer is used to display a black background
> > > +  (C_USE_BACKGROUND). It must still be registered.
> > > +- xylon,layers-configurable: Configuration of layers' size, position and offset
> > > +  is enabled (C_USE_SIZE_POSITION).
> >
> > I would think this will effectively have to be enabled to make this
> > usable with DRM. I'm not sure if a "standard" userspace would use any of
> > the layers if all this is fixed.
>
> I was going with the same assumption, but drm_atomic_helper_check_plane_state
> has a can_position parameter, which will check that the plane covers the
> whole CRTC if set to false. So I guess it is somewhat expected that this can
> be the case and some drivers (e.g. arm/hdlcd_crtc.c) also set this to false.

Certainly atomic can fail on anything not supported. My question is
more whether userspace has some minimum requirements. A cursor
couldn't deal with can_position=false for example.

> I guess this falls under a more generic discussion of what should be expected
> by userspace when it comes to DRM. Since drivers may reject commits because of
> any hardware-specific limitation, there is definitely a significant grey area
> there and apparently no common rule.
>
> > > +
> > > +Required sub-nodes:
> > > +- layers: The description of the display controller layers, containing layer
> > > +  sub-nodes that each describe a registered layer.
> > > +- ports: The LogiCVC connection to an encoder input port. The connection
> > > +  is modeled using the OF graph bindings, as specified in:
> > > +  Documentation/devicetree/bindings/graph.txt
> > > +
> > > +Required layer properties:
> > > +- reg: Layer index (from front to back, starting at 0).
> > > +- xylon,layer-depth: Layer depth in use (C_LAYER_0_DATA_WIDTH).
> > > +- xylon,layer-colorspace: Layer colorspace in use, should be one of:
> > > + - "rgb": RGB colorspace (C_LAYER_*_TYPE == 0).
> >
> > Why is this needed if there's only 1?
>
> The hardware supports more but support is no implemented yet, so the binding
> document may be enriched along with the driver in the future.
>
> Should I describe other colorspaces even if they are not currently supported?

Document what the h/w supports to the extent you can. Then we can make
better decisions.

> > > +- xylon,layer-alpha-mode: Alpha mode for the layer, should be one of:
> > > + - "layer": Alpha is configured layer-wide (C_LAYER_*_ALPHA_MODE == 0).
> > > + - "pixel": Alpha is configured per-pixel (C_LAYER_*_ALPHA_MODE == 1).
> >
> > Could just be boolean.
>
> In this instance too, there are other modes that are not yet implemented but
> supported by the hardware, so I did not describe them yet but they may be added
> later.
>
> > > +- xylon,layer-base-offset: offset in number of lines (C_LAYER_*_OFFSET) starting
> > > +  from the video RAM base (C_VMEM_BASEADDR), only for version 3.
> > > +- xylon,layer-buffer-offset: offset in number of lines (C_BUFFER_*_OFFSET)
> > > +  starting from the layer base offset for the second buffer used in
> > > +  double-buffering.
> >
> > It might be better to define all this in terms of byte offsets. I'd
> > guess that is what CPU accesses are going to need.
>
> I agree that it is more convenient from a driver's perspective, but the
> rationale is that this allows copying parameters directly from the synthesis
> configuration file, where these are expressed as a number of lines.
>
> I would like to keep both delcarations as close to eachother as possible, as to
> facilitate integration work for future users of the driver. But maybe this is a
> bit too much in that case. What do you think?

Fair enough. I'd feel differently if I thought this would be common,
but this seems to be a pretty specific usecase. I guess there could be
other fixed at synthesis h/w.

Rob
