Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170DEC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEC52070D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfEVKAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:00:01 -0400
Received: from mail-oln040092071070.outbound.protection.outlook.com ([40.92.71.70]:50087
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfEVJ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:59:58 -0400
Received: from VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (10.152.18.57) by VE1EUR03HT110.eop-EUR03.prod.protection.outlook.com
 (10.152.19.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Wed, 22 May
 2019 09:59:56 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.18.60) by
 VE1EUR03FT044.mail.protection.outlook.com (10.152.19.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 09:59:56 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 09:59:52 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: kexec: Make function static
Thread-Topic: [PATCH] arm: kexec: Make function static
Thread-Index: AQHVEIUZgDg7hS40xUq+6eBVL19VIg==
Date:   Wed, 22 May 2019 09:59:52 +0000
Message-ID: <VI1PR07MB443291A1A53B11863CC94CF2FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:104:5::14) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:9142456758F54D39B48F89E39745417DE4858B598A4A4642D51B4949F38FC9BA;UpperCasedChecksum:673D0B77AC37DD197533B001F0229245E98729DDA58EB21241DBD1DE73F31F60;SizeAsReceived:7446;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [N+ZqhKH1FPuF8bK7tTriPAl46xXok0HX]
x-microsoft-original-message-id: <20190522095930.157843-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT110;
x-ms-traffictypediagnostic: VE1EUR03HT110:
x-microsoft-antispam-message-info: eS9mnvW9kHXHBBWNTG9JZafcO8zVJPEQAWqDW3RrlqB5J/XLPlW5PYAyq7MzzS2ZvWeSyjOkEOk+A6PshOjMyqJlOGW2dIHCV3VsIGbrsd8spimjIQ2U5JdcusrQAC029JFwqg13iL/Y1ngrE0QH+TB9LGia7nYat3apUdC9i2P/3K5ZoW3Uf8sbLIY/dThr
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1A48A595A058F458EE05BA24C232FBE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dab1e480-4559-47e7-9221-08d6de9c3c0d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:59:52.7398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT110
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFrZSBmdW5jdGlvbiBtYWNoaW5lX2NyYXNoX25vbnBhbmljX2NvcmUoKSBzdGF0aWMsIGFzIGl0
IGlzIG9ubHkNCnJlZmVyZW5jZWQgaW4gdGhpcyBmaWxlLg0KDQouLi9hcmNoL2FybS9rZXJuZWwv
bWFjaGluZV9rZXhlYy5jOjgyOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig
4oCYbWFjaGluZV9jcmFzaF9ub25wYW5pY19jb3Jl4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10N
CiB2b2lkIG1hY2hpbmVfY3Jhc2hfbm9ucGFuaWNfY29yZSh2b2lkICp1bnVzZWQpDQogICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF6
ZW5hdWVyIDxwaGlsaXBwZS5tYXplbmF1ZXJAb3V0bG9vay5kZT4NCi0tLQ0KIGFyY2gvYXJtL2tl
cm5lbC9tYWNoaW5lX2tleGVjLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9rZXJuZWwvbWFjaGlu
ZV9rZXhlYy5jIGIvYXJjaC9hcm0va2VybmVsL21hY2hpbmVfa2V4ZWMuYw0KaW5kZXggNzYzMDBm
MzgxM2U4Li4yNDU2MjE1NzM4MDIgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9rZXJuZWwvbWFjaGlu
ZV9rZXhlYy5jDQorKysgYi9hcmNoL2FybS9rZXJuZWwvbWFjaGluZV9rZXhlYy5jDQpAQCAtNzks
NyArNzksNyBAQCB2b2lkIG1hY2hpbmVfa2V4ZWNfY2xlYW51cChzdHJ1Y3Qga2ltYWdlICppbWFn
ZSkNCiB7DQogfQ0KIA0KLXZvaWQgbWFjaGluZV9jcmFzaF9ub25wYW5pY19jb3JlKHZvaWQgKnVu
dXNlZCkNCitzdGF0aWMgdm9pZCBtYWNoaW5lX2NyYXNoX25vbnBhbmljX2NvcmUodm9pZCAqdW51
c2VkKQ0KIHsNCiAJc3RydWN0IHB0X3JlZ3MgcmVnczsNCiANCi0tIA0KMi4xNy4xDQoNCg==
