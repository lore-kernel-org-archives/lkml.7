Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E320C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D068C208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568822929;
	bh=vVgvcGgEuELXUfXsbuvT7tuO6CbO0HHmAw6W9rp88VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nTTQx8enhQREDWHjsFArk9kuXHHm0JOoSa01M032bUAaYAcjnv6BhS09YHOtDbCie
	 sd4QdHfWMgYspmd1kWfjD7PnY2se93U3bS5EjlG0tgEwGj3iHbqQytJeK/g/9hb2nL
	 2gdPnp/uiNZEO076cexBbWD50zmLk18VsVWafQO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfIRQIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:08:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbfIRQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n+gt11BxFqFvJsr5YUiBJ0bn70lpyoWRNSeQgaOO+LA=; b=kHOn3wSYO6lgJ6X9PX38b/zU6
        o2CfIJOtbtp2j9Ti6oiRiAOxwU+f09BrdDc6YpSX+6mWrJsRRqwqiCvTRn/rXCqkfKUxY39JmsRLl
        qzQbGUhQvhZRMnRig0oLMGHqkZaPDXeGIj7PyY+eBgpNYSW0PSSPLQmJd+f8E9wkxPXTU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAcVX-0006Dl-Fc; Wed, 18 Sep 2019 16:08:43 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 66D202742927; Wed, 18 Sep 2019 17:08:42 +0100 (BST)
Date:   Wed, 18 Sep 2019 17:08:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, zhang.chunyan@linaro.org,
        Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, lkml <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 3/3] regulator: core: make regulator_register()
 EPROBE_DEFER aware
Message-ID: <20190918160842.GS2596@sirena.co.uk>
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-4-m.felsch@pengutronix.de>
 <CAKdAkRSi+d0AXwXaxc4wx+p2kAf=+_P8HZnq-sJAKmbwuuKH4Q@mail.gmail.com>
 <20190918081807.yl4lkjgosq5bhow3@pengutronix.de>
 <CAKdAkRSneYYjcVe--P=m037aA1DaD+efbEcRGGKVk1hDeEw70A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkEkAx9hr54EJ73W"
Content-Disposition: inline
In-Reply-To: <CAKdAkRSneYYjcVe--P=m037aA1DaD+efbEcRGGKVk1hDeEw70A@mail.gmail.com>
X-Cookie: The devil finds work for idle glands.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkEkAx9hr54EJ73W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2019 at 08:53:40AM -0700, Dmitry Torokhov wrote:
> On Wed, Sep 18, 2019 at 1:18 AM Marco Felsch <m.felsch@pengutronix.de> wrote:

> > Those errors are handled but the behaviour of this funciton is to return
> > NULL in such errors which is fine for the caller of this function. I
> > only want to handle EPROBE_DEFER special..

> And I am saying it is wrong to handle only EPROBE_DEFER.
> regulator_of_get_init_data() should always return ERR_PTR()-encoded
> error code when parsing callback returns error, so that regulator core
> does not mistakenly believe that there is no configuration/init data
> when in fact there is, but we failed to handle it properly.

> IOW I'm advocating for extending you patch so that it reads:

> +               ret = desc->of_parse_cb(child, desc, config);
> +               if (ret) {
> +                       of_node_put(child);
> +                       return ERR_PTR(ret);
> +               }

> Thanks.

That's a more invasive change and we do have a fallback after DT for
configuration passed in when the regulator is registered, we want to
distinguish between the valid case where there just wasn't anything
there and the error case where we found something but it wasn't parsable
which is always a bit annoying to do.  The logic around this could
really do with a bigger refactoring TBH.

--vkEkAx9hr54EJ73W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2CVokACgkQJNaLcl1U
h9CqRwf+KHS+U8s1VKLlEwSovXoS/ed/Rc0g51Ng+a4RbbbNR+99vPBqi0tfOVui
JFVM11seetmRuEF7rOUXdQlwlzZ17d7MWiZoaPY9XvCowPto5n9G2w4s6qfF/6qb
lf690jFG5a6C8vpFRhkM4cEbYG7nyS5Uz5QLHBgvmq6jMpytN0nyyiQtF6Ovg1cu
qB39PqnfH/B9hDu59AdVjqUHydpMG2bAMjUXWZBIWbNJbnmfN8c9Yxk8746jS6DK
89J7YQrLhUcWevS+k229/GXwVH/ktOVa6wRmEE5Jr5l0kgmG1bpUBdNZ73+LDlbt
QC0b+CBAbMU7XHNaYWu80FfuQBaxxA==
=t2uh
-----END PGP SIGNATURE-----

--vkEkAx9hr54EJ73W--
