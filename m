Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122812133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="USZG7Q9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCRSKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:10:08 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:22246
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbfCRSKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIADVGMdEfycLDnVpnM+3sNuBEB5IsWTDIIxs2vPCo4=;
 b=USZG7Q9xEkg0bpjEmiTaVTTNLrSx4nA0adzBv2yldPOaCOWuGkXPxbKpMoiAJjdBKz7GW436gw+Tcm4MJakbgaXbiYPOE2LDoDOcBvmQlGkcbNem6l4SUuPIw3VRzbD8tyl5lWXk5VhMmkyigfEcE/BWEc7YyC8dkW2fKu3ree0=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB6140.eurprd05.prod.outlook.com (20.179.12.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 18:10:00 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 18:10:00 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "davem@davemloft.net" <davem@davemloft.net>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Eli Britstein <elibr@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Topic: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Index: AQHU0S+tjWF8L6Ijf0eajSu7+CzZyqX6BweAgAAklgCAF5QTgIAACYgA
Date:   Mon, 18 Mar 2019 18:10:00 +0000
Message-ID: <9c1a67b0c8e9c1e3a6448a9c3ac848c3b5d109b6.camel@mellanox.com>
References: <20190302193933.GA13467@embeddedor.com>
         <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
         <5e256a0f-ef58-4b23-8d7f-08a6148782e6@mellanox.com>
         <6cef0a46-d408-4b79-88ca-6c7da2538abf@embeddedor.com>
In-Reply-To: <6cef0a46-d408-4b79-88ca-6c7da2538abf@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff61b185-78d5-4e26-71e5-08d6abccf005
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB6140;
x-ms-traffictypediagnostic: DB8PR05MB6140:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR05MB61408EEDF7B94B4824793F7FBE470@DB8PR05MB6140.eurprd05.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(136003)(376002)(396003)(53754006)(189003)(199004)(6306002)(6512007)(966005)(478600001)(186003)(229853002)(6246003)(99286004)(6486002)(305945005)(6506007)(14454004)(53546011)(2501003)(76176011)(26005)(102836004)(36756003)(4326008)(7736002)(8936002)(105586002)(106356001)(6116002)(3846002)(2906002)(54906003)(53936002)(71200400001)(58126008)(110136005)(14444005)(97736004)(86362001)(66066001)(256004)(6436002)(71190400001)(5660300002)(316002)(8676002)(68736007)(81166006)(81156014)(118296001)(446003)(486006)(11346002)(2616005)(476003)(93886005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB6140;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E+zF1PxlQQa/avFhN5xuCWyuOkof4C8LojUClIluFWsafnngKXyIZNf4/4PN3f1oIDXNp/nCz0M3xaUB6X4qfRP1/5x8misWAcN1Q5ZZXbPi24/TqOiN0MQmqlR9GRVNgEvroh+lHP8Zb42sGlj/T4S48pRtlX2E6f/WJ1Ku2IQ0/Zob3DyUhmpWgWoaD/3qALFTMTpf5RQTArNnAT5g13+w0Ts5ET6ylojKufPxg+EEIHdaG8tBPh70ptweITwOzk5Q/hqGAJaCKsEwCQLnu4BBKUGUrsMfyws7uGUF1uqNFyZIN5dE9p/wZA712rQ7obB/FWGnEVGjJZXc9nhdk5WmaNSZf8B9+1EmHqvPz+/XSfDhG3rpSloSH2oZ7gdQXerMp3JiGdNcWRiAaq6PxAfCdtHpVmsgWKqMijdYE/I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0849FE448128264385CD7E6501AEAA38@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff61b185-78d5-4e26-71e5-08d6abccf005
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 18:10:00.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTE4IGF0IDEyOjM1IC0wNTAwLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdy
b3RlOg0KPiBIaSBhbGwsDQo+IA0KPiBGcmllbmRseSBwaW5nOg0KPiANCj4gV2hvIGNhbiB0YWtl
IHRoaXM/DQo+IA0KDQoNCkhpIEd1c3Rhdm8sIA0KDQpJIGFscmVhZHkgcmVwbGllZCBvbiBNYXJj
aCA4LCB0aGF0IHRoaXMgcGF0Y2ggd2FzIGFwcGxpZWQgdG8gbXkgYnJhbmNoLA0KbmV0LW5leHQt
bWx4NSwNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
c2FlZWQvbGludXguZ2l0L2NvbW1pdC8/aD1uZXQtbmV4dC1tbHg1JmlkPTYyNzk5OTljNmUzZGU1
YTkzMzEyYTJkNjZiM2ZkNmFjODYzNmYyNjANCg0KT25jZSBuZXQtbmV4dCBpcyBvcGVuLCB0aGlz
IHBhdGNoIGlzIGdvaW5nIHRvIG1ha2UgaXQgdGhlcmUgYXMgcGFydCBvZg0KbXkgbmV4dCBwdWxs
IHJlcXVlc3QgdG8gRGF2ZS4NCg0KVGhhbmtzLA0KU2FlZWQuDQoNCj4gVGhhbmtzDQo+IC0tDQo+
IEd1c3Rhdm8NCj4gDQo+IE9uIDMvMy8xOSAxMTozMSBBTSwgRWxpIEJyaXRzdGVpbiB3cm90ZToN
Cj4gPiBSZXZpZXdlZC1ieTogRWxpIEJyaXRzdGVpbiA8ZWxpYnJAbWVsbGFub3guY29tPg0KPiA+
IA0KPiA+IE9uIDMvMy8yMDE5IDU6MjAgUE0sIFJvaSBEYXlhbiB3cm90ZToNCj4gPiA+IE9uIDAy
LzAzLzIwMTkgMjE6MzksIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+ID4gPiA+IFJlbW92
ZSByZWR1bmRhbnQgYXNzaWdubWVudCB0byB0dW5fZW50cm9weS0+ZW5hYmxlZC4NCj4gPiA+ID4g
DQo+ID4gPiA+IEFkZGVzc2VzLUNvdmVyaXR5LUlEOiAxNDc3MzI4ICgiVW51c2VkIHZhbHVlIikN
Cj4gPiA+ID4gRml4ZXM6IDk3NDE3ZjYxODJmOCAoIm5ldC9tbHg1ZTogRml4IEdSRSBrZXkgYnkg
Y29udHJvbGxpbmcNCj4gPiA+ID4gcG9ydCB0dW5uZWwgZW50cm9weSBjYWxjdWxhdGlvbiIpDQo+
ID4gPiB0aGUgY29tbWl0IGRvZXNuJ3QgZml4IGFueSByZWFsIGlzc3VlIGJ1dCBpcyBtb3JlIG9m
IGEgY2xlYW51cC4NCj4gPiA+IHNvIEknbSBub3Qgc3VyZSBpZiBmaXhlcyBsaW5lIGlzIHJlbGV2
YW50IG9yIG5vdC4NCj4gPiA+IGJlc2lkZSB0aGF0IGxvb2tzIG9rLg0KPiA+ID4gDQo+ID4gPiBS
ZXZpZXdlZC1ieTogUm9pIERheWFuIDxyb2lkQG1lbGxhbm94LmNvbT4NCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1i
ZWRkZWRvci5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0
L21lbGxhbm94L21seDUvY29yZS9saWIvcG9ydF90dW4uYyB8IDYNCj4gPiA+ID4gKystLS0tDQo+
ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbGliL3BvcnRfdHVuLmMNCj4gPiA+ID4gYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbGliL3BvcnRfdHVuLmMNCj4gPiA+ID4g
aW5kZXggNDBmNGExOWIxY2UxLi5iZTY5YzFkNzk0MWEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9saWIvcG9ydF90dW4uYw0KPiA+
ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbGliL3Bv
cnRfdHVuLmMNCj4gPiA+ID4gQEAgLTgwLDEwICs4MCw4IEBAIHZvaWQgbWx4NV9pbml0X3BvcnRf
dHVuX2VudHJvcHkoc3RydWN0DQo+ID4gPiA+IG1seDVfdHVuX2VudHJvcHkgKnR1bl9lbnRyb3B5
LA0KPiA+ID4gPiAgIAltbHg1X3F1ZXJ5X3BvcnRfdHVuX2VudHJvcHkobWRldiwgJmVudHJvcHlf
ZmxhZ3MpOw0KPiA+ID4gPiAgIAl0dW5fZW50cm9weS0+bnVtX2VuYWJsaW5nX2VudHJpZXMgPSAw
Ow0KPiA+ID4gPiAgIAl0dW5fZW50cm9weS0+bnVtX2Rpc2FibGluZ19lbnRyaWVzID0gMDsNCj4g
PiA+ID4gLQl0dW5fZW50cm9weS0+ZW5hYmxlZCA9IGVudHJvcHlfZmxhZ3MuY2FsY19lbmFibGVk
Ow0KPiA+ID4gPiAtCXR1bl9lbnRyb3B5LT5lbmFibGVkID0NCj4gPiA+ID4gLQkJKGVudHJvcHlf
ZmxhZ3MuY2FsY19zdXBwb3J0ZWQpID8NCj4gPiA+ID4gLQkJZW50cm9weV9mbGFncy5jYWxjX2Vu
YWJsZWQgOiB0cnVlOw0KPiA+ID4gPiArCXR1bl9lbnRyb3B5LT5lbmFibGVkID0gZW50cm9weV9m
bGFncy5jYWxjX3N1cHBvcnRlZCA/DQo+ID4gPiA+ICsJCQkgICAgICAgZW50cm9weV9mbGFncy5j
YWxjX2VuYWJsZWQgOg0KPiA+ID4gPiB0cnVlOw0KPiA+ID4gPiAgIH0NCj4gPiA+ID4gICANCj4g
PiA+ID4gICBzdGF0aWMgaW50IG1seDVfc2V0X2VudHJvcHkoc3RydWN0IG1seDVfdHVuX2VudHJv
cHkNCj4gPiA+ID4gKnR1bl9lbnRyb3B5LA0KPiA+ID4gPiANCg==
