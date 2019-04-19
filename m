Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560EBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D7F222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698209;
	bh=9iNK0gwcUMYFeR0tIfG8ohfqV+rxApq+ECYCJiECHlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z/jsOQJxx9Vz+dIl8ynVvREmeTlbT91nEBIX3/T8A/i5Xu4g/nvkwRtSR3cUcZQ1n
	 8baVUgUxlpogVCtGTQjgYXVVKRegXLp41VejTpnjvCdOrpJqLGhatgepZsz9INVya5
	 ryptHY56F1ubfmnQWtsueWLta0YxPoc8Zu87A+Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfDSSX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfDSSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L02lidpU1CWJs+5WvBdKuXF1cJhohg86bxgiBZZR0xU=; b=DgaVWyKzfGLpL8WTjq6xjbRJg
        cXPNBN2oTgNzZvV1P49C16H285liahkHS0bGwxqAUgPW5VJsod3iigt/9PARyVtMHI7pXeHjICcCC
        gWgyEuHIsjjR84JuKvRBjoWP6KWE2GF3FhtxyLathZ9ZCRmRlQtunkSnEdSJWTIP9RCvo=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHUrp-0008BF-Bc; Fri, 19 Apr 2019 14:51:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 62107441D3B; Fri, 19 Apr 2019 15:51:51 +0100 (BST)
Date:   Fri, 19 Apr 2019 15:51:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        dwmw2@infradead.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, computersforpeace@gmal.com,
        paul.burton@mips.com, stefan@agner.ch, christophe.kerello@st.com,
        liang.yang@amlogic.com, geert@linux-m68k.org,
        devicetree@vger.kernel.org, marcel.ziswiler@toradex.com,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 3/4] spi: Patch Macronix SPI controller driver
 according to MX25F0A MFD driver
Message-ID: <20190419145151.GR2803@sirena.org.uk>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
 <1555320234-15802-4-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Content-Disposition: inline
In-Reply-To: <1555320234-15802-4-git-send-email-masonccyang@mxic.com.tw>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2019 at 05:23:53PM +0800, Mason Yang wrote:
> Patch Macronix MX25F0A SPI controller driver according to it's MFD driver.

It'd be much better to describe what the above actually means - what
changes have been made in the introduction of the MFD driver?  It does
feel like there's not as much abstraction as I'd expect between the MFD
and the child, there's a lot of peering into the parent and enabling and
disabling individual clocks for example rather than either having this
hidden behind a function or just having the clocks owned by the child
driver.  The driver also isn't using the MFD interfaces to pass through
the register subblocks for the IP - instead the child driver is peering
straight into the MFD structure and looking at a variable in there.

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly54IYACgkQJNaLcl1U
h9D0PQf/erY3gZlhAvdcG9BNLPO9WNE8OrfW8W1e5MFQI3MEhJC9fi3BynwsbKtq
oYO7n4IlWTIXmNDQdlZTdlGU2ybIAMGbUmRh0sP2UB5dh2nNnCTfzdOKdszWov18
JFDl2+5xeyM5ensdZqRVNaXOP/j3eavC/1AOgDTlVummvycoxPH7AeDEg/+UTHrb
blDrIxdutZnG+hGdmdoDBZdMsP/eWTS2FJ1t3bnU2AVnftWS/35E5NXpJG4o+gz+
kb+NmEWgrDFoCOk03rq02pudfkdQawONL85giQwm5Apz4OcKeGRV7tIUjfVr0DxT
9Rw+gkXFeqGyyD3rS25VYKnDsuXRCg==
=WftF
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--
