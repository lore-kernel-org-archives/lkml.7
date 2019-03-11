Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7D4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="sy1ehUkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfCKJwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:52:45 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7246 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfCKJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:52:44 -0400
X-IronPort-AV: E=Sophos;i="5.58,467,1544511600"; 
   d="scan'208";a="27960966"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Mar 2019 02:52:43 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 11 Mar 2019 02:52:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJe+ByDX3rOe07R2UI/KgYP2eiE8CoCF10qohVvuUy0=;
 b=sy1ehUkh9uwntzCBtF9JnxtqcFrwNQ83md6FVw8yIDcvoCfHSpZELiaPMaWr8QVlR0w3odn71q66vLdePjHtVVoSwcLfosP4r+c7TP9DDp5xnjxDOvaw+rjRviASE/SlxNHaf7dlhUMe8MCysQYdfmIhChXxOHRNKnHu7oKwTiE=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1871.namprd11.prod.outlook.com (10.175.53.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.22; Mon, 11 Mar 2019 09:52:41 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5413:49b5:8548:fe44]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5413:49b5:8548:fe44%8]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:52:41 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <david.engraf@sysgo.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: at91: Fix typo in ISC_D0 on PC9
Thread-Topic: [PATCH] ARM: dts: at91: Fix typo in ISC_D0 on PC9
Thread-Index: AQHU1+FmKmRv5qHx8k2BLrHq+kz3oKYGMIcA
Date:   Mon, 11 Mar 2019 09:52:41 +0000
Message-ID: <48221283-f5c8-2c03-db40-11c581911434@microchip.com>
References: <20190311075742.23320-1-david.engraf@sysgo.com>
In-Reply-To: <20190311075742.23320-1-david.engraf@sysgo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0384.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::36) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2fd9c73-9ad1-4681-dd5c-08d6a6074d5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1871;
x-ms-traffictypediagnostic: MWHPR11MB1871:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxODcxOzIzOnZWQVBmWjhjNEZLN2VUNEdpcGJPUDAvckps?=
 =?utf-8?B?d3Y0TDNmNkFCR3VrdEJ3dzloczNHSmFoa0xVN3FoTGVwSHBkT3RjL0VTYUFi?=
 =?utf-8?B?MEpkNU1WYjZIL2MyNU5GOW1Sd3NtdFgrSW52aFpJRy80SDlvMEtpa0haT0c1?=
 =?utf-8?B?aVp1VDNLZUliZXhqWVlHZlhRSzY3YlM3Q2VWVEd0K1JDd0lNdXByYmpBWjc3?=
 =?utf-8?B?eVlITnYxMVMyNUtQQVQ1RXBjQTZLdFBpL1d1blk3YldxTm02OVpzdXM4NFdD?=
 =?utf-8?B?aGdIMmFQTWxMTFJMb3l6M1AraWhhQmlSS3pTRHdmbHAwUXFhMXpQZW5hUlV0?=
 =?utf-8?B?bjh3ZkxLYklzZjhocnlQa3pKR0pXSTF4cGRvUU5rcXk4ZnR4K1J5Q3pFSkcx?=
 =?utf-8?B?MDY1dWE0ZkVEeUhRSG1VK0xUc0RWUGNZczdNWHMzdUVPS25Ob1FNeExxUzZV?=
 =?utf-8?B?a1diTmNoMThxR25HTlU5dWpFbkhjNkhXbUFQak1nSklZeTR5VHhURWZ0QVV4?=
 =?utf-8?B?U005MWtsbzBtSGR2N1FLS1V6cVBzS1dpMTd6SmJPSkZIMVhMN2w1N3dyODFq?=
 =?utf-8?B?ZlBXTllSTVdSQmdNaWY0aHBvNjRNdzVSVlY4ZDA2djF2eTVkS3RnUldoMGRY?=
 =?utf-8?B?bXQ1ellXQTZlYWZMUmkyREYyQXZIYXZQQWEySXl6MklmZEdCa0Yrb3B6THlp?=
 =?utf-8?B?ZUtnenlybWREMWRGczNvRHhqVUNtMFZoTUhpOVR1Q3VKRGhtM2Y1djBVaVg2?=
 =?utf-8?B?b3RlVG9XekpXVlRiK21ZYUMvUmJNYmNOT2YrTXZLWWxVdVU4cVdYd290T0sv?=
 =?utf-8?B?RlBLOEkxMlA0Qm9tRVY1LzBhMmsrQXlqMkJPdlBQWFFLRUVpc25hWHBNMWta?=
 =?utf-8?B?b1JFalg1enNLYnh6azg2bXNZeFFJZXNQUG5makh1MVFCZ1RReERySWpuYVZW?=
 =?utf-8?B?RSsxMTR1MzBFT1oyVnNXVnBjTjgvYjkxMVRUU1hIYlM5dkV6ZDlaTzNjOXIx?=
 =?utf-8?B?TkdMdlpOeHpuNWVpbHg1WGZZQTR3SGcxZTR0MWZGSnphQVZucXk5UGNDMGE0?=
 =?utf-8?B?Y3VTNm9vVUxTNUxJREcrWExmSDlDU2VOc2JPMnpsc0RKMllXK3g1b1BsZzhT?=
 =?utf-8?B?RnlWQ09uY3RUa2tnTjBvbGhCcFY1U2pIU0RGZ1JXVGJmNkxrQVN3SGRHRTgw?=
 =?utf-8?B?WlNwbitGODFWZE9MaTRPMkI2ekpmWnhIV3J5Y3RabktwQnFOS3NiNzlGUUFz?=
 =?utf-8?B?UkFHY3J4SmpteEwyckxEOEZicmwwV0hKRjVBZVNRQWxXdHVvVUZyYWY2dnhD?=
 =?utf-8?B?d3F6cVZhVXRDOEVwNU9ZRkVZYmZuNEhiL3pBQjVKS3hkenFsQ0k5VUlMSUhU?=
 =?utf-8?B?STQ1VWgvOS9uL3YzM0txb1VaZHh4ZENvZmVCOUhuekJ5SFMxN1RlUmpvNWow?=
 =?utf-8?B?TCtycHp6VVZROVRjak1tREtPTmFyMlpzMVhRUWZSdWZEeFpVQVJ2L1l3Umhw?=
 =?utf-8?B?TDlPWExiYk9DMjdwMUQycThLMDB6aGZsc1NFSmE0L2J0R2FDY3k2TmxhWm9Z?=
 =?utf-8?B?VGtISDZCYmpRdHVyRE5raUJJUmliaVF6MnZ4aVhsandCV2ZzUDYyWDA2MnhB?=
 =?utf-8?B?eHJTbnRVUXRoUHFmckFsUnVEbW8valU5TURRYmN4cERXS2NOYzBZdFlFMGlS?=
 =?utf-8?B?YXZWRktVUTlURDllL2FxQzgyUDcxRHV6Q3dXd255YmRpakQ2cEpWR05oN3dE?=
 =?utf-8?B?dVNCN2xJSTR1ZSt5ZzVFUmd5WjlGQ3FOS3NoV08vdkd2eHp1MTBFUnRqem84?=
 =?utf-8?Q?QfHhhE19GfAW6?=
