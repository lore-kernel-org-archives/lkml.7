Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB3AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2F72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfHLKCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:02:35 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35571 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfHLKCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:02:35 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0A47560008;
        Mon, 12 Aug 2019 10:02:31 +0000 (UTC)
Date:   Mon, 12 Aug 2019 12:02:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Code Kipper <codekipper@gmail.com>,
        Christopher Obbard <chris@64studio.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Subject: Re: [linux-sunxi] Re: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane
 functionality
Message-ID: <20190812100231.wlxitekfojr4jaki@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <2092329.vleAuWJ0xl@jernej-laptop>
 <20190731122953.2u3iabd6gkn7jv7k@flea>
 <1589203.0AjJVEASy3@jernej-laptop>
 <CAGb2v66D4-QvWYPXE=rf6Zv93X1LjnxUgpk+5wdAL_b7MM3vaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4tzqsccmfdz6gxrw"
Content-Disposition: inline
In-Reply-To: <CAGb2v66D4-QvWYPXE=rf6Zv93X1LjnxUgpk+5wdAL_b7MM3vaA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4tzqsccmfdz6gxrw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2019 at 02:22:13PM +0800, Chen-Yu Tsai wrote:
> On Thu, Aug 1, 2019 at 1:32 PM Jernej =C5=A0krabec <jernej.skrabec@gmail.=
com> wrote:
> >
> > Dne sreda, 31. julij 2019 ob 14:29:53 CEST je Maxime Ripard napisal(a):
> > > On Tue, Jul 30, 2019 at 07:57:10PM +0200, Jernej =C5=A0krabec wrote:
> > > > Dne torek, 04. junij 2019 ob 11:38:44 CEST je Code Kipper napisal(a=
):
> > > > > On Tue, 4 Jun 2019 at 11:02, Christopher Obbard <chris@64studio.c=
om>
> > wrote:
> > > > > > On Tue, 4 Jun 2019 at 09:43, Code Kipper <codekipper@gmail.com>=
 wrote:
> > > > > > > On Tue, 4 Jun 2019 at 09:58, Maxime Ripard
> > > > > > > <maxime.ripard@bootlin.com>
> > > >
> > > > wrote:
> > > > > > > > On Mon, Jun 03, 2019 at 07:47:32PM +0200, codekipper@gmail.=
com
> > wrote:
> > > > > > > > > From: Marcus Cooper <codekipper@gmail.com>
> > > > > > > > >
> > > > > > > > > The i2s block supports multi-lane i2s output however this
> > > > > > > > > functionality
> > > > > > > > > is only possible in earlier SoCs where the pins are expos=
ed and
> > > > > > > > > for
> > > > > > > > > the i2s block used for HDMI audio on the later SoCs.
> > > > > > > > >
> > > > > > > > > To enable this functionality, an optional property has be=
en
> > > > > > > > > added to
> > > > > > > > > the bindings.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > > > > > >
> > > > > > > > I'd like to have Mark's input on this, but I'm really worri=
ed
> > > > > > > > about
> > > > > > > > the interaction with the proper TDM support.
> > > > > > > >
> > > > > > > > Our fundamental issue is that the controller can have up to=
 8
> > > > > > > > channels, but either on 4 lines (instead of 1), or 8 channe=
ls on 1
> > > > > > > > (like proper TDM) (or any combination between the two, but =
that
> > > > > > > > should
> > > > > > > > be pretty rare).
> > > > > > >
> > > > > > > I understand...maybe the TDM needs to be extended to support =
this to
> > > > > > > consider channel mapping and multiple transfer lines. I was t=
hinking
> > > > > > > about the later when someone was requesting support on IIRC a=
 while
