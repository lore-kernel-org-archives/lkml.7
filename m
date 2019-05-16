Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8583BC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4897420815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558022173;
	bh=8xQGYMWEUvgEKQ9dnqz6HVEgkN3PnC4OsTTFftuaUkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M2pWctT98Q+/hp1kkP4e2631eC7yWsM9OZMNjPR6CXftE1QJU+FI8Op3C4RwFxOBF
	 XYf7dXO/fAG0dZyRg+fm85P7MFJNbz6V1hJnY4C5IujSj549KFTCYrnbwpgoRMdjiG
	 DLvH2kYFGaQSWeAwJt1TCKv4i8yN1j0ZB2crue3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEPP4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:56:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56958 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8xQGYMWEUvgEKQ9dnqz6HVEgkN3PnC4OsTTFftuaUkw=; b=rcILKcdTLzB+Hw4ficgrdCjKU
        lDGe84tvh2rEsJHUFDlfK3hwv4VdKCBoth2YVcKMtYQ2O0eA6X9jx53ZV28pgA/ESXTwFgnbMggfv
        fAOlqK/U2RdI2bLg/mbWR4+GaQVNFDncfyCcE1+9+6SgJbSc0pz4MgDsJudrIdOvpjheU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hRIjo-0006xQ-Kr; Thu, 16 May 2019 15:56:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 07392112929C; Thu, 16 May 2019 16:56:03 +0100 (BST)
Date:   Thu, 16 May 2019 16:56:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spidev: Add dhcom-board to compatibility list
 [Klartext]
Message-ID: <20190516155602.GH5598@sirena.org.uk>
References: <kcis.7DC7E250415B4C2E9DA25490D6832213@DHPLMX01>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
Content-Disposition: inline
In-Reply-To: <kcis.7DC7E250415B4C2E9DA25490D6832213@DHPLMX01>
X-Cookie: <ahzz_> i figured 17G oughta be enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 12:48:10PM +0000, Christoph Niedermaier wrote:

> You are right, it has something do to with encryption on our mailing server.
> I am in contact with our IT department to fix this issue.
> Should I resend the patch when this issue is fixed?

This is already the second time you sent it today, the other time didn't
have this problem.

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdiBIACgkQJNaLcl1U
h9AWxAf9HlPgqvZTVahRW3CfddQctwPCo7feSgJDs9NW7GSx/CRLWlNpAXj+Bi0Q
TO03hjqaSgez+yU/ptkYZDIy7Xh+G6R2O8BZ0avQGT/fv9YNa98pjGj6MJaClb0q
6xgsDauTMzvAScwgc1h8YRXfNvkjb258SjxmYFwA0JcZZAeXORd15ZuvLB7RXau+
Yv00Ru97EXjxK0qHKr/NWs5QJ4jPaSBqPKqWtzNC2sUndNz7/eUr3C4rdsGTXBXH
/sBYUU/t8XT33fEA+Bl7Rlxc09DqJWek+V8t/O4sOtezxgKPFrOdEFt4ManISbX5
tRXLJayyjQHV61ZRG+CbObjgh/UrPw==
=BvsO
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--
