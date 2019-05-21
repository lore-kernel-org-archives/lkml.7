Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C456C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC3921773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfEUO1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:27:24 -0400
Received: from mail-oln040092065105.outbound.protection.outlook.com ([40.92.65.105]:2176
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfEUO1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:27:23 -0400
Received: from VE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (10.152.2.52) by VE1EUR01HT097.eop-EUR01.prod.protection.outlook.com
 (10.152.3.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Tue, 21 May
 2019 14:27:20 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.2.55) by
 VE1EUR01FT021.mail.protection.outlook.com (10.152.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16 via Frontend Transport; Tue, 21 May 2019 14:27:20 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 14:27:20 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: add missing include <asm/system_misc.h>
Thread-Topic: [PATCH] arm: add missing include <asm/system_misc.h>
Thread-Index: AQHVD+FMaE/bAVrtFUKLj850TK7Gvg==
Date:   Tue, 21 May 2019 14:27:19 +0000
Message-ID: <VI1PR07MB44320C0A8BF43B054BA3D71CFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To VI1PR07MB4432.eurprd07.prod.outlook.com (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:3CF4B88603A15A4069E2F09216DCB3CEBB997CC6F99A476453F70487702EE3C6;UpperCasedChecksum:26227384BE2B2F1343F3162DEA6BF2BC7D4AEA5CD449C40C4BB19F8114E42A5C;SizeAsReceived:7432;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [2mBiuiP4HBnya3jsXfghEEZOM6+b//f2]
x-microsoft-original-message-id: <20190521142655.91715-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR01HT097;
x-ms-traffictypediagnostic: VE1EUR01HT097:
x-microsoft-antispam-message-info: sqnL2VwgmMW3r3TRfEDu4wLUy3/4r/xLG7jW4mXzvqtHlzDwaPSc4W3JtUfshApG5XytrbFKz/kjTvTasP/Kt6LArLYMVwWsyHgxRHFT+lRkU3VQzL0kjiYux9vO5H8OdyyCnY53OsspFFbvh8TnMrOymzXmlaEkGDYr9dabLL0ZonuYpGRJd71O44hxBca5
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C029BC30B4184D9F631839944CDD7A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: db677e2a-dfc4-47ac-7869-08d6ddf86e72
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 14:27:19.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT097
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW5jbHVkZSBjb3JyZXNwb25kaW5nIGhlYWRlciBmaWxlIDxhc20vc3lzdGVtX21pc2MuaD4gZm9y
IGZ1bmN0aW9uDQpzb2Z0X3Jlc3RhcnQoKS4NCg0KLi4vYXJjaC9hcm0va2VybmVsL3JlYm9vdC5j
OjgyOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYc29mdF9yZXN0YXJ0
4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10NCiB2b2lkIHNvZnRfcmVzdGFydCh1bnNpZ25lZCBs
b25nIGFkZHIpDQogICAgICBefn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUg
TWF6ZW5hdWVyIDxwaGlsaXBwZS5tYXplbmF1ZXJAb3V0bG9vay5kZT4NCi0tLQ0KIGFyY2gvYXJt
L2tlcm5lbC9yZWJvb3QuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2VybmVsL3JlYm9vdC5jIGIvYXJjaC9hcm0va2VybmVs
L3JlYm9vdC5jDQppbmRleCAzYjJhYTlhOWZlMjYuLjhhY2E2MWZhY2EzNyAxMDA2NDQNCi0tLSBh
L2FyY2gvYXJtL2tlcm5lbC9yZWJvb3QuYw0KKysrIGIvYXJjaC9hcm0va2VybmVsL3JlYm9vdC5j
DQpAQCAtMTAsNiArMTAsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KICNpbmNsdWRl
IDxsaW51eC9yZWJvb3QuaD4NCiANCisjaW5jbHVkZSA8YXNtL3N5c3RlbV9taXNjLmg+DQogI2lu
Y2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+DQogI2luY2x1ZGUgPGFzbS9pZG1hcC5oPg0KICNpbmNs
dWRlIDxhc20vdmlydC5oPg0KLS0gDQoyLjE3LjENCg0K
