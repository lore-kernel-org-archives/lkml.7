Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395AAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1E8206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="VPgkifOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCJSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:19:49 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:1859
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfCJSTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdev-co-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iRUdP0COYnDb1lbdUYsUXUBbclWfgEixRA14iaN8Tg=;
 b=VPgkifOIEHIHizzvRa7pT2hRq52+gl1wSI//T76vXCrFuAFIXRie1O8B/s0pvR4rOGjGwt43ywMSTBRw6xEYditH4CFLyahPo91tGrdjR3+aW3XZb6366qUvX2T5OSgSTeW4hvSPS1nOqTmIw8c4mpywxd9w4RrLZz0LFBqy3o8=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB1165.eurprd08.prod.outlook.com (10.166.45.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Sun, 10 Mar 2019 18:19:43 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::c129:d694:632f:6574]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::c129:d694:632f:6574%4]) with mapi id 15.20.1686.021; Sun, 10 Mar 2019
 18:19:43 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     David Miller <davem@davemloft.net>
CC:     "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] staging: e1000: e1000_main.c: remove extern declarations
 in .c file.
Thread-Topic: [PATCH] staging: e1000: e1000_main.c: remove extern declarations
 in .c file.
Thread-Index: AQHU1zbVhlSR+yXAUk61hP5Kksvv3KYFKJuAgAAEngA=
Date:   Sun, 10 Mar 2019 18:19:43 +0000
Message-ID: <20190310181940.GA13925@jiffies>
References: <20190310114558.GA23133@jiffies>
 <20190310.110309.2001511079802999473.davem@davemloft.net>
