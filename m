Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BE7C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F3122CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567408245;
	bh=nI1FQ+yp2NSHESE6VHXqC+vG7vvMeihbXOq9nd7cT1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f+CyEelD01pOAWHuIZiiWFjJ5U2hwFnTlkMgJ/yVwxNWqkF4Ko3dUZ60oHeBRyX2I
	 /dpySEAYSnDBld9F8NUdm5mAnhrguH9X6RxCc0cSyYqdIVhNx9lQTCalNATcPHs6rO
	 lEP29Kj9hpokwzMud+9NFSFkXb+DwZU5mpKT7wO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfIBHKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbfIBHKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:10:44 -0400
Received: from earth.universe (dyndsl-091-096-044-124.ewe-ip-backbone.de [91.96.44.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19537214AE;
        Mon,  2 Sep 2019 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567408243;
        bh=nI1FQ+yp2NSHESE6VHXqC+vG7vvMeihbXOq9nd7cT1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWSlnzTBSy/PPFqJDIHARHDU+/BQEYEqj4GPMQrIhDr+kNWLJ+49QGkdtq7YbhXyx
         L5a9DSxXXfztFm8QOvGrNo5hCpoTOup76ASYdaRF+/qBkzeugjCqizMogWx4OHXDu8
         zxxFH2Am9/paHJQr11iJcNbnrm711xcwONt29Qh4=
Received: by earth.universe (Postfix, from userid 1000)
        id 19BF63C0B7F; Mon,  2 Sep 2019 09:10:41 +0200 (CEST)
Date:   Mon, 2 Sep 2019 09:10:41 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Nosthoff <committed@heine.so>
Subject: Re: linux-next: Fixes tag needs some work in the battery tree
Message-ID: <20190902071041.ukvc64tg5tjttk6w@earth.universe>
References: <20190902093131.06f66c9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wm7d4y7wvhwlmzhu"
Content-Disposition: inline
In-Reply-To: <20190902093131.06f66c9f@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wm7d4y7wvhwlmzhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Mon, Sep 02, 2019 at 09:31:31AM +1000, Stephen Rothwell wrote:
> In commit
>=20
> b19aca4eb2d2 ("power: supply: sbs-battery: only return health when batter=
y present")
>=20
> [...]
>=20
> Please do not split Fixes tags over more than one line.

I have fixed this and rebased the branch, so the issue should be
gone tomororw. Thanks for the notice,

-- Sebastian

--wm7d4y7wvhwlmzhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1swG0ACgkQ2O7X88g7
+ppgvw/+P6KS+HyVyg/uxc5+sXrC0VTxIZO+rYG2qFhMOO23u7dguRaQw0GreVms
BoKEzxxVN/siZ0R95gUxAnnd8N9vMDdXXVvDBT2QD21HuEcKthM+fvrNYlZg70u5
ZYDiTGfY+AIga+O113n3047P8vo26QpljbPP7K8slmemSoxfxgCjH7/Ccq1afYUk
AZwyzGJ18OTvdqkFqt6/x5RzmKs1hb58BrlfZoZIsbA1zGghAk4C5lznSTOYobZi
IoX783RA/gkjbOKGKSND7NrajjHf0vaps0rfgf3X/+f+fpiOIuOhuVlXfRHtMuMS
Nxtcb2/KhI60rTNnMVgpl2QUWN4Lab4rBebDjqGm8U30v8tgTzGJzX2qs6N9jFhE
FVv1bh3/SVAcB36Zsl7i4oYJ/ttNzeuo06pP/aL30y4TfwsNEnBhKhUdonQ4/36i
qN5hHfzHziRXQi/C7lT2fsmGMufzpLUuF13GNPL1S+T9OVHwF73YbUQ3GzZ9oqaI
HgGvFBDeP290u5sPHgdQ3gZ4hslmcQfHiHpCSylVfcHJ3IYjy3q+Zi+pipMUZMXT
dPPqYuEhN0TnIB1QJA11rFhqtdXenG7VDWWG0ijsWAZAUni4GljKue/6O6f48dMD
e8J5hazgLbbYMsxVed11d1QoDdhKaAx4cCNuxBk2wbr0BqPzgrM=
=M2sM
-----END PGP SIGNATURE-----

--wm7d4y7wvhwlmzhu--
