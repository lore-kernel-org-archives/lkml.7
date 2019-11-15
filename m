Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C327C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B43520729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKOVNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:13:55 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:37904 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfKOVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:13:53 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A58F61C14E3; Fri, 15 Nov 2019 22:13:51 +0100 (CET)
Date:   Fri, 15 Nov 2019 22:13:51 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg KH <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     Pavel Machek <pavel@denx.de>, colin.king@canonical.com,
        mmoese@suse.de, sashal@kernel.org
Subject: Re: 8250-men-mcb: fix signed/unsigned confusion
Message-ID: <20191115211351.GB30273@duo.ucw.cz>
References: <20191115125234.GC29996@duo.ucw.cz>
 <20191115150942.GA375649@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <20191115150942.GA375649@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-11-15 23:09:42, Greg KH wrote:
> On Fri, Nov 15, 2019 at 01:52:34PM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> > Commit 5210a3a722543fc25b8830d2236dcbe2c8178468 fixes part of
> > signed/unsigned confusion, but not all of it.
> >=20
> > 8250-men-mcb: fix error checking when get_num_ports returns -ENODEV
> > Upstream commit f50b6805dbb993152025ec04dea094c40cc93a0c
> >=20
> > Fix function returning -ENODEV to signed prototype, and make error
> > check consistent between two functions.
> >=20
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> >=20
>=20
> Hi,
>=20
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually
> respond

Not sure what is supposed to be friendly about this bot.

Anyway, it would be nice if authors of
5210a3a722543fc25b8830d2236dcbe2c8178468 picked this up. I have no way
to test it.

					 	     	   Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXc8VDwAKCRAw5/Bqldv6
8go1AJ9eKBHmvdcBtyxG/oX6giluytirGgCgpANTvbCufWxtWZOgXsWt4yBjw1s=
=BSiL
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
