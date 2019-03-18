Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B52120857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCRMQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:16:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37402 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCRMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:16:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6280B80753; Mon, 18 Mar 2019 13:16:47 +0100 (CET)
Date:   Mon, 18 Mar 2019 13:16:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / core: fix kerneldoc comment for
 dpm_watchdog_handler()
Message-ID: <20190318121654.GF6101@amd>
References: <20190316033751.31323-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <20190316033751.31323-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-03-15 23:37:51, Yangtao Li wrote:
> This brings the kernel doc in line with the function signature.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f80d298de3fa..0cff68bd7b4b 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -478,7 +478,7 @@ struct dpm_watchdog {
> =20
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
> - * @data: Watchdog object address.
> + * @t: The timer that pm watchdog depends on.
>   *
>   * Called when a driver has timed out suspending or resuming.
>   * There's not much we can do here to recover so panic() to

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPjDYACgkQMOfwapXb+vJCQACfXKyj6G3VQJoj9h6CmUWWU1cV
/HQAoLYW/5IkOCcKLMxSEq30xxiM60pE
=8I4/
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
