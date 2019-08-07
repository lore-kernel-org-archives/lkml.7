Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCDCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B6522296
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565200624;
	bh=yPeef3j6LhNS2VOHbDy8pZkEquwI+YA09pIQwpAJn7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iWgXPVne6jhVbOi5Puz2fkBIykBpJAef6nBYjRvPyc0optkHh+JETX0Figi0B4qmk
	 A7xXv/i60gBA9Jiy/M5Z+roTJ4L1Wj4pb42540zUzH5Hzj5RAt250CG53Eikl/jZ8v
	 UJMv0+eDzSTABnN17r6Ynyw3pRCJwRKBrZjCvaPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbfHGR5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:57:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58896 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbfHGR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dEwiILabVzzTIYb/658XogkvnQOQeMh6Hr9+QcEFNQw=; b=Ph36o3U8a75Pt13+eK/wAbf6A
        VV0kmEhBB9qEVHgLcYjl5W8oR0fPnwTTJAhQkGsMSL4+QkuMcdOoCCJZ1ng+qCnnL8H26nOKTBkb8
        0xH5iKbozYBzPRcG02sCY4dHMkClvyqkI6fVDQYP1royVPVx377Df8yrtOyQq1ARGj8Ik=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvQB5-0008Le-Vg; Wed, 07 Aug 2019 17:56:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D80DB2742B9E; Wed,  7 Aug 2019 18:56:46 +0100 (BST)
Date:   Wed, 7 Aug 2019 18:56:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: fix regmap dependencies and
 align with other serial links
Message-ID: <20190807175646.GK4048@sirena.co.uk>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
 <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline
In-Reply-To: <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 10:09:27AM -0500, Pierre-Louis Bossart wrote:

> Vinod, Mark, any feedback?

> There will be a set of SoundWire codec drivers provided upstream soonish =
and
> we'll get a number of kbuild errors without this patch.

I think I'm missing context here, I've basically been zoning out all the
soundwire stuff - the patch series are huge and generate a bunch of
discusion.  Is the patch below the full thing?  I don't see any obvious
problems.

>=20
> >=20
> > > ---
> > >   drivers/base/regmap/Kconfig | 2 +-
> > >   drivers/soundwire/Kconfig   | 7 +------
> > >   drivers/soundwire/Makefile  | 2 +-
> > >   3 files changed, 3 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> > > index 6ad5ef48b61e..8cd2ac650b50 100644
> > > --- a/drivers/base/regmap/Kconfig
> > > +++ b/drivers/base/regmap/Kconfig
> > > @@ -44,7 +44,7 @@ config REGMAP_IRQ
> > >=20
> > >   config REGMAP_SOUNDWIRE
> > >          tristate
> > > -       depends on SOUNDWIRE_BUS
> > > +       depends on SOUNDWIRE
> > >=20
> > >   config REGMAP_SCCB
> > >          tristate
> > > diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> > > index 3a01cfd70fdc..f518273cfbe3 100644
> > > --- a/drivers/soundwire/Kconfig
> > > +++ b/drivers/soundwire/Kconfig
> > > @@ -4,7 +4,7 @@
> > >   #
> > >=20
> > >   menuconfig SOUNDWIRE
> > > -       bool "SoundWire support"
> > > +       tristate "SoundWire support"
> > >          help
> > >            SoundWire is a 2-Pin interface with data and clock line ra=
tified
> > >            by the MIPI Alliance. SoundWire is used for transporting d=
ata
> > > @@ -17,17 +17,12 @@ if SOUNDWIRE
> > >=20
> > >   comment "SoundWire Devices"
> > >=20
> > > -config SOUNDWIRE_BUS
> > > -       tristate
> > > -       select REGMAP_SOUNDWIRE
> > > -
> > >   config SOUNDWIRE_CADENCE
> > >          tristate
> > >=20
> > >   config SOUNDWIRE_INTEL
> > >          tristate "Intel SoundWire Master driver"
> > >          select SOUNDWIRE_CADENCE
> > > -       select SOUNDWIRE_BUS
> > >          depends on X86 && ACPI && SND_SOC
> > >          help
> > >            SoundWire Intel Master driver.
> > > diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> > > index fd99a831b92a..45b7e5001653 100644
> > > --- a/drivers/soundwire/Makefile
> > > +++ b/drivers/soundwire/Makefile
> > > @@ -5,7 +5,7 @@
> > >=20
> > >   #Bus Objs
> > >   soundwire-bus-objs :=3D bus_type.o bus.o slave.o mipi_disco.o strea=
m.o
> > > -obj-$(CONFIG_SOUNDWIRE_BUS) +=3D soundwire-bus.o
> > > +obj-$(CONFIG_SOUNDWIRE) +=3D soundwire-bus.o
> > >=20
> > >   #Cadence Objs
> > >   soundwire-cadence-objs :=3D cadence_master.o
> > > --
> > > 2.20.1
> > >=20
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >=20

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1LEN0ACgkQJNaLcl1U
h9Doowf+Pqtbwv8TKH7n1SWpm5BzFI61YcWAq17CFzAwcyo9WP/KgUvxQuOPbkhE
BLh0VrJ0TjoAk1hFmJjOiiteW2VCD0GuSwLLta/bIuRPRVfzNbo7hhEMk9StQOzZ
IyyPf272g43ClAZI0BWc7MxKnx7Kc2Tfr+DJNlOe40TXKqQ3e9EPrZvqQjczZuLl
LgqWERVy/CAf7McruEyKoWsR9F89dmQUjYjsxXn8+vXjmYJ4KoSFpnXa65U9k3f9
dq86ylDSeaYDpuFP9HdYzn74boq8u3C+svgAcv7z6q62Pa8RDifXSnMAr84Q6Nn1
3ScPBYV/GzO3k5FLqxGL5GizewOQyw==
=9z/t
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
