Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1241EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3062184B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="o9i4hKrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfEUSwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:52:54 -0400
Received: from narfation.org ([79.140.41.39]:37122 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfEUSwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:52:53 -0400
Received: from sven-edge.localnet (unknown [IPv6:2a00:1ca0:1480:f1fc::4065])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id BFAAF1100E8;
        Tue, 21 May 2019 20:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558464770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLFOHAz+9Cusm8AESNgaYqugxzsv1C53Vsv9e7W7l2w=;
        b=o9i4hKrpLUDmlI9Y1Qvg382eLd2vDmWuWjEIwL7Q+Mm23dv8FDBpZxo8nceOjL6V+Hpw9R
        tALoa5O0bddzavHLpbywSEehQ2/AQQ12LLw0dCAIMtyhGgCsYOcH1AQKgZISB5uyIdt5qV
        Wtb8Pqb/s2xNkRQKL6SCINACKz4d1Ko=
From:   Sven Eckelmann <sven@narfation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Date:   Tue, 21 May 2019 20:52:46 +0200
Message-ID: <1640847.rHWZmc4HWd@sven-edge>
In-Reply-To: <20190521124603.658acbd3@lwn.net>
References: <20190521074435.7a277fd6@canb.auug.org.au> <1654747.HbZAs67LzE@sven-edge> <20190521124603.658acbd3@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2552761.yTD1mybP9e"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558464771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLFOHAz+9Cusm8AESNgaYqugxzsv1C53Vsv9e7W7l2w=;
        b=M5N2MHouZnOvwYoyMe59t4aQB0m726MsalhECwnd0SnOXKyWHbfq41sq5RdniiC6/kcvor
        uAK8yBgEBP6qkkvbMXEboxdXw5Q84oWlt7rsgUqVimyE30SDz/+uLLjyxdcg33DMkl0KMR
        3+ZBxW0U+f3Vc4KrbACvaB36utHknt0=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1558464771; a=rsa-sha256;
        cv=none;
        b=sGDHk/O8aWsOeVg1ZMKUIqhRVeaSzK+iVxXFZuwdLFJ2XdwVref+f7xBjbBLRGLXhoJMSY
        jj8yTGOnEOHtl9FHc/QiJCeyYetiy+qyICR8UZz29Q7zlvGI7ihh2XcCcAW2DkjFFO3BxP
        Ro9jqS6fVl8gs4x+3ajHYfbNJDkIZqw=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2552761.yTD1mybP9e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 21 May 2019 20:46:03 CEST Jonathan Corbet wrote:
> On Tue, 21 May 2019 20:23:48 +0200
> Sven Eckelmann <sven@narfation.org> wrote:
> 
> > > <sigh>  
> > 
> > It is ok, I will never send you any patch again.
> 
> I'm hoping that's meant to be a joke...?  This is certainly not a big
> problem on any scale...

Not really. If you are so frustrated that you start your reply with "<sigh>" 
then I think that it was not enough for me to explain what I did wrong and 
that I am sorry about copying the wrong git commit + not noticing it when 
pasting it to the commit message. What else should I do? Jump back in time?

Kind regards,
	Sven
--nextPart2552761.yTD1mybP9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzkSP4ACgkQXYcKB8Em
e0bn6w//Yl3IZ4QEd+FpOkQix5YPM7pvHUiEb+azTHURtsTlLAy5w1DZfBWDTf14
kN9mmMovAZ/UIgb0/n6W0LUzn4GcHzzYKx9jRBTUfV8JIRwrXXpbomjBzfp6B8/r
pAV7ibsubdwtco58oOilvVHTIJQ3nSHYj/0aL/bZzaj0ZnXaMOODB2CifF0boEsZ
BuwRjobkCr/hR7jrtm4PzsK4WuCbNiTNJJw/x2YUYs3AmDyjjrySiR1LFgt2t+5l
NUt9Zl6jprOqeElzNzaC1eMFGqefll4UFnWSBsWiFgKVQ72RClYY1F29lbhsMKKz
4lTVpjGAlX5WrYTEeitq2/+SD12IsGW0wOsQof/RoVxyJb8zdkUXXS0JIA0g9TWE
2Wu/UCmgEchDIkDToNCebhuM9Mv/38A4dm9QlYMGASzz2sRNJollB4pZLr/cy7Jr
xypJ3FiX2ufC3+4OJY+nGhs92saoVAGW43oZQ7xf6Up+BgyXsBjUtx/CWOd/SL/d
Gy4OUfSk65gjZnEe1GrGtD9szVjoYJ0YYCj6gC3krzcv4HGRvROTQPjUgaHIT0i7
ICLAcYIjL0c5+D2PNgSgdd1PF5tub5IrVoDz+i0Huw7wYfSo7JK2/giTPXVWbVO3
zXnYRFLQ+3HJ1GyMwLgdLZznpiwSJUnBzF9yHp13mUnhXtlfLJM=
=+2S5
-----END PGP SIGNATURE-----

--nextPart2552761.yTD1mybP9e--



