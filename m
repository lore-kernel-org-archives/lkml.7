Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3FCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A11F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555079282;
	bh=bIE9gs7XneLI+Mm2Ad2MU4iATuFw7FjsD8YJbJFJaeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aVvD5tn8CMuqmCpHpnKbHucfhYtN9Ocr2rwehFdlnhwoLe1dYgMhvo7mw6qG7QWBM
	 Dda3PTBxRDkaj61kT/Lg68KjO+7M1x15iiQf/PktTb3MB/yDA13fo+UlWogtLwn0Yp
	 Qof9RLvOdF8UAsHfF+EGjTGZvR9uXEujN7fURNuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDLO2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:28:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37152 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLO2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qxDH6L1FTEn5bSDv2p2bqSdx5euLq7X5rYD0KvdDqRE=; b=n0H6r8vUxCiXsArrHSiYFWJjt
        ZKGHUGr86yZvyNrozykxY+9Yn7oDW1c8m1MUM+zsdfEx6qyR3CZjXv8SSdlN3TTKLKXFxfPp9A8UD
        QzZzwguhE82X4BbPByKAXu7p5FUDdysELX3ik9nHyqSt5IMoGeiFARVMeZynhUennV3RM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEx9i-0007Ej-Jb; Fri, 12 Apr 2019 14:27:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6123C1121A6C; Fri, 12 Apr 2019 15:27:48 +0100 (BST)
Date:   Fri, 12 Apr 2019 15:27:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: fix Kconfig select/depend
 issues
Message-ID: <20190412142748.GB6235@sirena.org.uk>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
 <aaa3f184-bcd5-70fd-b8fa-e6e361253ede@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <aaa3f184-bcd5-70fd-b8fa-e6e361253ede@linux.intel.com>
X-Cookie: You dialed 5483.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 09:17:35AM -0500, Pierre-Louis Bossart wrote:
> On 4/12/19 5:06 AM, Srinivas Kandagatla wrote:
> > On 11/04/2019 20:28, Pierre-Louis Bossart wrote:

> > > 0-day/Kbuild starts complaining about missed module dependencies and
> > > compilation issues. Since codecs and soc drivers need to be compilable
> > > independently, let's fix this using the following model:

> > > SOUNDWIRE_INTEL ---- select -----------
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 v
> > > REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS

> > Last time when I looked at this, Kconfig symbols SOUNDWIRE_BUS and
> > SOUNDWIRE looked totally redundant and bit over done.

> > Removing SOUNDWIRE_BUS Kconfig did clean it up and made it bit more
> > align with others

> Good point, but no. This is intentional and follows the Kconfig pattern
> pattern described by Takashi at https://lkml.org/lkml/2017/11/17/47

> yes, this SOUNDWIRE is overkill for now, but let's assume there is a seco=
nd
> non-intel implementation (which I understand as very likely given all the
> threads on ARM64 support). In that case you'd really want a top-level
> selector option that has no actual compilation impact - not used in any
> Makefile or code - but enables the sub-options and let users/distros sele=
ct
> the platforms they care about.

I don't understand what you're saying here - what is the intended
difference between SOUNDWIRE and SOUNDWIRE_BUS?  Having the separate
option for _INTEL for your controller makes sense but otherwise the
normal pattern for a bus would be that you'd have the root config
option for the bus (which would enable the core code for the bus) and
then everything else is hidden behind that.

>=20
> SOUNDWIRE_BUS is really the lowest-common denominator that will be used by
> all drivers at the end.
>=20
> > regarding REGMAP_SOUNDWIRE, It should be selected by the codec/soundwire
> > slave drivers isn't it?
>=20
> yes, that was the intent.
> Thanks
> -Pierre

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywoGMACgkQJNaLcl1U
h9BKWgf/Uu12+7GZaZlYY+rgsISG7oJhhvwc6PKMSDUkKB3TPs5PYY50WEJuAz3G
Yc0EFNJpJleCQJ7+Cwt1bhV8fZ+gMKmuS6DchfTQIpdCq/cs9iD3vqDCOdBE0h/i
ufk0Du3ztMmg4YG49lvPQane1xuuG6twho3OdONZndeTKsJy16fqpp5fhNs2FAD+
VAGuxJBBx2YTGgO+g7Oog9wv5n1NcwGwbUH7BBKPceUwh2P8bKXBtVa5ai6+JWW3
W2wPS96Swegy1/gLu0RIERQNVy9mrx7dbiX+4omgtdYuhsPReJhmG4tQrbWonYg0
axdGsoYgOFcRZv78mX/MuxqNlL2kzg==
=y7Jn
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
