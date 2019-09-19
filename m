Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE415C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB42218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568899880;
	bh=85uPHKRFvJfcsJD7C/IA/5a0QS7njpfF46Btr/PWAmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WtNTEVtKqrtw7Gs3j9tVxOs6ct07aoKukwdjPlGKnrNK8quHOOkWo81SHGEDzZAJt
	 9hFf1SOiqGo69p26rg6PkoCH89NisvCTDhDi0e+IaliymJ+Ea8f/qocZm8KbholzDm
	 OGu6uK1q3/o3w+LEOONbn6wVAAFR6wIWAZmEH+1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390044AbfISNbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:31:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35150 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389999AbfISNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JyAlY6UIhywYtset6XBZK5PunxSRA0O1GFSEjQPW0TA=; b=NnhC7vS7q68YrtR4QJdielghM
        DsttULbXxzytm4cpca5wYi6hou+RVfnKYOyEvIpILb5hexDq2F9CJPNVBiPQGTJLBWEVcbJ3Sqc4Q
        h/pC8lIQKU5g7hqgZavVok/HXb5ZmiNtCe4Uveljk96pd9XwhI4hfWjUP0zsSa4pZX/2g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAwWg-0002pX-Uh; Thu, 19 Sep 2019 13:31:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2019A2742939; Thu, 19 Sep 2019 14:31:14 +0100 (BST)
Date:   Thu, 19 Sep 2019 14:31:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] spi: dw: Add basic runtime PM support
Message-ID: <20190919133113.GK3642@sirena.co.uk>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline
In-Reply-To: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 09:04:32AM +0100, Gareth Williams wrote:

> Gareth Williams (1):
>   dt-bindings: snps,dw-apb-ssi: Add optional clock domain information
>=20
> Phil Edworthy (3):
>   dt: spi: Add Renesas RZ/N1 binding documentation

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.  This isn't
even consistent within the series :(

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DgyEACgkQJNaLcl1U
h9CySAgAgDnSgZkYFNYM2rEOjD3mK2F8DU/d10qh1tJqQkX5Fo7DqE0mxuvcJfAM
kdtdWxCG5DRh2q3iM2T7k20iU9tQOjiW3E0dL4W4pUSObgat68DxlTXe2ag/fntc
VwC6D1+AIoNFnOXTYKYPt8Pp+NqBlgNxHByHW7KXxbbSDgslBZESYG9fLQBf+KJ/
FrMgo8aRnez6Sv1adY2aCSGwZxK643tL5ZgVBdv3+KjObqdlSex4EbphqkEO8mVY
eoGKz7X3EDv/IeJfHNoy3O3Y3w064iEnv8ioO6+XTKDiVkntQV1xxmDjnQs6fNy/
A5PqKEMRpy36c5gNU3JP9C72+3PjxA==
=73/l
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
