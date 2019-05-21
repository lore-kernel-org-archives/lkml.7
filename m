Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A32EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15747217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="nICBqDhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEUHS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:18:27 -0400
Received: from narfation.org ([79.140.41.39]:53922 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfEUHS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:18:27 -0400
Received: from bentobox.localnet (p200300C59711FEEAB947ACDD12503D9C.dip0.t-ipconnect.de [IPv6:2003:c5:9711:feea:b947:acdd:1250:3d9c])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 239E31100E9;
        Tue, 21 May 2019 09:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558423104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hnrAZMZkoiK+k99+YAeToQRKWKznt4TCN7wFGxaZzg=;
        b=nICBqDhJepMBAVVzl2clnpyGgMzfznAejuwPgOne8wCznoBytsJI11Eekh7eHZV3C0CNN8
        TWOeoLfqCiBU3lU3oPwp/rUjT74kI7KWQZlvZuszksp6fRo95lzEec7JRAVOwJxXi0k//G
        k5vr2uS6ShKR19RhUQ4GYKSaL1xshQ8=
From:   Sven Eckelmann <sven@narfation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Date:   Tue, 21 May 2019 09:18:21 +0200
Message-ID: <2143236.hFqxAeOdFG@bentobox>
In-Reply-To: <20190520155423.2ad5d16a@lwn.net>
References: <20190521074435.7a277fd6@canb.auug.org.au> <20190520155423.2ad5d16a@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1610824.eLnjEb8XeW"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558423104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hnrAZMZkoiK+k99+YAeToQRKWKznt4TCN7wFGxaZzg=;
        b=Hbpj1EKeXLHFKb1SVMXYWJ5ofALR3qqb98nckmbfjZijrOPGXwl2Sva1Xo8FF9B05xnWNY
        /AJEZDJ+j35O1BvYWDsudpyMirApu+pI4u7itd6iMS1LIf4RxiPql6ZRyem8sYCl8hwtQ/
        iGy5kCznRs5AkV4f9SqUCImakr3inWI=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1558423104; a=rsa-sha256;
        cv=none;
        b=Iw8UloSpeGP3y4O3emf4mRnCAS/jA1CDWGgkn5UqJUx//us7Bf4UTR0qXAD4G3jDidxBMS
        3UoqhJuURbXKeLkHuJ2KYGV9Pjk98NR4Clwmpz4ZR0chCKdJ6JS8ON8HvCZ+UhHIg1hk/1
        iZ7zEtf6L9jqM61idl56ldCSh0p0WoY=
ARC-Authentication-Results: i=1;
        v3-1039.vlinux.de;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1610824.eLnjEb8XeW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 20 May 2019 23:54:23 CEST Jonathan Corbet wrote:
[...]
> Argh, sorry, I should have caught that.  Fixed, thanks.

Thanks for trying. Unfortunately it was changed to the wrong value. The actual 
commit I wanted to reference in both places of the commit message was:

    8ea8814fcdcb ("LICENSES: Clearly mark dual license only licenses")

It seems I've copied the wrong commit id for some reason when I send it though 
the git-fixes alias and it didn't occur to me that I just referenced my own 
patch. Sorry about the confusion.

Kind regards,
	Sven
--nextPart1610824.eLnjEb8XeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzjpj0ACgkQXYcKB8Em
e0aj2A/+KDSsnjismXPiAVG0/RWxHc4WNz4F3vtWr92HIw/HYZswKy8wZFYm+23F
3AbPZ1HYMud3gNkSqYhgyFslmYTdWTml1vIHQ2oa1WaZuMD6zYxLa/sSgfGO1YP5
AqFMMQLIC2I1IEXrCbyEx9yJc+2Wp/Va2JapD4NI79cblHlJBb41kAH2C57ftygC
3IZ6tdJ29sWKGsuWmKIBrXJv868mG5r2grXuEXTDznmPWrRfQaSEAuJGZ9QGlBgK
wuJQgitqESD2Lw8B2e1ZPlpDZI6g5RJbOgqsvGzjcxPb7Meegw4Pykl+yuckKX3I
yFlXeIhLjLwzSvtYtT1zueKmnbKyrcCsfyISuZrTE6xdEiJoI4ZDrMmfn29CKhRG
KEfmg+P2x/qG+djUne8pomzAANGqDqhAjNIFu7GUmT2zyAUSkXgX+N4f5VJQxVAf
cRXdmtEohRMbTCvTX8T2pGa0b43807TTYablJ8iyvwDFisrjbw5/iL79tPexXf8r
QhF2acfKq1686VCmVttpRn5xzpRdQ2sNHhH7w371FmYKaqzlCVbn15Jz/1sfz36z
qrfNzHLxpYhDhO3RaWubX9yH7UOaNd4qCPsnjmBmFg8uRx0tCdryu6AW2E031izK
6O6a3//ySDdsNE7OvsUVFSBP++GyX5M+DS95OssrFm8O6pEUCCY=
=pipe
-----END PGP SIGNATURE-----

--nextPart1610824.eLnjEb8XeW--



