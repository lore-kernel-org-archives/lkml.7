Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EB7C4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387BD208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568983598;
	bh=MxfbZuNRVN5rNCGNlblLaCjQFZy7BN7xYfhqSWXVc2g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BmyaniEQ0SIKQVGEeeQxJpqIs1BoInvcjEhnXgQ2OL+sxf4kJjUCnJm7Mv4Zg9MJi
	 K+GLKxrcy9KDRKlFMStyLeu7v4MyUFxBuQri1T2s4221gfkQv7Hg0VAy+Dk2YrOGXo
	 9bOz99565O9r4oh+cq6kj4jagerBcx7KjHjgLn28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfITMqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:46:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37132 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfITMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IAoZ6rM/PwDOA6r3P1bWoJ5e5+WfwYE0KvYydJITs3E=; b=Yx1wwA9Q1LCZcEVL/ZIw/HGF/
        bUmt0vx1HpM5fuTw5daAVCHl7/akEdzzkfaT2G/smdUMUAA3rkDFPPj5wgvaRY4VdK0RjhAV0OHdf
        X+hSRsTdfL+wLeBo8fiFHNfTbS2DDLd1gwJMfxkiaWl5jjG+VeXt9TaL283EQ00mnnHCc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iBIIv-00020g-Rz; Fri, 20 Sep 2019 12:46:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 04AD5274293C; Fri, 20 Sep 2019 13:46:28 +0100 (BST)
Date:   Fri, 20 Sep 2019 13:46:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the thermal tree with Linus' tree
Message-ID: <20190920124628.GE3822@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got conflicts in:

  Documentation/driver-api/thermal/index.rst
  Documentation/driver-api/thermal/sysfs-api.rst
  Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst

between commit:

  eaf7b46083a7e34 ("docs: thermal: add it to the driver API")

=66rom Linus' tree and commit:

  af3e0fe9c66370a ("docs: thermal: add it to the driver API")

=66rom the thermal tree.

I fixed it up and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2EyiQACgkQJNaLcl1U
h9B/GQf/W3MND5/v2dfrNECBHTdEzxKGFd7JGohchspnd6LTJFDBpj5yP57rWPEg
nkbi/Sbho/sLC0MTaP7ymDlI6pyGYewap4zf0m4mfdgWgVXeC/iHa7pHdcg4dWrP
BKiUILveTIc+NXkurgAgngN2NWm/liZuioYd9gsKnDCFQKM/T5XE6Jfeeel+ZKRr
I0wB7dM7YO5EUQ74vKAqYqCjunj9bRjIdwv+UNzTbTP23ikY4HvuqSGkkkkDeANT
UlSCU8e/z8z93aSJ4yc/yBPOXpgx+JWsyWcCsO55OiQs/oMA2wivseVeq1IE00KR
K1dAKZviRfUmdx5UCC6rHoY9IM0PFA==
=AK6N
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
