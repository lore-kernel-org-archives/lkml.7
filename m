Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10BBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6024B20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfIWPdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:33:16 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:39821 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIWPdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:33:16 -0400
Received: from aptenodytes (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8048020000E;
        Mon, 23 Sep 2019 15:33:11 +0000 (UTC)
Date:   Mon, 23 Sep 2019 17:33:11 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/2] dt-bindings: display: Add xylon logicvc bindings
 documentation
Message-ID: <20190923153311.GE57525@aptenodytes>
References: <20190910153409.111901-1-paul.kocialkowski@bootlin.com>
 <20190910153409.111901-2-paul.kocialkowski@bootlin.com>
 <20190913143510.GA9504@bogus>
 <20190913155815.GA1554@aptenodytes>
 <CAL_Jsq+dzT1xrfBy2QQHLx9MUNukWWq5eXyOecVV8h0z5ziC8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+dzT1xrfBy2QQHLx9MUNukWWq5eXyOecVV8h0z5ziC8g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 13 Sep 19, 20:16, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 4:58 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > Hi Rob and thanks for the review!
> >
> > On Fri 13 Sep 19, 15:35, Rob Herring wrote:
> > > On Tue, Sep 10, 2019 at 05:34:08PM +0200, Paul Kocialkowski wrote:
> > > > The Xylon LogiCVC is a display controller implemented as programmab=
le
> > > > logic in Xilinx FPGAs.
> > > >
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  .../bindings/display/xylon,logicvc.txt        | 188 ++++++++++++++=
++++
> > > >  1 file changed, 188 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/xylon=
,logicvc.txt
> > >
> > > Consider converting this to DT schema format. See
> > > Documentation/devicetree/writing-schema.rst (.md in 5.3).
> >
> > Oh right, that would certainly be much more future-proof!
> >
> > > > diff --git a/Documentation/devicetree/bindings/display/xylon,logicv=
c.txt b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > > new file mode 100644
> > > > index 000000000000..eb4b1553888a
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > > @@ -0,0 +1,188 @@
> > > > +Xylon LogiCVC display controller
> > > > +
> > > > +The Xylon LogiCVC is a display controller that supports multiple l=
ayers.
> > > > +It is usually implemented as programmable logic and was optimized =
for use
> > > > +with Xilinx Zynq-7000 SoCs and Xilinx FPGAs.
> > > > +
> > > > +Because the controller is intended for use in a FPGA, most of the =
configuration
> > > > +of the controller takes place at logic configuration bitstream syn=
thesis time.
> > > > +As a result, many of the device-tree bindings are meant to reflect=
 the
> > > > +synthesis configuration. These do not allow configuring the contro=
ller
> > > > +differently than synthesis configuration.
> > > > +
> > > > +Layers are declared in the "layers" sub-node and have dedicated co=
nfiguration.
> > > > +In version 3 of the controller, each layer has fixed memory offset=
 and address
> > > > +starting from the video memory base address for its framebuffer. W=
ith version 4,
> > > > +framebuffers are configured with a direct memory address instead.
> > > > +
> > > > +Matching synthesis parameters are provided when applicable.
> > > > +
> > > > +Required properties:
> > > > +- compatible: Should be one of:
> > > > +  "xylon,logicvc-3.02.a-display"
> > > > +  "xylon,logicvc-4.01.a-display"
> > > > +- reg: Physical base address and size for the controller registers.
> > > > +- clocks: List of phandle and clock-specifier pairs, one for each =
entry
> > > > +  in 'clock-names'
> > > > +- clock-names: List of clock names that should at least contain:
> > > > +  - "vclk": The VCLK video clock input.
> > > > +- interrupts: The interrupt to use for VBLANK signaling.
> > > > +- xylon,display-interface: Display interface in use, should be one=
 of:
> > > > +  - "lvds-4bits": 4-bit LVDS interface (C_DISPLAY_INTERFACE =3D=3D=
 4).
