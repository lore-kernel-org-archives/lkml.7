Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DBDC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716F621928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568909005;
	bh=7eBsu75hT5u93cfWoc74rVSLAhHN0VCyBJejf45QBFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vl1BRIjh24D5fyFnSnpjw/ZHo9/RC7amqwkAh85Zm+Rm/mB00qX3v8nhWqyst4nKL
	 55RmfzRPTq8YN25VHQMzBzt8nx27nVNI0cL2Cl75DMEtIXC3BpbYs7dgiS/+L2Yn78
	 Mq+oKBIAqckmVsLSGtKncwOfJfXZxFCHmf/EJRR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbfISQDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:03:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389371AbfISQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vJRSj0yJ0nGMQ7A04jXbedZdlDHcAN0hBrzP50Ruo6g=; b=enEiR9C8pobypGbm3Yy3RH5U8
        TsGirkqhrEOn7G+4Oldowb8anNJrWFpFbamtEgD5TksYWJ9AKr9t7Z8AERxiv/Z0WkZy4cjQkKbeb
        m/nxq4q6tjVQFHarK9iHDf4DSp32U593EVhKKIJf7WhoWNqGNj22cAXlRHkgcb0BOwBIw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAyto-0004MD-Ol; Thu, 19 Sep 2019 16:03:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A09802741D3A; Thu, 19 Sep 2019 17:03:15 +0100 (BST)
Date:   Thu, 19 Sep 2019 17:03:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: atmel: Fix crash when using more than 4 gpio CS
Message-ID: <20190919160315.GQ3642@sirena.co.uk>
References: <20190919153847.7179-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline
In-Reply-To: <20190919153847.7179-1-gregory.clement@bootlin.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 05:38:47PM +0200, Gregory CLEMENT wrote:

> With this patch, when using a gpio CS, the hardware CS0 is always
> used. Thanks to this, there is no more limitation for the number of
> gpio CS we can use.

This is going to break any system where we use both a GPIO chip select
and chip select 0.  Ideally we'd try to figure out an unused chip select
to use here...

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DpsIACgkQJNaLcl1U
h9DKfgf+Jsooil74xOpQ+umzYyZp8Qb3FEcyImIlX60lGCNBSHiEvAhRajJ6+AXX
CsWEWs+bSzrHgo4y5RRwOrtp7RXbEJARgR2ke9JZ0l9P9qdU3oW/m8A8Ghq4Q8z/
3w+GW4UoWkqUuDjK/LZeOvBtmq1+viYePqq+wOLg12uVCc+aifI1qZlTJHFaGJUf
EJDxnopv92Ct66G3ZcQ8lMmujukMAuk6Z7+H6SJqvhIDOQLd8Ryt955+6v198wcq
M8zO5suWI6sTMK0HpsN6L3K/WOe7vOUOPYyyLtKBSAA4+Piy9EaQcVsWv1mVLJfp
SO2Y3XYEQykklvv+yX+7XlZxS6QYAg==
=WMib
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--
