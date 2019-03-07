Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0365F2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551974985;
	bh=Q66Q1DKqNnJCkiminWhlddkbAMzaxLdwC5bzjwe8FTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AluFFkMv1aEjI3yCDksIcc4Nfo9C3ScWcv4XAbACjjNs466cQlfVyQH4yZU324CeO
	 dTAZ+MOMX3Hq6unRErVacQL0iIHwVIJurX5nBH1gK5PQAWzfb0PQkR+QwyILvHyhDU
	 ccPehRABYL6jYlhjP7Zzja3YQTwCT4pBtrW6XNh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCGQJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:09:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54294 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCGQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rV/JEOtQ34mI2W1JyeD2iMtK5Fe2tHJoIWT2YvMjkdY=; b=WxrE/1wryIiCnpx1GKWCtGF9v
        ZsKdYiUTx/0d2kG9ssUGID1mmHsZ/AEiZ2y5jA/MDysNDqMl4uV4BjXpTmmF8Wbey/18yxTjzn9Zu
        2OrnqOl8nY0G3fYhvdbtkdeTSXheDnV3Hqu6KB9qi+O9N7P/mx3MIiHp8ZDl0gpbVK5cs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h1vaH-0006Nf-1U; Thu, 07 Mar 2019 16:09:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 630F61128841; Thu,  7 Mar 2019 16:09:24 +0000 (GMT)
Date:   Thu, 7 Mar 2019 16:09:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     xiao jin <jin.xiao@intel.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanmin.zhang@intel.com,
        bo <bo.he@intel.com>
Subject: Re: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during
 pxa2xx_spi_transfer_one()
Message-ID: <20190307160924.GE6529@sirena.org.uk>
References: <20190307072424.18820-1-jin.xiao@intel.com>
 <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
In-Reply-To: <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
X-Cookie: All celebrity voices impersonated.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 05:26:53PM +0200, Jarkko Nikula wrote:
> On 3/7/19 9:24 AM, xiao jin wrote:

> > The patch is to do cs again if spi-pxa2xx restar the SSP during
> > pxa2xx_spi_transfer_one()

> Hmm.. please correct me if I'm wrong but pxa2xx_spi_unprepare_transfer() =
is
> called always when there is no more messages pending and the spi core sho=
uld
> have deasserted the CS already?

Yes.

> > @@ -1056,6 +1057,11 @@ static int pxa2xx_spi_transfer_one(struct spi_co=
ntroller *master,
> >   	if ((pxa2xx_spi_read(drv_data, SSCR0) !=3D cr0)
> >   	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
> >   	    !=3D (cr1 & change_mask)) {
> > +		/* It needs to deassert the chip selection
> > +		 * firstly before restart the SPP */
> > +		need_cs_change =3D true;
> > +		cs_deassert(spi);

> I think code comes here at the beginning of each transfer so will be hit
> multiple times before pxa2xx_spi_unprepare_transfer() if SPI message
> consists of multiple transfers.

> This makes me wondering if the device driver setting up the "struct
> spi_transfer" is maybe missing the cs_change flag set for transfers before
> last one in case HW needs CS toggling between transfers? For instance what
> following drivers are doing with the cs_change flag:

> drivers/char/tpm/tpm_tis_spi.c: tpm_tis_spi_transfer()
> drivers/input/touchscreen/ad7877.c: ad7877_read(), ad7877_read_adc()

Right, this really feels like it's fixing the wrong thing. =20

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyBQjMACgkQJNaLcl1U
h9D+IAf/RPJBHypK+ouTHdrAKEfxDNywJpo2oajUzbpOk+84L90tpxhXxJqmNkfO
wBqnszhfTMXP/bPgFKBRxni3WdiHW8De4enQ0SrP3MPUEh4t6j1iUsbTTpbocxbl
SsosvIJKdjFTvz0oE5rUM6OKl5wB6ENyk2AFZffJxY0I3ktHkEgdSYJ1bi006x5X
uIwEUJwM8I/wwo151dQXsUOGu93b7j92P6p5iTEnPL+gbiE/0X8OxCxe1KVveCbY
flsc/Sk6IFJ2p4Ll5qKooM6Ef+/fCXiTeFkSIolUXBwnR04R2sC404aelPR2zj7X
/EQ3J6/PFUg4m9aV/HQNiJCKp6bmXw==
=7VDL
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
