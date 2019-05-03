Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591DCC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122502081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556863888;
	bh=yu5vnQWN4bJnaV2Bvju2K3GUUEYnT5P7jOsHkUTZ1Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ndUE5Aib0WqMhfSYOt7xdPl8fyCPlkWN9E+jpC2lGvHrq8vbMHx9YzpweHgLvzIOu
	 fENtuKfyxmT/PiAxeRKfe6ilJ6qApRfdGpTfQj+ul5JXSB9yYXD39NONp9xwyaCiMq
	 Kq27wTsuNdTSa9jqIBCmm1eGkqQnNVbOUuP3SmcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfECGL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:11:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40110 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECGL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a8B1muFE7lmKz338Eq4rDraWNNZB+Seiq1IuidyrS40=; b=eyWvdSg4GxfOe9V5fBDgDA2CR
        67XEx5ktm3mnEGj4Djz4SzHp8FsCJh8Pw4BlzCaLh4kYbNWGAqdE/RFXc1uS/C+PvQkWApQWF/vgj
        /qP0z8dRf6VBmhnRvZkienTvrq+t5UC1kdhnEAqUjcBl4T8cQYMJ0/u1PSAf5QJY4+ESk=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRPf-0000T3-OZ; Fri, 03 May 2019 06:11:16 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A1199441D3C; Fri,  3 May 2019 07:11:11 +0100 (BST)
Date:   Fri, 3 May 2019 15:11:11 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: mediatek: mt8516: register ADDA DAI
Message-ID: <20190503061111.GA32229@sirena.org.uk>
References: <20190502131214.24009-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190502131214.24009-1-fparent@baylibre.com>
X-Cookie: Never kick a man, unless he's down.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 03:12:14PM +0200, Fabien Parent wrote:

> This patch depends on patch serie:
> 	[PATCH 0/5] ASoC: mediatek: Add basic PCM driver for MT8516
>=20
> v2:
> 	* Register ADDA before memif to fix ordering issue.

This is v2 of a single patch which depends on an in review patch series?
Please don't do things like this, it makes it much more confusing to
follow what's going on - unless there's some strong reason to do
otherwise it's better to either wait for the existing patch series to be
reviewed or to resend the whole thing.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL234ACgkQJNaLcl1U
h9DlYAf+NB6GD7ylQBBA7/swvGJd8bxeuqc3fRRWHfYBVXV1nkAQOhs5IoTziCE3
W2b1ACZX9lv2scdJ/8/OwxN10Q4/i30ShHMTIPeY2/hEn6dnPcYoTQg8n+W+Ca5e
Aa0ixg+VrXMYV7mSo8qYtuVULeOK1H8drM8pA61is2RlupNHtdwdFwfiCXO6uKRU
1FKvToH0OGsohgfGXdfGlz1JpSLNZrWefcyo2talqy3GTpXnMpROsGGZyNNx0EyF
bWLfdfuArrauf4kXhF559nMoWTIuA2/paZFVNNxZrmC5C8ViyU51Yh+nAz4iLFbg
f+dC4E1ARwca+ZyOMN/7V06nYMyx0A==
=dh9z
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
