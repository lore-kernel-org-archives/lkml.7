Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74750C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523E52133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfFXL0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:26:10 -0400
Received: from mail-oln040092067095.outbound.protection.outlook.com ([40.92.67.95]:59814
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfFXL0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:26:10 -0400
Received: from VE1EUR02FT009.eop-EUR02.prod.protection.outlook.com
 (10.152.12.54) by VE1EUR02HT069.eop-EUR02.prod.protection.outlook.com
 (10.152.13.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.13; Mon, 24 Jun
 2019 11:26:07 +0000
Received: from VI1PR06MB4142.eurprd06.prod.outlook.com (10.152.12.60) by
 VE1EUR02FT009.mail.protection.outlook.com (10.152.12.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13 via Frontend Transport; Mon, 24 Jun 2019 11:26:07 +0000
Received: from VI1PR06MB4142.eurprd06.prod.outlook.com
 ([fe80::c8ce:d86:2172:6b3]) by VI1PR06MB4142.eurprd06.prod.outlook.com
 ([fe80::c8ce:d86:2172:6b3%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 11:26:07 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?SmVybmVqIMWga3JhYmVj?= <jernej.skrabec@siol.net>
Subject: Re: [PATCH] MAINTAINERS: Update Maintainers and Reviewers of DRM
 Bridge Drivers
Thread-Topic: [PATCH] MAINTAINERS: Update Maintainers and Reviewers of DRM
 Bridge Drivers
Thread-Index: AQHVKmx1kLdA2SW15k6VQDSHihxT4aaqqlwA
Date:   Mon, 24 Jun 2019 11:26:07 +0000
Message-ID: <VI1PR06MB41421447ED6897E551E23087ACE00@VI1PR06MB4142.eurprd06.prod.outlook.com>
References: <20190624090851.17859-1-narmstrong@baylibre.com>
In-Reply-To: <20190624090851.17859-1-narmstrong@baylibre.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0183.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::31) To VI1PR06MB4142.eurprd06.prod.outlook.com
 (2603:10a6:802:64::15)
x-incomingtopheadermarker: OriginalChecksum:46A3463A05CD975A64871E050BBFE208C484F53A3AB79B2D8620F5C3338191B2;UpperCasedChecksum:B2C6E075A6A6E0F287866249642BF9E1280D07AEAF963723DCBCD95F56181275;SizeAsReceived:7727;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [2NLynlfImZeI93Sbq+o2aeIuOfJItXLi]
x-microsoft-original-message-id: <8ac600c2-360b-0bf2-dea6-5e7812fd9a63@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR02HT069;
x-ms-traffictypediagnostic: VE1EUR02HT069:
x-microsoft-antispam-message-info: VmqY7L3HyR/1l3ZxYFzkPQemjekEVqQ61l4gqLL+4D2X5iEQDOfSiP3jwA2/swVkMsmfWSUncGmkXYb8VoFSIQZo01ohD0rEmiijJAEppOLTqC70AEdm9nZM8+e6c0B8c5APl7etkdLOabZg/J4eDsNlBeNAIjOIuyHmTgc1qgkBfDmHmdjHx24gNtQmOCG4
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A1ADD9DDF40DE48B2D4DD6F74FE9374@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b38207f9-7b5e-473f-6061-08d6f896c005
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 11:26:07.5001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNi0yNCAxMTowOCwgTmVpbCBBcm1zdHJvbmcgd3JvdGU6DQo+IEFkZCBteXNlbGYg
YXMgY28tbWFpbnRhaW5lciBvZiBEUk0gQnJpZGdlIERyaXZlcnMgdGhlbiBhZGQgSm9uYXMgS2Fy
bG1hbg0KPiBhbmQgSmVybmVqIMWga3JhYmVjIGFzIFJldmlld2VycyBvZiBEUk0gQnJpZGdlIERy
aXZlcnMuDQo+DQo+IENjOiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFz
b25ib2FyZC5jb20+DQo+IENjOiBKb25hcyBLYXJsbWFuIDxqb25hc0Brd2lib28uc2U+DQo+IENj
OiBBbmRyemVqIEhhamRhIDxhLmhhamRhQHNhbXN1bmcuY29tPg0KPiBDYzogSmVybmVqIMWga3Jh
YmVjIDxqZXJuZWouc2tyYWJlY0BzaW9sLm5ldD4NCj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4NCj4gU2lnbmVkLW9mZi1ieTogTmVpbCBBcm1zdHJvbmcgPG5hcm1zdHJvbmdA
YmF5bGlicmUuY29tPg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTIHwgMyArKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIv
TUFJTlRBSU5FUlMNCj4gaW5kZXggMmFiZjZkMjhkYjY0Li5kZDhkYWNjNjFlNzkgMTAwNjQ0DQo+
IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC01MjUzLDcgKzUy
NTMsMTAgQEAgVDoJZ2l0IGdpdDovL2Fub25naXQuZnJlZWRlc2t0b3Aub3JnL2RybS9kcm0tbWlz
Yw0KPiAgDQo+ICBEUk0gRFJJVkVSUyBGT1IgQlJJREdFIENISVBTDQo+ICBNOglBbmRyemVqIEhh
amRhIDxhLmhhamRhQHNhbXN1bmcuY29tPg0KPiArTToJTmVpbCBBcm1zdHJvbmcgPG5hcm1zdHJv
bmdAYmF5bGlicmUuY29tPg0KPiAgUjoJTGF1cmVudCBQaW5jaGFydCA8TGF1cmVudC5waW5jaGFy
dEBpZGVhc29uYm9hcmQuY29tPg0KPiArUjoJSm9uYXMgS2FybG1hbiA8am9uYXNAa3dpYm9vLnNl
Pg0KPiArUjoJSmVybmVqIFNrcmFiZWMgPGplcm5lai5za3JhYmVjQHNpb2wubmV0Pg0KPiAgUzoJ
TWFpbnRhaW5lZA0KPiAgVDoJZ2l0IGdpdDovL2Fub25naXQuZnJlZWRlc2t0b3Aub3JnL2RybS9k
cm0tbWlzYw0KPiAgRjoJZHJpdmVycy9ncHUvZHJtL2JyaWRnZS8NCg0KVGhhbmtzIQ0KDQpSZXZp
ZXdlZC1ieTogSm9uYXMgS2FybG1hbiA8am9uYXNAa3dpYm9vLnNlPg0KDQpCZXN0IHJlZ2FyZHMs
DQpKb25hcw0K
