Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D06C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F02C21873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563988096;
	bh=8f7/HBEwR5RTd1dKxNzj0UuMzaT74znFN1gikiy9ykY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g43thL/bVutNCjbL+1O+nRbRrzN8L1hCAwSbL0Cyav9kcaAFF0+MXUkHHBK2k9TWU
	 CmqN8j72tJHr9IiRuKWW1eqY9XetgX5owKQt2VOMHF5v1pk3phyo7vyHJjTaDng4wD
	 CsEjTTgomwGjBtEQwTNzFfKB/gVsfi8n534liIMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfGXRIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:08:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfGXRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8f7/HBEwR5RTd1dKxNzj0UuMzaT74znFN1gikiy9ykY=; b=IBbJSbdZ8fYDuP+1Wu/0ibWwx
        ILaBo6qNY34I7/HYYStQU5Xq+fXnmewGNLk/oQPvUcwucO9HksKNquFkTl2Z5v4pUAASWxHHQTs2t
        pG21Bq6MY+Iz/7Z5+ukz+ZbsJ0ZkJwMwDlrpmh33U7d1oMf1kXTV3gr0Wrq5OWfGULqvU=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqKkG-0008Fg-Bt; Wed, 24 Jul 2019 17:08:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 97FF02742B5D; Wed, 24 Jul 2019 18:08:03 +0100 (BST)
Date:   Wed, 24 Jul 2019 18:08:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190724170803.GE4524@sirena.org.uk>
References: <20190723181624.203864-1-swboyd@chromium.org>
 <20190723181624.203864-3-swboyd@chromium.org>
 <CAL_JsqKMmQdvQmybXbGf_CZkvd1TTeMBPyk3uEUOK9Vz1+9PNg@mail.gmail.com>
 <5d378936.1c69fb81.2ee3b.0089@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <5d378936.1c69fb81.2ee3b.0089@mx.google.com>
X-Cookie: Matrimony is the root of all evil.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 03:24:53PM -0700, Stephen Boyd wrote:
> Quoting Rob Herring (2019-07-23 12:30:48)

> > There's also some cases that the irq seems to be optional. They use
> > dev_info, but will now have an error level print. That's fine with me,
> > but some may complain...

> Yeah I wonder if there should be a platform_get_irq_optional() API that
> more explicitly indicates this and then doesn't print a warning when the
> irq isn't there.

I think that'd be a good solution.

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl04kHIACgkQJNaLcl1U
h9BCaAf+JjPTkQHm4fv871uJPfD7pXuOx2y7FaJ5PQD6pKmRxdYuLMfFHGfbVqJo
xLcmrNGr2viH9qH+jknCarmrJc89SmEPV/lLi4vwUFAqW4zVXjZeAWYv8JqueoYv
TN6yQLHsZaAOGIId7JwzJ3PmpsMv3ECT+dN555xCf92fGbwmep1p8t7K9AN5/f0e
gSOqq60oS8/aaZQ3jQv7cudlGmMpesTfgsIlXzE+Xkb5L3WDKG4q/pUEN8Ql+7cS
8OJU2I0GPFAraCxRNq35LKjBWm+glw2mEa8ykUa+5cSH5zz4pSyo3IQ9nBmLGCZx
B9WjDCtRVYdWkM2BLfR1STE4AZlAsQ==
=LQaA
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
