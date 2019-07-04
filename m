Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A80C0651D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D9B2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lSzcYLx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfGDMmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:42:35 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:42081
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727017AbfGDMmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qnUUJvBInYaZrAb+tmh9qGH/Z1+0TJvYeuigMDPi7k=;
 b=lSzcYLx0n4fKEXLzu7i9TGoRE56+jGBova6L/Z3PdXxmtRF1gVcECjORVfqy1MjuCE5vcjDB4xCywzJIUB+FCYYj96SDajgKzVZt62/l5l7JC9m5hq2ijOX7PGmYOoZRsniOClK6jTeoK5OgGd5wijhbzHgcdaR0u/d6bdIA5sk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4334.eurprd05.prod.outlook.com (52.133.12.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 12:42:32 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 12:42:32 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Topic: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Index: AQHVMk9/uClvT2KGLk2cRdL0kttENqa6Z0EA
Date:   Thu, 4 Jul 2019 12:42:32 +0000
Message-ID: <20190704124228.GI3401@mellanox.com>
References: <20190704200139.696330e8@canb.auug.org.au>
In-Reply-To: <20190704200139.696330e8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:91::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ed5f0aa-6de7-4121-0984-08d7007d14c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4334;
x-ms-traffictypediagnostic: VI1PR05MB4334:
x-microsoft-antispam-prvs: <VI1PR05MB4334AC02C0C1FA1D99453A4ACFFA0@VI1PR05MB4334.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(53754006)(189003)(99286004)(33656002)(52116002)(5660300002)(6246003)(2906002)(1076003)(486006)(6506007)(386003)(53936002)(76176011)(305945005)(6512007)(54906003)(7736002)(446003)(476003)(11346002)(6436002)(66556008)(66066001)(36756003)(66446008)(64756008)(14454004)(2616005)(6486002)(478600001)(316002)(66946007)(66476007)(73956011)(102836004)(81166006)(4326008)(86362001)(8676002)(71200400001)(229853002)(8936002)(25786009)(186003)(81156014)(256004)(26005)(6116002)(3846002)(71190400001)(68736007)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4334;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wmoWLYJPFJdYuvsRSuyUdnQ8QTJ3Veu7bu3LIiFdp9gcqx+luZ9r0wcB5wXHNlTxGQg7UkGH0W4nxpJj6TknTZSqIc3g9x1bM4O/wJoFOc/KjaWAfPZ4cWvUBNxevWg9noiI4y8xG0DVBkC22XbzKNa1SbkcmeF8VycZxmbpp0NUzm/o9CYXU3RVNqzLpzaSytw0OVG+eqCD/Dnzc1SL4R8k67ukcKZ00LRcZ3gBH9Zl3YvUDP6UNT/OFlZP1LejtvgW7L7rrZu+xJERm1Xds+b2jZtPKXMaNss4YcVeWx7xWmJD0bp/cqenHQlfZGqbg+EKuCZUuFXP+7az0kw9i7PbcETKesVRQjBirKuGtLnrLwjWNnWYo6KulDPIe2xjEC1a/TRBf9PhUWx4ZPfXzxzcQCu8fnvDr/8wwXQtseE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7185EF4203E9904987D1285EDE584FD7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed5f0aa-6de7-4121-0984-08d7007d14c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 12:42:32.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 08:01:39PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   drivers/dax/dax-private.h
>=20
> between commit:
>=20
>   ea31d5859f58 ("device-dax: use the dev_pagemap internal refcount")
>=20
> from the hmm tree and commit:
>=20
>   420a0854e8f2 ("device-dax: "Hotremove" persistent memory that is used l=
ike normal RAM")
>=20
> from the akpm-current tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/dax/dax-private.h
> index c915889d1769,9ee659ed5566..000000000000
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@@ -43,6 -43,9 +43,7 @@@ struct dax_region=20
>    * @target_node: effective numa node if dev_dax memory range is onlined
>    * @dev - device core
>    * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>  - * @ref: pgmap reference count (driver owned)
>  - * @cmp: @ref final put completion (driver owned)
> +  * @dax_mem_res: physical address range of hotadded DAX memory
>    */
>   struct dev_dax {
>   	struct dax_region *region;
> @@@ -50,6 -53,9 +51,7 @@@
>   	int target_node;
>   	struct device dev;
>   	struct dev_pagemap pgmap;
>  -	struct percpu_ref ref;
>  -	struct completion cmp;
> + 	struct resource *dax_kmem_res;
>   };
>  =20
>   static inline struct dev_dax *to_dev_dax(struct device *dev)

Looks OK to me, thanks

Jason
