Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29474C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A9B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nUnfIugI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfCRORl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:17:41 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:21546 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfCRORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:17:40 -0400
IronPort-Data: A9a23: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
 mNpvdyAOVr2fPy0vF7yv6W08MDrps=
X-IronPort-AV: E=Sophos;i="5.58,494,1544511600"; 
   d="scan'208";a="28265787"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Mar 2019 07:17:36 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Mar 2019 07:17:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UikxpIJzidRRqLot5uOBBx6q6IvY6mPY1MocVQ87e8M=;
 b=nUnfIugIbMuEz4qWktJSb2DfjosapaBFBS6F4CPm6PXTrwLfJkQ72/axr0L+rJN49KzEbEIr4OJbMGJ36k8WVl0ufzQrpq3g6rV6gZSYwj1xN/tTX9ZgfuKNM5cLR/iV/Dx2NZnnFliFWm/PLn8VN/vNAn/NPPhWUpI5mVS3NHU=
Received: from SN6PR11MB3069.namprd11.prod.outlook.com (52.135.126.81) by
 SN6PR11MB3485.namprd11.prod.outlook.com (52.135.112.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 14:17:34 +0000
Received: from SN6PR11MB3069.namprd11.prod.outlook.com
 ([fe80::715e:962d:5745:da26]) by SN6PR11MB3069.namprd11.prod.outlook.com
 ([fe80::715e:962d:5745:da26%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 14:17:34 +0000
From:   <Razvan.Stefanescu@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>
CC:     <webergil@gmail.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tty/serial: atmel: Add is_half_duplex helper
Thread-Topic: [PATCH 1/2] tty/serial: atmel: Add is_half_duplex helper
Thread-Index: AQHU2xDI6gZWZP/qxEyCOBXVMaE7SaYRanmAgAAKBwA=
Date:   Mon, 18 Mar 2019 14:17:34 +0000
Message-ID: <13afa294-e279-9ba3-352d-184730f483d4@microchip.com>
References: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
 <20190315092334.13246-2-razvan.stefanescu@microchip.com>
 <c8ee3b11-e674-4992-c24f-b0434887a21e@sorico.fr>
In-Reply-To: <c8ee3b11-e674-4992-c24f-b0434887a21e@sorico.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::31) To SN6PR11MB3069.namprd11.prod.outlook.com
 (2603:10b6:805:d5::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190318161728800
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcde6f49-5349-455e-1072-08d6abac7734
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SN6PR11MB3485;
x-ms-traffictypediagnostic: SN6PR11MB3485:
x-microsoft-antispam-prvs: <SN6PR11MB34857DF5B76442264058701CE8470@SN6PR11MB3485.namprd11.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(386003)(6346003)(6506007)(53546011)(2906002)(6486002)(102836004)(305945005)(6116002)(4326008)(31686004)(5660300002)(229853002)(86362001)(31696002)(6246003)(25786009)(3846002)(106356001)(7736002)(105586002)(8936002)(11346002)(8676002)(71190400001)(476003)(2616005)(71200400001)(316002)(72206003)(478600001)(6512007)(186003)(97736004)(26005)(54906003)(110136005)(14454004)(446003)(66066001)(76176011)(36756003)(6436002)(256004)(81156014)(81166006)(486006)(99286004)(52116002)(53936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3485;H:SN6PR11MB3069.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Razvan.Stefanescu@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0jwrldQBb5RXZrnDfoivOPATdS3+rAIlRxmblQkQAJy02LvzgLGaRuu/s2JSQzqqsIX5ytmvKc4mdgxRZj1qqZ2xcgLq5iwIf4tIVqm1aQ5gr2h9Tv0qQAjPl4BKjG8OzygGTjjFivzLi+xID0n7HQKS5AxME60iz4ZgDb8dg7NgJZNJVT18jIEskj7dVQay88nPlEIRypCyGIZ2h0H/ix3GqDW+JOSQLmz6XBWtcgrQ09xoFQjRSe+3laypT8BSdGIzl0heThUxw7GDtbENGZ64BbMcmV915M6dEyzuKjcy6YXVLY3hOxyn7197Krdk99jWLTAedpaR8YzUjLfsrQReyRJIU1js/8h4OCU3I1vET7ZXd6ZukXBbt7x21Chfs/bjcPJWXXZ+u8//YRylGLhcazk4lq6vDckqMvO8YgM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5061AD63DD25484193C1D93989EE27E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fcde6f49-5349-455e-1072-08d6abac7734
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 14:17:34.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3485
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE4LzAzLzIwMTkgMTU6NDEsIFJpY2hhcmQgR2Vub3VkIHdyb3RlOg0KPiBbIGFkZGlu
ZyBHaWwgV2ViZXIgaW4gQ2M6IF0NCj4gDQo+IExlIDE1LzAzLzIwMTkgw6AgMTA6MjMsIFJhenZh
biBTdGVmYW5lc2N1IGEgw6ljcml0wqA6DQo+PiBVc2UgYSBoZWxwZXIgZnVuY3Rpb24gdG8gY2hl
Y2sgdGhhdCBhIHBvcnQgbmVlZHMgdG8gdXNlIGhhbGYgZHVwbGV4DQo+PiBjb21tdW5pY2F0aW9u
LCByZXBsYWNpbmcgc2V2ZXJhbCBvY2N1cnJlbmNlcyBvZiBtdWx0aS1saW5lIGJpdCBjaGVja2lu
Zy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSYXp2YW4gU3RlZmFuZXNjdSA8cmF6dmFuLnN0ZWZh
bmVzY3VAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRt
ZWxfc2VyaWFsLmMgfCAyNyArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+IGluZGV4IDA1MTQ3ZmUyNDM0My4uYTY1NzdiMWM0NDYx
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+PiAr
KysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+IEBAIC0yMzEsNiArMjMx
LDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhdG1lbF91YXJ0X3dyaXRlX2NoYXIoc3RydWN0IHVh
cnRfcG9ydCAqcG9ydCwgdTggdmFsdWUpDQo+PiAgIAlfX3Jhd193cml0ZWIodmFsdWUsIHBvcnQt
Pm1lbWJhc2UgKyBBVE1FTF9VU19USFIpOw0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyBpbmxp
bmUgaW50IGF0bWVsX3VhcnRfaXNfaGFsZl9kdXBsZXgoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkN
Cj4+ICt7DQo+PiArCXJldHVybiAoKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJM
RUQpICYmDQo+PiArCQkhKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19U
WCkpIHx8DQo+PiArCQkocG9ydC0+aXNvNzgxNi5mbGFncyAmIFNFUl9JU083ODE2X0VOQUJMRUQp
Ow0KPj4gK30NCj4+ICsNCj4+ICAgI2lmZGVmIENPTkZJR19TRVJJQUxfQVRNRUxfUERDDQo+PiAg
IHN0YXRpYyBib29sIGF0bWVsX3VzZV9wZGNfcngoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4+
ICAgew0KPj4gQEAgLTYwOCwxMCArNjE1LDEwIEBAIHN0YXRpYyB2b2lkIGF0bWVsX3N0b3BfdHgo
c3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4+ICAgCS8qIERpc2FibGUgaW50ZXJydXB0cyAqLw0K
Pj4gICAJYXRtZWxfdWFydF93cml0ZWwocG9ydCwgQVRNRUxfVVNfSURSLCBhdG1lbF9wb3J0LT50
eF9kb25lX21hc2spOw0KPj4gICANCj4+IC0JaWYgKCgocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJf
UlM0ODVfRU5BQkxFRCkgJiYNCj4+IC0JICAgICAhKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JT
NDg1X1JYX0RVUklOR19UWCkpIHx8DQo+PiAtCSAgICBwb3J0LT5pc283ODE2LmZsYWdzICYgU0VS
X0lTTzc4MTZfRU5BQkxFRCkNCj4+IC0JCWF0bWVsX3N0YXJ0X3J4KHBvcnQpOw0KPj4gKwlpZiAo
YXRtZWxfdWFydF9pc19oYWxmX2R1cGxleChwb3J0KSkNCj4+ICsJCWlmICghYXRvbWljX3JlYWQo
JmF0bWVsX3BvcnQtPnRhc2tsZXRfc2h1dGRvd24pKQ0KPiBUaGlzIGNoZWNrIHdhc24ndCB0aGVy
ZSBiZWZvcmUuDQo+IElmIGl0J3MgcmVhbGx5IG5lZWRlZCwgcGxlYXNlIGluc2VydCBpdCBpbiBh
bm90aGVyIHBhdGNoIGFuZCBleHBsYWluIHdoeQ0KPiBpdCdzIG5lZWRlZC4NCj4gDQpUaGFuayB5
b3UgZm9yIHRoZSBmZWVkYmFjay4gSXQgaXMgbm90IG5lZWRlZCwgd2lsbCBiZSByZW1vdmVkIGlu
IHYyLg0KDQpCZXN0IHJlZ2FyZHMsDQpSYXp2YW4NCg0KPj4gKwkJCWF0bWVsX3N0YXJ0X3J4KHBv
cnQpOw0KPj4gKw0KPj4gICB9DQo+PiAgIA0KPj4gICAvKg0KPj4gQEAgLTYyOCw5ICs2MzUsNyBA
QCBzdGF0aWMgdm9pZCBhdG1lbF9zdGFydF90eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPj4g
ICAJCXJldHVybjsNCj4+ICAgDQo+PiAgIAlpZiAoYXRtZWxfdXNlX3BkY190eChwb3J0KSB8fCBh
dG1lbF91c2VfZG1hX3R4KHBvcnQpKQ0KPj4gLQkJaWYgKCgocG9ydC0+cnM0ODUuZmxhZ3MgJiBT
RVJfUlM0ODVfRU5BQkxFRCkgJiYNCj4+IC0JCSAgICAgIShwb3J0LT5yczQ4NS5mbGFncyAmIFNF
Ul9SUzQ4NV9SWF9EVVJJTkdfVFgpKSB8fA0KPj4gLQkJICAgIHBvcnQtPmlzbzc4MTYuZmxhZ3Mg
JiBTRVJfSVNPNzgxNl9FTkFCTEVEKQ0KPj4gKwkJaWYgKGF0bWVsX3VhcnRfaXNfaGFsZl9kdXBs
ZXgocG9ydCkpDQo+PiAgIAkJCWF0bWVsX3N0b3BfcngocG9ydCk7DQo+PiAgIA0KPj4gICAJaWYg
KGF0bWVsX3VzZV9wZGNfdHgocG9ydCkpDQo+PiBAQCAtOTI4LDkgKzkzMyw3IEBAIHN0YXRpYyB2
b2lkIGF0bWVsX2NvbXBsZXRlX3R4X2RtYSh2b2lkICphcmcpDQo+PiAgIAkgKi8NCj4+ICAgCWlm
ICghdWFydF9jaXJjX2VtcHR5KHhtaXQpKQ0KPj4gICAJCWF0bWVsX3Rhc2tsZXRfc2NoZWR1bGUo
YXRtZWxfcG9ydCwgJmF0bWVsX3BvcnQtPnRhc2tsZXRfdHgpOw0KPj4gLQllbHNlIGlmICgoKHBv
cnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpICYmDQo+PiAtCQkgICEocG9ydC0+
cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSkgfHwNCj4+IC0JCSBwb3J0LT5p
c283ODE2LmZsYWdzICYgU0VSX0lTTzc4MTZfRU5BQkxFRCkgew0KPj4gKwllbHNlIGlmIChhdG1l
bF91YXJ0X2lzX2hhbGZfZHVwbGV4KHBvcnQpKSB7DQo+PiAgIAkJLyogRE1BIGRvbmUsIHN0b3Ag
VFgsIHN0YXJ0IFJYIGZvciBSUzQ4NSAqLw0KPj4gICAJCWF0bWVsX3N0YXJ0X3J4KHBvcnQpOw0K
Pj4gICAJfQ0KPj4gQEAgLTE1MDgsOSArMTUxMSw3IEBAIHN0YXRpYyB2b2lkIGF0bWVsX3R4X3Bk
YyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPj4gICAJCWF0bWVsX3VhcnRfd3JpdGVsKHBvcnQs
IEFUTUVMX1VTX0lFUiwNCj4+ICAgCQkJCSAgYXRtZWxfcG9ydC0+dHhfZG9uZV9tYXNrKTsNCj4+
ICAgCX0gZWxzZSB7DQo+PiAtCQlpZiAoKChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9F
TkFCTEVEKSAmJg0KPj4gLQkJICAgICAhKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X1JY
X0RVUklOR19UWCkpIHx8DQo+PiAtCQkgICAgcG9ydC0+aXNvNzgxNi5mbGFncyAmIFNFUl9JU083
ODE2X0VOQUJMRUQpIHsNCj4+ICsJCWlmIChhdG1lbF91YXJ0X2lzX2hhbGZfZHVwbGV4KHBvcnQp
KSB7DQo+PiAgIAkJCS8qIERNQSBkb25lLCBzdG9wIFRYLCBzdGFydCBSWCBmb3IgUlM0ODUgKi8N
Cj4+ICAgCQkJYXRtZWxfc3RhcnRfcngocG9ydCk7DQo+PiAgIAkJfQ0KPj4NCj4gDQo=
