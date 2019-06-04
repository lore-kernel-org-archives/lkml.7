Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F106BC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 03:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C785A2608F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 03:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QFw/l1Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFDDJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 23:09:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfFDDJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 23:09:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Hxht4wdsz9s3Z;
        Tue,  4 Jun 2019 13:09:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559617745;
        bh=eWk4DUmMh2ML3MaInSj2iLEGM8bKHvXFv1XvMiEKuDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QFw/l1AcB3GM8YTQyJICmay9MqC8YZUU8ZDy3L+URZRb79Hl3DScsWSv3H9lgSZYi
         88VVUnYy7onU2ERrNiQBBcp4B85fqlPkf6+f++ZtjMkQIXppGSFL4Z2lN/bxrOGlr/
         lyH1nqrF1yDlWtSXq9an6OT4asGOQ+EqIa+H4zEiVKmOYvXL7FSG6Z+1BydG2yUU7p
         qBQNY9YT0MLZSRwWjngBGcT3HGiPfPvxPNFfbq14d2feb5YJw8kHMzfVNXbku4YDMI
         WR+SEIQmR3brMUD/H4Ysb/mnY4e4G89thx9P1nHAoXP+j0T00aAU//la0/lFYE1dEP
         mxMCDAWyQddrw==
Date:   Tue, 4 Jun 2019 13:09:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>, Ingo Molnar <mingo@elte.hu>,
        Joel Fernandes <joelaf@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Roman Gushchin <guro@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [mm/vmalloc.c]  728e0fbf26: kernel_BUG_at_mm/vmalloc.c
Message-ID: <20190604130902.67475ea1@canb.auug.org.au>
In-Reply-To: <20190604021356.oqipbgasyaanrt3k@inn2.lkp.intel.com>
References: <20190604021356.oqipbgasyaanrt3k@inn2.lkp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=XpXsArn/ygwi1SriMAj9TN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=XpXsArn/ygwi1SriMAj9TN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Jun 2019 10:13:56 +0800 kernel test robot <lkp@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: 728e0fbf263e3ed359c10cb13623390564102881 ("mm/vmalloc.c: get rid =
of one single unlink_va() when merge")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

This has been widely reported and a fixed version of the patch is
included in today's linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/=XpXsArn/ygwi1SriMAj9TN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz14M4ACgkQAVBC80lX
0GwzYwgAh7eCk6JmAfdEitRufiw5h92Gd/rnK2hyovFpEUePDaKWExRwkZ6qVbzX
E9gPZfVuoNarf+rdxIvUHQDRwHGiQbYcD8lvUKrcHbUeiIwWImlM2WVLzexW98kt
Xj5Irq5EQnEKEOn+xcYPNp0EGQcTwWd6nfdPeiVeaoaiARlDv4bh0FzoFg0WQHm4
ySRD1oJ3SE4ygwW+jQA/XxolUcXGnkZuu7AHRk85IGvpBUl9VkRcBDedZ05Ig5eI
d49sJOLpV6Mhwn/+WDPK2jC3fJpHb+4JfOlHsLPv9BLSlj5sbgSSAOdbemiVQ7CD
sUsPGihDqORKT1IYJh6HZqXwP/HI4A==
=OTJt
-----END PGP SIGNATURE-----

--Sig_/=XpXsArn/ygwi1SriMAj9TN--
