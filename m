Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F60C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2EA216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G3MgsvQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfGELJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:09:56 -0400
Received: from ozlabs.org ([203.11.71.1]:49163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfGELJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:09:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45gBvN2X9Rz9sNf;
        Fri,  5 Jul 2019 21:09:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562324993;
        bh=OXtbk1b4fFm1R1JUKIm0/9hTWgjDEdLQvvS+zollgOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G3MgsvQyAmYt5urUQ6AzpSDvoKudKW3EWi6fUqBodclkx5xpU/skwj/XwZf29RhnY
         uAx1dqZp+S8GjBd+GLGf+BhkboqlUqvZS2MiLxsRmQ+B6K1C73U3vk+FZ4M9rhOIYg
         aaLvRNEuYNpLqWbr/sxB6qWVAVFQlZ185hmyqs/pi1olhrjywUoz2szLQq1jWwvouq
         wp0Fle6SyxWv/BAqUTdH4QCp6AAslhlDrF1buqdHcohe0kMnH9v1lZhcJzPg6shII9
         DkC1KV/cUqTwYccq0r51cPTG9VDeCIe5WXzdkHG3tsq5zdYBb7HQiukikd+xpapgPJ
         xEmbcsgOjVjRw==
Date:   Fri, 5 Jul 2019 21:09:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Staron <jstaron@google.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: linux-next: build failure after merge of the nvdimm tree
Message-ID: <20190705210950.6b77ec77@canb.auug.org.au>
In-Reply-To: <616554090.39241752.1562316343431.JavaMail.zimbra@redhat.com>
References: <20190705172025.46abf71e@canb.auug.org.au>
        <616554090.39241752.1562316343431.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gp22g0z1_Tgphjq1B8VeR1e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gp22g0z1_Tgphjq1B8VeR1e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Pankaj,

On Fri, 5 Jul 2019 04:45:43 -0400 (EDT) Pankaj Gupta <pagupta@redhat.com> w=
rote:
>
> Thank you for the report.

That's what I am here for :-)

> Can we apply below patch [1] on top to complete linux-next build for toda=
y.
> I have tested this locally.

Its a bit of a pain to go back and linux-next is done for today (after
13 hours :-)).  You really should do a proper fix patch and get it
added to the nvdimm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/gp22g0z1_Tgphjq1B8VeR1e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0fL/4ACgkQAVBC80lX
0GyG2gf/Xe6VyKK1naUX+/PKN76T06iz58l9CRpjhS40BUeEYwwfWTADN9z/Th2S
xc1bWUeSIfpOn5mtxGrf0x85QHizUh9Nxt4k0h9lDulpR6/y8DS6ECHf5/X5YwTG
aIBlqDnDeKARR3/K6yfYW8O9KEKVo9u+tj7F62hrg9tPnVv1AG6jLak8ul4dMM1i
9Mcv5jFhzpsrBNl01chTayDvdrXD5q3ClwKLJuIDiPscEAIf0/dNog1mPmOg7ivx
aLE0+4IoSY9T+yXHG9xdM2OED1HV+ohwXRY8Rvl7sX+csGgAPjDRYhvAmMSvIi+B
A3y/T4Mrwxr0bl69Wvm1LJWS3re9Xw==
=JDAT
-----END PGP SIGNATURE-----

--Sig_/gp22g0z1_Tgphjq1B8VeR1e--
