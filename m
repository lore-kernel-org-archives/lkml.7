Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D29C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB6F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfEVJ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:57:15 -0400
Received: from mail-oln040092070010.outbound.protection.outlook.com ([40.92.70.10]:51862
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbfEVJ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:57:14 -0400
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (10.152.20.54) by DB5EUR03HT062.eop-EUR03.prod.protection.outlook.com
 (10.152.21.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Wed, 22 May
 2019 09:57:11 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.20.58) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 09:57:11 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 09:57:11 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: kernel: add missing import <linux/moduleloader.h>
Thread-Topic: [PATCH] arm: kernel: add missing import <linux/moduleloader.h>
Thread-Index: AQHVEIS5JK/wZFGeW0ysj4hc5NEdmQ==
Date:   Wed, 22 May 2019 09:57:11 +0000
Message-ID: <VI1PR07MB443223E9DBAF0354739AA194FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:104:2::26) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:0EBD54CD39B947CFB26840CC790FA00BE209348308C9BD1E1E04BD5EE7645C2D;UpperCasedChecksum:EE1ABD9FF380C1EDF3BE532FC7AFC0E0E37C84844EE9CA122273D302D385E886;SizeAsReceived:7461;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [5JF0WqkuAb62rehId9iJYhLqbNXcWaaU]
x-microsoft-original-message-id: <20190522095649.157754-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT062;
x-ms-traffictypediagnostic: DB5EUR03HT062:
x-microsoft-antispam-message-info: LrtC/klUwxm4PSfz7sM6of9DNep7vpTwU81yRq/RXWSizKCwkUqVkFbAO+VKUIuCeG7+Tf7HjkPzRamvt/g2DHtf4djX0eKVrLPMwW5bWIz4+L9yKaT7XLK4nqjAyRZxg29Tp/1e0XXB6nLqQOiZgrMNmk0ZEfQH7raUicCsGTpZ+r/iaHYW8zoufRC6Sy77
Content-Type: text/plain; charset="utf-8"
Content-ID: <45B2D72F8C04944F8780B02BA9D8F266@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f0367c-1455-4098-fe91-08d6de9bdc1c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:57:11.7486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT062
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW5jbHVkZSBjb3JyZXNwb25kaW5nIGhlYWRlciBmaWxlIDxsaW51eC9tb2R1bGVsb2FkZXIuaD4g
Zm9yIGZ1bmN0aW9uDQptb2R1bGVfZnJvYl9hcmNoX3NlY3Rpb25zKCkuDQoNCi4uL2FyY2gvYXJt
L2tlcm5lbC9tb2R1bGUtcGx0cy5jOjE5MTo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5
cGUgZm9yIOKAmG1vZHVsZV9mcm9iX2FyY2hfc2VjdGlvbnPigJkgWy1XbWlzc2luZy1wcm90b3R5
cGVzXQ0KIGludCBtb2R1bGVfZnJvYl9hcmNoX3NlY3Rpb25zKEVsZl9FaGRyICplaGRyLCBFbGZf
U2hkciAqc2VjaGRycywNCiAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQpTaWduZWQt
b2ZmLWJ5OiBQaGlsaXBwZSBNYXplbmF1ZXIgPHBoaWxpcHBlLm1hemVuYXVlckBvdXRsb29rLmRl
Pg0KLS0tDQogYXJjaC9hcm0va2VybmVsL21vZHVsZS1wbHRzLmMgfCAxICsNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2tlcm5lbC9tb2R1
bGUtcGx0cy5jIGIvYXJjaC9hcm0va2VybmVsL21vZHVsZS1wbHRzLmMNCmluZGV4IDNkMGMyZTRk
ZGExZC4uMzcyNWVjY2RhYTczIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0va2VybmVsL21vZHVsZS1w
bHRzLmMNCisrKyBiL2FyY2gvYXJtL2tlcm5lbC9tb2R1bGUtcGx0cy5jDQpAQCAtOSw2ICs5LDcg
QEANCiAjaW5jbHVkZSA8bGludXgvZWxmLmg+DQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0K
ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCisjaW5jbHVkZSA8bGludXgvbW9kdWxlbG9hZGVy
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3NvcnQuaD4NCiANCiAjaW5jbHVkZSA8YXNtL2NhY2hlLmg+
DQotLSANCjIuMTcuMQ0KDQo=
