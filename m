Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E602084F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556325846;
	bh=dLOXKF1p/Dv4HBRtRIutRTqnhpZWwgM1HJ/m9aMP1BY=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=xxR2NWBp8nZ+5DkkcE5S2qfLDcGCgSItEZlwXdD9O53LbEPIE5wp9vSTP2SXp86qM
	 cKvhDkM1aWdGwVBk6TNoAiTgmOwfeci5jVsc/vL2zsJXkBRWBhTeSAO4cvJUvGfm1S
	 q13sqWPjinemDbiRv6lsSkiatgR/WIieva+rNbYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfD0AoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 20:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfD0AoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 20:44:05 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27CE52084F;
        Sat, 27 Apr 2019 00:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556325843;
        bh=dLOXKF1p/Dv4HBRtRIutRTqnhpZWwgM1HJ/m9aMP1BY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=I3z0OQQz4G3bPGGBfzkMnbvO1IgqxUHBA4LJWXvs6mTlgWIrteueNnUX4Q8XHiZDu
         tYeqdbhxVg3SJHJ3EF2z4aclGKXkhHfOdncw4143p89HlviWh2QVNi9euZj9kKMGfh
         bBOmltNQH8xy5UJmzE3CAfZTmhIKis6FBtqvVZ0Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl>
References: <20190424090216.18417-1-mike.looijmans@topic.nl> <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com> <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: Add silabs,si5341
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 26 Apr 2019 17:44:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2019-04-25 23:51:15)
> On 26-04-19 01:04, Stephen Boyd wrote:
> > Quoting Mike Looijmans (2019-04-24 02:02:16)
> >> Adds the devicetree bindings for the si5341 driver that supports the
> >> Si5341 and Si5340 chips.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >> ---
> >>   .../bindings/clock/silabs,si5341.txt          | 141 ++++++++++++++++=
++
> >>   1 file changed, 141 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/clock/silabs,si=
5341.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.txt=
 b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
> >> new file mode 100644
> >> index 000000000000..1a00dd83100f
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
> >> @@ -0,0 +1,141 @@
> >> +Binding for Silicon Labs Si5341 and Si5340 programmable i2c clock gen=
erator.
> >> +
> >> +Reference
> >> +[1] Si5341 Data Sheet
> >> +    https://www.silabs.com/documents/public/reference-manuals/Si5341-=
40-D-RM.pdf
> >=20
> > Thanks! I also had to look up the pinout in the datasheet, not the
> > reference manual above.
>=20
> Now you mention it, this is the "reference manual", not the datasheet. I'=
ll=20
> add a reference to that as well.
>=20

Cool, thanks.

>=20
> >> +
> >> +Optional properties:
> >> +- silabs,pll-m-num, silabs,pll-m-den: Numerator and denominator for P=
LL
> >> +  feedback divider. Must be such that the PLL output is in the valid =
range. For
> >> +  example, to create 14GHz from a 48MHz xtal, use m-num=3D14000 and m=
-den=3D48. Only
> >> +  the fraction matters, using 3500 and 12 will deliver the exact same=
 result.
> >> +  If these are not specified, and the PLL is not yet programmed when =
the driver
> >> +  probes, the PLL will be set to 14GHz.
> >=20
> > Can this be done via assigned-clock-rates? Possibly with a table in the
> > clk driver to tell us how to generate those rates.
>=20
> The PLL frequency choice determines who'll get jitter and who won't. It's=
=20
> ridiculously accurate too.
>=20
> For example, if you need a 26 MHz and a 100 MHz output, there's no soluti=
on=20
> for the PLL that makes both clocks an integer divider (SI is vague about =
it,=20
> but apparently integer dividers have less jitter on output). Only the end=
user=20
> can say which clock will get the better quality.
>=20
> >=20
> >> +- silabs,reprogram: When present, the driver will always assume the d=
evice must
> >> +  be initialized, and always performs the soft-reset routine. Since t=
his will
> >> +  temporarily stop all output clocks, don't do this if the chip is ge=
nerating
> >> +  the CPU clock for example.
> >=20
> > Could this be done with the reset framework? It almost sounds like if
> > the clk is a CLK_IS_CRITICAL then we shouldn't do the reset, otherwise
> > we probably should reset the chip when the driver probes. If we don't
> > have a case where it's going to be supplying a critical clk for a long
> > time then perhaps we shouldn't even consider this topic until later.
>=20
> The driver can sort of see that the chips is already configured. This tel=
ls=20
> the driver whether that's expected or just coincidence.
>=20
> Maybe it'd be clearer if I reversed the logic and name this=20
> "silabs,preprogrammed", which will skip the driver's initialization routi=
ne?
>=20

Maybe? Is there any way to look at some register to figure out for sure
if it's been pre-programmed or not? Could TOOL_VERSION be used or
ACTIVE_NVM_BANK or DESIGN_ID0-7?

>=20
> >=20
> >> +
> >=20
> > Looks like there is an interrupt pin? So we need an optional interrupts
> > property?  Also, a reset pin, so maybe a 'resets' property. There's also
> > another input pin for 'output enable' which maybe someone wants to use?
> > Plus some other pins to control step up/down of frequency and clock
> > synchronization? Maybe those should be optional gpios, but it probably
> > can wait until later.
>=20
> There's indeed an interrupt, that can tell you when a clock stops running.
>=20
> The issue here is that supporting all that the chip can do in a driver wi=
ll=20
> take weeks of programming, whereas the added value is next to nothing.
>=20
> I assumed the enable, step, and similar pins are for cpu-less operation, =
since=20
> they don't add any functionality (you can do all that through the I2C int=
erface).
>=20

