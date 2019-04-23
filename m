Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E31AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9127206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="gWy9wxUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfDWGWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:22:50 -0400
Received: from mail-eopbgr1310044.outbound.protection.outlook.com ([40.107.131.44]:63200
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfDWGWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-com0iei;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gfRIH2LgoDnkor607bEw8mSNiy34IOeRw6fzEEKXXc=;
 b=gWy9wxUYzG+YKW257U8Wra39ImoiJ1HR2XRMhz247/3PWe+X09UjZig+76HAFf4/YBBKeH9DwuQZ3WUkRsZ7hwlQ5y5lLfyaWWbPgxsmYbBMPRmhesIO+NmZtq3zxQk2u3CsjIFXhTKoauap5UJoV4rHHopPBYaribcIBo3Rly8=
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com (20.177.148.141)
 by HK0PR01MB2756.apcprd01.prod.exchangelabs.com (20.177.167.140) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.12; Tue, 23 Apr
 2019 06:22:45 +0000
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::d9ee:56ed:f05d:b56c]) by HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::d9ee:56ed:f05d:b56c%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 06:22:45 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Where is the PGP Verification Signature for Linux Kernel 5.1-rc6?
Thread-Topic: Where is the PGP Verification Signature for Linux Kernel
 5.1-rc6?
Thread-Index: AQHU+ZyWrskCHj1LLUyX3FE157iumw==
Date:   Tue, 23 Apr 2019 06:22:45 +0000
Message-ID: <HK0PR01MB2644BDF8317D49A5E6755E0287230@HK0PR01MB2644.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [158.140.133.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12ac129b-c4dc-481a-4d1b-08d6c7b419c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7177060)(7172020)(7174020)(7193020);SRVR:HK0PR01MB2756;
x-ms-traffictypediagnostic: HK0PR01MB2756:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <HK0PR01MB2756E88DB988EBAB008E32B587230@HK0PR01MB2756.apcprd01.prod.exchangelabs.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(34036004)(376002)(346002)(366004)(39830400003)(396003)(136003)(199004)(189003)(4744005)(3846002)(86362001)(66946007)(6116002)(486006)(7736002)(7696005)(476003)(6916009)(73956011)(99286004)(25786009)(71190400001)(64756008)(71200400001)(66476007)(76116006)(66556008)(91956017)(66446008)(97736004)(14444005)(102836004)(2906002)(52536014)(2501003)(26005)(186003)(66066001)(15650500001)(5640700003)(33656002)(74316002)(256004)(6436002)(316002)(68736007)(8676002)(4326008)(81166006)(81156014)(8936002)(6506007)(9686003)(6306002)(55016002)(305945005)(14454004)(107886003)(53936002)(2351001)(5660300002)(508600001)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR01MB2756;H:HK0PR01MB2644.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ggD1BkwkQnkSATxs5B1xAdk4tqXKfhq1uzOB0uaFwGJkrNshhlrzGFfxbY+eqgQtuKeZijQJ/fZC7h51ZBsqJL+X3c7u+PWEauSD44/2Tmb/GSnCbdI0EwD/t7DzAl/BMna+rd2HUnU+9wEUNoA04+VDwmTGO7iwQIInF3kU7sQVCg2K4wVxOOL6y3QTH1eHM/hP81gfiphY09Oon3dfhOzRdV239xvHQEctNeF7aBA0uDk0n8XsnyrM90qO5U1FcLzeqTRbfVgdaGNppyRmY6PNVXDUOUV1vCXsQjX8NUNWQq/w4SvCK3xp/6AGsvH45j1q3rwjm7lIdb7hgtJGq/oDbUq6YQ5NYcpWKbIG782yThKjIqYRsz24DeSGXraCLt0cxUrnEGw1mTHQejm0nh6+1KHxkyV3uXgLcwjh6pc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ac129b-c4dc-481a-4d1b-08d6c7b419c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 06:22:45.8667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon from Singapore,

May I know where is the PGP verification signature for Linux kernel 5.1-rc6=
? I can't find it at=A0https://www.kernel.org/

Please advise.

Thank you very much.



=20
=20
=20
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
=20
  =
