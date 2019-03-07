Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F56C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B8F20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfCGKNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:33 -0500
Received: from sauhun.de ([88.99.104.3]:50932 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfCGKNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:31 -0500
Received: from localhost (p54B334C5.dip0.t-ipconnect.de [84.179.52.197])
        by pokefinder.org (Postfix) with ESMTPSA id 1F8F12E3551;
        Thu,  7 Mar 2019 11:13:28 +0100 (CET)
Date:   Thu, 7 Mar 2019 11:13:27 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: davinci: remove extraneous __init annotation
Message-ID: <20190307101327.hs3evq4hv6i4bdvu@katana>
References: <20190307101024.594587-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2cja6kbcvwnu3gnt"
Content-Disposition: inline
In-Reply-To: <20190307101024.594587-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2cja6kbcvwnu3gnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:10:11AM +0100, Arnd Bergmann wrote:
> Building with clang finds a mistaken __init tag:
>=20
> WARNING: vmlinux.o(.text+0x5e4250): Section mismatch in reference from th=
e function davinci_mmcsd_probe() to the function .init.text:init_mmcsd_host=
()
> The function davinci_mmcsd_probe() references
> the function __init init_mmcsd_host().
> This is often because davinci_mmcsd_probe lacks a __init
> annotation or the annotation of init_mmcsd_host is wrong.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--2cja6kbcvwnu3gnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyA7sIACgkQFA3kzBSg
KbZjDA/+My5zSwY80FAs1DuuLQiD/w+094gAyjoRHuPuB7rL50q/7BYOqhngvF5C
73UEqW5dK4USmwJKiVPkAYUEeuASoZaMj/QIFsQ6SYrQb76iORg1VIybPQDxkoEP
gblMThfKd68W241OB+JncbdnM6ALmezU/Iz3/BU0GH3jkwJZ0MLP0nBiz/tt1+/8
O0XFUhfrV1L29pUnjzoVz99YnagquVrjlnkLb51ggESV+FPx03ZDoBdDGMW3XPVO
efe/qGDNt6v56vDJnQghT/571o024CuDCSFhqTLiHyaqLIaG6SA7dNzxZWildE70
5RgdXvQAhO6eUC0u8U/714gfVQ4IYxTtYX5NyA+aF0aY6s2O9I1kmLM08zmxB1oL
SJ9S2p1F5ng1M1hpdnBbK5T+LjfTnqayR63Jy15iR03eqS9hjp2qadVkexkebibS
JmFBP70A9aoPBswhlfyG1NsHgHWUTKFdJoQYaqfe4CLnILRSAjHPtSwo94U1i+kq
kilN871gOxuEI89Z5KixzICge2k8Oujfrlq3qix4axTO/mFhiw9Bqj6KrWquJQzZ
1SKqTj7tF9LuznIxC2qw5htk4/E1EPP74k8zOSWSqqTiG/PftqmlVYZgoqWsnMEk
557VePLqA9UiLl+B9iPYPVfNfk52qnKFzMKwO0H7V3gBeqAPYmk=
=WY7N
-----END PGP SIGNATURE-----

--2cja6kbcvwnu3gnt--