I'm not asking for the driver code to be written, just for the
properties to be documented in the binding. I suppose if there isn't
going to be code for them and they're complicated then it might not make
sense to add the properties. All that matters immediately is to get the
required properties correct. If those pins are for cpu-less operation
then I agree it makes sense to not describe them in the binding.

>=20
> >=20
> >> +=3D=3DChild nodes=3D=3D
> >> +
> >> +Each of the clock outputs can be overwritten individually by
> >> +using a child node to the I2C device node. If a child node for a clock
> >> +output is not set, the configuration remains unchanged.
> >> +
> >> +Required child node properties:
> >> +- reg: number of clock output.
> >> +
> >> +Optional child node properties:
> >> +- silabs,format: Output format, see [1], 1=3Ddifferential, 2=3Dlow-po=
wer, 4=3DLVCMOS
> >> +- silabs,common-mode: Output common mode, depends on standard.
> >> +- silabs,amplitude: Output amplitude, depends on standard.
> >> +- silabs,synth-source: Select which multisynth to use for this output
> >> +- silabs,synth-frequency: Sets the frequency for the multisynth conne=
cted to
> >> +  this output. This will affect other outputs connected to this multi=
synth. The
> >> +  setting is applied before silabs,synth-master and clock-frequency.
> >> +- silabs,synth-master: If present, this output is allowed to change t=
he
> >> +  multisynth frequency dynamically.
> >=20
> > These above properties look like highly detailed configuration data to
> > let the driver configure the clk output exactly how it's supposed to be
> > configured. Can these properties be rewritten in more high-level terms
> > that a system integrator would understand? Ideally, I shouldn't have to
> > read the datasheet and the driver and then figure out what DT properties
> > need the values from the datasheet in them so that the driver writes
> > them to a particular register. I don't know if that's possible here,
> > because I haven't read the driver or the datasheet too closely yet, but
> > that should be the goal.
>=20
> The datasheet is not very helpful in this regard. Silabs just assumes you=
'll=20
> use their clockbuilder software for writing these values, which is how we=
 got=20
> to the "LVDS 3v3" values.

I hope that can be determined by looking at vdd<N>-supply voltages?

>=20
> I could put in a table of "common" values, so that you can say:
>=20
> silabs,output-standard =3D "lvds";
>=20
> And then use the "raw" properties to expand or override on that.
>=20
> Extra defines might help, e.g.:
>=20
> silabs,format =3D <SI5341_FORMAT_DIFFERENTIAL>;

I suppose you'll need to reverse engineer the clock builder software to
figure out why a SI5341_FORMAT_DIFFERENTIAL would be specified instead
of some other value. Ideally we don't need any of these vendor specific
properties and the drivers using these clks can ask the clk framework to
configure these properties, or we need to look at making more properties
like 'assigned-clock-parents' that lets us configure things generically.

>=20
> >> +- clock-frequency: Sets a default frequency for this output.
> >=20
> > Why not use assigned-clock-rates?
>=20
> Suppose you want to have a synchronized audio and video clock. The audio =
needs=20
> a 1536000 Hz clock and video wants 36864000. The clocks must have the sam=
e=20
> parent (so they don't drift).
>=20
> Without pre-specifying the clocks, the video might probe first and change=
 the=20
> synth to run at 73728000. The audio clock will then run at some undefined=
=20
> frequency until the driver probes. The audio hardware may not like that.
>=20
> If the audio probes first, it could program the synth to 3072000 for exam=
ple.=20
> Then when the video probes, it needs to re-program the synth, and then th=
e=20
> audio must adapt its divider.

I think you're describing a need to call clk_set_rate_exclusive() on
certain clks provided by this node? But I'm lost how this property is
solving that problem.

>=20
> Another example, a serdes needs a 100MHz clock. This could set the synth =
to=20
> 200MHz, and that's fine. Another device needs a 200MHz clock. This can sh=
are=20
> the same synth, by programming it to 400MHz using a /4 and /2 divider. Bu=
t if=20
> that 100MHz serdes is already up and running, changing the synth config w=
ill=20
> cause the serdes to lose its lock and result in transfer errors. This wou=
ld=20
> not happen if the 200MHz device happens to probe before that serdes. The =

> solution provided by the driver is that you can pre-set the synth to 400 =
and=20
> then both drivers can probe in any order they like.
>=20
> While the driver can change the muxing and dividers and multipliers, ther=
e's=20
> more to it that just "gimme a frequency". So I let the user describe a=20
> (partial) solution in the devicetree.

How is this different from using assigned-clock-rates with the
"consumer" being the clk provider node and the rate being 400MHz?

>=20
> >> +- always-on: Immediately and permanently enable this output. Particul=
ary
> >> +  useful when combined with assigned-clocks, since that does not prep=
are clocks.
> >=20
> > Looks like you want CLK_IS_CRITICAL in DT. We've had that discussion
> > before but maybe we should revisit it here and add a way to indicate
> > that some clk should never be turned off instead of assuming that we
> > can do this from C code all the time.
>=20
> My issue was that assigned-clocks does not call clk_prepare. If the clock=
 is=20
> not running, assigned-clocks will not turn it on (at least, that is the c=
ase=20
> on the 4.14 kernel I tested this on), it apparently only prevents it from=
=20
> being turned off by marking it as "in use". This just provides a way to u=
se=20
> assigned-clocks.
>=20

Do you want the clks to always be prepared and enabled? What use-case is
this? It still looks like CLK_IS_CRITICAL flag needs to be expressed in
DT here.

