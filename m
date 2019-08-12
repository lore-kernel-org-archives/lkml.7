Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10429C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38B1208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565608310;
	bh=iqxafIsi/tx0vmd0+8KNWtaAimqsMxnM/eIaX9FMhQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I2xI/RElGdvaDZwQ/Yt7Mj8aF+Zic3EtX9kpkhf8RhMmOeLoVyJInsEFoU7P+IHO5
	 clLhApx3n5cmDX+6cyngUXX/OkY0YbmADn9DGNMtpqHYU7svBSu2/80Ioq4wHzuqu0
	 SUPJbBN/YKFpyYgcz7pRoAQb1+d7QHoZakSSwxnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfHLLLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:11:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38512 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfHLLLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VOU+A7N6Ee0Dhs3ArVSbBOqkU2CM/MzFu4Eo8Vtc5Hw=; b=ffEBe40YCHxGSxDqNpEbhChwl
        zv4FStkFDOSl/qWyUyZ6fOe2c3rXVzDsbZ3T5DHT5qNx0EodSX1IQLIiG8DDtxo5RgJEHM2YiG68Q
        E4qxh0O3IyC9Jz+J2iJCHMfyj5dvH8+0JHCDO2+NuMLvuuqqlfFhBOY8jRVu0utabE2aQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hx8Em-00013U-V9; Mon, 12 Aug 2019 11:11:41 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7511D27430B7; Mon, 12 Aug 2019 12:11:40 +0100 (BST)
Date:   Mon, 12 Aug 2019 12:11:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: regulator: act8865 regulator modes and
 suspend states
Message-ID: <20190812111140.GG4592@sirena.co.uk>
References: <1565423335-3213-1-git-send-email-raagjadav@gmail.com>
 <1565423335-3213-3-git-send-email-raagjadav@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <1565423335-3213-3-git-send-email-raagjadav@gmail.com>
X-Cookie: Decaffeinated coffee?  Just Say No.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 10, 2019 at 01:18:55PM +0530, Raag Jadav wrote:

> + * ACT8865 regulators as follows:
> + * ACT8865_REGULATOR_MODE_FIXED:	It is specific to DCDC regulators and it
> + *					specifies the usage of fixed-frequency
> + *					PWM.

Ah, _FIXED doesn't mean what it sounded like - this should map to _FAST.
The reason you use forced PWM is to avoid any delay in the hardware
figuring out that it needs to go into PWM mode in the case of rapid load
changes.

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RSWsACgkQJNaLcl1U
h9BgOwf+L+0uD2AkY2mKb2rgbO4kz8XM2/qXa/Guj883xw8zawXENnnGXMu1g+i3
0gO9qV1QdTKin8sA2YFzlSqIreIjIh5EBwxcTDBizvq7+QO40zJVxLi4kvMNEQcN
O144ApoOUPDU4HhhaZM9fW9+kx13IAgn4cficrqDdnoL2pZ8sNWsQP28vjprfgWH
45DxGYJqrrhnXW3unBkGBT/z6Cu5DhCo9NYnNY6+G2eQqNtD+UacEu2K+HQuVuUj
g/0Tg8h9ZhsIX+z1eo2Idorf7jkvd4QctqaA4DJHIKezvyD+7STfmAIwyobXC0Nh
fDr0HHOLg3E7HBBIXu8mX4GEVDJkZw==
=mPsh
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
