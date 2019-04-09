Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9F6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27C82084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="LinLEVX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDIOHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:07:13 -0400
Received: from mail-eopbgr1310040.outbound.protection.outlook.com ([40.107.131.40]:15936
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbfDIOHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-com0iei;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnYlA09Wn1kjAkpWItn040iaEU5opNDXIDDvIfmIt2I=;
 b=LinLEVX7pcFCJmbS8lIUcnWFgnUbcE2Yhoy6WetlclFX27Nb7CtGe4l2aK7hQ4d/XT8gmxsNJRGGfI4ISZbYqz+0HjtGH1ssXG0C4BgvKqbhpdO/xv8IMA/Om5mERIh7blkVo35ShXsK5mJz1n7j2VU43+pIBRYE9If2ncdJsk4=
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com (20.177.148.141)
 by HK0PR01MB2627.apcprd01.prod.exchangelabs.com (20.177.148.202) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.15; Tue, 9 Apr
 2019 14:07:09 +0000
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::d9ee:56ed:f05d:b56c]) by HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::d9ee:56ed:f05d:b56c%5]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 14:07:09 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming's Fortigate-VM64 Site-to-Site IPsec VPN Tunnel Manual
 v1.0
Thread-Topic: Teo En Ming's Fortigate-VM64 Site-to-Site IPsec VPN Tunnel
 Manual v1.0
Thread-Index: AdTu3VX5GvqRx/m4QduaHZ3AgbyfaQ==
Date:   Tue, 9 Apr 2019 14:07:09 +0000
Message-ID: <HK0PR01MB26445503E5D2833E2C6B8B94872D0@HK0PR01MB2644.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8673e54b-f232-4360-ad18-08d6bcf4a7bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7027125)(7031125)(7023125)(7093024)(5600139)(711020)(4605104)(2017052603328)(7177060)(7172020)(7174020)(7193020);SRVR:HK0PR01MB2627;
x-ms-traffictypediagnostic: HK0PR01MB2627:
x-ms-exchange-purlcount: 9
x-microsoft-antispam-prvs: <HK0PR01MB2627BEBD445141D58B8F0FB6872D0@HK0PR01MB2627.apcprd01.prod.exchangelabs.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(34036004)(39830400003)(376002)(366004)(346002)(396003)(199004)(189003)(66066001)(26005)(86362001)(38610400001)(8676002)(33656002)(8936002)(586005)(256004)(2501003)(81166006)(81156014)(7736002)(74316002)(486006)(7696005)(14454004)(6506007)(476003)(2906002)(102836004)(305945005)(5660300002)(68736007)(45080400002)(6436002)(52536014)(106356001)(105586002)(966005)(186003)(55016002)(3846002)(6116002)(97736004)(9686003)(498600001)(6916009)(6306002)(4326008)(99286004)(71190400001)(5640700003)(53936002)(71200400001)(25786009)(107886003)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR01MB2627;H:HK0PR01MB2644.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6h18qyN4AdIvzl/iR3s3mJV44RXMyJLTMkZAOM6kaPQ/A7cAjICT50CXZxEbazc/Wsj9ppWph/GTCOeBc6ixCAk407wv71EacUvlDHoVmWrAesuBZnMFIBDZP4ml6gWnZG1F+XSKIbSuDAUpuTiP8mX6P493OgOvu7ep2m7euvCdy0Am1bAhahcH/klQfynSsxjGn+XJRHCLnuZwAjxHoP9CGDRvCFUc2ZgoDUdyaOrz4KdA9wkZn3nQfroGGPxme+K6VGlBnoQ1oUkSRN9VmOkzrJbCGSy0wLoCoapPkBoBBjTB5npttJaPh9uhMikzDsAj8F7qhvWPJ2Kpfxv1ILcsohHi+DfSBpapxRl5WaGAn/3U72jnJg1QlS7nsfKzKVT9pIzQ3slp8eGv1JHxryMNZMCcwm+fUK4kY+SAXEI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8673e54b-f232-4360-ad18-08d6bcf4a7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 14:07:09.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening from Singapore,

Primary Subject/Topic: Teo En Ming's Fortigate-VM64 Site-to-Site IPsec VPN =
Tunnel Manual v1.0

Secondary Subject/Topic: How to Deploy Site-to-Site IPsec VPN Tunnel with F=
ortigate-VM64 5.6.8 Virtual Firewall Appliances and VMware Workstation Pro =
15.0.4

Multiple Links to PDF Manual version 1.0 (47 pages)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

1. DocDroid Link

https://www.docdroid.net/XqcbEhQ/teo-en-ming-fortigate-vm-site-to-site-ipse=
c-vpn-manual-v10.pdf

2. Google Drive Link

https://drive.google.com/open?id=3D1S6JOyUs9ic2jBUQa-L5Xzv3bMpyjEWas

3. Microsoft OneDrive Link

https://1drv.ms/b/s!ArahPxJAVR61hRCjv7-l5Xt2q6TV

4. Scribd Link (Low Quality PDF)

https://www.scribd.com/document/405589802/Teo-En-Ming-s-Fortigate-VM64-Site=
-To-Site-IPsec-VPN-Tunnel-Manual-v1-0

5. DocHub Link

https://dochub.com/enmingteo/rag2NZ/teo-en-ming-fortigate-vm-site-to-site-i=
psec-vpn-manual-v1-0-pdf?dt=3DRhaC2bQZsxhbR3jyZ6nt

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

