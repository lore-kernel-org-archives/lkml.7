Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D654C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5774820684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gTZlFg/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfCFKL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:11:29 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:42976
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729858AbfCFKL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0vnptnwyycJkSqGZPniPOhuQLk6zRWnT1Zkb28GJLE=;
 b=gTZlFg/MrRVGUFUB+R5eXwg8D3QuJQ2Dm3oLcmdz/lLnSknrXMHhFNXI54lnh0h7PlcSnnoD5I2B+oqy1+XgOqVP3Tl71IvhwcShX0ZBGKhf6mJmofGqoU94xFhPPR+gYxNMqMQLIa6FBiZd6sv/0N+mEDBNzHJyxSuScAOLhhw=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB4318.eurprd04.prod.outlook.com (52.134.31.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Wed, 6 Mar 2019 10:11:17 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::417:7274:9a1:a752]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::417:7274:9a1:a752%3]) with mapi id 15.20.1665.021; Wed, 6 Mar 2019
 10:11:17 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>, Stefan Agner <stefan@agner.ch>
CC:     Christina Quast <cquast@hanoverdisplays.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Thread-Topic: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Thread-Index: AQHUytCIfTFXSadJckWCjEy0gWR0oKXyA8SQgAATHICAClra8IACAHHA
Date:   Wed, 6 Mar 2019 10:11:17 +0000
Message-ID: <VI1PR04MB504036C9FA56673680279BB190730@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <20190222170038.9669-1-cquast@hanoverdisplays.com>
 <VI1PR04MB42227AA158BA1FCBF314AA27807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <db6c2755e80e41f7c169406c213a40e8@agner.ch>
 <AM0PR04MB4211737BF7A85E15090636BD80720@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211737BF7A85E15090636BD80720@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d268ee4c-6bb6-477e-2efe-08d6a21c12c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4318;
