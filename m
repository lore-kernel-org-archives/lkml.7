Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03395C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE09820578
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567702852;
	bh=5sGaDo2Se80huorPhl7a0jrvqd8rgrTdusG+eyO1xYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DrIVHNMjAmhFIPrAIYxogr37aoUQEjcBvEDP3joa3VirASOE+J53oIISt/+wNctbq
	 7HQ78G4BlY7myZNPoy4jm615YXEVgv79x9Q/mZE+6UTtlhzL22gqskpXT52AENnMgI
	 p1+atvvM1PBLF3XIbAV6jiYLb1wKE8DG6LjTHIWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390886AbfIERAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:00:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49786 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733299AbfIERAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RMR7yLB7eLVOGQ40Lw2gegmrpDn0f2yyxFNY+57x51Y=; b=OhQEtYy5rpuuDT9cChMUICtrE
        V0tW7BD+A9HX+F/z9hBZQftsPGgvm/R5izgSEJ5VVldr9cr5p9E+7tESNq+lMRmSejsru2MBm8ut0
        yXuPoNi1M9cL7+OeNlgKQa3w/+b5U2esN4wwxhLSiHfRzBf23qdvo7ilXoRjkGdoCuptI=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5v79-00055J-N9; Thu, 05 Sep 2019 17:00:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3D7032742D07; Thu,  5 Sep 2019 18:00:06 +0100 (BST)
Date:   Thu, 5 Sep 2019 18:00:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "shifu0704@thundersoft.com" <shifu0704@thundersoft.com>
Cc:     lgirdwood <lgirdwood@gmail.com>, perex <perex@perex.cz>,
        tiwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        Dan?Murphy <dmurphy@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: Re: [PATCH]Add tas2770 driver code
Message-ID: <20190905170006.GF4053@sirena.co.uk>
References: <201909051335040840918@thundersoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <201909051335040840918@thundersoft.com>
X-Cookie: You humans are all alike.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 01:35:04PM +0800, shifu0704@thundersoft.com wrote:
> From 5b539e7dbebebf7e58c38a6b54f222bc116d63f3 Mon Sep 17 00:00:00 2001
> From: Shi Fu <shifu0704@thundersoft.com>
> Date: Mon, 1 Jul 2019 11:00:13 +0800
> Signed-off-by: Shi Fu <shifu0704@thundersoft.com>
> Subject: [PATCH v5] dt: tas2770: Add tas2770 smart PA dt bindings.
>=20
> Add tas2770 smart PA dt bindings.
> ---

This looks like it's a whole patch series sent as a single mail, and
there's some confusing with things like Signed-off-by and general
formatting.  Please see submitting-patches.rst in the kernel source for
how to send patches, it's worth taking a look at other posts on the list
and trying to ensure that your mails look the same as them.  As things
stand it's really hard to read this since whatever happened with the way
this has been sent seems to have mangled the indention so it doesn't
look like normal kernel code unfortunately.

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1xPxUACgkQJNaLcl1U
h9Auqwf9FZZMYjmrZdhmxYDfmduqhmJnimUlRbiugyYCzlakQ7QRyMF9tIfOOgtt
RENe5mq1GM1/FQHJyCvbc8Ws4+98/6YIVqKuMoV4FtvOP9Tyfr2t33FgWWtfsy6u
jbOYYpI8i4pTO9xaKSrovleO0se/6l8idMr71swiwLuzmByhS63/jBeiQNf1oTi+
iC617tpwGRmTdPOppZXBvcBby+SOS6I9DkmhdHDhtjLQUHw/rE3umFxsL0hGwCDJ
ePJIjWF7pQWvflzNTbD+lE/JdzqU0u9emaO4Lq9qC/uAJ3QXxRzlFnqJjnG2dC+T
TBowIwKHWmZ5r26JpGhbWkVS2ZUicw==
=K8ao
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
