Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF3520880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="FR518TLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDIGzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:55:39 -0400
Received: from mail-eopbgr1300058.outbound.protection.outlook.com ([40.107.130.58]:10165
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfDIGzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhvftYmBbxKShj+CoY7y/lw9q0Ayo3jaUwg6pzEUmPo=;
 b=FR518TLZ4+8qiRHTrjxuqnhhLEUQdi7ILgmL65iyZBsuNf1ZrXcpLQNMGqdXrb78k/A4fFRht2bVkqjBi9fVyMpzWJjV1OEFbaFSqAOP8bS9YRx4Fh166s74KRntHrTvLdPrMAchXL2/gcCLml6d6ECSVF6Eb1d2ixitRHM8H1k=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB4043.apcprd02.prod.outlook.com (20.178.156.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 06:55:34 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1771.019; Tue, 9 Apr 2019
 06:55:34 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Basics : Memory Configuration
Thread-Topic: Basics : Memory Configuration
Thread-Index: AQHU7qEJC6EuUiGvjEiZ+OVh95dcdw==
Date:   Tue, 9 Apr 2019 06:55:34 +0000
Message-ID: <SG2PR02MB3098925678D8D40B683E10E2E82D0@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 751437ea-88cb-4a1e-d3a0-08d6bcb85d6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:SG2PR02MB4043;
x-ms-traffictypediagnostic: SG2PR02MB4043:
x-microsoft-antispam-prvs: <SG2PR02MB4043FF045576F230EF49F1B3E82D0@SG2PR02MB4043.apcprd02.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(9686003)(3846002)(6116002)(2906002)(476003)(44832011)(66066001)(7696005)(486006)(25786009)(99286004)(316002)(110136005)(14454004)(68736007)(55016002)(53936002)(81166006)(305945005)(7736002)(33656002)(8676002)(81156014)(74316002)(478600001)(6436002)(26005)(14444005)(55236004)(102836004)(8936002)(256004)(5024004)(71200400001)(186003)(2501003)(6506007)(86362001)(5660300002)(52536014)(105586002)(106356001)(66574012)(78486014)(97736004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB4043;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OLQhb5QUQA9QWg7Owjq+RUq0FC+c+7gqkaSiU/vsJWQSEsMLhNOCPJdpdjXpTy9d4b5YqwYIUmTu1zZplHJ3tCLwxJkuUxpwTEa/o6mX9K6PiOQfTkvfv4dt1Hb21f4zdf8pI+/q0VgwqAkwHOo2B7v5bSg8eoHTet3pQt/nOEHWYv4DsA2GkWf8fGuL3yz/d4PbkSqFH2JtO9Q0I2tdEfKOPfHhFKL5sAMb802GeewZZ4f/F0vvj543d88so4FYgzXEeCdzJP9WBx36UDM0kaTE6AboXa93slIsITtqQ0rLNT4fCE6nsncX+pRJut8h6FdkUVkNrLGf5SnTDhiygUrhiqawGRKqwnrjKj1isTSZRCr66Jspj2DbcFkbMUL4tqnMPAirSweRm8SVdu84tM2Ozo2AH1lJIAjk5a0nIII=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751437ea-88cb-4a1e-d3a0-08d6bcb85d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 06:55:34.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am confuse about memory configuration and I have below questions

1. if 32-bit os maximum virtual address is 4GB, When i have 4 gb of ram for=
 32-bit os, What about the virtual memory size ? is it required virtual mem=
ory(disk space) or we can directly use physical memory ?

2. In 32-bit os 12 bits are offset because page size=3D4k i.e 2^12 and 2^20=
 for page addresses
   What about 64-bit os, What is offset size ? What is page size ? How it c=
alculated.

3. What is PAE? If enabled how to decide size of PAE, what is maximum and m=
inimum size of extended memory.

Regards,
Pankaj
***************************************************************************=
***************************************************************************=
******* eInfochips Business Disclaimer: This e-mail message and all attachm=
ents transmitted with it are intended solely for the use of the addressee a=
nd may contain legally privileged and confidential information. If the read=
er of this message is not the intended recipient, or an employee or agent r=
esponsible for delivering this message to the intended recipient, you are h=
ereby notified that any dissemination, distribution, copying, or other use =
of this message or its attachments is strictly prohibited. If you have rece=
ived this message in error, please notify the sender immediately by replyin=
g to this message and please delete it from your computer. Any views expres=
sed in this message are those of the individual sender unless otherwise sta=
ted. Company has taken enough precautions to prevent the spread of viruses.=
 However the company accepts no liability for any damage caused by any viru=
s transmitted by this email. **********************************************=
***************************************************************************=
************************************
