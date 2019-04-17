Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4E4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AFD217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555511938;
	bh=li3TiGdcDEzOUBecAVdSW9wri5Gh01tHC9BkG4IpuAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQLYt92dU/CmpIC6UJJ+ZuK/2L00ibyDZqqVDVBQeByL6FqcGHdWLKBUev/1PXUEQ
	 baNVgkAIDbxSHJCo5QigDO9i9bca1Z8Exgk41MFXYVYxa8pGMCV0WjYsN41aVUlqTz
	 ISRcZEyu3cFweI548KHpAWS9Gihjtj181M/se4fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbfDQOi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:38:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4F9/JL9M2LVluN54Y8cO53OWfOU868csA+1WZmqHrX0=; b=t66O9imSnbi6XFUYLoQA4DFot
        I/DaC2RDrPkbOQ35OZ/OM5RzpJjbLZK3f0dvT/UPH2caiktRnIBQ45AU83MCZhyJOYn/z0FicQpGc
        yTCysMLR51QZduQgnVLWSmLoCeirbFVDH+b1pT0ULCeeJBxvjEKCD1kiMNBdDbwBe2cgg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGli3-0000Cw-QS; Wed, 17 Apr 2019 14:38:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8E9761126DA5; Wed, 17 Apr 2019 15:38:46 +0100 (BST)
Date:   Wed, 17 Apr 2019 15:38:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com
Subject: Re: [PATCH] dt-bindings: spi: spi-mt65xx: add support for MT8516
Message-ID: <20190417143846.GA5703@sirena.org.uk>
References: <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
X-Cookie: Boy!  Eucalyptus!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 04:47:16PM +0800, Leilk Liu wrote:
> Add binding documentation of spi-mt65xx for MT8516 SOC.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3OnMACgkQJNaLcl1U
h9CDkgf7Bx0bnRJJVFtQpite9Bwk7qhLVPQLE2niAQnuTpnQfiPcVJNEYN1NZY77
JJgxEgnbj2h9umXbA3LRx3dGJ7CzkEoJ+3UGI5nL8LA12cMpzT5xCfa+7wMgxnzh
x06IziNXB7fkG7TWnk98S45A5ULUAHXOo24znTbZz+5SxfGw5H2E6lGKOaMBJhd9
oMMqefjcLLQK+AGEk97o8crtziPHYHukAg5twenB9qQdOlSqHuywFQ7G+gStSRmO
tSDUWRInPf6sJfRmoNw13qzP/ESvbq5onFc+dsoLfRDfqyhy/DMV7DAYAh4UJj9D
3i/gX2LDoJmrRbIHACBjllcgOPV9wQ==
=JoPM
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
