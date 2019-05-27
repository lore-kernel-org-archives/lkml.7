Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD23C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465112081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="QRK2RQHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfE0NmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:42:13 -0400
Received: from mail-eopbgr1310050.outbound.protection.outlook.com ([40.107.131.50]:56929
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbfE0NmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvK5Iqy3C4kcTvCGOPtlYTewvPyPSmsHigytoNNJFjw=;
 b=QRK2RQHmeZvvdT1tdQYyQ4M9MrwB0+p0PqgxrgEB/XO2vlfnOjO2ujDaezE6iGvXupmNn7MFx0XiA906B4mtsl+pImXVh13th4ZYHU8uTcTTV/4+7qYoy6bvve7OgFH8Loir9mA/fFzc0a5WTLBDo3THrvei8ZdZV1T3JtjgXLA=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2741.apcprd01.prod.exchangelabs.com (20.177.171.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Mon, 27 May 2019 13:42:08 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::118b:a597:2b7f:3b01]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::118b:a597:2b7f:3b01%7]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 13:42:08 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Testing
Thread-Topic: Testing
Thread-Index: AQHVFJHvfGo+DC+fpEWhZiCHdrrqmA==
Date:   Mon, 27 May 2019 13:42:08 +0000
Message-ID: <SG2PR01MB2141CAFA4528005FA08C989C871D0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 653a8426-a0ae-4445-5b9a-08d6e2a91d2f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SG2PR01MB2741;
x-ms-traffictypediagnostic: SG2PR01MB2741:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <SG2PR01MB2741B4105C6F763FB707461B871D0@SG2PR01MB2741.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(366004)(346002)(136003)(376002)(396003)(189003)(199004)(7116003)(486006)(476003)(26005)(5660300002)(86362001)(4744005)(66946007)(6916009)(66066001)(6436002)(221733001)(66476007)(66556008)(64756008)(66446008)(5640700003)(9686003)(186003)(6116002)(3846002)(52536014)(2906002)(14454004)(6306002)(73956011)(55016002)(3480700005)(76116006)(53936002)(7696005)(71200400001)(71190400001)(256004)(966005)(2351001)(478600001)(68736007)(316002)(305945005)(81166006)(81156014)(8676002)(99286004)(33656002)(8936002)(2501003)(7736002)(25786009)(74316002)(102836004)(6506007)(107886003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2741;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sLg47e+v1xFcKgmf2yJ8jIZGqOlDAODoAIyqLrE9SYSKperS4GnVPKWgml5Xtg+3sIlGopGEqDnDJ9lvCQ89ZAPIvVxEqJkQXxElKxxFD+kytSia4tRg8lXmDa1qpbUhXbtAA4bPeKyE3OjfzOsnehidY5UU63ZUvjTbVxPMQN71KMiCSrUgwrUdvHChGFrunKaOO8A/M2LOLt741hW3Q3nMOYalaeaIxG1XCHJGPvn4ZJK0buINgaY6hEcZTxMm98reYwbmJTcOqBhTeSl5Mwl6yRIhkVvpwRaoC339ZrJsMD3xwTN6BhcYBrE+RK1j4tvKiGTM3BU9qL+z5E+b9H8+8UygFIxedb3riX9ogAJIuQ69SaxQMVGyJX8qYnrPOqcAGrmVickysvwfVGo4Tc3AETu0/3mC0DyXtTlsFoY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653a8426-a0ae-4445-5b9a-08d6e2a91d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 13:42:08.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing


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
