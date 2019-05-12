Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CDFC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054D32173E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557680793;
	bh=3WR6j4tUBuLmYW66VmpK1RVIYXW+PeG8uLUex6Dz2dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vjNkIzlhNpdPqQfYyGN6oUKgkeFSqewyn7ZprA2AFjKPWISQFdCnPsbpBFO1I4MeB
	 XWTYM3jbDECf82NNX4Gyuq2qtEBFXKzjbGckXx3JlXjNHpwnJG5JaQdxKZiUfZGqET
	 yWJONeFkp1hfIshgCU25sT4x0lt0BOkhJ2wbLj6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfELRFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:05:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49356 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfELRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i7AIbl3LuWCqd7OLDSbBZZ+JZVLRCdFPtZTLEmXFlX4=; b=YcPgH/wO+xi9sH9dzNiWeGDnh
        aut8UScY9xKtjJf0ZSIy0pUP4FNY/xtfCuKYjbjLkdWva3AZvyNCnW35thx+T4VdaF0gkKNAJ8hpL
        mwDObNGZGo8C0jJ0mQ50lzj40EZfdK0a1mK92z7NZLMISwwWGQ1OYGJCXiM1ccBafV3dA=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPrut-00044U-NA; Sun, 12 May 2019 17:05:39 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id EE2C5440056; Sun, 12 May 2019 09:27:26 +0100 (BST)
Date:   Sun, 12 May 2019 17:27:26 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the current
 substream
Message-ID: <20190512082726.GL21483@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
 <20190506095815.24578-3-jbrunet@baylibre.com>
 <20190508070058.GQ14916@sirena.org.uk>
 <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
 <20190508085758.GE14916@sirena.org.uk>
 <5b677f1581565bd8c915a14cd91352ec4bcabdd7.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Content-Disposition: inline
In-Reply-To: <5b677f1581565bd8c915a14cd91352ec4bcabdd7.camel@baylibre.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2019 at 10:11:48AM +0200, Jerome Brunet wrote:
> On Wed, 2019-05-08 at 17:57 +0900, Mark Brown wrote:

> > Probably using a mutex for the flag is clearer.  I'd rather keep things
> > as simple as absolutely possible to avoid people making mistakes in
> > future.

> I received a notification that you applied this patch.
> Just to confirm, you expect a follow up patch to re-introduce the mutex, right ?

Right.

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX2O4ACgkQJNaLcl1U
h9DTqgf+PkO76Y2CBGrPX0MuFUXOjE2QlNeHbqPtBweMBUAI8bHZbVVwZzd4RWQc
MO9Na+UlPDBKHaxlfkC8HqV5Tud6PMmAcXYj/qJCiGewOTwVI+C472JBLfsYfont
dfAkAhqUE+XZ/WlF1MELpoXCWAY3AP/i8RLP7it1dD0Y58HZl3/ofjtB0eIXevAr
HnPMmyv9VzSA9RmD7bEwzeuURho3714tlQs45grB3UtW6h39hDUWHanl8v+uet1u
gyHtxg9tE90edoV83T8lkqwiRuO7Pd+V0XVKM1bvGpNVMEAgR6iAQ02UUgULBzh9
qVZx8lrwwvTjCIQVH+VUw2B5NwV1Rw==
=m9x5
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--
