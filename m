Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BCEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3031420833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="SrJBBV+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfDOF0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:26:44 -0400
Received: from mail-eopbgr800080.outbound.protection.outlook.com ([40.107.80.80]:14336
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfDOF0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRaaTZb/b7GrrAlycWg5+Prj7kYz4ntEka2OTlPpW7Y=;
 b=SrJBBV+/xoqTPwhN4o5/TUW8pcv1KQ+cZxPZnOwMrd7ZRS+W82j0iZjHEk3nzeh39lKkiiyDVpTJHPedp+Y64YebNFCOYYXItvCXmD3o/PQKUuDh4CXutjBh8/hD15/VxfgpeMG1X1OrU5v+O4tVTSAvkdKgDuabhNZpYauKLOg=
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com (10.160.195.140) by
 BY1PR0301MB0888.namprd03.prod.outlook.com (10.160.194.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 05:26:40 +0000
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::596a:b0b6:d17d:d075]) by BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::596a:b0b6:d17d:d075%8]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 05:26:40 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: normalize Michael Hennerich's email address
Thread-Topic: [PATCH] MAINTAINERS: normalize Michael Hennerich's email address
Thread-Index: AQHU8drxR9KppFAGakWHlkR/p+BXjKY8s/TA
Date:   Mon, 15 Apr 2019 05:26:39 +0000
Message-ID: <BY1PR0301MB0901908BC7A60D355D6045858E2B0@BY1PR0301MB0901.namprd03.prod.outlook.com>
References: <20190413092548.13995-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190413092548.13995-1-lukas.bulwahn@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23d713ce-a87e-4d65-00ad-08d6c162f052
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BY1PR0301MB0888;
x-ms-traffictypediagnostic: BY1PR0301MB0888:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BY1PR0301MB08883EF1BCB82C345B26BBF78E2B0@BY1PR0301MB0888.namprd03.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(13464003)(8936002)(2906002)(4326008)(316002)(11346002)(486006)(476003)(25786009)(53546011)(446003)(478600001)(6506007)(72206003)(186003)(33656002)(229853002)(86362001)(102836004)(26005)(6916009)(6436002)(4744005)(74316002)(105586002)(68736007)(6116002)(3846002)(305945005)(71190400001)(97736004)(966005)(76176011)(71200400001)(8676002)(7736002)(106356001)(7696005)(256004)(14444005)(14454004)(53936002)(66066001)(52536014)(55016002)(99286004)(5660300002)(9686003)(6306002)(6246003)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0301MB0888;H:BY1PR0301MB0901.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7J28iXPLTYKRqWz6xilXKOLDvuufqB/0c3dkBeSb4mp2liSYy2mSIUrZ5wGka/UijMkXTnpq3mEnz+pywwHkLlJ/JCxDmQ1uc8YW3zVONFRLNtLxZpBaisHTYwUoLnPZxrjqDwLMRqQCSOqgHcj64kSZzQnP6RLyYgPc9+UrUVsNA5496VH9Tin/79QYdEGz4aFHvxDOIoWFCne12fYD/27eH3rbI7Srx/JNpvZMaD0Qs0XtRLBo8WL4YPcJwOKSazdXrgCVmawGJTa95BOcufElKypKT7S55G/GTNJXkiNR9rTwIGvY2Hz2c8pKDzrwxy4SfF49h5LlvieelqohszCzzJHfm1Wngsb4aJTUAO8V3KlnZ1MuQ41yLs4q9kI0cRBZEeWasMZJoZ89Bnq8lzKbDeEhFN+w6v8z9oEs5U0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d713ce-a87e-4d65-00ad-08d6c162f052
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 05:26:39.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0301MB0888
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Lukas Bulwahn [mailto:lukas.bulwahn@gmail.com]
> Sent: Samstag, 13. April 2019 11:26
> To: Hennerich, Michael <Michael.Hennerich@analog.com>
> Cc: linux-kernel@vger.kernel.org; Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Subject: [PATCH] MAINTAINERS: normalize Michael Hennerich's email address
>=20
> MAINTAINERS contains a lower-case and upper-case variant of
> Michael Hennerich' s email address.
>=20
> Only keep the lower-case variant in MAINTAINERS.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index afa019b5c461..b486b9e5d73c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -949,7 +949,7 @@ F:  drivers/dma/dma-axi-dmac.c
>=20
>  ANALOG DEVICES INC IIO DRIVERS
>  M:     Lars-Peter Clausen <lars@metafoo.de>
> -M:     Michael Hennerich <Michael.Hennerich@analog.com>
> +M:     Michael Hennerich <michael.hennerich@analog.com>
>  W:     http://wiki.analog.com/
>  W:     http://ez.analog.com/community/linux-device-drivers
>  S:     Supported
> --
> 2.17.1

