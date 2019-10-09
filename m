Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469AF21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570639687;
	bh=hxBrrA5JSAN3J/lKtA6byN6mDCwGxoFHVE3tLVJhHXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bWzt8suFH5KMOsYN1CU1kbc8vTXalQ4jiNIIAOIc5f1T6Z8i/L/6gNPV7N5QmIXOv
	 cSrOQXJnfSORfQAnNyrU0XOErehMPnsNs+O0fhl9/6bhK0LySFyhZjcSRLb0EbTsJp
	 Ln3fEFp2Gib7rCMzEWncfEMNkton1Uqa8FAlJP4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbfJIQsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:48:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43354 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xihV+hrKUrXRaEoaNU4czLsTlMBrjpQZweZmyEQED50=; b=Av22dA3b5NvucR3HZAk9EzKOi
        k/NA4vCv+QREnefKBAKjB763aPttgXgHHGoioH0LzDfsjA0DktvHrb46x47Nlj/+TnlOByc1m0W7l
        jAQgM2dyEISNs/i5Qt1M/XOB+WuH7ymzY0wMW6m+OnC/bdbkAG61tJITALhPOyqE/+7uY=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIF84-0005G5-IY; Wed, 09 Oct 2019 16:48:01 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A3798D03ED3; Wed,  9 Oct 2019 17:47:36 +0100 (BST)
Date:   Wed, 9 Oct 2019 17:47:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        vkoul@kernel.org, bgoswami@codeaurora.org,
        Gopikrishnaiah Anandan <agopik@codeaurora.org>
Subject: Re: [RFC PATCH] ASoC: soc-dapm: Skip suspending widgets with ignore
 flag
Message-ID: <20191009164736.GL2036@sirena.org.uk>
References: <20191009104603.15412-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K+L15n4vPMSPOAOM"
Content-Disposition: inline
In-Reply-To: <20191009104603.15412-1-srinivas.kandagatla@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K+L15n4vPMSPOAOM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 11:46:03AM +0100, Srinivas Kandagatla wrote:
> From: Sudheer Papothi <spapothi@codeaurora.org>
>=20
> For wigdets which have set the suspend ignore flag asoc framework
> shouldn't mark them as dirty when ASoC suspend function is called.
> This change adds check to skip suspending the widgets with the flag set.

Why?  The goal here is to ensure we revalidate everything on
resume, and flow any changes out.  It doesn't actually result in
changes in state on these widgets if they're still powered on.

--K+L15n4vPMSPOAOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2eDycACgkQJNaLcl1U
h9BGCAf/dK+uOS4ghYlBx/LFBAJdeo4N5IE1HlHjItdYYchRCM70mbOJqOX3jqT2
411PjY4AgP6/+gUhimf+qm/9V4qoZNOpGrQ7j7tJ8aAm/5qG42CyRzpTyD860XvE
2j9hyVMeTq+thrjDudEnzFsLUqfFTW/SuGE8E66paMqHZFbKrcQ78zOyWeJlcnFd
r9OTrnxF9IDRdagu9qEjna3jeFi7dx2sHa3JNDTt17w3IPcSJ4kKwaRUHlJUaSzr
sz3AlU0SRq//PxZMLMZzO7iCwaJu4saVj6f0vJdMQreG4XzcYx16ihZs3jS6jz6x
OX+6IJiZcojBdTPwf4oLYv7svieS6A==
=DpsL
-----END PGP SIGNATURE-----

--K+L15n4vPMSPOAOM--
