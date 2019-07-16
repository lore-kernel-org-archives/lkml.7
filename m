Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96AC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9411B2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfGPXVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:21:05 -0400
Received: from anholt.net ([50.246.234.109]:53906 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbfGPXVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:21:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 32E5A10A2C47;
        Tue, 16 Jul 2019 16:21:04 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wrnpGYEhumn2; Tue, 16 Jul 2019 16:21:03 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E975C10A264A;
        Tue, 16 Jul 2019 16:21:02 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id DD8EF2FE2547; Tue, 16 Jul 2019 16:21:03 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: Re: [Intel-gfx] [PATCH v3 1/3] drm/gem: don't force writecombine mmap'ing
In-Reply-To: <20190716213746.4670-1-robdclark@gmail.com>
References: <20190716213746.4670-1-robdclark@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 16 Jul 2019 16:21:01 -0700
Message-ID: <87o91th8gy.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Rob Clark <robdclark@gmail.com> writes:

> From: Rob Clark <robdclark@chromium.org>
>
> The driver should be in control of this.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> It is possible that this was masking bugs (ie. not setting appropriate
> pgprot) in drivers.  I don't have a particularly good idea for tracking
> those down (since I don't have the hw for most drivers).  Unless someone
> has a better idea, maybe land this and let driver maintainers fix any
> potential fallout in their drivers?
>
> This is necessary for the last patch to fix VGEM brokenness on arm.

This will break at least v3d and panfrost, and it looks like cirrus as
well, since you're now promoting the mapping to cached by default and
drm_gem_shmem_helper now produces cached mappings.  That's all I could
find that would break, but don't trust me on that.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAl0uW90ACgkQtdYpNtH8
nuhEYQ//SHu8CMphEkC2owZV5vypxTHr7xCw11FdyGvA/BKc+ydJ/bLYJC9AZ4q2
RLnWRI2LhwJxpXdLIvW1SFeZwj3RqhAcngI6hccJD9EB+75IjeqtLMuvKn5WNjV1
mY+gNypUpx3ENntShYWB/cpXiKiEKTYKP+1UjRewSxzSwICf9NEdc0k+BMLs0mpP
BdT7agdnuD90yX6o080eiz5pRGFw7GgpXbvC2jmUIulS+ITHzf0n4zsQ70zIxRNa
NT+gsw8nb2WOjJgIl8AJIV1iFWtn186C1gKP0m3E0ldRITcbP/rh4uU4MLL9mh7v
NmWFJ/p0Ja7LrWI5RIWMrcBGx+tDO2rzoAyVmgekC4HEa2ueSfxsIQKwxarwne1D
nsKwuZZ4F8pyCmlMCQLdi51eM7hvn1nd4DbPq9WQ8s3diQFy0+MXUJUE6VIJU5jz
UynwKRHIOYrBHnYm4dqnLugXnlYVakvVJGrnyrzg+AvjTerx6l0DzMXo+v5dRJFS
J5CWYdhbewr7XGEzjdn2GNMs1p/x+ZU7zEvDCWjPAPxag8Ay5cfkeBTQbvlEqMX3
GMcY4av5AdB9G3MA4gJb95Ykkx4dFbA3z00kJfvi2uE3wT8Ia9Yq2eXj3g/YCzCX
EnDcGbs+9Cp7gdww2Z4xHVTpz4m39X2NeOld2sZX6TfBepurmVQ=
=CmID
-----END PGP SIGNATURE-----
--=-=-=--
