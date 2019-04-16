Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4EFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1870B206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YfTS3ZcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfDPV5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:57:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:39583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPV5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555451860;
        bh=aHw5y8qd8Mk3FlsLP7KGOjmmhB00qlgFp9xq8oPc3iE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YfTS3ZcEY9nc6qdKEvsx3kD8/DaN3/ypX1A2Y7YM0dStXi0fJF2KKb4uEb2X7Dc3+
         y8Z7WTXN72LauXMXXDnB86f8v7d1lW92A7G6Vw9yOXLbUECHSCnxzlpZNj5TuebFzl
         3iFf6VpR997iNwzx+bM0H2e5oFIwRxhaY9MG5EFY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpbfG-1gbPtq04Ig-00fUKb; Tue, 16
 Apr 2019 23:57:40 +0200
Date:   Tue, 16 Apr 2019 23:57:38 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     kernel-doc@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 2/2] docs/zh_CN: fix typos in 1.Intro.rst file
Message-ID: <20190416215738.GC11536@latitude>
References: <20190416022825.187932-1-alex.shi@linux.alibaba.com>
 <20190416022825.187932-2-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <20190416022825.187932-2-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:lty/SQgik6raNskLv70/ES5ByEX/V9HX9bUgVgleA9jUN1FD+cp
 9lMXlJi+I7S8TBmss7MKTP8AE7xVaNc0qJJqxf1mOhbFtG1TGVpCicYzFHXNfaRSD0D5kRl
 YSZ7Xg7vsFtykVMqQYzIW+PZB+uufVnVywjOAX5MxCrcLN2CS5O1kds5hmEuAqWzLLsWv75
 RDg0BzZGXgl8qp2+EO9vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M/02r5MQdBM=:5ZtfHA+6tden0/+f9zaeZz
 c1itR+6tKQq7pPeuNuYg+IpEJBNb4xovYTg3tM8DQcvbyhDx5KGl0IPAJnSqi3olFf+hj7u8u
 4e+86U1Sd/EPDnl5vvL3kqzneXzNZm3S0K869IT7Trlquc5joZL631Yw5Okry77qrIJL1eWkM
 oBxaGLT1ROhO7xj7YEvXcgDPqcKQHZI7PCflbVReA92OERjy7J3OxdX97lKEC3BpcXfgaG1ub
 PeqAVZoiswOjee9A9jIZ+2mHeUdCKan0RK8QRWiMS+vtuZmFNkFN2h0EQhByFKOIkFncPD3j8
 67qwAHBni1bQHYLcvJdGEMYQ5rdPlKTOOEcJHq0b9p8nEO77fEYGOs/C2Cp5fz4iBctndEBRZ
 Zs5dDIOS3wAvEIugCi4qvemb2lC1hZd/Hb2P8Ob2KqlaJAkIoBMO8w0bX6MbydHveP3QqWexm
 WoGyfz3MN5Y3WjYOLH9EGzVy+tRsxbRqVnRHVWe+s/C8+0mX52oqZqsZcfx4EZXf59+jPZ6x3
 +pmk2TmDsFC21eZGgW3PP4xba2VQJl1Ar1P30HySCdTXNYTu158IabLfPeMaJuMRrc155+YaA
 T8dGpulab2McNjyvu7azECjYTDh7SMZWwH/Oqr0n/YQNK7P8v7V/4+yo/RvRrVoMyfH4Ucfeb
 I3NfP/34Lx7fkTsSlzq5ivPzFvE84d6XGjmjEm5epADt3sJqqZ9sMG7TYxlhUoMtvcQ4/9PVz
 MgrhgirSZwswnhqHKpXUwEcd9+uf/bPs7Huon3kzMqwu3hiEsL4TQ2Hrv3VLzSLTg/IYsdbQx
 ZgJv5oukBpZy8YOxNbRpGaWIbpf26mcjvTvidXH5LXJz0vnEOk2IfA5CwTrNJ/UnLuoIBG2+3
 rPwTSuzMlH/m4bWKanc5TyfBL4aAO8Si3fg0ScwqWSQGyX0Tf6gLcTXr9SHLfK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 10:28:25AM +0800, Alex Shi wrote:
