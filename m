Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A32086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554088777;
	bh=HhB/Pni8+F9Gv4cH44CIWcScAgU+DWXPQPFwqEBbEcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dbQC5o2Vqo/VWYreGO7I2YWYfuKkcSzCcIjR0JU1VtKxP431aM9dmip0F/YPVobA3
	 QjNq00E6gaTxePbp/+phdzMdhvmnfeun6zcrjFQsk63Yg2xPdeAFjICDMFh8t0AllD
	 /zyjYi00+QFDMQrurmrWKjlHVN+nMN5bUDSP+bDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbfDADTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:19:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbfDADTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HhB/Pni8+F9Gv4cH44CIWcScAgU+DWXPQPFwqEBbEcU=; b=IKOM6hB2GnZubina35cAQbRDe
        zMsO7ZIfGmVWeSQL/ph+cO+B1fJE7Xdm6wIfCDzM7wjHyz8iyjUMUd5q6fzbWikRxZucB8lKqkbsV
        ZoDdUkjEBD2GIlJ1pXMWwSKvnZr+OLs5NTgj30aGz28dwoWy9hmdtOjoT+spC2a+JtpbY=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAnTy-0006ZV-BD; Mon, 01 Apr 2019 03:19:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4F718440082; Mon,  1 Apr 2019 04:19:31 +0100 (BST)
Date:   Mon, 1 Apr 2019 10:19:31 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: oc-tiny: fix negative loop bound error on for loop
Message-ID: <20190401031931.GB2059@sirena.org.uk>
References: <20190330212300.11675-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20190330212300.11675-1-colin.king@canonical.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 30, 2019 at 09:23:00PM +0000, Colin King wrote:

> Fixes: ca632f556697 ("spi: reorganize drivers")

Please think about the fixes tags you're applying, this is obviously not
the source of the issue.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhg0IACgkQJNaLcl1U
h9Cs6Qf9Fpbz2BMlEdLo7nS++JCHNNgHm4Bze8OKx/kUYqaoIGevJQa3I+XiiwdV
gEiumPsY5r9I12LcUrzCS82kjns6BelBI8d+tDc/rQLwC2L/J8g6ykWbT7FW/2Op
18R6ghzM+Ht99Yh2QlUm4GBF8iRw6WhUvdUlPIGRXK6abwJSR+4Pt7WpbB6ulFv2
wwk4He5BTE3IQgRD2IrkWvFrx5YCTP2/x9ObdngJC3cMd/HehIF57JO3LKz9HmVL
fVcODQ16aLBAF+Ju6U9C9aULv6gfMw5ueVQv7uWiq3mTNlrXqbgX+U4QBJVIhZR9
6pQGzyzYs6+8TO7YnESyWZNgoaImJA==
=Q9Dc
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
