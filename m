Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4267BC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164FB2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Xd6CD5+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHSF3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:29:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53816 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725308AbfHSF3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:29:24 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7J5LhLT003955;
        Mon, 19 Aug 2019 07:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=xruT1o96DDimISiLeIQPJA2wBQfu4f213a/txjAPZI0=;
 b=Xd6CD5+Q7PwNJitsgkiCBMkU6ZaqwwJaGv4pheNCI7s1kCFcVT+7Ql7fnHjo6kLQQLdZ
 IBxAaRrPmmQ/MFTwG/fGX4esWuq26Ji0k+gBYQrQOej13Cg2G4dpKcVJgmu6xYk5Znpv
 VB+ygllJcihLrDGZYuQXxZz4U57u7UUUWRyUhsbuVz38KFtToDfM5JTLaixeZTXagZxI
 HufLdla7OLysLT5lHPtCuyo5FTNqAiXSdMk05M+n7AFIHspXOyCIZuqGOBhmFQNO3XN2
 dih5YgaHbQw3FVt6Zz+xPY20uv+VQyxEr1eZno+V2ZHhpx7olOm7je+GzxE7Jk89vlLA wA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ue8fggxsy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 19 Aug 2019 07:29:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DEE1538;
        Mon, 19 Aug 2019 05:29:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node1.st.com [10.75.127.10])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A8A8521E797;
        Mon, 19 Aug 2019 07:29:07 +0200 (CEST)
Received: from SFHDAG4NODE2.st.com (10.75.127.11) by SFHDAG4NODE1.st.com
 (10.75.127.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 07:29:07 +0200
Received: from SFHDAG4NODE2.st.com ([fe80::4457:45af:aece:883f]) by
 SFHDAG4NODE2.st.com ([fe80::4457:45af:aece:883f%20]) with mapi id
 15.00.1473.003; Mon, 19 Aug 2019 07:29:07 +0200
From:   Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        "info@metux.net" <info@metux.net>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH -next] clk: st: clkgen-fsyn: remove unused variable
 'st_quadfs_fs660c32_ops'
Thread-Topic: [PATCH -next] clk: st: clkgen-fsyn: remove unused variable
 'st_quadfs_fs660c32_ops'
Thread-Index: AQHVVFk4wzhRgyRVpkig2XNbQPhwiKcB9RSX
Date:   Mon, 19 Aug 2019 05:29:07 +0000
Message-ID: <1566192547262.14182@st.com>
References: <20190816135341.52248-1-yuehaibing@huawei.com>,<20190816173655.17BB2205F4@mail.kernel.org>
In-Reply-To: <20190816173655.17BB2205F4@mail.kernel.org>
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
To: YueHaibing; info@metux.net; mturquette@baylibre.com; robh@kernel.org; G=
abriel FERNANDEZ=0A=
Cc: linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org; YueHaibing=0A=
Subject: Re: [PATCH -next] clk: st: clkgen-fsyn: remove unused variable 'st=
_quadfs_fs660c32_ops'=0A=
=0A=
Quoting YueHaibing (2019-08-16 06:53:41)=0A=
> drivers/clk/st/clkgen-fsyn.c:70:29: warning:=0A=
>  st_quadfs_fs660c32_ops defined but not used [-Wunused-const-variable=3D]=
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
>  drivers/clk/st/clkgen-fsyn.c | 1 -=0A=
>  1 file changed, 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c=
=0A=
> index ca1ccdb..a156bd0 100644=0A=
> --- a/drivers/clk/st/clkgen-fsyn.c=0A=
> +++ b/drivers/clk/st/clkgen-fsyn.c=0A=
> @@ -67,7 +67,6 @@ struct clkgen_quadfs_data {=0A=
>  };=0A=
>=0A=
>  static const struct clk_ops st_quadfs_pll_c32_ops;=0A=
> -static const struct clk_ops st_quadfs_fs660c32_ops;=0A=
>=0A=
>  static int clk_fs660c32_dig_get_params(unsigned long input,=0A=
>                 unsigned long output, struct stm_fs *fs);=0A=
