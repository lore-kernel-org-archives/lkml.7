Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F23AC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9591206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560440761;
	bh=Ki30Zt9rubRFzkQOPBKDpdJsqFjYNJVS0zvzpE1t/gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xnt1wxZEgMI0mignPLrByYNbj99jqrlSh/J8HOHvOA+C8FzkiAGHc+YL3kC5cbYn8
	 KMPONKqe2/epq/g2/ZKPp4jQ1ePafTQ7A5FmZIr6r15WvG73Cz44XwI9qs/fkVn+UJ
	 oeFyVsvPBrFl6TryUE9sqNy1Tut7q008kE3uVX+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbfFMPqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:46:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39714 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfFMPpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S/Hz66zfUqFTM9lEJJLGr7NIoOTRtHtoEtXaG4KN1+k=; b=g2XWnishsfgj/HVqzEnSgiAg0
        96YUSwpy4Gw7eqFMLqOynOK9uxIosdLTejC1d8sTI2E46cd2PfCQ2q4/Ydo55Eyv4KFTDmksJy0FJ
        KsDKHgQxBFCmx8Yxfo5Wp6dcxj+R5PI9cfJ3SUz+UV0MxiLwol1dKJG+SGgi/uwodpDBg=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbRvF-0005E1-6z; Thu, 13 Jun 2019 15:45:53 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 857D1440046; Thu, 13 Jun 2019 16:45:52 +0100 (BST)
Date:   Thu, 13 Jun 2019 16:45:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: Re: [RESEND PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561
 regulator support
Message-ID: <20190613154552.GL5316@sirena.org.uk>
References: <20190612144620.28331-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Content-Disposition: inline
In-Reply-To: <20190612144620.28331-1-j-keerthy@ti.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 08:16:20PM +0530, Keerthy wrote:

> patches 1/3 2/3 are already applied to linux-next.

This doesn't build without those patches:

  CC      drivers/regulator/lp87565-regulator.o
drivers/regulator/lp87565-regulator.c:156:32: error: =E2=80=98LP87565_BUCK_=
3210=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98LP=
87565_BUCK_10=E2=80=99?
  LP87565_REGULATOR("BUCK3210", LP87565_BUCK_3210, "buck3210",
                                ^~~~~~~~~~~~~~~~~

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Cb68ACgkQJNaLcl1U
h9AUbgf6A+P+h4sdG/p+dyYpkKGR3cquJxOVi7Exm40YbqYaCWO0HY5QzQFIuW7J
gp1fNPT0jE9eSpfZFBDHxSJjBVsaQMBDLa5lxjZoxjR1s+TBCsb1KvZkNeUmqaq+
MFsy4b4R21CFzZa29LUKVF6d+OP8dror7J4Nrs+XS0qk9B2woSuvtH5XoNQ7blD6
cL6ibkfEWpaL/LZYpjbAHWdyUD9/xMPBd+3LR6N+FnsqcxdGsC/vExczha6DgWHo
8vEX3Upy/jAph3CAcBWTx6qmWmroonea5tLg02jqAha/Un+uvVRSSwsOQYiTxqm7
9ua7ffTjwmyDRxOFrLLz4b0Sb6GeIw==
=jcCU
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--
