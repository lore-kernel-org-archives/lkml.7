Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2BAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457BA204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565267264;
	bh=qcJpF5sH8EjTU2YAp6xLoeuP92UYj3QnPSPnYj1D+XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ki0ZnZ8ZVC4pHpMJW34i87y92fteKgHTqTliuLE3wNukmsOvyeUd5Q1SOTqShN8bF
	 sm13KFxCep89Ypw5GdfCFjSBKIbezcwkuuBe5q1kZNwMABzTxayXV8GBum0zXTVXNJ
	 BaggeRgsp5MW622opCtZCl1ZPBnHWXSVLBTshuYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbfHHM1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:27:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33058 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XT7FXEAc0AKqvinWOlJDsKF/Qz/NIldOL1mI3L4QB6w=; b=dQNWJDy5YeLs+jkwEj4xpgq5/
        DBI0WXibr+SB/gjDQXZ+l6h1euxjJ6uF5+sTVb1QZ789xvURbT8FKFWlwALhLBkSYua8BVjSh9nnE
        uKaIbahAzf6bkNo2ADOyqHzZ8G+ZuH5GXiTL+TuTCUGUtYg27PhKmRAY4pY1og4FjyGHA=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvhW9-0002p0-HW; Thu, 08 Aug 2019 12:27:41 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7E0CF2742BDD; Thu,  8 Aug 2019 13:27:40 +0100 (BST)
Date:   Thu, 8 Aug 2019 13:27:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: core: Add of_node_put() before return
Message-ID: <20190808122740.GB3795@sirena.co.uk>
References: <20190808070553.13097-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20190808070553.13097-1-nishkadg.linux@gmail.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 12:35:53PM +0530, Nishka Dasgupta wrote:
> In function of_get_child_regulator(), the loop for_each_child_of_node()
> contains two mid-loop return statements. Ordinarily the loop gets the
> node child at the beginning of every iteration and automatically puts

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MFTsACgkQJNaLcl1U
h9D/1gf+N9kCZcP5ptvF6gkwQDM3Ng9R3apuMcaULdoX0Tj+aZA9N8ZZfLlYjCTt
pZVAX8UnDn2cQ6dvnA7SXTqtZ0vGTrNtxDmByJ8ju9vFJNsZCqMV30qR6Y+/fP0d
tCP0hXz3EVitTLvxodW+OOfa6TJvem51rUj+q8lnjoIo3RohOE3mLwzS9/lv++4/
IudlYN5WVDx7zOruh/FsR5HC7REU3Tf8erRjpeiRQOjptRaEEiNmWgNyL4TjdxBy
UHTaQimMWk1EkVK4JaGpoFjmXRbMiO02asuNiTgLGVYXsGsrSV3bau+o/m18jBPY
p7mb6utG0FXIFhjbODG4EPDGrsqUAQ==
=+M4Q
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
