Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA65C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E622121721
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="a2VSLtbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfE0I7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:59:52 -0400
Received: from mail-eopbgr1300044.outbound.protection.outlook.com ([40.107.130.44]:49021
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfE0I7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zro+nDYFvGjsarfznwo/kT7bH2VPYwn954WEL3JjOHA=;
 b=a2VSLtbJd6nErNOrOEIOvg0cenqMnfUqmnDFzJJhHJtN8T4yN8UO4fgvoi9vvEvBZ9VdlW4o8FptLw8m46/EzLHAk7WzUged/TnnjiAIx0KlRdPj9Ab+u8+/PpF6zoz6PByr+zC14Ulp7M8sCucijxuuM3nZ1jMCqrT3R8vwr/0=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2581.apcprd01.prod.exchangelabs.com (20.177.95.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Mon, 27 May 2019 08:59:47 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::118b:a597:2b7f:3b01]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::118b:a597:2b7f:3b01%7]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 08:59:47 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Wow! Microsoft Loves Linux!
Thread-Topic: Wow! Microsoft Loves Linux!
Thread-Index: AQHVFGoENBDdi9I6RUaT2DTVyEzmKQ==
Date:   Mon, 27 May 2019 08:59:47 +0000
Message-ID: <SG2PR01MB2141879E255579DF60E40324871D0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [158.140.133.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0981c9ce-77d9-498e-7f1c-08d6e281aba7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SG2PR01MB2581;
x-ms-traffictypediagnostic: SG2PR01MB2581:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <SG2PR01MB2581978C00827EE70703858A871D0@SG2PR01MB2581.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39830400003)(376002)(47530400004)(199004)(189003)(76116006)(66446008)(64756008)(66556008)(66476007)(73956011)(66946007)(68736007)(305945005)(5660300002)(966005)(7736002)(52230400001)(81156014)(8676002)(81166006)(86362001)(74316002)(25786009)(14454004)(8936002)(316002)(2351001)(4744005)(6916009)(4326008)(52536014)(7696005)(2501003)(53936002)(186003)(66066001)(6506007)(33656002)(6116002)(478600001)(2906002)(3846002)(99286004)(45080400002)(107886003)(26005)(6306002)(71200400001)(71190400001)(9686003)(102836004)(55016002)(486006)(476003)(256004)(6436002)(5640700003)(30393001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2581;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eXOOUr7FdOeF7k+z+eUmMzf0ZSjtLp5AUcZlY2p8Xr9KX1nz/9psOHiuKzG5voU7dTBy9SQ1DWC7BlFm6EsNaD8F8jIyAtfA5I+k4puGQ44e0fFPVUf2m3JUlqpHSkDgjzno4knXPYbsro2nE4xhl6ceaeBsZ7RspZzHsOY5pSD1KULCT9T5yTJXbLJhLyhWMJfqxCDXJjwHxlI1QYTW8+UaDZ5IsLyPLZFgbhwm0ThTnKMLdE8qvDnIsAkVoEv5ToMz9BgyvSY53kCuJ0snPqngZxvCImKQ0v0jwFz4weZAB6ZtBbCcVig5LaLQq1xN6xs5nN6FL9RmD7u5kwwU/6MHBFg7bn8N+gGE0HobdIVwuo2G1hRXFSgEFuZAFPMJsk+3n9DlKaQesPM6SOjjIyeDGSOx2hmhXelUAFnoCqk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0981c9ce-77d9-498e-7f1c-08d6e281aba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 08:59:47.6934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon from Singapore,

I did a Google search on "Microsoft Loves Linux".

Google search URL:

https://www.google.com/search?q=3Dmicrosoft+loves+linux

Tons of results show up.=A0Lots of good reads.     =20
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
