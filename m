Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D5C004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD19D206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfECIeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:34:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50555 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:34:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9C28E80377; Fri,  3 May 2019 10:33:49 +0200 (CEST)
Date:   Fri, 3 May 2019 10:33:59 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Li RongQing <lirongqing@baidu.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: Re: [PATCH 4.19 10/72] ieee802154: hwsim: propagate genlmsg_reply
 return code
Message-ID: <20190503083359.GC5834@amd>
References: <20190502143333.437607839@linuxfoundation.org>
 <20190502143334.278374504@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <20190502143334.278374504@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-02 17:20:32, Greg Kroah-Hartman wrote:
> [ Upstream commit 19b39a25388e71390e059906c979f87be4ef0c71 ]
>=20
> genlmsg_reply can fail, so propagate its return code

> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 624bff4d3636..f1ed1744801c 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -332,7 +332,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, st=
ruct genl_info *info)
>  			goto out_err;
>  		}
> =20
> -		genlmsg_reply(skb, info);
> +		res =3D genlmsg_reply(skb, info);
>  		break;
>  	}

How does the bug manifest for the user and is it severe enough?

Should this free the skb when it is signalling an error?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzL/PcACgkQMOfwapXb+vJWnQCgugyfXV5OAsDsuIiwJURwLqDp
FtEAoJUgUHX2bJuNHYGWG6tYU92cQ+Pw
=pVLA
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
