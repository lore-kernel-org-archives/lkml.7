Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD93C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C425B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfEVJhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:37:02 -0400
Received: from mail-oln040092068101.outbound.protection.outlook.com ([40.92.68.101]:55630
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbfEVJhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:37:01 -0400
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (10.152.8.60) by AM5EUR02HT037.eop-EUR02.prod.protection.outlook.com
 (10.152.9.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16; Wed, 22 May
 2019 09:36:58 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.8.56) by
 AM5EUR02FT003.mail.protection.outlook.com (10.152.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 09:36:57 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 09:36:57 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: add missing include platform-data/atmel.h
Thread-Topic: [PATCH] arm: add missing include platform-data/atmel.h
Thread-Index: AQHVEIHmwqCRWv45dU+96A02oogPbw==
Date:   Wed, 22 May 2019 09:36:57 +0000
Message-ID: <VI1PR07MB443209D29ADFA139B9735D89FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:300:c0::33) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:93CD7ADE6AD34B393F044E52CDF5EA4DDF10D87F80E81BFF1E84C4652B53F226;UpperCasedChecksum:BAC4A55834B0659D1E2F50FD8CD1AE12D391813C43D7FD10B3A032ABFECA07FD;SizeAsReceived:7644;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [pUfdQLg42iiv9FdXbIJA2HDMX7HzPMgX]
x-microsoft-original-message-id: <20190522093634.157414-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT037;
x-ms-traffictypediagnostic: AM5EUR02HT037:
x-microsoft-antispam-message-info: tfmLjODZCjHZv0L7VHlARd+k3K/x8NB1BwKVcs2QLv2jtfQ8qGnBl+auWfvTuYmHCfKV4NYT0BF8S/ewlNx0wfckDyw5+XzjCxYdpe6NRI/8stmKTLQrZZJjNgrPWMiEgMDcDE/9ZtEEvZa2dGXjQGuhp6iatoHdCCjvbmfRLBZk/eHh+FzKQM0tYYaGgJcy
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FBCE08C9A428D489A2F271157E25109@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 753f2fa7-2c99-46c3-0771-08d6de99088a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:36:57.8987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT037
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW5jbHVkZSBjb3JyZXNwb25kaW5nIGhlYWRlcmZpbGUgPGxpbnV4L3BsYXRmb3JtLWRhdGEvYXRt
ZWwuaD4gZm9yDQpmdW5jdGlvbiBhdDkxX3N1c3BlbmRfZW50ZXJpbmdfc2xvd19jbG9jaygpLg0K
DQouLi9hcmNoL2FybS9tYWNoLWF0OTEvcG0uYzoyNzk6NTogd2FybmluZzogbm8gcHJldmlvdXMg
cHJvdG90eXBlIGZvciDigJhhdDkxX3N1c3BlbmRfZW50ZXJpbmdfc2xvd19jbG9ja+KAmSBbLVdt
aXNzaW5nLXByb3RvdHlwZXNdDQogaW50IGF0OTFfc3VzcGVuZF9lbnRlcmluZ19zbG93X2Nsb2Nr
KHZvaWQpDQogICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQoNClNpZ25lZC1v
ZmYtYnk6IFBoaWxpcHBlIE1hemVuYXVlciA8cGhpbGlwcGUubWF6ZW5hdWVyQG91dGxvb2suZGU+
DQotLS0NCiBhcmNoL2FybS9tYWNoLWF0OTEvcG0uYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1hdDkxL3BtLmMgYi9h
cmNoL2FybS9tYWNoLWF0OTEvcG0uYw0KaW5kZXggNmM4MTQ3NTM2ZjNkLi4xYzg4YjQ3YzIzNmYg
MTAwNjQ0DQotLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvcG0uYw0KKysrIGIvYXJjaC9hcm0vbWFj
aC1hdDkxL3BtLmMNCkBAIC0xOSw2ICsxOSw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQu
aD4NCiANCiAjaW5jbHVkZSA8bGludXgvY2xrL2F0OTFfcG1jLmg+DQorI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RhdGEvYXRtZWwuaD4NCiANCiAjaW5jbHVkZSA8YXNtL2NhY2hlZmx1c2guaD4N
CiAjaW5jbHVkZSA8YXNtL2ZuY3B5Lmg+DQotLSANCjIuMTcuMQ0KDQo=
