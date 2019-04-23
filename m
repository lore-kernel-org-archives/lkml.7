Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D59C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554AF218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfDWVgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:36:32 -0400
Received: from sauhun.de ([88.99.104.3]:56570 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWVgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:36:31 -0400
Received: from localhost (p5486CDD9.dip0.t-ipconnect.de [84.134.205.217])
        by pokefinder.org (Postfix) with ESMTPSA id 35CA72C7BF4;
        Tue, 23 Apr 2019 23:36:30 +0200 (CEST)
Date:   Tue, 23 Apr 2019 23:36:29 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Message-ID: <20190423213629.GF5659@kunai>
References: <20190403210535.32236-1-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline
In-Reply-To: <20190403210535.32236-1-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 02:05:35PM -0700, Ray Jui wrote:
> Change the iProc I2C driver to use the 'BIT' macro from all '1 << XXX'
> bit operations to get rid of compiler warning and improve readability of
> the code
>=20
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Applied to for-next, thanks!


--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly/hV0ACgkQFA3kzBSg
KbYSSQ//U28cZhOdvdRpOtnjksOrWPT0G7du60YMy/1ypLWNaFg2Nt/c+EOEhyiM
ACPJIPzeM2AEP753ce42qnqFKdzvszUJQ4pMoTL0WYwjmc/6ocYee+fLLAgKOWQb
jMcMpOJVSJBzLcc9HDYkF+Lz370WRmdW6cIayFUxysleTnBM4PVGY+e1cDiR3rjv
t55jRtWEjfszyPZqiIAHgVuUumfZp0MZykrJawwY2y2RadP7TlpM29bD6om97pcl
q4cJfmckD74RZi/fD45qWzxDwPOH1wAshwj5z/sOBorzuJbPLB/d3+iexsk3Uu+T
HxkxhmNtLnyYhNnPQmAtcsJJB5PvMPmnT6Lu3zxz5cuGvXv3PKBsHanHE1LXeVxD
ZcejqDuW+j0fzhC9CrCb2/IF6zFBIc2M/PIG2LOp+MlE0mDcwJ7HKvVfSrGdTWV2
eHH4zycZIgyjwSHeNcTklZbCFnAqmpnnqPsftsEatJYjBZRw0kktn6Wd+anWrT1v
wMXHFauJ7n7OTdEBOJ2IvgpbswdqoM6T30kZRZH7fsWyitHfOiwIO7cHhjeYKTYE
iA6zACp28KQaxaMf1SDVbDGrVgYYikwyi5qQmWleS1VhVWcuB64/FigXaHqwCWOe
rZNSu8mfgZvMTVKbp1aZy++mhYr1LQNscuLWOgvdbwaymmJqJQo=
=/key
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
