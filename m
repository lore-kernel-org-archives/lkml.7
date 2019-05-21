Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42829C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F0221841
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="KK9IBRrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfEUTFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:05:39 -0400
Received: from narfation.org ([79.140.41.39]:37372 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfEUTFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:05:39 -0400
Received: from sven-edge.localnet (unknown [IPv6:2a00:1ca0:1480:f1fc::4065])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 717941100E8;
        Tue, 21 May 2019 21:05:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558465536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q+RYG1Ew1/BWvqBAzrvXKnnOjuLzkIU5nlRGcIrbnsU=;
        b=KK9IBRrWfK9qYuPsjoM9enbsUnM6zme6isWt+voZOqhTeDbVSHrYgd6BZuTaS812H76WNl
        a0nHZ31WBoadHAGxobhccLorKyehqEV4DzxOeyJKZZNXgkLlckTS2MZpo/Ik1ei5L4U5tu
        j9L1Rk7xV3gvo0ORfTSFSqXoDsnBOeg=
From:   Sven Eckelmann <sven@narfation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Date:   Tue, 21 May 2019 21:05:33 +0200
Message-ID: <1667110.kPLpuMjk16@sven-edge>
In-Reply-To: <20190521130431.2ab4c8f7@lwn.net>
References: <20190521074435.7a277fd6@canb.auug.org.au> <1640847.rHWZmc4HWd@sven-edge> <20190521130431.2ab4c8f7@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7183951.9blmtyIVgS"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558465536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q+RYG1Ew1/BWvqBAzrvXKnnOjuLzkIU5nlRGcIrbnsU=;
        b=lWmrPgYmgklkRMAzE2fBrSzxiEn19LSaGe+yBHJiGuWk5wcUukt7YmDa2kN3F1qJhoxUmU
        nQNIhJUdM0mWTtq7GEy3+Y3QdRhVn6Q37WAx+UT0lM1f6QzUeqDAFzp5lH4FsXCBX/bGuK
        y846UqcWQxlCeMyXEs7JOUGmH86Qp7c=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1558465536; a=rsa-sha256;
        cv=none;
        b=0Gb0ZE2LC9wsxle5oHau2rMDShTVKaBnIfAI+gIZtSXScMldO5EhdXKVZQ+v0sxUeMy/Z0
        mq1rnIVfbDOppK7YH6d5sYLQaH5dlRwxbWtsrrBuCUrfKbgf0p0sFj1FC67UbzlfewgRlS
        sp/YMQk22kzYNQKk8e0bYebLiNBe2qA=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7183951.9blmtyIVgS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, 21 May 2019 21:04:31 CEST Jonathan Corbet wrote:
> It was just a sigh because there was a little mess that I needed to clean
> up =E2=80=94 one that I had failed to clean up correctly on my first atte=
mpt.
> That's all. Apologies for giving you any other sort of impression, that
> was not intended.  Things happen, life goes on.

Ok. Thanks for cleaning it up.

Kind regards,
	Sven
--nextPart7183951.9blmtyIVgS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzkS/0ACgkQXYcKB8Em
e0bQbg//XcY4nxSCIfs2JCYPFs/JqyhQ1WJjzrIL330WuCC6gS2ZJaKhRzZk1iYj
umiQfRnFKQ+ZzkxZKlr9uIvOUX90rRyZyjn0aYelAPg5oaziKptc+1PsOqluqJ4Y
N6ouxLMTzMMAqY+/PyC77BgdmixJu99HdS/jh+K7L16c8hAY5MssVgg3ZgiMf5R4
ctn9iFhK8sYTFSR1y6dX9RT93ijChinhby5/TJZonU5SRbEg8fFUWpSgoMCXg+jh
BFIpSE66FAxeTS8xke9+8FJlvpM3U6yxGgjVUHjp//MGVIjNHoVn8I7AyCcZ+NQT
X6fy2S1/09mHiSukptaF2/Er/LWZgLSLbfp/lF0lNb4tfmqIVkrzYkMmyj5xdNjc
J7N/SoosRalHHQ/BSNt3Io9I63U7g+Xw59bREJeGFQpG71Zl3W90eJ9WvB9ZzkB5
p9q0mYAhh1aBVePljt9FPhmIhHNu0ykCeRofjtXhqi1hyVbuUn1dbS81VgrsSi4c
WwjasfLL6R0ZavhVDl60zpDrgZawQ6lkYcEy8w8QpVos6q6u0S0/kl1I7UvJz4ON
b2bsjabWA14RKa2VXnb1N7z3gD25YRlLoHOMLvFuj19VCiVIUhOhCQlI6oiAykR7
kFZCfDvY3R8j14IyJzr5LX5zeAuz44YXCEtqPcOIzPGnaM8Rp80=
=N3G4
-----END PGP SIGNATURE-----

--nextPart7183951.9blmtyIVgS--