x-ms-traffictypediagnostic: VI1PR04MB4318:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtWSTFQUjA0TUI0MzE4OzIzOlVSbldvVEo5c1pKTllpdjdVSmVTYnRIN0Q4?=
 =?gb2312?B?SHp2Y2dhUFNUZnFnblJaK1gyR2E3MFZFUitlZEc5MGJhdVFnVS8rbGtxaHZK?=
 =?gb2312?B?b1F3VHAwMllhVitoamd6T0llaEQ4V2VubGlmMlFncER6bVZLTEtncjMrbmNn?=
 =?gb2312?B?bVJhb09wcVVLUkZKLzd6VmE0dUIyNmJtYm1jbmNZcW0rMk5kUHljMGNQMHJv?=
 =?gb2312?B?Qmp6Y2FjdEJ4TXQyNjVFTCs4YU9BWElxS1NzYkx6NFFFMjhxeFRPd0hFb1Vp?=
 =?gb2312?B?Z1dzYXdpN3l6TVgwdjVtZGl0UmRCcysrZldUSTV4YlVIZ2c1VWNjRjU4RVZ5?=
 =?gb2312?B?TFFEV3d0YVUzS3hsMVVEN1pPK3pMSEYvMGIxRkovdFVPdWtpVlpoTE1sRmRp?=
 =?gb2312?B?OEU4MENWT1NzK3ZCVkNMWE53T2VlZ0ZnSW9wdC9QblF6MTM4Q1ZXSkVrNzk5?=
 =?gb2312?B?aEloZ0g5ZnozMFZSWmx3dEZ5cTVGNkZrWHlrRkJjNFhmNklDOEF6cGJQOWRN?=
 =?gb2312?B?RGgycnUrbk1KOFYwRm5hVHZGL0tMYkFaUEtOM2ZMZlVaemJBdjZOak85S3No?=
 =?gb2312?B?TEtPdlp6SEsvSVdnZTZ5R0tMYlZxN0dpUFZiUmV1Tml1SFMwYSt6bW9Ya01w?=
 =?gb2312?B?N3lGTVpDVTJ6OExnU0lremNIWFFhOEpuTkdjS2c3YnllM2NLcXM3aEMzaDFK?=
 =?gb2312?B?ZWpQL252cGFYTmRkVi8xT0dpaWxIQW1zTjhaN0xaVUtQNDFRRkpLY0tha2xv?=
 =?gb2312?B?ZDEyZDhPK1NmOE1ZY1V4WHV2YTVpdHJrZ3IrbnE3dm5pRHNTM0FTdmVZYTVl?=
 =?gb2312?B?bGdNQklaNGp1a3htdHRpTDM3OW1JM24xWkF3VzV1ZGNGMHJKY3c3bDRNUFdX?=
 =?gb2312?B?cENOTGJtVWRNd3QwSVA2V0hEaGRkK3NnQ0FSN0JNS0o2b1owWlBPNVhsVHJ6?=
 =?gb2312?B?cHpUNEZieGNjNEtxdU9ES1dlUUpXOXE5MFNDbmkrUDg2MDBHTlh5RzIzeDlr?=
 =?gb2312?B?SWdZWVJseGN0Zm1icDlyTmZ2UFhaWGRsQkU1cXBOMjJzZlpha2pRTEhLd1Ay?=
 =?gb2312?B?UW1hbEQ1SEUrM1ZvZ3huYStqTGhXTUlGM1B2TmptazlwYk41VkF0cjZmVkNZ?=
 =?gb2312?B?Q3pybjZpSnkzOVlWUHVtbXBpcy95UmpFUldUUXBXc0liQmNlZ3JWUGNDblU3?=
 =?gb2312?B?MlhrSFUySVZBOFRsVTZ5ZmlFejAwME52Qnc3MlAyUlJXYVU0QTFEY0c5K3M3?=
 =?gb2312?B?UEh6VkZnQzZXbW02ZTRVVlAxMTJCK0M2VXVvajIzQXNMdWI4bEpaVUhUUTRC?=
 =?gb2312?B?L2xERUZVbEErVWx1Mkw0U3M1VW5aOXpydWp2dlU0Wm1xM1FoWUpCd2J0VWx0?=
 =?gb2312?B?R0Mwa2h5TldsaWd2eXE0dklUK1RtSmxRaHZ5RlYyaDZ5OFRWdEZEUnBEREpr?=
 =?gb2312?B?TDlHUmpNK1BSNTRVNVhpMVRGTjVFaTdYSXB3UTdLMXpFYTlnNm5LTVhOaXRv?=
 =?gb2312?B?bDBaeEJJaENsemV0eXptM1JSR0prbGRia2VnMWQrNjg1emNiYUVZS1I4Nkwy?=
 =?gb2312?B?Njd3ZGNJb282ck9FWU9JSWdzQkV2VGIvbWE3YnhLNFFScStkODl4Ym8wMjBI?=
 =?gb2312?B?WmljRDh5UVUzQzgzcldMSnF6ZXhqUGo3Wkx1UHRUYkhCdXl3cTFZbW90VitS?=
 =?gb2312?B?QWxkMmRtSzVxQ3dsZEVGRTByME1IL01XSDdVUFE4ZGlvWEo1aE1OOUtmNStx?=
 =?gb2312?B?UWZnZU04dGhoWDJOa3hqdzA5Zy9sSzREcEFaMWxKQytxTmlKK3Bkc0JhbHBy?=
 =?gb2312?B?NUJET0k4V2NQUjIwMko1aUI5T0dweGVaZ0FHb1FSeVAvVEE9PQ==?=
