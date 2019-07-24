Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1182CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85F02190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfGXRrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:47:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfGXRrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:47:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id DBB9D283CC1
Date:   Wed, 24 Jul 2019 10:47:13 -0700
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH] drm/panfrost: Export all GPU feature registers
Message-ID: <20190724174713.GA2836@kevin>
References: <20190724105626.53552-1-steven.price@arm.com>
 <CAL_JsqLkxKe=feVQDb3VXqOnA7fvDBEKWgLf2suOHhNLnR704Q@mail.gmail.com>
 <20190724164004.GA8255@kevin>
 <CAL_Jsq+cLg5R=SJ0zjfVqYB_So-gHT3qb16wcOCbrHuufSZgLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+cLg5R=SJ0zjfVqYB_So-gHT3qb16wcOCbrHuufSZgLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I think this ship already sailed when we added the first one with
> GPU_ID. Also, at least etnaviv works the same way.

Fair enough then!

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl04mZsACgkQ/v5QWgr1
WA1KhQ//QyUZMhFEVJsHJiDBp+zDqDq6xeA2ytimiiwjyqWLpimmGP4nLPvOabGz
irjA3hjB97h4L4d4cvDCjgmLuh3joXWaUXWT0SLs5HrG0S+1wZojoGKk0TTPBzK4
R0m4d28yNhahZp+7yJyy/x44UDy0cUNe9jLo1cEgc4O9UrwjHEJW6lAZrMsPmKrb
7dWKre3jaNZBnX4nKxnhVHURT/FhoKyzjQAcFeG1M06uj+i5FzTPKYHmCn3CzKpl
sf0PWXAAjtaTxGTaS1NzfQjTEbMyNtJVAetMzWn20VNFtnwW1TxDc3ZN6V29jkoP
bHf5fprR5A6PTyvAhKL9MXgygrSVhvb0A9BbLfcuPe9FGBmSAetMLw5GbVUQ3gMZ
3K4cSYvCfG8toAQlFRlLLPooZ7VG3rLUh6wPXgmRgiCR3zUH0Pz68NdZlu+L0u9b
M3cwVs+MCh543et0MFKU+B/2HL9mRuowOefUZvsEc/dQudzMsAE+NK7PJl/N6gkG
Ah/sfkw0+kKi+EzMibSUPeWlYEbcMCxEwCawE9PsCj8Zw7pMn5msMhu76HPxk09m
Mr3llwYbG4X26eXfFFlwodyfyL/z0MRghQQuJWwfmzo2445E6j+LDjLoqtys4n9K
jmfTbpNFPwHrfU/QRd717sv+A2k79syZ/lcuu9f+5LQ4EDztLV8=
=5PdD
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
