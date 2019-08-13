Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A08CC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF94F206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565695320;
	bh=mr7MTTp2S1783D3IUPJoGwtr5P40BgpMglJUrsbxxbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CUjSwRHotWvvkJEb6DDCy58F0ly16NUKQZsQKnwr7OT3a+FSNK7VfJZ4UZmGXWNCt
	 /2ycmyhDUZZ9/00UaO1LH2RN+TM+mYvEFAT/kfloxPx0fciS5pn4/Nte4eHQSlLFNr
	 IuaclXZR9soob07XKOYNQ0gftFQ0b/+f1q+MLV5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfHMLV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 07:21:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfHMLV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S+haXQ31VwOR8EScuk4xDAXQAIpZXE7S84bl3ZEQmCQ=; b=NTsX4G4wMZAiM1T6uwsNNHYh/
        7uxBSIEamuTn69Q/hCmek2SL7IvsauP/Oj/O1Q3zDAEVxVD4OzyQEkTMiHI+932ww8kb/beAo3DzN
        3q6FnV55oTm4AOn+ux7mByv/tFAzlnCc1TrqdTX0H3spfnFJJkTk83fIVJR/drvNwIoBc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxUsH-0007l0-HC; Tue, 13 Aug 2019 11:21:57 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AF8EC2742B44; Tue, 13 Aug 2019 12:21:56 +0100 (BST)
Date:   Tue, 13 Aug 2019 12:21:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: core: Add of_node_put() before return
Message-ID: <20190813112156.GB5093@sirena.co.uk>
References: <20190808070553.13097-1-nishkadg.linux@gmail.com>
 <20190808122740.GB3795@sirena.co.uk>
 <106177ee-d6e0-5825-83f0-ca199b05ac20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <106177ee-d6e0-5825-83f0-ca199b05ac20@gmail.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2019 at 09:57:47AM +0530, Nishka Dasgupta wrote:
> On 08/08/19 5:57 PM, Mark Brown wrote:

> > Please do not submit new versions of already applied patches, please
> > submit incremental updates to the existing code.  Modifying existing
> > commits creates problems for other users building on top of those
> > commits so it's best practice to only change pubished git commits if
> > absolutely essential.

> I am very sorry about this; I wasn't sure whether this particular commit had
> been applied. Should I split the commit and resend only the change to the
> old commit, or should I leave it as it is?

If there's any changes you think are a good idea please send a new patch
for them.

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1SnVMACgkQJNaLcl1U
h9Cimgf9Eex8ZpWx60ww9ZeOCtXNnH6VRaLEs5gLgCE1r+7wdh7sK0qRBDyRUlBY
za6XFJSxW086pma5Td2h2e73KHa3hYZ1QlsYcwCkCU10ZQYJxCQdThuOpmxnGSlX
J3aQDmggq1XGB4XJvkrOQZrdiU9+ioSCNvQuvBVph+ETk0c6xxI0ZEk1aDdM9Qk7
mPpHuCLFY7nk29JKvIAgHRwzkTGgGLCPLUET8qnPZTX7lRMvS3/RFYrCQ3g9nk9Q
D9ojCmTF0DMkEqVznlpIQHRE8kfSe1E+fIxxe6+ed0rZamOBqMU834QBp6CkU2N9
SZ6p40Y7cPOXrDYEt2eK9KZTXAxUhA==
=LpVL
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