x-microsoft-antispam-prvs: <MWHPR11MB18716271D23BEB8FD7255A6AE0480@MWHPR11MB1871.namprd11.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(66066001)(6436002)(8936002)(53546011)(6486002)(486006)(2616005)(11346002)(446003)(476003)(14454004)(86362001)(8676002)(54906003)(110136005)(316002)(2906002)(99286004)(68736007)(7736002)(305945005)(76176011)(386003)(52116002)(81166006)(6506007)(81156014)(102836004)(71190400001)(3846002)(5660300002)(6116002)(71200400001)(26005)(186003)(256004)(478600001)(105586002)(31696002)(106356001)(4326008)(72206003)(6246003)(229853002)(6512007)(14444005)(36756003)(97736004)(53936002)(31686004)(25786009)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1871;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UnZ/jrLZL+1VFSL8S+wC21hvRXDWKTfX0RpqAf4h4FieKbMk9N/HE3ZO+fCNeE54cWPbTc6i8QVuwaEOC/SYMZLnYVRW0YaLvJ6tNGQ8VX/UNJ7mN7VxVJrAB/pBJpIHCztpEkjf0CGs5ItaILeqwDVc/0VkypcWo4egYZjx/KcrDO86dw/MZYwxvS0zDwp/l0HJWpV36My5CZFBhpUH3xAFlt2NSn7ajfM/oNV04Seou7r4+Nf26QTTinRWDih6cdmdmB828MAVE28bJ8MlcuSTEMCl52TTF9I5maeDtQu9LbYdESwAf5rMuLL17IkaCGkx1JpZWQlQoWbNH8+bOQ4sBbBGWm+0WZypllN6a/f6ilGNzMDiHdfIKPT+2voDoe5FV6NLwta0n7kKSQ/LTTm0tYwBRuntZ680baJOkuk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17D5149D6D1C4D45A281AFFF5AA264CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fd9c73-9ad1-4681-dd5c-08d6a6074d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:52:41.6882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1871
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDMvMjAxOSBhdCAwODo1NywgRGF2aWQgRW5ncmFmIHdyb3RlOg0KPiBUaGUgZnVuY3Rp
b24gYXJndW1lbnQgZm9yIHRoZSBJU0NfRDAgb24gUEM5IHdhcyBpbmNvcnJlY3QuIEFjY29yZGlu
ZyB0bw0KPiB0aGUgZG9jdW1lbnRhdGlvbiBpdCBzaG91bGQgYmUgJ0MnIGFrYSAzLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRGF2aWQgRW5ncmFmIDxkYXZpZC5lbmdyYWZAc3lzZ28uY29tPg0KDQpS
ZXZpZXdlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0K
DQpGaXhlczogN2YxNmNiNjc2YzAwICgiQVJNOiBhdDkxL2R0OiBhZGQgc2FtYTVkMiBwaW5tdXgi
KQ0KQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY0LjQrDQoNCj4gLS0tDQo+ICAgYXJj
aC9hcm0vYm9vdC9kdHMvc2FtYTVkMi1waW5mdW5jLmggfCAyICstDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvc2FtYTVkMi1waW5mdW5jLmggYi9hcmNoL2FybS9ib290L2R0cy9zYW1h
NWQyLXBpbmZ1bmMuaA0KPiBpbmRleCAxYzAxYTZmODQzZDguLjI4YTJlNDU3NTJmZSAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi1waW5mdW5jLmgNCj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvc2FtYTVkMi1waW5mdW5jLmgNCj4gQEAgLTUxOCw3ICs1MTgsNyBAQA0K
PiAgICNkZWZpbmUgUElOX1BDOV9fR1BJTwkJCVBJTk1VWF9QSU4oUElOX1BDOSwgMCwgMCkNCj4g
ICAjZGVmaW5lIFBJTl9QQzlfX0ZJUQkJCVBJTk1VWF9QSU4oUElOX1BDOSwgMSwgMykNCj4gICAj
ZGVmaW5lIFBJTl9QQzlfX0dUU1VDT01QCQlQSU5NVVhfUElOKFBJTl9QQzksIDIsIDEpDQo+IC0j
ZGVmaW5lIFBJTl9QQzlfX0lTQ19EMAkJCVBJTk1VWF9QSU4oUElOX1BDOSwgMiwgMSkNCj4gKyNk
ZWZpbmUgUElOX1BDOV9fSVNDX0QwCQkJUElOTVVYX1BJTihQSU5fUEM5LCAzLCAxKQ0KPiAgICNk
ZWZpbmUgUElOX1BDOV9fVElPQTQJCQlQSU5NVVhfUElOKFBJTl9QQzksIDQsIDIpDQo+ICAgI2Rl
ZmluZSBQSU5fUEMxMAkJCTc0DQo+ICAgI2RlZmluZSBQSU5fUEMxMF9fR1BJTwkJCVBJTk1VWF9Q
SU4oUElOX1BDMTAsIDAsIDApDQo+IA0KDQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
