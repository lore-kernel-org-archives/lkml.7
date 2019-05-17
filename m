Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00766C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9FF2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfEQKlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:41:22 -0400
Received: from mail-oln040092067080.outbound.protection.outlook.com ([40.92.67.80]:21463
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbfEQKlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:41:21 -0400
Received: from AM5EUR02FT015.eop-EUR02.prod.protection.outlook.com
 (10.152.8.57) by AM5EUR02HT137.eop-EUR02.prod.protection.outlook.com
 (10.152.9.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11; Fri, 17 May
 2019 10:41:18 +0000
Received: from AM0PR07MB4417.eurprd07.prod.outlook.com (10.152.8.53) by
 AM5EUR02FT015.mail.protection.outlook.com (10.152.8.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16 via Frontend Transport; Fri, 17 May 2019 10:41:18 +0000
Received: from AM0PR07MB4417.eurprd07.prod.outlook.com
 ([fe80::9046:9a59:4519:d984]) by AM0PR07MB4417.eurprd07.prod.outlook.com
 ([fe80::9046:9a59:4519:d984%3]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 10:41:18 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] rcu: Remove unused variable
Thread-Topic: [PATCH] rcu: Remove unused variable
Thread-Index: AQHVDJ0PaytwmI+cjkO4D+WVtF6z0Q==
Date:   Fri, 17 May 2019 10:41:18 +0000
Message-ID: <AM0PR07MB4417DD6F49126041FFC18864FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To AM0PR07MB4417.eurprd07.prod.outlook.com
 (2603:10a6:208:b8::26)
x-incomingtopheadermarker: OriginalChecksum:33A003E4205DE6DDA650AAB83182455DED3AD86DA580A7F85906A817FEAC7FB1;UpperCasedChecksum:F73777195E42FA6D16F0B4FDE304236849D2C80CC7278501C6FFCE5797F0817A;SizeAsReceived:7687;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [izYu5eZZWdk23ffCP/JKispLyHTtTt9b]
x-microsoft-original-message-id: <20190517104032.26157-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT137;
x-ms-traffictypediagnostic: AM5EUR02HT137:
x-microsoft-antispam-message-info: 7P5bXffb1m6GXx6rMc5tzRtFGmLDC4Hjrq9SK8ddRc+K3aRlh6fnaS8tTvfXsrzE7Zaaq/nh+uNs4cpywetZ5e+vzpT95lxGTJUveCxoH3PX+H0tlVC0SEZ8lMFZpyQLZtyoiADkukL4Za1P3heUk7XjtICak+bGRUc8JBb9GY7BurdrT+/13And5QRGiT0S
Content-Type: text/plain; charset="utf-8"
Content-ID: <670F3AF570FAFF499022D46B5FFDFA4A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a29653-80e7-4422-3c9e-08d6dab43166
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 10:41:18.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT137
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VmFyaWFibGUgJ3JkcCcgaXMgc2V0IGJ1dCBub3QgdXNlZCBpbiBzeW5jaHJvbml6ZV9yY3VfZXhw
aWRpdGVkKCkuIFRoZQ0KbWFjcm8gcGVyX2NwdV9wdHIoKSB1c2VkIHRvIHNldCB0aGUgdmFsdWUg
b2YgJ3JkcCcgaGFzIG5vIHNpZGUgZWZmZWN0Lg0KDQouLi9rZXJuZWwvcmN1L3RyZWVfZXhwLmg6
NzY4OjE5OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhyZHDigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCiAgIHN0cnVjdCByY3VfZGF0YSAqcmRwOw0KICAgICAg
ICAgICAgICAgICAgICBefn4NCg0KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF6ZW5hdWVyIDxw
aGlsaXBwZS5tYXplbmF1ZXJAb3V0bG9vay5kZT4NCi0tLQ0KIGtlcm5lbC9yY3UvdHJlZV9leHAu
aCB8IDIgLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2tlcm5lbC9yY3UvdHJlZV9leHAuaCBiL2tlcm5lbC9yY3UvdHJlZV9leHAuaA0KaW5kZXggOWM5
OTBkZjg4MGQxLi40MWY1NmI2MDY1YzYgMTAwNjQ0DQotLS0gYS9rZXJuZWwvcmN1L3RyZWVfZXhw
LmgNCisrKyBiL2tlcm5lbC9yY3UvdHJlZV9leHAuaA0KQEAgLTc2NSw3ICs3NjUsNiBAQCBzdGF0
aWMgaW50IHJjdV9wcmludF90YXNrX2V4cF9zdGFsbChzdHJ1Y3QgcmN1X25vZGUgKnJucCkNCiAg
Ki8NCiB2b2lkIHN5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQodm9pZCkNCiB7DQotCXN0cnVjdCBy
Y3VfZGF0YSAqcmRwOw0KIAlzdHJ1Y3QgcmN1X2V4cF93b3JrIHJldzsNCiAJc3RydWN0IHJjdV9u
b2RlICpybnA7DQogCXVuc2lnbmVkIGxvbmcgczsNCkBAIC04MDIsNyArODAxLDYgQEAgdm9pZCBz
eW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKHZvaWQpDQogCX0NCiANCiAJLyogV2FpdCBmb3IgZXhw
ZWRpdGVkIGdyYWNlIHBlcmlvZCB0byBjb21wbGV0ZS4gKi8NCi0JcmRwID0gcGVyX2NwdV9wdHIo
JnJjdV9kYXRhLCByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCiAJcm5wID0gcmN1X2dldF9yb290
KCk7DQogCXdhaXRfZXZlbnQocm5wLT5leHBfd3FbcmN1X3NlcV9jdHIocykgJiAweDNdLA0KIAkJ
ICAgc3luY19leHBfd29ya19kb25lKHMpKTsNCi0tIA0KMi4xNy4xDQoNCg==
