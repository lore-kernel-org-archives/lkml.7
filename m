Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEC02084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="EurrVFio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfFTIOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:14:51 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:25126
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfFTIOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTn2nAR+PmPACY6QGnQ5p+1bbU8o6uBslmhrq/lYWXw=;
 b=EurrVFioVayz+wwJ2nQsAs/BCBE7IwZl8rqxApzaLzo3tM+S12jvi+/dRt08Z8+AuO4gfpK7dEP/1tVtug4J2KnviOjke1Lrr/VkS3KH+NzaTIiZUxx/PN6Pq+A7pHfgaKywLan7iSnZS4GwXWmjGvlEZJps7BeOD6tmJOQ04tg=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3408.eurprd08.prod.outlook.com (20.177.59.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 08:14:46 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::f142:fb4a:57c2:3b5]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::f142:fb4a:57c2:3b5%6]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 08:14:46 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Colin King <colin.king@canonical.com>
CC:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: vt6656: fix indentation on break statement
Thread-Topic: [PATCH] staging: vt6656: fix indentation on break statement
Thread-Index: AQHVJr+dU2gnHxTDVkufdp78GoxcxqakMu6A
Date:   Thu, 20 Jun 2019 08:14:46 +0000
Message-ID: <20190620081443.GA19564@qd-ubuntu>
References: <20190619165405.7784-1-colin.king@canonical.com>
In-Reply-To: <20190619165405.7784-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB8PR06CA0066.eurprd06.prod.outlook.com
 (2603:10a6:10:120::40) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6466686c-3b1c-40be-f5be-08d6f5575b29
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR08MB3408;
x-ms-traffictypediagnostic: VI1PR08MB3408:
x-microsoft-antispam-prvs: <VI1PR08MB3408F0AE9C635D95A90AEE8BB3E40@VI1PR08MB3408.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(136003)(366004)(396003)(376002)(39830400003)(199004)(189003)(86362001)(33656002)(14454004)(316002)(6246003)(25786009)(68736007)(66446008)(4326008)(33716001)(66066001)(74482002)(54906003)(81156014)(102836004)(76176011)(26005)(52116002)(305945005)(2906002)(3846002)(6116002)(8676002)(44832011)(446003)(53936002)(99286004)(508600001)(7736002)(386003)(14444005)(81166006)(6916009)(8936002)(486006)(66946007)(256004)(11346002)(1076003)(64756008)(71190400001)(5660300002)(4744005)(186003)(71200400001)(66476007)(476003)(6436002)(229853002)(6512007)(66556008)(6486002)(6506007)(73956011)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3408;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: js7aXb0bF6ZYeUpHJsE30nftnF0lCiXb9gWjHQeY4WLpmWezFznXi43oFqmNTRwGf/9QV+TA4BOquQNffSIt1HFQwUmnUr3MGYjpNR6C4CCkgGjvjAFWHj4S+775Wo+S0KCIYa3XVturCpEFCbh8umWJCIay8WUl/RgJRNCEz3Uz8FKbj45mUAkbVUHwlaVwuRa+hE9ASgvyHs6NuAYwL0lQzUYdexCHal6hKf6ryX1pXZ7R4swpnWBmlkrAvbI+qhlbxOv7Bzsgqv67ye/QhyNtG9YmWZuQvR/GxrAV8s+6aGinWI07R+FUAve/W1d3S3sO5slW/68mboHE9mgdzoMiy0Fs50GxBJJ46VvKpSGvcSPRO2Cv1jOWFiZjzJqk/0A0yYPP/sqNOR8vE0ecxfeNtP9NcDYEAbNEvd382Dc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D04D965FCA89FE4BA30708D1B76B9B28@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6466686c-3b1c-40be-f5be-08d6f5575b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 08:14:46.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quentin.deslandes@itdev.co.uk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3408
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 05:54:05PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The break statement is indented one level too deep, fix this.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/vt6656/card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.=
c
> index 08fc03d8740e..56cd77fd9ea0 100644
> --- a/drivers/staging/vt6656/card.c
> +++ b/drivers/staging/vt6656/card.c
> @@ -166,7 +166,7 @@ static void vnt_calculate_ofdm_rate(u16 rate, u8 bb_t=
ype,
>  			*tx_rate =3D 0x8b;
>  			*rsv_time =3D 30;
>  		}
> -			break;
> +		break;
>  	case RATE_9M:
>  		if (bb_type =3D=3D BB_TYPE_11A) {
>  			*tx_rate =3D 0x9f;
> --=20
> 2.20.1
>=20

Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

Regards,
Quentin