> Fixed uncapital issues, thanks for Jonathan Neusch=C3=A4fer, I am insensi=
tive
> on captial custom as a non-captial native language reader. Sorry.

No problem!

> diff --git a/Documentation/translations/zh_CN/process/1.Intro.rst b/Docum=
entation/translations/zh_CN/process/1.Intro.rst
> index 03bbafc00bd2..10a15f3dc282 100644
> --- a/Documentation/translations/zh_CN/process/1.Intro.rst
> +++ b/Documentation/translations/zh_CN/process/1.Intro.rst
> @@ -79,13 +79,13 @@ Linux=E6=9C=80=E5=BC=95=E4=BA=BA=E6=B3=A8=E7=9B=AE=E7=
=9A=84=E7=89=B9=E6=80=A7=E4=B9=8B=E4=B8=80=E6=98=AF=E8=BF=99=E4=BA=9B=E5=BC=
=80=E5=8F=91=E4=BA=BA=E5=91=98=E5=8F=AF=E4=BB=A5=E8=AE=BF=E9=97=AE=E5=AE=83=
=EF=BC=9B=E4=BB=BB=E4=BD=95
>  =E8=87=B4=E8=B0=A2
>  ----
> =20
> -=E6=9C=AC=E6=96=87=E4=BB=B6=E7=94=B1jonathan corbet=E6=92=B0=E5=86=99=EF=
=BC=8Ccorbet@lwn.net=E3=80=82=E4=BB=A5=E4=B8=8B=E4=BA=BA=E5=91=98=E7=9A=84=
=E5=BB=BA=E8=AE=AE=E4=BD=BF=E4=B9=8B=E6=9B=B4=E4=B8=BA=E5=AE=8C=E5=96=84=EF=
=BC=9A
> +=E6=9C=AC=E6=96=87=E4=BB=B6=E7=94=B1Jonathan Corbet=E6=92=B0=E5=86=99=EF=
=BC=8Ccorbet@lwn.net=E3=80=82=E4=BB=A5=E4=B8=8B=E4=BA=BA=E5=91=98=E7=9A=84=
=E5=BB=BA=E8=AE=AE=E4=BD=BF=E4=B9=8B=E6=9B=B4=E4=B8=BA=E5=AE=8C=E5=96=84=EF=
=BC=9A

For this part of the patch:

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


Thanks.

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAly2T8sACgkQCDBEmo7z
X9u+Rw/8Cc3DM2VGnAOu/tpAYarGoB/hTGxa2H3e9RKaIQp2h7CDrximQqfKhcaL
O/ZoYiK+hd3j7p1Pskg6A3q0swkOZR9TNzrjd7ecnMvlpHFOPD93sIZhqNCVx2kx
+0rJZ9DBV9S3yJH5YIybM/FoQf8C0jCV/K89vnLH+bl+XH0yONudYK4LyhtN6I2W
IaOadCZngy9SMvUWehcbwBj8jySnF+i53o/cwG+voBssjSDid6WpdFKLeHyEVJFW
U2N+U+WDYkfCNOxyKNsR0v7uzvT4tYLRdfyOmYpjTs+IoE59fOp7AkW9muLqrYe5
VgebWImKRqJWuBMKTXJg0nCEeaCaMfaCiMaXXrOoD7bupanF/1YySbpiTn0Euu1j
js42VXl83glwe3pDMHnUBQiYxG/RMJyBKrgE5tI7dJVMsumSd75JaIZ9UmiUy+FZ
pMH1n5ExKo8e4gyuV5uCfaYddWZ59ozhOaa9F016MDAtLtp9GNMlL6B+q4ax47H7
RWX6vJnW3yTa39qxsURbHyCRVaiZ8GxOd84SB7qzx+8PXg7fhthC46EFDehbRrLO
Hcmq635oo2dyzRFQwAtTRVfl+pLvUEXoWALBKpXRWWNekKsIBOG7WSvTnJJ7pHMz
8kYAZreCkjVwJBZb/oNmJNYuZWJq1bFC9WoXWSNK2JIMjglXMPo=
=9oLG
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
