Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBC0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD22207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554196214;
	bh=RCLI6jvyLpySCZZYO8g+bGv43T2N8g5KVkec6dBhgT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eunLQeIKGijPItIMt94Dn6POPfH2/Tww8RJz7puO63q5H+/CYCsN+uADQFM8WfOER
	 ah82rva5vRVxL+gVd9M2QYQqOUYpBwUDFJMSsuv6pcgyD5cXg1IFvZnPUgLYH7vVom
	 vkDVV55DxzCAGosM1ObVxT0j8KcqqkvjScjxizQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfDBJKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:10:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49222 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfDBJKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PQtR22IfGnpW+4UD8rHmpQlgcjqz35SLOcrjDxw9uB0=; b=ogJNGOM02Dyx7WFRUUxxL78PO
        Op7JXiRheKKf4vNXPhChJnnzTcUG1r/rkgiiyp8c9lW0o4GWSt1mMksmvA1yLvjDDghsvKytlYQtu
        CzfotaPeYqIIb09qX9uIespYhjGLAueSApZx6mGLi3gTPIQQ6susw3QPT/tjQU0y9T05E=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBFQm-0006lO-Sc; Tue, 02 Apr 2019 09:10:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EB5F2440082; Tue,  2 Apr 2019 10:10:05 +0100 (BST)
Date:   Tue, 2 Apr 2019 16:10:05 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Message-ID: <20190402091005.GC2059@sirena.org.uk>
References: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
 <20190401073450.GG2059@sirena.org.uk>
 <ce9e8ca8-6db7-1be8-5ea3-c098b1c1c813@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U58U7wle/RT11wuz"
Content-Disposition: inline
In-Reply-To: <ce9e8ca8-6db7-1be8-5ea3-c098b1c1c813@prevas.dk>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U58U7wle/RT11wuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 08:43:51AM +0000, Rasmus Villemoes wrote:

> Thanks! There's one other option I can think of: don't do the interrupts
> at all, but just busy-wait for the completion of each word transfer (in
> a cpu_relax() loop). That could be guarded by something like
> 1000000*bits_per_word < hz (roughly, the word transfer takes less than 1
> us). At least on -rt, having the interrupt thread scheduled in and out
> again easily takes more than 1us of cpu time, and AFAIU we'd still be
> preemptible throughout - and/or one can throw in a cond_resched() every
> nnn words. But this might be a bit -rt specific, and the 1us threshold
> is rather arbitrary.

Yeah, that's definitely worth exploring as a mitigation but obviously
with things like flash I/O that gets a bit rude.  Hopefully what's there
at the minute turns out to be robust enough.

--U58U7wle/RT11wuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyjJu0ACgkQJNaLcl1U
h9AQpwf+OuW45aY1671qbCW3I/2+1Z2PuTbheg08DkMzK9IQ6qmkz9Web828TcQk
Wh+mr066jfLo2rf2NL3Ed2/zu4Y1GPn4wtqblsg1Jl2UsRGk+V4Eb27iaj6szvU2
GenjVXF7zia3xVVw5ISh5IKVnko+rRZnatuusPffejsXoRrtiG5gN3W9EJH6+oK3
b6BIPgQBqS0/de54NjVFthmd5X24fGwRfi2DkMwtN/W1k2Y8/bTQwTY+z5lepLRU
pM83mhetp3X1jZAt4KwjGlKmE4ATaU3Q8bDwOwTCyhyRMxDtUkts7pcyf1uez/rh
X3OwafCkR2xlVNqfRPt/mepvxntvLg==
=dmgT
-----END PGP SIGNATURE-----

--U58U7wle/RT11wuz--
