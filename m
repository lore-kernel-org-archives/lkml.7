Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38F5C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A4C20730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574071189;
	bh=9l9y8mbUUWdHV0d1LTAj4+3W9N3gykUXna0pQednssQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LRmc5C6FyeOUiHvU5sb+vTv4dKqp5anP1xPE5WrKa11o+w3sAIitsfhObWpgTHtdI
	 snSnu1d4hLiEU0Yw0wwIw3OAE46KLVZGua7ehXKW2+AMiwI3p3K6MQ874Ar+ZXJ3wa
	 y8ttc4BBlSrPWytKFHsP0LvQkVkYNoT+vYDbUgik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfKRJ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfKRJ7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:59:48 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466A420726;
        Mon, 18 Nov 2019 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574071187;
        bh=9l9y8mbUUWdHV0d1LTAj4+3W9N3gykUXna0pQednssQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QL2+16G0flSQmGtRJTrCS3XRl2jo8nP/OjcamNRMmG3DlRpdCXG2xsWq1EZ0vKaCw
         eOV7bo488UXESbXTNVGjT6km/We/YXL2lckB8TQ0apwqpD2JNp0hGfnxo9AAL4UTiM
         pGT4Ef0faPy0e3CZazu5ZkaoJqsMUglxM/lpofdo=
Date:   Mon, 18 Nov 2019 10:59:45 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: Add rc map for Beelink X2
Message-ID: <20191118095945.GC4345@gilmour.lan>
References: <20191117125250.1339829-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lRwEuQLrOweSgmPW"
Content-Disposition: inline
In-Reply-To: <20191117125250.1339829-1-jernej.skrabec@siol.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lRwEuQLrOweSgmPW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Nov 17, 2019 at 01:52:50PM +0100, Jernej Skrabec wrote:
> Beelink X2 box comes with a remote. Add a mapping for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Queued for 5.6, thanks!
Maxime

--lRwEuQLrOweSgmPW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdJrkQAKCRDj7w1vZxhR
xYOyAPwPmxyRoHp8QXtQebwxInzAnzmCF3T67rKVNR7q1DoBxQD/fETiy0lIdbyr
U1mpqsVBkyA5sCFQYXHgfXRP/xX8vg0=
=JJzO
-----END PGP SIGNATURE-----

--lRwEuQLrOweSgmPW--
