Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074DB20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263210;
	bh=ANQO2ApB2En3pMDbZlXOjrig9w/lz+tn8yahenzVHaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lo/426F4etJSvCCSzzgModRNZQ5+cOJ9sqJsnJbyAbPcnxZIlC4NLtZut75bgnDMU
	 wtRKv/8mQ9iX+wjmI3Z5qnpyse3jXFgHu2UY5SGv/DNC3NFl41Q6QtDBWAHa5GjHC0
	 9sCk7zViAHmxlcPeZbK//wEX2zb9vGnPGweUF6nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440483AbfIWS0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:26:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49010 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438244AbfIWS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zw+H0cLzv/wwqoCNPLuepePG6BXzshdDMwI7nmGluWE=; b=fKjhg1afHN0bskjgwyq9Io5Cu
        Uy0KP8nn8p8ohmwBpELJ9JE/+fVoxTyba9bySGimHT6golLOxvZ0pAbFoNxr9uKGSvSA5BIxMtEXm
        yzngWO3G+0KzgEAjcKOxDl9W86UWTmdQi6InLrl40Pfi9MGte/6+khTJKabJteeX0bAb8=;
Received: from [12.157.10.114] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iCT2X-0004Xp-9o; Mon, 23 Sep 2019 18:26:25 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 46260D01F26; Mon, 23 Sep 2019 19:26:23 +0100 (BST)
Date:   Mon, 23 Sep 2019 11:26:23 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jiri Kosina <trivial@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH trivial] sound: Fix Kconfig indentation
Message-ID: <20190923182623.GX2036@sirena.org.uk>
References: <20190923154547.26532-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AaroDtM9M79Ffl67"
Content-Disposition: inline
In-Reply-To: <20190923154547.26532-1-krzk@kernel.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AaroDtM9M79Ffl67
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2019 at 05:45:47PM +0200, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig

Acked-by: Mark Brown <broonie@kernel.org>

--AaroDtM9M79Ffl67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2JDk4ACgkQJNaLcl1U
h9AK3Af/Tumh0ikqpRGJ0LZQlwnZL1S5vUwKQexSehpfKUrROssuMuDooB4KfBpz
ADosYAcnRlbfTq0/WyLAbhOUUYfA11tff0W8JqcdhWDupk+DWkHGiSgARTy18/fx
QQIiYsgO/MAiMJLVUS8Qm55ro7At6IGI6nGxDUtLowI/2OBxRrIXLlik9szhF9UL
hfh0nRX4R2gIj33W/MuTWPLiRf2SUAvK95Z7+0QoiCMAwY+d4NKkjNTdqCKJWfeK
FRBvFxRrd7KWIVq41QLWFp7FX3+fPEMhi2Setm0a7XVTszCKb09uxOIIKNJ8JwDv
vOR6rMrZvaRkVnVT+BsW5n9HY6OksQ==
=gZw4
-----END PGP SIGNATURE-----

--AaroDtM9M79Ffl67--
