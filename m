Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D01C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4722183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfCVNKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:10:00 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37897 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfCVNJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:09:59 -0400
X-Originating-IP: 90.88.33.153
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id ADD671BF20B;
        Fri, 22 Mar 2019 13:09:53 +0000 (UTC)
Date:   Fri, 22 Mar 2019 14:09:53 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <contact@paulk.fr>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20190322130953.kb4llrtz2nriyfbu@flea>
References: <20180328215213.29538-1-contact@paulk.fr>
 <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
 <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
 <20190321130133.zllt5pqbrhiecoch@flea>
 <20190321164138.GB11121@kroah.com>
 <20190322124622.GB25852@uda0271908>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ls5fgcgtksm3xyoa"
Content-Disposition: inline
In-Reply-To: <20190322124622.GB25852@uda0271908>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ls5fgcgtksm3xyoa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 07:46:22AM -0500, Bin Liu wrote:
> On Thu, Mar 21, 2019 at 05:41:38PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Mar 21, 2019 at 02:01:33PM +0100, Maxime Ripard wrote:
> > > Hi,
> > >
> > > I'm reviving this thread a bit, because I encountered this bug today.
> > >
> > > On Thu, Mar 21, 2019 at 11:02:10AM +0100, Bin Liu wrote:
> > > > On Sat, Apr 21, 2018 at 12:59:23PM +0200, Paul Kocialkowski wrote:
> > > > > Hi,
> > > > >
> > > > > Le vendredi 20 avril 2018 =E0 09:25 -0500, Bin Liu a =E9crit :
> > > > > > On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski wro=
te:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> > > > > > > > On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski=
 wrote:
> > > > > > > > > This allows dual-role ports to be reported as having gadg=
et mode
> > > > > > > > > by
> > > > > > > > > the
> > > > > > > > > musb_has_gadget helper. This is required to enable MUSB a=
t all
> > > > > > > > > with
> > > > > > > > > MUSB
> > > > > > > > > glue layers that set the port mode to MUSB_PORT_MODE_DUAL=
_ROLE
> > > > > > > > > at
> > > > > > > > > init.
> > > > > > > > >
> > > > > > > > > Most notably, this allows calling musb_start when needed =
in the
> > > > > > > > > virtual
> > > > > > > > > MUSB root HUB, regardless of whether the current mode sho=
uld be
> > > > > > > > > gadget
> > > > > > > > > or host.
> > > > > > > > >
> > > > > > > > > This fixes USB OTG on Allwinner devices that I could test=
 it
> > > > > > > > > with,
> > > > > > > > > mainly A20 devices.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > > > > >
> > > > > > > > Surely there's more to it than that. The gadget mode of A20=
 boards
> > > > > > > > have been working in the past, including when compiling wit=
h mUSB
> > > > > > > > setup as dual role.
> > > > > > > >
> > > > > > > > Is this a regression since a particular commit? Or is there
> > > > > > > > another,
> > > > > > > > deeper issue overlooked in the commit log?
> > > > > > >
> > > > > > > The root of the issue here is that musb_start is not called a=
t any
> > > > > > > point
> > > > > > > without this patch. My understanding of the flow is the follo=
wing:
> > > > > > > when
> > > > > > > the PHY detects that there was a VBUS/ID change, it will noti=
fy its
> > > > > > > listeners (mainly the musb sunxi glue layer). This will then
> > > > > > > schedule
> > > > > > > the driver's work (sunxi_musb_work), which does nothing since=
 the
> > > > > > > SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only set=
 after
