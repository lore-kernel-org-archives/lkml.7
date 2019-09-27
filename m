Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAB4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67A2204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfI0X7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 19:59:31 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45062 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0X7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:59:31 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1iE093-0007qU-0Z; Fri, 27 Sep 2019 19:59:29 -0400
Message-ID: <b5075f9296537d404f36b28928f0a9b5bfd8f520.camel@surriel.com>
Subject: Re: [PATCH v3 02/10] sched/fair: rename sum_nr_running to
 sum_h_nr_running
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com
Date:   Fri, 27 Sep 2019 19:59:28 -0400
In-Reply-To: <1568878421-12301-3-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
         <1568878421-12301-3-git-send-email-vincent.guittot@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OjHyJqX/BFxOoodamTwo"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OjHyJqX/BFxOoodamTwo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-19 at 09:33 +0200, Vincent Guittot wrote:
> Rename sum_nr_running to sum_h_nr_running because it effectively
> tracks
> cfs->h_nr_running so we can use sum_nr_running to track rq-
> >nr_running
> when needed.
>=20
> There is no functional changes.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>=20
Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-OjHyJqX/BFxOoodamTwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl2OomAACgkQznnekoTE
3oPQ6ggAnV9P6DOlnyIEq2zgnQrLdgc7cfBHDsOsQl7nYlP9HjTnU4vl4oWO8fGl
Zez8pG3yEI+6eVI1JXyTELHecF8KrCTrIYr/08zOT+tO9hfaH3Ay3NzWziFIlAhp
z2SofgfTmBxMhJUFh2qYZZ617Zve79iMcfyfWu7OBLg4183s+Zc73fQxqbxlWs3a
yma5INapUC+m4idZOUM7lpsu9BExW5i0eO5++1GfEeVUYCATTWilI5WWeBcEljjq
+vBsFKUNhskAaRzvRLnnzkTKT6bLaPDRVGO8do73kmPKyNlMfV1NVOT9Pk2l6Cet
Y2JF4tz56gGxbMFz4aAv7EpUtNVqPg==
=OGI8
-----END PGP SIGNATURE-----

--=-OjHyJqX/BFxOoodamTwo--

