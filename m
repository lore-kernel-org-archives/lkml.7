Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBB2C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACFD20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SBoocK3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfGJVif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 17:38:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJVif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:38:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kXcP6ft9z9sN6;
        Thu, 11 Jul 2019 07:38:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562794712;
        bh=xQ3HrnTRQwPLFyO/CnTD4dLIFe8+jtE4NPO9L/af/aM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SBoocK3KkGhnC3PxZLfoug8FLuVs0OMpscW/cFQr0/3c8AfEADJGNkX0+N6RkfUbj
         a6ppwgh2L8Ptl/FetHAHx7oKokCf2KFYzh/MWdqg7lTJU+a+Fh/9AEEtHTNpvWHMZW
         gCR+s76nHI2GSzJxAF50mYjPontAKJ8sT1vQ5sFrI+/8Rq+Sct7bgno5jc5rcfC16W
         BjBg6OBTL/PnrV5Fvxp1D0+520ZBizXuROLZuQf9wOF8Zlxb0Hv74GNjfuLhz4bVpw
         kUx7DVF1a35vx0fbX4u0nUbR9VpogwnJqf05E6micr3RnSuk94v8OpKPXlmVI04LXy
         NTg0BRD3/Zi/w==
Date:   Thu, 11 Jul 2019 07:38:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Sage Weil <sage@newdream.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20190711073828.063b534c@canb.auug.org.au>
In-Reply-To: <CAOi1vP8wsFDzmdwHw8HwvuycPnOChAjzAOLgajLHqxMadoWojQ@mail.gmail.com>
References: <20190709165459.11b353d8@canb.auug.org.au>
        <20190710100138.0aa36d47@canb.auug.org.au>
        <CAOi1vP8wsFDzmdwHw8HwvuycPnOChAjzAOLgajLHqxMadoWojQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qMqdXEy7FW0l3m2Xb.djr01"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qMqdXEy7FW0l3m2Xb.djr01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

On Wed, 10 Jul 2019 20:21:33 +0200 Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Yes, that is what I figured would happen.  I assume you would keep
> carrying this fixup until the ceph tree is merged.

Of course.

--=20
Cheers,
Stephen Rothwell

--Sig_/qMqdXEy7FW0l3m2Xb.djr01
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0mWtQACgkQAVBC80lX
0Gza1gf/aerGthD0YS4W/eCgBMMyml2K3lFzn8K5fWlvZymUolz/n6JTDNh6yR/n
MU/9KsdNWl918aEBX1k3ioCtHTxDvbKtRsN76pxsZktEJXLCR7N78bFCN6x4UYTX
09K5PCYPnh/nkMuFnecjx5w+fYtCsv2CjnM0BwcydcPSAGMZtkWqjWrzjMulYqeO
Jc149ERGJF1JNVD7ZCyw7xtUsYdLKkYBL00nhn1usVRD+ygNC9a/f90TcZykbOn9
R0jIbFBsjZfV4m3od3sN0f6jt0iHvyNJhDswDZ9qlMoRIYVaThse0vJrDwZTgwyL
3C2wVLBc2qZ6t7DQmY6GRX0EApJU6w==
=bauX
-----END PGP SIGNATURE-----

--Sig_/qMqdXEy7FW0l3m2Xb.djr01--
