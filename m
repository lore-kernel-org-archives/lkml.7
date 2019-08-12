Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B283AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B6E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g3sAA9jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfHLGyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:54:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:51793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLGyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565592845;
        bh=muCwBkulWXt9jniwNNVXYtlUSvKh+OTHOdKC7/7Donc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=g3sAA9jEYVf7TJnUqDQZKozfgQ6iotPeo6Fg/TimIXREF7mm0nACEJqWs15zj+TO/
         FQstiF6iMRVpWx7dQGmtZtan18797LT1BWtMroo9yjiK9PU2F+ktYyvV5CQ9HBrgKc
         WxlW0HAO8M2h7De4VN/5z3GDQ0ojKez0PSl6DuTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1i7Y551ghS-00ASBJ; Mon, 12
 Aug 2019 08:54:05 +0200
Date:   Mon, 12 Aug 2019 08:53:51 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: rn5t618: Document optional property
 system-power-controller
Message-ID: <20190812065351.GE1966@latitude>
References: <20190129135917.29521-1-j.neuschaefer@gmx.net>
 <20190201092411.GG783@dell>
 <20190808183924.GB1966@latitude>
 <20190812062520.GB4594@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <20190812062520.GB4594@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:0+t/4tjn5mVBiots3LoCVFLYTLI74+cDsU8c5ZuStgO/8b+KpiL
 oAod8woJAh8rcoDrLv/nK76vkHNW4Xh7zDAwHx3jSxCku4F+X5B/h6+1V7luvTF6RI9GUP7
 Iiu5MMkoLSykaNUHBSGMww4DzkOST8rVn9KQHHa6u1TnmwWC4t+QmRj4B1EbT506RhGBSYG
 fC38FheIUmHE7wG/Rt8FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YM9U+Z9XuY0=:Wpf0OfEeYuFPOGyk6eTzLK
 W/is/NGC04Gu84EngU/pe5d1cZNHbGNzosD4gnDmpPdGtDALIpfHcdhI8YZemNwQjSn8A+1L6
 8tIpc3hGF5wyhDjRf/QNiyB9fXWP+tcHKoEY9A+Fi2sNAz55shVA+HaMOq9AP+icvYKfaneyx
 DYhdLCkeEiyRrRmd8uQ04tE9SE9g08rGE0hyPd20RIufCJxJRaWvsxdwFhwyhiobsyhN/v3q7
 o24wcAH2ZvqbVxvJALr1yzAWwb0BArgXoks/h+TiveK92H8LGCFYYTIbXhvjIWMYQpWHsGsQE
 NepPUHlE5NSIm7pjTP1sJbJeQ7RlfXvuPADVftBWB4/e0X7js0hnh0iL2eK+Cbz/O8mieBva0
 GXWvaUnzNh7X7JkzRLtYfPOeVIRs9I+77cv/5XXNJymGkO+yqz83R1kxiZuOsat6oxA0+7Aci
 4NUoTJLaZ+H2uZgqyqA9TMyAMdzp63JIEtkEYBj/UKuOXwOmNoNFOA/5t6G+AGtdxYIUGQPeJ
 FVFA0FdS0Om6tUTPVVfGv4JQo7tCzzavdRpG5iB4OCIZHB3C0mKALNckhUyOIDnFXsT4qUMDz
 e/tsde/PXogKdK95EMFMpErkbRcU06X0Z8qkk6yDwJvti9JedQ18MQbEdDgwoXVY01MZ/mpV0
 sFCMRyKuGMftBBQCS7yeZ7yimiSClmFvGrZVXLSdROMDczL7SqqF5wlBa8/lT801gvutowKVr
 ixuUqS3bus1EIo+35A6oHMngjyATNxAcaklDVjCJ3wKSREthLW41AuCx3okIWNXyFm4xkA5MM
 dSypikRphLSMNUkDaMbpLusWXa5Lz/NChUxXUyCZ9TM4jMXJ0Em5topoNdOhZIkJOf/oqqCqW
 kUFc3REnFvfmd4iHKbKvTXC29v4zwrvS+fvuKa+cDMYeK5BjFotyBP18g0QYxKS2TJNHsVDVK
 CHqAflZs8KxxPud7ciBMed6aGlSsPQNlvKEuIhMlWC2dWykdsZ5rBkGtOUNGlCbkTRLLx6gb6
 a7V5GhEu+Q9CWz7ybTsWu5T8wUGD5oqtI+tEZ1ZPqSh14QPXBYAMkraVfF4VyEfh3hBJLD3vq
 WEv37pB/umX2lbzz4NOnEZriZ33JfYUWhWo0A3KVB++wy9KDgScTSkfZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 07:25:20AM +0100, Lee Jones wrote:
> On Thu, 08 Aug 2019, Jonathan Neusch=C3=A4fer wrote:
> > On Fri, Feb 01, 2019 at 09:24:11AM +0000, Lee Jones wrote:
> > > On Tue, 29 Jan 2019, Jonathan Neusch=C3=A4fer wrote:
> > > >  Documentation/devicetree/bindings/mfd/rn5t618.txt | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > >=20
> > > Applied, thanks.
> >=20
> > Hi,
> >=20
> > apparently this patch got lost somehow (I can't find it in mainline or
> > -next). Should I resend it?
>=20
> Yes, it appears that it did.
>=20
> I've applied it again.

Thanks!

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl1RDPYACgkQCDBEmo7z
X9shKw/+JZCAsjf1jIve1vL5EAHYyh19xmD6BTvCpIjinKKs3lspa2jQd34ePTCq
4BhMRoisEjqvx5SqUlOccHAqT+WoU9gBAegDqkVUPTEUXFB2H0i2I8u6AoOWCQJ+
tqltE/95fRn5oPxmk2rzF2hCPABRK94A1LQPEKr7YfLKqoA47tCmZ6CjWRqVzx+E
mGo6aW/nChuMG5Sq1iZTJUOtJ1adSEL8I3h/S00UBumkd5XjXAu1fjBEBOX4l5Yg
T5qV6LXxQppQLUV/UWS/025aSy1bYm9jBY526Tz9iHb0z8ZljlWY9Mn7oWLS9Ujo
ExflAfx/QtiQ/45mwHYa/71xLz5rUhowbeo0dZfCfMTzDOB3e+gF83ss6eSOQ7sQ
ehNbWYf1T5Ct/9AW/OBjuzChlP0UY02KfHPP/EpZV0VjsGo2PxV3C8qmnzYfrK5x
wq4sblpFHdDIQHoJQPL7XgJwb12fhDgdmUCXkLJXrB1Hv2avEqmMBC30rJDeC1GL
0YAZSMYEkW7FAYxYwiElKp8lKNd2hPM8zzwj6KnE9OOfuhvkE9TjtPSRTcmg6Cnu
bxDH9iun1cy9MOIIJ2n3h0xeE3+Zf6YdC4hK0sRCPJnkNVS1o6+LKtpGEcyr1EFH
SZoTweJD6Z2WOCvJ2a0iWIrY6893L8fCClafY+aEonYxmRYx+M0=
=HJdh
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
