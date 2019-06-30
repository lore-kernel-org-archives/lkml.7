Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01183C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10A62054F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uwoca.onmicrosoft.com header.i=@uwoca.onmicrosoft.com header.b="tZJgcTMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfF3RmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 13:42:17 -0400
Received: from mail-qb1can01hn2083.outbound.protection.outlook.com ([52.100.145.83]:14799
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfF3RmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 13:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwoca.onmicrosoft.com;
 s=selector1-uwoca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JyuDFUmOpzgKH6dgh5LdWzoUOc/E37EGuvvgxjAQ2g=;
 b=tZJgcTMl73LGcsTwTFInBb1P1mwaoMyEscHVFvdSz/0nnfBzPzBxTOND3Sn0jkGM08Se3RudxjH7rOE1blf7ZtHhTdTcZX20fnIgy6QZuUHFO4rc6ZbBZTklyjKbjbCcB2BRrrYSPcjUK/HST8MNLAFMHi9ocOLj75uzgbpmTxs=
Received: from YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM (52.132.69.19) by
 YQBPR0101MB1203.CANPRD01.PROD.OUTLOOK.COM (52.132.70.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Sun, 30 Jun 2019 17:42:14 +0000
Received: from YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::810f:1394:be78:11a4]) by YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::810f:1394:be78:11a4%7]) with mapi id 15.20.2032.019; Sun, 30 Jun 2019
 17:42:14 +0000
From:   Sandra Anne Hamilton <shamil32@uwo.ca>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Project Analysis
Thread-Topic: Project Analysis
Thread-Index: AQHVL2XZjM6opn8qfEWSO3n7jUq49Q==
Importance: high
X-Priority: 1
Sensitivity: company-confidential
Date:   Sun, 30 Jun 2019 17:04:17 +0000
Message-ID: <YQBPR0101MB1378C78C62F5EA842A0235F6A8FE0@YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM>
Reply-To: "mrfuhuangfu101@mufgbank-jp.com" <mrfuhuangfu101@mufgbank-jp.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:208:134::23) To YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:a::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shamil32@uwo.ca; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [102.165.49.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a5cb08c-7023-4aa2-5e34-08d6fd7cfc56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YQBPR0101MB1203;
x-ms-traffictypediagnostic: YQBPR0101MB1203:
x-microsoft-antispam-prvs: <YQBPR0101MB1203352B57EA7FB7E91BE707A8FE0@YQBPR0101MB1203.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 008421A8FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(102836004)(558084003)(3480700005)(14454004)(71190400001)(71200400001)(52116002)(7696005)(43066004)(81686011)(6436002)(386003)(53936002)(2501003)(6506007)(55016002)(9686003)(2351001)(99286004)(186003)(229853002)(26005)(5003540100004)(5640700003)(305945005)(66806009)(5660300002)(221733001)(8796002)(81156014)(478600001)(6246003)(86362001)(7736002)(6916009)(316002)(786003)(66066001)(2906002)(486006)(3846002)(6116002)(476003)(8936002)(66556008)(74482002)(25786009)(8676002)(256004)(66446008)(64756008)(66476007)(33656002)(68736007)(66946007)(74316002)(52536014)(73956011)(7116003)(81166006)(130330200001);DIR:OUT;SFP:1501;SCL:1;SRVR:YQBPR0101MB1203;H:YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uwo.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JouyTm+jYaAY6Mny/uQAwlVgxDC3dy/s8sjB43HqHhbKihTsPHfYaMxqDyYJpWtwALyac6j7FvXngC9UBQO9QSFOgZKB2RJ5cqPN3xha1HxWcpPc5RETRRXe1W1uQrzkadMTUYZ6Xh2ZFaw9Wo9DbKFoW9evRJKu4F0rDQ6tviruGypD0jqln7mLD4kbuJDxeC5moVPIYxfPddlkN73XElaeQhIVrxUNtEscoGGeYOJ3xw3+hyDil8P+GNzEyYFViV46nVrnrzLZ971T5Iv3EtxQ2NeLdWT1uQN20ds5ssE1Biphzr1jO/76KsC1s/c0qz9HPOibjBKf0a211rlF6HPwOgjcWzLFsmRMLNOLPUensfPSrGz/hTwgUmKdqWZ7GLA0969e8YHl2E3/YeOWheBmL9pFMc5WtfXvBYI4ems=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C6634AA55AD17D419F8D155D7A2C457E@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uwo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5cb08c-7023-4aa2-5e34-08d6fd7cfc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2019 17:04:17.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ad93a64d-ad0d-4ecd-b2fd-e53ce15965be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shamil32@uwo.ca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB1203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you receive my earlier email as  regards the project with Mr Fu huang C=
EO. PLEASE REPLY immediately. Regards.
