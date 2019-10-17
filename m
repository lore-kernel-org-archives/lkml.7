Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F8EECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6E220663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439307AbfJQIzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:55:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39004 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439083AbfJQIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:55:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0CFD9801AD; Thu, 17 Oct 2019 10:55:24 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:55:39 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sashal@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 4.19 62/81] cifs: use cifsInodeInfo->open_file_lock while
 iterating to avoid a panic
Message-ID: <20191017085538.GA5847@amd>
References: <20191016214805.727399379@linuxfoundation.org>
 <20191016214843.979454273@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20191016214843.979454273@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Dave Wysochanski <dwysocha@redhat.com>
>=20
> Commit 487317c99477 ("cifs: add spinlock for the openFileList to
> cifsInodeInfo") added cifsInodeInfo->open_file_lock spin_lock to protect

> Fixes: 487317c99477 ("cifs: add spinlock for the openFileList to cifsInod=
eInfo")
>=20
> CC: Stable <stable@vger.kernel.org>
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>

This is missing upstream commit ID and a signoff.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXagsigAKCRAw5/Bqldv6
8i7xAKCBGixLen4sFo0D9/lNpClaoCvpPACfW/fRf88Do2+v0vyafH2nQEWlqeI=
=skro
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
