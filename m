Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25690C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F164420857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCRMRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:17:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37429 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCRMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:17:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B3B118074C; Mon, 18 Mar 2019 13:17:03 +0100 (CET)
Date:   Mon, 18 Mar 2019 13:17:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / core: fix kerneldoc comment for
 device_pm_wait_for_dev
Message-ID: <20190318121710.GG6101@amd>
References: <20190316034841.31451-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <20190316034841.31451-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-03-15 23:48:41, Yangtao Li wrote:
> Rearrange comment to make the comment style consistent, the previous
> function parameters are described first.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 0cff68bd7b4b..eddb54057ed6 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -2069,8 +2069,8 @@ EXPORT_SYMBOL_GPL(__suspend_report_result);
> =20
>  /**
>   * device_pm_wait_for_dev - Wait for suspend/resume of a device to compl=
ete.
> - * @dev: Device to wait for.
>   * @subordinate: Device that needs to wait for @dev.
> + * @dev: Device to wait for.
>   */
>  int device_pm_wait_for_dev(struct device *subordinate, struct device *de=
v)
>  {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPjEYACgkQMOfwapXb+vKiIACfaImgNuI9nyp2zWc1zjI6P1Uy
ZaEAmwQIqDMH/OWJjyg5gexXKeWlaLlN
=FNoo
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
