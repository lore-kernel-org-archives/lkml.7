Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6DE2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="brJxBtdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfD3A2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:28:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbfD3A2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:28:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tMnW0vF3z9s9y;
        Tue, 30 Apr 2019 10:28:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556584095;
        bh=jxeomaEGDj9jCiG96b0VM67znI2L+mGjbFhnESNETM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=brJxBtdYMRHVALu8PXFocfLMPDZ3tsuZp7FEDNu+RazGxYN06hjHyeP5KSWC+S/Um
         6qUKslKeTIC3hy9M3Xog0jnzLq7gVhbkhz9SMXh6DMJy3xGB4KLkdbZN+8ApTK1w+t
         /TVbi3yIXqCatEaRjL1OTXWKRfkpp6Wulw7S7G9n3ccA2uyGRM7OeBZR2ZzA61GX0v
         PXiQlIxFH+0t/jqVH4lcFcX2nABGZCCj4If6yKXYURX43MjWqcqN2aZcfebzrUCL3T
         aM4p3aMvXa9218IySs6+helsPVCzW3leyIE0WkND2KRwO3Ng3tfhrx114Vu1nfuU5c
         MhhvYffVPmhgA==
Date:   Tue, 30 Apr 2019 10:28:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the rdma-fixes tree with Linus'
 tree
Message-ID: <20190430102814.73f213e1@canb.auug.org.au>
In-Reply-To: <16bb268f0b5b62d71cc65204bccea856333b87d8.camel@redhat.com>
References: <20190430081346.3196b60f@canb.auug.org.au>
        <16bb268f0b5b62d71cc65204bccea856333b87d8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mSbVZQh6/BdOyK84lieBwgo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mSbVZQh6/BdOyK84lieBwgo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Mon, 29 Apr 2019 18:21:32 -0400 Doug Ledford <dledford@redhat.com> wrote:
>
> Sorry, I forgot to back that head commit out.  Once Linus committed his
> fix the one in the rdma tree was superfluous (and wrong anyway).

No worries - I even managed to choose the correct one by chance! :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/mSbVZQh6/BdOyK84lieBwgo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHlp4ACgkQAVBC80lX
0GzPhQf/aQox6wP+TJarWwq9a2oRtjQLg9FWKpjkODFhbBh9J2V4+Rk6V/PBFcRZ
03DiD+8goxY7hX8drMtGPfjFSesYbmyQKz6ikM7lfxODpyzZiesHg7cHLLGJYIeb
KcLDJnQWpQIaLLvr6hqZ+IPWYQyWzFKs1l70h+eLPfTRdR3niZ3d2hrDEgmYYCLv
+VWiphd6VYExwO42Ei7DNuHt2MsA7m+pnATtCWaWS1uj9ay1CSwBq4CCL/h9DJNK
rsnOc4VfU4E5AWplyGqQlkO2a8nnwTiAm8ZErvUHKrwFOGlICPjriYgt6SNaHgf6
EcmtTS6tgz74zPlJVa4XnYujb/X/YA==
=1DgZ
-----END PGP SIGNATURE-----

--Sig_/mSbVZQh6/BdOyK84lieBwgo--
