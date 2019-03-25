Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE015C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAA620989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GQg/m4Q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCYEjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:39:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55444 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCYEjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:39:01 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190325043858epoutp027f2041e41b9480fdc0b735e9891970c5~PGcbyb3_d1767517675epoutp02J
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 04:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190325043858epoutp027f2041e41b9480fdc0b735e9891970c5~PGcbyb3_d1767517675epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553488738;
        bh=D4C3Kkwvt4YLTwTnWr8U7+hUJLRWvFCoSXRdkCdauHs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=GQg/m4Q4xu52daNsdhYHnFaVLClSeJk4xYoaCYfrrw3C0USqvNaW2FZMU3pKw6kwz
         oUz9emBd0yRSEioibEgU70hu+sgqWfxJ6dsRT624tq2bzV39iGTlrAWEoLID9JE8ML
         beedhSLqmRx7C8apzkHoghYcwbaS0l53vOz1U/nc=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190325043854epcas1p27a4349fcd8089e4a28652f9ad93c0ae1~PGcYP4Fj42606726067epcas1p28;
        Mon, 25 Mar 2019 04:38:54 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-d1-5c985b5bb63a
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.90.04142.B5B589C5; Mon, 25 Mar 2019 13:38:51 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] PM / devfreq: exynos-bus: Suspend all devices on
 system shutdown
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <f41be303-0159-0730-501b-f465a1418861@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190325043850epcms1p7c55d5c6767779f4dc044118975cff560@epcms1p7>
Date:   Mon, 25 Mar 2019 13:38:50 +0900
X-CMS-MailID: 20190325043850epcms1p7c55d5c6767779f4dc044118975cff560
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmrm509IwYg1+t/BYbZ6xntXh5SNPi
        +pfnrBbnz29gt7jVIGNxedccNovPvUcYLWac38dk8fLID0aLtUfusjtwedy6U++xaVUnm8fB
        d3uYPPq2rGL0+LxJLoA1KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWle
        ul5yfq6VoYGBkSlQYUJ2xt3Z11gKFkpU3F3n2cB4QLyLkZNDQsBE4v++X0xdjFwcQgI7GCUu
        zf/O2MXIwcErICjxd4cwSI2wQLTEw8eHGEFsIQEliYab+5gh4voSHQ+2gcXZBHQltm64ywIy
        R0RgDpPEg6ZdbCAOs8BWRomTdy+zQGzjlZjR/hTKlpbYvnwrWDengL3Er4vrmSDiohI3V79l
        h7HfH5vPCGGLSLTeO8sMYQtKPPi5mxFmzowp/6FmVktcm76YHWSxhEALo0Tv6ilQRfoSZ+ae
        ZAOxeQV8JeZsOwa2gEVAVeLMl1Y2iBoXiabLM8EGMQtoSyxb+JoZFBLMApoS63fpw9zfsPE3
        OzqbWYBP4t3XHlaY+I55T6B+UZM4tHsJVL2MxOnpC6Hu95DYNvMu0wRGxVmIsJ6FZPEshMUL
        GJlXMYqlFhTnpqcWGxYYIcfuJkZw8tQy28G46JzPIUYBDkYlHl6HPdNjhFgTy4orcw8xSnAw
        K4nwPhGdESPEm5JYWZValB9fVJqTWnyI0RTo/4nMUqLJ+cDEnlcSb2hqZGxsbGFiaGZqaKgk
        zrvewTlGSCA9sSQ1OzW1ILUIpo+Jg1OqgdFN9vx987j/2fnfg3873oxa68qgtjv0kmdI1gad
        5ZrNe57YsGxm5J2zQ2NCiGvrweaV+p92nPj28pif/3KGhXOf6czSP/v/TsKhO5vn5K8TVd3L
        +en2v606utXKG5+tSjn/6phvZNURuavt8x45P3roHxRX/Lla3adU7Z9VSoeg1ZL9TdccagWV
        WIozEg21mIuKEwE1TomYtAMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b
References: <f41be303-0159-0730-501b-f465a1418861@samsung.com>
        <20190321090110.26506-1-m.szyprowski@samsung.com>
        <c2b39c36-a2f4-282e-1145-c61cfa18c6ce@samsung.com>
        <CGME20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b@epcms1p7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Chanwoo,
