Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D3C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13484208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559923544;
	bh=kd5GsWGzTUp4RqE1pDbtp5fb3I07nUQQ5XgJZ3PPlVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jVP6QnZLj2uDyrDE4kDC1LQMKhULPMachb8N4xJZ4EDdC0rxTv6NoR7tBwUOzyryV
	 aq1a6BYytUtZLYyvIGsYZNSnCmm8x5J0LzDmpXOOiWYxbJN2i2GQ9Fml31F6X4Wtb/
	 jH/50uVaE8Ks2Bv9sJhwKj/aYVZa/U2/c3DjhncY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfFGQFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:05:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfFGQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AtaSTkf1DBf94OVADGmL4073qC0dMdKOc6GCWJ2B5nE=; b=kVMKtQN2lU5qDB9hwkgVECukB
        6m8Mk4mxg+JZJ9GxZOxj9OFP/nyuP84YEZKcp145Ff+lrth76K8hff7HxAMH3ldl9Al5Qv6enqToF
        j1pKTsQpQVvXN9dcMyqsPUVAJnYfQ0JWiJWzfImh63ZcoUnPIMotXgIRIduj70+poP+UI=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZHN6-0002tA-C9; Fri, 07 Jun 2019 16:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id CFAEF440046; Fri,  7 Jun 2019 17:05:39 +0100 (BST)
Date:   Fri, 7 Jun 2019 17:05:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Message-ID: <20190607160539.GI2456@sirena.org.uk>
References: <20190607155631.15072-1-paul@crapouillou.net>
 <20190607155907.GH2456@sirena.org.uk>
 <1559923340.1918.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LPYkZes1JsE9T1lX"
Content-Disposition: inline
In-Reply-To: <1559923340.1918.0@crapouillou.net>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LPYkZes1JsE9T1lX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 06:02:20PM +0200, Paul Cercueil wrote:
> Le ven. 7 juin 2019 =E0 17:59, Mark Brown <broonie@kernel.org> a =E9crit :

> > Hopefully not since we might probe later on if something registers a new
> > device...

> Makes sense. Sorry for the noise.

No problem.  There used to be an annotation for probe() and remove()
functions but it got removed since hotplug and deferred probe made it
very difficult to ever practically take advanage of it.

--LPYkZes1JsE9T1lX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6i1IACgkQJNaLcl1U
h9Ctggf/ZkWVbeBDP7S/xhHdF5lonQeFIVA24awMWy1BPO+zdDas4oSFwUBik4c4
u+krCzZdQzwLx5ZTHPFSP+cxhvYy0HV3hQxIXjhCFS7JupiL1npDKoCLGjvKSCYI
5hMjEASlUQYk0XiRBVfnEKshR7dPq0UBcRkgCnmo7xOpxaeg75vfjtePZmGYNPKA
q3aDOK9Z7fGJFzF8qSDAUrofo7D2DiWZRuH8/aB6W46IAstodUZjLOS9cnU+SC0e
GQ+hj4XaJg7Jfmy3SAeck6fmDOF6+Xq5hulHItYU+nzYLOLGZiJrjiHzf9ilPNyG
7wU+IQpIiKYRkfo5BIueEGnAvKUf3A==
=UR4I
-----END PGP SIGNATURE-----

--LPYkZes1JsE9T1lX--
