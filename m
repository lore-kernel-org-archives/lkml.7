Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4687D218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551344744;
	bh=fOJxbWW1Ta3m7zKAZsG70AAq1RqWmbHnBGjvKxaTHZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xdGqBUsZAdMKYNcUvxFbegVCsuxM7JtEW+0hRt1QJsNA728qxus+ETs+6+jHrnl5a
	 /NSVTmnPU5NKu00aGiITXsLnKkC+yl0xQwiNICxuyGj52qal/Cy+FCk3iD6sFug0Nn
	 ndXB0aZmbkMipLEHERcftt+hfg4viDf0T+Ydr6R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbfB1JFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731463AbfB1JFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:05:42 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BD821850;
        Thu, 28 Feb 2019 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551344741;
        bh=fOJxbWW1Ta3m7zKAZsG70AAq1RqWmbHnBGjvKxaTHZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y3RGjK0MBVzfhaeJuSg4sknhGh5AQzGd9AISB1FaZ2PSJ6q8BfSlbvSNXdudhBAlh
         aGDwPj1r07epXLdVpvJmenbl/9uJYKidB0GKtjp5aYLh24+YTfkVugyh9drVLRSQGK
         GnWoXa9ca2UIUGqW41IF/Xo6XGqypgyrNLkM7Exo=
Date:   Thu, 28 Feb 2019 11:05:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20190228090538.GI15253@mtr-leonro.mtl.com>
References: <20190227112522.2f32b5d7@canb.auug.org.au>
 <16f0ac6227f948165b7062a72e1fa82f1dfe4697.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
In-Reply-To: <16f0ac6227f948165b7062a72e1fa82f1dfe4697.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 27, 2019 at 11:24:51AM -0500, Doug Ledford wrote:
> On Wed, 2019-02-27 at 11:25 +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the net-next tree got a conflict in:
> >
> >   drivers/infiniband/hw/mlx4/Kconfig
> >
> > between commit:
> >
> >   6fa8f1afd337 ("IB/{core,uverbs}: Move ib_umem_xxx functions from ib_core to ib_uverbs")
> >
> > from the rdma tree and commit:
> >
> >   f4b6bcc7002f ("net: devlink: turn devlink into a built-in")
> >
> > from the net-next tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
>
> Thanks Stephen, we'll add it to the (largish this release) list of
> conflicts to bring to Linus' attention.

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD



--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcd6RiAAoJEORje4g2cling6UQALWqfFTY0PGurqrSq5C/SMa0
+drjsyY7SaxOO1pE6kXGAzA3QrM4qjD4jMPkk4yMdDx+Z9cdM0ycApnIKQhfzfGq
VO+lWr3cvRRmYq2q+Hh0doLh8MWlBooTicc1m1DzLgziYRQUw1LyAs5El6UbcQvl
BWnlPHF0ilcqIw5JCtKStchov7JLo/UYsrFtVX7G+0SSyw8TNmo53BaFQ4RwwR25
XrYy93M86UGs7dALYmMVco+JTp5JvgD5u2f+7EQfe6DMHixcLQT2ynCDSwF4Fh02
EYDiPw6N/ca1xpBYbZxE/Log8B3cAIGuh1W6yBeXidAYfDWuR89ep/RAotdAJuNM
Q81+xMbwNmx49HP2ex7Jf4Ppjn6SPvPbkktzXjzgIDEs2YB0ElW9jj+HAPzwHEp3
HPmuysZawGQY4SI3QETgUBtkFp+erezKoM8DxtC4mKCiDf8r12ZObmEuL5cDjORB
gMUXh+L5J6C6H3SxTInMp9C/2dAEhpfWZvOKszZ4FxEV6FsQxmyqGV0z0TgvarCu
UfzYpqiIIcPXRamjUcPJIHSgssORO6MNw5BBRbEwpsx11ux7me5vK6lB3FseNmUi
YkpleORNneUZlfDLRuPWOGdXyafWhuKlwrBOkiI6dsNJ8Tt/fE848cx0hF43LHH/
8oIm6QU4gEpIKQZkOBBt
=WiJt
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
