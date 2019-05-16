Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9EC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F1220862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="P+a0m83w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfEPJbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:31:11 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:59230
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbfEPJbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN/0cKwExxFWXT6NQchMF8Gmsom+mwEEgXD/ZVEj/u0=;
 b=P+a0m83wis7oQtEDNU69rXgc9TYo9enhuBY7/GSAt3de46EhBNJC6ZE/QSkZgiVEcYw3VBy9vI9WaAuT0wwUStZCO7dpKbrsK9syQs+taz+RqC5sLrPdvzbEj1PuxCS9jL85QAWlQAE4LmswL3pVfcf/gr4YN1PSptlYeIhI0U0=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB2878.eurprd08.prod.outlook.com (10.170.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 09:31:05 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf%3]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 09:31:05 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: vt6656: remove unused variable
Thread-Topic: [PATCH] staging: vt6656: remove unused variable
Thread-Index: AQHVC8oVWbJV7t4C7kCfosLx3wTTvA==
Date:   Thu, 16 May 2019 09:31:05 +0000
Message-ID: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b7::26) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 928aa406-891d-4716-b106-08d6d9e13809
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB2878;
x-ms-traffictypediagnostic: VI1PR08MB2878:
x-microsoft-antispam-prvs: <VI1PR08MB28788C91A0833A8C9AAFFB6EB30A0@VI1PR08MB2878.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39830400003)(366004)(376002)(396003)(136003)(199004)(189003)(8936002)(508600001)(316002)(44832011)(81166006)(81156014)(86362001)(6116002)(3846002)(8676002)(66066001)(6436002)(68736007)(2906002)(486006)(6486002)(476003)(5640700003)(6512007)(50226002)(2616005)(2351001)(74482002)(4326008)(71200400001)(71190400001)(52116002)(186003)(99286004)(1076003)(4744005)(386003)(6506007)(73956011)(66446008)(102836004)(64756008)(66946007)(66476007)(66556008)(36756003)(5660300002)(54906003)(26005)(2501003)(25786009)(305945005)(7736002)(6916009)(256004)(14444005)(14454004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2878;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Uc1wjTTew1fxAxF0ZvWS05YqsqSxLbODNpOVHjZjqEwUWQQxTP3KLBIUwnkZPCk+lploRMebw5clxygvBt7qQ1hEqUmBmH871DfO7ijTGPx+60ORcuB62ycm6t9fLnbELl3ZO7Wj/ZNJ4mcIZ6iO2lK1eDdl/q5qczpn/npZFi1x8/z21/2Qj5dVpQ2AR+ApHK3HoMtlFKP2ckncLgkxi9Mt1o9vWBOQnsFCLT/poamKu3wqZY9SBnhIxyrQ6zUQs6Xttuq6REYsKkAtLyOCY5Q0QyHHF+p8GXc0RQVmw5JAvU9pF1yLb9AG+p8AhE1WV4gbNGGO+UO4YjSpYOYlTePINmU/VLZYWnIErRmxfWvK87iz26O016W2+XOpCYHwvRuuuVk9NzmV/dkPKOlViNes9IrSdSR+KJuebO7NL7o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 928aa406-891d-4716-b106-08d6d9e13809
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 09:31:05.5385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4ZWQgJ3NldCBidXQgbm90IHVzZWQnIHdhcm5pbmcgbWVzc2FnZSBvbiBhIHN0YXR1cyB2YXJp
YWJsZS4gVGhlDQpjYWxsZWQgZnVuY3Rpb24gcmV0dXJuaW5nIHRoZSBzdGF0dXMgY29kZSAndm50
X3N0YXJ0X2ludGVycnVwdF91cmIoKScNCmNsZWFuIHVwIGFmdGVyIGl0c2VsZiBhbmQgdGhlIGNh
bGxlciBmdW5jdGlvbg0KJ3ZudF9pbnRfc3RhcnRfaW50ZXJydXB0KCknIGRvZXMgbm90IHJldHVy
bnMgYW55IHZhbHVlLg0KDQpTaWduZWQtb2ZmLWJ5OiBRdWVudGluIERlc2xhbmRlcyA8cXVlbnRp
bi5kZXNsYW5kZXNAaXRkZXYuY28udWs+DQotLS0NCiBkcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2lu
dC5jIHwgMyArLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2ludC5jIGIvZHJpdmVy
cy9zdGFnaW5nL3Z0NjY1Ni9pbnQuYw0KaW5kZXggNTA0NDI0YjE5ZmNmLi5hYzMwY2U3MmRiNWEg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2ludC5jDQorKysgYi9kcml2ZXJz
L3N0YWdpbmcvdnQ2NjU2L2ludC5jDQpAQCAtNDIsMTMgKzQyLDEyIEBAIHN0YXRpYyBjb25zdCB1
OCBmYWxsYmFja19yYXRlMVs1XVs1XSA9IHsNCiB2b2lkIHZudF9pbnRfc3RhcnRfaW50ZXJydXB0
KHN0cnVjdCB2bnRfcHJpdmF0ZSAqcHJpdikNCiB7DQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQot
CWludCBzdGF0dXM7DQogDQogCWRldl9kYmcoJnByaXYtPnVzYi0+ZGV2LCAiLS0tLT5JbnRlcnJ1
cHQgUG9sbGluZyBUaHJlYWRcbiIpOw0KIA0KIAlzcGluX2xvY2tfaXJxc2F2ZSgmcHJpdi0+bG9j
aywgZmxhZ3MpOw0KIA0KLQlzdGF0dXMgPSB2bnRfc3RhcnRfaW50ZXJydXB0X3VyYihwcml2KTsN
CisJdm50X3N0YXJ0X2ludGVycnVwdF91cmIocHJpdik7DQogDQogCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnByaXYtPmxvY2ssIGZsYWdzKTsNCiB9DQotLSANCjIuMTcuMQ0KDQo=
