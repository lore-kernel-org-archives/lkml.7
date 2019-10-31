Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E1CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDF420862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572525903;
	bh=0DNBeenyH7rB/8g2YXDHf6rJYEKF+j4UGX0CUbblXaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UTP7KwPS8gY6v1YtEu1PNxu0FG6dsCGJUQ99DA1kzi/YJrvLanPJa2mY9dUNcqxz/
	 faisIC5bdhRCzdm4XR7ri1dzcTonJLGqxX9583M87a8s87hr6igIooH/+8rA+vjbZN
	 e7iYI9q/yT1CkKRo9Rg2EOJcLUmN0/BZ89F/S8bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfJaMpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaMpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:45:02 -0400
Received: from localhost (lns-bzn-32-82-254-4-138.adsl.proxad.net [82.254.4.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAAF02067D;
        Thu, 31 Oct 2019 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572525901;
        bh=0DNBeenyH7rB/8g2YXDHf6rJYEKF+j4UGX0CUbblXaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZ2EFnFaQxMFoSOwRwqwyd2Y9KZ+YtRrSiC6EbdzRR+rfKo31dkjxb3WqL6WD2PLV
         CXi8nj0pOAqaL5Jz40Ey/pB2Q/l9RqFR3ZJ7RxF6l/Ildoo5XduUSMQXz18Y2y0tzL
         GzoBlIYLheWU7SCpbNIdcCe9B1hw0oYK3jgmmIdY=
Date:   Thu, 31 Oct 2019 13:35:43 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Allwinner H6 Mali GPU support
Message-ID: <20191031123543.lllmoat4zv5f47pd@hendrix>
References: <20191030150742.3573-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nd6i5yai3phkhdlv"
Content-Disposition: inline
In-Reply-To: <20191030150742.3573-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nd6i5yai3phkhdlv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 04:07:40PM +0100, Cl=E9ment P=E9ron wrote:
> Hi,
>
> Proper iommu patches has been merged[0].
>
> There is still work to do to make it works with panfrost
> but all modules can be probed and removed smoothly.
>
> These bindings could be used also for out-of-tree modules.

Applied both, thanks

Maxime

--nd6i5yai3phkhdlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbrVHwAKCRDj7w1vZxhR
xWqMAQClAAyrxFvMUcdFqsOw4AphcLAVcXIVqpAF1731LJ7ZBgEAn8EdQHaxfj6V
RLMcF7zHur0tsbHuhAtC/gJY0sHFFQM=
=pJeb
-----END PGP SIGNATURE-----

--nd6i5yai3phkhdlv--
