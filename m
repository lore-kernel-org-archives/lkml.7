Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B39C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB77220700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554321259;
	bh=NmQUBwDLnAU3Z94YVlcKullQwNvExxGzQinXEeBs0qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NSahxkku4RxwJz33/KwqckM+ytaDgq2+Z4uitdAzf7TylA42eTOVCdS6Ecbqi0Sox
	 EHWlcpQFR0R79Z8Q+U6VGcbrY2nM6U6G+HM52snz827kIiyuxsmlP/mEi+O9rF01sO
	 htzAbzwd4ZnUvnpTvyk+Jff1X3LvStvfIfQBNcU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDCTyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCTyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:54:17 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF2E206C0;
        Wed,  3 Apr 2019 19:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554321256;
        bh=NmQUBwDLnAU3Z94YVlcKullQwNvExxGzQinXEeBs0qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=piStoAaMJwVdxDf+AWyENvXTPFi1DSNFYcLA0frRWtHoJQgZ+fCjeIA7odHVvabf8
         T5axp8RoJBWKbnKdQof04t+QyMOgFXd9GLQHKwAPVahenPF02I3mxo2y2u3vvHbYkl
         vOuxWYJ43yL6hgC1SULwLwyfqvH1l4jtKk6G3m6Q=
Received: by earth.universe (Postfix, from userid 1000)
        id 7B95B3C08D5; Wed,  3 Apr 2019 21:54:13 +0200 (CEST)
Date:   Wed, 3 Apr 2019 21:54:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     kernel@collabora.com, Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, Pavel Machek <pavel@ucw.cz>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 0/6] omapdrm: DSI command mode panel support
Message-ID: <20190403195413.djfrgzuj7povdksi@earth.universe>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <3fed7238-776e-9ee7-9c54-b7c44a5e3a2e@ti.com>
 <20190402155508.GJ4805@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oz6n6y7l5eyf43yk"
Content-Disposition: inline
In-Reply-To: <20190402155508.GJ4805@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oz6n6y7l5eyf43yk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi & Laurent,

On Tue, Apr 02, 2019 at 06:55:08PM +0300, Laurent Pinchart wrote:
> On Tue, Apr 02, 2019 at 06:36:21PM +0300, Tomi Valkeinen wrote:
> > On 21/11/2018 18:09, Sebastian Reichel wrote:
> > > Hi,
> > >=20
> > > Here is another round of the DSI command mode panel patchset
> > > integrating the feedback from PATCHv4. The patches are based
> > > on 4.20-rc1 + fixes from Laurent and Tony. I dropped the patches
> > > for OMAP3 support (it needs a workaround for a hardware bug) and
> > > for automatic display rotation. They should get their own series,
> > > once this patchset has landed.
> >=20
> > The big omapdrm bridge/panel series from Laurent has been merged to
> > drm-next. I think this series can now be rebased and merged.
> >=20
> > However, all this needs to be changed to DRM bridge/panel model sooner
> > or later (sooner, please!), but perhaps it's best to first go with the
> > legacy way.
>=20
> I would be OK with that, but I'd like to understand what we still need
> to do to convert DSI support to DRM bridge and panel. Sebastian, if
> you've looked into it, could you provide some insight ?

I have a rebased & tested version of the patches getting the Droid 4
panel working in this branch (together with 2 patches adding
backlight support for testing purposes). I will send it as a patch
series in a few minutes.

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git/log/?h=
=3Domapdrm-5.2-with-dsi

I also had a look at converting to DRM bridge/panel model and
started working on it in the following branch. It's completley
untested and probably not working at all. Also the most recent
patches are not yet properly splitted / formated. But they show
my idea of how this can be achieved:

1. Add DSI transfer() function
2. Convert custom functions to use transfer() instead
3. Convert to use mipi_dsi_host
4. Get rid of custom DSI related omapdss functions
5. at this point panel conversion can hopefully happen the
   same way as for the other modules

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git/log/?h=
=3Domapdrm-5.2-with-dsi-untested-work-branch

P.S.: I will continue to work on this, but probably not in
the next 4 weeks. I'm currently very busy with non-kernel
tasks and still have to review > 200 power-supply patches.

-- Sebastian

--oz6n6y7l5eyf43yk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlylD2IACgkQ2O7X88g7
+pqmNg//X3X81hK2Jt2e4MuElTUGUr/XiB5k83gP9XsCZ+OHr8q5ue9joV5PV7oi
Yfg3XsfqCiZDvzwb3CRVYXgOZOf2MV4w5SnunA/Ca6mXNkiB2j/SF2K65TqBEtZN
GwthUu0aaOJ/uT+JOLcdQGfAkkypOxKLjgAOqbOSx7fOwm4Pe0XygC1TsFUjYNkv
tUvC9TzsLS5AWkwvWHjpyXtOU316QY2rVr32C/QlGEKOdXgzY3Gw7D06+w6UnAe0
teIfTbym0SaEGhI7VlwbrfgiCXDSTXxC3+8z8NTPR2t6eVVsRsZedYhQcxE7wtnf
JIONd8dA5s9zSGQsGTU2ydgIiP/qW9zV4I3a5J5P0dxUGyuXOLLPl1klX09vJXCc
7EHHIfxB29TOj4ee2KEdrjpFTAgn1p9rxoEYWuiluXXlzQvasLSGkOcD6oYz81/h
0jMmmLaTJZvvCY3Yhm961pU2S116Vg1HZYo/QJSmfKSUolMiMcDmdTZR8Yofc7vx
K0uur0cjI1pbSG8Yw1ISrcgbRMSeGjBBOX8TDSPhfrfzfoeZm8O6gBONp88I8emr
ZOP1cGPZ3GM6pQFaq6LjdrqYjICAG8c3D6kbJRBqvwafkIq3Q6fXEnpkXTA+TpwB
KRGAeYy/vVHPen5qoq7nPamjxzPjfv3XdjBaI4lWgn+8s8rBvGc=
=KUNl
-----END PGP SIGNATURE-----

--oz6n6y7l5eyf43yk--