> > > > +- xylon,display-colorspace: Display output colorspace in use, shou=
ld be one of:
> > > > +  - "rgb": RGB colorspace (C_DISPLAY_COLOR_SPACE =3D=3D 0).
> > > > +- xylon,display-depth: Display output depth in use (C_PIXEL_DATA_W=
IDTH).
> > > > +- xylon,row-stride: Fixed number of pixels in a framebuffer row (C=
_ROW_STRIDE).
> > > > +- xylon,layers-count: The number of available layers (C_NUM_OF_LAY=
ERS).
> > >
> > > Presumably some of this is determined by the display attached. Isn't =
it
> > > safe to assume the IP was configured correctly for the intended displ=
ay
> > > and you can just get this from the panel?
> >
> > Layers are what corresponds to DRM planes, which are not actually indic=
ated
> > by the panel but are a charasteristic of the display controller. In our=
 case,
> > this is directly selected at bitstream synthesis time for the controlle=
r.
> >
> > So I'm afraid there is no way we can auto-detect this from the driver.
>=20
> Sorry, I referring to the set of properties above. In particular,
> xylon,display-interface and xylon,display-colorspace, though I don't
> know if the latter is talking in memory format or on the wire format.

Both of these are about the wire format, which is also "hardcoded" at synth=
esis
time with no way to be detected afterwards, as far as I know. Memory format=
 is
described in the layer sub-nodes.

> Actually for xylon,layers-count, You should just count the child nodes
> of 'layers'.

Oh that's a good point, thanks!

> > > > +Optional properties:
> > > > +- memory-region: phandle to a node describing memory, as specified=
 in:
> > > > +  Documentation/devicetree/bindings/reserved-memory/reserved-memor=
y.txt
> > > > +- clock-names: List of clock names that can optionally contain:
> > > > +  - "vclk2": The VCLK2 doubled-rate video clock input.
> > > > +  - "lvdsclk": The LVDS clock.
> > > > +  - "lvdsclkn": The LVDS clock inverted.
> > >
> > > How are these really optional?
> >
> > Well, the controller currently only supports LVDS, but more interfaces =
may be
> > added later, so the lvdsclk clock will be optional when another interfa=
ce
> > is used instead. Maybe I'm mistaken about how to categorize them though.
> >
> > My understanding is that the need for vclk2 and lvdsclkn depend on the =
target
> > FPGA family. I've developped the driver without the need for them, but =
the
> > datasheet states that they may be needed (but doesn't provide significa=
nt
> > details about their role though).
>=20
> Not sure what to tell you then. You'll see it becomes a bit messy to
> describe in schema. Ideally we define the exact number, order, and
> values possible (or sets of those).

I'll try to do my best.

> > > > +- xylon,syscon: Syscon phandle representing the logicvc instance.
> > > > +- xylon,dithering: Dithering module is enabled (C_XCOLOR).
> > > > +- xylon,background-layer: The last layer is used to display a blac=
k background
> > > > +  (C_USE_BACKGROUND). It must still be registered.
> > > > +- xylon,layers-configurable: Configuration of layers' size, positi=
on and offset
> > > > +  is enabled (C_USE_SIZE_POSITION).
> > >
> > > I would think this will effectively have to be enabled to make this
> > > usable with DRM. I'm not sure if a "standard" userspace would use any=
 of
> > > the layers if all this is fixed.
> >
> > I was going with the same assumption, but drm_atomic_helper_check_plane=
_state
> > has a can_position parameter, which will check that the plane covers the
> > whole CRTC if set to false. So I guess it is somewhat expected that thi=
s can
> > be the case and some drivers (e.g. arm/hdlcd_crtc.c) also set this to f=
alse.
>=20
> Certainly atomic can fail on anything not supported. My question is
> more whether userspace has some minimum requirements. A cursor
> couldn't deal with can_position=3Dfalse for example.

Right, so I suppose that using an overlay plane as cursor wouldn't work
in this situation. Well, I haven't found any formal definition of what mini=
mal
requirements are expected from overlay planes. I would expect userspace that
tries to use an overlay plane as a cursor to have a software fallback as so=
on
as something goes wrong. My feeling is that overlay planes are provided on a
"best-effort" basis, though contradiction is welcome here.

