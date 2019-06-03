Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D17C28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3F727AFA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j7+8aIfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfFCCvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 22:51:11 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:22972
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfFCCvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SmWoqJSneWeLmHCMTw5WTlnZGfm8dE5b0oRTak8TRQ=;
 b=j7+8aIfM1iV2JxNeCMpndipUcyV8xUKdFe3fhQvACi7gDTpgoopLRfGRxwSKAaOwIsx6n9vnugd2MjdCQ1w71sAkwxwpROM4ZC0JHr/zxaPZ0gW8YH7oqtJ5yf56PdiAK6z13cn4o7nCo3SWoDu6taMwil338zCY75QVsIxDFpg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3644.eurprd04.prod.outlook.com (52.134.70.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Mon, 3 Jun 2019 02:51:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 02:51:04 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mm: Fix build warnings
Thread-Topic: [PATCH] arm64: dts: imx8mm: Fix build warnings
Thread-Index: AQHVGaXO4iCjF9SbWUifvQR5SJsW3qaJOl6AgAAAj8A=
Date:   Mon, 3 Jun 2019 02:51:04 +0000
Message-ID: <DB3PR0402MB3916DEAAAF8992D12BFAE302F5140@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190603004820.36247-1-Anson.Huang@nxp.com>
 <CAOMZO5B_1HTg6i2Aybv1Hdm4jXg=1R7FRbOnkAXjjG0mk3RZ=A@mail.gmail.com>
In-Reply-To: <CAOMZO5B_1HTg6i2Aybv1Hdm4jXg=1R7FRbOnkAXjjG0mk3RZ=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a37a7226-3f60-4425-d0df-08d6e7ce5217
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3644;
x-ms-traffictypediagnostic: DB3PR0402MB3644:
x-microsoft-antispam-prvs: <DB3PR0402MB36446C8A06C60E43DF825B3BF5140@DB3PR0402MB3644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(13464003)(189003)(199004)(6916009)(316002)(4744005)(54906003)(71200400001)(71190400001)(52536014)(478600001)(8676002)(26005)(68736007)(7736002)(81166006)(14454004)(476003)(8936002)(486006)(186003)(305945005)(81156014)(1411001)(11346002)(66066001)(55016002)(9686003)(66476007)(102836004)(6436002)(64756008)(66446008)(73956011)(66946007)(76176011)(99286004)(6506007)(53546011)(7696005)(66556008)(86362001)(6246003)(74316002)(53936002)(229853002)(76116006)(7416002)(4326008)(5660300002)(33656002)(446003)(25786009)(256004)(3846002)(6116002)(14444005)(44832011)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3644;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ODg+yYB95TRa0hpREUIERxQKFGBc2IfbyFWBSN3Mh+xLOQ6OanZiw6vT8wPtQNeBBRdZXCmUqj7ZtOIsz8yrf5AvK9/DicckrfbhS5m8SM9CeBiioQVfdv4o+kRB7s+ivDfrvWSGas7Hq7XqZCKEb3MHeLWWYszEQGqdAtPpHCKxtXn+P21FVmgtiFrhhuFD+7gNWVqX7ie7lBrd/OI2gFblYUtljUYswoxf6j+rLlgMPcf17FZ+z+vpNlRHC7DwJR1NMs1Zto/LxZ4u/UpFUiyqtCYA0yHu95B57FAnOlc3SYcueF8zfn2tMPSneEj/JQxwBtzmPjHCOHOgKc6+dEj2BcJo0tXCWHh//HwqvYs0bGx6FrjMGR8JBiZLiqsFHljGRnFcSnXx6Tj5WmUU+SFPUvO2oef8iJv+gxFnZpA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37a7226-3f60-4425-d0df-08d6e7ce5217
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 02:51:04.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMywgMjAx
OSAxMDo0OSBBTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENj
OiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kDQo+IDxtYXJr
LnJ1dGxhbmRAYXJtLmNvbT47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2No
YQ0KPiBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFNhc2NoYSBIYXVlciA8a2VybmVs
QHBlbmd1dHJvbml4LmRlPjsNCj4gTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhw
LmNvbT47IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyB2aXJlc2gga3Vt
YXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPjsgSmFja3kNCj4gQmFpIDxwaW5nLmJhaUBueHAu
Y29tPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRA0KPiBERVZJQ0UgVFJF
RSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0ZWQNCj4gbGlz
dDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0tDQo+
IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgta2VybmVsIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgZGwtDQo+IGxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IGlteDhtbTogRml4IGJ1aWxkIHdhcm5p
bmdzDQo+IA0KPiBIaSBBbnNvbiwNCj4gDQo+IE9uIFN1biwgSnVuIDIsIDIwMTkgYXQgOTo0NiBQ
TSA8QW5zb24uSHVhbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgYmVsb3cg
YnVpbGQgd2FybmluZyB3aXRoICJXPTEiOg0KPiANCj4gSSBoYXZlIGFscmVhZHkgc2VudCBwYXRj
aGVzIHRvIGZpeCB0aGVzZSB3YXJuaW5ncy4NCg0KT0ssIHRoYW5rcywgdGhlbiBwbGVhc2UgaWdu
b3JlIHRoaXMgcGF0Y2guDQoNCkFuc29uLg0K
