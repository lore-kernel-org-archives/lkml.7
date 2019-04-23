Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975E8204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="YKK2yDPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfDWMiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:38:11 -0400
Received: from mail-eopbgr1300070.outbound.protection.outlook.com ([40.107.130.70]:48950
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfDWMiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-com0iei;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6AeWmQ55X/Tmajsy+/RZiGYqgdTfCw2aaiKI+yUyn8=;
 b=YKK2yDPd5eLVZe8cvhvg1L8Ybm150lwu0iie5YtfJzbQcfYcX+AvjIKTznwVuvOxPgYPH9dGow5GuDuLCCTXGJ5nDBwpfNZg3quuYbfA1zsFfeaHJAv0DdpclWOBLYqhUYtHF5MEv9U/fkwHdzgSYyE8F2qdYgLIzWTJ1vwxgeY=
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com (20.177.148.141)
 by HK0PR01MB2097.apcprd01.prod.exchangelabs.com (52.133.159.146) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.12; Tue, 23 Apr
 2019 12:38:03 +0000
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::d9ee:56ed:f05d:b56c]) by HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::d9ee:56ed:f05d:b56c%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 12:38:03 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: RE: Where is the PGP Verification Signature for Linux Kernel 5.1-rc6?
Thread-Topic: Where is the PGP Verification Signature for Linux Kernel
 5.1-rc6?
Thread-Index: AQHU+ZyWrskCHj1LLUyX3FE157ium6ZJS32AgABjx5A=
Date:   Tue, 23 Apr 2019 12:38:03 +0000
Message-ID: <HK0PR01MB26446B2BAE4DCAB3694263B487230@HK0PR01MB2644.apcprd01.prod.exchangelabs.com>
References: <HK0PR01MB2644BDF8317D49A5E6755E0287230@HK0PR01MB2644.apcprd01.prod.exchangelabs.com>
 <20190423063953.GA32041@Gentoo>
In-Reply-To: <20190423063953.GA32041@Gentoo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 061eb079-5070-4154-8f9b-08d6c7e8871e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(7093024)(5600141)(711020)(4605104)(2017052603328)(7177060)(7172020)(7174020)(7193020);SRVR:HK0PR01MB2097;
x-ms-traffictypediagnostic: HK0PR01MB2097:
x-ms-exchange-purlcount: 6
x-microsoft-antispam-prvs: <HK0PR01MB2097CDDB043503BBEFB2E1CA87230@HK0PR01MB2097.apcprd01.prod.exchangelabs.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(34036004)(396003)(376002)(39830400003)(346002)(189003)(199004)(13464003)(256004)(14444005)(107886003)(76116006)(4326008)(25786009)(66476007)(305945005)(7736002)(73956011)(64756008)(66946007)(66556008)(71190400001)(2906002)(55016002)(66446008)(6246003)(71200400001)(53546011)(229853002)(6436002)(74316002)(6506007)(102836004)(9686003)(97736004)(110136005)(316002)(6306002)(86362001)(76176011)(26005)(7696005)(53936002)(186003)(99286004)(15650500001)(2501003)(966005)(33656002)(486006)(14454004)(68736007)(5660300002)(81166006)(6116002)(81156014)(8676002)(3846002)(8936002)(446003)(476003)(11346002)(66066001)(52536014)(508600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR01MB2097;H:HK0PR01MB2644.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tMgedVf4JGs9rqMabQH4/gU7NMR8HsnInrCAVvMCh0oQwGbJOtvd9GnpC3KfQ0w9lsSJ6mSwcMn6vFV1NGxPQV1sFQNCvRETdEuC1Lv8hp8SgFAg01TKNC0EnzzotiZjxebkmYWlE+GsgXTTz3GCgUSjaK0cIyIQq65+Wfd2Dy1oRLqhQJvvDswT/I24QW6SZ681rRzvWvhZAEmV75seILszJf52kf+2aNHNO5HVrwcm81ZpAsxkeC/zwk8Euy5LePZgGU6kauDTVkCjjE544uAX7n+YwmERi5RmbC3rzEBoR5+DSmqF37GeBVfDHKowxwTas4uGK9mFXBR/MtRCEEx4j32NNQsupaWJYUa5x7J91C2PQrJ/Q64UzLMMncfx4ncGxJRqiMLGDIO/Yv21tPfn+1vFnvZK64OKV+jgx5A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061eb079-5070-4154-8f9b-08d6c7e8871e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 12:38:03.2040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noted with thanks.

-----Original Message-----
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>=20
Sent: Tuesday, 23 April 2019 2:40 PM
To: Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Re: Where is the PGP Verification Signature for Linux Kernel 5.1-r=
c6?

I think , we only sign the stable release tarball not the rc's.=20

On 06:22 Tue 23 Apr , Turritopsis Dohrnii Teo En Ming wrote:
>Good afternoon from Singapore,
>
>May I know where is the PGP verification signature for Linux kernel=20
>5.1-rc6? I can't find it at=A0https://www.kernel.org/
>
>Please advise.
>
>Thank you very much.
>
>
>
>
>
>
>-----BEGIN EMAIL SIGNATURE-----
>
>
>The Gospel for all Targeted Individuals (TIs):
>
>
>[The New York Times] Microwave Weapons Are Prime Suspect in Ills of=20
>U.S. Embassy Workers
>
>
>Link:=20
>https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.
>html
>
>
>***********************************************************************
>*********************
>
>
>
>
>Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic=20
>Qualifications as at 14 Feb 2019
>
>
>[1] https://tdtemcerts.wordpress.com/
>
>
>[2] https://tdtemcerts.blogspot.sg/
>
>
>[3] https://www.scribd.com/user/270125049/Teo-En-Ming
>
>
>-----END EMAIL SIGNATURE-----
>
>

-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
