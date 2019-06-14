Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C421AC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9330D20851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qvDhRojV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfFNJJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:09:33 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1261 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNJJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:09:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03644b0000>; Fri, 14 Jun 2019 02:09:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 02:09:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 02:09:30 -0700
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun 2019 09:09:29
 +0000
Date:   Fri, 14 Jun 2019 11:09:27 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Nathan Huckleberry <nhuck@google.com>
CC:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
Subject: Re: Cleanup of -Wunused-const-variable in
 drivers/usb/host/xhci-tegra.c
Message-ID: <20190614090926.GB14954@ulmo>
References: <CAJkfWY4nKwyPDh=MuCURst2SZceceeR2v3qrT9UY=VbvLnEmFg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJkfWY4nKwyPDh=MuCURst2SZceceeR2v3qrT9UY=VbvLnEmFg@mail.gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560503371; bh=NPpw3g7qJwORXH5hMJclNUm2tbMB0d7doKYfsHOg8pE=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=qvDhRojV/C+y2ywvNC6e4ah8nVRW1G8qKbom1K4ep04P/sp6bWcwwpwhY7knEGWJP
         wDe555zTeqjuzfxYkQhVHy0oZJgDcS2mWHF4veDa1Xy7vWEFN/o0DwOL8wd8Q8LfSA
         /5hqz3spsa0Bfmz5iUeo2HzCn/0sSNVxDM9p4ojZlkhsiKU3m7Kkl2F6Xmhvp3BQZx
         UbD0OCUk8Ka6NZm87Xig198n8ljAb+bXrXpvnEJAzh2x/369RNfXVxrofQdh/6Mk+b
         0bcUCE9Ke42pAphU1IuneJ7zqVjZA1kOYU0ovPKj1tH2/ICqr1s/XDJ7URDVVFFWPR
         AfuhMjPGnRIOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 11:38:38AM -0700, Nathan Huckleberry wrote:
> Hey all,
>=20
> I'm looking into cleaning up ignored warnings in the kernel so we can
> remove compiler flags to ignore warnings.
>=20
> There's an unused variable ('mbox_cmd_name') in xhci-tegra.c. Looks
> like it was intended for logging or debugging, but never used. Just
> wanted to reach out to ask the best steps for cleaning this up.
>=20
> If the variable is no longer needed I'd like to send a patch to remove it.
>=20
> https://github.com/ClangBuiltLinux/linux/issues/533

Feel free to send that patch. If we ever need this debug information
again we can easily add it back by reverting.

Thierry

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0DZEYACgkQ3SOs138+
s6F0tw//W5cSvT/bzIDSSWLG2gWjBGan521TaQV9D62U4c5bYKIDMGBGyXKIQkPC
yL81T65cFTzuAD/+4isvxTihI42lYK5CbI1JyjKdE2SGjrMOQQkrm7+O02FGye4w
TDje5ir0HRUx2KtjfuDbjvRKlUY3Q/gp8255k4KPSY3ZozepzO1FrjaaXMew6bn1
xcWtVh8LVqcsGbP0Ifp0bMrHx7mKHajEnhtPtevnH1/11ELJE86l/iOOekjL151m
feA9Vs5v4NB84NRFE3HVx9c5N8DBdmuLfDHgrECIbP/xvbgGrqKQi+6a0cZOMZcB
LJ9oTATYH/FpbmFOg7MCrfjkU4eKP6xVUjL+Y3qD7iha7IWuWxGuK+QtrWhq3Bxq
qiE4r5eFdRVAu44dl0GoNIuNzlHqiuOvZ52DyTzHuBqEkyLYQYm4NqHsFgjHMwnd
cz2oALUYAcrhFv8qfSVeqDIg23PK7ulrAt2hBUaDDDD8hYOc2WIdVw3xg7wCa9qb
ZW07rRakhLV1xsoIhcbKhKzSpVNymchyI5HvrRQyY5nVdx99N4dyHO6rDrMHWAQE
VUautrjtchnOkHpIPQi+rkcZjCqtGK1GNfpljSP42WSZCYeOZJMoFbkdfU5AVRVu
wSxU5NEnY4uo4Xm31cvUXd+DU14SuF+kicc02+fU9GuKnVfc/Is=
=BAJT
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
