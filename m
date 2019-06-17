Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F787C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02B1208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560791048;
	bh=AkmTIN/DLIUcKa3kYwVmaR2+lhaypazibptzLpfeWro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q5kM8n4q8asiHbA6Y1Q79k0AALpwoJH8+pMSdYzDCPb2HQz35+zj2/8ZUY3VZyZRy
	 quuSBJuj8lrjl34VOfTflcqtRyO/6KqQZC9QxAyi6O1PEd9i8crpV6vyM6ODvKTf9+
	 UPG/IxGcUSl+2mdQAyS5b6463bZuxHl4cIdr/DS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfFQREG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:04:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49514 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfFQREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jR5dpcF83bwydBklv+m2ztgjHtSD92AnS277cN/OJ8k=; b=ZZMkQIELmZek1gEukxSTLe6vi
        3klbJCg+7NbmMS/oL8SZDLB4qgcJelmC9WDLxjVks3+b7+9YHhKBH6hUPdIpqXFjejn3dMUxQ1dk5
        U34uhtRAk7S8g0S5hs3VUMyj1tT3f9RWurJN2oQDJHK5QpXyII2WtChyxh0m51R5SeMOI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcv2z-0002Gj-Ik; Mon, 17 Jun 2019 17:03:57 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 16246440046; Mon, 17 Jun 2019 18:03:57 +0100 (BST)
Date:   Mon, 17 Jun 2019 18:03:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20190617170356.GG5316@sirena.org.uk>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
 <20190617163015.GD5316@sirena.org.uk>
 <20190617163413.GA16152@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UkJByDtiyhV6M6Gk"
Content-Disposition: inline
In-Reply-To: <20190617163413.GA16152@Mani-XPS-13-9360>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UkJByDtiyhV6M6Gk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 10:04:13PM +0530, Manivannan Sadhasivam wrote:

> > > + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> > You definitely didn't assign copyright to your employer?

> Yeah, that was intentional. This work is not part of Linaro working hours and
> falls into my spare time works where I'm trying to complete the upstream support
> for Actions Semi Owl series SoCs and target boards which I'm co-maintaining
> (sort of)...

OK...  seems very weird to use your work address for developing on
products closely associated with your employer in non-work time.

--UkJByDtiyhV6M6Gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Hx/wACgkQJNaLcl1U
h9Ar3wgAgwgO1eMVsiWTWQDJeNUIJUkzt9yULEaqEKmpeNPTtx0sXnIz5fLhNuft
A/TGlL5gxm2wsCSpZVSvfUk+kAD+TZ3Xwq55LW2QmoDkXNkFNQiXRzPAsrYyPO32
n4PrIQCh2SY4gQlqa0n3qpDofBd99ZpENcYFzzsGvGAJHQ6msoeF4A72zIxcIit+
f+zsTOIW0qLMNNHIY3Kw06uMJzNbZOCTzQWPhEufaldZSt3z1DcNxRUDHg+1ea8G
NttZZghhlpCwkVTVne+0DKnr8XTlGJ4bWni7XnQjHyapZAM/9GmXasfCqOrpwP5r
bkeK7xHfGJGzqZuFad4R237TUbypig==
=U153
-----END PGP SIGNATURE-----

--UkJByDtiyhV6M6Gk--
