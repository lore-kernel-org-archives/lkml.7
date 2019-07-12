Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D3C742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1D82084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562929025;
	bh=FUTKQZFBxlg3r/HorfMiicWyVwroPqc8X0h0TrUErCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k6FAPFIT9wCWS+86feRb+JfVCzDIpP7iB/2/TJnKf+E/k4yXMLzo3vqABLQGoP1Wr
	 hIwb2UguDpkr8BjD7hPNPZhEGo0q+lRl4Smo1tZU3+W+kn+UK4bLQl/RmOg2piO98S
	 /pmCAFsz8PU3mYWrv6fSWpVe7ewv7uI7xCC8Adq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfGLK5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:57:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfGLK5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R31OTluumCbFh2Wq31EACJNPV9PVLFkU904R5DpMCmQ=; b=Nc4DglWLq32b6Q41Fp8lXJdIp
        np6/G6hkVmv0LaMlmjuouu3lOkuLsMNKDIwwzqFWsgk5hGw2KtNFfIzpj/VmQtQwisTLlQcvOdClm
        +qObwFo7QHEYdhD0xUWeL88AcT+i+snqELMLwjfeyWRXvB2qx7OvIOQDp697kIzsY5L20=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hltDw-0006AP-9P; Fri, 12 Jul 2019 10:56:20 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 685D8D02DAD; Fri, 12 Jul 2019 11:56:19 +0100 (BST)
Date:   Fri, 12 Jul 2019 11:56:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: codecs: mt6358: change return type of
 mt6358_codec_init_reg
Message-ID: <20190712105619.GL14859@sirena.co.uk>
References: <20190709182543.GA6611@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bPg9NdpM9EETxvqt"
Content-Disposition: inline
In-Reply-To: <20190709182543.GA6611@hari-Inspiron-1545>
X-Cookie: Visit beautiful Vergas, Minnesota.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bPg9NdpM9EETxvqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2019 at 11:55:43PM +0530, Hariprasad Kelam wrote:
> As mt6358_codec_init_reg function always returns 0 , change return type
> from int to void.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--bPg9NdpM9EETxvqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0oZ1IACgkQJNaLcl1U
h9DBvQf/bEOPmabOAkiJN59jKdo0Gi0w05y+5JDO15GfjfCufMDcc4Ul9bl0aH0X
sBwwlklO0yJM4Szsx4dy8rVPtdU6GldTUUIprkzTyzb+e2jO63BxyTzR85GKXwkt
0UFKK8ZOp74xrpxkc3ViFRwnfKNQ8qm2eqcoszNwUH8xrqPOFYhrmIjBrmlikuEB
+ojxODhzc18uqCo8YUHrqFHW85L/bxomSFWVP5Uyv+R1STDaZHJC/8uXlBdNu8C/
B+DDhV8hBV8YLAS8fYeNTARUhBf/IX9Yukc4h6hECKdK80l4mhqK/mOVeMXvtSUW
E+3CB4XK/4FDzc1nlg01L9omlgrGAw==
=pELE
-----END PGP SIGNATURE-----

--bPg9NdpM9EETxvqt--
