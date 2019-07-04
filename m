Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F7C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEBF2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tdaY9WTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGDNBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:01:39 -0400
Received: from ozlabs.org ([203.11.71.1]:41165 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfGDNBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fdQm3jMfz9sBp;
        Thu,  4 Jul 2019 23:01:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562245296;
        bh=wi9xuffeOzlu3jAUH5WeWRsq/Q57g6q/g02//NAupm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tdaY9WTJh7KZ0DGwkpSNcihubZcxbcr6eEyyHqgv7JYEntjyAcJjgurL9PFLArxAo
         Dw/TsPrm8fR+ZEGeIdRUkwgubsznC7Hz1HrApMXP1lTp8yfBjb0mGWP0aeYWSXcVhN
         NNPeE4YIqiBAX95w0HpKnIzpzBOkL/BypsbBrW6RKEJp2JQsso74HLL1ULL94R4NiX
         6YElMoHkXt0THhu9Ipj/HjDkYNZtvCoPMpv1NWfoDP50q/JkIRTqtdd/eqYgmnp7Pw
         YHChm6ob80NhRZ8Tu7U6jj63dK2YZ1V5xq1yb27UapdoRj0sIY9Dctb0e9hoLjMBrf
         XF3iJNffqjU8Q==
Date:   Thu, 4 Jul 2019 23:01:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Message-ID: <20190704230133.1fe67031@canb.auug.org.au>
In-Reply-To: <20190704125539.GL3401@mellanox.com>
References: <20190704205536.32740b34@canb.auug.org.au>
        <20190704125539.GL3401@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tVMXQfMxeXIw7WTvCxvQfHP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tVMXQfMxeXIw7WTvCxvQfHP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Thu, 4 Jul 2019 12:55:43 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jul 04, 2019 at 08:55:36PM +1000, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the akpm-current tree got a conflict in:
> >=20
> >   mm/memory_hotplug.c
> >=20
> > between commit:
> >=20
> >   514caf23a70f ("memremap: replace the altmap_valid field with a PGMAP_=
ALTMAP_VALID flag")
> >=20
> > from the hmm tree and commit:
> >=20
> >   db30f881e2d7 ("mm/hotplug: kill is_dev_zone() usage in __remove_pages=
()") =20
>=20
> There must be another commit involved for the 'unsigned long nr,
> start_sec, end_sec;' lines..

Yeah, there was, but that didn't actually create a conflict.  That hunk
is only there because I removed the initialisation of map_offset.

--=20
Cheers,
Stephen Rothwell

--Sig_/tVMXQfMxeXIw7WTvCxvQfHP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0d+K0ACgkQAVBC80lX
0GxQ/Qf7Bl4eULvQ8CruWMkgGN1Xs04I+4aRGbKwPY/ZgGV1nogi0GDU+rbOyIYx
weKj2KUWM2RE1DV7BpvzkONY8Li0hVT/B0wrZ3UH43rQLWPneaiw1Kr7ZBLImAVa
xeRVYS+owsHk9eWnyOWvLjRcdHI79y/bTjLhj3edys8kqiRNVWC+RipZxTdN/8rl
vcLNxewaAY9bFM8/CCozNWXMI1YcEOOa37Ilzn4x1/p8HNMANTALzgee7VtbkzpK
q8SmmfxZUB3NYRMCaf/yqDM208DrZRXpPTGk0FVEYjE5eapMkrFW0m3G91EtCE68
R15L/af1czzwaz1t6zrQ36bEj5SJaA==
=t4d8
-----END PGP SIGNATURE-----

--Sig_/tVMXQfMxeXIw7WTvCxvQfHP--
