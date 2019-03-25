Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC5CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8320896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="CnbsuHmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfCYR0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:26:47 -0400
Received: from mail-eopbgr810078.outbound.protection.outlook.com ([40.107.81.78]:33067
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfCYR0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRNjPa3ionpa14HtwtZL6mHyjXxty3b5ir/+1pWayjU=;
 b=CnbsuHmUv6+71mO+Ud+QP276z95jWY4kMPEa4C8IQqopNtbk9a5R3U7jCtekhDvLYfOb+SlzXyftopuZc9TkZTjO73saYgCKcNh7h0m8iU1hgWlCHHI+90Br9k10RIX/nuCw7dhbDvHokIAyxZdd3UNconyTpRjrxv0nOzweCoE=
Received: from BYAPR05MB5240.namprd05.prod.outlook.com (20.177.231.90) by
 BYAPR05MB4197.namprd05.prod.outlook.com (52.135.200.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.14; Mon, 25 Mar 2019 17:26:36 +0000
Received: from BYAPR05MB5240.namprd05.prod.outlook.com
 ([fe80::dc61:629d:7b3a:e836]) by BYAPR05MB5240.namprd05.prod.outlook.com
 ([fe80::dc61:629d:7b3a:e836%3]) with mapi id 15.20.1750.013; Mon, 25 Mar 2019
 17:26:36 +0000
From:   Deepak Singh Rawat <drawat@vmware.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] drm/vmwgfx: Remove set but not used variable
 'fb_offset, fb_depth'
Thread-Topic: [PATCH -next] drm/vmwgfx: Remove set but not used variable
 'fb_offset, fb_depth'
Thread-Index: AQHU4SDsvdZoOTLaDE67Hj0v9eJ0jqYcnaeA
Date:   Mon, 25 Mar 2019 17:26:36 +0000
Message-ID: <53a45c6dc200247288ce70a22c06e2f1db4c5497.camel@vmware.com>
References: <20190323024606.163683-1-yuehaibing@huawei.com>
In-Reply-To: <20190323024606.163683-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::40) To BYAPR05MB5240.namprd05.prod.outlook.com
 (2603:10b6:a03:9f::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7aa7e44-90ce-43ad-1efe-08d6b14707ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4197;
x-ms-traffictypediagnostic: BYAPR05MB4197:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB4197E644B078EE0DEE431312BA5E0@BYAPR05MB4197.namprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(54906003)(81156014)(81166006)(3846002)(5660300002)(6246003)(97736004)(305945005)(8676002)(110136005)(6116002)(7736002)(106356001)(14454004)(26005)(446003)(71190400001)(4326008)(102836004)(316002)(71200400001)(478600001)(36756003)(53936002)(99286004)(118296001)(476003)(14444005)(2616005)(256004)(66066001)(229853002)(6486002)(486006)(186003)(68736007)(52116002)(25786009)(86362001)(76176011)(11346002)(50226002)(6512007)(2906002)(6436002)(386003)(8936002)(6506007)(105586002)(99106002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4197;H:BYAPR05MB5240.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DZrrmjPdUhrnyMjsC+N8fkCg5D1+/c2BfTwGHztGSQyatmJGMwsf5Uv+EsCOAfazp6w72Nyvpr68E0Inph/NgHZOkzu4qT0mfabaSxXZqIjif8vPjwpE6ohhHqV7yJwn2PruNW8MA1H9FayIbyuM1FBBkawANOp2UrNNw6Q8VErHbOFeeQXkKo6bR0wugBMxs8YIJWVBKjf0mq0E8qUCz3kCg4ymbLeM7uR0AlUvcdYYWrtlRB+4mI6C13g5TRBYl0/D1GJDOr62a28D2ZKFUQYsCGd4oe6g6q59oAupieCdyZZTBfmNYthAIUF85nI3hIOHYUN4c63qyPC0JvQej2tx9MoJM8KVUG1QqP+uhBOG22KZJv2dCzkrXhV5aoX42tZnUhlt8H3iLvG+Ar1LFIcEC8ab8T+qtUSbFYmaYjQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBB1434DE1D34A4680125BC2C5849235@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7aa7e44-90ce-43ad-1efe-08d6b14707ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:26:36.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBkb2luZyB0aGlzLg0KDQpSZXZpZXdlZC1ieTogRGVlcGFrIFJhd2F0IDxkcmF3
YXRAdm13YXJlLmNvbT4NCg0KT24gU2F0LCAyMDE5LTAzLTIzIGF0IDAyOjQ2ICswMDAwLCBZdWVI
YWliaW5nIHdyb3RlOg0KPiBGaXhlcyBnY2MgJy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdh
cm5pbmc6DQo+IA0KPiBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9mYi5jOiBJbiBmdW5j
dGlvbiAndm13X2ZiX2luaXQnOg0KPiBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9mYi5j
OjY0NToyOTogd2FybmluZzoNCj4gIHZhcmlhYmxlICdmYl9vZmZzZXQnIHNldCBidXQgbm90IHVz
ZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+IA0KPiBkcml2ZXJzL2dwdS9kcm0vdm13
Z2Z4L3Ztd2dmeF9mYi5jOjY0NToxOTogd2FybmluZzoNCj4gIHZhcmlhYmxlICdmYl9kZXB0aCcg
c2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCj4gDQo+IFRoZXkn
cmUgbm90IHVzZWQgYW55IG1vcmUsIHNvIGNhbiBiZSByZW1vdmVkLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2ZiLmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9mYi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3Ztd2dm
eC92bXdnZnhfZmIuYw0KPiBpbmRleCAyYTkxMTI1MTVmNDYuLjg2ZWZiOTFmNTAzNCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZmIuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9mYi5jDQo+IEBAIC02NDIsMTIgKzY0MiwxMSBAQCBp
bnQgdm13X2ZiX2luaXQoc3RydWN0IHZtd19wcml2YXRlICp2bXdfcHJpdikNCj4gIAlzdHJ1Y3Qg
dm13X2ZiX3BhciAqcGFyOw0KPiAgCXN0cnVjdCBmYl9pbmZvICppbmZvOw0KPiAgCXVuc2lnbmVk
IGZiX3dpZHRoLCBmYl9oZWlnaHQ7DQo+IC0JdW5zaWduZWQgZmJfYnBwLCBmYl9kZXB0aCwgZmJf
b2Zmc2V0LCBmYl9waXRjaCwgZmJfc2l6ZTsNCj4gKwl1bnNpZ25lZCBmYl9icHAsIGZiX3BpdGNo
LCBmYl9zaXplOw0KPiAgCXN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICppbml0X21vZGU7DQo+ICAJ
aW50IHJldDsNCj4gIA0KPiAgCWZiX2JwcCA9IDMyOw0KPiAtCWZiX2RlcHRoID0gMjQ7DQo+ICAN
Cj4gIAkvKiBYWFggQXMgc2hvdWxkbid0IHRoZXNlIGJlIGFzIHdlbGwuICovDQo+ICAJZmJfd2lk
dGggPSBtaW4odm13X3ByaXYtPmZiX21heF93aWR0aCwgKHVuc2lnbmVkKTIwNDgpOw0KPiBAQCAt
NjU1LDcgKzY1NCw2IEBAIGludCB2bXdfZmJfaW5pdChzdHJ1Y3Qgdm13X3ByaXZhdGUgKnZtd19w
cml2KQ0KPiAgDQo+ICAJZmJfcGl0Y2ggPSBmYl93aWR0aCAqIGZiX2JwcCAvIDg7DQo+ICAJZmJf
c2l6ZSA9IGZiX3BpdGNoICogZmJfaGVpZ2h0Ow0KPiAtCWZiX29mZnNldCA9IHZtd19yZWFkKHZt
d19wcml2LCBTVkdBX1JFR19GQl9PRkZTRVQpOw0KPiAgDQo+ICAJaW5mbyA9IGZyYW1lYnVmZmVy
X2FsbG9jKHNpemVvZigqcGFyKSwgZGV2aWNlKTsNCj4gIAlpZiAoIWluZm8pDQo+IA0KPiANCj4g
DQoNCg==
