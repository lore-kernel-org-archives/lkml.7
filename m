Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8832BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556D9218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564137952;
	bh=0YY7mkRGRSxULY/Rw3dGZM6yw9mz2AHZvaMTsWTx5ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQUD2jrebAshNj5KhRhSexStKdypc5BWGMeBzNZixb4uVdBdYk6yWwb4NCroSHZSi
	 59chijCu3o9Jze0R2kQ5vKrZHqhlGijpYKyTWemebx55RHBmmvi+UvrdCC3878kNLn
	 L3Ryv2Mrqimxqkndtb7vYuiOeIfN99mgVHvWN4cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfGZKpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:45:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59924 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfGZKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DiLw617umykXb2Ab64YhiIyIqGLqcMOLE/qOfe0nhxg=; b=Zj5fo/Ze6u/+6R7jl/2UE8DZP
        XvkRoAiAuQiWDsCeWbifjJhRwmf8ruIxKTO+fB5ASu6V4Yr3I5EbKAwvpHU+sTgSrHAIJzb1V7Np6
        +fHp1FzJkjGwILI8fpHSJpw+sRRYNwKB/iN44KJpTzuVWA6CIjabdweLWjVIyUC78ESZw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqxjR-00018l-4g; Fri, 26 Jul 2019 10:45:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DD4052742B63; Fri, 26 Jul 2019 11:45:47 +0100 (BST)
Date:   Fri, 26 Jul 2019 11:45:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: of: Add of_node_put() before return in
 function
Message-ID: <20190726104547.GA4902@sirena.org.uk>
References: <20190724083231.10276-1-nishkadg.linux@gmail.com>
 <20190724154701.GA4524@sirena.org.uk>
 <af559a36-c926-e2a5-a401-aae0f6867a6e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <af559a36-c926-e2a5-a401-aae0f6867a6e@gmail.com>
X-Cookie: List at least two alternate dates.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2019 at 01:02:52PM +0530, Nishka Dasgupta wrote:
> On 24/07/19 9:17 PM, Mark Brown wrote:
> > On Wed, Jul 24, 2019 at 02:02:31PM +0530, Nishka Dasgupta wrote:

> > > The local variable search in regulator_of_get_init_node takes the value
> > > returned by either of_get_child_by_name or of_node_get, both of which
> > > get a node. If this node is not put before returning, it could cause a
> > > memory leak. Hence put search before a mid-loop return statement.
> > > Issue found with Coccinelle.

> > > -		if (!strcmp(desc->of_match, name))
> > > +		if (!strcmp(desc->of_match, name)) {
> > > +			of_node_put(search);
> > >   			return of_node_get(child);
> > > +		}

> > Why not just remove the extra of_node_get() and a comment explaining why
> > it's not needed?

> I'm sorry, I don't think I understand. I'm putting search in this patch; the
> program was already getting child. Should I also return child directly
> instead of getting it again, and continue to put search?

Your new code is dropping a reference then immediately reacquiring one
to return it (introducing a race condition along the way).  Why not just
return the already held reference and not call any functions at all?

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl062dgACgkQJNaLcl1U
h9BqfAf/XkPCA/poexRgHnpFE+r37fkrF/5xoqRAFbobrvS42H1YdMPKPDuShBG2
akn59PB6QIRjUgSVJVgdCRvAVDR6/HvvR55SUD66w6iQY3qHIFGxn426t9huP++T
Rox4MQtM4W/6QKb9jXN8fxstr+bvw7LXgXoc5ZHBQ2boMfWormTWe7TtNIp+uZkc
o2Id8iUdXPRk6fwQcRtTAiL3cJpLKWEGh0zK3EB8gFSFolgacoOooY4XeR02lP2T
zmNYrdrGlNPG9ddjKW+RBerO1v8PObzmWmY3hcsTnbhQMnolKklzsJB3egv9FpLW
pbq3pldG5+VJsEHoOmcAnq9DgAUAGQ==
=k/xs
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