> > > > > > > calling sunxi_musb_enable, which is called from
> > > > > > > musb_platform_enable,
> > > > > > > that originates from musb_start.
> > > > > > >
> > > > > > > Currently I see two places where musb_start is called:
> > > > > > > * musb_virthub
> > > > > > > * musb_gadget
> > > > > > >
> > > > > > > In the latter case, it is in turn called from udc_start, which
> > > > > > > should
> > > > > > > probably (correct me if I'm wrong) happen later in the call c=
hain
> > > > > > > than
> > > > > > > ID/VBUS change notification time.
> > > > > >
> > > > > > I don't think it is correct that udc_start() is triggered by ID=
/VBUS
> > > > > > events, but I don't have an Allwinner platform to verify the ca=
llflow.
> > > > >
> > > > > Yes you're right, I didn't make myself very clear here. I didn't
> > > > > investigate the udc_start call path much since it was apparently =
not the
> > > > > culprit.
> > > > >
> > > > > > Have you tried to load with a gadget driver? When a gadget func=
tion is
> > > > > > bound to UDC, udc_start() is triggered, which in turn calls
> > > > > > musb_start().
> > > > >
> > > > > It does work under that scenario, although my used case here is u=
sing
> > > > > musb with DUAL_ROLE but no gadget driver loaded. That it, I want =
the
> > > > > musb_start call to originate from the virtual hub, not from the g=
adget
> > > > > side.
> > > > >
> > > > > > > In the former case, musb_start is called in the root controll=
er hub
> > > > > > > control, when setting the USB_PORT_FEAT_POWER feature. This l=
ooks
> > > > > > > perfectly legit and IMO this is where it should be initially =
calling
> > > > > > > musb_start in the dual role case. The kernel is indeed settin=
g the
> > > > > >
> > > > > > No actually. A dual-role port should be in b_idle state by defa=
ult, so
> > > > > > logically all actions should go to the gadget path until the po=
rt
> > > > > > switches to host mode.
> > > > >
> > > > > It makes sense that the port should be in b_idle state by default=
, but
> > > > > here it fails to switch to host mode when the ID pin detects that=
 it
> > > > > should. Or does b_idle state entail that a gadget must be loaded =
(per
> > > > > the USB spec), and thus nothing should (ever) happen until that h=
appens?
> > > > >
> > > > > I find it really odd to need a gadget device to trigger host mode.
> > > > > This patch does fix the issue, but I am puzzled as to why it is n=
eeded
> > > > > in the first place. The comment above it mentions that "In OTG mo=
de we
> > > > > have to wait until we loaded a gadget. We don't really need a gad=
get if
> > > > > we operate as a host but we should not start a session as a device
> > > > > without a gadget or else we explode.", which is apparently compat=
ible
> > > > > with my use case: a gadget is not really needed and I'm not tryin=
g to
> > > > > start a session as a device without a gadget loaded.
> > > > >
> > > > > What do you think?
> > > >
> > > > Okay, this came down to an argument that whether we should require
> > > > loading a gadget driver on a dual-role port to work in host mode,
> > > > which is currently required on musb since a long long time ago.
> > > >
> > > > I understand the requirement is kinda unnecessary, but since it alr=
eady
> > > > exists on musb stack for a long time, I don't plan to change it. Be=
cause I
> > > > cannot think of a use case in real products that doesn't automatica=
lly
> > > > load a gadget function on the dual-role port.
> > > >
> > > > If you can explain a use case in real world (not a engineering lab)=
 that
> > > > the gadget driver will not be loaded at linux booting up, but later
> > > > based on user's input, I will reconsider my decision. To remove this
> > > > requirement from musb stack, the work is more than this patch.
> > >
> > > I have one for you: we're working on a device that boots pretty fast,
> > > and therefore are pushing as much things as we can to modules. It
> > > includes gadgets, the musb driver and glue, etc. That doesn't sound
> > > way very different from what a generic distro would do as well.
> > >
> > > At boot, the various modules for the hardware are loaded
> > > automatically: the musb glue, the musb core, our USB PHY, etc. We end
> > > up in a situation where the musb driver is loaded and reported to work
> > > properly. The USB cable to the OTG port (in peripheral) might or might
> > > not be connected, it's kind of irrelevant.
> > >
> > > The gadgets, however, are not loaded automatically.
> > >
> > > Now comes a user that wants to use musb as a host, and connect a
> > > proper USB adapter, that wires the ID pin properly. In our case, the
> > > phy detects it, reports the mode change, and .... nothing.
> > >
> > > That doesn't really look like an engineering lab setup to me.
> >
> > I agree, that sounds like a valid setup.
> >
> > Also realize that Android is pushing to have all drivers as modules, so
> > you will start to see a whole lot more devices out there be modular
> > instead of statically built kernels.  So issues like this are good to
> > resolve :)
>
> This issue here is not related to building all drivers as modules. Today
> we already have all musb related drivers including gadget drivers in
> modules.
>
> The issue discussed here is that when musb is configured in dual-role
> mode (dr_mode =3D 'otg' in dts), a gadget driver has to be bound to the
> udc to make musb working in host mode.
>
> I never disagree it is not ideal, but I consider it is minor - since the
> port is configured to dual-role mode, it is intended to work in
> peripheral mode, then why not automatically load the gadget driver when
> linux boots up.

Because no other controller requires it and therefore it's not
standard and violates the principle of least surprise?

And even without taking this into account, there's also the fact that
while the *hardware* can do dual role, the software might decide
otherwise. If I don't want to have support for any gadget (at all) in
the end system, then why should I be forced to compile and load
something I don't even want to use in the first place?

The same story goes with cold booting with a device plugged in, and
therefore acting as a host from the very beginning. It will never ever
be configured as a peripheral, even though you might have loaded a
module.

> To summaries my comments on this again, since it is minor in my opinion,
> I won't spend time to solve it myself (in a near future), but I am more
> than happy to review and take any patch which solve it.

Paul provided a patch that started this discussion. You mentionned
that it's not enough and other parts should be missing. What are
those?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ls5fgcgtksm3xyoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJTeoQAKCRDj7w1vZxhR
xa3xAQDsznoQw/xX3MEVTOqcNGnfQ+17N9b9LxR5R5rtgbvO+QD+NiIhUR0dfhNr
Rh/K7EEurHa63raCN6UlhcB8rwJU4wY=
=Ls7s
-----END PGP SIGNATURE-----

--ls5fgcgtksm3xyoa--
