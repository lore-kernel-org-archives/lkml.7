Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548D521773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GipkUqyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfDXJGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:06:13 -0400
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:13880
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728177AbfDXJGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybOB7TTACbIGmANeRTntyJI/8FCMKbkjDv52MseaakA=;
 b=GipkUqyP+MheCgQWa/4ncDHe4BSwg9anSIctLqeUBodbRlwsB27rRmkK1L5+m3bUazoblUCVyVYrgQiubjO1ABaPdsHaBe1hlx47/TwMFuIVESdF5RbUMp56Fw7SiiDhuJQwAEL+eAa5IqtrxQjlkrJFasPDfsnd2OVBnQn3qVE=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4206.eurprd04.prod.outlook.com (52.134.30.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 09:06:03 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 09:06:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v1 14/15] ARM: dts: imx6sll: correct ecspi/sdma
 compatible
Thread-Topic: [EXT] Re: [PATCH v1 14/15] ARM: dts: imx6sll: correct ecspi/sdma
 compatible
Thread-Index: AQHU+duwHt0Y+lCjeEKfty3+TgG1IKZK3LuAgAAnsAA=
Date:   Wed, 24 Apr 2019 09:06:03 +0000
Message-ID: <1556096388.19638.3.camel@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
         <1556027045-5269-15-git-send-email-yibin.gong@nxp.com>
         <20190424063745.b67kcb3zzifuf22b@pengutronix.de>
In-Reply-To: <20190424063745.b67kcb3zzifuf22b@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c5d75f0-0f96-49c2-de6c-08d6c89413ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4206;
x-ms-traffictypediagnostic: VI1PR04MB4206:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB420676ABDEB023776F14FCD7893C0@VI1PR04MB4206.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(66446008)(7736002)(103116003)(66556008)(5640700003)(54906003)(99286004)(97736004)(71190400001)(68736007)(66066001)(73956011)(91956017)(76116006)(76176011)(66946007)(71200400001)(305945005)(64756008)(486006)(6436002)(5660300002)(66476007)(6486002)(7416002)(316002)(2501003)(966005)(86362001)(6246003)(478600001)(6512007)(45080400002)(6306002)(36756003)(25786009)(256004)(2906002)(53936002)(2351001)(4326008)(50226002)(3846002)(6116002)(81166006)(81156014)(6916009)(26005)(476003)(102836004)(11346002)(14454004)(186003)(8676002)(8936002)(6506007)(2616005)(53546011)(446003)(229853002)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4206;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zyiprBXuRHTDpN2d0fimN4XF0f2joO6BqkUNqZlgCBT6ht5/tcBNveHo2rbXsjy9NnKEbUNchE2DHMK8VAyFdTuBswFgm6mwo12qCqgMjy5tmvtqqNDTcqij0W1JHprnYK4J9UVE529iLqVvRXEkFCN0GKX7obuNrmNqbVyV2r4Dp9XJ85U3VZUOt2yHxOFbGeSNiPVTAjYH1VMjzMAn3kE4okOaUmEelEG/6CkpYpNigGbXNkvJsn21rcnaTJ0eYf5rMy6J68B0lnfEdQd4NlYcdF31ddmQeVidifafAH7et1JYqEvecP+rKi9SptikWwBjxCBal20Dtcpq/tKuwC6xopW3biMulbEqU/Wmrf/qpGnHY2zodnqHzBrHDRdsYInwIuI4eSlr74MnG/acyxQrWkJ9sO05D/w5hb2O5fY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25D3ADAEEFCFE64E9C47CC15846B2303@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5d75f0-0f96-49c2-de6c-08d6c89413ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 09:06:03.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNCBhdCAwODozNyArMDIwMCwgcy5oYXVlckBwZW5ndXRyb25peC5kZSB3cm90
ZToNCj4gT24gVHVlLCBBcHIgMjMsIDIwMTkgYXQgMDE6NTE6NDVQTSArMDAwMCwgUm9iaW4gR29u
ZyB3cm90ZToNCj4gPiANCj4gPiBDb3JyZWN0IGVjc3BpL3NkbWEgY29tcGF0aWJsZSBzaW5jZSBl
Y3NwaSBlcnJhdGEgRVJSMDA5MTY1DQo+ID4gbm90IGZpeGVkIG9uIGkubXg2c2xsIGNoaXAuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0K
PiA+IC0tLQ0KPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpIHwgMTAgKysrKyst
LS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNp
DQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0c2kNCj4gPiBpbmRleCAxYjQ4OTlm
Li4wM2YyMTAzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwuZHRz
aQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwuZHRzaQ0KPiA+IEBAIC0xODMs
NyArMTgzLDcgQEANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9Ow0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVjc3BpMTogc3BpQDIwMDgwMDAg
ew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bC0NCj4gPiBl
Y3NwaSIsICJmc2wsaW14NTEtZWNzcGkiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGli
bGUgPSJmc2wsaW14NTEtDQo+ID4gZWNzcGkiOw0KPiBXaGVyZSBpcyB0aGUgZnNsLGlteDZzbGwt
ZWNzcGkgY29tcGF0aWJsZSB0aGF0IHdvdWxkIGhhdmUgcHJldmVudGVkDQo+IHVzDQo+IGZyb20g
Y2hhbmdpbmcgdGhpcyBkZXZpY2V0cmVlIG5vdz8gWW91IHNob3VsZCBhdCBsZWFzdCBhZGQgaXQg
bm93Lg0KV2lsbCBhZGQgZnNsLGlteDZzbGwtZWNzcGkgaW4gVjIuDQo+IA0KPiBTYXNjaGENCj4g
DQo+IC0tDQo+IFBlbmd1dHJvbml4DQo+IGUuSy7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlv
bnPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy4NCj4gcHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cucGVu
Z3V0cm9uaXguZGUlMkYmYW1wO2RhDQo+IHRhPTAyJTdDMDElN0N5aWJpbi5nb25nJTQwbnhwLmNv
bSU3Q2ZhMWRhZTA3N2MxYzRiMTkxYjJmMDhkNmM4N2Y2MDE2JQ0KPiA3QzY4NmVhMWQzYmMyYjRj
NmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MTY4NDY3Mjg2OTc5OTAmYW1wO3MNCj4g
ZGF0YT15VHI5ang3bElvZENFYVM2Q2IwbXdwa1NDMXN5R0dKdkZYb3g0ZDMlMkJuTUUlM0QmYW1w
O3Jlc2VydmVkPTDCoA0KPiDCoHwNCj4gUGVpbmVyIFN0ci4gNi04LCAzMTEzNyBIaWxkZXNoZWlt
LCBHZXJtYW55IHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0NCj4gMMKgwqDCoMKgfA0KPiBBbXRz
Z2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NsKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8IEZheDrC
oMKgwqArNDktNTEyMS0yMDY5MTctDQo+IDU1NTUgfA==
