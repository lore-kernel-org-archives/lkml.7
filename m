Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54641C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287A921873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563988032;
	bh=aJSfoCG0LAsFAd62My8xcDFG0irllfrZC1k2MhIA3m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2SJdCkhT2LsPLJ56EtTrbxBAJovYxipk33fGA62hn3wJ1suBOjAPBVwbrfUdKMUjw
	 5o07tJTOFYsf6hVMwfCJ4mbUk3BrfUKb83slPydskHCbaMLy9rU3cyozoM0fX2vYLR
	 HywRijDYDXVnVao1mKKTyIlxlYWxSqS00KV7SNqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfGXRHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:07:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGXRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aJSfoCG0LAsFAd62My8xcDFG0irllfrZC1k2MhIA3m8=; b=ua+DyaI6E4NpZjGyP76iocXiU
        7w4llWVKfEyGDbMUWxrB62R2X7E2SU8mAQvNsmQ2AEbl2uSHkpCfecpW1JEAANwdwPUfOyCKLh8yW
        c0IFnjhWhfkJrMivbRVuDrMJAdg6OLRb4rUsbGajF2zc+kdo7fXREZC+j3k22D+GcPEs4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqKj6-0008FO-PZ; Wed, 24 Jul 2019 17:06:52 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4F2372742B5D; Wed, 24 Jul 2019 18:06:52 +0100 (BST)
Date:   Wed, 24 Jul 2019 18:06:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190724170652.GD4524@sirena.org.uk>
References: <20190723181624.203864-1-swboyd@chromium.org>
 <20190723181624.203864-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20190723181624.203864-3-swboyd@chromium.org>
X-Cookie: Matrimony is the root of all evil.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 11:16:23AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.

Acked-by: Mark Brown <broonie@kernel.org>

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl04kCsACgkQJNaLcl1U
h9BEbAf+JK2+H8PSGzC4bVmJ8LFEQ+zp2EcRBWA//q3y/ti3pC+NkcS1a7K2/mKM
kdYghM/4QOLrReojPWhUfr/D0FKtdmDFec7QpdKdcDiVvkRGALHZmWTUSbscUF9o
o7xnU0G2JLCoL4JUUore5N1yA26wv3galt7ky1b06XRosUeMFiS2+pCKy4GPW3uA
/4qzGKOIt2XmuxXS3NEImtvum9MSMDQgCR509T3RWNWQQ7NMfP2ZIyyaQJYSd34Y
kR3wz5JJuPzuN6nDeTCFkfRWo9GNriLpnw533yJvDx7FPzY98NyGxFWBHajbTQtN
W1xoXAs9yuVgRkwsu3Q9Z8qeWTVasA==
=mZmN
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