> > I guess this falls under a more generic discussion of what should be ex=
pected
> > by userspace when it comes to DRM. Since drivers may reject commits bec=
ause of
> > any hardware-specific limitation, there is definitely a significant gre=
y area
> > there and apparently no common rule.
> >
> > > > +
> > > > +Required sub-nodes:
> > > > +- layers: The description of the display controller layers, contai=
ning layer
> > > > +  sub-nodes that each describe a registered layer.
> > > > +- ports: The LogiCVC connection to an encoder input port. The conn=
ection
> > > > +  is modeled using the OF graph bindings, as specified in:
> > > > +  Documentation/devicetree/bindings/graph.txt
> > > > +
> > > > +Required layer properties:
> > > > +- reg: Layer index (from front to back, starting at 0).
> > > > +- xylon,layer-depth: Layer depth in use (C_LAYER_0_DATA_WIDTH).
> > > > +- xylon,layer-colorspace: Layer colorspace in use, should be one o=
f:
> > > > + - "rgb": RGB colorspace (C_LAYER_*_TYPE =3D=3D 0).
> > >
> > > Why is this needed if there's only 1?
> >
> > The hardware supports more but support is no implemented yet, so the bi=
nding
> > document may be enriched along with the driver in the future.
> >
> > Should I describe other colorspaces even if they are not currently supp=
orted?
>=20
> Document what the h/w supports to the extent you can. Then we can make
> better decisions.

Okay then, I'll include those well-known other possibilities in the descrip=
tion.
Hopefully users will take the description for what it is and refrain from
expecting that the driver currently supports all that is described.

Thanks for the follow-up!

Cheers,

Paul

> > > > +- xylon,layer-alpha-mode: Alpha mode for the layer, should be one =
of:
> > > > + - "layer": Alpha is configured layer-wide (C_LAYER_*_ALPHA_MODE =
=3D=3D 0).
> > > > + - "pixel": Alpha is configured per-pixel (C_LAYER_*_ALPHA_MODE =
=3D=3D 1).
> > >
> > > Could just be boolean.
> >
> > In this instance too, there are other modes that are not yet implemente=
d but
> > supported by the hardware, so I did not describe them yet but they may =
be added
> > later.
> >
> > > > +- xylon,layer-base-offset: offset in number of lines (C_LAYER_*_OF=
FSET) starting
> > > > +  from the video RAM base (C_VMEM_BASEADDR), only for version 3.
> > > > +- xylon,layer-buffer-offset: offset in number of lines (C_BUFFER_*=
_OFFSET)
> > > > +  starting from the layer base offset for the second buffer used in
> > > > +  double-buffering.
> > >
> > > It might be better to define all this in terms of byte offsets. I'd
> > > guess that is what CPU accesses are going to need.
> >
> > I agree that it is more convenient from a driver's perspective, but the
> > rationale is that this allows copying parameters directly from the synt=
hesis
> > configuration file, where these are expressed as a number of lines.
> >
> > I would like to keep both delcarations as close to eachother as possibl=
e, as to
> > facilitate integration work for future users of the driver. But maybe t=
his is a
> > bit too much in that case. What do you think?
>=20
> Fair enough. I'd feel differently if I thought this would be common,
> but this seems to be a pretty specific usecase. I guess there could be
> other fixed at synthesis h/w.
>=20
> Rob

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl2I5bcACgkQ3cLmz3+f
v9EgsAf/fH5F+rMgJFkv937AL/QCvDgvbz/HWC9S4a4+EjVcX3PyRHFiTnAl+cHQ
i5g5rkx3+4rSXMCaaWEZs+XHFFwQH2BrCp5nn5qZtFjeaBr8Zk21H+pEdYccy9CX
cQINtFy5dFUmo6Vr+nlDuNkP/V/Z0c4z+3fjnZG/Y6aZwQ0E7VrgFQ0TZpJuSKNV
LOKxNMq37ojLPvOAtoLD+qcNUqtsGNPvYPJl0r0hSuvaeftB5b+dut9YijxJD1of
pcBq+9zNonjJGANYH1bezu7tIes9s80zqHE19qoq2CaFS+bc9SSqFm+YgiQAcn+c
EjOMPmY+fFS/kmaITBA3ApvcuV2M7A==
=BNzK
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
