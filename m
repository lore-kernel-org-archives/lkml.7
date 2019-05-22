Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C695C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3822070D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfEVJy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:54:59 -0400
Received: from mail-oln040092071057.outbound.protection.outlook.com ([40.92.71.57]:33014
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfEVJy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:54:59 -0400
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (10.152.20.53) by DB5EUR03HT105.eop-EUR03.prod.protection.outlook.com
 (10.152.20.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16; Wed, 22 May
 2019 09:54:56 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.20.58) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 09:54:56 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 09:54:56 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM SUB-ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: highbank: add missing include "core.h"
Thread-Topic: [PATCH] arm: highbank: add missing include "core.h"
Thread-Index: AQHVEIRpwlbR+xaFOESZgvN+063LTQ==
Date:   Wed, 22 May 2019 09:54:56 +0000
Message-ID: <VI1PR07MB443237D908B62034AD42B47CFD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:207:3d::39) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:EFD166EDB3D22A56C729BF36814128BF21DAAC513C4A7AE5E4DFFAD14975E30B;UpperCasedChecksum:BC61C0A1C5417C4FF375B49158F35D2AFBE82EE64DF7F73B28A7A1F8CD58D805;SizeAsReceived:7491;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [YWasQwWfgd3qdc3fjycWOG6+dGWXGbrR]
x-microsoft-original-message-id: <20190522095439.157660-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT105;
x-ms-traffictypediagnostic: DB5EUR03HT105:
x-microsoft-antispam-message-info: xYmJ6QscMMh/pz4+i0C9M/9ff3zHqF4AZ3Vzsx8vnJYYT6+NX6KT8jfQeNxFU79x9FzHCKen16qqz6vnb/sWgMtNL3bjx2DE4aqjjK71m+Rqy+3RUVcCJK6uHR/Rvzunsdm4RbY6bldhXXs62G/WWe1FO6RGl7LyjyZXMxil7qDMoAym57/b6LvOAUk4OhGn
Content-Type: text/plain; charset="utf-8"
Content-ID: <20033042072E864BAFAC38291B72E09E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a4099f-384d-464c-62fb-08d6de9b8b7b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:54:56.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT105
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW5jbHVkZSBjb3JyZXNwb25kaW5nIGhlYWRlciBmaWxlICJjb3JlLmgiIGZvciBmdW5jdGlvbg0K
aGlnaGJhbmtfcG1faW5pdCgpLg0KDQouLi9hcmNoL2FybS9tYWNoLWhpZ2hiYW5rL3BtLmM6NTQ6
MTM6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYaGlnaGJhbmtfcG1faW5p
dOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQogdm9pZCBfX2luaXQgaGlnaGJhbmtfcG1faW5p
dCh2b2lkKQ0KICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
UGhpbGlwcGUgTWF6ZW5hdWVyIDxwaGlsaXBwZS5tYXplbmF1ZXJAb3V0bG9vay5kZT4NCi0tLQ0K
IGFyY2gvYXJtL21hY2gtaGlnaGJhbmsvcG0uYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWhpZ2hiYW5rL3BtLmMg
Yi9hcmNoL2FybS9tYWNoLWhpZ2hiYW5rL3BtLmMNCmluZGV4IDQwMDMxMTY5NTU0OC4uMzU4MGRk
ZTdjM2RhIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vbWFjaC1oaWdoYmFuay9wbS5jDQorKysgYi9h
cmNoL2FybS9tYWNoLWhpZ2hiYW5rL3BtLmMNCkBAIC0yMyw2ICsyMyw4IEBADQogDQogI2luY2x1
ZGUgPHVhcGkvbGludXgvcHNjaS5oPg0KIA0KKyNpbmNsdWRlICJjb3JlLmgiDQorDQogI2RlZmlu
ZSBISUdIQkFOS19TVVNQRU5EX1BBUkFNIFwNCiAJKCgwIDw8IFBTQ0lfMF8yX1BPV0VSX1NUQVRF
X0lEX1NISUZUKSB8IFwNCiAJICgxIDw8IFBTQ0lfMF8yX1BPV0VSX1NUQVRFX0FGRkxfU0hJRlQp
IHwgXA0KLS0gDQoyLjE3LjENCg0K
