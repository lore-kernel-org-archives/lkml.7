Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98573C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB5120836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562070272;
	bh=cvy0kIJO+R/Gzj/CEXr/8PVzwmIW9DWMbnYx/biL+po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=teJEt9wLlMUfhkggABPkJXYaaiefk13yP4BZMlpQ/GKRjUgntjJGiggqAGEX0HoUS
	 ky0J7jc9SAsJFAoIcGVrbHNl2v+yj9t4jC8UUvMRJ3y3in1pPPbYBM7hYlZR75ImNv
	 Muu6g+gL+n9z6A1UgSe3RkeLu9mdd9f9drJJihUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGBMYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:24:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57020 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfGBMYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cvy0kIJO+R/Gzj/CEXr/8PVzwmIW9DWMbnYx/biL+po=; b=ggVQc4I7QcO67RPYg5FQWUfk1
        77P9hQCq1bHSFUFFKmuNpNw+xQVarmAw9Gyi2uAIYcbhp+M4E/B+aO7DCnUIB5Lbe1LZ5P26y9QXp
        0h6S/AqVmg29L91wFLLKfAD1HnExsU42l1ZL7ldK19SiNJjkr/seIVWXmoH1YCq4l/LL4=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiHpj-0002J7-Hv; Tue, 02 Jul 2019 12:24:27 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 9C4F3440046; Tue,  2 Jul 2019 13:24:26 +0100 (BST)
Date:   Tue, 2 Jul 2019 13:24:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] regulator: lp87565: fix missing break in switch
 statement
Message-ID: <20190702122426.GI2793@sirena.org.uk>
References: <20190627131639.6394-1-colin.king@canonical.com>
 <20190628143628.GJ5379@sirena.org.uk>
 <4cb0e4ab-66c7-2b3d-27d3-fd5cfde8988f@canonical.com>
 <20190702104420.GD4652@dell>
 <4a0a50be-1465-0554-f787-dec72bc07a00@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Content-Disposition: inline
In-Reply-To: <4a0a50be-1465-0554-f787-dec72bc07a00@canonical.com>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2019 at 12:12:10PM +0100, Colin Ian King wrote:
> On 02/07/2019 11:44, Lee Jones wrote:
> > On Fri, 28 Jun 2019, Colin Ian King wrote:

> >> So it applies cleanly against linux-next, I think the original code
> >> landed in mfd/for-mfd-next - c.f. https://lkml.org/lkml/2019/5/28/550

> > Applied, thanks Colin.

> I'm confused, who is the official maintainer of the regulator patches
> nowadays?

Me and Liam but since this patch only applies against Lee's tree he's
applied it there (I didn't think it was worth me picking up the entire
cross tree merge branch Lee prepared for this one fix, if Lee hadn't
picked it up it'd have waited till after the merge window).

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bTPkACgkQJNaLcl1U
h9Blxgf/X/fK5rQM9Xb+Yt492Z9/NCArCSuCI/mxZbI1rmSe+GDcD8h5mV6hd0ok
d5MOzJ6HnMDRxgAZIns3zlNJ+Pm9F86FKrpfEv6Amjd8ykg7Xy9Gb0DsNv2PQnj9
0K9Zf3cD5OBEAM8VusSStT/AvvFxSkejXLjt5nswMdQFN3a7CS16U0aGIZOrd1t+
rROoqa5YQKTb4AF9Tn6+XoVvpy96zd2ixbFPqDeV8EwXJFt6+Y5PJAbSvXfG6HX+
PYOQO/IMeJqfH9jbg8a8GyDdOTYC5rKHKIRPmbZVuRGo7O4WEDpMRFO1PwKiBV/J
hcNdXDspcFdYbwvUUo6Ar3d2F94ScQ==
=aXbp
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--
