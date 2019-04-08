Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B6C282DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8515214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554716311;
	bh=oLj+mpVfYrMAKVzT100KDOGJ3d3S70Ze+nV+TsWJcxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zzpruSsprIEHix9JU+WvFR1BwXLEDsrg0krxqL8YyOjgKGyBxcMQNKgHvaBGEBr/Y
	 fIqURGnoJOmr/uTpUs/l76LHeUOAAOH2meFawp0oIAOmMrtDQBALaaAjq/mGr0+F1H
	 JvfqHVU54GEA4kn6N+Xv2LT0/1GzRn2uIEjaehBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDHJia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfDHJi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:38:29 -0400
Received: from earth.universe (dyndsl-037-138-087-101.ewe-ip-backbone.de [37.138.87.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A5120880;
        Mon,  8 Apr 2019 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554716308;
        bh=oLj+mpVfYrMAKVzT100KDOGJ3d3S70Ze+nV+TsWJcxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJTL5FvqkzJtA8kNPhmF3T1ag21WUT1NXgRgQH/Dn+E+pxvdZCxTWrJzg7ep1k9oS
         CEBjrZhwDmwxOCMnPm+R9V1pNFoeCE2qV671rrzH0zObL60yra4hMNbBZxxTTNbJRK
         vQg4M8LUyyzMRjWETQ2Fedg1G2bvUiywIBoBsSX4=
Received: by earth.universe (Postfix, from userid 1000)
        id 312AA3C08D4; Mon,  8 Apr 2019 11:38:24 +0200 (CEST)
Date:   Mon, 8 Apr 2019 11:38:24 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] power: supply: add Ingenic JZ47xx battery driver.
Message-ID: <20190408093824.yzpd7mve6df7lpka@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
 <20190323172809.14407-4-contact@artur-rojek.eu>
 <20190324153137.04857cdf@archlinux>
 <20190407165234.is66vmnjfc35jnho@earth.universe>
 <1554664077.4322.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kxv5ige2aqijufid"
Content-Disposition: inline
In-Reply-To: <1554664077.4322.0@crapouillou.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kxv5ige2aqijufid
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sun, Apr 07, 2019 at 09:07:57PM +0200, Paul Cercueil wrote:
> Hi Sebastian,
>=20
> Le dim. 7 avril 2019 =E0 18:52, Sebastian Reichel <sre@kernel.org> a =E9c=
rit :
> > Hi,
> >=20
> > On Sun, Mar 24, 2019 at 03:31:37PM +0000, Jonathan Cameron wrote:
> > >  On Sat, 23 Mar 2019 18:28:09 +0100
> > >  Artur Rojek <contact@artur-rojek.eu> wrote:
> > >=20
> > >  > Add a driver for battery present on Ingenic JZ47xx SoCs.
> > >  >
> > >  > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> > >  The IIO parts look fine to me.
> > >  Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > >  Sebastian, assuming you are happy with this version,
> >=20
> > The driver itself looks ok. I'm a bit unhappy, that we already have
> > jz4740-battery. This driver is much cleaner, but does not yet seem
> > to be ready to replace it. Artur Rojek what are your plans regarding
> > to the existing driver? Is there currently work going on migrating
> > JZ47xx to DT?
>=20
> Why do you think it's not ready? Feature-wise, it has everything we
> need to replace jz4740-battery, which will be trashed as soon as the
> LB60 board code is updated to use the new driver.

jz4740-battery has a few features not provided by your driver.
For example the gpio providing the charging status. Assuming
you plan to trash the old driver soon:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> We are working on porting the JZ47xx code to devicetree, yes. The
> ultimate goal is to completely get rid of
> arch/mips/jz4740/board-qi_lb60.c and arch/mips/jz4740/platform.c.

Ok, sounds good.

-- Sebastian

--kxv5ige2aqijufid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlyrFowACgkQ2O7X88g7
+pqAVw/+NKyxFp5GIWuXBnG+OV0ezhW5bAYrBsST5OtDqg8x4aACWv6BjwNwLQJN
TREW2Rda/Jqyy0fxhwUDdcGJ0deWMqWbFi0+OPQXBZ4Xd8kpTLjs1uwcHRag8mkN
Sre9c6FIsCytrd73CYFgJjz7PMmB4FBaRr/Z7qhWhdgTh66i+m+Ql5GjVI0sl2nL
m9fxTCpJgh7zmVuLepEosq7YgwrOTP8ZZaMCJSD/Bo8ejDIW9ox9IMjbdUFEqWC1
sxzpDvBhZT6rcvuwVx57/F0XtGIcsJEMruB3YFKCOS5XJhk7GExs1c1zos9xBap6
N0WBllMu4PhLpZphW/7zWWDxeco/whNupy682YPh3r9hg7u5npCfaxu9z+h5Kp53
YCW/dClq8WId9IG1nxI2Pl4M7pXiieiMR3ms9Bq/VMLYRLT08QWRopsA2QVZ/dyt
wle6YdFZtgvt+yFfKNOHF0ogmhApuA4J01PP9T65KAEcV4RDH3ZgLNlZuEZeYFCq
YcKPp5e2dQGv66qqRNnMPLyhUAOY3s6UG8YCSkSGtRZZjZheb/nqHaw/w7CjitrR
JbDcw+iBLeoDxgYRLSQKGFpkvxSt1x8rd8xBHKmVailT/9IAUgrejm0CL+MS3fZm
te+QRKM+DvDMGvKXnuF6WjTqw6yTNngyd/aM2yQQ4XQ604fXBNo=
=/UP4
-----END PGP SIGNATURE-----

--kxv5ige2aqijufid--
