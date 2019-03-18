Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ECDC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145762070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552904589;
	bh=Px4JW5dLseTSPZAVK2VfJA7PbLnaQdZqiUwc2bPIdOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gM/84bKfZfBio6Ci2AFLeP4LeoUKXIuBY20yE+wxBz1WwZwBGEJHfYuWoqUbmr5y8
	 8KEM9bsAAt5b/7dC3kavAfElNGV0HvFoCyc7TKmINFdmoGzw/2P9A6WT+5HmFXpHEy
	 2bZMIayWgzkNtcJMbRtq6Zo4kOWOM6JvnE4R8ZhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCRKXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:23:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55674 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Db/+hl7JnfB3d3ZTU10zVsmSk/RkPfrVkARUwPV9vu4=; b=ORNgvqwX2Q3Y9c+KNtwOCv2qS
        dlW03ZCTE29/GLpOW49BJNp726f2MXNA0dRvZiOUrOQeEDBFUIoJQwry4XtI+9ynNLszeYh0A4llJ
        GPdiVPnNCeCkm3inhy2lLZSqSK9ETlGjB3UlqeKKuXrHLCEZZCDCqmULXUHLEOB1/yjho=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5pQ2-0004tS-25; Mon, 18 Mar 2019 10:22:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 95E9F11287B3; Mon, 18 Mar 2019 10:22:57 +0000 (GMT)
Date:   Mon, 18 Mar 2019 10:22:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Esben Haabendal <esben@geanix.com>,
        Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: support use of the SPISEL_BOOT signal
 on MPC8309
Message-ID: <20190318102257.GA6221@sirena.org.uk>
References: <20190306103156.19897-1-rasmus.villemoes@prevas.dk>
 <3f0313c8-670c-5d70-80e2-210add8e328c@prevas.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <3f0313c8-670c-5d70-80e2-210add8e328c@prevas.se>
X-Cookie: Linux is obsolete
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 07:43:47AM +0000, Rasmus Villemoes wrote:
> ping
>=20
> On 06/03/2019 11.32, Rasmus Villemoes wrote:

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyPcYAACgkQJNaLcl1U
h9Czxwf/Zi8hNjbwLvG1C60sGV85PLsh4mSzTnWNjr6x8PxqRBadRmrb+i6PQdxh
yGDP2L8AUhZbQH4kjwH/H6HDHCZrxh0eRuKpbSXFNVkih5YXMmcr7mE1woV1HGZ7
relo2dVkp5JKP4biS5+rkOIsxiWdBrJo8BbJ1CNLeykQKh/qizqD6X70MSQZwyho
Y3/3YRkUWVo83Vdm53/pRo3dOGZ+ihPulmVUnx5Nh7jA3C1TdVK1qdJzyLn/gG4i
dmljnrxj9G2D2C0uAudO9RSgfkhqvAQsWEGAQUwnPlXiZ69rmUMKBz79OkjP4RGL
LTzz4cXEBqx4XCIznLV9oSrwNowDVQ==
=Vo2r
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
