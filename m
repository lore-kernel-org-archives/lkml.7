Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8E1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349E720714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKVRUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:20:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38868 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKVRUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:20:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DE6C2291D1A
Received: by earth.universe (Postfix, from userid 1000)
        id 85EB63C0C71; Fri, 22 Nov 2019 18:20:29 +0100 (CET)
Date:   Fri, 22 Nov 2019 18:20:29 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCHv2 1/6] ASoC: da7213: Add da7212 DT compatible
Message-ID: <20191122172029.spocjr762ojxie5n@earth.universe>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
 <20191120152406.2744-2-sebastian.reichel@collabora.com>
 <AM5PR1001MB0994D2F45FA75E8285938191804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tysshi4s2jnkbg3v"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994D2F45FA75E8285938191804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tysshi4s2jnkbg3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 21, 2019 at 08:10:30PM +0000, Adam Thomson wrote:
> [...]
>
> >  Required properties:
> > -- compatible : Should be "dlg,da7213"
> > +- compatible : Should be "dlg,da7212" or "dlg,7213"
>=20
> Typo? "dlg,da7213"

Ack.

> [...]

-- Sebastian

--tysshi4s2jnkbg3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3YGNcACgkQ2O7X88g7
+prT3A//SdxIQx4L3dfQzpv+3LGWycvNn4B5b2ZV5zcwDVJV+vdONMLtwDR+2clL
MDjh3nDty/JesN5L5pTB30e6zIAJB2fnbfpmIqzztW8xxOO/COc24T8Y1LYU68og
VgaVTAPMY4O6zgF1th3FjLFC2h93vzvZZL69t+060bqbU5t+FFXopwOXpP4zby/S
4C/VtljyTNiLtgq+f8nqnqVlSddM/gKMQeHnA2AeQL8n3AFHRmtFiv6kNp13N+1g
FKisBHv/pwD7IPTvl7odDrYf2RWmptbVDGf5xFJl3SsbtwQ2zJfDHxQkcp1rfymZ
TbQgKgRlzSyHQpBaJiBYvAR+KzHiI5fBrZhw5F4XDKxjxeg8G7F9DdWell9ZUkfL
K0e6wVwGuntb/LXRo2TE3oDzXIJ9hzZwUeqCxxnOCR9pWRY2cp7tO3aaPpNa+DAg
z63KpwTyBvOd0n8jb85BdhA2hABJBw9cffGjhUEOxMOhcb/ngFJlhxrY67IIS4o7
2t9mZWmBcc9Y7BP2rSMGJsOnqJsD9EL6tFSkRlMbNovwBp7+eUgTG8AdrH7Iho0x
4JLiBts0EO4XzsdYhtYbZcjzyCxBtj3tVWFBBU3VDSJp4eAxtVLoDalSYgY/+sJe
BzY70BsifFGyR6EK1hSY3zGLUTNd5kfA3VXr5BYwcvgcKbtns58=
=Hzv+
-----END PGP SIGNATURE-----

--tysshi4s2jnkbg3v--
