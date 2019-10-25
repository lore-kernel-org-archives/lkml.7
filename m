Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB54CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F12521929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572005114;
	bh=i5B+/CdlbPYsH67nZ5snstzgFbTG/e2uMC274sAyyo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fCaZUiOXAI0PzKCXT1nnh0ZQ8myV6gVMdf+u+qXC7kWzkPlkkd68XH1L8WjnmduOy
	 WQWnJLn6XIe7sLQwZmWupsyQltNX1CXq4w8aBBRvGsLoSbcY4rcac+odHz9znx3luP
	 5fAwvYIwo26lwlGTF+pU8QmfxpwxXnsNlduWMLaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504217AbfJYMFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:05:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58030 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503944AbfJYMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i5B+/CdlbPYsH67nZ5snstzgFbTG/e2uMC274sAyyo0=; b=F3ayR/iJtJE/lEau5XNit0z6H
        0Axbxga/+IRWImrDLWnepdBxzubKVQdyRFUza33GAx91GDBp7niT0n4m//GpsLC0PSRuHdLL6ewmt
        2ElDeqGkiITeORP8Rn8tGLFYtEXNYKBoRBNK5nG5SbgxrXwpaDkCem0ElGYc5vvR6xiR8=;
Received: from 188.30.141.58.threembb.co.uk ([188.30.141.58] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iNyL5-0006s8-LV; Fri, 25 Oct 2019 12:05:07 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 310D7D020A1; Fri, 25 Oct 2019 13:05:06 +0100 (BST)
Date:   Fri, 25 Oct 2019 13:05:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andrey Zhizhikin <andrey.z@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lgirdwood@gmail.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
Message-ID: <20191025120506.GB4568@sirena.org.uk>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
 <CAHtQpK5ZSOMKY4U0y-HHHH6QiuYRWHr90SAzjaACpAGgTzALLQ@mail.gmail.com>
 <0136a15a-7af4-dabc-a857-fcd80d5576a9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <0136a15a-7af4-dabc-a857-fcd80d5576a9@redhat.com>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2019 at 12:45:30PM +0200, Hans de Goede wrote:

> Hmm, I do just realize that the regulator subsystem turns off regulators
> which are not in use from its pov, which would be kinda bad here.

It will only do this for regulators which have constraints which
enable the kernel to change the power state of the regulator, the
regulator core will never make any change to hardware that was
not explicitly permitted by constraints so should be perfectly
safe unless constraints are provided in which case it's up to
whoever provides the constraints to make sure they are safe.

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2y5PEACgkQJNaLcl1U
h9ByJAf/SDQpPyZZmud2fieRG+6CVAJr/SJsv5R2Iaos/djWHWV0yNdxhgUZU0zd
+X/ENZPTP2e0CLK9yVHRXKHphT/yddBf11+QAbRDPI4kU3HOkmZyNQxSdlt9I8PC
9UQwLH73LhNIHxfHhX5sceG7jkIGLpWxZEGbFQBoj4fZn+cByKjQPHbzlAnxfnhz
tuUJ9hxUFY4mE/YUl4J3kfOYiVPygVbsl53xLgZwLh8INLMdM6JeV+hVu992H2ba
NYvXlGFr/peFZmAi9Q2km9BNCLr8Yku1UyTr0SjIsVRcYzerpKSlbpD7j8hwEKs/
soRtWX0rOczDdeam4cVqC+o//EP7uw==
=ErDW
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
