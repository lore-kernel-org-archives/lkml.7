Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18FFC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBE92087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556858432;
	bh=aEXkKaRENuQpEkZiMFHPqEQ5eshMRiql7Un8Krp1YCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dF0+yJuW06eNe3DkzfiELhaL28+zYMm2YIIHO5Cb9/lohq9rhDQzpt+Fe3N59tqdr
	 wnwaiRlkpVrmBAEy69T1aANiC73Ua4dAFrSipB9bFRID+xE3XhS4+BJsMfOkC1gHge
	 vi8+jfshA9EsVn79YpMID6q1MV9nygZZ2av1xlQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfECEkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 00:40:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfECEka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 00:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7puOT1H5/jwpIFIzaaENQa5w62/b8d5Bx2dFBB0hxqg=; b=JjtNfQi8NEH0DnWewIHPgDpXf
        yK8l5F+QiWGgODu8fttloDgR2N9QAKBDMcygcaa7Ntm9rj0ipLGup4d6olreCufTX7mPyFdRzawkI
        6QX64J0L804eK+OFwotujETiMOxKrr5rxwvmQe0ELGOMbAyJSQNX7EWGbPUJ/F5FgbJZ0=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMPzW-0000N8-R6; Fri, 03 May 2019 04:40:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 211BA441D3C; Fri,  3 May 2019 05:39:57 +0100 (BST)
Date:   Fri, 3 May 2019 13:39:57 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Message-ID: <20190503043957.GA14916@sirena.org.uk>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pMHZerOf5PT7gmN5"
Content-Disposition: inline
In-Reply-To: <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pMHZerOf5PT7gmN5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 19, 2019 at 02:46:49PM -0500, Pierre-Louis Bossart wrote:

>  config REGMAP_SOUNDWIRE
>  	tristate
> -	depends on SOUNDWIRE_BUS
> +	select SOUNDWIRE_BUS

This now makes _SOUNDWIRE different to all the other bus types; if this
is a good change then surely the same thing should be done for all the
other bus types.  It's also not clear to me that this actually does
anything, do selects from symbols that are themselves selected actually
do anything?

--pMHZerOf5PT7gmN5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzLxhwACgkQJNaLcl1U
h9BFVAf+Kt8GD1suXskJzvuY/n6wUgMPGxKm9mip+31Y4Nv5D7V6nydDFOwdS/f2
0C6007zZSPyN2VqhgqhyuXlop/FAn9NkAHSsw5MEdOTabr3z07tL6TazA7pH5fG1
9/uTD3fbEcxQXJLvHhgR2KlkmbougPBt+Xbsl+7r/FHx1ZZ4lxhdAFZJmpHVRUo8
NtWcaeWOOpBEfd/0L335nNPOVChuNgpgUxj5mVidltafNB5H+9ygUWlF2ad0YaRK
qmjRWKCopc7DAghRUqIf8UoL+VV+YJnsuvTXky5lsuv56h3SXQiX50+QH/aKhbBu
+CDExuiE/VrK6yKLt8+xXpUHATjxEQ==
=RQMe
-----END PGP SIGNATURE-----

--pMHZerOf5PT7gmN5--
