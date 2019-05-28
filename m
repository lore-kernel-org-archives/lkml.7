Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0C7C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B30420883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfE1K64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:58:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33642 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfE1K64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:58:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AFACC8035B; Tue, 28 May 2019 12:58:43 +0200 (CEST)
Date:   Tue, 28 May 2019 12:58:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Theodore Ts'o <tytso@mit.edu>, walter harms <wharms@bfs.de>,
        Aung <aung.aungkyawsoe@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: need company for kernel upgrade
Message-ID: <20190528105853.GA21111@amd>
References: <5CE53BA9.4070906@bfs.de>
 <CABC7EG8NiiPycthdfb7Ng3MsxTvmmxk_LjcosM8ZD1F0CnuDFw@mail.gmail.com>
 <5CE64BC7.4010803@bfs.de>
 <20190524050116.GI2532@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20190524050116.GI2532@mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-05-24 01:01:16, Theodore Ts'o wrote:
> On Thu, May 23, 2019 at 09:29:11AM +0200, walter harms wrote:
> >=20
> > No,
> > the company i am working for has a custom build arm-board.
> > We bought the kernel from the assembler but found it has
> > some problems that need fixing.
> > Basically we want to improve the linux-kernel so it can run
> > native on our boards.
> >=20
> > >> Hi developers,
> > >> i am in search of a company that can help upgrading
> > >> a running linux-kernel on custom hardware.
> > >> Est. time 10 days.
>=20
> Have you tried contacting Linutronix (https://linutronix.de) or
> Collabora (https://collabora.com)?
>=20
> Both have EU offices --- well Collabora does for now, until Brexit
> happens.  :-)

www.denx.de is another option.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlztFGwACgkQMOfwapXb+vJQQwCfUaLlYmrmpHFmhnoWAWelVhMW
LWYAnjN/qvBL6orvceQ/lxjhRw08XtA4
=yGBx
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
