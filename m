Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115EC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C342420856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfEVIyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:54:39 -0400
Received: from mail-oln040092067104.outbound.protection.outlook.com ([40.92.67.104]:49111
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbfEVIyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:54:38 -0400
Received: from AM5EUR02FT029.eop-EUR02.prod.protection.outlook.com
 (10.152.8.57) by AM5EUR02HT231.eop-EUR02.prod.protection.outlook.com
 (10.152.9.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16; Wed, 22 May
 2019 08:54:36 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.8.57) by
 AM5EUR02FT029.mail.protection.outlook.com (10.152.8.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 08:54:36 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 08:54:35 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: Add method to mach/pci.h
Thread-Topic: [PATCH] ARM: Add method to mach/pci.h
Thread-Index: AQHVEHv6lq8w7O7W1kuo9tizM8ubug==
Date:   Wed, 22 May 2019 08:54:34 +0000
Message-ID: <VI1PR07MB443283DF94F9F8942E6A3ADAFD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0001.namprd02.prod.outlook.com
 (2603:10b6:301:74::14) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:AE6877DCB04B7A1ABB5EAE267A161E0BB157E0E7B953ABF9D704854FE2E1E338;UpperCasedChecksum:1F8AD31A4A089FF3C730F2C3E3FA88C354BFB6319A50B83F0A7CD44991D4E8C2;SizeAsReceived:7421;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [cYBMpV7q8ymNh4KaOYE0WfZP4tigp1go]
x-microsoft-original-message-id: <20190522085353.113717-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT231;
x-ms-traffictypediagnostic: AM5EUR02HT231:
x-microsoft-antispam-message-info: h1vn1LmJtUMreQ0Pee7FC2pTadgObiOZKYK1dMviGlW+IATHSKa3dujBwCgjMMiofT6i2CXo/V5std3KWMCVAJn0lW0a+/QwMiniy8B6klV5TtS2KzhxR+7RNPeJvRNSXz1qWqXo9vfi9Zpl6kpT7M0tu/zUiNGf9DEfFuQYOgPklds+RejtnH5fhkM7Ashm
Content-Type: text/plain; charset="utf-8"
Content-ID: <17B8CDA1DC5EF441B76A66E351EC577E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c8705529-ceb8-49a1-0466-08d6de931c0a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 08:54:35.6337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT231
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkaW5nIG1ldGhvZCBwY2liaW9zX3JlcG9ydF9zdGF0dXMoKSB0byBtYWNoL3BjaS5oLCBzbyBh
cyB0byByZW1vdmUgdGhlDQpleHRlcm4gZGVjbGFyYXRpb24gaW4gZGMyMTI4NS5jLCBhbmQgcmVt
b3ZlIG1pc3NpbmctcHJvdG90eXBlcyB3YXJuaW5nDQppbiBrZXJuZWwvYmlvczMyLmMuDQoNCi4u
L2FyY2gvYXJtL2tlcm5lbC9iaW9zMzIuYzo1OTo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90
b3R5cGUgZm9yIOKAmHBjaWJpb3NfcmVwb3J0X3N0YXR1c+KAmSBbLVdtaXNzaW5nLXByb3RvdHlw
ZXNdDQogdm9pZCBwY2liaW9zX3JlcG9ydF9zdGF0dXModV9pbnQgc3RhdHVzX21hc2ssIGludCB3
YXJuKQ0KICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQoNClNpZ25lZC1vZmYtYnk6IFBoaWxp
cHBlIE1hemVuYXVlciA8cGhpbGlwcGUubWF6ZW5hdWVyQG91dGxvb2suZGU+DQotLS0NCiBhcmNo
L2FybS9pbmNsdWRlL2FzbS9tYWNoL3BjaS5oICAgIHwgMiArKw0KIGFyY2gvYXJtL21hY2gtZm9v
dGJyaWRnZS9kYzIxMjg1LmMgfCAxIC0NCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vbWFj
aC9wY2kuaCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL21hY2gvcGNpLmgNCmluZGV4IDIzM2I0YjUw
ZWZmMy4uMWUwNzYxMmJjYmRiIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vbWFj
aC9wY2kuaA0KKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vbWFjaC9wY2kuaA0KQEAgLTU3LDYg
KzU3LDggQEAgc3RydWN0IHBjaV9zeXNfZGF0YSB7DQogCXZvaWQJCSpwcml2YXRlX2RhdGE7CS8q
IHBsYXRmb3JtIGNvbnRyb2xsZXIgcHJpdmF0ZSBkYXRhCSovDQogfTsNCiANCit2b2lkIHBjaWJp
b3NfcmVwb3J0X3N0YXR1cyh1X2ludCBzdGF0dXNfbWFzaywgaW50IHdhcm4pOw0KKw0KIC8qDQog
ICogQ2FsbCB0aGlzIHdpdGggeW91ciBod19wY2kgc3RydWN0IHRvIGluaXRpYWxpc2UgdGhlIFBD
SSBzeXN0ZW0uDQogICovDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1mb290YnJpZGdlL2Rj
MjEyODUuYyBiL2FyY2gvYXJtL21hY2gtZm9vdGJyaWRnZS9kYzIxMjg1LmMNCmluZGV4IDE2ZDcx
YmFjMDA2MS4uNzVkOTdjZGU3NjU1IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vbWFjaC1mb290YnJp
ZGdlL2RjMjEyODUuYw0KKysrIGIvYXJjaC9hcm0vbWFjaC1mb290YnJpZGdlL2RjMjEyODUuYw0K
QEAgLTM0LDcgKzM0LDYgQEANCiAJCQkJICBQQ0lfU1RBVFVTX1BBUklUWSkgPDwgMTYpDQogDQog
ZXh0ZXJuIGludCBzZXR1cF9hcm1faXJxKGludCwgc3RydWN0IGlycWFjdGlvbiAqKTsNCi1leHRl
cm4gdm9pZCBwY2liaW9zX3JlcG9ydF9zdGF0dXModV9pbnQgc3RhdHVzX21hc2ssIGludCB3YXJu
KTsNCiANCiBzdGF0aWMgdW5zaWduZWQgbG9uZw0KIGRjMjEyODVfYmFzZV9hZGRyZXNzKHN0cnVj
dCBwY2lfYnVzICpidXMsIHVuc2lnbmVkIGludCBkZXZmbikNCi0tIA0KMi4xNy4xDQoNCg==