In-Reply-To: <20190310.110309.2001511079802999473.davem@davemloft.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB8PR09CA0029.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::42) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.44.76.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 707eb0dc-82a1-4763-e359-08d6a584f7b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB1165;
x-ms-traffictypediagnostic: VI1PR08MB1165:
x-microsoft-antispam-prvs: <VI1PR08MB1165785C515864DDF7C9B523B34F0@VI1PR08MB1165.eurprd08.prod.outlook.com>
x-forefront-prvs: 0972DEC1D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(396003)(39830400003)(376002)(136003)(366004)(199004)(189003)(105586002)(74482002)(256004)(446003)(97736004)(26005)(76176011)(106356001)(6506007)(8676002)(186003)(386003)(71190400001)(8936002)(71200400001)(99286004)(68736007)(102836004)(508600001)(66066001)(44832011)(305945005)(52116002)(558084003)(11346002)(86362001)(6916009)(33656002)(7736002)(486006)(476003)(4326008)(54906003)(6436002)(6246003)(6486002)(6512007)(14454004)(1076003)(9686003)(2906002)(81156014)(6116002)(53936002)(25786009)(81166006)(316002)(5660300002)(33716001)(3846002)(229853002)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB1165;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR08MB1165;23:eso2OOdfba9ukhP1PP3CChjN3tXLru0+hp7CZQ5xz?=
 =?us-ascii?Q?Jx5ktwOghhP9Kax6ZwLMo4rD8pkw1Yr22jJKYdIRsuh+eIiATUL0eE7NjIWX?=
 =?us-ascii?Q?fQz/cfsdC2IMoSmIOOJn19w1hL/Gh4aa281PrS5kteMMIed+PgXyPVWUBzlx?=
 =?us-ascii?Q?mMZrnqSESDADjqvYKZpU7+fqMPRFUjqO6Md6P5E8O+ovS4aw9WYZIR5Ag2/E?=
 =?us-ascii?Q?jb5bxIvZRWigFaojzBopkHp3+oG6ntdvEMJ/5aVVoOL93nZr3d+ObSSePGY6?=
 =?us-ascii?Q?XvME0rcRqWf1I2RTAaA+FS4P1asQHDHQqXji1mBX8XncL+SvtZ7HGCJxFRZw?=
 =?us-ascii?Q?U6jopDf1/VFUKfQpO1p3F8YJE0FmS8XP2FHZ2eYplRT+LYUTxDSpUqbpfUav?=
 =?us-ascii?Q?bOMy5hE+z+CZEokRM+6qX31kMIyJj2yGzK/BSLUcjC0Ym9bLjf46awP8rXDs?=
 =?us-ascii?Q?kVTkjb+MLDokT7Nfkiy2+V7pr7IAslxkdJJ0OQtGJPoTNy6bOoyxJkchOsB5?=
 =?us-ascii?Q?bVWWoZzfix17ySb/xmP5SusmuCvk8NnNreN6NMhwMXutonUL6YwrI0UnHeGk?=
 =?us-ascii?Q?qFM5LEvDWkFLTUHXlf9LFDpiMt+esiVjE3iWX2ZRkMij6/UCdjnk4Ceq5twG?=
 =?us-ascii?Q?/Qddylz66jZw4ztdnc3jbAwRE3zx0A0dVqvKz6ENdYteafy6IyRKqpHWiSjT?=
 =?us-ascii?Q?rmtenCDLr4nC/Tyhbj27FeUdDvaWEm0+iLvf6hBHlbdu633/+Z3IF6Ne4ky0?=
 =?us-ascii?Q?mO63R8FbQgPZg+SVlxD7522t9REwukJmxzYGWZSFK6NgCSlBZ8GwDeQfUj19?=
 =?us-ascii?Q?IX7oE9ZwXlrZNczAcUWiJ+TzgV8FXTUYBDfcAzVQE4iqz8H/Qtn/gbxrU888?=
 =?us-ascii?Q?wF4mQ7FqjAPOYhmftDdvzSuFpCnsM/4Ryb0VtFSx5Mnadqj43OOkbUfN20KO?=
 =?us-ascii?Q?SvNXsHUOZAZXgj2hu6vIJwA5lgRXn4GlRM/K7akh9V5unpdxCvUmNhHcoFAD?=
 =?us-ascii?Q?QeoLnu3M167caWzb0WJFIvC8dGcWPXzIL+xqrCjK/FAOqv/ABNoxvLn4Cygy?=
 =?us-ascii?Q?LTE9jZIwpFvINT6xA13xh+HJ5P9NRSDb0inPRNuNS/KNvnVu5bF7MLatFa+Z?=
 =?us-ascii?Q?PyKLtnY5/e2fhsDThNR7Fs9ORpPmHUuP0WVQ4EuED+G4J2mnWdwjcaduj35d?=
 =?us-ascii?Q?UCjlOwfMFXHibdcSR6j8KQ83fQgqK+XLWq1SkYCEWYGVoEiLcn9BoePq3dSf?=
 =?us-ascii?Q?yHx3f2CrPoglEt8fmYwWwl4MI1YR/FMU9ypm0cY4a7CzZ8CpGoymk8GCdohK?=
 =?us-ascii?Q?PAd6Xkx7jGDAOrEotKauAkg1OEfimPOQs8j7WG4cdyMYphG/PAvbyJhmPvp1?=
 =?us-ascii?Q?bYI3w=3D=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aS3WyC9it3WujyaYXI6nITMsHcJ1XY6DgOVEZtdnK7EDKovkT5De8iv3HxtcHSNMW3EsW3vJmK71liqNfmeOt/PHdZbq6j+xxGL5XmoSnmmN5CtzLDARg6cvk3T8yIXOiFUz9/3z8jJsfRWHOsdJYzaNFQT/DK1wjqK2+SgTj3lFuVGfQ1S7HAMqXAG4BoRzMfohE7LiKigz1MLqwXw4vQ1Ag93s4k9rq4aRbbilof3GaeZbjGjFCjQPqCrdFCbxI4x1IJdTAwl37gu70gAWQc6/t3DWZ+sMb50J0K5hRJSWxYvmR4lHMeOV2l5KdJ+X+/w/M9GE6vMyXNI2XVurgbFkvJjV+bz43zhCzVO58/RupappNEArTZu1Qknhi4qtM1bPh9veGY7g3PynAVJCtOtRaET3hXEsuheFv/X1yP4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1994B1A3FED3E449ACDF8B5AFFD8A55E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 707eb0dc-82a1-4763-e359-08d6a584f7b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2019 18:19:43.2178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB1165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 11:03:09AM -0700, David Miller wrote:
>=20
> "staging"?

"staging" was an error, someone explained me after I sent the patch, sorry =
for
the inconvenience.

