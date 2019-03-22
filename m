Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22919C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88AF2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfCVNqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:46:35 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:54111 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfCVNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:46:34 -0400
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 824E2100002;
        Fri, 22 Mar 2019 13:46:31 +0000 (UTC)
Date:   Fri, 22 Mar 2019 14:46:30 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <contact@paulk.fr>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20190322134630.c4cauwj5smxvj77y@flea>
References: <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
 <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
 <20190321130133.zllt5pqbrhiecoch@flea>
 <20190321164138.GB11121@kroah.com>
 <20190322124622.GB25852@uda0271908>
 <20190322130953.kb4llrtz2nriyfbu@flea>
 <20190322132846.GD25852@uda0271908>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sehda5tzdbkaj7xu"
Content-Disposition: inline
In-Reply-To: <20190322132846.GD25852@uda0271908>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sehda5tzdbkaj7xu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 08:28:46AM -0500, Bin Liu wrote:
> On Fri, Mar 22, 2019 at 02:09:53PM +0100, Maxime Ripard wrote:
> > On Fri, Mar 22, 2019 at 07:46:22AM -0500, Bin Liu wrote:
> > > On Thu, Mar 21, 2019 at 05:41:38PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Mar 21, 2019 at 02:01:33PM +0100, Maxime Ripard wrote:
> > > > > Hi,
> > > > >
> > > > > I'm reviving this thread a bit, because I encountered this bug to=
day.
> > > > >
> > > > > On Thu, Mar 21, 2019 at 11:02:10AM +0100, Bin Liu wrote:
> > > > > > On Sat, Apr 21, 2018 at 12:59:23PM +0200, Paul Kocialkowski wro=
te:
> > > > > > > Hi,
> > > > > > >
> > > > > > > Le vendredi 20 avril 2018 =E0 09:25 -0500, Bin Liu a =E9crit :
> > > > > > > > On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski=
 wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> > > > > > > > > > On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialko=
wski wrote:
> > > > > > > > > > > This allows dual-role ports to be reported as having =
gadget mode
> > > > > > > > > > > by
> > > > > > > > > > > the
> > > > > > > > > > > musb_has_gadget helper. This is required to enable MU=
SB at all
> > > > > > > > > > > with
> > > > > > > > > > > MUSB
> > > > > > > > > > > glue layers that set the port mode to MUSB_PORT_MODE_=
DUAL_ROLE
> > > > > > > > > > > at
> > > > > > > > > > > init.
> > > > > > > > > > >
> > > > > > > > > > > Most notably, this allows calling musb_start when nee=
ded in the
> > > > > > > > > > > virtual
> > > > > > > > > > > MUSB root HUB, regardless of whether the current mode=
 should be
> > > > > > > > > > > gadget
> > > > > > > > > > > or host.
> > > > > > > > > > >
> > > > > > > > > > > This fixes USB OTG on Allwinner devices that I could =
test it
> > > > > > > > > > > with,
> > > > > > > > > > > mainly A20 devices.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > > > > > > >
> > > > > > > > > > Surely there's more to it than that. The gadget mode of=
 A20 boards
> > > > > > > > > > have been working in the past, including when compiling=
 with mUSB
> > > > > > > > > > setup as dual role.
> > > > > > > > > >
> > > > > > > > > > Is this a regression since a particular commit? Or is t=
here
> > > > > > > > > > another,
> > > > > > > > > > deeper issue overlooked in the commit log?
> > > > > > > > >
> > > > > > > > > The root of the issue here is that musb_start is not call=
ed at any
> > > > > > > > > point
> > > > > > > > > without this patch. My understanding of the flow is the f=
ollowing:
> > > > > > > > > when
> > > > > > > > > the PHY detects that there was a VBUS/ID change, it will =
notify its
> > > > > > > > > listeners (mainly the musb sunxi glue layer). This will t=
hen
> > > > > > > > > schedule
> > > > > > > > > the driver's work (sunxi_musb_work), which does nothing s=
ince the
> > > > > > > > > SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only=
 set after
