Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E64FC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC7F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCVIcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:32:04 -0400
Received: from sauhun.de ([88.99.104.3]:48780 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbfCVIcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:32:04 -0400
Received: from localhost (p54B3303C.dip0.t-ipconnect.de [84.179.48.60])
        by pokefinder.org (Postfix) with ESMTPSA id F3AA62C08C3;
        Fri, 22 Mar 2019 09:32:01 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:32:01 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/msm: simplify getting .driver_data
Message-ID: <20190322083201.GE1005@kunai>
References: <20190319163629.30660-1-wsa+renesas@sang-engineering.com>
 <7d66ed6f-1dc4-05ec-567e-939df7d8c94b@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <7d66ed6f-1dc4-05ec-567e-939df7d8c94b@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -	struct platform_device *pdev =3D to_platform_device(dev);
> > -	struct msm_gpu *gpu =3D platform_get_drvdata(pdev);
> > +	struct msm_gpu *gpu =3D dev_get_drvdata(dev);
>=20
> Nice simplification :-)
>=20
> Do you catch these with Coccinelle?

Yes, the previous series had the script in the cover letter, but for
this small series, I thought it was too much. I haven't changed it since
then.


--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyUnYEACgkQFA3kzBSg
KbZH1Q/9GiumevdCXYDywxVkBEGKkHqsak/lfC0FCyk9nIbwTB5T9BygKpMo7Jjj
7FqG71AeYTvtsVsoxkKt7vozKtkomgFStiXZC7a39y7cTWnY8ReadnucvY4xtN0Y
ix1X8khP43em2g1PKHnZK+SseAgZPwzgkXpTw5yDl80mbsgYceleY1q6E6bMA4+f
QDtl6jvbtmXVIpduMqv40fRISVN8bAuygtGLeTIIVpmC8QtmYc8kkQYU/gnjOCd8
OC4VqZGNQ66qYib1rPntiK9pnZDXEJsNlfG7/O6GGFY4yGwGD06W89N2VFn1oEBj
14hPPHUIo/ttsxmNMm9XmlZ9oHZL72WdxjztnDDROdxMAwSeKGwR3bL3wiplRLpk
zEItq6iUfNiu7/m5wSjcwOum3bFgAUDIscu0ApntmSKNfpWie49K0GLocFvH9Fl3
oG8BetU34UFB2D8oxYsS0kehcddNEg1O8a9b7MBtvdi048uFwpQLPDK2bpgN0WUR
tfEJxcacj2WhZaafVN1xcKlq1riVj03JFW6P/IrB2w8JbqseGmWlHGh8nOM++NJd
ksvRj6lEKn6UDBI7Ug+iC7QLBubO7WQMlnPW1pwEE2fIZTlLWqjriNvae3c3IPtc
EH/8KJR6gpyJZIc3sBlQevF3Uh1Zcnma+vaTD3byuUvQuGPzUqw=
=fJka
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
