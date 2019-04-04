Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D2DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA0D2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uE6ZaNW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfDDXFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:05:00 -0400
Received: from ozlabs.org ([203.11.71.1]:48329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730539AbfDDXFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:05:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Zz6x6c6Mz9sPp;
        Fri,  5 Apr 2019 10:04:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554419097;
        bh=4nHwZkRtxZoOrbZsp5HwRYEGwwsgbw2QxI9YZiXNzuo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uE6ZaNW1dWGsg9l2XsJOH/yDvQ2QGDNxeEGx9WA4L5ZKG2aHBt89jh7MLvegguKY9
         kFkVhUfQvIUqCTKprvWSdOP2nkLu4Wna9TrKM7dkn/wLHVbAFps/ywmScFGggsjKDX
         mYtPWDLP8mGezguopiaDvMjTQVklSkIJY6uUJt7GDT9ZzM4GVBvZRz59eEt6wzX/KH
         KFch4Ge8pRysCJDIn5BK4qUn5yOb5Gn1mTKo4CLkb0TnqavFrPR9g1vPWEl4+LnzYS
         Mg0+laIkKj/uR/n1Nd7BU1L1R5yL5LjJq0s+HZ9711rl4WPKhZULDCGQJehSQ4cI5y
         jLk7f0b9bGdMA==
Date:   Fri, 5 Apr 2019 10:04:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the hwmon-staging tree
Message-ID: <20190405100457.134e9197@canb.auug.org.au>
In-Reply-To: <20190404212618.GA20949@roeck-us.net>
References: <20190405075438.12f98275@canb.auug.org.au>
        <20190404212618.GA20949@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/98eBZhbKBR=GkV3jwTFA.g1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/98eBZhbKBR=GkV3jwTFA.g1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, 4 Apr 2019 14:26:18 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> The original subject is "[PATCH] I2C: Move hwmon drivers (2/3)", and
> I consider it quite pointless to include the "[PATCH] " prefix.
> Same for the other tag.

True, sorry for the noise.

--=20
Cheers,
Stephen Rothwell

--Sig_/98eBZhbKBR=GkV3jwTFA.g1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlymjZkACgkQAVBC80lX
0GwOgQgAi/BbweXHJD+SFjrkJlp3RwHveSzlgAfhsMdapCHpV/+DQoq3hao+rzrm
WDsqWfHUkpIXHbmJ+XTpYkPDO0s6Bhir0mplhfPg1mf8DeDGsP4akTPM+mPd3sv+
DqHhlhSCqiH3c+LmzBY1xd8+dsuNaTArunvB4xyqNDvkgDbdGHbtxygGzRCeMafh
+hCe1nHhaDxEegFsMf8Hd5wyL0cU++rJ3y7xEhDj0ZlvOcMneofmjfdsZwcTzQ6W
tWzFwCWY123ZeFtGWfEYy5RaffIR3xux/+1OxohJ3yDIwOPGPXbIJMz9/fBuQnku
OL8bgNvf3635gVDkj+WO7HOilWLJmA==
=GHoi
-----END PGP SIGNATURE-----

--Sig_/98eBZhbKBR=GkV3jwTFA.g1--