> > > > > > > > > calling sunxi_musb_enable, which is called from
> > > > > > > > > musb_platform_enable,
> > > > > > > > > that originates from musb_start.
> > > > > > > > >
> > > > > > > > > Currently I see two places where musb_start is called:
> > > > > > > > > * musb_virthub
> > > > > > > > > * musb_gadget
> > > > > > > > >
> > > > > > > > > In the latter case, it is in turn called from udc_start, =
which
> > > > > > > > > should
> > > > > > > > > probably (correct me if I'm wrong) happen later in the ca=
ll chain
> > > > > > > > > than
> > > > > > > > > ID/VBUS change notification time.
> > > > > > > >
> > > > > > > > I don't think it is correct that udc_start() is triggered b=
y ID/VBUS
> > > > > > > > events, but I don't have an Allwinner platform to verify th=
e callflow.
> > > > > > >
> > > > > > > Yes you're right, I didn't make myself very clear here. I did=
n't
> > > > > > > investigate the udc_start call path much since it was apparen=
tly not the
> > > > > > > culprit.
> > > > > > >
> > > > > > > > Have you tried to load with a gadget driver? When a gadget =
function is
> > > > > > > > bound to UDC, udc_start() is triggered, which in turn calls
> > > > > > > > musb_start().
> > > > > > >
> > > > > > > It does work under that scenario, although my used case here =
is using
> > > > > > > musb with DUAL_ROLE but no gadget driver loaded. That it, I w=
ant the
> > > > > > > musb_start call to originate from the virtual hub, not from t=
he gadget
> > > > > > > side.
> > > > > > >
> > > > > > > > > In the former case, musb_start is called in the root cont=
roller hub
> > > > > > > > > control, when setting the USB_PORT_FEAT_POWER feature. Th=
is looks
> > > > > > > > > perfectly legit and IMO this is where it should be initia=
lly calling
> > > > > > > > > musb_start in the dual role case. The kernel is indeed se=
tting the
> > > > > > > >
> > > > > > > > No actually. A dual-role port should be in b_idle state by =
default, so
> > > > > > > > logically all actions should go to the gadget path until th=
e port
> > > > > > > > switches to host mode.
> > > > > > >
> > > > > > > It makes sense that the port should be in b_idle state by def=
ault, but
> > > > > > > here it fails to switch to host mode when the ID pin detects =
that it
> > > > > > > should. Or does b_idle state entail that a gadget must be loa=
ded (per
> > > > > > > the USB spec), and thus nothing should (ever) happen until th=
at happens?
> > > > > > >
> > > > > > > I find it really odd to need a gadget device to trigger host =
mode.
> > > > > > > This patch does fix the issue, but I am puzzled as to why it =
is needed
> > > > > > > in the first place. The comment above it mentions that "In OT=
G mode we
> > > > > > > have to wait until we loaded a gadget. We don't really need a=
 gadget if
> > > > > > > we operate as a host but we should not start a session as a d=
evice
> > > > > > > without a gadget or else we explode.", which is apparently co=
mpatible
> > > > > > > with my use case: a gadget is not really needed and I'm not t=
rying to
> > > > > > > start a session as a device without a gadget loaded.
> > > > > > >
> > > > > > > What do you think?
> > > > > >
> > > > > > Okay, this came down to an argument that whether we should requ=
ire
> > > > > > loading a gadget driver on a dual-role port to work in host mod=
e,
> > > > > > which is currently required on musb since a long long time ago.
> > > > > >
> > > > > > I understand the requirement is kinda unnecessary, but since it=
 already
> > > > > > exists on musb stack for a long time, I don't plan to change it=
=2E Because I
> > > > > > cannot think of a use case in real products that doesn't automa=
tically
> > > > > > load a gadget function on the dual-role port.
> > > > > >
> > > > > > If you can explain a use case in real world (not a engineering =
lab) that
> > > > > > the gadget driver will not be loaded at linux booting up, but l=
ater
> > > > > > based on user's input, I will reconsider my decision. To remove=
 this
> > > > > > requirement from musb stack, the work is more than this patch.
> > > > >
> > > > > I have one for you: we're working on a device that boots pretty f=
ast,
> > > > > and therefore are pushing as much things as we can to modules. It
> > > > > includes gadgets, the musb driver and glue, etc. That doesn't sou=
nd
> > > > > way very different from what a generic distro would do as well.
> > > > >
> > > > > At boot, the various modules for the hardware are loaded
> > > > > automatically: the musb glue, the musb core, our USB PHY, etc. We=
 end
> > > > > up in a situation where the musb driver is loaded and reported to=
 work
> > > > > properly. The USB cable to the OTG port (in peripheral) might or =
might
> > > > > not be connected, it's kind of irrelevant.
> > > > >
> > > > > The gadgets, however, are not loaded automatically.
> > > > >
> > > > > Now comes a user that wants to use musb as a host, and connect a
> > > > > proper USB adapter, that wires the ID pin properly. In our case, =
the
> > > > > phy detects it, reports the mode change, and .... nothing.
> > > > >
> > > > > That doesn't really look like an engineering lab setup to me.
> > > >
> > > > I agree, that sounds like a valid setup.
> > > >
> > > > Also realize that Android is pushing to have all drivers as modules=
, so
> > > > you will start to see a whole lot more devices out there be modular
> > > > instead of statically built kernels.  So issues like this are good =
to
> > > > resolve :)
> > >
> > > This issue here is not related to building all drivers as modules. To=
day
> > > we already have all musb related drivers including gadget drivers in
> > > modules.
> > >
> > > The issue discussed here is that when musb is configured in dual-role
> > > mode (dr_mode =3D 'otg' in dts), a gadget driver has to be bound to t=
he
> > > udc to make musb working in host mode.
> > >
> > > I never disagree it is not ideal, but I consider it is minor - since =
the
> > > port is configured to dual-role mode, it is intended to work in
> > > peripheral mode, then why not automatically load the gadget driver wh=
en
> > > linux boots up.
>
> Again, think about an embedded product,

