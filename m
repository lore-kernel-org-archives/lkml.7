Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD630C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC11217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfEUMQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:16:19 -0400
Received: from mail-oln040092065088.outbound.protection.outlook.com ([40.92.65.88]:51175
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbfEUMQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:16:18 -0400
Received: from VE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (10.152.2.54) by VE1EUR01HT145.eop-EUR01.prod.protection.outlook.com
 (10.152.3.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Tue, 21 May
 2019 12:16:14 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.2.54) by
 VE1EUR01FT058.mail.protection.outlook.com (10.152.3.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1900.16 via Frontend Transport; Tue, 21 May 2019 12:16:14 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 12:16:14 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: Remove unused variable
Thread-Topic: [PATCH] clk: Remove unused variable
Thread-Index: AQHVD878NH4niKcAbkGQS1Zq+TuwCg==
Date:   Tue, 21 May 2019 12:16:14 +0000
Message-ID: <VI1PR07MB44324648C54773C24E4B186AFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0045.namprd02.prod.outlook.com
 (2603:10b6:301:73::22) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:AC1CDF9B7E0587675D62C5068EBBAEEFEC3198AA2838AA2DEEEB372B33E36057;UpperCasedChecksum:F12575AB9399412C42B53289C4DC711B69F7A80BEF1B18AF3232D82A69D6696A;SizeAsReceived:7733;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [nJ1juxtnP1Zcdux7epdSyzoGFywwolgO]
x-microsoft-original-message-id: <20190521121547.119863-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR01HT145;
x-ms-traffictypediagnostic: VE1EUR01HT145:
x-microsoft-antispam-message-info: BQrbwy9gZ2t/mX75oj20cZ9Gt8TciHH9LYQqfCp6YoTF9coVOiYEvbFj1P00OhCK40PNBwo30sfRKUfqGnv/Oy98rwCjTeubSBDzbzyV44SX9qVdDIXCZvQqwcDzxK5W8AUeMmmcZX4XHiSrLdnBvmRLpw6xTLROGrlN46PO5/3/+IYJ/bLymd5NwtWq5Udd
Content-Type: text/plain; charset="utf-8"
Content-ID: <A735F365BEE52F4FB81877FF849B6A63@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b43d6e31-bbb0-4f49-bcfd-08d6dde61e20
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 12:16:14.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT145
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VmFyaWFibGUgJ2RkcnBoeWNmZ19wYXJlbnRzJyBpcyBkZWZpbmVkIHN0YXRpYyBhbmQgaW5pdGlh
bGl6ZWQsIGJ1dCBub3QNCnVzZWQgaW4gdGhlIGZpbGUuDQoNCi4uL2RyaXZlcnMvY2xrL21lZGlh
dGVrL2Nsay1tdDg1MTYuYzoyMzQ6Mjc6IHdhcm5pbmc6IOKAmGRkcnBoeWNmZ19wYXJlbnRz4oCZ
IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dDQogc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdCBkZHJwaHljZmdfcGFyZW50c1tdIF9faW5pdGNvbnN0ID0gew0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9m
Zi1ieTogUGhpbGlwcGUgTWF6ZW5hdWVyIDxwaGlsaXBwZS5tYXplbmF1ZXJAb3V0bG9vay5kZT4N
Ci0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDg1MTYuYyB8IDUgLS0tLS0NCiAxIGZp
bGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdDg1MTYuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDg1MTYuYw0K
aW5kZXggMjZmZTQzY2M5ZWEyLi45ZDQyNjFlY2M3NjAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstbXQ4NTE2LmMNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1t
dDg1MTYuYw0KQEAgLTIzMSwxMSArMjMxLDYgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBu
ZmkxeF9wYWRfcGFyZW50c1tdIF9faW5pdGNvbnN0ID0gew0KIAkibmZpMXhfY2siDQogfTsNCiAN
Ci1zdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGRkcnBoeWNmZ19wYXJlbnRzW10gX19pbml0Y29u
c3QgPSB7DQotCSJjbGsyNm1fY2siLA0KLQkibWFpbnBsbF9kMTYiDQotfTsNCi0NCiBzdGF0aWMg
Y29uc3QgY2hhciAqIGNvbnN0IHVzYl83OG1fcGFyZW50c1tdIF9faW5pdGNvbnN0ID0gew0KIAki
Y2xrX251bGwiLA0KIAkiY2xrMjZtX2NrIiwNCi0tIA0KMi4xNy4xDQoNCg==
