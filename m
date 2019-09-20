Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF33C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA0E208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568960424;
	bh=3T4MBrrvAFoM5nVfdPzS+xVdO3QHAnjJT4ytFIM+Gzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BVqU1nokCDqudW6aN74ImwWmGp/UL/+rA6Qsu1sYCJzlAd92eem5PXZBXUwgoqqoE
	 SykqluOU4HKaDLPdQuUCf8q4KAr6ZyJ6x02s8FDJpfRQYz25PXYYz7Ic12/reewLTX
	 rhrV8tusmGrMEecGNQ9NyTajHu6aDQSBrYzr9gog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394848AbfITGUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394810AbfITGUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:20:23 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F354C20882;
        Fri, 20 Sep 2019 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568960422;
        bh=3T4MBrrvAFoM5nVfdPzS+xVdO3QHAnjJT4ytFIM+Gzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mT2ka4Nr4v3hC4nSuZb/06NB6lhQVzdlxhnSSPfNNayqKve2YzN4WH4VeVKY4W0Gc
         fNAtOezhXRjHaXQ9apdMWD0/JySkkD1/VPZW1ifChgNla8HItF8DsQmmqsWo9980Kh
         JcNFloX/JArYE27T3xdjnJuWgm8H+OkvFQdwaDLQ=
Date:   Fri, 20 Sep 2019 08:20:20 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: drm/sun4i: Add missing pixel formats to the vi layer
Message-ID: <20190920062020.zyt5ng6cxtu6muye@gilmour>
References: <20190918110541.38124-1-roman.stratiienko@globallogic.com>
 <9229663.7SG9YZCNdo@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jyakblbkkxwj5w7k"
Content-Disposition: inline
In-Reply-To: <9229663.7SG9YZCNdo@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jyakblbkkxwj5w7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2019 at 08:53:10PM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 18. september 2019 ob 13:05:41 CEST je
> roman.stratiienko@globallogic.com napisal(a):
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > According to Allwinner DE2.0 Specification REV 1.0, vi layer supports t=
he
> > following pixel formats:  ABGR_8888, ARGB_8888, BGRA_8888, RGBA_8888
>
> It's true that DE2 VI layers support those formats, but it wouldn't change
> anything because alpha blending is not supported by those planes. These
> formats were deliberately left out because their counterparts without alp=
ha
> exist, for example ABGR8888 <-> XBGR8888. It would also confuse user, whi=
ch
> would expect that alpha blending works if format with alpha channel is
> selected.

I'm not too familiar with the DE2 code, but why is alpha not working
if the VI planes support formats with alpha?

Thanks!
Maxime

--jyakblbkkxwj5w7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYRvowAKCRDj7w1vZxhR
xRW4AP91J8qXurWjaYEIlShut/9F1o+AH+QFka253dVyQ1XzmQD9GKVxtyQFNqro
T6dUZ4eM7nZmoFWRwll07iRaM6lFVQM=
=cHIh
-----END PGP SIGNATURE-----

--jyakblbkkxwj5w7k--