That's all I'm thinking about.

> if dr_mode is 'otg' which indicates the peripheral mode will be used
> at some point

No, it indicates that it *might* be used at some point, based on a
number of external factors, including:
  - Whether or not the user has plugged something in the connected USB
    connector
  - If they did so, how the ID pin has been wired (and therefore, is
    a device or a host on the other end)
  - And how the system designer decided to configure their kernel and
    userspace.

> when and how to load the gadget driver if it is not loaded
> automatically when Linux boots up? the end user doesn't have access
> to the console.

An application could load it. And really, we start seeing SoCs in more
and more pc-like devices, including with mUSB, so I don't think we
should be making assumptions here.

How do you think Fedora, Ubuntu or Debian would behave here?

> > Because no other controller requires it and therefore it's not
> > standard and violates the principle of least surprise?
>
> I know no other controller does this, but this doesn't mean it is not
> standard.

I'm pretty sure that would be the definition of "standard", or of a
norm at least.

> > And even without taking this into account, there's also the fact that
> > while the *hardware* can do dual role, the software might decide
> > otherwise. If I don't want to have support for any gadget (at all) in
> > the end system, then why should I be forced to compile and load
> > something I don't even want to use in the first place?
>
> then dr_mode should be set to 'host' instead, you don't have to load a
> gadget if peripheral mode will never be used.

No. The hardware is perfectly capable of using OTG. The software has
been configured not to.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sehda5tzdbkaj7xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJTnNgAKCRDj7w1vZxhR
xQz2AQCvvLULwzyANZo0U9//cEgsq0sMpYJexqsOPqPHOBTynQD/fiHyWfn9lcX6
VP4CSGkDKba/FBcBu+DzJeT0kVpdWgA=
=BJeq
-----END PGP SIGNATURE-----

--sehda5tzdbkaj7xu--
