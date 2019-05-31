Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38457C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047CA2688B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUGHXYMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEaMNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:13:09 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:56803
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfEaMNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSVZFnz5EofKxjDO51pqdERUDg0mztW6Np+chrnU8WI=;
 b=MUGHXYMeybuB/bqGoe8dDT/hRUdtc4H9wcJd+RrhmiHVpvQL48i/MSZeNj9k3FRESkK0FxzmdEB2ZXaPIAOFbbRHQaT1ET1MRw2I2c9QuUJHVKM/5Aj1OqhdJ0ZEt0Gk6xOAaF1Ub8mrwUa8XqY9BK+n6kkCUm84uuGuMfH6mV8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3836.eurprd04.prod.outlook.com (52.134.71.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Fri, 31 May 2019 12:13:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1943.018; Fri, 31 May 2019
 12:13:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] arm64: dts: freescale: Add i.MX8MN dtsi support
Thread-Topic: [PATCH 2/3] arm64: dts: freescale: Add i.MX8MN dtsi support
Thread-Index: AQHVFsxub3h/I8/ZmEeLiTXReak9WqaFHYKAgAAIYOA=
Date:   Fri, 31 May 2019 12:13:02 +0000
Message-ID: <DB3PR0402MB3916139B49D9EF7E44E33911F5190@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190530094706.865-1-Anson.Huang@nxp.com>
 <20190530094706.865-2-Anson.Huang@nxp.com>
 <CAOMZO5D1B1tKs8eu_a8hXs193+TukHAYHiCEyk5g63p1S-cnbg@mail.gmail.com>