x-microsoft-antispam-prvs: <VI1PR04MB4318AC67CF55C20B563DD52490730@VI1PR04MB4318.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(13464003)(189003)(53936002)(55016002)(7736002)(99286004)(8676002)(81156014)(93886005)(106356001)(8936002)(105586002)(53546011)(9686003)(76176011)(7696005)(14454004)(33656002)(6506007)(478600001)(25786009)(186003)(2906002)(81166006)(102836004)(256004)(52536013)(14444005)(5024004)(3846002)(6116002)(446003)(68736007)(6436002)(5660300002)(110136005)(11346002)(476003)(486006)(4326008)(26005)(229853002)(316002)(305945005)(71190400001)(71200400001)(54906003)(74316002)(53346004)(97736004)(7416002)(86362001)(6246003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4318;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EycTRZG2dR8wbk0u2G7c/JV/PmYFog6++TbVuHYts4f0aTcK2oj8oc5UTij5YUM9B7Bjjca1VAwfjl/hJ/TtzH2yT5WQbPT02LrXPAkheRpFDdWb1xGIgmMVvaJNqFWb9B5cwlnOMT5fvoj0cbo5bQBc9TNwDiKLP3SIXhU8MzgjlYFDUYej+Vay67bIFOjx6jwgepxmtzJCI+HzUZcggnj/mR76/EO+yd60GEOcav9fhV7eERUb6n6ChOo27t+h1ciq9933oOIazvUrijH856FD9iNMeh3ZreIBgScvPg6uHASCtftTyPBWgiOAek6fGISuixKuafVQebd9/gcaPhd/ZzRnjL72YidapRXGJiftSczYpKM1m4qjnHpE7MS6q+1UlpIVJylBWGgK/Ggr+Tdq/XC1H6Anc5MAJwyNG8g=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d268ee4c-6bb6-477e-2efe-08d6a21c12c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:11:17.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFpc2hlbmcgRG9uZw0KPiBT
ZW50OiAyMDE5xOoz1MI1yNUgMTE6MzUNCj4gVG86IFN0ZWZhbiBBZ25lciA8c3RlZmFuQGFnbmVy
LmNoPjsgQk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogQ2hyaXN0aW5hIFF1
YXN0IDxjcXVhc3RAaGFub3ZlcmRpc3BsYXlzLmNvbT47IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4g
c2hhd25ndW9Aa2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207
IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQk9VR0ggQ0hFTg0KPiA8aGFpYm8uY2hl
bkBueHAuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBEb2N1bWVudDogZHQ6IGJpbmRpbmc6
IGlteDogRml4IFBBRF9DVExfRFNFX1gqDQo+IA0KPiArIEhhaWJvDQo+IA0KPiA+IEZyb206IFN0
ZWZhbiBBZ25lciBbbWFpbHRvOnN0ZWZhbkBhZ25lci5jaF0NCj4gPiBTZW50OiBUdWVzZGF5LCBG
ZWJydWFyeSAyNiwgMjAxOSA5OjIyIFBNDQo+ID4NCj4gPiBPbiAyNi4wMi4yMDE5IDEzOjIxLCBB
aXNoZW5nIERvbmcgd3JvdGU6DQo+ID4gPj4gRnJvbTogQ2hyaXN0aW5hIFF1YXN0IFttYWlsdG86
Y3F1YXN0QGhhbm92ZXJkaXNwbGF5cy5jb21dDQo+ID4gPj4gU2VudDogU2F0dXJkYXksIEZlYnJ1
YXJ5IDIzLCAyMDE5IDE6MDEgQU0NCj4gPiA+Pg0KPiA+ID4+IEluIHRoZSBpTVg3ZCBkYXRhc2hl
ZXQsIHRoZSBQQURfQ1RMX0RTRV9YKiB2YWx1ZXMgYXJlIGRpZmZlcmVudA0KPiA+ID4+IGZyb20g
dGhlIGRvY3VtZW50YXRpb24uDQo+ID4gPj4NCj4gPiA+DQo+ID4gPiBJdCdzIGEgZG9jIHByb2Js
ZW0uDQo+ID4gPiBMYXRlc3QgUk0gc2VlbXMgZ290IHVwZGF0ZWQuDQo+ID4gPg0KPiA+ID4gQXMg
aGVyZSBpdCdzIGEgcmVmZXJlbmNlIGRlZmluaXRpb24gaW4gYmluZGluZyBkb2MgYW5kIGRldmlj
ZSB0cmVlDQo+ID4gPiBhY3R1YWxseSBkb2VzIG5vdCB1c2UgaXQgKElNWCBQaW5jdHJsIHVzZSBy
YXcgZGF0YSB0byBzZXQgcGFkDQo+ID4gPiBjb25maWd1cmF0aW9uKS4gU28gaXQgd29uJ3QgY2F1
c2UgYW55IGNvbXBhdGliaWxpdHkgaXNzdWUgdG8gbWUuDQo+ID4gPg0KPiA+ID4gUGxlYXNlIHVw
ZGF0ZSB0aGUgcGF0Y2ggdGl0bGUgdG86DQo+ID4gPiBkdC1iaW5kaW5nczogcGluY3RybDogaW14
N2Q6IHh4eHh4DQo+ID4gPg0KPiA+ID4gT3RoZXJ3aXNlOg0KPiA+ID4gQWNrLWJ5OiBEb25nIEFp
c2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+DQo+ID4gQnR3LCBJIHNhdyB0aGF0IGlt
eDdkLXNkYi5kdHMgKGFuZCBwcm9iYWJseSBvdGhlciBpLk1YIDcgYm9hcmRzIHRvbykNCj4gPiB1
c2UgdGhyZWUgZGlmZmVyZW50IHNldHRpbmdzIGZvciB1c2RoYyBwaW5jdHJsOiAweDU5LCAweDVh
IGFuZCAweDViDQo+ID4gKGZvciBkZWZhdWx0LCAxMDBNSHogYW5kIDIwME1IeiByZXNwZWN0aXZl
bHkpLiBPbmUgd291bGQgZXhwZWN0IHRoYXQNCj4gPiBoaWdoZXIgZnJlcXVlbmN5IHVzZSBoaWdo
ZXIgZHJpdmVyIHN0cmVuZ3RoIChhbmQgdGhpcyBpcyB0aGUgY2FzZSBmb3IgaS5NWCA2KS4NCj4g
PiBCdXQgd2l0aCB0aGlzIG5ldy9jb3JyZWN0ZWQgcGFkIHZhbHVlcyB0aGlzIG1lYW5zIHdlIHVz
ZSB4NCwgeDIgYW5kIHg2DQo+ID4gZm9yIGRlZmF1bHQsIDEwME1IeiBhbmQgMjAwTUh6IHJlc3Bl
Y3RpdmVseS4gVGhpcyBoYXJkbHkgc2VlbXMgcmlnaHQuLj8NCj4gPiBQcm9iYWJseSBuZWVkcyBm
aXhpbmcgdG9vPw0KPiA+DQo+IA0KPiBZZXMsIHRoYXQncyB0cnVlLg0KPiBFc3BlY2lhbGx5IDEw
ME1oeiBzZXR0aW5nIHNob3VsZCBiZSB1cGRhdGVkLg0KPiANCj4gSGFpYm8sDQo+IENhbiB5b3Ug
cGxlYXNlIGhlbHAgZG91YmxlIGNoZWNrIGlmIFgyIGZvciA1ME1oeiBhbmQgWDQgZm9yIDEwME1o
eiBjYW4gd29yaw0KPiBzdGFibHkgb24gTVg3RCBTREI/DQo+IElmIHllcywgd2UnZCBsaWtlIHRv
IHVwZGF0ZSB0aGUgcGFkIHNldHRpbmcgYWNjb3JkaW5nIHRvIG5ldyBSTSB2ZXJzaW9uLg0KPiAN
Cg0KWDIgZm9yIGhpZ2ggc3BlZWQgYW5kIHg0IGZvciBkZHI1MC9kZHI1MiBjYW4gd29yayBzdGFi
bGUgb24gTVg3RCBTREIuDQpJIHRoaW5rIGFsbCB0aGUgN0QgcmVsYXRlZCBkdHMgbmVlZCB0byBm
aXggdGhpcy4gTm90IHN1cmUgd2hldGhlciA3UyBuZWVkIHRoaXMgZml4LCBjYW4geW91IGNvbmZp
cm0/DQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiBSZWdhcmRzDQo+IERvbmcgQWlzaGVu
Zw0KPiANCj4gPiAtLQ0KPiA+IFN0ZWZhbg0KPiA+DQo+ID4NCj4gPiA+DQo+ID4gPiBSZWdhcmRz
DQo+ID4gPiBEb25nIEFpc2hlbmcNCj4gPiA+DQo+ID4gPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0
aW5hIFF1YXN0IDxjcXVhc3RAaGFub3ZlcmRpc3BsYXlzLmNvbT4NCj4gPiA+PiAtLS0NCj4gPiA+
PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9mc2wsaW14N2QtcGluY3RybC50eHQg
ICAgICAgfCA2ICsrKy0tLQ0KPiA+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4+DQo+ID4gPj4gZGlmZiAtLWdpdA0KPiA+ID4+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvZnNsLGlteDdkLXBpbmN0cmwu
dHh0DQo+ID4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9m
c2wsaW14N2QtcGluY3RybC50eHQNCj4gPiA+PiBpbmRleCA2NjY2Mjc3YzNhY2IuLjhhYzFkMDg1
MWEwZiAxMDA2NDQNCj4gPiA+PiAtLS0NCj4gPiA+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waW5jdHJsL2ZzbCxpbXg3ZC1waW5jdHJsLnR4dA0KPiA+ID4+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL2ZzbCxpbXg3ZC1waW5jdHJs
LnQNCj4gPiA+PiArKysgeHQNCj4gPiA+PiBAQCAtNDgsOSArNDgsOSBAQCBQQURfQ1RMX0hZUyAg
ICAgICAgICAgICAgICAgICAgICgxIDw8IDMpDQo+ID4gPj4gIFBBRF9DVExfU1JFX1NMT1cgICAg
ICAgICAgICAgICAgKDEgPDwgMikNCj4gPiA+PiAgUEFEX0NUTF9TUkVfRkFTVCAgICAgICAgICAg
ICAgICAoMCA8PCAyKQ0KPiA+ID4+ICBQQURfQ1RMX0RTRV9YMSAgICAgICAgICAgICAgICAgICgw
IDw8IDApDQo+ID4gPj4gLVBBRF9DVExfRFNFX1gyICAgICAgICAgICAgICAgICAgKDEgPDwgMCkN
Cj4gPiA+PiAtUEFEX0NUTF9EU0VfWDMgICAgICAgICAgICAgICAgICAoMiA8PCAwKQ0KPiA+ID4+
IC1QQURfQ1RMX0RTRV9YNCAgICAgICAgICAgICAgICAgICgzIDw8IDApDQo+ID4gPj4gK1BBRF9D
VExfRFNFX1g0ICAgICAgICAgICAgICAgICAgKDEgPDwgMCkNCj4gPiA+PiArUEFEX0NUTF9EU0Vf
WDIgICAgICAgICAgICAgICAgICAoMiA8PCAwKQ0KPiA+ID4+ICtQQURfQ1RMX0RTRV9YNiAgICAg
ICAgICAgICAgICAgICgzIDw8IDApDQo+ID4gPj4NCj4gPiA+DQo+ID4gPg0KPiA+ID4+ICBFeGFt
cGxlczoNCj4gPiA+PiAgV2hpbGUgaW9tdXhjLWxwc3IgaXMgaW50ZW5kZWQgdG8gYmUgdXNlZCBi
eSBkZWRpY2F0ZWQgcGVyaXBoZXJhbHMNCj4gPiA+PiB0byB0YWtlDQo+ID4gPj4gLS0NCj4gPiA+
PiAyLjIwLjENCj4gPiA+Pg0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+Pg0KPiA+ID4+DQo+ID4gPj4g
UGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlbWFp
bA0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+Pg0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+PiBUaGUgaW5m
b3JtYXRpb24gdHJhbnNtaXR0ZWQgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvcg0K
PiA+ID4+IGVudGl0eSB0byB3aGljaCBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250YWluIGNv
bmZpZGVudGlhbCBhbmQvb3INCj4gPiA+PiBwcml2aWxlZ2VkIG1hdGVyaWFsLiBBbnkgcmV2aWV3
LCByZXRyYW5zbWlzc2lvbiwgZGlzc2VtaW5hdGlvbiBvcg0KPiA+ID4+IG90aGVyIHVzZSBvZiwg
b3IgdGFraW5nIG9mIGFueSBhY3Rpb24gaW4gcmVsaWFuY2UgdXBvbiwgdGhpcw0KPiA+ID4+IGlu
Zm9ybWF0aW9uIGJ5IHBlcnNvbnMgb3IgZW50aXRpZXMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQN
Cj4gPiA+PiByZWNpcGllbnQgaXMNCj4gPiBwcm9oaWJpdGVkLg0KPiA+ID4+IElmIHlvdSByZWNl
aXZlZCB0aGlzIGluIGVycm9yLCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIG9yDQo+ID4gPj4g
cG9zdG1hc3Rlcg0KPiA+ID4+IChwb3N0bWFzdGVyQGhhbm92ZXJkaXNwbGF5cy5jb20pIGFuZCBk
ZWxldGUgdGhlIG1hdGVyaWFsIGZyb20gYW55DQo+ID4gPj4gY29tcHV0ZXIuDQo+ID4gPj4gQWx0
aG91Z2ggd2Ugcm91dGluZWx5IHNjcmVlbiBmb3IgdmlydXNlcywgYWRkcmVzc2VlcyBzaG91bGQg
Y2hlY2sNCj4gPiA+PiB0aGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnQgZm9yIHZpcnVzZXMu
IFdlIG1ha2Ugbm8gd2FycmFudHkgYXMNCj4gPiA+PiB0byBhYnNlbmNlIG9mIHZpcnVzZXMgaW4g
dGhpcyBlLW1haWwgb3IgYW55IGF0dGFjaG1lbnRzLg0KPiA+ID4+IE91ciBDb21wYW55J3MgZW1h
aWwgcG9saWN5IGlzIHRvIHBlcm1pdCBpbmNpZGVudGFsIHBlcnNvbmFsIHVzZS4gSWYNCj4gPiA+
PiB0aGlzIGVtYWlsIGlzIG9mIGEgcGVyc29uYWwgbmF0dXJlLCBpdCBtdXN0IG5vdCBiZSByZWxp
ZWQgdXBvbiBhcw0KPiA+ID4+IGV4cHJlc3NpbmcgdGhlIHZpZXdzIG9yIG9waW5pb25zIG9mIHRo
ZSBjb21wYW55Lg0K
