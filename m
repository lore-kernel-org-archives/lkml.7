Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B80C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBBE2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfF1V0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 17:26:39 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:42524 "EHLO
        8.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1V0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:26:39 -0400
X-Greylist: delayed 2106 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 17:26:38 EDT
Received: from player732.ha.ovh.net (unknown [10.109.159.159])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id F2E5C10B6C1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 22:51:29 +0200 (CEST)
Received: from sk2.org (gw.sk2.org [88.186.243.14])
        (Authenticated sender: steve@sk2.org)
        by player732.ha.ovh.net (Postfix) with ESMTPSA id 178AF7442F61;
        Fri, 28 Jun 2019 20:51:24 +0000 (UTC)
Date:   Fri, 28 Jun 2019 22:51:17 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: format kernel-parameters -- as code
Message-ID: <20190628225117.636f7f21@heffalump.sk2.org>
In-Reply-To: <20190628124804.5ce44f04@lwn.net>
References: <20190627135938.3722-1-steve@sk2.org>
        <20190628091021.457d0301@lwn.net>
        <20190628203841.723ccd9c@heffalump.sk2.org>
        <20190628124804.5ce44f04@lwn.net>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/D5CSdnIVtgKhNrZkMj5lYjW"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 9066027525608918405
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgdduheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D5CSdnIVtgKhNrZkMj5lYjW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jun 2019 12:48:04 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 28 Jun 2019 20:38:41 +0200
> Stephen Kitt <steve@sk2.org> wrote:
>=20
> > Right, looking further shows a large number of places where -- is handl=
ed
> > incorrectly. The following patch disables this =E2=80=9Csmart=E2=80=9D =
handling wholesale;
> > I=E2=80=99ll follow up (in the next few days) with patches to use real =
em- and
> > en-dashes where appropriate. =20
>=20
> Thanks for figuring that out, it seems like the right thing to do.
>=20
> Let's not worry about "real" dashes for now.  Not everybody welcomes
> non-ascii characters in the docs and, for dashes, it's something I deemed
> not worth fighting about.

Indeed, there are more important things to worry about than dashes.

Regards,

Stephen

--Sig_/D5CSdnIVtgKhNrZkMj5lYjW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl0WfcUACgkQgNMC9Yht
g5zbiRAAhPM6Lzef7gtaxRb8+GUIukddDQqDhCEEJZdge2BkMohXu7M4fGVUMqU+
xD6FDBE/iIlt0+YXdYMrIrLol0X8Gqq4htQmZeljYQY8WHEGCqp4aECoX2HMetRB
kFU18I02I/mGpyQX9i9KuZXGxqKTCHyj9a99war0GfN0P4WkWn/1RGsEgKcVmbMa
IocSF8wCUsiO1sarLuJSVkaq/N+dZTjS8r7I50+Y7p7Aun4MWgBbacshJo0ZQPKr
0IQjgLU9aqt7kB9cQucpf2sDLau+cuTEYPTmFXlL48Yg+tF2jL4mRhv2bc5UH43Z
I3dwem1eDjeY++FdrRMglPBI/sUtcaG7eh9nglxSxLcK/LPJ6wgOoEDVKuFlJvYA
tTsowjAz41samprmXc7xt/7HjR0jm0cbHTTBB5hDSYJ1YR3ChmoysCQetzsZuviB
MDjbZmzXUED7dDhnCm8v5jkQWWGLwLzJROSkl3kKF26LZTyymbe65YVkT6TV4qM8
WnY0FYg7gtgoQeBvl9MNMP/YyGaMRdDhHglNmjx9PxtG3VLY5iiHZF3lSUIshIcf
jP+SX/ul5HTe0R8JjiD19bjGqxhW5EPFA1ix4CCkGa+oRbIV5cK99htWKmcoz7Pa
A72T64xP4xM8LQTXMws7rACOJ4oEJ0r1BxtObABqT6BJ/QAFnkI=
=L5vG
-----END PGP SIGNATURE-----

--Sig_/D5CSdnIVtgKhNrZkMj5lYjW--
