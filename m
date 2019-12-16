Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD076C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9343020725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576491400;
	bh=oK2Z+gvU7X/ZRWb2P9P4VPxCD0n4mPIDKj1lZYaWRxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EWVVqcWgWcFIfixE4ONKQuBY/DXrmpvQDghljLzysRqWrC/pb4TXJw29xh8R+5yzl
	 YuecjNZdkOHHbRPhaQKwVl0ok6/wDk4AQTS7sxdxK17Ds1AZLS6ZCHV+0hZef2iNWP
	 bxTJpknCZFvdP+srvuxWdZu3nb/uUd+nzLu7D67E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfLPKQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfLPKQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:16:37 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 918F9205ED;
        Mon, 16 Dec 2019 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576491397;
        bh=oK2Z+gvU7X/ZRWb2P9P4VPxCD0n4mPIDKj1lZYaWRxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Iqa3GZCKAN/BdWeWt2q2lMQjNnKzlvJOdMtwDeLaqUTOmPSgXJd6jkhBaSdtyeAF
         vEKERaSI8CjRBdZMKlASq1MHUEYQumryWPzIQDwoaElZzL6qbKPjxf25MgAXrohkq8
         XROoXtS44NgmZ6tOAWC1LXi38QxyxMxneL5bfz9Q=
Date:   Mon, 16 Dec 2019 11:16:34 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: allwinner: unify header comment style
Message-ID: <20191216101634.tzef62pzxlsy6xpp@gilmour.lan>
References: <20191214132642.29564-1-peron.clem@gmail.com>
 <20191214132642.29564-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zxlxqylynajtnxui"
Content-Disposition: inline
In-Reply-To: <20191214132642.29564-3-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zxlxqylynajtnxui
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2019 at 02:26:42PM +0100, Cl=E9ment P=E9ron wrote:
> Allwinner device tree files used different comment style for
> copyright notice.
>
> Update this to keep a coherency.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied all three patches, thanks!
Maxime

--zxlxqylynajtnxui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfdZggAKCRDj7w1vZxhR
xd7CAQCeM3JWttlLb8tuINHhejhLTsUpHbCjus1qXKBxmKRLdwD/X28cgdu5O2ZQ
KhbaqZ4aE9ttkiDXqIdrw2cPY0Ft/QA=
=iT1Z
-----END PGP SIGNATURE-----

--zxlxqylynajtnxui--
