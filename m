Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375AC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB95218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fWMDFo8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGDMzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:55:48 -0400
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:10336
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726614AbfGDMzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF166CzLGKJB5aq/EtW8VvsRNjCwF9u5uCzsTiprGT0=;
 b=fWMDFo8zIr3U8fSZRgPRjyHdqNtlo+rjmkIT0qMr2b0zoKqYFjkHrgrWEW0POnshid9lPUdzQwpfV525MzlZ3wgALDSi/pjBGQw43jQmPsUvNdIL6T4pwe5ip6IhxzXr4ihLoYwBouH70yFfGqOIHGtHfgSiD3GLncY3wxnAzIE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4400.eurprd05.prod.outlook.com (52.133.13.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 12:55:44 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 12:55:44 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Topic: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Index: AQHVMlcIUr9ppS/jrECG60Qeg/CcSKa6auGA
Date:   Thu, 4 Jul 2019 12:55:43 +0000
Message-ID: <20190704125539.GL3401@mellanox.com>
References: <20190704205536.32740b34@canb.auug.org.au>
In-Reply-To: <20190704205536.32740b34@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:208:fc::40) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 663cca89-368c-4e52-dfc4-08d7007eece0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4400;
x-ms-traffictypediagnostic: VI1PR05MB4400:
x-microsoft-antispam-prvs: <VI1PR05MB440049E4B44E36BAFFF4D247CFFA0@VI1PR05MB4400.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(53754006)(199004)(189003)(305945005)(5660300002)(186003)(6436002)(316002)(6506007)(386003)(229853002)(53936002)(71200400001)(54906003)(86362001)(102836004)(446003)(4326008)(25786009)(81166006)(76176011)(81156014)(6246003)(11346002)(52116002)(99286004)(6512007)(14454004)(7736002)(6916009)(71190400001)(8936002)(26005)(2616005)(6486002)(478600001)(486006)(3846002)(476003)(6116002)(66446008)(68736007)(1076003)(36756003)(33656002)(73956011)(2906002)(256004)(66476007)(66556008)(66946007)(64756008)(66066001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4400;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ye/fHZiV1FARo5VnRUH/5aT9JwI+9/GXA7rjVw/ZfPKkcms7sQpMy75CbrdZeN9zfWE9vUt77fBun8Lk+jb0NDjFjdK69BjILn0ZmYFmTLTnaX3TN8Ip3EWHTGgOncPDJdRzUhWWG1FO3flVrr2WSNV5LCz8GrDjseJ2SS+8ZFrNdHwpcwKzez9pfxdO48Zh0P4sKraA+oq8YtCRS5PsaM5N2k0ONkox1iRheGNjZLGDpusYQ4RDEOge4RSyFt4w3BX6l/0W9POwG8nhm4BU03DjvsMhdJFX29zuJRqVwdD8YwFPg79TUeBY0me5RYyLL87Xspz3RvfwDZ8+SYBdITPza5Yknu7zcajvRVKUO6QPAGdHx9sfKLJe62JgxARQdJRY8kG0/coooIDc/dFTMq+vDp/WsSzheRCKTkPcINk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69C17C8EDD7BE040A9FF874F0A78BABC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663cca89-368c-4e52-dfc4-08d7007eece0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 12:55:44.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 08:55:36PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   mm/memory_hotplug.c
>=20
> between commit:
>=20
>   514caf23a70f ("memremap: replace the altmap_valid field with a PGMAP_AL=
TMAP_VALID flag")
>=20
> from the hmm tree and commit:
>=20
>   db30f881e2d7 ("mm/hotplug: kill is_dev_zone() usage in __remove_pages()=
")

There must be another commit involved for the 'unsigned long nr,
start_sec, end_sec;' lines..
=20
> from the akpm-current tree.
>=20
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc mm/memory_hotplug.c
> index 6166ba5a15f3,dfab21dc33dc..000000000000
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@@ -549,16 -537,14 +537,13 @@@ static void __remove_section(struct zon
>    * sure that pages are marked reserved and zones are adjust properly by
>    * calling offline_pages().
>    */
> - void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> + void __remove_pages(struct zone *zone, unsigned long pfn,
>   		    unsigned long nr_pages, struct vmem_altmap *altmap)
>   {
> - 	unsigned long i;
> --	unsigned long map_offset =3D 0;
> - 	int sections_to_remove;
> ++	unsigned long map_offset;
> + 	unsigned long nr, start_sec, end_sec;
>  =20
> - 	/* In the ZONE_DEVICE case device driver owns the memory region */
> - 	if (is_dev_zone(zone))
>  -	if (altmap)
> --		map_offset =3D vmem_altmap_offset(altmap);
> ++	map_offset =3D vmem_altmap_offset(altmap);
>  =20
>   	clear_zone_contiguous(zone);
>  =20

This looks OK to me. After the trees are merged vmem_altmap_offset()
returns 0 if !altmap, so the code is equivalent.

Jason
