Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3ADC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F002075E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfEVKDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:03:20 -0400
Received: from mail-oln040092071015.outbound.protection.outlook.com ([40.92.71.15]:38272
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbfEVKDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:03:20 -0400
Received: from DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (10.152.20.60) by DB5EUR03HT010.eop-EUR03.prod.protection.outlook.com
 (10.152.20.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16; Wed, 22 May
 2019 10:03:18 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.20.52) by
 DB5EUR03FT027.mail.protection.outlook.com (10.152.20.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 10:03:18 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 10:03:17 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: topology: make function static
Thread-Topic: [PATCH] arm: topology: make function static
Thread-Index: AQHVEIWUn/i0+75iwk+EnwEgRCDTcw==
Date:   Wed, 22 May 2019 10:03:17 +0000
Message-ID: <VI1PR07MB443207D4A7601168EC51C641FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:301:4c::12) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:B2CF39FDFDD89AAA0052F75E9B8DCBAE08792BD69B67008FB2B3B2D5119C3C7F;UpperCasedChecksum:62CEE253371D47573478AC960DC26245A833E06E5F2A90DC4E1016866B5C54CB;SizeAsReceived:7452;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [Te3Kow79IK5edHwUwcUouDi32pwLaVe6]
x-microsoft-original-message-id: <20190522100255.157960-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT010;
x-ms-traffictypediagnostic: DB5EUR03HT010:
x-microsoft-antispam-message-info: 8WLtpJQc7MTNj3jj1KRuaXfkIkyIa7N5x35J8RRDo42SAEmVXeaDD0jvvl7OWX45A4ruKddmCyy1MPQxiN4pu7uMU+eP9g2SYMs6A1APSklzIyI5AP//bDhUXzjMAxABBY0vqLsAK/bhAaVnio36tkyFDn1DTXzXAmJnYTzS53a+Q+X2sXm2/K1URtOz+9Nb
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B3C6BEBC5B5E94FB67AC814F0603D07@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b07c1ee-b58f-479c-6977-08d6de9cb660
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:03:17.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT010
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFrZSBmdW5jdGlvbiBjcHVfY29yZXBvd2VyX21hc2soKSBzdGF0aWMsIGFzIGl0IGlzIG9ubHkg
cmVmZXJlbmNlZCBpbg0KdGhpcyBmaWxlLg0KDQouLi9hcmNoL2FybS9rZXJuZWwvdG9wb2xvZ3ku
YzoxOTU6MjM6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYY3B1X2NvcmVw
b3dlcl9tYXNr4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10NCiBjb25zdCBzdHJ1Y3QgY3B1bWFz
ayAqY3B1X2NvcmVwb3dlcl9tYXNrKGludCBjcHUpDQogICAgICAgICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fg0KDQpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXplbmF1ZXIgPHBo
aWxpcHBlLm1hemVuYXVlckBvdXRsb29rLmRlPg0KLS0tDQogYXJjaC9hcm0va2VybmVsL3RvcG9s
b2d5LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9rZXJuZWwvdG9wb2xvZ3kuYyBiL2FyY2gvYXJt
L2tlcm5lbC90b3BvbG9neS5jDQppbmRleCA2MGUzNzVjZTFhYjIuLjVjODA3NWVjODA2NSAxMDA2
NDQNCi0tLSBhL2FyY2gvYXJtL2tlcm5lbC90b3BvbG9neS5jDQorKysgYi9hcmNoL2FybS9rZXJu
ZWwvdG9wb2xvZ3kuYw0KQEAgLTE5Miw3ICsxOTIsNyBAQCBjb25zdCBzdHJ1Y3QgY3B1bWFzayAq
Y3B1X2NvcmVncm91cF9tYXNrKGludCBjcHUpDQogICogVGhlIGN1cnJlbnQgYXNzdW1wdGlvbiBp
cyB0aGF0IHdlIGNhbiBwb3dlciBnYXRlIGVhY2ggY29yZSBpbmRlcGVuZGVudGx5Lg0KICAqIFRo
aXMgd2lsbCBiZSBzdXBlcnNlZGVkIGJ5IERUIGJpbmRpbmcgb25jZSBhdmFpbGFibGUuDQogICov
DQotY29uc3Qgc3RydWN0IGNwdW1hc2sgKmNwdV9jb3JlcG93ZXJfbWFzayhpbnQgY3B1KQ0KK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqY3B1X2NvcmVwb3dlcl9tYXNrKGludCBjcHUpDQog
ew0KIAlyZXR1cm4gJmNwdV90b3BvbG9neVtjcHVdLnRocmVhZF9zaWJsaW5nOw0KIH0NCi0tIA0K
Mi4xNy4xDQoNCg==
