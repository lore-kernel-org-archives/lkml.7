Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2601C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C1020873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560854658;
	bh=uRckzg3vMUzjM5CMRKlR78piUnfBxDxx8whHzAnRlZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g2ClN84I2rfOajNyUTU5MRNgXrlDmWaUlqT4ZVuKkzOOQNFFfIZkoz95jZ1mQDDjK
	 zIvliacnIiLuWnlJL+HLxrllkiaRrClquugb71j1klf9atwxHZELGqWqOYS6pd/0Ap
	 IGG3fqUUKnTJnwfAq09u+zgMjeIR2IUNLD6qBM1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfFRKoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:44:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49964 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfFRKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=km0kfdC/hKjVZnNZui8sF4w+LrQQDOJNijMncnZtyZc=; b=wEW+gzWk9qrPhm2yCnuwnYZ5U
        slDRNd35BCqwiERohldwe0Dc5Tjqg9SrEf9TYmz7RaKNIKBHA67fnyfh7Fxc5oJe6GZ7hWBHxN39Q
        T0r6YH85oDHYOhSs1WFeP5qagJ0Ay3DAuSmrmjCREOd4TVF0qhT0KO0iqCNy8+0Z/r16Y=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdBaw-0004vD-6k; Tue, 18 Jun 2019 10:44:06 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2E62F440046; Tue, 18 Jun 2019 11:44:05 +0100 (BST)
Date:   Tue, 18 Jun 2019 11:44:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lgirdwood@gmail.com, robh+dt@kernel.org, afaerber@suse.de,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20190618104405.GJ5316@sirena.org.uk>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
 <20190617163015.GD5316@sirena.org.uk>
 <20190617163413.GA16152@Mani-XPS-13-9360>
 <20190617170356.GG5316@sirena.org.uk>
 <20190618081324.GK16364@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NV8Q+b3U03j8aVmL"
Content-Disposition: inline
In-Reply-To: <20190618081324.GK16364@dell>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NV8Q+b3U03j8aVmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2019 at 09:13:24AM +0100, Lee Jones wrote:
> On Mon, 17 Jun 2019, Mark Brown wrote:

> > OK...  seems very weird to use your work address for developing on
> > products closely associated with your employer in non-work time.

> I use my Linaro address for everything.  So long as the work is of the
> required standard, I cannot see anyone having reservations.

It's not a problem to use it - I was querying the copyright statement
due to the Linaro address and work in conjunction with the non-Linaro
copyright to make sure it wasn't a mistake.

--NV8Q+b3U03j8aVmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0IwHEACgkQJNaLcl1U
h9BkZAf+Om81gkS+ElDadCSyURXSDk+RIxCGvstK5OCPfn7F0BEtzv6WNmxMotvi
gAzvgAeSKYiSVXiRE2PV1N1VUKftvLcn5FqmhU+pgUJ//VHsuXm5Adl4WAP0o7Pl
AlXgWiXIeMpINnOcrsNs1Bhm17S59rgI9glWbtsdrVeHcZJJgh3HtlDZocqDJ7M9
0XBmfGbMfM3BVMVF8O2VBoV2VIHi4F2uS/X7cYdV/6KZ39jF34Oii0Cf9X+rZ5Zn
Dnu2+dXuqP/0wV2oF2aJtB78XIItH/ZfiZ7V0n5JyFy9swmllw9+YyfJoePFl2ru
oNsKsfGatclsw/ygzrPd+AJa2l51Hw==
=ORPp
-----END PGP SIGNATURE-----

--NV8Q+b3U03j8aVmL--
