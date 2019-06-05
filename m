Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91592C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498E02075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daktronics.com header.i=@daktronics.com header.b="jcjDxpY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfFEQJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:09:48 -0400
Received: from mail-eopbgr780058.outbound.protection.outlook.com ([40.107.78.58]:19008
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728263AbfFEQJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daktronics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZKjR+aKaM7SNkga57Y2V4cUixephsgLQnpwgpF+XlE=;
 b=jcjDxpY+vi4Xz2YHElxLGIdwSfYWgrRxcmpMESbXQ9DAwoE7RhWFVjmpRLoC5mfqLYIQjD13Q12CbYP6ig9PfZKjT8Im/GpfZWxqyRq6jzOWXgiUpShCFl6RirGAfbwzhX2jTQoHKFuz6d3imhntG0IuH6YIujqUZZFgpFMEmp8=
Received: from SN6PR02MB4016.namprd02.prod.outlook.com (52.135.69.145) by
 SN6PR02MB5200.namprd02.prod.outlook.com (52.135.103.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 5 Jun 2019 16:09:41 +0000
Received: from SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::f551:3180:ba2d:7c1f]) by SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::f551:3180:ba2d:7c1f%6]) with mapi id 15.20.1943.023; Wed, 5 Jun 2019
 16:09:41 +0000
From:   Matt Sickler <Matt.Sickler@daktronics.com>
To:     Valerio Genovese <valerio.click@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: kpc2000: kpc_dma: fix symbol
 'kpc_dma_add_device' was not declared.
Thread-Topic: [PATCH] staging: kpc2000: kpc_dma: fix symbol
 'kpc_dma_add_device' was not declared.
Thread-Index: AQHVG7dilT2yYfZL10OphSiUIglSjqaNOn8w
Date:   Wed, 5 Jun 2019 16:09:41 +0000
Message-ID: <SN6PR02MB4016AB359CFD2CAAF58D8B5DEE160@SN6PR02MB4016.namprd02.prod.outlook.com>
References: <20190605155711.19722-1-valerio.click@gmail.com>
In-Reply-To: <20190605155711.19722-1-valerio.click@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sickler@daktronics.com; 
x-originating-ip: [63.85.214.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c80387fa-24d3-4d4f-751f-08d6e9d037a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR02MB5200;
x-ms-traffictypediagnostic: SN6PR02MB5200:
x-microsoft-antispam-prvs: <SN6PR02MB520080C20BAB0AC2283AFBD7EE160@SN6PR02MB5200.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(189003)(199004)(478600001)(5660300002)(446003)(14454004)(11346002)(25786009)(6246003)(7696005)(229853002)(54906003)(72206003)(4744005)(99286004)(26005)(8936002)(8676002)(81156014)(81166006)(305945005)(186003)(76176011)(110136005)(2501003)(53936002)(86362001)(4326008)(102836004)(76116006)(68736007)(33656002)(66946007)(73956011)(6436002)(2906002)(6506007)(9686003)(66066001)(7736002)(486006)(476003)(55016002)(316002)(14444005)(66446008)(6116002)(256004)(3846002)(66476007)(66556008)(64756008)(52536014)(71190400001)(71200400001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5200;H:SN6PR02MB4016.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: daktronics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VpFtRpfwXEQ3hgQbpDXhhh8r2BG5bJLEGpPo3HWR7VU/aDzsFahR2DHB9vRZg8Wsyj1vqd3iQCZbTlk10ENc3NcRmuGR/Tvj0QmWaEyKRhAwjsrc4hlM1RpIUEcpWQ8UGrMxPscDLm1vZZMVNDqy+cqfDvjX9gH0Givr4kzPAEJUck4zbucHqaaifvZW27hev43qFyU9pPPyQ30XdRKKZ5xvyU9WxhSkQDeF/mX6h3wC5D4KFjBUlxn/PEu/LpxFwJR+xpkdOS820yXKNoU7tnjlgkKKxC2SJGDfX4zWW/xmA1Od3GmvX1h/sMDGRCBdegGwzQ7RkNBYTOhUfG9PeeiLvWp2QPN+ZeOJ+CJHhNQvOuV2Eo2MaIhovYXmCNQxr63Eg39S/ZSiiy6HTVmp/BjO29YkCFNfV0zh3Cu+vMU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: daktronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80387fa-24d3-4d4f-751f-08d6e9d037a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 16:09:41.4666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be88af81-0945-42aa-a3d2-b122777351a2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: matt.sickler@daktronics.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This was reported by sparse:
>drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:39:7: warning: symbol
>'kpc_dma_add_device
>' was not declared. Should it be static?
>
>Signed-off-by: Valerio Genovese <valerio.click@gmail.com>
>---
> drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
>b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
>index ee47f43e71cf..19e88c3bc13f 100644
>--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
>+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
>@@ -56,6 +56,7 @@ struct dev_private_data {
> };
>
> struct kpc_dma_device *kpc_dma_lookup_device(int minor);
>+void kpc_dma_add_device(struct kpc_dma_device *ldev);
>
> extern const struct file_operations  kpc_dma_fops;
>

Wouldn't it be better to mark the function static?
It's only used in kpc_dma_driver.c which is where it's defined.
