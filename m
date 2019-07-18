Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8624DC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A697208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563466997;
	bh=wRhm0B+F2MDWS6n5Tn2SaHoSuJLy4eFplDgU7rJwaR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fQyMSOVS51sJA40uiJlCLFLK80iJMZcBSXpRp3Gcf6bYBQuXaU7bUDyCM/9O5rO9k
	 AuWvhK6p7++eNu8MdJYriCOc62dJmVJvjQBRuZMtHfP7H/F+asRNlb8Br25PdRKQQ1
	 R0VZPmJBROeNLj2AG2Ut2F9W1FuMxFO9JsyZlsdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfGRQXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:23:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45454 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u88OQSng8pqPv+xn+R4kAUlsl3qCV7o4uVNlPX15ue8=; b=qYExk+w1vbwc0rCB7fAgxwakH
        r0od6lDOr3H/+/SR6yuwp6kCzxy2VecJb4DJ0MokSnQxpeYb7cZoPZMp7VjZWsApTHk9bLQV/NC4L
        dVI8g8ehwmXAB4CJuCO+hnc6yVtfHitvJKnxynMhYhyW2weDb59Nm6l2QuHxPa6Zn6KA0=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ho9BX-0005Yo-7M; Thu, 18 Jul 2019 16:23:11 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 25436274175C; Thu, 18 Jul 2019 17:23:10 +0100 (BST)
Date:   Thu, 18 Jul 2019 17:23:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kasan: push back KASAN_STACK detection to clang-10
Message-ID: <20190718162310.GG5761@sirena.org.uk>
References: <20190718141503.3258299-1-arnd@arndb.de>
 <0ee5952b-5a76-c8a5-a30a-ee3c46a54814@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <0ee5952b-5a76-c8a5-a30a-ee3c46a54814@virtuozzo.com>
X-Cookie: Oh, wow!  Look at the moon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2019 at 07:18:28PM +0300, Andrey Ryabinin wrote:
> On 7/18/19 5:14 PM, Arnd Bergmann wrote:

> > asan-stack mode still uses dangerously large kernel stacks of
> > tens of kilobytes in some drivers, and it does not seem that anyone
> > is working on the clang bug.

> > -	default !(CLANG_VERSION < 90000)
> > +	default !(CLANG_VERSION < 100000)

> Wouldn't be better to make this thing for any clang version? And only when the bug is
> finally fixed, specify the clang version which can enable this safely.

Especially if nobody is currently working on it.

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0wnO0ACgkQJNaLcl1U
h9APYwf+Kzm6iVj05bK6tW2kdTEo7s2zm8djsU0Lw/jReO/2k4adbVVkiYeVBcvr
mfOHmcwEl9KdUAAhqhAXKmhUHjAX92Tiz8uPmlYm//5K2+0nAkq8T+qbZK6HGnSZ
qg/7w6bG7SL/nEgQKjbxNz2ZRJJPRsFR69hPewzSmO+MEPEmsfBZbk6/2wcLS5+P
AFO3X8Sn8Lx8b2ZszQ+gyr6z23CL9t4MnkaNY/3j/bWqhwZs1oXS6Ij8ALgU576K
nhTH7/9p5vDpOayPI4tT+5WLCAKIjb+xkbUQcfDTlFxvbH0EAA91c2L1JfgAAwAq
d324QrrbSFQ2A1y1BmntIQKfCBB+fg==
=tOEW
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
