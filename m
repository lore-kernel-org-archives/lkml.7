Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985ABC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C03206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556213300;
	bh=KZ7Vq6MJGUGJOP1LIm6nuki37oyzKRSI0kCmH6EGc0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nd7iSCGRaSz6yccQSan/jZ43s2lTJqvRZy9vU/G+LsExnDoa0pGfXwCrHx34TX98T
	 QQT9D9LDS5dclKFIwffYF8KwdMM9q7kNcWfB0/WyloAHyTGG3/+RZXvw8lS4FDWbMF
	 vO9LlMJNajd9IapjiL7l+ukN45DS9Uqyj6IPzHEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfDYR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:28:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYR2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5//Ed24q2hhc/wnJ0HqSkEXHaaPI5WZwKLImFJ+SszA=; b=hw5c6cgM7IQvpLzxQKvQxpJmg
        qKJ/oHRdNI2raWMl2FV8Wfxrtv8QJvWpxGgrPbdUKq6pTeXQPmZ5OCGcKt3wgyIM90ZW4neVq+W5k
        uXccj7+gR75Euy6p1ev16fpNEistmj2Zq0SfIOgblObzgX6NYrKXkb/8ni4oPkqIGGVRU=;
Received: from 92.40.248.65.threembb.co.uk ([92.40.248.65] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJiAM-0003Ik-1b; Thu, 25 Apr 2019 17:28:10 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6A009441D3B; Thu, 25 Apr 2019 18:28:07 +0100 (BST)
Date:   Thu, 25 Apr 2019 18:28:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        enric.balletbo@collabora.com, guillaume.tucker@collabora.com,
        khilman@baylibre.com, matthew.hart@linaro.org,
        mgalka@collabora.com, tomeu.vizoso@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
Message-ID: <20190425172807.GW2803@sirena.org.uk>
References: <5cbe596c.1c69fb81.e252.b9d0@mx.google.com>
 <155598159898.15276.8408514960097680895@swboyd.mtv.corp.google.com>
 <20190423144028.GA8007@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Wg5Vd7si6EhrIHA"
Content-Disposition: inline
In-Reply-To: <20190423144028.GA8007@atomide.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Wg5Vd7si6EhrIHA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2019 at 07:40:28AM -0700, Tony Lindgren wrote:

> Hmm do you guys have some index page of all the found "boot bisection"
> issues that I can check every morning while drinking coffee? :)

Sadly there's no web UI for this bit of the system.  The nearest would
be trying to find the reports on LKML but that is suboptimal.

--1Wg5Vd7si6EhrIHA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzB7iIACgkQJNaLcl1U
h9C1+gf/VJq4cVVkiHFm1QdHncra/jZ6tWfiwlCAvaNC5dE3vVZ299Jq+KylALPe
TOHnuPFUo+ROtYAoAwpJra5ZbjGUE+u/bLQLpfliufFPbbPH66CvMphfPWt8Wyv5
wNlh7WvvJxzObEfF5tNiJ+SU69Xz/e2aKCPQxdf9ooT1gg/N215664aeL3pXTuQJ
/MGBvGIYPVhWKnFKRtrBpI+oITsa2o5tLrPHavmP16BJ3cEM+EupyJ6iryg1XGSN
VptSXI5qx8156K0291FSN3xVfgqrwmjwZcbNuj9wubjEjwEz9pvZQsILELuJE5au
un8KAxntqk7mAAsyIK5e2TXbNSHoiw==
=JxN+
-----END PGP SIGNATURE-----

--1Wg5Vd7si6EhrIHA--
