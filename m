Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0DDC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246CB20675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfEVJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:18:18 -0400
Received: from mail-oln040092072031.outbound.protection.outlook.com ([40.92.72.31]:29508
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbfEVJSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:18:18 -0400
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (10.152.18.56) by VE1EUR03HT069.eop-EUR03.prod.protection.outlook.com
 (10.152.19.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Wed, 22 May
 2019 09:18:14 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.18.55) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 09:18:14 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 09:18:14 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: Add missing method to asm/irq_work.h
Thread-Topic: [PATCH] arm: Add missing method to asm/irq_work.h
Thread-Index: AQHVEH9I7QiDXzMhvECKeuN2C3td2w==
Date:   Wed, 22 May 2019 09:18:14 +0000
Message-ID: <VI1PR07MB4432EEF1C469BE68BF1F1DA7FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1601CA0012.namprd16.prod.outlook.com
 (2603:10b6:300:da::22) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:7B409564C77F1D2A3E110E6EF3E316457909D8473D11FEF52362CAD2EC26832E;UpperCasedChecksum:9D90EAE8728F0930D4B6E330651CEDE43ED4C9774C4A9236058407059894C598;SizeAsReceived:7445;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [JtX3SCL8CK1gWfMohNhOYjqm1x3+TFT+]
x-microsoft-original-message-id: <20190522091746.132422-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT069;
x-ms-traffictypediagnostic: VE1EUR03HT069:
x-microsoft-antispam-message-info: FADARJh28q77mYtZqB9ED4VgPPelOSxvgSb8yrck/nOm5o78QoO9Bl2yvX8uMFLQE1FpvQNiKwgm5Yobkpjg9DTbdM+8yZ7BX9wH8pHyyff0u4Nr08ySyQk5dYyxRigFmuw95W5gZ2XdvyjdA8wIC0Ap7ZX4uQrhDryM+cVd6/PoQTvTHolMQrbySvYhvsS9
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F89DECB9B09EB4A9A0D6541B0C58630@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 841c8027-7795-40e1-f9a6-08d6de966b33
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:18:14.8640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT069
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1pc3NpbmcgbWV0aG9kIGFyY2hfaXJxX3dvcmtfcmFpc2UoKSB0byBpcnFfd29yay5oLCBz
byBhcyB0byByZW1vdmUNCm1pc3NpbmctcHJvdG90eXBlcyB3YXJuaW5nIGluIGtlcm5lbC9zbXAu
Yy4NCg0KLi4vYXJjaC9hcm0va2VybmVsL3NtcC5jOjU3Mjo2OiB3YXJuaW5nOiBubyBwcmV2aW91
cyBwcm90b3R5cGUgZm9yIOKAmGFyY2hfaXJxX3dvcmtfcmFpc2XigJkgWy1XbWlzc2luZy1wcm90
b3R5cGVzXQ0KIHZvaWQgYXJjaF9pcnFfd29ya19yYWlzZSh2b2lkKQ0KICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fg0KDQpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXplbmF1ZXIgPHBoaWxpcHBl
Lm1hemVuYXVlckBvdXRsb29rLmRlPg0KLS0tDQogYXJjaC9hcm0vaW5jbHVkZS9hc20vaXJxX3dv
cmsuaCB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9pcnFfd29yay5oIGIvYXJjaC9hcm0vaW5jbHVkZS9h
c20vaXJxX3dvcmsuaA0KaW5kZXggODg5NTk5OTgzNGNjLi5jOWVkYjllNzUyN2YgMTAwNjQ0DQot
LS0gYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9pcnFfd29yay5oDQorKysgYi9hcmNoL2FybS9pbmNs
dWRlL2FzbS9pcnFfd29yay5oDQpAQCAtNCw2ICs0LDggQEANCiANCiAjaW5jbHVkZSA8YXNtL3Nt
cF9wbGF0Lmg+DQogDQordm9pZCBhcmNoX2lycV93b3JrX3JhaXNlKHZvaWQpOw0KKw0KIHN0YXRp
YyBpbmxpbmUgYm9vbCBhcmNoX2lycV93b3JrX2hhc19pbnRlcnJ1cHQodm9pZCkNCiB7DQogCXJl
dHVybiBpc19zbXAoKTsNCi0tIA0KMi4xNy4xDQoNCg==
