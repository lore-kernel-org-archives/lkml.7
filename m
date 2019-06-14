Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0D0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6941D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jGcbkePR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfFNNuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:50:17 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:35591
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728182AbfFNNuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBIioesIuLp0QB7Oka03l4Du5E/SXG5X+2PTItoXJxg=;
 b=jGcbkePR59rX5MNWj2qmnehJ57rqk3boIVX5TYXFQIz8Y9aDM5du4Xcu5gwZfLM2yOgshJV8ubsFGkDKWTMUdj/FLi/lWenhSqRgkjYCQiMI5rI4iibY05IauE1mI6aJ9S2hueNE+MG4VNGqYp6aAMmceQAZgoFT7NJbWwESFEg=
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.123.141) by
 VI1PR04MB4478.eurprd04.prod.outlook.com (20.177.53.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 14 Jun 2019 13:50:12 +0000
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7]) by VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7%7]) with mapi id 15.20.1965.018; Fri, 14 Jun 2019
 13:50:12 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [EXT] Re: [PATCH 2/2] drm/panel: Add support for Raydium RM67191
 panel driver
Thread-Topic: [EXT] Re: [PATCH 2/2] drm/panel: Add support for Raydium RM67191
 panel driver
Thread-Index: AQHVIqdzFTZPTbEojEKDO3NY8aRErKabE9mAgAARJ4CAAAL7gIAAAuGA
Date:   Fri, 14 Jun 2019 13:50:12 +0000
Message-ID: <1560520211.9328.41.camel@nxp.com>
References: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com>
         <1560513063-24995-3-git-send-email-robert.chiras@nxp.com>
         <CAOMZO5BAborMvk=4cgreWKX6rJjK-237me98dM1dDV53oUnExQ@mail.gmail.com>
         <1560518953.9328.31.camel@nxp.com>
         <CAOMZO5DcvKQPDhP468VSCfQkFy-7roKBkw7uqXxTMn9PTTgS+A@mail.gmail.com>
In-Reply-To: <CAOMZO5DcvKQPDhP468VSCfQkFy-7roKBkw7uqXxTMn9PTTgS+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31f6b76c-8377-44a4-9406-08d6f0cf38dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4478;
x-ms-traffictypediagnostic: VI1PR04MB4478:
x-microsoft-antispam-prvs: <VI1PR04MB4478306BC725240DFDF5358FE3EE0@VI1PR04MB4478.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(229853002)(36756003)(6916009)(86362001)(25786009)(6486002)(54906003)(1411001)(68736007)(2351001)(14444005)(6246003)(316002)(103116003)(2906002)(186003)(305945005)(7416002)(7736002)(256004)(66066001)(1361003)(4326008)(6436002)(3846002)(476003)(66946007)(8936002)(73956011)(71200400001)(11346002)(64756008)(2616005)(66556008)(66476007)(66446008)(486006)(6512007)(53546011)(6506007)(76116006)(102836004)(76176011)(8676002)(44832011)(6116002)(478600001)(1730700003)(81166006)(446003)(71190400001)(26005)(53936002)(4744005)(5660300002)(50226002)(5640700003)(14454004)(2501003)(99286004)(81156014)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4478;H:VI1PR04MB5967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ccZTdIHeTAVSoEfMTGscJhkjNGi6NdFIppIr89Q4c3u2CO+pRPoaPJcP6IDTO7cWJ1IxH8o7v+NruyQdGE8U0YVlstSVm3YiH0gUTocXK0UJLJXIHPnzwWlrenQTw79lqzHnGr8k5QaeHIPh0sWW8HBgjW1phAAUR4+jd101KwcN4R/Lu8rdIk6s5MV/iD2f2oWFWfUJXYwkv0WbZSdBNOzHjnxrTOYELC3b1v3BE4uPftkTuW1J1OWVv/dBZFQmKGiuv4MVBgyhbe1FWNPnHFkwcYJLYvpVmPHYlf9aGOlhq6ompDJ6bvF5MbgkSAmi9fQwnSTgB8fbQE+rAxSZn7g0Yudv58AObLhAhJyz2K/2QSvJ1cFXjmpMPBsZIQIDjRWkj60Sf9nKe7xzDUZu/Nx4laLz458WfCyK3xR0wus=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFE0FA3EDFCE8F479938F2D5F10DD015@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f6b76c-8377-44a4-9406-08d6f0cf38dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 13:50:12.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: robert.chiras@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVmksIDIwMTktMDYtMTQgYXQgMTA6MzkgLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+
IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgMTA6Mjkg
QU0gUm9iZXJ0IENoaXJhcyA8cm9iZXJ0LmNoaXJhc0BueHAuY29tDQo+ID4gd3JvdGU6DQo+IA0K
PiA+IA0KPiA+IFRoZSBHUElPIGlzIGFjdGl2ZSBoaWdoLCBhbmQgdGhlIGFib3ZlIHNlcXVlbmNl
IHdhcyByZWNlaXZlZCBmcm9tDQo+ID4gdGhlDQo+ID4gcGFuZWwgdmVuZG9yIGluIHRoZSBmb2xs
b3dpbmcgZm9ybToNCj4gPiDCoMKgwqDCoMKgwqDCoMKgU0VUX1JFU0VUX1BJTigxKTsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgTURFTEFZKDEwKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgU0VUX1JFU0VU
X1BJTigwKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgTURFTEFZKDUpOw0KPiA+IMKgwqDCoMKgwqDC
oMKgwqBTRVRfUkVTRVRfUElOKDEpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBNREVMQVkoMjApOw0K
PiA+IEkgZ290IHJpZCBvZiB0aGUgZmlyc3QgdHJhbnNpdGlvbiB0byBoaWdoIHNpbmNlIHNlZW1l
ZCByZWR1bmRhbnQuDQo+ID4gQWxzbywgYWNjb3JkaW5nIHRvIHRoZSBtYW51YWwgcmVmZXJlbmNl
LCB0aGUgUlNUQiBwaW4gbmVlZHMgdG8gYmUNCj4gPiBhY3RpdmUgaGlnaCB3aGlsZSBvcGVyYXRp
bmcgdGhlIGRpc3BsYXkuDQo+IFRoYXQncyBleGFjdGx5IG15IHBvaW50IDotKQ0KPiANCj4gSW4g
bm9ybWFsIG9wZXJhdGlvbiB0aGUgR1BJTyByZXNldCBuZWVkcyB0byBiZSBoaWdoLg0KPiANCj4g
RHVyaW5nIHJlc2V0IHRoZSBHUElPIHJlc2V0IG5lZWRzIHRvIGJlIGxvdy4sIHdoaWNoIG1lYW5z
IHRoYXQgdGhlDQo+IEdQSU8gcmVzZXQgaXMgImFjdGl2ZSBsb3ciLg0KPiANCj4gU28geW91IHNo
b3VsZCBpbnZlcnQgYm90aCB0aGUgZHRzIGFuZCB0aGUgZHJpdmVyIHRvIGJlaGF2ZSBjb3JyZWN0
bHkuDQpOb3cgSSBnZXQgaXQuIFRoYW5rcyEgSSB3aWxsIHVwZGF0ZSB0aGUgZHRzIGFuZCBkcml2
ZXIgZm9yIHRoZSBncGlvLg==
