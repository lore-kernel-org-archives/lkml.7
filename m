Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C4C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E6B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574876151;
	bh=8HRYzVgPcetDDCF2bvKH47TzErjz8apkOIgcOvQ1Q6Y=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=oTYeAXYk2EHA+wL+kbNCF484tMlX5c8hYp8uOKtb/f5jMpe83vxQ8n9HKg0JkRusW
	 xcSsWTmR07W6IoDl19F/M6CZjc0GskYpnvsRg7/9ajTx0shs1IUFETbi7rzbkNfahJ
	 Ws+Q2/JWhSHcmVJbmXTjMhr03ScEe2MHQX/middU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfK0Rfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfK0Rfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:35:50 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B672073F;
        Wed, 27 Nov 2019 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574876149;
        bh=8HRYzVgPcetDDCF2bvKH47TzErjz8apkOIgcOvQ1Q6Y=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=BM8a+qfDycXQPaQbw7hsiDRV8bKLEb8FpywEpFh3vOEHMmQ1oySZpXGMCd0pvVHrH
         1iY9UZH1hZ6FYLZDgibJ5emEWQ4yU+lrVgNbPqySBe+7iNNKmCUHMOesopKoDFva/Z
         AAOADAj9iZp6SlGt3ST9nR57pV3T2Rj3+kVJ7jBI=
Date:   Wed, 27 Nov 2019 18:35:47 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] thermal: sun8i: add thermal driver for
 H6/H5/H3/A64/A83T/R40
Message-ID: <20191127173547.ch3pcv3lxgdcrfnu@gilmour.lan>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
 <20191127052935.1719897-2-anarsoul@gmail.com>
 <20191127111419.z5hfu5soxceiivg6@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwcawhqsgm2ldrw5"
Content-Disposition: inline
In-Reply-To: <20191127111419.z5hfu5soxceiivg6@core.my.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwcawhqsgm2ldrw5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 12:14:19PM +0100, Ond=C5=99ej Jirman wrote:
> > +	/*
> > +	 * Avoid entering the interrupt handler, the thermal device is not
> > +	 * registered yet, we deffer the registration of the interrupt to
> > +	 * the end.
> > +	 */
> > +	ret =3D devm_request_threaded_irq(dev, irq, NULL,
> > +					sun8i_irq_thread,
> > +					IRQF_ONESHOT, "ths", tmdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ret;
>
> I guess just return devm_request_threaded_irq(... ^

This is harder to extend though, so I'd keep the current construct
(with a return 0 though).

Thanks!
Maxime

--rwcawhqsgm2ldrw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXd6z6AAKCRDj7w1vZxhR
xcDrAQCIanJbpjnMpsEnvSREQtxK7fDMF2yUA4PEFXxT7Jc4XQD8DwS/ddoljPwC
LOq4CK3fzDEGVY2Hq1jih6ifX6QOQAw=
=BHNs
-----END PGP SIGNATURE-----

--rwcawhqsgm2ldrw5--
