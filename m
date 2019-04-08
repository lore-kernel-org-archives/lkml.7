Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C57FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8A620880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDHVzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:55:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57118 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:55:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 02D5380569; Mon,  8 Apr 2019 23:55:07 +0200 (CEST)
Date:   Mon, 8 Apr 2019 23:55:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org,
        david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 01/18] counter: Introduce the Generic Counter
 interface
Message-ID: <20190408215515.GA27592@amd>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +const char *const counter_count_direction_str[2] =3D {
> +	[COUNTER_COUNT_DIRECTION_FORWARD] =3D "forward",
> +	[COUNTER_COUNT_DIRECTION_BACKWARD] =3D "backward"
> +};
> +EXPORT_SYMBOL_GPL(counter_count_direction_str);
> +
> +const char *const counter_count_mode_str[4] =3D {
> +	[COUNTER_COUNT_MODE_NORMAL] =3D "normal",
> +	[COUNTER_COUNT_MODE_RANGE_LIMIT] =3D "range limit",
> +	[COUNTER_COUNT_MODE_NON_RECYCLE] =3D "non-recycle",
> +	[COUNTER_COUNT_MODE_MODULO_N] =3D "modulo-n"
> +};
> +EXPORT_SYMBOL_GPL(counter_count_mode_str);

Dunno. Exporting const tables saying "forward" and "backward". Can we
=2E.. somehow make it work without need to export this?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrw0MACgkQMOfwapXb+vI0fQCeOVJVU9FSIbeRA4WSFP7n6OI7
dq8AnR+Ykf6BWrqHixl+oRJ+LYhLlFau
=/6R+
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
