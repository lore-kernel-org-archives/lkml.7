Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C435C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E7320869
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfI1AFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 20:05:36 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45078 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI1AFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 20:05:35 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1iE0Et-0007ss-CP; Fri, 27 Sep 2019 20:05:31 -0400
Message-ID: <3989537df397001a7f909c6495292ea79cce041e.camel@surriel.com>
Subject: Re: [PATCH v3 03/10] sched/fair: remove meaningless imbalance
 calculation
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com
Date:   Fri, 27 Sep 2019 20:05:30 -0400
In-Reply-To: <1568878421-12301-4-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
         <1568878421-12301-4-git-send-email-vincent.guittot@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3XZ/y1IFppNmU436yTMp"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3XZ/y1IFppNmU436yTMp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-19 at 09:33 +0200, Vincent Guittot wrote:
> clean up load_balance and remove meaningless calculation and fields
> before
> adding new algorithm.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Yay.

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-3XZ/y1IFppNmU436yTMp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl2Oo8sACgkQznnekoTE
3oMJlAgAgmRQMnp6XiEs9/xyV1FpM+weOBxCntq8s95JpAeI7iDzRIyg7olBAlol
gM/ZoIUHw9Ask2LjTYiO195uyfw8WnTnA5TQ38C+4QIDY+IUOPqHTzCEV909eenl
SAUyXA0W4y3cLYvuMXMsdXTTF9ZBDECMH7550FK5N9wOKcsQZ715QYNoW0mdKWsE
FsndyKMMqfqgDDbuWbI/HwN00H//5AexeBsMW1f+Xgt2LMlAEZwX0/SHr+XeSFUm
306VJYTN7iJ03cfPpVAWAzruMINw/UTvCQIZ4f3vBG2g7Eog7XHFpJ0baw6oeOb1
hl2dtq2yD9LY/n8dHNUg6fvx3CJcXA==
=Otml
-----END PGP SIGNATURE-----

--=-3XZ/y1IFppNmU436yTMp--

