Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8725C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737FA20700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDAMdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:33:42 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58079 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDAMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:33:42 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2FE2EFF80E;
        Mon,  1 Apr 2019 12:33:37 +0000 (UTC)
Date:   Mon, 1 Apr 2019 14:33:37 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: linux-next: Tree for Mar 27 (sunxi clk & mfd)
Message-ID: <20190401123337.2nhppxyl5nzyofub@flea>
References: <20190327145020.2fff97b8@canb.auug.org.au>
 <641a04ec-e2e6-4263-e77e-d272058c18c9@infradead.org>
 <20190328095036.734adbba@canb.auug.org.au>
 <20190401102732.GD4187@dell>
 <20190401223624.6b4f8c42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3wrik5kehvbal5cg"
Content-Disposition: inline
In-Reply-To: <20190401223624.6b4f8c42@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3wrik5kehvbal5cg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 10:36:24PM +1100, Stephen Rothwell wrote:
> Hi Lee,
>
> On Mon, 1 Apr 2019 11:27:32 +0100 Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 28 Mar 2019, Stephen Rothwell wrote:
> >
> > > I reported that a while ago (x86_64 allmodconfig after the merge of the
> > > sunxi tree).  Apparently there is a fix out there but it hasn't been
> > > applied yet.
> >
> > Where is the fix to be applied?  SUNXI or MFD?
>
> Well, I only see the problem after applying the sunxi tree (which
> happens before I merge the mfd tree).
>
> Maxime said:
>
> > I've just sent a patch fixing this:
> > https://lore.kernel.org/lkml/20190322091650.5189-1-maxime.ripard@bootlin.com/
>
> So maybe if you (Lee) acked it, Maxime could apply it to the sunxi
> tree, so we keep the breakage and fix together?  Assuming that the fix
> is acceptable (and works :-)).

That works for me

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3wrik5kehvbal5cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKIFIQAKCRDj7w1vZxhR
xXKRAQCpxIqp1fLVXeCSBx3FmBK9+OAs+wyf2wIlAg5J1lWT8QD+LuJc1TxgLuST
yeXkfytOMPlqdqzMMRww9t9ltlvUcgM=
=EIgP
-----END PGP SIGNATURE-----

--3wrik5kehvbal5cg--
