Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C611C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0487220843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iKfT+qbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfHNHpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:45:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:50411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfHNHpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565768699;
        bh=WaUwZB8urvVG948whRzXPedtOy9zLbWOaIvo4IOnSXM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iKfT+qbsajQWRJXS6tU6c88gCLfCpVaMOPyIn/q+dhRRoGB3ckpCAe+rvRMkHFiNZ
         H7x3ajCaNN9H+UMzI7x0hyiyMcQr+B+ClFmSFcl8weOqA4hUOMxlIW82lLvxhv14fT
         VCCBo+3w+0YDZs6lgEYUoPVTUT/iw44YtfOAZMcw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkOeR-1iYEAy1qeJ-00cOG6; Wed, 14
 Aug 2019 09:44:59 +0200
Date:   Wed, 14 Aug 2019 09:44:40 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: fix boot failure with DEBUG_PAGEALLOC
 without KASAN.
Message-ID: <20190814074440.GI1966@latitude>
References: <8c83a4e1237658ed1acfb9a9891048a15f9ca36b.1565760495.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5lq+205vWdkqwtk"
Content-Disposition: inline
In-Reply-To: <8c83a4e1237658ed1acfb9a9891048a15f9ca36b.1565760495.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:wyxn0Wc5J5kp5Z+GclnMvwK33OhK308I1mfB8ka5lZnfMn/D6zH
 OnscyqIweg5eunew0cYK9tcc4f7dpYIUnqxgeEHzRiPb1esRj0Pdd2stcDywDm99Wt3dCC8
 STyRXCyWwsUiua9/L3bdpnncYy0IBd9ekhjYkpQ565vzvueP23h7/ANK9ZmZueN2LoJkZKQ
 KXhndwDzT5ijM3nNFZB1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:neJsRt2cxfg=:Lc60XBE/kqWVVXTtFhg/2x
 t8msVasIPAzjntLkj0iTeR+N9bINS+Ww05k+ETai6T4ojeaRMQckXH6Zfq9oRuxlZIdilJoA7
 wgc5rETnsfUbTHCmua149cZSGz38ttjY99lIDzJ+61UC0QBUvYGXgGGNJLwxHx4BdoWC96dxn
 hJ8gZkj8MAiCkwN3HVJ9wJxODzceTK70g0A+/6JN+zhTJHdrTNDUFDYyljU7/3nxH6c9QjoaH
 35pA6+XinF1PimCmXIr5sAApTFZNb/JeuCsSQLFqlCPBzc4spCCe/k83VpxUiBhUexWJEX3DT
 gO9IASUmJzPwgWcC/c4hdLQyzKijlhgIsaniNiWwdS3pVYWvnxVafy5LQxlI7lTZl5j3rkYbc
 oVIdWWOCbHemlADdW7f3B7k5KAPIOCnMxbAVAjYZldUJpM93ARWLuSja0yhHqfbLomx00Im2F
 c7edCfL3AAJ1yXPxHm9j2uu1/qU5Ud0XHYdpnqxSQeofW9QrjwWnBTZxah0Z/NRBNklWcXhmm
 KSZYDxHcL3by0E/Ejvq/XfP3mSmz81bNabYijwjTXvXmsvnp999wqShMvinVi8lH4iQKJO6QC
 pFvEO0ct29swJMMUq2CYmvF50w9NeuLU9RkhmkrA1r5HBwQbhHyRIG5nyCmkpwmXWa3omrhE4
 5L865pjZrSOq2YpK/hc4fAPgoMwZdd1/xdqfSBK7BQBqqkoiEQz8F71/UZG2b4LAVSmJhQtNC
 xFQfyzZ3Q1gDJqfoyYAkY+EY9RK6NQ4QR8nEkPZDzvv5tRra0F3gCIVQo9hmOhizqogEAJnaI
 515ZGAxp/oZqkqolkrXMxkaOKekLjW7d8EuZHE9QuHAmnjKHztSwP7xdTr0/UWwjp+B4vhAms
 bNF3vObH2PGMz/8Nh4Rh2QuE66k4lY1u386r5zMtS7CO8qr0/Ie5QYSZe6UA0afeQU95D+qmu
 dDoj8/k/2ksIpo+iw/kk0qZVk2oGJfb4ClTE6+LH4T92fEidzy4NkOV9AhXwvH2zhqQZYUsmD
 zFcCLurTw+/tx9Thk9EwOXnTAsjs6dQ+LI/wrQOiJavQdNlBQx1GtTzwMAuZPm9hcabLBFyoD
 vGlCl7cbwdAXClnx+9h8pqPM4NyJJLwmymOuLWrKXBYLwr/1hCuW8Vgqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5lq+205vWdkqwtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 05:28:35AM +0000, Christophe Leroy wrote:
> When KASAN is selected, the definitive hash table has to be
> set up later, but there is already an early temporary one.
>=20
> When KASAN is not selected, there is no early hash table,
> so the setup of the definitive hash table cannot be delayed.
>=20
> Reported-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
> Fixes: 72f208c6a8f7 ("powerpc/32s: move hash code patching out of MMU_ini=
t_hw()")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

Thanks. This does fix the DEBUG_PAGEALLOC-without-KASAN case.

Tested-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>

--r5lq+205vWdkqwtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl1Tu94ACgkQCDBEmo7z
X9uE2BAAy8A3Rc4+Bt+NtsfU5ntpwFsT7xUp4RlfKnMWZwTDC8GBh2NqaBrPJ5Ob
uMxgdv4pYpCB2JWQKEHerh7IWUUBE0BGyytakjrs5gSG5L1dIUNKO0x8tTv8Ew0Y
+8pY+eizv4V/fUPKLhoINKRVLlwWlZQs3r2A6Nw/uFpsR4l+nWPT5XNjIirrdsJO
afHYg52YyYpO/IhEI37+sGx0l94hY5y73twQs1nUc6MzEwFN+bp70PhbSHM1Bco1
Nwlxd1gCO4ArMQMlzKs0wMxja9paup6ZvZul6CcaxpJiH1L6DFVVejGVTpv3Yhvk
tw3yoAbfe3CywkqfBZFDuTanvkw3OS+ew1DD+3VcnclndyrB/OIwEohIEGC3XohD
Y3cSmE5NFPQ+HKE7M8XaTuvo7jliY85GWbl86WalK9wn9lmDlqKchaELkxYkCOMY
rf3oA3akchxEJgJygnlG30Y6r5FyrAMkePEq7ABmaFQatg0BnB/BKD0l+Bvxrisz
cmt4WoU9PIqohSucLALSiYBFOfATqP90Lw0SRBWTAeWI4ZPH6b9fb7LzBjf4550h
vZUHDq2tkk7LSXSxJZ8SJ300Ww/kFHWIZYzfrURyNIFKadx9HmBcP/Oa8ta95Ic1
cV907yOmw8T4rKHfSC75px4kz0+CJcl+urmHmSHwInZUogRMadY=
=pQtO
-----END PGP SIGNATURE-----

--r5lq+205vWdkqwtk--
