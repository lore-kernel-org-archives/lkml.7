Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC63CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EAD2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554182085;
	bh=X2u9oqRsEaAuQVXF2Wpq4Ocm5o+1E/B+V/Q2GGD21eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JZaZnSEW5alsLsfsbsRCMbrKi9WMhthgahSSkhOnVKHezk8MIeD0dDsGdq9XcHIrl
	 i8pv80XI97UvGN2b/nA+kRG49Jh3npk9OVprJO5hjS69ijJ5kFCpp8L/KQvn+jnD1u
	 2LZORFMmAoEv2daQHapZxzsJLhlwSiBzQ6qDd7vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfDBFOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:14:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfDBFOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X2u9oqRsEaAuQVXF2Wpq4Ocm5o+1E/B+V/Q2GGD21eo=; b=c3GIf+NZb/k/NQoA+eoUba3kb
        DXsmA8M4ZlEPE92aZR4ZLBFbkyP+uYjTmDgQHpKTbTRNo9U+4yqVP8SPmdxLXzZScKRB1YCIPlXeY
        qjLqIrB34As3EQFTszRgj+cXCfjbAEPvD7nmsEWQ6qFj0hToepE80SY+U6UFjuWFA+F/M=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBBkQ-0005rr-Tv; Tue, 02 Apr 2019 05:14:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 59221440082; Tue,  2 Apr 2019 06:14:07 +0100 (BST)
Date:   Tue, 2 Apr 2019 12:14:07 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190402051407.GX2059@sirena.org.uk>
References: <20190326133349.3d9427dc@canb.auug.org.au>
 <20190326131550.GB10898@sirena.org.uk>
 <87pnqdndmk.fsf@concordia.ellerman.id.au>
 <20190327115745.GA11404@sirena.org.uk>
 <87tvfiou8f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xd9y+pRso0hzCdjI"
Content-Disposition: inline
In-Reply-To: <87tvfiou8f.fsf@concordia.ellerman.id.au>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xd9y+pRso0hzCdjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:11:44PM +1100, Michael Ellerman wrote:

> Anyway I think what you've done in next, make the code depend on
> COMMON_CLOCK, is the best option. If anyone cares about that driver on
> powerpc platforms that don't support COMMON_CLOCK they should speak up.

It's probably fine for now for this one driver but it's going to cause
issues going forwards since we're trying to make the framework's clock
handling more standard. =20

--xd9y+pRso0hzCdjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi754ACgkQJNaLcl1U
h9BMxQf/VrR/8FAWEVz+p5IAVWhEp/5r8gGBQzY33Bg6n8m4Wx0mFHVfDDxORd/L
SYSWqWbDGTk1AwbZ59dzTXaGEhh/9YX9/g5v6INunPhClb7NMBIvddfzvFv8pDTd
nI6DbaUyOnQzFtXTMF+ClhtKHxRBVbT6MwFKFOLcoPRjkhU9ebaiaVmBrzOoaq6N
dqDF7ukc0T15k/qvZ38kKczZA6m4DsGhVoSvpXxe5MucSHe7wphRFwyaJ8+S2AFR
AYvOQJNcYPi4pJYpcQ8i6cX4lJecezofZkVbj+b8WBCjndlieq5CZtB76qLevleN
WB8m8oAwM1GH+wdKRlWDmJWIOgRb3A==
=JFD3
-----END PGP SIGNATURE-----

--xd9y+pRso0hzCdjI--
