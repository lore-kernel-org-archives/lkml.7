Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB6C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409622186A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="De4qybQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfHSF3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:29:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24938 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbfHSF3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:29:24 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7J5PhoM022044;
        Mon, 19 Aug 2019 07:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=IFWskdJXLKwleUudMDd+NKJV0RuMLXPFxrqVuDJPNvQ=;
 b=De4qybQn59MQdVjM1t9iBOTihvxwBtPnNtvPK/68Zu13qudr9wbfqf7ju42MgtmtJ5bI
 mFNXaiet+NpdiUaJ3Q4No8ef1Dr/d0ubNCvUTVUj3insESmM1+PLTz2/86/a5dGRI5i/
 Z2l1btE5WKgCT5rlupk5sMdz8fJwECksy+xmihyR4cVrn1YuW7bjiTyqVRJqp+m432Wp
 sfy2XV1C45RCqdxBmURAUWo1daC2GgfovLtav28muQkz5Ac+rnGUz46EYrpCeXU6aGfU
 6zJmNiDRi4YZJ3OsEMyvTvyAb8fi+necBq9vsSOhqCptX6tlcJFimlu09KYGFNYfTKsm Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ue6q8h9m7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 19 Aug 2019 07:29:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B58334;
        Mon, 19 Aug 2019 05:29:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node3.st.com [10.75.127.12])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7173621FDE4;
        Mon, 19 Aug 2019 07:29:06 +0200 (CEST)
Received: from SFHDAG4NODE2.st.com (10.75.127.11) by SFHDAG4NODE3.st.com
 (10.75.127.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 07:29:06 +0200
Received: from SFHDAG4NODE2.st.com ([fe80::4457:45af:aece:883f]) by
 SFHDAG4NODE2.st.com ([fe80::4457:45af:aece:883f%20]) with mapi id
 15.00.1473.003; Mon, 19 Aug 2019 07:29:06 +0200
From:   Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH -next] clk: st: clkgen-pll: remove unused variable
 'st_pll3200c32_407_a0'
Thread-Topic: [PATCH -next] clk: st: clkgen-pll: remove unused variable
 'st_pll3200c32_407_a0'
Thread-Index: AQHVVFkdhAo7dZyXGkmyal/JL4pFW6cB9U/p
Date:   Mon, 19 Aug 2019 05:29:06 +0000
Message-ID: <1566192546052.96439@st.com>
References: <20190816135523.73520-1-yuehaibing@huawei.com>,<20190816173613.491082086C@mail.kernel.org>
In-Reply-To: <20190816173613.491082086C@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Gabriel Fernandez <gabriel.fernandez@st.com>=0A=
________________________________________=0A=
From: Stephen Boyd <sboyd@kernel.org>=0A=
Sent: Friday, August 16, 2019 7:36 PM=0A=
To: YueHaibing; allison@lohutok.net; gregkh@linuxfoundation.org; mturquette=
@baylibre.com; Gabriel FERNANDEZ=0A=
Cc: linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org; YueHaibing=0A=
Subject: Re: [PATCH -next] clk: st: clkgen-pll: remove unused variable 'st_=
pll3200c32_407_a0'=0A=
=0A=
Quoting YueHaibing (2019-08-16 06:55:23)=0A=
> drivers/clk/st/clkgen-pll.c:64:37: warning:=0A=
>  st_pll3200c32_407_a0 defined but not used [-Wunused-const-variable=3D]=
=0A=
>=0A=
> It is never used, so can be removed.=0A=
>=0A=
> Reported-by: Hulk Robot <hulkci@huawei.com>=0A=
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>=0A=
> ---=0A=
=0A=
Adding Gabriel, please ack/review.=0A=
=0A=
>  drivers/clk/st/clkgen-pll.c | 13 -------------=0A=
>  1 file changed, 13 deletions(-)=0A=
>=0A=
> diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c=0A=
> index d8a688b..c3952f2 100644=0A=
> --- a/drivers/clk/st/clkgen-pll.c=0A=
> +++ b/drivers/clk/st/clkgen-pll.c=0A=
> @@ -61,19 +61,6 @@ static const struct clk_ops stm_pll3200c32_ops;=0A=
>  static const struct clk_ops stm_pll3200c32_a9_ops;=0A=
>  static const struct clk_ops stm_pll4600c28_ops;=0A=
>=0A=
> -static const struct clkgen_pll_data st_pll3200c32_407_a0 =3D {=0A=
> -       /* 407 A0 */=0A=
> -       .pdn_status     =3D CLKGEN_FIELD(0x2a0,   0x1,                   =
 8),=0A=
> -       .pdn_ctrl       =3D CLKGEN_FIELD(0x2a0,   0x1,                   =
 8),=0A=
> -       .locked_status  =3D CLKGEN_FIELD(0x2a0,   0x1,                   =
 24),=0A=
> -       .ndiv           =3D CLKGEN_FIELD(0x2a4,   C32_NDIV_MASK,         =
 16),=0A=
> -       .idf            =3D CLKGEN_FIELD(0x2a4,   C32_IDF_MASK,          =
 0x0),=0A=
> -       .num_odfs =3D 1,=0A=
> -       .odf            =3D { CLKGEN_FIELD(0x2b4, C32_ODF_MASK,          =
 0) },=0A=
> -       .odf_gate       =3D { CLKGEN_FIELD(0x2b4, 0x1,                   =
 6) },=0A=
> -       .ops            =3D &stm_pll3200c32_ops,=0A=
> -};=0A=
> -=0A=
>  static const struct clkgen_pll_data st_pll3200c32_cx_0 =3D {=0A=
>         /* 407 C0 PLL0 */=0A=
>         .pdn_status     =3D CLKGEN_FIELD(0x2a0,   0x1,                   =
 8),=0A=
