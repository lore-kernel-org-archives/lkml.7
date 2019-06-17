Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9DBC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A532920652
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560790451;
	bh=jzwy6sc+pd0RPmHAI4fwhk46ytVWeFT3FR8ECvwsaPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eTST75TeBK9ntZkBeoiv3UscCM7e9q3FSeBI81VTDwWOEkzaJuK60G+OPRmUGWrpq
	 VrXAmdpqi9yRYJgj2IJGBYQUD7QceGlh/ClraON4N/ML29ZT9CmyQLBYmPFUAAnb9h
	 EKgAtTCu21fgZvEt8zV1iRplH+vhu2lkVLLucl+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfFQQyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:54:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32824 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfFQQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jzwy6sc+pd0RPmHAI4fwhk46ytVWeFT3FR8ECvwsaPQ=; b=oKpYDBqMUYHtZxOybCyzxMGa9
        lXmE2ZPIQzEDm+fDIJTDAyVYmoWUxV2D3W/KT30SnefyxOvP0738Q/9VH3Y7uZOyaVmh9Ew5kYq6m
        xUgW6biBfyDi/29nPCsOe7YOJlHkt4nQfLMGt1aLEFyhdrKqT+HcTk68In68hkovt+/d4=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcutN-0002En-Fv; Mon, 17 Jun 2019 16:54:01 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id C6CC2440046; Mon, 17 Jun 2019 17:54:00 +0100 (BST)
Date:   Mon, 17 Jun 2019 17:54:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lee.jones@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20190617165400.GE5316@sirena.org.uk>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
 <20190617163015.GD5316@sirena.org.uk>
 <20190617163413.GA16152@Mani-XPS-13-9360>
 <a38d26d1-213c-31ef-9cc7-1d4bdda4ceab@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eT+isKliMkztK06K"
Content-Disposition: inline
In-Reply-To: <a38d26d1-213c-31ef-9cc7-1d4bdda4ceab@suse.de>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eT+isKliMkztK06K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 06:38:53PM +0200, Andreas F=E4rber wrote:
> Am 17.06.19 um 18:34 schrieb Manivannan Sadhasivam:
> > On Mon, Jun 17, 2019 at 05:30:15PM +0100, Mark Brown wrote:

> >>> @@ -0,0 +1,389 @@
> >>> +// SPDX-License-Identifier: GPL-2.0+
> >>> +/*
> >>> + * Regulator driver for ATC260x PMICs

> >> Please make the entire comment a C++ one so this looks more intentiona=
l.

> No, this is intentional and the official style requested by GregKH.

The important bit for the tools is the first line, the rest of it the
tools don't care about.

> He suggested I patch the SPDX documentation to make this clearer, but I
> did not find time for this yet (and am not the one making this rule).

The other regulator API files are all the way I suggest...

--eT+isKliMkztK06K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HxacACgkQJNaLcl1U
h9Ajxwf+Nb+pLbzQmwjNKosrH3fv70fMfbz4cH0bwwpA8IfE8kkDkD8+R5xM2XEE
IjWs97/+dLz9ZKKOW+ueil9ySOIs9xXMfYfCCKEY97KMa+v8MCpmS0GPXpVszCwW
r9LrLC8CXddWKroaUloEE+zoNvz3vCA6jbuIxV30hFa4qKELfxlq7PdVm+jnUTKy
0F9rLO6/cGJ1kxg1wSHvhYagG3aDAyD7hDv9qfrFR9OyPc487ePeBpnOWDddVc1Z
mGjV9yM7xxUXpb1kkHVn9Ug/3j7b/CHxJc0OAYnVHzQPrbJ8rtt61jCx9owFuXO9
CwcUmE7kPQ3qijmR6SEvlJcL5TVAUA==
=RJ5C
-----END PGP SIGNATURE-----

--eT+isKliMkztK06K--
