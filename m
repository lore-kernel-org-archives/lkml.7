Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D1BC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672DF20863
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfEZVUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 17:20:25 -0400
Received: from mail-oln040092071061.outbound.protection.outlook.com ([40.92.71.61]:16935
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfEZVUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 17:20:25 -0400
Received: from VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (10.152.18.53) by VE1EUR03HT092.eop-EUR03.prod.protection.outlook.com
 (10.152.19.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16; Sun, 26 May
 2019 21:20:21 +0000
Received: from VI1PR03MB4206.eurprd03.prod.outlook.com (10.152.18.55) by
 VE1EUR03FT043.mail.protection.outlook.com (10.152.19.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Sun, 26 May 2019 21:20:21 +0000
Received: from VI1PR03MB4206.eurprd03.prod.outlook.com
 ([fe80::883e:1bd6:cd36:5fb0]) by VI1PR03MB4206.eurprd03.prod.outlook.com
 ([fe80::883e:1bd6:cd36:5fb0%4]) with mapi id 15.20.1922.021; Sun, 26 May 2019
 21:20:21 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>
CC:     Jonas Karlman <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] drm/meson: Enable DRM InfoFrame support on GXL, GXM and
 G12A
Thread-Topic: [PATCH 3/4] drm/meson: Enable DRM InfoFrame support on GXL, GXM
 and G12A
Thread-Index: AQHVFAjTiBUVlVzg0Ey27UDn0LdoFg==
Date:   Sun, 26 May 2019 21:20:21 +0000
Message-ID: <VI1PR03MB4206A326130A81DCBAA62CE8AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0016.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::26) To VI1PR03MB4206.eurprd03.prod.outlook.com
 (2603:10a6:803:51::23)
x-incomingtopheadermarker: OriginalChecksum:B4F359A41AA2A6E855DFAB7927CCB6099252EB3CFAD3B62BAA21F8BAB040625C;UpperCasedChecksum:2FD75F5FEF2A62BCE2C7C2D69009653194286B004FD6F074AB58A1761D1CA78F;SizeAsReceived:8121;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [khpGtoKFcGyh6rGSRWTft7uY3QUY3+Ok]
x-microsoft-original-message-id: <20190526212012.31994-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT092;
x-ms-traffictypediagnostic: VE1EUR03HT092:
x-microsoft-antispam-message-info: 5chgj3XDhLQKiSPmioevvDxbwXfCvotxovdABLndbYScaY/rb9Hw4XXO56c4OfAMipNAXom1gfoWJ8m9Mect00n4P98vYl7ZyaSJlbAudsm3CiHtlHydQUWN+9y9Iv+2rM4gM5X3Axf2ECb7iNhD2LtRtzW2/WbsvVGKsy1tr2mKAYlDlWZLSccWVV2i7PLI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 155994aa-743c-4a9a-9b32-08d6e21ff54d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2019 21:20:21.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBlbmFibGVzIER5bmFtaWMgUmFuZ2UgYW5kIE1hc3RlcmluZyBJbmZvRnJhbWUg
b24gR1hMLCBHWE0gYW5kIEcxMkEuDQoNCkNjOiBOZWlsIEFybXN0cm9uZyA8bmFybXN0cm9uZ0Bi
YXlsaWJyZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBKb25hcyBLYXJsbWFuIDxqb25hc0Brd2lib28u
c2U+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVzb24vbWVzb25fZHdfaGRtaS5jIHwgNSArKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZXNvbi9tZXNvbl9kd19oZG1pLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVzb24v
bWVzb25fZHdfaGRtaS5jDQppbmRleCBkZjNmOWRkZDIyMzQuLmY3NzYxZTY5OGMwMyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZXNvbi9tZXNvbl9kd19oZG1pLmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZXNvbi9tZXNvbl9kd19oZG1pLmMNCkBAIC05NjYsNiArOTY2LDExIEBAIHN0
YXRpYyBpbnQgbWVzb25fZHdfaGRtaV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZSAqbWFzdGVyLA0KIAlkd19wbGF0X2RhdGEtPmlucHV0X2J1c19mb3JtYXQgPSBNRURJQV9C
VVNfRk1UX1lVVjhfMVgyNDsNCiAJZHdfcGxhdF9kYXRhLT5pbnB1dF9idXNfZW5jb2RpbmcgPSBW
NEwyX1lDQkNSX0VOQ183MDk7DQogDQorCWlmIChkd19oZG1pX2lzX2NvbXBhdGlibGUobWVzb25f
ZHdfaGRtaSwgImFtbG9naWMsbWVzb24tZ3hsLWR3LWhkbWkiKSB8fA0KKwkgICAgZHdfaGRtaV9p
c19jb21wYXRpYmxlKG1lc29uX2R3X2hkbWksICJhbWxvZ2ljLG1lc29uLWd4bS1kdy1oZG1pIikg
fHwNCisJICAgIGR3X2hkbWlfaXNfY29tcGF0aWJsZShtZXNvbl9kd19oZG1pLCAiYW1sb2dpYyxt
ZXNvbi1nMTJhLWR3LWhkbWkiKSkNCisJCWR3X3BsYXRfZGF0YS0+ZHJtX2luZm9mcmFtZSA9IHRy
dWU7DQorDQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIG1lc29uX2R3X2hkbWkpOw0KIA0K
IAltZXNvbl9kd19oZG1pLT5oZG1pID0gZHdfaGRtaV9iaW5kKHBkZXYsIGVuY29kZXIsDQotLSAN
CjIuMTcuMQ0KDQo=
