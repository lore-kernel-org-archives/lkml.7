Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED184C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F68206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556218360;
	bh=EFDOgMKX/dpYthNyw2Gjg96XQ6SZ6j06nhd6LCDzrK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nFMzVVArtcV0CW0E/9oi/iS1dPMepqsiwBHfhgQ5VwKs4/iiMg9FsZ0/dGmdYwXI/
	 Lu9Zxz5sK5vsbjHHxfmuPCt0x+PmG0Nf9PTcqV80bvUOlx5AaizWAg7sa3y825l185
	 ah4KQRUeQcc/Ngd8/EZqeEmOT6BAo70Mj0LoEtng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfDYSwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:52:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51500 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDYSwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NyLs7J7dnpCjhrc3jQIiIYSC3g79pshX13Pl5CKIFVU=; b=wKMBz+KrKbj6/2KqYF0biBhnG
        gDyLbrJmRQv8yfhwZHoZGeqLOipOtNsRkC2//OGIBHh6PPJ2TWvpGeXB8+h5/DoU1+HVLsNAPjiNo
        9vwAjXvB8VhoUa8TH3YUqrWxomJ1fwV8kLW1tDoML8BCgP7oO8ZaxSBEuN/45PalYKr9Y=;
Received: from 188.29.165.56.threembb.co.uk ([188.29.165.56] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjTy-0004NO-2a; Thu, 25 Apr 2019 18:52:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6D683441D3B; Thu, 25 Apr 2019 19:52:25 +0100 (BST)
Date:   Thu, 25 Apr 2019 19:52:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] drivers: base: regmap: add proper SPDX identifiers on
 files that did not have them.
Message-ID: <20190425185225.GI23183@sirena.org.uk>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
 <20190425180618.GB8998@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZY5CS28jBCfb727c"
Content-Disposition: inline
In-Reply-To: <20190425180618.GB8998@kroah.com>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZY5CS28jBCfb727c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2019 at 08:06:18PM +0200, Greg Kroah-Hartman wrote:
> There were a few files in the regmap code that did not have SPDX
> identifiers on them, so fix that up.  At the same time, remove the "free
> form" text that specified the license of the file, as that is impossible
> for any tool to properly parse.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--ZY5CS28jBCfb727c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzCAegACgkQJNaLcl1U
h9C1zQf/YmuIPvS8/lDk7cqjNlkdA4qupI4ZhgNgo7uDFZZtJ77/vZqqngELn9MN
tYTwdiszx7sYpcX6VOHB7mMJjCg7YX47U7qkx/zp1cg7Dw59+ZZXcpXIu1AN3RJZ
LDsT6Zwdo6jJgj/YTg315ZnNmSwiseYyZrgNDvWZMS0ktw6quB5VUKzdri1IV22M
Cjzk6/vYtPQt0RgqKycj23HpfoJLfpQ4UGVVDRJ9DWKqKE+22HxaEWABbSJ252kI
0wF2FGf/EOYu/0/Ww9AzL3D0Xc5e4qs8c1NseugrxeDkYuVNYMNAAzg3b6qv0Hgk
xQ3kn63v4SPG3Qk/W+sopjPBOYL1FA==
=Uxqk
-----END PGP SIGNATURE-----

--ZY5CS28jBCfb727c--
