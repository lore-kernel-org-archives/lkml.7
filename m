Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C673FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E7A20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IHjgdsOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEBFst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:48:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:44929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfEBFss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556776125;
        bh=e97h7Oc+V3PzWYZf2aXC12eE1cAnqC2ASIoNjMs0snE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IHjgdsOq9ofWWDQqAuyujIO80DxHvUj0kHX3bUrW0Fmok2LmvpNdApOERYiLO8xqi
         A8xM+129JDA7J85F+hQUWLWSXM08BtU5pdoULjHLy7hceyfQD4xyxuScpF3u8E+RRE
         u6r1J4BMgbd+788keptQZz5IGgrEP2PmkAiG1kOg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.154.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1gw7Q23IAA-00jomi; Thu, 02
 May 2019 07:48:44 +0200
Subject: Re: linux-next: Signed-off-by missing for commit in the parisc-hd
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190502074519.61272b42@canb.auug.org.au>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
Date:   Thu, 2 May 2019 07:48:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502074519.61272b42@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IHQdC5p6ai1NPrnPei5omsyXdpU1jMhqJ"
X-Provags-ID: V03:K1:67sW+rL/niYAXbd/GQxVSM1nGSafXBOnOiZTciJmGXr+MtAK1ie
 5JChfChtwezWC6IbCbK/779/T/MvqFmJscLMgfOOpwW2m/8l14UyJ+BuSf0XknlkjW03X88
 FXNBTQtjdfKpndlha1wwE051gBQrFJMMbO85hkr4TPrUxqjQHdC4aYWWtKr1Pm7WZQrFGea
 D7Mh61PzazwnLBejlFlMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WrAke0Jlj7w=:r1JHH4efPlV0Cb1k7lZ4bc
 UgFoUsgf14tB0XWjcG78Bxxq01uKKsRBtULgRT58B06GPCpu2BpWBKbzrfSK5395LRnvLRvzF
 wnyp4qEuMdfKCtXBeaH/sJ34IZ3yno1h/g6x2hb5FPKjDOPx7L7xEJSougipfBtte4SJpEIlH
 cwWaJF/uLSB8VqmquprU8wwhdH1neH/qglGlyD25mxt5Ys8+z9ijQuJ14ilCKdSD4UQeQa7s+
 iKhXzczjslNYwRSaJhve/rS5s1uNWEriYcGOKq7CSVXoqGxfXy23HF9iXQNLho/eLBczF7W2U
 fNhrpLM6YtFnO4b67GqUEPI2zllWQcq07LJEkmiK09pg4D26oaLh3mgGOrYeXMChck0xjYqq9
 vc+mG7bGbCTyA366BZG16dMFvJMo6xEUCzgD0ezgPJXfWuJaewCjbfunBrYNnoFkv0+qKQUcY
 xfCc2peJNaFthIk8hiMZYj7SL0RZjkfdU5pRbECvC9dRKudLweei7BT35YHoVcVY/NPwNXg9N
 Etg4iWAfMI93HZyppCyYD2a3EgGYml2SEK4ryX7htMwY93KiY8UJFLYeVN7BCBR3ffHYMvMgn
 OZsSeAc9ewBEeqtfX0KrwaegBQ/81Dx945i7dQ9Dxgk80l1xN6E/Kca+0Ez2n6dUtP/LiXo5s
 hNO968+Y3wqJxXSYgJKTfKNU77P6Vf8X2v5mkirHDDH6mnmEZJTp59/zBvqDyPO34XrQxb4Tn
 tIj2jJ6SLmFrm44DTJzD4vwdB7ORqO8yykJd4dH1zKuYD+hAw6DxDzeMqXHX5mGlSQyCLA6vA
 qwn852E7v5HapGYEmEdOxzP2/+kXd15iv05KZQvTlKttrclhacpjcZE+cQCeF9oikD8BvYc89
 4R5dvOKmS4J6PXpXAKU9osZtE8xsXtppaMYV8yTCYdek8WmmmRTMPz4b2VhAss
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IHQdC5p6ai1NPrnPei5omsyXdpU1jMhqJ
Content-Type: multipart/mixed; boundary="C1TGjZwGUWBQWVPFWmHFWHOr2RqEe39YE";
 protected-headers="v1"
From: Helge Deller <deller@gmx.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Parisc List <linux-parisc@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the parisc-hd
 tree
References: <20190502074519.61272b42@canb.auug.org.au>
In-Reply-To: <20190502074519.61272b42@canb.auug.org.au>

--C1TGjZwGUWBQWVPFWmHFWHOr2RqEe39YE
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.05.19 23:45, Stephen Rothwell wrote:
> Commit
>   2b731a920986 ("parisc: Update huge TLB page support to use per-pageta=
ble spinlock")
> is missing a Signed-off-by from its committer.

Thanks. Fixed now.
Helge


--C1TGjZwGUWBQWVPFWmHFWHOr2RqEe39YE--

--IHQdC5p6ai1NPrnPei5omsyXdpU1jMhqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTPnDOmy1/TQodsisYgKkl43U+sXQUCXMqEuwAKCRAgKkl43U+s
XcYZAP9NTF3n2FZHZEYF5b0jMWIrXPfbPFaSt1Qo5OJea/Jn7wD+KXVgjkZohu/M
77SaaKd3negeywaSR6bXPj6XftKPIQg=
=DobL
-----END PGP SIGNATURE-----

--IHQdC5p6ai1NPrnPei5omsyXdpU1jMhqJ--
