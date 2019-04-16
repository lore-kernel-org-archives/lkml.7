Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296FC205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555429203;
	bh=INIycX6BY/8l1v+SJGb74HEJYYo8BeU0ZwECHq2wKvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dI1lmS5CVkTq/iI64gRXSaAFYWWIuOkT5q5bIdlN2mr4G/n5cWG6dTz8W72/81+1n
	 aXZwNruIOU3n4jJ3wo4nB5sP4B+tBvxThw5fSADExBF0x9elJRXqwFAk1ND9mrb4nJ
	 XNHEXv+cJFull55Qj3HnQ5qrzHoZFAW8UjNe+vpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfDPPkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:40:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDPPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=INIycX6BY/8l1v+SJGb74HEJYYo8BeU0ZwECHq2wKvk=; b=h31t181SMb9HuGzAIFD7t8wSq
        OWxUFxHn7lS+S4+bmQVgotWbqiUEP6MBjGGUeOWehcB8o0NaIhIe3HBGB03n23JYcwUW+684qwg0o
        fix0bZYC6+yW/IlG/hdTvD8r0XJO2EiYZW0cFi99KY8iEvkoD0GGx6+0Ip3DvIjJNhFro=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGQBY-0007W0-Hd; Tue, 16 Apr 2019 15:39:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1C8FA1127BAE; Tue, 16 Apr 2019 16:39:48 +0100 (BST)
Date:   Tue, 16 Apr 2019 16:39:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        bbrezillon@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, joao.pinto@synopsys.com
Subject: Re: [PATCH 1/3] remap: Add I3C bus support
Message-ID: <20190416153948.GF4834@sirena.org.uk>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
 <c38e3cb9e8524af58c995a9cf1f79ddba69b47b4.1555354268.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <c38e3cb9e8524af58c995a9cf1f79ddba69b47b4.1555354268.git.vitor.soares@synopsys.com>
X-Cookie: Who messed with my anti-paranoia shot?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2019 at 09:19:39PM +0200, Vitor Soares wrote:

> +++ b/drivers/base/regmap/regmap-i3c.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.

Please make the entire header C++ style so it looks more consistent.
Otherwise this looks good modulo Boris' comment; I'm fine with leaving
extra modes for later so long as they can be introduced without
disrupting existing users so the only question there would be if we
should name the init function in some way that's specific to the I/O
mode being used here.

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly190MACgkQJNaLcl1U
h9DH+gf+OZQm2X5EmdYvxQVJJHvMkOfr4/bdMEClhyqxihcdEuHsGX7QDR1nOmoV
nF4/QXoiYl9So2AGriD74jcq2IZzBvw5dEKuLCHus0TOF5hLFQjtdLuRdtxEP3y9
V7Q3aioi/RW8ukOjDRFBVXbzKiMwQ8QNM0P+0cZWjrp5HEG6t0qodhI6TKyq6X3g
ngnb7r1L5TZxgcE8oT7J17TowCc0jPqCj8DQMiDM+EOGDftnXXp8KK8wPXc/QwoB
xvuNoC9kIrbgIjbqyvbNYDkquIukHYOqzYVhLFm10WLEUySc0ImSh1JrDMn3WAoc
Jdm4iJV3Nc5Nn2c1BpBlHQ4D4iaWKg==
=bbEG
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
