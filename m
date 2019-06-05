Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012BFC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD02D2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559764003;
	bh=lpXSty8OvP8wMPY+dbYLrBP1KgGqVQex58AtPAl7jPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JFRL0e8O2i2UMF5zhliRsG8cwaz+WsWbVblw4gOFP7h/H2SDBOo88eP2v508X9ZMA
	 a+Gqs8Pq9gA1osC5ysD4D4pwvOBZQzLDYaVMDcLhm/GAFCxVFhFebY+rnoA8+PgZJ4
	 1+N+JfZHollnMLofCgG+10Ct+rRCBPpo2Md+La4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfFETqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:46:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFETqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kZOzUUZ1da7mPtdEIr5pBNywzNIi07uBPLrGLgK0d5Q=; b=tVdH1grPqhyZ6eMQy0JywOyu1
        oxuYOmt0jEzsT+tK0qeH10zU3cNaGmrJe9/RmXC0bVgr5rzNqd6iFqx1GoPFdnw6JU0tK4+LzkWzF
        1Zm1xvMIrZgOmSwzrlW/wQPpWqgEPR/TMWNQ1uvGsUjK48q/dMuyAMe5CjZ3aQkMsHudE=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYbrp-0001PF-B6; Wed, 05 Jun 2019 19:46:37 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 9A9B0440046; Wed,  5 Jun 2019 20:46:36 +0100 (BST)
Date:   Wed, 5 Jun 2019 20:46:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 0/6] mailbox: arm_mhu: add support to use in doorbell mode
Message-ID: <20190605194636.GW2456@sirena.org.uk>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
 <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
 <20190531165326.GA18115@e107155-lin>
 <20190603193946.GC2456@sirena.org.uk>
 <20190604093827.GA31069@e107533-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O/1O6NUaCrlCPhw5"
Content-Disposition: inline
In-Reply-To: <20190604093827.GA31069@e107533-lin.cambridge.arm.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O/1O6NUaCrlCPhw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 10:44:24AM +0100, Sudeep Holla wrote:
> On Mon, Jun 03, 2019 at 08:39:46PM +0100, Mark Brown wrote:

>=20
> > It feels like the issues with sharing access to the hardware and with t=
he
> > API for talking to doorbell hardware are getting tied together and
> > confusing things.  But like I say I might be missing something here.

=2E..

> So what I am trying to convey here is MHU controller hardware can be
> used choosing one of the  different transport protocols available and
> that's platform choice based on the use-case.

> The driver in the kernel should identify the same from the firmware/DT
> and configure it appropriately.

> It may get inefficient and sometime impossible to address all use-case
> if we stick to one transport protocol in the driver and try to build
> an abstraction on top to use in different transport mode.

Right, what I was trying to get at was that it feels like the discussion
is getting wrapped up in the specifics of the MHU rather than
representing this sort of controller with multiple modes in the
framework.  It's important for establishing the use case but ultimately
a separate issue.

--O/1O6NUaCrlCPhw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz4HBsACgkQJNaLcl1U
h9ByUgf/UsJL7ity8FKfFJ8RCFQnmEJwwqTPF2rr5baP6c9jYRf2nJx1ZEL8CBQQ
NbUfRcVcpQG2901CsRWwzKGEQ6ISkphLyaissRoh2FVJEJkeZkMkt89BD0O5h3/G
NRuofyB0qDaX2uMC81S+EQgpu/oB8uFgIOQ0Hp7tpz116b50qf7tb0c+ww6OYlTD
CQJK8XRRLfA+eQ1NgF6mLYiWWda6+xSs79QsrFsypRLgAChputP3NkM4lDFQPYeH
X2zMWOqPnQ0S8y5Nc8uIxkUMaQ8v4rN8xYjLjE8dTNjn62omGAo6wJFavlozdn6X
vC4syRan227VJQuJ+YZ83T29+f5TUQ==
=POCs
-----END PGP SIGNATURE-----

--O/1O6NUaCrlCPhw5--
