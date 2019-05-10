Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9835C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A956E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RJlk77te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfEJFF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 01:05:28 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:12493
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfEJFF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 01:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSQDM1ha7kkR71pR5UbVrq5KtnZfPXR3nW4J+rDHq2I=;
 b=RJlk77teJK+HP3Mh99sqvAQ37Lgxaao8INfMPtLcoP93PDnlw1wApIpRHOUNsd1AIdbANMlO3+NtN+8fGo2k3uVuaixDXGBFjqBTZszYXYIPCYrfHAdOMQw+XzLJpVySOXnBsCu27HQx835HPPEovV9Mj/VDS5zPIFm3Q7H6724=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3820.eurprd04.prod.outlook.com (52.134.65.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 10 May 2019 05:05:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 05:05:18 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Thread-Topic: [PATCH] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Thread-Index: AQHU+k2bJJ9MRtHiIEOyvuqXcpXxpaZjzH4AgAAam8A=
Date:   Fri, 10 May 2019 05:05:18 +0000
Message-ID: <DB3PR0402MB391661070B9F664C9E9577B0F50C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556076113-4593-1-git-send-email-Anson.Huang@nxp.com>
 <20190510032917.GG15856@dragon>
In-Reply-To: <20190510032917.GG15856@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc47c5ca-8689-4459-7f88-08d6d50518c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3820;
x-ms-traffictypediagnostic: DB3PR0402MB3820:
x-microsoft-antispam-prvs: <DB3PR0402MB38203374E86E03C399820473F50C0@DB3PR0402MB3820.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(13464003)(6916009)(486006)(6246003)(9686003)(53936002)(71200400001)(305945005)(446003)(53546011)(68736007)(11346002)(476003)(25786009)(74316002)(7416002)(33656002)(66066001)(71190400001)(73956011)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(4326008)(14454004)(256004)(7736002)(478600001)(26005)(102836004)(44832011)(186003)(6506007)(6436002)(52536014)(54906003)(316002)(81166006)(86362001)(55016002)(5660300002)(2906002)(99286004)(81156014)(6116002)(3846002)(8676002)(8936002)(4744005)(7696005)(76176011)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3820;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y2AN9omLSvBhB96ISO1wyN0O0VfOcJX2/zwTGtFi0Tc6fJ67IZm9sxu2PgFJkuCysof4cDorfgVg+41QsTSvouc2PUWbzLJAsKGGq9irNjgffzDQ7VyQ56mcTikOcOtBseta9yOUo1OhLH5HZD577YD3qhZVbVbiIxzjdC6jkmQIEjt3lVm2w+V9Ln4Bii1np/a3r1F2gMy/yt0KcBWQ+ZywZBIe9fmfTxHz90zq8Fh+R3th4afT2tsE1cqFX5xVD2T/gclngqCaK50jTlEKygHkqjoNv6kS04kqpzEfm6jXL6zukf75BhyU2Z0V/K7CJRSy5kKuH49EyMrFOL16cdUaj67NdpbzuZXgvCip34N0fW5mAjtuZ7MiYrbVMCzXnCjWJHDuwxmf338NW35JdrXFZBhsYEAX10CaVYrRabU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc47c5ca-8689-4459-7f88-08d6d50518c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 05:05:18.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIFttYWlsdG86c2hhd25ndW9Aa2VybmVsLm9yZ10NCj4gU2VudDogRnJpZGF5LCBNYXkgMTAs
IDIwMTkgMTE6MjkgQU0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0K
PiBDYzogbGludXhAYXJtbGludXgub3JnLnVrOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgb3RhdmlvQG9zc3lzdGVt
cy5jb20uYnI7DQo+IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBS
b2JpbiBHb25nDQo+IDx5aWJpbi5nb25nQG54cC5jb20+OyB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0
cm9uaXguZGU7DQo+IGphbi50dWVya0BlbXRyaW9uLmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQVJNOiBp
bXhfdjZfdjdfZGVmY29uZmlnOiBFbmFibGUNCj4gQ09ORklHX1RIRVJNQUxfU1RBVElTVElDUw0K
PiANCj4gT24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgMDM6Mjc6MTNBTSArMDAwMCwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gRW5hYmxlIENPTkZJR19USEVSTUFMX1NUQVRJU1RJQ1MgdG8gZXh0ZW5k
IHRoZSBzeXNmcyBpbnRlcmZhY2UgZm9yDQo+ID4gdGhlcm1hbCBjb29saW5nIGRldmljZXMgYW5k
IGV4cG9zZSBzb21lIHVzZWZ1bCBzdGF0aXN0aWNzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IA0KPiBJIGRvbid0IGFwcGx5IHBh
dGNoIHVzaW5nIGJhc2U2NCBlbmNvZGluZy4NCg0KSXQgaXMgb3VyIHNlcnZlciBpc3N1ZSBhbmQg
d2UgaGF2ZSByZXBvcnRlZCBpdCB0byBsb2NhbCBJVCwgd2lsbCByZXNlbmQgcGF0Y2ggb25jZSBp
c3N1ZQ0KaXMgc29sdmVkLg0KDQpUaGFua3MsDQpBbnNvbi4NCg0KPiANCj4gU2hhd24NCg==