In-Reply-To: <CAOMZO5D1B1tKs8eu_a8hXs193+TukHAYHiCEyk5g63p1S-cnbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56a1de6b-3714-4bd0-b86c-08d6e5c15431
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3836;
x-ms-traffictypediagnostic: DB3PR0402MB3836:
x-microsoft-antispam-prvs: <DB3PR0402MB3836F93AA410562FFF848736F5190@DB3PR0402MB3836.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(189003)(199004)(13464003)(8936002)(44832011)(71190400001)(486006)(305945005)(81156014)(66066001)(229853002)(478600001)(9686003)(86362001)(55016002)(71200400001)(7736002)(52536014)(6436002)(53936002)(2906002)(8676002)(5660300002)(33656002)(7416002)(316002)(6916009)(476003)(73956011)(26005)(256004)(76116006)(99286004)(1411001)(25786009)(54906003)(3846002)(6116002)(4326008)(102836004)(53546011)(66446008)(74316002)(6506007)(6246003)(66476007)(7696005)(76176011)(66946007)(68736007)(11346002)(81166006)(66556008)(446003)(186003)(64756008)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3836;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yDyvQeX3GAMW6i/RpXz/NW1iOLdvQjaiom/2hfnmF+HUeT71ur7qrLNlRoJiDD0TagvUtpKN5Vjr5w2+2gHEDEc3BveUjyz+48SEreDLXEg35d7x3UzUKimaPCt+EmyeJz6MhSRFmLelNrHXmxYGmcE9D9P+8MdcKLhzqyciX/zPNBcMj2PPdA6oyT6+Wbw9865TTLDml40/71UTUvOe183SV6doNmVYtuxiAAHvhn59TYHtNleU16fus3gHrXecHLl1uqvb0DeohRyJklRwmkmutea+XmqROSIFOXK4rlmV5WWROiEQG7D55DV+EtCjG9nIy072ZRdMCdiEg8CHCgCEkv7Ad9dwzb6KVcyxJuCTnUCMnSu7a9qzFTkXAV967NhnMf9nsnq42sad6ztCd2U5SEPk9f590iMwzCc6at8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a1de6b-3714-4bd0-b86c-08d6e5c15431
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 12:13:02.2258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1heSAzMSwgMjAx
OSA3OjQwIFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6
IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQNCj4gPG1hcmsu
cnV0bGFuZEBhcm0uY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hh
DQo+IEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgU2FzY2hhIEhhdWVyIDxrZXJuZWxA
cGVuZ3V0cm9uaXguZGU+Ow0KPiBBbmRyZXkgU21pcm5vdiA8YW5kcmV3LnNtaXJub3ZAZ21haWwu
Y29tPjsgTWFuaXZhbm5hbiBTYWRoYXNpdmFtDQo+IDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGlu
YXJvLm9yZz47IEJydW5vIFRob21zZW4NCj4gPGJydW5vLnRob21zZW5AZ21haWwuY29tPjsgQWlz
aGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+IEphY2t5IEJhaSA8cGluZy5iYWlA
bnhwLmNvbT47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgTHVjYXMgU3RhY2gNCj4gPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+OyBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5j
b20+Ow0KPiBCaGFza2FyIFVwYWRoYXlhIDxiaGFza2FyLnVwYWRoYXlhQG54cC5jb20+OyBQcmFt
b2QgS3VtYXINCj4gPHByYW1vZC5rdW1hcl8xQG54cC5jb20+OyBWYWJoYXYgU2hhcm1hIDx2YWJo
YXYuc2hhcm1hQG54cC5jb20+Ow0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBu
eHAuY29tPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUNCj4gQU5EIEZMQVRURU5FRCBERVZJQ0Ug
VFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBsaW51eC1rZXJu
ZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJF
RVNDQUxFDQo+IElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc+OyBkbC0NCj4gbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGFybTY0OiBkdHM6IGZyZWVzY2FsZTogQWRkIGku
TVg4TU4gZHRzaSBzdXBwb3J0DQo+IA0KPiBPbiBUaHUsIE1heSAzMCwgMjAxOSBhdCA2OjQ1IEFN
IDxBbnNvbi5IdWFuZ0BueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZ3BpbzE6IGdwaW9AMzAyMDAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OG1uLWdwaW8iLCAiZnNsLGlteDM1LWdwaW8i
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MzAyMDAwMDAg
MHgxMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgNjQgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgNjUNCj4gPiArIElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KPiANCj4gTm8gR1BJTyBjbG9ja3MgZW50cmllcz8NCg0KSnVzdCBub3Rp
Y2VkIHRoaXMsIHRoZSBpbnRlcm5hbCBicmluZy11cCBicmFuY2gncyBjbG9jayBkcml2ZXIgZG9l
cyBOT1QgaGF2ZSBpdCwNCkkgd2lsbCBhZGQgdGhlbSBpbiBWMiwgdGhhbmtzIGZvciBwb2ludGlu
ZyBvdXQgdGhpcy4gDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdXNicGh5bm9w
MTogdXNicGh5bm9wMSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21w
YXRpYmxlID0gInVzYi1ub3AteGNlaXYiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY2xvY2tzID0gPCZjbGsgSU1YOE1OX0NMS19VU0JfUEhZX1JFRj47DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJTVg4TU5f
Q0xLX1VTQl9QSFlfUkVGPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFz
c2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsaw0KPiBJTVg4TU5fU1lTX1BMTDFfMTAwTT47DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJtYWluX2Ns
ayI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gDQo+ICB1c2JwaHlub3AxIGRv
ZXMgbm90IGhhdmUgYW55IHJlZ2lzdGVycyBhc3NvY2lhdGVkLCBzbyBpdCBzaG91bGQgYmUgcGxh
Y2VkDQo+IG91dHNpZGUgdGhlIHNvYy4NCj4gDQo+IEJ1aWxkaW5nIHdpdGggVz0xIHNob3VsZCB3
YXJuIHlvdSBhYm91dCB0aGF0Lg0KPiANCg0KT0ssIEkgd2lsbCBtb3ZlIHRoZW0gdG8gb3V0c2lk
ZSBvZiBzb2MuDQoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB1c2JwaHlub3AyOiB1c2Jw
aHlub3AyIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAidXNiLW5vcC14Y2VpdiI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
bG9ja3MgPSA8JmNsayBJTVg4TU5fQ0xLX1VTQl9QSFlfUkVGPjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrIElNWDhNTl9DTEtfVVNC
X1BIWV9SRUY+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXNzaWduZWQt
Y2xvY2stcGFyZW50cyA9IDwmY2xrDQo+IElNWDhNTl9TWVNfUExMMV8xMDBNPjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gIm1haW5fY2xrIjsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gDQo+IERpdHRvDQoNCk9LLCBJ
IHdpbGwgbW92ZSB0aGVtIHRvIG91dHNpZGUgb2Ygc29jLg0KDQpUaGFua3MsDQpBbnNvbi4NCg0K
