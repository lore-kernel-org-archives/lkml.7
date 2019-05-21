Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B4221019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfEUPyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:54:45 -0400
Received: from mail-oln040092069092.outbound.protection.outlook.com ([40.92.69.92]:48613
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727969AbfEUPyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:54:43 -0400
Received: from HE1EUR02FT018.eop-EUR02.prod.protection.outlook.com
 (10.152.10.53) by HE1EUR02HT070.eop-EUR02.prod.protection.outlook.com
 (10.152.11.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Tue, 21 May
 2019 15:54:40 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.10.56) by
 HE1EUR02FT018.mail.protection.outlook.com (10.152.10.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1900.16 via Frontend Transport; Tue, 21 May 2019 15:54:40 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 15:54:36 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: add missing include <linux/elf-randomize.h>
Thread-Topic: [PATCH] arm: add missing include <linux/elf-randomize.h>
Thread-Index: AQHVD+196VQxVFzkxUm6hIWwPiiwhw==
Date:   Tue, 21 May 2019 15:54:36 +0000
Message-ID: <VI1PR07MB44324E07A6AFE89A920444AFFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:300:6c::23) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:1B20B10E0D37E672A2A37032CC990F06044B38EB367D1C78112B8A0A12F11ADF;UpperCasedChecksum:D6A7E7506F0D5C558B5E9FCFB493E8F104A525A8B45A64B21960325CF08A7F68;SizeAsReceived:7703;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [0/mt7oT42HkDkcphSArYfbly3ntQ7FEF]
x-microsoft-original-message-id: <20190521155408.176794-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HE1EUR02HT070;
x-ms-traffictypediagnostic: HE1EUR02HT070:
x-microsoft-antispam-message-info: W493sq3XOzztmL+wkxZ1mIpQe+TyOvYilerCH0Ud4Fu0B9NSriFJiKz7b/bKGcoju7J4O1fgCiiWXSZHAklcFjlFp/xjVhE5TI3KcyODu9DhAHSKR8AGhFR7gS/TxY0LVwucK/wbHYmqnxnbDIuln3TUG3aPO+rRQG/w84FZfIxGaIWEM7MJR5sUtk2azI2u
Content-Type: text/plain; charset="utf-8"
Content-ID: <42BCE344A2286F4E8170B11CBAEB83E0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1fff71-75ec-4e53-59c3-08d6de049efa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 15:54:36.6515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT070
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW5jbHVkZSBjb3JyZXNwb25kaW5nIGhlYWRlciBmaWxlIDxsaW51eC9lbGYtcmFuZG9taXplLmg+
IGZvciBmdW5jdGlvbg0KYXJjaF9yYW5kb21pemVfYnJrKCkuDQoNCi4uL2FyY2gvYXJtL2tlcm5l
bC9wcm9jZXNzLmM6MzI1OjE1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKA
mGFyY2hfcmFuZG9taXplX2Jya+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQogdW5zaWduZWQg
bG9uZyBhcmNoX3JhbmRvbWl6ZV9icmsoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQogICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF6ZW5h
dWVyIDxwaGlsaXBwZS5tYXplbmF1ZXJAb3V0bG9vay5kZT4NCi0tLQ0KIGFyY2gvYXJtL2tlcm5l
bC9wcm9jZXNzLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNoL2FybS9rZXJuZWwvcHJv
Y2Vzcy5jDQppbmRleCA3MmNjMDg2MmEzMGUuLjczNzgyMDEyZDQwMyAxMDA2NDQNCi0tLSBhL2Fy
Y2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMNCisrKyBiL2FyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMN
CkBAIC0yMyw2ICsyMyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KICNpbmNs
dWRlIDxsaW51eC9pbml0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2VsZmNvcmUuaD4NCisjaW5jbHVk
ZSA8bGludXgvZWxmLXJhbmRvbWl6ZS5oPg0KICNpbmNsdWRlIDxsaW51eC9wbS5oPg0KICNpbmNs
dWRlIDxsaW51eC90aWNrLmg+DQogI2luY2x1ZGUgPGxpbnV4L3V0c25hbWUuaD4NCi0tIA0KMi4x
Ny4xDQoNCg==
