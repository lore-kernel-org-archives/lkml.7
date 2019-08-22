Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88589C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9BA21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566502226;
	bh=UwXSAlsVz1BlQm8jZYLskuF/vGXa9uwO7QF/dYvbdd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aBsVJV4QlFaB8vXxrTunyB+AC+hj0n6pQ+CXYfspd0lwS5+J/9vHcqThGcgG1pPKu
	 7jZULhu8wcrePlY2xZKQy7MykpTmVQv8vkqLkTTYbJ2/R6CJfnnQnU7Ax289iss1YC
	 oMoTHCDCsa6bCHQcLR1SOO9Mf/uZjIuEwfrFaoRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbfHVTaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:30:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42696 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732926AbfHVTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bGI25yHsJcTnsVsILHuHx70XcG/d+CFDq9ZeEujNOuQ=; b=UcoZzjb0cl/K0CzhfAY2Tywbd
        EL8YAfcqciH+e9NKwQy3pfB4HghGWKXv0VqjvWcQQ+rYqJ9lN1dYU3k+KbbfAGxmXBTyIbXIH7JSD
        4kllOWF0YjmDVj0RHiy88DBm8+qnlzhqiWO17s63VSBUYgOGry3H3glHcLolnebieoFHU=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0smo-00083C-1z; Thu, 22 Aug 2019 19:30:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 77532D02CCA; Thu, 22 Aug 2019 20:30:15 +0100 (BST)
Date:   Thu, 22 Aug 2019 20:30:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        =?iso-8859-1?Q?=22Ren=E9_van_Dorst=22?= <opensource@vdorst.com>
Subject: Re: BUG: devm_regulator_get returns EPROBE_DEFER
 (5.3-rc5..next-20190822) for bpi-r2/mt7623/mt7530
Message-ID: <20190822193015.GK23391@sirena.co.uk>
References: <trinity-584a4b1c-18c9-43ae-8c1a-5057933ad905-1566501837738@3c-app-gmx-bs43>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
In-Reply-To: <trinity-584a4b1c-18c9-43ae-8c1a-5057933ad905-1566501837738@3c-app-gmx-bs43>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2019 at 09:23:57PM +0200, Frank Wunderlich wrote:

> seems of_find_regulator_by_node(node); is failing here, but i see the dts-node (mt6323_vpa_reg: buck_vpa) in /sys/firmware/devicetree/...

It's not looking for the node in the device tree, it's looking
for that regulator to instantiate at runtime.  Is that happening?

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1e7UYACgkQJNaLcl1U
h9DIXAf/SwrWcS3GuI3wq6WJK9mC5ILC9tOznC/HRhk/xcYaCYjZJgBRt6jJf9k9
HXrnvUX3Gr7b4jpE4PbpJM2KTFIzE5qTkQrb55slWJ6CAG6do+Pu2ZcO9tWRNou8
XuyvN0kjtW1s3eEGuYeDBTdJT2EueBbZ13qDt00uRJExurcbxWOuQbJNQT2Jcdj5
mYPyrrpIUJ1/3oZPV9WdrofTWx3YRpFrwiJ22kKnUA2NV90OIInFtfi3K6IXezWv
Ko6w3yRH+Koz1nDvCvAYd6rkPzJATa9n5sLToX5yxNWfYY4C7lpCov3NM3IEbjEY
7dtsFgvTH5X7V8Z4O2kcfDDmfaY71Q==
=zy6Z
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
