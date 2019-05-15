Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C11C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B686520843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oXaVrloN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfEOMBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:01:12 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:51366
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729410AbfEOLOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7BGuuaGOnQc9nBqNlL/Om1S/Ms76Y+ujewO4AU7h2c=;
 b=oXaVrloNKQ4B8a2I5UPJZs9OAGKZWNSYKb+MySAEp257/SnMykcRmTOXCIObO426o+mn66tFJ3O4Zc9aWthmE99yfiGLak6dahylkh1S3uW1wa5yt4OLNHGbK7cSAIf/3LioXrQpe3/J+akKVnNJ8sCE0A/gMGuTZpkdHzawuDQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 11:14:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 11:14:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Jacky Bai <ping.bai@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings: clock: imx8mm: Add SNVS clock
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx8mm: Add SNVS clock
Thread-Index: AQHVCr2yrHCSJQGcuE+Cdq63vYcty6ZsCLIA
Date:   Wed, 15 May 2019 11:14:05 +0000
Message-ID: <DB3PR0402MB39164F45F288EB251D5C10F4F5090@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB6434DFD7728BD5B105EF2A31EE090@AM0PR04MB6434.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB6434DFD7728BD5B105EF2A31EE090@AM0PR04MB6434.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70ea0596-93f0-4071-98ff-08d6d92671c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB3PR0402MB367364FD467C714C023798CAF5090@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(13464003)(199004)(189003)(76116006)(66556008)(64756008)(66446008)(52536014)(66476007)(66946007)(68736007)(7736002)(81166006)(446003)(305945005)(11346002)(8676002)(81156014)(66066001)(476003)(102836004)(6116002)(3846002)(44832011)(4326008)(256004)(25786009)(53546011)(6506007)(14444005)(186003)(26005)(76176011)(486006)(6636002)(71200400001)(71190400001)(7696005)(110136005)(54906003)(14454004)(2501003)(99286004)(7416002)(316002)(2906002)(6436002)(53936002)(966005)(2201001)(73956011)(33656002)(86362001)(478600001)(5660300002)(8936002)(6246003)(55016002)(229853002)(74316002)(6306002)(9686003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ln/s82RfGRvJbVZsY8XVAE9J5rY+MqCGo7Kg/II+VlSWJoik8QFFlOg06ZmHTQBrE78gT03hdfGCtQ4GiZhTQpg9kXw94z2wulqRKs4v0Lr3dBad7ODoLteNGqG2rctbIgMwIdAqUufgabytKPMrKKSrEK/B+39TgMoLM4FbGJmIu+5+E3aIe6ZeTXE55TXUKcez1LWgh8EZQVjXVRlOY47nVj/08iFTnlqbaB8BFP92Cgx6ttxUFrRMJojgIUvlgFVD1tBhaNm1uevoNYY2EG0MGeOSK+GoJXadS3DQPkdFjU3BSASu0Alh4IksJkZd2L5JjZ/8qk9QURwEi22QKnuF4yEbUVJePQb/2rMrLJAikZEoJjshgMbNtes+r07txCcx7IgXMtDg1r5vqEq8el4vKCzIvuAiY3GHTdgV6xM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ea0596-93f0-4071-98ff-08d6d92671c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 11:14:05.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9u
YXJkIENyZXN0ZXoNCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTUsIDIwMTkgNjoxOCBQTQ0KPiBU
bzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3Jn
Ow0KPiBzYm95ZEBrZXJuZWwub3JnOyBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+DQo+IENj
OiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzLmhhdWVyQHBlbmd1
dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsg
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxp
bnV4LQ0KPiBpbXhAbnhwLmNvbT47IEFiZWwgVmVzYSA8YWJlbC52ZXNhQG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogY2xvY2s6IGlteDhtbTogQWRkIFNO
VlMgY2xvY2sNCj4gDQo+IE9uIDE1LjA1LjIwMTkgMDQ6MjksIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+IEFkZCBtYWNybyBmb3IgdGhlIFNOVlMgY2xvY2sgb2YgdGhlIGkuTVg4TU0uDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIHBhdGNoOg0KPiA+IGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA5Mzk5OTcvDQo+IA0KPiBOdW1iZXJpbmcgYWxzbyBjb25m
bGljdHMgd2l0aCBvbmUgb2YgbXkgcGF0Y2hlczoNCj4gDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTA5NDAzMDMvDQo+IA0KPiBUaGUgY29uZmxpY3QgaXMgZWFzeSB0byBy
ZXNvbHZlIGJ1dCBJIGRvbid0IG1pbmQgcmVzZW5kaW5nIGlmIHlvdXIgcGF0Y2hlcyBnZXQNCj4g
YWNjZXB0ZWQgZmlyc3QuIElmIHNob3VsZCBwcm9iYWJseSByZXNlbmQgYW55d2F5IHRvIGFsc28g
YWRkIGdpYyBjbGsgdG8gOG1xLg0KDQpUaGFua3MsIEkgZGlkIE5PVCBub3RpY2UgdGhpcywgZmVl
bCBmcmVlIGlmIHdhbnQgbWUgdG8gcmVzZW5kIHRoZSBwYXRjaCBzZXQsIGJvdGgNCnRoZSBHUElP
IGNsb2NrIGFuZCBTTlZTIGNsb2NrIHBhdGNoIHNlcmllcy4NCg0KVGhhbmtzLA0KQW5zb24uDQo+
IA0KPiBGb3Igc2VyaWVzOg0KPiANCj4gUmV2aWV3ZWQtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVv
bmFyZC5jcmVzdGV6QG54cC5jb20+DQo=
