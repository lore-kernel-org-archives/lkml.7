Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D253C4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64923207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568976669;
	bh=926BHXCwA7K3XTxEJ0HBZkwUSTMXXxYECQaz/wFwtao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vm9qJUbFuD+WHuzb9jyhOwL8hpDTlmhw/tTULzmkMGZoVEn/0w5o+PzgXEhDCu7gR
	 n2HbwBoSKIgWCUM9ctD3QPsoRvmFXRoVX6WjCB6NLbbrfMafT4rYtzVO3ak+dQp9NE
	 B3bJDCToQZVSPnoG3xRx8sEHtgPTK5ibpwYKsdMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408742AbfITKvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:51:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbfITKvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PUcLIbaqeuHnXeQutdJgdyi+R4Jz8eNeOWDcF4uPM0s=; b=aBXsyIzsozo5Obmv7v1aptdjR
        Xcx06QOq2bnCWdgDkLSNDxf3bzFr2rX6ntaGY60wWiyibyFN/TnZkD8ISsFxQmheMgXOR10d8oFJw
        ydT4mamHbCCjbsFGav4f98ngoev76Gd623LBbaKTV8BOUtdOO+u1tJIRpkCuGhhOcfvLA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iBGVC-0001ZW-Vr; Fri, 20 Sep 2019 10:51:03 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1020D274293C; Fri, 20 Sep 2019 11:51:01 +0100 (BST)
Date:   Fri, 20 Sep 2019 11:51:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: atmel: Fix crash when using more than 4 gpio CS
Message-ID: <20190920105101.GA3822@sirena.co.uk>
References: <20190919153847.7179-1-gregory.clement@bootlin.com>
 <20190919160315.GQ3642@sirena.co.uk>
 <20190919172350.GZ21254@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20190919172350.GZ21254@piout.net>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 07:23:50PM +0200, Alexandre Belloni wrote:
> On 19/09/2019 17:03:15+0100, Mark Brown wrote:

> > This is going to break any system where we use both a GPIO chip select
> > and chip select 0.  Ideally we'd try to figure out an unused chip select
> > to use here...

> The point is that this use case is already broken and this patch fixes
> the crash and is easily backportable.

> Fixing the CS + gpio CS should probably be done in a separate patch.

If the GPIO is overlaid on any of the existing slots (except GPIO 0)
then it'll cause GPIO 0 to start toggling.  I'm not convinced that the
code doesn't currently support that.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ErxQACgkQJNaLcl1U
h9C4OAf9FfyzqjxlHkt3ntI6EvTAyZw0LS08pAM3Y9UgSh+9oAHuivVW0ZQ55DFO
IXeXuTGoNbS0doU2lJfCc4/mRGV0SLFkdf9Oa8OHBVnHjtYo7iHhWLuGfwVr6YOr
CqDSofMpphdzsQxhZ8xTycUYjC5ZrJ2Zd31CddLcCZNWRM1HsLN89XXVQ2HclVhi
dVhOkAiGJ3Cy4AeXky7/UNCJbKJfeQQvhSy8Dn+LOqbPrglKDh4xwbfTVUMChBH4
IjFd5De9X/Y5GP1Mqbr7dDz/3fVFbH8bb4jAuaWBJiO2tNkeE4WRKoTSG3BBp9EM
HhAPo7EorLaMmfC1Id2HdhxFrNrNIQ==
=40sX
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
