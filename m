Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A1C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7882720652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698300;
	bh=FIQappoQNPBpsFhelGyOFEK8HEytqtUXHBYpP3e6OPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gnMFGZSN/KbaSSy1mLHq9VHsKh9O5O/c0VjMS9zxl4S+uWLZ2m0MdYT/USHnkhdRJ
	 H9prRhXK51o6G/4TPeoo2yhyfPO/XEcH307Km4ddNGkg586/L815igJPhRszlFZdzj
	 97byAN3UoSuDoPg0AKzJAQZowfkzR1npV83PGQw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfDSSY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:24:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbfDSSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9evbReQLdq+rp87quJMzp43eYZ20TfGih2DP6IM6lWE=; b=EsLTAmKZCqECpItCHLc7uYj/+
        dwfEilLs2bOLjwoqDNFi8RI3Uiq8my7ZunF5OLxQqyKBhTwFkKSpYujWurN36JYelFDENn+lzbTFG
        8xF7pUwvUYRUR3ZQkb32rwFQqatfnR3QDXO50PvN0yBE/69zFgfOxC26jAquedTTlqH9o=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHW7T-0008VJ-TY; Fri, 19 Apr 2019 16:12:08 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 726D0441D3B; Fri, 19 Apr 2019 17:12:06 +0100 (BST)
Date:   Fri, 19 Apr 2019 17:12:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     lgirdwood@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] regulator: Make symbols static
Message-ID: <20190419161206.GA18211@sirena.org.uk>
References: <20190416144109.33692-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20190416144109.33692-1-yuehaibing@huawei.com>
X-Cookie: Please go away.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 10:41:09PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>=20
> Fix sparse warnings:
>=20
> drivers/regulator/stm32-pwr.c:35:5: warning:
>  symbol 'ready_mask_table' was not declared. Should it be static?
> drivers/regulator/stm32-pwr.c:47:5: warning:
>  symbol 'stm32_pwr_reg_is_ready' was not declared. Should it be static?
> drivers/regulator/stm32-pwr.c:57:5: warning:
>  symbol 'stm32_pwr_reg_is_enabled' was not declared. Should it be static?

This doesn't apply against current code, please check and resend (I
think it's just that someone else made similar fixes already but didn't
check properly).

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly581UACgkQJNaLcl1U
h9BX9Af+PhgDnWEvYrbvMVL6LtazYOGzHy8oW9xjmFyhMdEcELuy3s6VK6MypHmQ
HGXLQQFx+Ke+aRL21hodBuEoHk4TxywdrBiDg4Rv3rXUs4eV/vfsMZKv3YhjsiCv
0V+Y/j7cMuzU0kWA7yhxl3z4n6/gDLcMBIjHD4gqlqbcqC1VZFpQV+Fo4z69Abng
LbBoYHTTHaiohZuYHxrJDt3tiT9O5uEIwPoTcA9FPQwfsGAtxd/xywlPCJQi57RO
xSwLO3fZj7Rk7CVuh1m1awJOVRVj5W0O8+lQLLDZJr3AJQL+2OnONooq7mIMBci5
2yv4zcfluvwLvrVMHNwRUmVFW/uhZA==
=y4Ip
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
