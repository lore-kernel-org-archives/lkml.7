Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AD2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D272082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554899767;
	bh=fb+yG2R+jdC4TCuIsHIn/V7zfezU71DGF6K3eGJXSDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dY9qTmTh/WXj2pZMB9HNYdZVV8r5PLodjBXLmTBdUgqa50FZdk51CWFQN3ojhev5W
	 2TTUsU+Ybzi19foEDWx4dDT1mrzH9Fp7wQ5rBTNBKRlRwureZiZalI1vi41V+lg0MO
	 aOsBJqP/PVIcX9kJ7/NDM22rQpOYna0TlbScd/8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfDJMgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:36:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfDJMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=shqX0FUkVA5AJBBT3l/3UBd75D4mP2X0Ph1sHWE0G2I=; b=uoBNpzCpMLMetxwMKrvoxd8iR
        cjMcZR9MkTux0zMaIJO8bOLZeq0CaZxoO4IIc6RVwW2vkY58I2v37Icn6rZvAY1cYFm46aIyZ6bcc
        vpBw9kb+F4HyKENLz8KE2ebj049T5Hinp4iHXfY6kqHQP8CnVkvIFVyAssPEZulsklmmM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hECSN-0000EH-Do; Wed, 10 Apr 2019 12:35:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D57011128ED2; Wed, 10 Apr 2019 13:35:58 +0100 (BST)
Date:   Wed, 10 Apr 2019 13:35:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: Re: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Message-ID: <20190410123558.GQ6106@sirena.org.uk>
References: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
 <20190410122457.GP6106@sirena.org.uk>
 <MWHPR02MB262352F3C89EB163AB1EC2B5AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RCJLo13VlymhPcEi"
Content-Disposition: inline
In-Reply-To: <MWHPR02MB262352F3C89EB163AB1EC2B5AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RCJLo13VlymhPcEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 12:30:37PM +0000, Naga Sureshkumar Relli wrote:

> > Yeah, I'm surprised that builds...

> Sorry, I tested with CONFIG_SPI_MEM enabled. It's my bad.

I also see that I'd queued an earlier version for application.  I've
lost track of whatever issues there were with that, sorry - could one of
you please post an incremental patch for them?  IIRC they were nice to
haves and the patch that was applied fixes the correctness issue.

--RCJLo13VlymhPcEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt4y4ACgkQJNaLcl1U
h9B9aQf/eBwwfJiTcPbJnYZtslASErwcNR2MEum2BXjYAreK2uE99PbrinsbpvKk
zSnf0/RmnF2tw6ljGI16pca4Lq0yUAvbMu7DF1zTsE6PuXJG4c2dTM8jry9mpLkb
B1INtDU/5NL6trRgNXFMxnzPyScNm+rogCwf2etcku4dRZqJ1BAWg9mM0yN5d5I4
8dzEv/8m0BFJYZlcQSQT5rM1RGpzSStahNpz+bGd4OwcUa8z0BbXiec+5xQKh99c
tT+LuWWkDJ2ALYtcprfExQwlzUuGTEVXXv2RhyfChYiiGTghHlXeQAtp7vAlIbsX
Dppc57o/hcsHATMIediotGJZasG/6g==
=An3P
-----END PGP SIGNATURE-----

--RCJLo13VlymhPcEi--
