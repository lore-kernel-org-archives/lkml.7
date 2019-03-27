Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18761C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42362087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553687924;
	bh=q0BhOFMIwLvkUjfumq3asqFnAzUPsF020ocIGKxos0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oxy9rBE+IogSrGa/0loiA8wHorZAoBqA5vXNg1mlg/q0n/ccwdF0MQPz4XMFzvfwP
	 ccRU+hF+pTOecVXV1rLlVAUlOW6mp2qIlwWmpuXcvRFd2i2EuB05kdrCLJrGOk7vOl
	 8yrUqGAX7R5RpF0QLZd7tdQ31Z6eR16fbyOuSDYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfC0L6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfC0L6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:58:43 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBAB2146E;
        Wed, 27 Mar 2019 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553687922;
        bh=q0BhOFMIwLvkUjfumq3asqFnAzUPsF020ocIGKxos0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOtuUTXeBzInNy10TKcUhHbEJguPz1cHUjOD5Jyg+6UpyZN06EnxVXXojod592woc
         m9dVXBT8ij+433fX65JgQdg7M2BqIlQjDfx5P1Yvydmv9qkwp+KqRufYOVKd1EYnjU
         pVP0M58QGtSejaRW9ZCW6oq3ma8PJVXJJev/lGEg=
Date:   Wed, 27 Mar 2019 13:58:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Message-ID: <20190327115839.GW22899@mtr-leonro.mtl.com>
References: <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
 <20190327095337.GP22899@mtr-leonro.mtl.com>
 <20190327101133.GQ22899@mtr-leonro.mtl.com>
 <20190327101815.GB32571@zn.tnic>
 <20190327105024.GR22899@mtr-leonro.mtl.com>
 <20190327111452.GC32571@zn.tnic>
 <20190327113628.GS22899@mtr-leonro.mtl.com>
 <20190327114917.GD32571@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="phbq2bkSb+hZnunM"
Content-Disposition: inline
In-Reply-To: <20190327114917.GD32571@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 12:49:17PM +0100, Borislav Petkov wrote:
> On Wed, Mar 27, 2019 at 01:36:28PM +0200, Leon Romanovsky wrote:
> > At the end, it is reduced to our usage, we are running QEMU inside
> > docker to test kernel changes with limitation on number of CPUs to use.
> > The systems are optimized to boot kernel as soon as possible in order
> > to run tests and on my machine (64 CPUs) reduce is visible: from ~2.6
> > sec to ~2.3 sec from execution to kernel boot.
>
> You're kidding, right?
>
> 0.3 sec boot time "improvement" for a kernel on which you run tests
> which take orders of magnitude longer (I assume). And you want to hide
> this message in the upstream kernel because you want to minimally speed
> up *your* *specific* usage ?
>
> And we still are wasting time talking about this?!

I understand your point, we will keep it internally.
Sorry for wasting your time.

Thanks

>
> Oh boy.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm2VvAAoJEORje4g2clinxEkP/R/f75qk5WO6sIAsvSO001nX
vKa2ISJHa3JHWOGE/1j49Tz1jGC3AffFipHaKCraK9DfJXD0peNz/g6GF/Kyjwlc
UPDyoET0pNS9af27DKOYdNWdFcFLKoEfm081qFtrol3SnwtLu31bZK6Or0NjX+SH
VTV1vvkXgnmkb+mhlqIgMoaga4n5fiC+A1KUdg+CZlHR0YMp+Dfom55Ftdc1H/Rf
aSRgiFCjep/vConrPe7WOQR2bhwdAZMxCQi/0hj0MlQbxk8ZqGV0WeblpyMXARoa
Hdett9TOGkGSFD1SKU6vn7uKSlAmDAra6GK45JKTbWX9HQG/zrM1tFaF5efJBa2z
mhgH9NkXWD2v8geh4pexxjSPRffQUBkm88IpMRohHwl6NQPpkCAxqFQtoWd+V4jv
XjwBsluNA0JOCo7t10H3bHM//XdiKnawinosa76OsKoHL591Jjd5fBe0JEiWH9gM
EP4nGtZ4NAzPiZat9fxp0hi6UPVhI1cX1m71TT9bMqiitPFzX3CWU5uf/ae1CgPY
MHpNUv1cTPtgaIoSZ1WXVCghGuif/WEidZofVp3Beuc7lmRiU/Qxkrh2ZA6bvnb2
WHmDfMbbnllrIFgofftTOzClF7H6sioZ8cyK8GLQz4p6CPHCehCUG09Tvmk/LVkE
F+BzQIXCQBYwNDD9hnfX
=2dI1
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--
