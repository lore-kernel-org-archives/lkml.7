Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53948C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2159121736
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574927010;
	bh=MxbZZyhMxP8MypT5uzl2FbmRA7P2Fx2ZT4tGfc6hXSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OUiFKf5oI9Fngvfh/zcGTxcVSq9UuYQ9J3yKi3eHmbT6BwTCdXpULor2z9PWoQVNw
	 kkIYpDwazQ5V0AyUn5T2yZYzKIevsmfiPg9/DYi0pKlq4sR4ifhDbTD0m7/fTCveld
	 bM4w+Mmq/WHFnAQAbnMbLwgRpGU8o9k8yoRIwpwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfK1Hn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfK1Hn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:43:29 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAB0215F2;
        Thu, 28 Nov 2019 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574927008;
        bh=MxbZZyhMxP8MypT5uzl2FbmRA7P2Fx2ZT4tGfc6hXSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wm8PVK7LJ/eHbBcPlypR34e9nGdlHpiyX+tDcKnSJxAQM91yQgFENMYbMHwZzBPie
         yRkIECYbg027w8uzuxwxYyGyI6EDte1JFAmNABgHVQO8I88Z5HY8A4vPdyjwu2xwR6
         QmnlLKgm3/xS4ZOJqZlhnywaFER5ex6PX8/4i3LE=
Date:   Thu, 28 Nov 2019 08:43:25 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
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
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
Message-ID: <20191128074325.q47rpzhufwog6mbb@gilmour.lan>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
 <20191127052935.1719897-3-anarsoul@gmail.com>
 <20191127174434.wousbqosmm5vxcsu@gilmour.lan>
 <CA+E=qVe22T1uhUo6iq9a82Y9bC014CZSkAtSJJNX4qsn6dJL9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cnk3ppztnbfqfu5l"
Content-Disposition: inline
In-Reply-To: <CA+E=qVe22T1uhUo6iq9a82Y9bC014CZSkAtSJJNX4qsn6dJL9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cnk3ppztnbfqfu5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2019 at 12:23:53PM -0800, Vasily Khoruzhick wrote:
> On Wed, Nov 27, 2019 at 9:44 AM Maxime Ripard <mripard@kernel.org> wrote:
> > > +
> > > +  nvmem-cell-names:
> > > +    items:
> > > +      - const: calibration
> >
> > Ditto for the const
>
> Sorry, I don't quite get it. What exactly do you want me to do with
> this one? nvmem-cell-names must be "calibration"

You don't need the items here either, this can be

nvmem-cell-names:
  const: calibration

Maxime

--cnk3ppztnbfqfu5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXd96nQAKCRDj7w1vZxhR
xRLoAQC3m7wZvI4EmXSfHN3h/VKMdIvvo5P5sgtpMsfd6hwbiAEAwqYBPjEtyyKB
IP3PzaCesyLXY9dHooofrsm3Z7+pIgw=
=I+ik
-----END PGP SIGNATURE-----

--cnk3ppztnbfqfu5l--
