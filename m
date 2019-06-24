Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21D3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1BB2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AU3Bg7yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfFXLLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:11:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35711 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbfFXLLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:11:40 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190624111138epoutp02368236491a1ff98bccba731e3dd21ebb~rHgPv18pU1104411044epoutp02S
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:11:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190624111138epoutp02368236491a1ff98bccba731e3dd21ebb~rHgPv18pU1104411044epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561374698;
        bh=0ipUsXhHHvkzImu9lVdNjb311YCAGiFs18/62Vk99mM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=AU3Bg7yHnBtJlmVI+It317fNYZ1N4n3lX2Oz9yRR6a78Fn9zqz6qlUmQ2c6Jv2ew9
         zdK+PJP3lPto4RAOeZ/KE44Dp8d1YSQT5z9fGGs2ObVd09aoh27Ik7G2WCzws+0qya
         U0tLc/I3pNIc/meKuq/AQIgJ5kNYzYmtTKC9kxVQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190624111135epcas1p3fddcc03adb0b79dfed24372b1c9a1ee1~rHgNTYg1M1149611496epcas1p3F;
        Mon, 24 Jun 2019 11:11:35 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-bc-5d10afe7e825
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.1C.04139.7EFA01D5; Mon, 24 Jun 2019 20:11:35 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <37db00bc-3a22-d1c2-7bdc-e27af42cd5c7@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190624111134epcms1p361aed3c72edd6eebc95408331c8d9739@epcms1p3>
Date:   Mon, 24 Jun 2019 20:11:34 +0900
X-CMS-MailID: 20190624111134epcms1p361aed3c72edd6eebc95408331c8d9739
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmge7z9QKxBu8fSFpc//Kc1WL1x8eM
        Fi2zFrFYXN41h83ic+8RRovOL7PYLH7umsfiwO6xc9Zddo/e5ndsHn1bVjF6fN4kF8ASlW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE748Ps
        VywFv9kqJl77z9zAeImti5GTQ0LAROLqwmMsILaQwA5Gid0v3LoYOTh4BQQl/u4QBgkLC7hJ
        bLv2G6pESaLh5j5miLi+RMeDbYwgNpuArsTWDXfBakQE1CSWH/3D2sXIxcEscJpJYvPan1C7
        eCVmtD9lgbClJbYv3wrWzClgK9Ez+xYjRFxU4ubqt+ww9vtj86HiIhKt984yQ9iCEg9+7maE
        mTNjyn+omdUS16YvZgdZLCHQwijRu3oKVJG+xJm5J8GO4BXwlTi68RXYIBYBVYnGnb+glrlI
        bJi1GizOLKAtsWzha2ZQQDALaEqs36UPUaIosfP3XEaIEj6Jd197WGH+2jHvCROErSZxaPcS
        qJEyEqenL4S62UPixYl94EAREuhhkphw6x3zBEaFWYiwnoVk8yyEzQsYmVcxiqUWFOempxYb
        Fhgix+4mRnBq1DLdwTjlnM8hRgEORiUeXoEN/LFCrIllxZW5hxglOJiVRHiXJgrECvGmJFZW
        pRblxxeV5qQWH2I0BQbARGYp0eR8YNrOK4k3NDUyNja2MDE0MzU0VBLnjee+GSMkkJ5Ykpqd
        mlqQWgTTx8TBKdXAmOTlamte1jz1sfyCK7fczp4+eORi53+5c5Oktqy74Zf0Tm+6y7k9TbPf
        VZt2rNQ817uxQmmKyvP7i5QvmOWuTjIUteTdbHGyT6O3eaPQnMlm7Tz2FyUETQr0TTvDDfUc
        pZoPhisuCNztlJ8u+cq1aK/KbOl223+lsl4rM3lW+Ttci71qL9qmxFKckWioxVxUnAgAW3CX
        7KMDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f
References: <37db00bc-3a22-d1c2-7bdc-e27af42cd5c7@gmail.com>
        <20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
        <20190624073414epcms1p87b6dc13758b6bd401d275cfba583314a@epcms1p8>
        <CGME20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
>--------- Original Message ---------
>Sender : Dmitry Osipenko <digetx=40gmail.com>
>=20
>24.06.2019 10:34, MyungJoo Ham =D0=BF=D0=B8=D1=88=D0=B5=D1=82:=0D=0A>>>=0D=
=0A>>>=20A=20question:=0D=0A>>>=0D=0A>>>=20Does=20this=20driver=20support=
=20Tegra20=20as=20well?=0D=0A>>>=20I'm=20asking=20this=20because=20ARCH_TEG=
RA=20includes=20ARCH_TEGRA_2x_SOC=0D=0A>>>=20according=20to=20/drivers/soc/=
tegra/Kconfig.=0D=0A>>>=0D=0A>>=20=0D=0A>>=20For=20this=20matter,=20how=20a=
bout=20updating=20your=2013/16=20patch=20as=20follows?=0D=0A>>=20=0D=0A=5B=
=5D=0D=0A>=20=0D=0A>Good=20call=21=20I'll=20update=20this=20patch=20followi=
ng=20yours=20suggestion,=20thanks.=0D=0A=0D=0AOr,=20you=20may=20approve=20t=
he=20modified=20commits=20here:=0D=0Ahttps://git.kernel.org/pub/scm/linux/k=
ernel/git/mzx/devfreq.git/log/?h=3Dfor-next=0D=0A=0D=0A=0D=0ACheers,=0D=0AM=
yungJoo=0D=0A
