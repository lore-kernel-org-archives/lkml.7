Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E71C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635412075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfEZVSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 17:18:50 -0400
Received: from mail-oln040092070031.outbound.protection.outlook.com ([40.92.70.31]:1346
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfEZVSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 17:18:50 -0400
Received: from VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (10.152.18.56) by VE1EUR03HT173.eop-EUR03.prod.protection.outlook.com
 (10.152.19.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16; Sun, 26 May
 2019 21:18:46 +0000
Received: from VI1PR03MB4206.eurprd03.prod.outlook.com (10.152.18.55) by
 VE1EUR03FT043.mail.protection.outlook.com (10.152.19.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Sun, 26 May 2019 21:18:46 +0000
Received: from VI1PR03MB4206.eurprd03.prod.outlook.com
 ([fe80::883e:1bd6:cd36:5fb0]) by VI1PR03MB4206.eurprd03.prod.outlook.com
 ([fe80::883e:1bd6:cd36:5fb0%4]) with mapi id 15.20.1922.021; Sun, 26 May 2019
 21:18:46 +0000
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
Subject: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
Thread-Topic: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
Thread-Index: AQHVFAiaQjT/HgX19UmwJWGXQ9hJLA==
Date:   Sun, 26 May 2019 21:18:46 +0000
Message-ID: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::14) To VI1PR03MB4206.eurprd03.prod.outlook.com
 (2603:10a6:803:51::23)
x-incomingtopheadermarker: OriginalChecksum:79BA76E179A41E8010C690CE41FB37BF4D738EC631F3885DEB54BF2DEFDEF101;UpperCasedChecksum:2F9A0D3F638AD527A90A65420103E9544D32B1E2324656B5852FDEF2687ACCD9;SizeAsReceived:7897;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [gDiwXeLjQZWi2jFHnRO1p1AkD+uCRGEn]
x-microsoft-original-message-id: <20190526211823.31739-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT173;
x-ms-traffictypediagnostic: VE1EUR03HT173:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: ySOKTNi/kQ5CAYx4/JSJgcwZM7rCQw/IuCBFENhMXnh8K4P+/mF/vVGm0TiEjxGAvRrKjebQo5uQWpep820PwlfAJGOXO4gA/1K7TU89Exa6inY5wkt6CUyCs0iY6F1M3fO1RBnr1OJzMyyPiwG5OM49fxguu3wlN1o8hEew5VwAm6x2PR5QSzwEHe1q7wa2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c5775b-deca-48c1-7e05-08d6e21fbd12
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2019 21:18:46.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIEhEUiBtZXRhZGF0YSB1c2luZyB0aGUgaGRyX291dHB1dF9tZXRhZGF0
YSBjb25uZWN0b3IgcHJvcGVydHksDQpjb25maWd1cmUgRHluYW1pYyBSYW5nZSBhbmQgTWFzdGVy
aW5nIEluZm9GcmFtZSBhY2NvcmRpbmdseS4NCg0KQSBkcm1faW5mb2ZyYW1lIGZsYWcgaXMgYWRk
ZWQgdG8gZHdfaGRtaV9wbGF0X2RhdGEgdGhhdCBwbGF0Zm9ybSBkcml2ZXJzDQpjYW4gdXNlIHRv
IHNpZ25hbCB3aGVuIER5bmFtaWMgUmFuZ2UgYW5kIE1hc3RlcmluZyBpbmZvZnJhbWVzIGlzIHN1
cHBvcnRlZC4NClRoaXMgZmxhZyBpcyBuZWVkZWQgYmVjYXVzZSBBbWxvZ2ljIEdYQkIgYW5kIEdY
TCByZXBvcnQgc2FtZSBEVy1IRE1JIHZlcnNpb24sDQphbmQgb25seSBHWEwgc3VwcG9ydCBEUk0g
SW5mb0ZyYW1lLg0KDQpUaGUgZmlyc3QgcGF0Y2ggYWRkIGZ1bmN0aW9uYWxpdHkgdG8gY29uZmln
dXJlIERSTSBJbmZvRnJhbWUgYmFzZWQgb24gdGhlDQpoZHJfb3V0cHV0X21ldGFkYXRhIGNvbm5l
Y3RvciBwcm9wZXJ0eS4NCg0KVGhlIHJlbWFpbmluZyBwYXRjaGVzIHNldHMgdGhlIGRybV9pbmZv
ZnJhbWUgZmxhZyBvbiBzb21lIFNvQ3Mgc3VwcG9ydGluZw0KRHluYW1pYyBSYW5nZSBhbmQgTWFz
dGVyaW5nIEluZm9GcmFtZS4NCg0KTm90ZSB0aGF0IHRoaXMgd2FzIGJhc2VkIG9uIHRvcCBvZiBk
cm0tbWlzYy1uZXh0IGFuZCBOZWlsIEFybXN0cm9uZydzDQoiZHJtL21lc29uOiBBZGQgc3VwcG9y
dCBmb3IgSERNSTIuMCBZVVY0MjAgNGs2MCIgc2VyaWVzIGF0IFsxXQ0KDQpbMV0gaHR0cHM6Ly9w
YXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3Nlcmllcy81ODcyNS8jcmV2Mg0KDQpKb25hcyBLYXJs
bWFuICg0KToNCiAgZHJtL2JyaWRnZTogZHctaGRtaTogQWRkIER5bmFtaWMgUmFuZ2UgYW5kIE1h
c3RlcmluZyBJbmZvRnJhbWUgc3VwcG9ydA0KICBkcm0vcm9ja2NoaXA6IEVuYWJsZSBEUk0gSW5m
b0ZyYW1lIHN1cHBvcnQgb24gUkszMzI4IGFuZCBSSzMzOTkNCiAgZHJtL21lc29uOiBFbmFibGUg
RFJNIEluZm9GcmFtZSBzdXBwb3J0IG9uIEdYTCwgR1hNIGFuZCBHMTJBDQogIGRybS9zdW40aTog
RW5hYmxlIERSTSBJbmZvRnJhbWUgc3VwcG9ydCBvbiBINg0KDQogZHJpdmVycy9ncHUvZHJtL2Jy
aWRnZS9zeW5vcHN5cy9kdy1oZG1pLmMgICB8IDEwOSArKysrKysrKysrKysrKysrKysrKw0KIGRy
aXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctaGRtaS5oICAgfCAgMzcgKysrKysrKw0K
IGRyaXZlcnMvZ3B1L2RybS9tZXNvbi9tZXNvbl9kd19oZG1pLmMgICAgICAgfCAgIDUgKw0KIGRy
aXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9kd19oZG1pLXJvY2tjaGlwLmMgfCAgIDIgKw0KIGRyaXZl
cnMvZ3B1L2RybS9zdW40aS9zdW44aV9kd19oZG1pLmMgICAgICAgfCAgIDIgKw0KIGRyaXZlcnMv
Z3B1L2RybS9zdW40aS9zdW44aV9kd19oZG1pLmggICAgICAgfCAgIDEgKw0KIGluY2x1ZGUvZHJt
L2JyaWRnZS9kd19oZG1pLmggICAgICAgICAgICAgICAgfCAgIDEgKw0KIDcgZmlsZXMgY2hhbmdl
ZCwgMTU3IGluc2VydGlvbnMoKykNCg0KLS0gDQoyLjE3LjENCg0K
