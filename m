Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3093C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 22:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5F8217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556749825;
	bh=Dfk9lBQVKaP+zmMQ0taFMBuX7ZniYNK29qHNRGVAzjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IdnnlGXZuaFUYnK1jLCeLDWkUVSfswexb8KjbLwOFvbcgafgy7Mx51Kyr6LBB044k
	 UJslmlUmhGUuNt4ySd9rW+aCzuCQngxfE1BD44j5c04yMBgTgw+BPUWkLQjtqkmcJI
	 DkQRvbBp6B/EJbRAIDL3jeIbkFqmfiXNBPJpq15w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEAWaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 18:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfEAWaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 18:30:24 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2713020866;
        Wed,  1 May 2019 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556749823;
        bh=Dfk9lBQVKaP+zmMQ0taFMBuX7ZniYNK29qHNRGVAzjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwomimeVrROPYRHmcO9G3EzqTteeJHS8yALgbsWoJfsq5XDidCFmlr/AXdSlRKGg1
         ZJaqnuZATmEBUK0pZVksMPTvpIb84E4qoUjbywezl1xdabmReCSIUU7BngGexFmt7B
         t/Dn4FbdDD/meetBX/XO4H17u7xiZ7+XYEEU9mVw=
Received: by earth.universe (Postfix, from userid 1000)
        id AECA03C0D1B; Thu,  2 May 2019 00:30:20 +0200 (CEST)
Date:   Thu, 2 May 2019 00:30:20 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the battery tree
Message-ID: <20190501223020.ueubqwqmkeorzcbp@earth.universe>
References: <20190502075238.4069504b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iaab4t56qjwtvbcc"
Content-Disposition: inline
In-Reply-To: <20190502075238.4069504b@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iaab4t56qjwtvbcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 02, 2019 at 07:52:38AM +1000, Stephen Rothwell wrote:
> Hi Sebastian,
>=20
> Commit
>=20
>   465089b4abe0 ("TODO")
>=20
> is missing a Signed-off-by from its author and committer.
>=20
> Not much of a commit message either :-)

oops, thanks for the hint :) Dropped!

-- Sebastian

--iaab4t56qjwtvbcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzKHfwACgkQ2O7X88g7
+ppYKw//V8qoAgl/3SgoQM30LFDI6zBmGajF5lqZ2Qfj3CYD7useGhk/cblLiCg9
g+FB9OggNZYTJp8SHJFMTK8E9LbZ+oiIDOzKw9Ln9N9X7f/zlxmvm77gtYTl+NO+
kdjBVfu+MpEUYit3dnlYmkpr/T5xuJ+laNcRnvM6IYGi5uBKNmgdjqDuMyWuyfh9
p6u/DTMsUq94TVQHir8i3+7fWRbGJKtkbCH71RGXgR3kUOqOwtJuwkL7exG1yXuI
bbGOppLcAFQJ9rk3jARg/G5162ylMONaM99ZVcppJloVUy+k1f76oIYJPJ4dOU/Y
ciXXtEmRv9lLTfnJAERYDttkvH+Et3Bxcx8FZiIPhUDFd5xdX4MWQjU6KhaYZLAt
rfAEjQC7h51aZpMMs1GdDR3jf5D7aeBZI9IE+MmQCfmrogp5LseRhoPUD9wREBQt
Cn2qoqPWgXnn04v3BS2iiA/YsuyRT9yQNv0a4ByEXWcLGwlQvxLMe/tXbcTXmicf
VvC81LxN3OiLzZBkahVsxzBM1p0bEOZB9RZHQ8FwaxnTvvnOiNyxJ4bUNe6Xg6To
dRvhKKa2x8cO9NhaQJGeA/u98MdK162prDGfP3VaCUR8IAfd8JQXwNYzzTUkiqQ8
rLLVb/LVexxHaOS5OwoZW0/XBMWhXlxXRbcjzfLiMLvi5svtRxY=
=Q90n
-----END PGP SIGNATURE-----

--iaab4t56qjwtvbcc--
