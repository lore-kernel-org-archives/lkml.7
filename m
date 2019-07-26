Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF27C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32152189F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564139876;
	bh=2MaCFPAW6J8gbjPDlbX0Tu9A2l4/AGlw7Y8zzRzYFFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UlXXywvanhOMAjYYzjIak3mDNXN+5dBzZqh76+z875eF7qo/cp1L23HhofQvkJez2
	 8Tf2+/jVfd1fTTRKZhD+dHZltzJfboX7uPVqYbZpqacP3qdtQzzC4tjxc+bKnK5UQO
	 0gNTNk+YF3ZYKgLI2c/qkvBpaMz+/N7Y6FPbKA+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfGZLRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:17:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfGZLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jm4OpSGofOUA5dqIvnMduxBbq6NaNOEvIczSvNy1Q0U=; b=K2KQcfiPjs6rgnZatJ0kUxrdK
        cpwlYJ5DdwUBS06TZWBTp08lIZAQLcwK5czEc/6yJdS+KIvG296bNLUjvfJSRQ2xgyn/zcp3DDFqZ
        iGhVj8B8GaJfmuLs7bJRXPejoee46BgPX3HXB9ERe6C/fXfYDCvexHCGzH6jgLCataL4M=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqyDv-0001I1-8I; Fri, 26 Jul 2019 11:17:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 13D6D2742B63; Fri, 26 Jul 2019 12:17:18 +0100 (BST)
Date:   Fri, 26 Jul 2019 12:17:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org, mka@chromium.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] Revert "ASoC: rockchip: i2s: Support mono capture"
Message-ID: <20190726111717.GB4902@sirena.org.uk>
References: <20190726044202.26866-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20190726044202.26866-1-cychiang@chromium.org>
X-Cookie: List at least two alternate dates.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 12:42:02PM +0800, Cheng-Yi Chiang wrote:
> This reverts commit db51707b9c9aeedd310ebce60f15d5bb006567e0.
>=20
> Previous discussion in

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl064T0ACgkQJNaLcl1U
h9DmAAf9FDy70YAEs1yPd9vLXET+RkMVfd/1yiLlweWPaqgu5WqZDjmBFBOQBj98
CnVVDFj3X1Fv6bQs6Q/+jRMuP5ckxiGPCFO2n0dV70pXNj0m/iGUHtj4ly/zOqsH
hwNNbmOpHphNoz87TaPFdPCj6XWPcNUOIa9b+mv/g8sxzR+9AdhzP0xLaDY7ixN9
0sZ+5QRGFuPsu/WscetgXtdTlhxFnEYpm6HxgvmZIrdKW0hYKVM7rSj4wKxiaP9T
ZyYlSmH/oA1OATb8LuDUPE3TTCEmMnyZUSyEAHeXAeWNFZzNn4bG0XYBeQoNZE8C
HZeFqmHV3qj2cU3rejJ2g1P3zqrKyA==
=4GTC
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
