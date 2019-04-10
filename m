Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66108C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD542133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O5PNOB8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDJCHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:07:12 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:21572
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbfDJCHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOkNKqcya0BnYbDNo20wer09XXq9I33+vhz6MrMJLY8=;
 b=O5PNOB8FfjVSafWDgY0eoB2HX4w6ZarNOJOLpdO/vbeW24ky4bGZpgM/H2yLryt09A3fs9E+WpcAHzUIBW2Ck/2eOZqFXj1nI2Z14WTKGyE3Z0OiNJNFgRK9GrIyUzMS2wGS8T6NoRHIT/F7l8pFhFLjwcOpCoeai0qYLMtAlaw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Wed, 10 Apr 2019 02:07:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 02:07:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH V11 5/5] ARM: dts: imx7ulp-evk: Add backlight
 support
Thread-Topic: [EXT] Re: [PATCH V11 5/5] ARM: dts: imx7ulp-evk: Add backlight
 support
Thread-Index: AQHU7z9rUblOBfVQSk+6QrO16tHxo6Y0pH4AgAAA7TA=
Date:   Wed, 10 Apr 2019 02:07:05 +0000
Message-ID: <DB3PR0402MB3916897ABC422445D50A100BF52E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
 <1554860547-18237-6-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5C0oTaaFFVKC=72+5UGMRwvoxJAsBJNsAp5H_16gsXhVA@mail.gmail.com>
In-Reply-To: <CAOMZO5C0oTaaFFVKC=72+5UGMRwvoxJAsBJNsAp5H_16gsXhVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b144fe1-a631-4283-2a56-08d6bd593b1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB36592A99B17E00D9E2482DB4F52E0@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(13464003)(189003)(199004)(6246003)(478600001)(55016002)(6116002)(97736004)(3846002)(7416002)(53546011)(99286004)(9686003)(102836004)(6506007)(74316002)(53936002)(14454004)(54906003)(186003)(25786009)(7736002)(4326008)(5024004)(305945005)(26005)(14444005)(33656002)(256004)(316002)(229853002)(6436002)(446003)(11346002)(105586002)(66066001)(486006)(2906002)(52536014)(5660300002)(1411001)(476003)(44832011)(81156014)(68736007)(71190400001)(71200400001)(8936002)(6916009)(81166006)(7696005)(86362001)(76176011)(8676002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fz2RJ2P+ZBI/9H7iIf+gs714j9pLgKPbxRdD5o3kiQdmQ7lyvZ1/vbvK1eJcVIMxVhCWHgfMDWwlZZVKVsya5jsFvP3qf/0JpKr/hrHp7X2VWRLjKYxLiU09tGaE1wKDddaGHDdgBNKdgwCVPCSEF2jTTWI2UZjlX7FfLN0FqMKobLNEYO2nDF5cWANFPT3uZRhRzm6MDaR3pjAzPQiPzejpsdJF+DAb1wCZy4WCFrwwBrTH++oifulpQ9Fo+5ExF5jCD8wg8qtcT3Uk8EnQ4CEFQluGPaxMmraUZXidb+YAKlLL7Pak2v36RETLNj1Rtpkx5+WNbDJLE63/PGFqlie7Y/mQ/Eyc2W4XCgkfAf09bDI06XU2A2dJrYq2W2Br9sIfMROrDlAORcW+weMXpJR3vFyrRuf8meBDTuyHOb4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b144fe1-a631-4283-2a56-08d6bd593b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 02:07:06.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOeW5tDTmnIgxMOaXpSAxMDowMw0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207
IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsN
Cj4gbGludXhAYXJtbGludXgub3JnLnVrOyBzdGVmYW5AYWduZXIuY2g7IG90YXZpb0Bvc3N5c3Rl
bXMuY29tLmJyOw0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsg
Um9iaW4gR29uZw0KPiA8eWliaW4uZ29uZ0BueHAuY29tPjsgdS5rbGVpbmUta29lbmlnQHBlbmd1
dHJvbml4LmRlOyBsaW51eC0NCj4gcHdtQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54
cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggVjExIDUvNV0gQVJNOiBkdHM6IGlt
eDd1bHAtZXZrOiBBZGQgYmFja2xpZ2h0DQo+IHN1cHBvcnQNCj4gDQo+IFdBUk5JTkc6IFRoaXMg
ZW1haWwgd2FzIGNyZWF0ZWQgb3V0c2lkZSBvZiBOWFAuIERPIE5PVCBDTElDSyBsaW5rcyBvcg0K
PiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIFR1ZSwgQXByIDksIDIwMTkgYXQg
MTA6NDcgUE0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiAN
Cj4gPiAgI2luY2x1ZGUgImlteDd1bHAuZHRzaSINCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L3B3bS9wd20uaD4NCj4gDQo+IFRoaXMgaW5jbHVzaW9uIGlzIG5vdCBuZWVkZWQgaGVyZSBhcyBQ
V01fUE9MQVJJVFlfSU5WRVJURUQgaXMgbm90IHVzZWQNCj4gaW4gdGhpcyBkdHMuDQoNClRoYW5r
cyBmb3IgcmVtaW5kZXIsIEkgd2lsbCByZW1vdmUgaXQgbGF0ZXIuDQoNCkFuc29uLg0KDQo=
