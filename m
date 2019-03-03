Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B0C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B28A20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="qfULqiNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCCRcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:32:00 -0500
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:6421
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbfCCRb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjAixZAwKWT5wPFcPCQUo3gQTR0+M7qzqnUu6QqLB6A=;
 b=qfULqiNh/NLS03xubDZ8WgqLcTc/GXor67H5mIc8IALrxVPMN5U4H3hMRfjbqPttaTM/dS99BNfDDatdQNWbmBGyDdB32+UR+TFwEob/sQGL6F17n+/iy6SgzCcKmyR2ypyGn12sEVEC52xrl1HZq5tLqBrLmbfO8Wvq6Nxh2ag=
Received: from DB8PR05MB5897.eurprd05.prod.outlook.com (20.179.9.78) by
 DB8PR05MB5850.eurprd05.prod.outlook.com (20.179.8.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Sun, 3 Mar 2019 17:31:54 +0000
Received: from DB8PR05MB5897.eurprd05.prod.outlook.com
 ([fe80::1446:6c05:afce:bd11]) by DB8PR05MB5897.eurprd05.prod.outlook.com
 ([fe80::1446:6c05:afce:bd11%4]) with mapi id 15.20.1665.019; Sun, 3 Mar 2019
 17:31:54 +0000
From:   Eli Britstein <elibr@mellanox.com>
To:     Roi Dayan <roid@mellanox.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Topic: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Index: AQHU0S+t/J2dm9DxgE+6QI4jJLyrZqX6BweAgAAkkQA=
Date:   Sun, 3 Mar 2019 17:31:54 +0000
Message-ID: <5e256a0f-ef58-4b23-8d7f-08a6148782e6@mellanox.com>
References: <20190302193933.GA13467@embeddedor.com>
 <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
In-Reply-To: <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0003.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::16) To DB8PR05MB5897.eurprd05.prod.outlook.com
 (2603:10a6:10:a5::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elibr@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [46.120.174.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a1a2fc3-9de9-42f8-5b76-08d69ffe2094
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB5850;
x-ms-traffictypediagnostic: DB8PR05MB5850:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjhQUjA1TUI1ODUwOzIzOkRseWtsTWNvNDlaTk9RVGZSTTZJeEVVdWZX?=
 =?utf-8?B?OTNreGthSGVqTUZFMTJTc1RBV1htOUVUZHE5V3ZnOGRoN1Bmc3VHclNGZTAr?=
 =?utf-8?B?OHBvb2JWMWREeGgvdGlMb0RQVTc4bCtlS3FKcGVGRllUWEdFYVVZekhrakov?=
 =?utf-8?B?T2pjRkZydGp6Rk51bGFDK3Aya1lYR2ZORlNiTWwrNmN3cWJVM0FCbXhPdk4z?=
 =?utf-8?B?bWl3UEZEOWhONjEyU3VMK3BVbndKRGNFOVExWm9Gc3A0T1VCZ3dRdnllWnF2?=
 =?utf-8?B?M2RzUldPTk9HTk1LTWIzZ0IyTkZET0NjOHVkeUh2QkFNRFBYYmxCNFIwVXBM?=
 =?utf-8?B?Z2tjT2pQVkVDdUVjRnRTc0MzME41UTdpclp4eU1nbEE4SEF2bmpsbS9QQ0N4?=
 =?utf-8?B?Nm80YkxaVHlrL2paTDhNTjNVSGVqU3g5MDZKWXR1OHorTWlCb21PMldtWDJu?=
 =?utf-8?B?QmNrTFQ1SmNONlhqOTFzcG9FSjFhMHpwd1ZySE8yd01PeGpTTUhkWnd3T0c0?=
 =?utf-8?B?RU5OVldrbmQ5NFNnTy9VOE00Ym1WR045U2ZCZ3dCck5rV0QzYllmU2ZoUkZu?=
 =?utf-8?B?SkdZOEo5NjhmSFpqRmNPeW41OHZLNmI2M3ZJTXp6M25ScHA2a3dSQ1BERCt2?=
 =?utf-8?B?Wm8rSVYzbnlJdkNIYlF6enY4SWFYNnIxajMzQkdrTFZzTGRVamN5WHBIUG90?=
 =?utf-8?B?RHpyRERkTThEYTNUYXh2MDB1NG5KSmhjYkZIUTFFeThtaXdXSUJOYWFoUnhK?=
 =?utf-8?B?SnF1QmdvbGU0NFhnSzgrdFZjd0xOT0gyS0toSWhHV3RnUGgwV3gzdk1UejhK?=
 =?utf-8?B?d0pMSGk1NDV1YXRGSGdGQkNkOGQrT21qTXpsaGRDbTBMeTlHNzQ2NTBNcDN4?=
 =?utf-8?B?Y3RoaWRUQ1N6VjA4eWRuZ20waEJodnhPelArRUZJd0R6QlBFZlRVMElyNUVG?=
 =?utf-8?B?KzI5b24vZzY2dTNQNkJkeERYa2xyOVlWUjJoTUYvNjB6UFEzaGNnNGdVbTJm?=
 =?utf-8?B?VElMRlFtKzl1cFEzSE5FaEE5dmpaUDFxZ0JSOG9UQTB4d2pUZDF6WVJFZVVi?=
 =?utf-8?B?TElSNUNTYWFoamNaTVpqdDR1VEtDZkxxTTdvTVdMZVVsWTh6YVJkZm9RVjlp?=
 =?utf-8?B?QXVQR01aZDVsZENhWUl6MVhlZ01lTUMxN0ZJeWJETWZSdDZkZitkM3pLYmtI?=
 =?utf-8?B?cHF1UUlMVDVlRUxoZEFFczRXbi9OQUxPYmdEZEdCYzhKR2dISnhXQ2d3RlFB?=
 =?utf-8?B?WEt1bGhqVEs5N3F1WEFoWnNnTlQ1bHg5bnBSVDJROWxzTVp0d3NyeHVHWEg1?=
 =?utf-8?B?bFJkOVdnbzRDNnZvY3lyRnd6bktlTXprUnBpb3AwSTRSMUdmTVJERTE4TzUv?=
 =?utf-8?B?S1c0akMzV21WZHJqR2FNYUtwdWcwNDBNWGNvYnpyNEpuWEh3QXdMZXlLT3FQ?=
 =?utf-8?B?eWJ2NFNZSTVackZXc2dqU2duSXQ2V1RHTEVnNWJwclUwMEYvcWlNMW1vZEo1?=
 =?utf-8?B?TlozUnJsTE9CT1Q5RkRITW5KNFRWN3FHREhkK21LdUZhRCtXQ3VsZEJrZlYz?=
 =?utf-8?B?K0V5QTc4eWpNdHM2WTNycHRqTzVWdXU3SjAvcnlPbHhZazdJTHdLRitFUGlk?=
 =?utf-8?B?WEF1NjdSVmI0WDBERHdwOS9BeGpNQWl6Vi9hbGhKVzgvQ3NxWjh3UWE0ZENi?=
 =?utf-8?Q?TsfsSRdhBLj8KnNvQB8M5XR6tguH4fyPAMn2PXI?=
x-microsoft-antispam-prvs: <DB8PR05MB58507F6F6C633CD93184E244D5700@DB8PR05MB5850.eurprd05.prod.outlook.com>
x-forefront-prvs: 096507C068
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(7736002)(102836004)(110136005)(54906003)(305945005)(25786009)(36756003)(105586002)(11346002)(446003)(5660300002)(66066001)(53546011)(71190400001)(71200400001)(186003)(2906002)(26005)(316002)(386003)(97736004)(6506007)(6436002)(6512007)(76176011)(52116002)(256004)(99286004)(81156014)(8676002)(81166006)(478600001)(86362001)(31696002)(106356001)(68736007)(53936002)(6486002)(3846002)(14454004)(6246003)(4326008)(2616005)(6116002)(486006)(31686004)(229853002)(476003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB5850;H:DB8PR05MB5897.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: feupzLqBm0N3pLmeJykHSwEpPoVnYfYjFY82BeAcxKkTPBCuflc2GGY/3NYCYX4GLd9Jlt7Pnbkz0gnxg+ZJoQ6uRMfupgo7lJ/BJakgBTwevj+TfoApJs0+9YCUKt0DnNqkfQDZlePbdr5d75UHxKhnLlBbqy4XOce9GKloPT1JE1tDNRLALAkyMTtguZWKRj00mdy9RaGA1oYrIgjksdNOz8NQvYl5UJC6P+IvBS0ktpqKdcVKJzSfAG2kN3HStfDedyUytjw+5M2WITUb15ewOmeM/r7JFqAsg9mBB5AtmGfz5dWmzd401hj7tttp/L88lxpl5gsxBaFq+uf/4Rmtd+lg4n37JxIYXA9rSixx5K21TScgyIpssEkS4BKEj7CI9Z63hfIp/jhsLALkZZe2t7hlCwTzrhiLvAzw8Xo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9B4F1449F4E374A93B23F8E7C36304B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1a2fc3-9de9-42f8-5b76-08d69ffe2094
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2019 17:31:54.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEVsaSBCcml0c3RlaW4gPGVsaWJyQG1lbGxhbm94LmNvbT4NCg0KT24gMy8z
LzIwMTkgNToyMCBQTSwgUm9pIERheWFuIHdyb3RlOg0KPg0KPiBPbiAwMi8wMy8yMDE5IDIxOjM5
LCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOg0KPj4gUmVtb3ZlIHJlZHVuZGFudCBhc3NpZ25t
ZW50IHRvIHR1bl9lbnRyb3B5LT5lbmFibGVkLg0KPj4NCj4+IEFkZGVzc2VzLUNvdmVyaXR5LUlE
OiAxNDc3MzI4ICgiVW51c2VkIHZhbHVlIikNCj4+IEZpeGVzOiA5NzQxN2Y2MTgyZjggKCJuZXQv
bWx4NWU6IEZpeCBHUkUga2V5IGJ5IGNvbnRyb2xsaW5nIHBvcnQgdHVubmVsIGVudHJvcHkgY2Fs
Y3VsYXRpb24iKQ0KPiB0aGUgY29tbWl0IGRvZXNuJ3QgZml4IGFueSByZWFsIGlzc3VlIGJ1dCBp
cyBtb3JlIG9mIGEgY2xlYW51cC4NCj4gc28gSSdtIG5vdCBzdXJlIGlmIGZpeGVzIGxpbmUgaXMg
cmVsZXZhbnQgb3Igbm90Lg0KPiBiZXNpZGUgdGhhdCBsb29rcyBvay4NCj4NCj4gUmV2aWV3ZWQt
Ynk6IFJvaSBEYXlhbiA8cm9pZEBtZWxsYW5veC5jb20+DQo+DQo+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KPj4gLS0tDQo+
PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9saWIvcG9ydF90dW4u
YyB8IDYgKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxh
bm94L21seDUvY29yZS9saWIvcG9ydF90dW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxh
bm94L21seDUvY29yZS9saWIvcG9ydF90dW4uYw0KPj4gaW5kZXggNDBmNGExOWIxY2UxLi5iZTY5
YzFkNzk0MWEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9t
bHg1L2NvcmUvbGliL3BvcnRfdHVuLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
bGxhbm94L21seDUvY29yZS9saWIvcG9ydF90dW4uYw0KPj4gQEAgLTgwLDEwICs4MCw4IEBAIHZv
aWQgbWx4NV9pbml0X3BvcnRfdHVuX2VudHJvcHkoc3RydWN0IG1seDVfdHVuX2VudHJvcHkgKnR1
bl9lbnRyb3B5LA0KPj4gICAJbWx4NV9xdWVyeV9wb3J0X3R1bl9lbnRyb3B5KG1kZXYsICZlbnRy
b3B5X2ZsYWdzKTsNCj4+ICAgCXR1bl9lbnRyb3B5LT5udW1fZW5hYmxpbmdfZW50cmllcyA9IDA7
DQo+PiAgIAl0dW5fZW50cm9weS0+bnVtX2Rpc2FibGluZ19lbnRyaWVzID0gMDsNCj4+IC0JdHVu
X2VudHJvcHktPmVuYWJsZWQgPSBlbnRyb3B5X2ZsYWdzLmNhbGNfZW5hYmxlZDsNCj4+IC0JdHVu
X2VudHJvcHktPmVuYWJsZWQgPQ0KPj4gLQkJKGVudHJvcHlfZmxhZ3MuY2FsY19zdXBwb3J0ZWQp
ID8NCj4+IC0JCWVudHJvcHlfZmxhZ3MuY2FsY19lbmFibGVkIDogdHJ1ZTsNCj4+ICsJdHVuX2Vu
dHJvcHktPmVuYWJsZWQgPSBlbnRyb3B5X2ZsYWdzLmNhbGNfc3VwcG9ydGVkID8NCj4+ICsJCQkg
ICAgICAgZW50cm9weV9mbGFncy5jYWxjX2VuYWJsZWQgOiB0cnVlOw0KPj4gICB9DQo+PiAgIA0K
Pj4gICBzdGF0aWMgaW50IG1seDVfc2V0X2VudHJvcHkoc3RydWN0IG1seDVfdHVuX2VudHJvcHkg
KnR1bl9lbnRyb3B5LA0KPj4NCg==
