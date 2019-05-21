Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27342C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D769C21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ExS9umMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfEUHMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:12:17 -0400
Received: from narfation.org ([79.140.41.39]:53756 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfEUHMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:12:17 -0400
Received: from bentobox.localnet (p200300C59711FEEAB947ACDD12503D9C.dip0.t-ipconnect.de [IPv6:2003:c5:9711:feea:b947:acdd:1250:3d9c])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id D740F1100E8;
        Tue, 21 May 2019 09:12:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558422734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cll/0tvKmc1o4mD6hUk9skbAEiUDqeovcJFWRPitVYs=;
        b=ExS9umMeg2RHQkrCNmTlLHH9XPoVfSk/WzUqsNwGvH/eCPdsq9gV93JkOD5vbK8x7rXnJe
        BXfXv7tDEoej0zuX9QTEmyDYH4Wtj+3rGFF86DiVv86x3X/uOGzSDxcJVo6jGRfygYrGHr
        bSO5XqEWrR8391uu1H0b5sWgqy/dQBc=
From:   Sven Eckelmann <sven@narfation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Date:   Tue, 21 May 2019 09:12:08 +0200
Message-ID: <4248928.C8WpLz62KC@bentobox>
In-Reply-To: <20190521074435.7a277fd6@canb.auug.org.au>
References: <20190521074435.7a277fd6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2630576.59dGvNmJpf"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558422734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cll/0tvKmc1o4mD6hUk9skbAEiUDqeovcJFWRPitVYs=;
        b=Vau9q/P75rVhuiuYyrEwKd2QBefN6/BESiKLeVspKQMcPd0n3/L7RA37wrFTevBcqB0miJ
        loq9AhCRRKAK03zMJQf2Z9jTlN24udnE5Kt/xJ/I7CwklCqn7+7N1ABkYrmR2FP0zG7MIG
        wqJBRMQiuFBDldvMx8bWDas9oX4X26Q=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1558422734; a=rsa-sha256;
        cv=none;
        b=y/wPTvW1KrneBRZx4/f6ZvTHAoZh7nPOBWGXbdvhiF0Kyvhv/m04SdP+hpbOhuoqpANq47
        I9+l+aFSamezornma0DmdDfkcYaDXanHLSOUcvCSmv1tevF1F6XppQxO6v6kIzoV7Kb8cn
        JgV/3AimoBbecHs4DLclC/Rdem3jmWc=
ARC-Authentication-Results: i=1;
        v3-1039.vlinux.de;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2630576.59dGvNmJpf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 20 May 2019 23:44:35 CEST Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   9eaa65e8aad5 ("scripts/spdxcheck.py: Add dual license subdirectory")
> 
> Fixes tag
> 
>   Fixes: 99871f2f9a4d ("scripts/spdxcheck.py: Fix path to deprecated licenses")
[...]

Sorry, my fault. I actually meant 8ea8814fcdcb ("LICENSES: Clearly mark dual 
license only licenses") at both places in the commit message.

Anything which can be done from my site?

Kind regards,
	Sven
--nextPart2630576.59dGvNmJpf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzjpMgACgkQXYcKB8Em
e0bFWhAAqmrN6fpYzrZd/fk+XNW4xx5h+ZKMaoXAfWxnpBhVpCOuwIUQC4euAeQd
ZXT8eefVRmbEmwXEsE3nEmc/srHqmzJu5Zjl2X9ArBYXzKwveYb1pKsuNSemvXx7
jgsaX212te1E4JDdWCnQlH4NgN8JgW42lY1E9W35lYqWBZqyW0Hh7QTG0dCfKmLg
Sd1TqWd4IXZSVaPr09TBZi+tirHdkEwCoe/eDvgKt0f0D4j88vH8YXIsDIpxv0t+
0Nge9BJ6uThhpLyNxeyO9L2WlsPx5jJjzZazDvNkKYupokKXhoc8LchMr3Em6EtM
QOab4cr93pw3sgdMxWLiKsKjhatkSn2qjNwxidqTGgDIFHVdtQjERp5H4NZGpGVj
d4pDmvaJfz9yTebYHfI6GtULX6oShh2NGI3DV+p+VGZQ7/wWnZ3jwFYSB+TdnM9i
R+YLdHjNZCDRY5qA497n7HXzOrDkiW+d1ks4rcnLWWhPOzY3n26EfXvLB+bTEIH1
f8K+isYSDWi3UMfgJtMH++WnmMgHKnE/5iBcrj3ojaXmmXDM3N/3XjpcgvlbBgTm
CkjKoOUcpGS9kVhT6EI/t7YAqBIevXFQM+txZO/gR7OKmYaVUaZyniqd2MumHupO
cdg9LHwHYH0KrzxrHwlYZw5FSLzI1MiwdtKron5U8Qs8Oda/rvM=
=NL74
-----END PGP SIGNATURE-----

--nextPart2630576.59dGvNmJpf--



