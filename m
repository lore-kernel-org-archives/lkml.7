Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D28EC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAAC20675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfEVJws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:52:48 -0400
Received: from mail-oln040092070055.outbound.protection.outlook.com ([40.92.70.55]:34485
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728424AbfEVJwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:52:47 -0400
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (10.152.20.54) by DB5EUR03HT051.eop-EUR03.prod.protection.outlook.com
 (10.152.21.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Wed, 22 May
 2019 09:52:44 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.20.58) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 09:52:44 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 09:52:44 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: arch_timer: add missing include <asm/arch_timer.h>
Thread-Topic: [PATCH] arm: arch_timer: add missing include <asm/arch_timer.h>
Thread-Index: AQHVEIQaLSPiDAkMGkqrMzxROUApjg==
Date:   Wed, 22 May 2019 09:52:44 +0000
Message-ID: <VI1PR07MB44325686CBB7085417C6754BFD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17)
 To VI1PR07MB4432.eurprd07.prod.outlook.com (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:D45B6809606F275CE0756F5625A90A7E788ECA32AE6DEAF2CC6933905CD9724E;UpperCasedChecksum:56C7425290EDACB7D2138C04EE7A86B74904D25CEB97A64C5D6910A939672725;SizeAsReceived:7447;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [WCI34R2IF49cDwn7cRyyIVXlQeIw9VJw]
x-microsoft-original-message-id: <20190522095223.157574-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT051;
x-ms-traffictypediagnostic: DB5EUR03HT051:
x-microsoft-antispam-message-info: 1RU92cdUtwPNOet+Ih5mpomM4BaC+2qvg27bRF8YHJlSKwRWwcb3L/g7y9iUH9t+Us1tvyL1xbrv/QQAwsGlfrtWEdilWl1YwxvucaYTfdw6CFNJk5O8T1A+R991mKtEx+bIqf56gJLZMOVOT2ymY/RcgS5d8LneW+ZnZTwiIVKo+z8tbYC23ADywmZulFHg
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9C1413FBFF368459A62E0CFFD61BC5B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f53bd173-624a-48d6-e848-08d6de9b3cba
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:52:44.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT051
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
