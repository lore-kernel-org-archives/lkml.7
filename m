Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E025AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF59206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552323821;
	bh=yIXpNpIfLBnD91GkZCJjN2L8+vrYfwgXDFlQTAWYEBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kj1lMV4rdzynAfL7sh08zpu0EZcvs/8esapIBsEGGLCcKztByPO30qzlSAM3pvQ+J
	 Cnl7lYEx1M4OZiu2+JFAHsAdbnkwz07Lz5lLekJewr3DWA+zjRiSO7pH8/FMXNkpS9
	 gwW/FzgWey+aciXZysFR0MDdcdxsXbpByFR5jaao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCKRDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:03:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCKRDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yIXpNpIfLBnD91GkZCJjN2L8+vrYfwgXDFlQTAWYEBw=; b=lNoCA75CMcsr7KCplQQprH/Hd
        jz9n6n70kN2TBOQrDsjxqFo3iMjzHldYDwHkn8mm0MN1RVC+Si7Tff8++SOMHO5Gdn4BHDHBIj2cH
        AN0eZ4485p+mm/djyZSDaMxB4CrDLmTWGPw4MyL95G2NZUfJwU9F4P1wLsOihUeh+wW+4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3OKu-0005Gr-Av; Mon, 11 Mar 2019 17:03:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 026061128896; Mon, 11 Mar 2019 17:03:34 +0000 (GMT)
Date:   Mon, 11 Mar 2019 17:03:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Volker Haspel <volker.haspel@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Han Xu <han.xu@nxp.com>, john.ogness@linutronix.de
Subject: Re: [PATCH] spi: spi-fsl-qspi: call spi_unregister_controller
Message-ID: <20190311170334.GA14368@sirena.org.uk>
References: <20190307103008.19841-1-volker.haspel@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20190307103008.19841-1-volker.haspel@linutronix.de>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 11:30:08AM +0100, Volker Haspel wrote:
> The driver does not clearly unregister the spi controller.
> Therefore calling an unbind and bind again will end up in a
> Kernel crash.
> Each driver who calls spi_register_controller() in the probe function
> has to call spi_unregister_controller() too.

Why not change it to use devm?

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyGlOYACgkQJNaLcl1U
h9AeuQf/TJE1svaqSfmjrzUapyQBDgHieQwhgpFkHDYkNAcdKPXxZcnlvhz5lrFa
/0bZ6BeH7jGfY/lNPWLpQ09na9+UaMwYUyhA/hO7HtSDNw1KTxq/77AuG6rDSVxG
ppShkWJfXcgPs/YqwOZbwerWzNKwC0io02cnd+raP2kjyItOiaqzzTrtpodjxDHj
bM9kYkZGLQqUOTLqH7wgA9l532UvoRkZvy0Iq/PEIb1I/smlbesfmdbAwOfQyV9d
uNHeOiRKUwE1W08YX//tgG82el+v7HkGRhXr01u/ZRD9H5/HODLb5e+ClhUEVsJE
rzgEIDthOFfKw4wMfsLtdF3/BR5lQQ==
=/i+o
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