>
>On 2019-03-21 10:19, Chanwoo Choi wrote:
>> On 19. 3. 21. =EC=98=A4=ED=9B=84=206:01,=20Marek=20Szyprowski=20wrote:=
=0D=0A>>>=20Force=20all=20Exynos=20buses=20to=20safe=20operation=20points=
=20before=20doing=20the=20system=0D=0A>>>=20reboot=20operation.=20There=20a=
re=20board=20on=20which=20some=20aggressive=20power=20saving=0D=0A>>>=20ope=
ration=20points=20are=20behind=20the=20capabilities=20of=20the=20bootloader=
=20to=20properly=0D=0A>>>=20reset=20the=20hardware=20and=20boot=20the=20boa=
rd.=20This=20way=20one=20can=20avoid=20board=20crash=0D=0A>>>=20early=20aft=
er=20reboot.=0D=0A>>>=0D=0A>>>=20This=20fixes=20reboot=20issue=20on=20Odroi=
dU3=20board=20both=20with=20eMMC=20and=20SD=20boot.=0D=0A>>>=0D=0A>>>=20Rep=
orted-by:=20Markus=20Reichl=20<m.reichl=40fivetechno.de>=0D=0A>>>=20Signed-=
off-by:=20Marek=20Szyprowski=20<m.szyprowski=40samsung.com>=0D=0A>>>=20---=
=0D=0A>>>=20This=20is=20an=20alternative=20to=20https://patchwork.kernel.or=
g/patch/10781433/=0D=0A>>>=20limited=20only=20to=20Exynos-bus=20driver.=0D=
=0A>>>=20---=0D=0A>>>=20=20=20drivers/devfreq/exynos-bus.c=20=7C=208=20++++=
++++=0D=0A>>>=20=20=201=20file=20changed,=208=20insertions(+)=0D=0A>>>=0D=
=0A>>>=20diff=20--git=20a/drivers/devfreq/exynos-bus.c=20b/drivers/devfreq/=
exynos-bus.c=0D=0A>>>=20index=20c25658b26598..486cc5b422f1=20100644=0D=0A>>=
>=20---=20a/drivers/devfreq/exynos-bus.c=0D=0A>>>=20+++=20b/drivers/devfreq=
/exynos-bus.c=0D=0A>>>=20=40=40=20-514,6=20+514,13=20=40=40=20static=20int=
=20exynos_bus_probe(struct=20platform_device=20*pdev)=0D=0A>>>=20=20=20=09r=
eturn=20ret;=0D=0A>>>=20=20=20=7D=0D=0A>>>=20=20=20=0D=0A>>>=20+static=20vo=
id=20exynos_bus_shutdown(struct=20platform_device=20*pdev)=0D=0A>>>=20+=7B=
=0D=0A>>>=20+=09struct=20exynos_bus=20*bus=20=3D=20dev_get_drvdata(&pdev->d=
ev);=0D=0A>>>=20+=0D=0A>>>=20+=09devfreq_suspend_device(bus->devfreq);=0D=
=0A>>>=20+=7D=0D=0A>>>=20+=0D=0A>>>=20=20=20=23ifdef=20CONFIG_PM_SLEEP=0D=
=0A>>>=20=20=20static=20int=20exynos_bus_resume(struct=20device=20*dev)=0D=
=0A>>>=20=20=20=7B=0D=0A>>>=20=40=40=20-556,6=20+563,7=20=40=40=20MODULE_DE=
VICE_TABLE(of,=20exynos_bus_of_match);=0D=0A>>>=20=20=20=0D=0A>>>=20=20=20s=
tatic=20struct=20platform_driver=20exynos_bus_platdrv=20=3D=20=7B=0D=0A>>>=
=20=20=20=09.probe=09=09=3D=20exynos_bus_probe,=0D=0A>>>=20+=09.shutdown=09=
=3D=20exynos_bus_shutdown,=0D=0A>>>=20=20=20=09.driver=20=3D=20=7B=0D=0A>>>=
=20=20=20=09=09.name=09=3D=20=22exynos-bus=22,=0D=0A>>>=20=20=20=09=09.pm=
=09=3D=20&exynos_bus_pm,=0D=0A>>>=0D=0A>>=20Actually,=20I=20already=20agree=
d=20the=20previous=20patch.=0D=0A>>=20Also,=20it=20looks=20good=20to=20me.=
=0D=0A>=0D=0A>Yes,=20I=20know,=20but=20MyungJoo=20had=20some=20objections,=
=20that's=20why=20I=20prepared=20=0D=0A>alternative=20version.=0D=0A>=0D=0A=
>>=20Acked-by:=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A>>=0D=0A=
=0D=0AThis=20has=20become=20looking=20good=20now=20:)=0D=0A=0D=0A=0D=0AAcke=
d-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0A=0D=0AChee=
rs,=0D=0AMyungJoo=0D=0A
