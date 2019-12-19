Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFA0C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2BE24676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576776805;
	bh=Y3xByJTEgCOaNoNsGe4pKVIS9XI0ZCLfbAdIESGvlxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fNd2BjHOk5ixe8mR6yu01dMhygVb2+Pm6pBBufhpOUQWfSSMn0rjhtzPcr0tsWI15
	 qx5PJo553i+KQh5/pEVekFzkhW4amgaTrmn1YWHyGUXMh6dprtGbLueTan/6aJmEJl
	 YJMMs9YQl8PVeRnoqkaX24xD2ZbLn9jLr8gQXhBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLSRdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLSRdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:33:24 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14EB21655;
        Thu, 19 Dec 2019 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576776803;
        bh=Y3xByJTEgCOaNoNsGe4pKVIS9XI0ZCLfbAdIESGvlxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7XHdThvled/qPuJrHfh8WDRBCGmbBlX8Qm16xJmq4b3/auOSP0X0WdRi7kcVRQft
         AxxquNXIx9tq78P+zTe7QRWMJYF+DCqi0KUdHrYBZVNzlVKfUcGChxMp8Lyc+CYNEM
         ObsJprmDL5/iDJDSnRhoA7meyAwq3o+5Ydrsv7vs=
Date:   Thu, 19 Dec 2019 18:33:21 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20191219173321.bni4tbrhfkkphv7k@gilmour.lan>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w5q3jazkvks4ahe3"
Content-Disposition: inline
In-Reply-To: <20191219172823.1652600-1-anarsoul@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w5q3jazkvks4ahe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> H6 and R40 SoCs.

Thanks again for working on this.

I'll merge the DT patches when the driver will have been merged.

Maxime

--w5q3jazkvks4ahe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfu0YQAKCRDj7w1vZxhR
xb1VAP4xjI8YI2zdKwYfiKElxYGUogPWWoFs7p5Em1VmwApCcwEAv4GZSBrUwgDf
iL9xxj+jWVL/hIbcgq1jXocUjXhSiQY=
=1zC1
-----END PGP SIGNATURE-----

--w5q3jazkvks4ahe3--
