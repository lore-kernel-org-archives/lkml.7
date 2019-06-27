Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2690BC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E528420659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="FZyxg24L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfF0BPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:15:43 -0400
Received: from mail-eopbgr1410099.outbound.protection.outlook.com ([40.107.141.99]:51280
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfF0BPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2avVQiR3lQuclFmlL/N/rnJt6G4lneF2E4ydIRrq24=;
 b=FZyxg24LHqxTFFpAFkdk+O6ve/ZxgYoGErDeqjnaqWnFtun4Vh7ybs7dr9qToYZ5zz5NscLNSluj6Q0H3EDbE+qgHO12thli68c8tBQ2peuabY8v6wa91mTbNo4AVRRyFCJRulJ9p4tcuoIutk0pC0BnI7/qvSyQu8TbbEIP4aE=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.174.85) by
 TYAPR01MB3887.jpnprd01.prod.outlook.com (20.178.138.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 01:15:40 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::602d:62cc:de62:eaba]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::602d:62cc:de62:eaba%6]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 01:15:40 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Colin King <colin.king@canonical.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: remove redundant
 assignment to ret
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: remove redundant
 assignment to ret
Thread-Index: AQHVLD0mdKJKZlZQqUCpEjW4XqxaaqausuBA
Date:   Thu, 27 Jun 2019 01:15:39 +0000
Message-ID: <TYAPR01MB4544D0BC2802B2F914153190D8FD0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20190626163517.18530-1-colin.king@canonical.com>
In-Reply-To: <20190626163517.18530-1-colin.king@canonical.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b87bb337-658e-4f29-1bfa-08d6fa9cf803
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB3887;
x-ms-traffictypediagnostic: TYAPR01MB3887:
x-microsoft-antispam-prvs: <TYAPR01MB38871BF6619BEB0713B0DED0D8FD0@TYAPR01MB3887.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(68736007)(54906003)(8676002)(478600001)(71190400001)(256004)(11346002)(316002)(74316002)(2501003)(4744005)(99286004)(53936002)(7696005)(66476007)(7736002)(52536014)(9686003)(81166006)(81156014)(8936002)(86362001)(14454004)(73956011)(229853002)(66446008)(76116006)(110136005)(6436002)(305945005)(55016002)(64756008)(3846002)(486006)(4326008)(2906002)(71200400001)(66556008)(6116002)(33656002)(446003)(6246003)(66066001)(5660300002)(25786009)(66946007)(76176011)(26005)(186003)(102836004)(476003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3887;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6nWM5R7XYEQz1XCEqJllsluIarH7jrF/kmYAaLAlvegB7y5HHpT+BVgwTZJjWrZa78i6WLlH1LPRCGw6+gMD/gYMoQyRhARqof7vWhaeEoTD0ZsHI/l6U69av7qbtGWgzlelSeIamDTDqWNgoxXgegKL8BEfgplq4Fk2gA5kbbzQtpY+npjU8No0ppOEo1BE38wKR7pI6vo6+0mQq/DOAfp/pJbhpt0byWhaWCQPb7owBP+VfCeaty+kGBpvcCj9u/M24lgGszDxHeWDbEgTKmPfFdqZU3cHMSUoaUItEm0PtVVWkfyjO+YCvisW+o0CQJWcDT8XbSXowpJS7rZC2RyDLhQ41Oi5IDAjIRt8bIKacgvfjt6Jpi45DsoHmKfOrM5w+g1tZNBjZ3Njl2iWMn8w26ELHa6ZdZA9A+u0GSo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87bb337-658e-4f29-1bfa-08d6fa9cf803
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 01:15:39.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNCj4gRnJvbTogQ29saW4gS2luZywgU2VudDogVGh1cnNkYXksIEp1bmUgMjcs
IDIwMTkgMTozNSBBTQ0KPiANCj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fu
b25pY2FsLmNvbT4NCj4gDQo+IFZhcmlhYmxlIHJldCBpcyBiZWluZyBpbml0aWFsaXplZCB3aXRo
IGEgdmFsdWUgdGhhdCBpcyBuZXZlciByZWFkIGFuZA0KPiByZXQgaXMgYmVpbmcgcmUtYXNzaWdu
ZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIGluaXRpYWxpemF0aW9uIGluIGJvdGgNCj4gcGF0aHMg
b2YgYW4gaWYgc3RhdGVtZW50LiBUaGlzIGlzIHJlZHVuZGFudCBhbmQgY2FuIGJlIHJlbW92ZWQu
DQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiVW51c2VkIHZhbHVlIikNCj4gU2lnbmVkLW9m
Zi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCg0KVGhhbmsg
eW91IGZvciB0aGUgcGF0Y2ghDQoNClJldmlld2VkLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9z
aGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGly
byBTaGltb2RhDQoNCg==
