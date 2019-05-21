Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77363C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B1E21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfEUP4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:56:49 -0400
Received: from mail-oln040092068019.outbound.protection.outlook.com ([40.92.68.19]:44342
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727941AbfEUP4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:56:49 -0400
Received: from HE1EUR02FT018.eop-EUR02.prod.protection.outlook.com
 (10.152.10.56) by HE1EUR02HT039.eop-EUR02.prod.protection.outlook.com
 (10.152.10.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Tue, 21 May
 2019 15:56:45 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.10.56) by
 HE1EUR02FT018.mail.protection.outlook.com (10.152.10.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1900.16 via Frontend Transport; Tue, 21 May 2019 15:56:45 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 15:56:45 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: arch_timer: add missing include <asm/arch_timer.h>
Thread-Topic: [PATCH] arm: arch_timer: add missing include <asm/arch_timer.h>
Thread-Index: AQHVD+3KlWo8uLaBL0Om+aRELQJgnw==
Date:   Tue, 21 May 2019 15:56:45 +0000
Message-ID: <VI1PR07MB443278198DB7B722332BF19EFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:104:1::34) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:186E5CFB7B24037E55ED5B9FFCB2EC106609FE42483C1837CB115A039DD7DA49;UpperCasedChecksum:A469A90C7B9CA5EA58B6ECC21A3510A7C0F06828EC1395F3A28DE01644CEB9D2;SizeAsReceived:7465;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [TQcm3/Y3dd47esT1vuBKNil4lmYimqOs]
x-microsoft-original-message-id: <20190521155618.176880-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HE1EUR02HT039;
x-ms-traffictypediagnostic: HE1EUR02HT039:
x-microsoft-antispam-message-info: BH6Gp5RW9aEaoCSw8Ec+Miuidkrbu2klVned73NOyXRJi1Lr6oSxUcpV6SSi1zHNSO1DSPe3hrQvflh1okQTxc/5bG69l7J1Z22gXTFYvOW66f7sWExH2Be7Li8honf9FuXsCFhPVMhGxmqh2woHSKHFUK8NFEnL1YnPyagBIQ3zqpjgBGJIzevi+T58PKXl
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F6827F23A99554DBCA2F4794F2D09C6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d939cc-3911-4733-95ae-08d6de04eccd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 15:56:45.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT039
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW5jbHVkZSBjb3JyZXNwb25pbmcgaGVhZGVyIGZpbGUgPGFzbS9hcmNoX3RpbWVyLmg+IGZvciBm
dW5jdGlvbg0KYXJjaF90aW1lcl9hcmNoX2luaXQoKS4NCg0KLi4vYXJjaC9hcm0va2VybmVsL2Fy
Y2hfdGltZXIuYzozNDoxMjogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhh
cmNoX3RpbWVyX2FyY2hfaW5pdOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQogaW50IF9faW5p
dCBhcmNoX3RpbWVyX2FyY2hfaW5pdCh2b2lkKQ0KICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF6ZW5hdWVyIDxwaGlsaXBwZS5tYXpl
bmF1ZXJAb3V0bG9vay5kZT4NCi0tLQ0KIGFyY2gvYXJtL2tlcm5lbC9hcmNoX3RpbWVyLmMgfCAx
ICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2tlcm5lbC9hcmNoX3RpbWVyLmMgYi9hcmNoL2FybS9rZXJuZWwvYXJjaF90aW1lci5jDQpp
bmRleCAxNzkxZjEyYzE4MGIuLmY5ZTdmNWI0YjE3NSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2tl
cm5lbC9hcmNoX3RpbWVyLmMNCisrKyBiL2FyY2gvYXJtL2tlcm5lbC9hcmNoX3RpbWVyLmMNCkBA
IC0xMyw2ICsxMyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+DQogDQogI2luY2x1ZGUg
PGFzbS9kZWxheS5oPg0KKyNpbmNsdWRlIDxhc20vYXJjaF90aW1lci5oPg0KIA0KICNpbmNsdWRl
IDxjbG9ja3NvdXJjZS9hcm1fYXJjaF90aW1lci5oPg0KIA0KLS0gDQoyLjE3LjENCg0K
