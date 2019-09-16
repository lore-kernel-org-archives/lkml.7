Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4006FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CE3214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568632043;
	bh=9EhxaTFzCHjydcZwT1TX1Ezrt7WLpHMbORJjZEhaYJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MNFESKQSIh+X0BizFYu1k6tvoRsQ3gdxnoefnlEv4KyRO5zAR7aNvHyYddpCVeh1N
	 X/a65FxGGB91FRuHk5/ES6uNl869Ok87i+xC0bndz81NJsHNOTRVsXUVvw7pc/dmQn
	 8gaSIhqhBGPUHWUF1hHAiP2pSXiL17sfq0D29nhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfIPLHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:07:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47032 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIPLHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yYYWQnKUc4Oh1sJbJJ5oc8EXea2EwAdCJHCalwZgMXM=; b=Rx4y7DacawR++bXnaPL8FEPuK
        lBjyJmNTwLs6sbLrsBISdTJ9ODtS8ubkVtO4LDaIYYUhZhXqVAtP9n3DCZtBZmubX1COSlX7vo/TD
        QtlZbzTv9sLtxGP0dMN+Gli2BGGFt80t2JC4f5DMuKfbUWfQsAxDgdQaPBq5EcaCLnn+Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9oqk-0003yU-At; Mon, 16 Sep 2019 11:07:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4AE202741A23; Mon, 16 Sep 2019 12:07:17 +0100 (BST)
Date:   Mon, 16 Sep 2019 12:07:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: no release today
Message-ID: <20190916110717.GY4352@sirena.co.uk>
References: <20190905160237.2e972a89@canb.auug.org.au>
 <20190916013727.GT4352@sirena.co.uk>
 <D081BA7D-9074-441A-B6C3-A742B41FF111@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DVXvgjZtTc9TWCEb"
Content-Disposition: inline
In-Reply-To: <D081BA7D-9074-441A-B6C3-A742B41FF111@canb.auug.org.au>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DVXvgjZtTc9TWCEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 06:05:14AM +0100, Stephen Rothwell wrote:
> On 16 September 2019 2:37:27 am GMT+01:00, Mark Brown <broonie@kernel.org> wrote:
> >On Thu, Sep 05, 2019 at 04:02:37PM +1000, Stephen Rothwell wrote:

> >> As I said yesterday, there will be no release today, or any day until
> >> September 30.

> >I'm going to try to provide some builds for this week (16th-20th).
> >There may also be a build for the 15th depending on how much rebuilding
> >the rest of the trees is needed for the build I've got ongoing.

> Thanks for this.  Don't stress too much, it should ease off a bit when Linus
> starts merging trees.

Yeah, I'm expecting it to be fine especially since moving jobs means I
have a very much more shiny system to do the builds on than I used to.
It was just the week's worth of conflicts to work through on the first
build and the late start from environment setup slowing the first one
down.

--DVXvgjZtTc9TWCEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/bOQACgkQJNaLcl1U
h9BuHQf+PNUkRql8F9cOE7MofvZMc0CliH0bfxdOgeZrlXa37xY/KPGnr0U13jeI
aJ3WK8K71bfVLjgE6/5Y4o7cWPIc97EF1NzxSbdrFZlt9IfWhx0P7US9rd2KUjOM
YEaxgLzX+BeDwPuA7sHRORD0Rs8yEzx8FH/ISUIfDTU2xVLfbIfaFgf9sFga+vlO
GBIX0qCXaZECfWcB+zyeE8BawR0fJIPpuB8VklVc8wuTlL7bhrNnvcfOHhc1GoTI
ZM/lrjTPFOXMZ7iExMLIlJW2wmRGeXV0HZS/jhgjufkvvLJyQsIwtGZfOQXLa/KQ
a8dfJF3K1McMXCSMnC6lkPhyIFADnw==
=IG74
-----END PGP SIGNATURE-----

--DVXvgjZtTc9TWCEb--
