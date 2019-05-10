Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B61C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0532175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hD35Q1DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfEJMt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:49:28 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:64465
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbfEJMt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ficx79QKKi4OdnGf8pHUVHNPrLeLEltcSkwjTdr5w9I=;
 b=hD35Q1DAmIAsQWgBT4x1HxkH2mqJIhcRHC3CCv0Bs09untyIDCWecZn5IW4SWX34dfBuY55S3HqostzfmApGSck7RXBvZuS7treBy2ZPJBeN3oJslSzqd+FYjw2E54vWpaZPpoTvJZVS7UnxEypsqe4rL7aW4UXk/8T2wSiAmPo=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5744.eurprd04.prod.outlook.com (20.178.127.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 12:49:21 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::91dc:dc9:180e:cf65]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::91dc:dc9:180e:cf65%3]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 12:49:21 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] add dts file to enable support for
 ls1046afrwy board.
Thread-Topic: [EXT] Re: [PATCH 2/2] add dts file to enable support for
 ls1046afrwy board.
Thread-Index: AQHVBaVf+VCLC05vFU+xwIgyLZG0QaZhQWwAgAMPZHA=
Date:   Fri, 10 May 2019 12:49:21 +0000
Message-ID: <VI1PR04MB480054935B3DDADFF2FD0055F30C0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <20190508135501.17578-1-pramod.kumar_1@nxp.com>
 <20190508135501.17578-3-pramod.kumar_1@nxp.com>
 <CAOMZO5C=dAN0LkhbTqCApmhv1msxAC8B2=u6D0gtC2KYV7T-HQ@mail.gmail.com>
In-Reply-To: <CAOMZO5C=dAN0LkhbTqCApmhv1msxAC8B2=u6D0gtC2KYV7T-HQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.120.0.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c295be6-6205-4e38-75d3-08d6d545ec8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5744;
x-ms-traffictypediagnostic: VI1PR04MB5744:
x-microsoft-antispam-prvs: <VI1PR04MB5744739A5E7FE2CA18D50D0EF30C0@VI1PR04MB5744.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(13464003)(189003)(199004)(305945005)(26005)(76176011)(6506007)(53546011)(74316002)(3846002)(102836004)(2906002)(486006)(476003)(86362001)(446003)(11346002)(6116002)(7696005)(44832011)(5660300002)(99286004)(68736007)(71200400001)(71190400001)(14454004)(52536014)(186003)(256004)(316002)(14444005)(6246003)(478600001)(4326008)(73956011)(76116006)(66476007)(53936002)(66446008)(64756008)(66556008)(6636002)(66946007)(25786009)(110136005)(8936002)(7736002)(9686003)(6436002)(66066001)(55016002)(54906003)(8676002)(33656002)(229853002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5744;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KKSiUzIHSceR5ACDQogmbzY1LTc/upQ/yf0UNLOKzEllOLwV/a5Y/laoi3m+UsoMEh/qprnUuW2FYpUC9aEzrNRZw8g5fjsHUpZR5jpBdDiRK6xRq5+3NCmxzWvXHzKNZS3H0EpkQNKBG+aQ0lJZAmiS29MSfwnPiHHeY5tvBMCltDCJkosP/ycXUQy95+64Fj+Cj0FfloH/8xH2Jji9U0LdzhfBwFrq0iYGjZdq+20Dvtc1+lMXb6ByMSWAutJdGseeuMurzDC37b8fIc/lOSkKd01BoJ0kMIr/9uDKiPBlogOVogkKIlc048/U9tZlpOy5waPZzPxAsNfXtlTBzzHENfbJRCw9WwKQpI8v3NUWAYrlWzUgJlKhnYESw4zObh+8xunDqEJ5yhgUUS9r6CJKWfIR/jm2HDzMqW2MROE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c295be6-6205-4e38-75d3-08d6d545ec8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 12:49:21.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA4LCAy
MDE5IDc6MzAgUE0NCj4gVG86IFByYW1vZCBLdW1hciA8cHJhbW9kLmt1bWFyXzFAbnhwLmNvbT4N
Cj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7DQo+IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnOyBBaXNoZW5n
IERvbmcNCj4gPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgTWljaGFsLlZva2FjQHlzb2Z0LmNvbTsN
Cj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IFZhYmhhdiBTaGFybWENCj4gPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4gU3ViamVjdDog
W0VYVF0gUmU6IFtQQVRDSCAyLzJdIGFkZCBkdHMgZmlsZSB0byBlbmFibGUgc3VwcG9ydCBmb3Ig
bHMxMDQ2YWZyd3kNCj4gYm9hcmQuDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IEhp
IFByYW1vZCwNCj4gDQo+IE9uIFdlZCwgTWF5IDgsIDIwMTkgYXQgMTA6NTYgQU0gUHJhbW9kIEt1
bWFyDQo+IDxwcmFtb2Qua3VtYXJfMUBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gKyZmbWFuMCB7
DQo+ID4gKyAgICAgICBldGhlcm5ldEBlMDAwMCB7DQo+IA0KPiBZb3UgaGF2ZSBwYXNzZWQgQGUw
MDAwIHdpdGhvdXQgYSBjb3JyZXNwb25maW5nIHJlZyBlbnRyeS4NCj4gDQo+IFRoaXMgY2F1c2Vz
IGR0YyBidWlsZCB3YXJuaW5ncyB3aXRoIFc9MS4NCj4gDQo+IFBsZWFzZSBtYWtlIHN1cmUgeW91
IGRvbid0IGludHJvZHVjZSBuZXcgVz0xIHdhcm5pbmdzLg0KZXRoZXJuZXQgbm9kZSBpcyBpbmNs
dWRlZCB3aXRoIGZzbC1sczEwNDYtcG9zdC5kdHNpIGZpbGUgYW5kIG5vIHdhcm5pbmcgaXMgaW50
cm9kdWNlZC4NCm5vZGUgY29udGVudCBjYW4gYmUgZm91bmQgaW4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL3FvcmlxLWZtYW4zLTAtMWctMC5kdHNpOg0KICAgICAgICBldGhlcm5ldEBl
MDAwMCB7DQogICAgICAgICAgICAgICAgY2VsbC1pbmRleCA9IDwwPjsNCiAgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImZzbCxmbWFuLW1lbWFjIjsNCiAgICAgICAgICAgICAgICByZWcgPSA8
MHhlMDAwMCAweDEwMDA+Ow0KICAgICAgICAgICAgICAgIGZzbCxmbWFuLXBvcnRzID0gPCZmbWFu
MF9yeF8weDA4ICZmbWFuMF90eF8weDI4PjsNCiAgICAgICAgICAgICAgICBwdHAtdGltZXIgPSA8
JnB0cF90aW1lcjA+Ow0KICAgICAgICAgICAgICAgIHBjc3BoeS1oYW5kbGUgPSA8JnBjc3BoeTA+
Ow0KICAgICAgICB9Ow0KDQpSZWdhcmRzLA0KVmFiaGF2DQo=
