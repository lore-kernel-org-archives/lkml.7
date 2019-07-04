Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE0C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF01F21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="BG/V74eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGDMon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:44:43 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:10990
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfGDMon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR27vgxW4sDMJOIY5DU682Ng4OVL3igm6xVlrzoTKD0=;
 b=BG/V74eGm8OIy+MNqN9oMHKKdUx3UYwybY1jBfYN1yIocaMJLZSuq2fhPgNvyFMFxU4C+dECv1whD31zKUAEuc1hnzRxPXqduGsM9Ks+lQpJYirk0oNakpFeownu50fwXBYv9uVzgdHzCJF5yQcCktwNRI7GniwBcD2Pa0NlZvg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6446.eurprd05.prod.outlook.com (20.179.28.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 12:44:39 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 12:44:39 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Topic: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Index: AQHVMlCmc6LUcqVhNUisivWOYhcBRaa6Z9aA
Date:   Thu, 4 Jul 2019 12:44:39 +0000
Message-ID: <20190704124435.GJ3401@mellanox.com>
References: <20190704200956.016f2297@canb.auug.org.au>
In-Reply-To: <20190704200956.016f2297@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:160::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 583a50d1-637c-410f-0210-08d7007d60c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6446;
x-ms-traffictypediagnostic: VI1PR05MB6446:
x-microsoft-antispam-prvs: <VI1PR05MB64465DF68B7E85D2132AEB9ACFFA0@VI1PR05MB6446.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(53754006)(68736007)(66946007)(6116002)(476003)(3846002)(36756003)(478600001)(256004)(1076003)(486006)(2616005)(66476007)(66066001)(66556008)(64756008)(8676002)(14444005)(66446008)(33656002)(2906002)(73956011)(6486002)(71200400001)(102836004)(86362001)(54906003)(53936002)(229853002)(4326008)(71190400001)(446003)(305945005)(316002)(6436002)(6506007)(386003)(186003)(5660300002)(6916009)(52116002)(14454004)(6512007)(99286004)(7736002)(81166006)(8936002)(26005)(6246003)(76176011)(11346002)(81156014)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6446;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1+C5pYIx6LecHWlB3XzIgt2lv6Jtzf6/Nq1GKMEeWn1b9EbFbl/bavLHzQlvF9iojYNKuV4o6C53XhG13TRPrX3OluXEWNUlE1AAHuBDIvWRszYMWo6Zz4opisFfv/TfIa8VmXh5uYvd/ob9OXl2HQnuZvgb3cd4s7rrI/H1JkbcVu0+P9laK+zobaTWLtUDjp64OjqCNjY765ZsMoakoMbVIibztfEUmsiExlZNQFxdyRrnWPzC5kitYhiujLPZ+grUbqB8e+L3YwZYJVihHTfaAU7z/36GfIGLVMgoEXBcdo3s9qtqxMdkWoVp6ad4AzGJo+P91u+HsGKejtp8iBBLvGDOdMB6N8T2sq+mhnRWE1P5AAvt5QK7Io7Af1rjGyi+3ZO+gclFs5H5Jnnov7UqULTf32qpGh6yvSPTdm8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <661A045F63E2F74785C05FFB06EE842D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583a50d1-637c-410f-0210-08d7007d60c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 12:44:39.3344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 08:09:56PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   include/linux/mm.h
>=20
> between commit:
>=20
>   25b2995a35b6 ("mm: remove MEMORY_DEVICE_PUBLIC support")
>=20
> from the hmm tree and commit:
>=20
>   0a470a2d114a ("mm: clean up is_device_*_page() definitions")
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
> diff --cc include/linux/mm.h
> index d405a7cff62a,12980954daf9..000000000000
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@@ -950,27 -953,15 +950,7 @@@ static inline bool put_devmap_managed_p
>   	}
>   	return false;
>   }
> -=20
> - static inline bool is_device_private_page(const struct page *page)
> - {
> - 	return is_zone_device_page(page) &&
> - 		page->pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE;
> - }
> -=20
> - #ifdef CONFIG_PCI_P2PDMA
> - static inline bool is_pci_p2pdma_page(const struct page *page)
> - {
> - 	return is_zone_device_page(page) &&
> - 		page->pgmap->type =3D=3D MEMORY_DEVICE_PCI_P2PDMA;
> - }
> - #else /* CONFIG_PCI_P2PDMA */
> - static inline bool is_pci_p2pdma_page(const struct page *page)
> - {
> - 	return false;
> - }
> - #endif /* CONFIG_PCI_P2PDMA */
> -=20
>   #else /* CONFIG_DEV_PAGEMAP_OPS */
>  -static inline void dev_pagemap_get_ops(void)
>  -{
>  -}
>  -
>  -static inline void dev_pagemap_put_ops(void)
>  -{
>  -}
>  -
>   static inline bool put_devmap_managed_page(struct page *page)
>   {
>   	return false;
> @@@ -978,14 -970,27 +959,19 @@@
>  =20
>   static inline bool is_device_private_page(const struct page *page)
>   {
> - 	return false;
> + 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> + 		IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
> + 		is_zone_device_page(page) &&
> + 		page->pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE;
>   }
>  =20
>  -static inline bool is_device_public_page(const struct page *page)
>  -{
>  -	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
>  -		IS_ENABLED(CONFIG_DEVICE_PUBLIC) &&
>  -		is_zone_device_page(page) &&
>  -		page->pgmap->type =3D=3D MEMORY_DEVICE_PUBLIC;
>  -}
>  -
>   static inline bool is_pci_p2pdma_page(const struct page *page)
>   {
> - 	return false;
> + 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> + 		IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> + 		is_zone_device_page(page) &&
> + 		page->pgmap->type =3D=3D MEMORY_DEVICE_PCI_P2PDMA;
>   }
> - #endif /* CONFIG_DEV_PAGEMAP_OPS */
>  =20
>   /* 127: arbitrary random number, small enough to assemble well */
>   #define page_ref_zero_or_close_to_overflow(page) \

Yep, this new version is much nicer

Jason