> > > > > > > ago, I thought masking might of been a solution. These can wa=
it as
> > > > > > > the
> > > > > > > only consumer at the moment is LibreELEC and we can patch it =
there.
> > > > > >
> > > > > > Hi Marcus,
> > > > > >
> > > > > > FWIW, the TI McASP driver has support for TDM & (i think?) mult=
iple
> > > > > > transfer lines which are called serializers.
> > > > > > Maybe this can help with inspiration?
> > > > > > see
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tre
> > > > > > e/s
> > > > > > ound/soc/ti/davinci-mcasp.c sample DTS:
> > > > > >
> > > > > > &mcasp0 {
> > > > > >
> > > > > >     #sound-dai-cells =3D <0>;
> > > > > >     status =3D "okay";
> > > > > >     pinctrl-names =3D "default";
> > > > > >     pinctrl-0 =3D <&mcasp0_pins>;
> > > > > >
> > > > > >     op-mode =3D <0>;
> > > > > >     tdm-slots =3D <8>;
> > > > > >     serial-dir =3D <
> > > > > >
> > > > > >         2 0 1 0
> > > > > >         0 0 0 0
> > > > > >         0 0 0 0
> > > > > >         0 0 0 0
> > > > > >     >
> > > > > >     >;
> > > > > >
> > > > > >     tx-num-evt =3D <1>;
> > > > > >     rx-num-evt =3D <1>;
> > > > > >
> > > > > > };
> > > > > >
> > > > > > Cheers!
> > > > >
> > > > > Thanks, this looks good.
> > > >
> > > > I would really like to see this issue resolved, because HDMI audio =
support
> > > > in mainline Linux for those SoCs is long overdue.
> > > >
> > > > However, there is a possibility to still add HDMI audio suport (ste=
reo
> > > > only) even if this issue is not completely solved. If we agree that
> > > > configuration of channels would be solved with additional property =
as
> > > > Christopher suggested, support for >2 channels can be left for a la=
ter
> > > > time when support for that property would be implemented. Currently,
> > > > stereo HDMI audio support can be added with a few patches.
> > > >
> > > > I think all I2S cores are really the same, no matter if internally
> > > > connected to HDMI controller or routed to pins, so it would make se=
nse to
> > > > use same compatible for all of them. It's just that those I2S cores=
 which
> > > > are routed to pins can use only one lane and >2 channels can be use=
d only
> > > > in TDM mode of operation, if I understand this correctly.
> > > >
> > > > New property would have to be optional, so it's omission would resu=
lt in
> > > > same channel configuration as it is already present, to preserve
> > > > compatibility with old device trees. And this mode is already suffi=
cient
> > > > for stereo HDMI audio support.
> > >
> > > Yeah, it looks like a good plan.
> > >
> > > > Side note: HDMI audio with current sun4i-i2s driver has a delay (ab=
out a
> > > > second), supposedly because DW HDMI controller automatically genera=
tes CTS
> > > > value based on I2S clock (auto CTS value generation is enabled per
> > > > DesignWare recomendation for DW HDMI I2S interface).
> > >
> > > Is that a constant delay during the audio playback, or only at startu=
p?
> >
> > I think it's just at startup, e.g. if you're watching movie, audio is i=
n sync,
> > it's just that first second or so is silent.
> >
> > >
> > > > I2S driver from BSP Linux solves that by having I2S clock output
> > > > enabled all the time. Should this be flagged with some additional
> > > > property in DT?
> > >
> > > I'd say that if the codec has that requirement, then it should be
> > > between the codec and the DAI, the DT doesn't really have anything to
> > > do with this.
> >
> > Ok, but how to communicate that fact to I2S driver then? BSP driver sol=
ves
> > that by using different compatible, but as I said before, I2S cores are=
 not
> > really different, so this seems wrong.
>
> Maybe we could make the DW-HDMI I2S driver require the I2S clock be on all
> the time? You wouldn't need any changes to the DT.

That's an option, but I'd really like to avoid it if possible.

I guess we could also just add a delay in the powerup path in the HDMI
case? Would it work?

maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4tzqsccmfdz6gxrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVE5NwAKCRDj7w1vZxhR
xaLkAP9Dau8CFZaqjfYlG8eEMwwmDGnmJ3Qb+OfrtRI9IxfL8AEA9pf3QqqQHWty
49bPYoHYZSaMSKd3MPMDdPL5aONO1Q8=
=l/Kl
-----END PGP SIGNATURE-----

--4tzqsccmfdz6gxrw--
