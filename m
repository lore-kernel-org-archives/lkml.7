Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F00C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0161921872
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555644891;
	bh=OyDGYY1oJXZY3nY50dQRdm7Px3U4Z+IpAs8EbIEXtiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PovHBnDP5GWgF8KGAblpiZ5cb7cfQfk8cPhWexMrIJ+cG8O8hbDDs86JjE5MmP8/W
	 OJ2p3haISSgSFhAGUBfLmsd9G2H+pJmFfI0cPQ9nlhySF0Y5SwMgkjg4bG+oCeBX2P
	 8p9JhvQXbBHJclreW8Uo1AzbRB9Wz9C82TvvL2U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfDSDet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfDSDet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:34:49 -0400
Received: from earth.universe (dyndsl-091-248-050-217.ewe-ip-backbone.de [91.248.50.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AEB2183F;
        Fri, 19 Apr 2019 03:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555644888;
        bh=OyDGYY1oJXZY3nY50dQRdm7Px3U4Z+IpAs8EbIEXtiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VndAtqPyXYNcQ2rWxEJbrPaolRdA4nkcGi9NK/bdj5rDNYgXBLoD+2sP8AyKblPGE
         BpG5q/rv+2iVmb8HgxeJvLIKozXGSp6xZmZW4o7HYat0+ezWSNAMg4YH5rZ1zRhcH8
         z3+I5UIg+xUoZuxS7bB2fj54AiQeJsyWNPA75Cfs=
Received: by earth.universe (Postfix, from userid 1000)
        id 3AC9B3C08DB; Thu, 18 Apr 2019 21:47:47 +0200 (CEST)
Date:   Thu, 18 Apr 2019 21:47:47 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/4] iio: inkern: API for reading available iio
 channel attribute values
Message-ID: <20190418194747.dptsqebjsf3rr6cy@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
 <20190324152725.35fed317@archlinux>
 <20190414113454.53087ca6@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgsxqldkf5o6zf2t"
Content-Disposition: inline
In-Reply-To: <20190414113454.53087ca6@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wgsxqldkf5o6zf2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 14, 2019 at 11:34:54AM +0100, Jonathan Cameron wrote:
> On Sun, 24 Mar 2019 15:27:25 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Sat, 23 Mar 2019 18:28:06 +0100
> > Artur Rojek <contact@artur-rojek.eu> wrote:
> >=20
> > > Extend the inkern API with a function for reading available
> > > attribute values of iio channels.
> > >=20
> > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu> =20
> > If this goes through a route other than IIO (otherwise
> > I'll just add a signed-off-by...)
> >=20
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Applied to the ib-jz47xx-prereq branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>=20
> I'll merge that into the togreg branch as well shortly.

Thanks, I pulled that branch into power-supply next for the
other two patches.

-- Sebastian

--wgsxqldkf5o6zf2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly41GMACgkQ2O7X88g7
+pq0Dg/+P5WbhV6uttsmFVoHwB+hHc7HmE2h4orwZWWWjceetahyW73XHoORaNvd
AAqGYq2CorKegt3pEYN1FjGLFl5Z1/ifbvr/2XL4145NEe9i2qyf56qlhY0Lou+S
al59XZ+PfiDSLWL1JX643zocJMIIFFxIptU6BYGPdIlANg9sFxVjejci2j+xJXo7
im6oiLmaJ9pY8ug9TFflQoS3YiNBEaVNoBks4tWZuJYGLZ2FH5LohEAk/V85g7hR
m4DTmBDD9bJWC0JQRkjyIal+xYB98f0FJV4dBkD/2G5OUZsCFDM+57MNQTKNF2dG
YSAcGg5sr5U7WDNvZrlPQpeqi5FmSiSAKp6QO0d1Wo1rfLsUfhrhH6G/KNYYMIpK
6TZAIB4qfPRSCOWy3zNILPDa4mdSd4tCyfJKj6iGLN0eioZnlvJU7yspm+0wxhnK
2I+Mj4oWyO4lCbX8CeM3+a+GCCQwxOFM4VQ8muer+tXla2eayznKPkPc0l3K5Jid
3DZK6ob/VqJV8uC7xPCDW9/7VWiRU7qG3h+z21dt2h7UXVvPu5keeTpifbnhUL6F
h0eOXOOLmjItgyXUiDcY2fdzUUypEJt0f6vKRozbBOy/ME0bba9ZYyxpi1aolaNU
dXtj0fd7c+XiZ+fZ0VpIbCF38/OrDoQBl82EzQJg6SdmhiAnfmA=
=wLB6
-----END PGP SIGNATURE-----

--wgsxqldkf5o6zf2t--
