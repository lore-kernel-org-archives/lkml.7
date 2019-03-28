Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC722173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfC1HGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:06:39 -0400
Received: from sauhun.de ([88.99.104.3]:42304 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfC1HGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:06:35 -0400
Received: from localhost (p54B33178.dip0.t-ipconnect.de [84.179.49.120])
        by pokefinder.org (Postfix) with ESMTPSA id 4C5BA2C27DA;
        Thu, 28 Mar 2019 08:06:34 +0100 (CET)
Date:   Thu, 28 Mar 2019 08:06:33 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc:     linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be,
        rui.zhang@intel.com, jslaby@suse.com,
        wsa+renesas@sang-engineering.com, edubezval@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        h-inayoshi@jinso.co.jp, nv-dung@jinso.co.jp, cv-dong@jinso.co.jp
Subject: Re: [RESEND PATCH] thermal: rcar_gen3_thermal: Fix init value of
 IRQCTL register
Message-ID: <20190328070633.GA902@kunai>
References: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 06:03:18PM +0900, Nguyen An Hoan wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>=20
> Fix setting value for IRQCTL register. We are setting the last 6 bits
> of (IRQCTL) to be 1 (0x3f), this is only suitable for H3ES1.*, according
> to Hardware manual values 1 are "setting prohibited" for Gen3.
>=20
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Yes, this is what we discussed for "[v2 PATCH] thermal:
rcar_gen3_thermal: Fix init value of IRQCTL register"

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyccnUACgkQFA3kzBSg
KbYuDg/+M0RVneSw2K0/P7IFF8ql31xrf3WCWCtgmbRkbHAcwWUgY9+xbs0jaF1h
y+nnHILeimX02peBa8dT4WHIDq3zKi+qN0IXMZ9XgU52kz4COlE51MbCtAtDhhgh
O0tHoRCky7U80Qn/8j91QBC7G+vS7vNMaX6ES2ZLEHnrr+m2YjK7olDNLap+Y7qc
oq3zB06fsdCT4qnow2DGCJllorICPATkv/41KI7BK59Opsm/nVnL1HbYH67IWdeh
c+kf1QvxwYrGQG2Rgkw9hOjRRoaZJcsohrfRotVMudthCK3mq7snR/CKUeC/2ylT
Eo6aQx10N/qo0CYxwMb63uz8J+L043bRE81kA5V8CLNaXRwyTL8BObpMAwoQyw01
Dv0sN6ACfiIJ8toYqPVnOFkJMeHsYksmg5TrBoQ9CJ+BsXYEccph0TKSBGuJO/oc
v/GZLKc0GAuwcY0BlthR0p9wu6X1UfcxA4/JHl9H7Tk1vaEdpSgkAcnKn/S5gDS2
rV8Zr5F92AZDGXY55OZC73rVvB7IePrvNcLqUCPk98IAazkj5yj1bCiXpkq6gqpO
iAn3knawf45BP4lD8Yal6lejucnnMsbWhrvsEBOTnG5W61CQ41eS6XZaScqZdcfS
pibHXwG/6re54YGt4dPgwMOp6Bfwnd2nA4tWZcWkrowsOLNY5mE=
=7qpK
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
