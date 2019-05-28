Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC25C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2520883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfE1LRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:17:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34155 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfE1LRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:17:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 696BC803CA; Tue, 28 May 2019 13:16:48 +0200 (CEST)
Date:   Tue, 28 May 2019 13:16:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Kirill Smelkov <kirr@nexedi.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 4.19 082/114] fuse: Add FOPEN_STREAM to use stream_open()
Message-ID: <20190528111657.GA23674@amd>
References: <20190523181731.372074275@linuxfoundation.org>
 <20190523181739.135794147@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20190523181739.135794147@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/include/uapi/linux/fuse.h
> @@ -219,10 +219,12 @@ struct fuse_file_lock {
>   * FOPEN_DIRECT_IO: bypass page cache for this open file
>   * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
>   * FOPEN_NONSEEKABLE: the file is not seekable
> + * FOPEN_STREAM: the file is stream-like (no file position at all)
>   */
>  #define FOPEN_DIRECT_IO		(1 << 0)
>  #define FOPEN_KEEP_CACHE	(1 << 1)
>  #define FOPEN_NONSEEKABLE	(1 << 2)
> +#define FOPEN_STREAM		(1 << 4)

Interesting choice of constants. It is too late to change it now, but
was (1 << 3) meant here?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlztGKkACgkQMOfwapXb+vLX3ACdGqLX+DFoYE64Oxz33y2VQL2O
+RcAoLwY/oFFXTwZOBVTJdr0oqoXPDTR
=KbD4
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
