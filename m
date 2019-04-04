Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69423C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3C220855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDDLFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:05:12 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50023 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfDDLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:05:12 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D8ED51BF210;
        Thu,  4 Apr 2019 11:05:08 +0000 (UTC)
Date:   Thu, 4 Apr 2019 13:05:08 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] nvmem: sunxi-sid: add new reg_read func
Message-ID: <20190404110508.rbk3z5urndtiqbmq@flea>
References: <20190402154514.11284-1-tiny.windzz@gmail.com>
 <20190402154514.11284-5-tiny.windzz@gmail.com>
 <7dc60dd9-3bbb-f215-4554-a0051c0cfbfd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ny7tgfpxvwmv6vfd"
Content-Disposition: inline
In-Reply-To: <7dc60dd9-3bbb-f215-4554-a0051c0cfbfd@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ny7tgfpxvwmv6vfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 11:59:44AM +0100, Srinivas Kandagatla wrote:
>
>
> On 02/04/2019 16:45, Yangtao Li wrote:
> > Because there was an endianness issue. It seems that reg_read
> > function which the nvmem the driver currently exposes is wrong.
> > So add the new read function, the new function is used when the
> > native_endian flag is set.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> This patch and 5/5 does not apply cleanly on nvmem-next.
> Also I would need an ack from Maxime to be able to apply it.

Chen-Yu has mostly been taking care of this recently, so I'd like his
feedback on this.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ny7tgfpxvwmv6vfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKXk5AAKCRDj7w1vZxhR
xTuEAQDJYNsyUIVjp1/OIKiaTRqefwV1Kzo8JrfqXvqyq3DWnQD9GRUbaA8kkh5q
19AYo+3YuKFkWdfrbe2rIgGkpRfMyAo=
=d7g+
-----END PGP SIGNATURE-----

--ny7tgfpxvwmv6vfd--
