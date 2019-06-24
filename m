Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE60C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C932083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lyxixNAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfFXHQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:16:26 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:1090
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbfFXHQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmaWFntu9vEMCGx5sjQ2w+4Kf6qaYGnJ9GQ+TbaBhLA=;
 b=lyxixNAu1Mj+TWWWiIC1kKiFMmOoA4uG0mWzlxQRHdeni23U0/TTTrvAAhITQKLZHxG9dHyuzxbEfdKGU20GnsfWx3Bi+fqM3HN7u8ItJ69ZSUpUnNCozHS8ulVr7P5nue4y7o/ayhZS3NhjhbSLfxAKEmaY7SY0j/r/fbPZiPk=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5933.eurprd04.prod.outlook.com (20.178.205.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 07:16:21 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::bcac:811a:b5bf:1431]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::bcac:811a:b5bf:1431%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 07:16:21 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v7 1/5] usb: fsl: Set USB_EN bit to select ULPI
 phy
Thread-Topic: [EXT] Re: [PATCH v7 1/5] usb: fsl: Set USB_EN bit to select ULPI
 phy
Thread-Index: AQHVIo6OTNdhagpIRU+CoiRRk5Bv8qakfUsAgAXzwoA=
Date:   Mon, 24 Jun 2019 07:16:21 +0000
Message-ID: <VI1PR04MB41587429A99C648AF57ED42DE9E00@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190614085433.22344-1-yinbo.zhu@nxp.com>
 <20190620121052.GC19295@kroah.com>
In-Reply-To: <20190620121052.GC19295@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 984beaf3-063f-4c48-cc4e-08d6f873dc22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5933;
x-ms-traffictypediagnostic: VI1PR04MB5933:
x-microsoft-antispam-prvs: <VI1PR04MB593360196C014B1E181E5952E9E00@VI1PR04MB5933.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(136003)(376002)(13464003)(189003)(199004)(8936002)(81156014)(81166006)(99286004)(476003)(6246003)(3846002)(52536014)(6116002)(86362001)(8676002)(4326008)(33656002)(68736007)(9686003)(6436002)(66476007)(55016002)(53936002)(76116006)(66946007)(73956011)(229853002)(66446008)(478600001)(5660300002)(44832011)(71190400001)(71200400001)(6506007)(25786009)(316002)(26005)(64756008)(66556008)(54906003)(2906002)(7696005)(14454004)(6916009)(446003)(14444005)(256004)(7736002)(66066001)(305945005)(74316002)(11346002)(486006)(53546011)(76176011)(186003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5933;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cK9+tqzanqMdZiCDR0ouVYYIEKzgEI2FlKSPl7Kkn2pu+B7fsSUf4ssODLaHDhpd9SQ1DzZk2j5e8Xx+uYIpccgeRLgyGIu8wWQjdhz4ic2bYSy/Bi8S1X1MloRm0+Ax2cULYhd+9fT7FBo9QVOXdOkwM338r/u8mA3vmb/9yqj5YZZ5868SUrC2i8iLo+i5a4lFlM4WczCZqULq0YfWViTexCKkhyB1Y/xDHC5yMEpQyDQI8UU3j5kXbhxEdpUKaFafwIwDiCLODgHXoheFXRKI5qGD426fOO9CLYBpDd8xVbm4qCuxxd12kehwrHovRMy3TjhSSIVRxYtB/woozOuwgFGcWoe7lNUGEcUO7qyF8DyxPyOTXc+vnEKCxvOhL5Kglu9Gxcu2Z4nxDAxux14M2kZfpFmFEqCYgP0hjY0=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984beaf3-063f-4c48-cc4e-08d6f873dc22
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 07:16:21.7059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yinbo.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLcm9haC1IYXJ0
bWFuIFttYWlsdG86Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+IFNlbnQ6IDIwMTnE6jbU
wjIwyNUgMjA6MTENCj4gVG86IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQo+IENjOiBB
bGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1PjsgWGlhb2JvIFhpZSA8eGlhb2Jv
LnhpZUBueHAuY29tPjsNCj4gSmlhZmVpIFBhbiA8amlhZmVpLnBhbkBueHAuY29tPjsgUmFtbmVl
ayBNZWhyZXNoDQo+IDxyYW1uZWVrLm1laHJlc2hAZnJlZXNjYWxlLmNvbT47IE5pa2hpbCBCYWRv
bGENCj4gPG5pa2hpbC5iYWRvbGFAZnJlZXNjYWxlLmNvbT47IFJhbiBXYW5nIDxyYW4ud2FuZ18x
QG54cC5jb20+Ow0KPiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjcgMS81XSB1c2I6IGZz
bDogU2V0IFVTQl9FTiBiaXQgdG8gc2VsZWN0IFVMUEkgcGh5DQo+IA0KPiBDYXV0aW9uOiBFWFQg
RW1haWwNCj4gDQo+IE9uIEZyaSwgSnVuIDE0LCAyMDE5IGF0IDA0OjU0OjI5UE0gKzA4MDAsIFlp
bmJvIFpodSB3cm90ZToNCj4gPiBGcm9tOiBOaWtoaWwgQmFkb2xhIDxuaWtoaWwuYmFkb2xhQGZy
ZWVzY2FsZS5jb20+DQo+ID4NCj4gPiBTZXQgVVNCX0VOIGJpdCB0byBzZWxlY3QgVUxQSSBwaHkg
Zm9yIFVTQiBjb250cm9sbGVyIHZlcnNpb24gMi41DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
aWtoaWwgQmFkb2xhIDxuaWtoaWwuYmFkb2xhQGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy91c2IvaG9zdC9laGNpLWZzbC5jIHwgNiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gV2hhdCBjaGFuZ2VkIGZyb20gdjEtdjc/ICBUaGF0IHNob3Vs
ZCBhbHdheXMgZ28gYmVsb3cgdGhlIC0tLSBsaW5lLg0KPiANCj4gUGxlYXNlIGZpeCB1cCB3aGVu
IHlvdSByZXNlbmQgdjguDQpPa2F5LCBJIHdpbGwgZG8gaXQsIGJ1dCBJIGFjY3VzdG9tZWQgdG8g
ZG8gY2hhbmdlIHZlcnNpb24gaWYgdGhlIHNlcmllcyBvZiBvdGhlciBwYXRjaCBoYXMgdXBkYXRl
LCBJIHN0aWxsIHVwZGF0ZSBwYXRjaCBzZXJpZXMgbnVtYmVyIGZvciBhbGwgc2VyaWVzIHBhdGNo
LCBidXQgbm8gdXBkYXRlZCBoaXN0b3J5IGluIG5vY2hhbmdlJ3MgcGF0Y2ggaW4gY3VycmVudCBz
ZXJpZXMuDQoNClRoYW5rcywNCkJlc3QgUmVnYXJkcywNCllpbmJvIHpodS4NCj4gDQo+IHRoYW5r
cywNCj4gDQo+IGdyZWcgay1oDQo=
