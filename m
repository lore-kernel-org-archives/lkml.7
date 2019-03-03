Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A6C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A7A20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="U3gcR5fS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfCCPVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:21:03 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:9952
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfCCPVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dcoodz/C1aYS/UpdbQActgRCVMb1XqBqdH81id3//p0=;
 b=U3gcR5fSV/XHNlzDMT+o0twt3N9CTn/mns63yT+f+vmzOPbfZrO65xwYKDe+tGN94MM8fOSjzX5yLZPtJE/3oyG1cZkZ0wINfKgMu2ZBobFcO1t9uHKsH9mgIAPcm4cENipRRfhT06qBfMbTswDsRMuhrnxQqBMHwOOT1XAcZi4=
Received: from AM6PR05MB4198.eurprd05.prod.outlook.com (52.135.161.31) by
 AM6PR05MB5831.eurprd05.prod.outlook.com (20.178.94.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Sun, 3 Mar 2019 15:20:57 +0000
Received: from AM6PR05MB4198.eurprd05.prod.outlook.com
 ([fe80::4902:bfc9:7aca:85b9]) by AM6PR05MB4198.eurprd05.prod.outlook.com
 ([fe80::4902:bfc9:7aca:85b9%4]) with mapi id 15.20.1665.019; Sun, 3 Mar 2019
 15:20:57 +0000
From:   Roi Dayan <roid@mellanox.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eli Britstein <elibr@mellanox.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Topic: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Index: AQHU0S+0OucuK5wAZka9EX5sKjTz6KX6BwMA
Date:   Sun, 3 Mar 2019 15:20:57 +0000
Message-ID: <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
References: <20190302193933.GA13467@embeddedor.com>
In-Reply-To: <20190302193933.GA13467@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.47.165.251]
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-clientproxiedby: AM6PR0502CA0036.eurprd05.prod.outlook.com
 (2603:10a6:209:1::49) To AM6PR05MB4198.eurprd05.prod.outlook.com
 (2603:10a6:209:40::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roid@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2df00236-8bef-47b1-52de-08d69febd5d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5831;
x-ms-traffictypediagnostic: AM6PR05MB5831:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA1TUI1ODMxOzIzOnl1akpFZFh4L2lMN2JKZUlhS3Z3dWVXdXhn?=
 =?utf-8?B?ME5MYTV6MzBwaFB2b0VUZHduMzJLTUNMSU40QnV2bGFqanBKVUwzYW9kRFlO?=
 =?utf-8?B?K25BUmVYbGF0dmJZMVpZdGVhNnR6QTNiWXI1K3RjUlA3c3h1empIdUJsRWtW?=
 =?utf-8?B?aC9XcHlQUE1QQ3pGZWJkdmlQR0FGNzh4eTZEUnJaUDNCYkt2RUorRGNZN21E?=
 =?utf-8?B?UTU4aXFveXNpaFNXakZvc005YnhvKzRzZnJ3RWwxSDBjdlFIdUszSitQNUU5?=
 =?utf-8?B?eUMvNjZ0RmhZRXN5RXJuZll3RjBsZ2R0eGVzenM2Uk80c0NVNmRzb2taeGVz?=
 =?utf-8?B?bjRmSDRPNmVtUUZrUVNGWFByNlRZamFGRXhWOEdsbFBKQnIweVVFRGRrMzdo?=
 =?utf-8?B?bzJXZWVUYXloUmpValBMTEUwcWpHNXhud2x2Mzl1SUJKTnc3M3BpYWt3VUdM?=
 =?utf-8?B?V21nUGxOMWp5NXpkZnlQQWFQR0c3MEQvZDYrU3FCL21hV1JhL3BsVFdZSjYy?=
 =?utf-8?B?NHorRmhFTThXNjEvYzVxZ09zN0x2Q1RNS0JDY1ZISU1RMm5NRVFrZUlhVzBT?=
 =?utf-8?B?MndxMGtRNk9hMFdjMS9VdGhJNU9vOVNJL3lyN3lIUmdySklienhNQUlkSGNr?=
 =?utf-8?B?OUNNVTNnZnoyRTd3bExiU3MrK2szMjQ0WkxSZGJMU2VIN1JpUHJWUzh5QnF6?=
 =?utf-8?B?MWxJcDAwWXF1QzNJblNtd1BIeDJ6TDRxL0FBUlliTXkrdlFocTdZUXNjL0Nn?=
 =?utf-8?B?WlFOaDlRWjhJeWR2NFRUV21zcUVHbDQ5RTRpUng5QkJGOVJjSUcybytyTHdO?=
 =?utf-8?B?bHdSL3cwSGtqWlhYdm5YN0NqdjI0NGgzQXJicGFJc0x6alBBaFllM3Q0cnUr?=
 =?utf-8?B?L3NLUXJpNFB5dlptYXlmSXBoMUJLNWY1ejEwNk1zbDZLSUl2RFVmOEQ2TFVn?=
 =?utf-8?B?dFJhdTYvbnNmMWxNSHVGZHBRMVFiZ1l2WVdnaHh6V3V2c2tSZVc3KzVONXdx?=
 =?utf-8?B?Q21jSmVFMHZqN1hiSjk1dlJ1QUFnem9TQ2tWNVFOY0lSR3VySlhha0V0MVJ1?=
 =?utf-8?B?cFllbGtGQ2Q0WFZOTTV0bzlEbDNmdThuL2hmNE9oZ2hwOGxXSXlNRFNSS3F0?=
 =?utf-8?B?dHIxOWoxV25tdy9zK3RhcUhJbjdDQlA2S2dHZzB4SjVyZjZocmR4OHJJY25o?=
 =?utf-8?B?OW56ekJVZ2Jha3QrTWM3ajhzK2pDdnRCbmtWTmhGRGxPb0JQTFpLcFpJY1V0?=
 =?utf-8?B?QmIxT0ZBOUlKWHdZaHRaNnBDWUtJakdScC95ODRBNnZBcmdiVUQwYmc2eDZV?=
 =?utf-8?B?YXM1TWZHeFpHR3p4WmhRTCt0QzVWVFZRbjMrL2Q1VFZ2cEcwc2NHaEFWNzBL?=
 =?utf-8?B?dnhwM2hRcjMzQjJ4eWV1SmJEL2swMlBIQlh2Z2Jmb1ozalZpQmRhZmFhZFpQ?=
 =?utf-8?B?Z1o0V2RiaW54d3RuV05hZ1FxbmxyWFRDM3pERGFYVi9rRHhzcUQvUjhocmNz?=
 =?utf-8?B?Y1RWTXN2V0x2SGpSR0tkbVNCMGF0L3N4SGd5NVBHYjd5WWRQd24rSkxLbnh4?=
 =?utf-8?B?ZFN5dWRCWHFES2tkMmRvaklJVVJnbng0T2V1eGNUblFjamFzU3E3SHJrN1Ur?=
 =?utf-8?B?Z1h5RGpHdDBTZnlmYlZ3b0lTVm8zWnEvY2NWdUpsL2RJb0lZZnNUZ09pRmh6?=
 =?utf-8?B?L3d4NW5sMDk3UXZHRDdrbDdtZUl3RG00SHpuZXZ6azNUUFlkQ2tGbktMT3dR?=
 =?utf-8?B?U3I1K3MrOEY1TUZxN2I2OGxWeFBHODVQSnhobllwQVZhZEcxa3RhTTdoTGFQ?=
 =?utf-8?B?dmg4UDlqRk9UczdFZXppRURwQjliWnZPTTJObWVLQ3F2WmNIRFhvR2gwUWN1?=
 =?utf-8?Q?8/gPT68zK0b66TLep6EYaMAPlfAUTf6b?=
x-microsoft-antispam-prvs: <AM6PR05MB5831CD36BA67D230437C9D41B5700@AM6PR05MB5831.eurprd05.prod.outlook.com>
x-forefront-prvs: 096507C068
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(76176011)(386003)(65956001)(66066001)(52116002)(8676002)(81156014)(81166006)(65806001)(36756003)(14454004)(68736007)(8936002)(478600001)(99286004)(53936002)(2906002)(4326008)(64126003)(7736002)(486006)(11346002)(2616005)(476003)(6506007)(305945005)(6512007)(106356001)(6636002)(25786009)(71190400001)(6436002)(71200400001)(97736004)(105586002)(6486002)(256004)(102836004)(110136005)(5660300002)(186003)(65826007)(86362001)(6246003)(316002)(54906003)(31686004)(446003)(6116002)(53546011)(58126008)(31696002)(26005)(3846002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5831;H:AM6PR05MB4198.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fIWqNm093Q2tYphdCngH/5Mev/lo629Nu5jB8rwWb4+8zrswtjvwOKX5nn+6kDnSgdk30Y50chKAWqA5/CRHY2LsFrmeYeinHy1UdMYNl3SgVr1Rxzp/HsTGUVBpLLETllRYMXD7wLlU2T9/QCo7VX0GGLPT62js7TPV0pjGrxf01/NxnGB5WC4lNz67XqH2/cUHif5iUxgJHHpRKA15Ifn+eA12zGqQXRFaTe72boRgxCClMAJelLw75KEN3OXdhX8KxiWDYYxb99bOjNa+Sj66sWL1ExuPNlBPKL/uAyyWrpXsvpwxzD1OLnKsL2cRvUWV4RmWch3EQOcuUmrHyPR8j2kXjKriLe3sFxFV9KQxjjeCcR7a6t3MW0DSh/MufOSJO2Tk1Z0bUYFM5VBbX6YPIGVpGKNxXin/hlTDc/g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7116A5FC429F55479DB7813E52C3D44F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df00236-8bef-47b1-52de-08d69febd5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2019 15:20:57.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzAzLzIwMTkgMjE6MzksIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+IFJl
bW92ZSByZWR1bmRhbnQgYXNzaWdubWVudCB0byB0dW5fZW50cm9weS0+ZW5hYmxlZC4NCj4gDQo+
IEFkZGVzc2VzLUNvdmVyaXR5LUlEOiAxNDc3MzI4ICgiVW51c2VkIHZhbHVlIikNCj4gRml4ZXM6
IDk3NDE3ZjYxODJmOCAoIm5ldC9tbHg1ZTogRml4IEdSRSBrZXkgYnkgY29udHJvbGxpbmcgcG9y
dCB0dW5uZWwgZW50cm9weSBjYWxjdWxhdGlvbiIpDQoNCnRoZSBjb21taXQgZG9lc24ndCBmaXgg
YW55IHJlYWwgaXNzdWUgYnV0IGlzIG1vcmUgb2YgYSBjbGVhbnVwLg0Kc28gSSdtIG5vdCBzdXJl
IGlmIGZpeGVzIGxpbmUgaXMgcmVsZXZhbnQgb3Igbm90Lg0KYmVzaWRlIHRoYXQgbG9va3Mgb2su
DQoNClJldmlld2VkLWJ5OiBSb2kgRGF5YW4gPHJvaWRAbWVsbGFub3guY29tPg0KDQoNCj4gU2ln
bmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbGliL3Bv
cnRfdHVuLmMgfCA2ICsrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvbGliL3BvcnRfdHVuLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvbGliL3BvcnRfdHVuLmMNCj4gaW5kZXggNDBmNGExOWIxY2UxLi5i
ZTY5YzFkNzk0MWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94
L21seDUvY29yZS9saWIvcG9ydF90dW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvbGliL3BvcnRfdHVuLmMNCj4gQEAgLTgwLDEwICs4MCw4IEBAIHZv
aWQgbWx4NV9pbml0X3BvcnRfdHVuX2VudHJvcHkoc3RydWN0IG1seDVfdHVuX2VudHJvcHkgKnR1
bl9lbnRyb3B5LA0KPiAgCW1seDVfcXVlcnlfcG9ydF90dW5fZW50cm9weShtZGV2LCAmZW50cm9w
eV9mbGFncyk7DQo+ICAJdHVuX2VudHJvcHktPm51bV9lbmFibGluZ19lbnRyaWVzID0gMDsNCj4g
IAl0dW5fZW50cm9weS0+bnVtX2Rpc2FibGluZ19lbnRyaWVzID0gMDsNCj4gLQl0dW5fZW50cm9w
eS0+ZW5hYmxlZCA9IGVudHJvcHlfZmxhZ3MuY2FsY19lbmFibGVkOw0KPiAtCXR1bl9lbnRyb3B5
LT5lbmFibGVkID0NCj4gLQkJKGVudHJvcHlfZmxhZ3MuY2FsY19zdXBwb3J0ZWQpID8NCj4gLQkJ
ZW50cm9weV9mbGFncy5jYWxjX2VuYWJsZWQgOiB0cnVlOw0KPiArCXR1bl9lbnRyb3B5LT5lbmFi
bGVkID0gZW50cm9weV9mbGFncy5jYWxjX3N1cHBvcnRlZCA/DQo+ICsJCQkgICAgICAgZW50cm9w
eV9mbGFncy5jYWxjX2VuYWJsZWQgOiB0cnVlOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IG1s
eDVfc2V0X2VudHJvcHkoc3RydWN0IG1seDVfdHVuX2VudHJvcHkgKnR1bl9lbnRyb3B5LA0KPiAN
Cg==
