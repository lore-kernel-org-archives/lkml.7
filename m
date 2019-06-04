Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B1C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197D823CEB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W5977cxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfFDQrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:47:09 -0400
Received: from mail-eopbgr750048.outbound.protection.outlook.com ([40.107.75.48]:64900
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfFDQrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK3mpPUYXtVpu4apHXC2ek85k5gR0Lw6yCXcJTSUVYk=;
 b=W5977cxykXK4eK5kpTRiyHxXysvKXp7Fhb4H3jdZSbSqlVC66fR13ODom8E5Jr5A+tgs5p/RCvpo1fATQdD41hpwJO8oFTGZ7P7AqArQUo5AG7yIm8saAU6zY6gE9HbYO7YGvQcn97jMHpt7NywiVqqS6tA6uqgSsaK0MKt9Irs=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1164.namprd12.prod.outlook.com (10.168.238.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 16:47:05 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::34ed:dc98:e87d:50c4]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::34ed:dc98:e87d:50c4%7]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 16:47:05 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Vinod Koul <vkoul@kernel.org>, "Hook, Gary" <Gary.Hook@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: dmatest: timeout value of -1 should specify
 infinite wait
Thread-Topic: [PATCH] dmaengine: dmatest: timeout value of -1 should specify
 infinite wait
Thread-Index: AQHVF+ku9NvxfnAiEUWf7KotYW4OlKaLcO8AgABJgYA=
Date:   Tue, 4 Jun 2019 16:47:05 +0000
Message-ID: <010db7bb-dee2-4ba8-a085-4154735b98db@amd.com>
References: <155933183362.4916.15727271006977576552.stgit@sosrh3.amd.com>
 <20190604122356.GY15118@vkoul-mobl>
In-Reply-To: <20190604122356.GY15118@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [47.220.187.91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b100444b-8b67-493b-de9b-08d6e90c4668
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1164;
x-ms-traffictypediagnostic: DM5PR12MB1164:
x-microsoft-antispam-prvs: <DM5PR12MB11641AFA1FBE3C2632BB6FC4FD150@DM5PR12MB1164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(3846002)(6116002)(99286004)(316002)(26005)(71190400001)(256004)(14444005)(186003)(6486002)(71200400001)(476003)(76176011)(81166006)(81156014)(2616005)(52116002)(7736002)(305945005)(6636002)(110136005)(8936002)(6512007)(31696002)(8676002)(229853002)(6246003)(102836004)(6436002)(486006)(25786009)(6506007)(14454004)(72206003)(73956011)(11346002)(446003)(64756008)(31686004)(66446008)(66556008)(66066001)(36756003)(66946007)(66476007)(4326008)(68736007)(53546011)(5660300002)(478600001)(2906002)(386003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1164;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sy8kk6Y/GSjWXmOPOX86gJ0PQVbzFy0MkpNPF/C5sZ+HgrnUHAAiv+gp6LXxFpqJXZK3zLPQd72S8A2O2mJlbBmEHRsun+4fjYoR8yknA4pOFTS9mtUdKUAqu55oBj9vdUmCrI6329xGqxBBPMkPNCX+moIoVYrd82ceZ8HwYlxpR2uKGC2ycZgos37W+sRLlIMjbTuK7Knx31ftGyUDUmxqPZO4xpjkg5jIsr9FJSrLzPNEHN2Z2nFrQFCOaMU6OZcj/uSbU0KwgsqVAsd4ut5qqNduMBZrKz47P4rJOm0v7ux7Q7AAdFmE6I42ej0FgsCI8SyuyLDY8pni3nc0dLXQSKqp4Snp1+FfcS2WyZBU7t3910tItq3XcVNjqUoRZ6ZBQigE8QOOQ51fiNOt9q8m1/ZpPqknQnrQnZ90kPo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA0B927900943241BBB241559D21321E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b100444b-8b67-493b-de9b-08d6e90c4668
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 16:47:05.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghook@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi80LzE5IDc6MjMgQU0sIFZpbm9kIEtvdWwgd3JvdGU6DQo+IFtDQVVUSU9OOiBFeHRlcm5h
bCBFbWFpbF0NCj4gDQo+IE9uIDMxLTA1LTE5LCAxOTo0MywgSG9vaywgR2FyeSB3cm90ZToNCj4+
IFRoZSBkbWF0ZXN0IG1vZHVsZSBwYXJhbWV0ZXIgJ3RpbWVvdXQnIGlzIGRvY3VtZW50ZWQgYXMg
YWNjZXB0aW5nIGENCj4+IC0xIHRvIG1lYW4gImluZmluaXRlIHRpbWVvdXQiLiBDaGFuZ2UgdGhl
IHBhcmFtZXRlciB0byB0byBzaWduZWQNCj4+IGludGVnZXIsIGFuZCBjaGVjayB0aGUgdmFsdWUg
dG8gY2FsbCB0aGUgYXBwcm9wcmlhdGUgd2FpdF9ldmVudCgpDQo+PiBmdW5jdGlvbi4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBHYXJ5IFIgSG9vayA8Z2FyeS5ob29rQGFtZC5jb20+DQo+PiAtLS0N
Cj4+ICAgZHJpdmVycy9kbWEvZG1hdGVzdC5jIHwgICAxMSArKysrKysrKy0tLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2RtYS9kbWF0ZXN0LmMgYi9kcml2ZXJzL2RtYS9kbWF0ZXN0LmMNCj4+
IGluZGV4IGI5NjgxNGE3ZGNlYi4uMjhhMjM3Njg2NTc4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9kbWEvZG1hdGVzdC5jDQo+PiArKysgYi9kcml2ZXJzL2RtYS9kbWF0ZXN0LmMNCj4+IEBAIC02
Myw3ICs2Myw3IEBAIE1PRFVMRV9QQVJNX0RFU0MocHFfc291cmNlcywNCj4+ICAgICAgICAgICAg
ICAgICJOdW1iZXIgb2YgcCtxIHNvdXJjZSBidWZmZXJzIChkZWZhdWx0OiAzKSIpOw0KPj4NCj4+
ICAgc3RhdGljIGludCB0aW1lb3V0ID0gMzAwMDsNCj4+IC1tb2R1bGVfcGFyYW0odGltZW91dCwg
dWludCwgU19JUlVHTyB8IFNfSVdVU1IpOw0KPj4gK21vZHVsZV9wYXJhbSh0aW1lb3V0LCBpbnQs
IFNfSVJVR08gfCBTX0lXVVNSKTsNCj4+ICAgTU9EVUxFX1BBUk1fREVTQyh0aW1lb3V0LCAiVHJh
bnNmZXIgVGltZW91dCBpbiBtc2VjIChkZWZhdWx0OiAzMDAwKSwgIg0KPj4gICAgICAgICAgICAg
ICAgICJQYXNzIC0xIGZvciBpbmZpbml0ZSB0aW1lb3V0Iik7DQo+Pg0KPj4gQEAgLTc5NSw4ICs3
OTUsMTMgQEAgc3RhdGljIGludCBkbWF0ZXN0X2Z1bmModm9pZCAqZGF0YSkNCj4+ICAgICAgICAg
ICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgIGRtYV9hc3luY19pc3N1ZV9wZW5kaW5nKGNoYW4p
Ow0KPj4NCj4+IC0gICAgICAgICAgICAgd2FpdF9ldmVudF9mcmVlemFibGVfdGltZW91dCh0aHJl
YWQtPmRvbmVfd2FpdCwgZG9uZS0+ZG9uZSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKHBhcmFtcy0+dGltZW91dCkpOw0KPj4g
KyAgICAgICAgICAgICAvKiBBIHRpbWVvdXQgdmFsdWUgb2YgLTEgbWVhbnMgaW5maW5pdGUgd2Fp
dCAqLw0KPj4gKyAgICAgICAgICAgICBpZiAodGltZW91dCA9PSAtMSkNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICB3YWl0X2V2ZW50X2ZyZWV6YWJsZSh0aHJlYWQtPmRvbmVfd2FpdCwgZG9uZS0+
ZG9uZSk7DQo+IA0KPiB3ZWxsIGkgYW0gbm90IHRvbyBoYXBweSB0aGF0IHdlIGhhdmUgYSBpbmZp
bml0ZSB3YWl0IGFuZCBubyB3YXkgdG8NCj4gY2FuY2VsLCBtYXliZSByZW1vdmUgdGhpcyBjYXNl
Pw0KDQpXZWxsLCBJIHdhcyB1bmNvbWZvcnRhYmxlIHdpdGggZG9jdW1lbnRhdGlvbiB0aGF0IGRp
ZG4ndCBtYXRjaCBiZWhhdmlvci4NCg0KSSBzZWUgdHdvIGNob2ljZXMgKGFuZCBJIGp1c3QgY2hv
c2Ugb25lIHRvIHN0YXJ0IGEgY29udmVyc2F0aW9uKToNCg0KMSkgQWNjZXB0IHRoaXMgcGF0Y2gs
IHdpdGggYW4gaW5maW5pdGUgdGltZW91dCwgb3INCjIpIExlYXZlIHRoZSBkYXRhIHR5cGUgYWxv
bmUsIGJ1dCBjaGFuZ2UgdGhlIGRlc2NyaXB0aW9uIHRvIHN0YXRlIHRoYXQgDQp0aW1lb3V0IHZh
bHVlcyB1cCB0byBoZXggMHhGRkZGRkZGRiAvIGRlY2ltYWwgNDI5NDk2NzI5NSBjYW4gYmUgdXNl
ZCwgDQplbXVsYXRpbmcgYW4gImluZmluaXRlIiB3YWl0LiBBIHZlcnkgbG9uZyB3YWl0IHRoYXQg
ZXZlbnR1YWxseSBwb3BzIGEgDQp0aW1lciBpcyBwcm9iYWJseSBwcmVmZXJhYmxlLiBJIGRvbid0
IHRoaW5rIHRoZXJlIGFyZSBhbnkgY29udmVyc2lvbiANCmlzc3VlcyBzaW5jZSB0aGUgamlmZnkg
cGFyYW1ldGVyIHRvIHdhaXRfZXZlbnRfZnJlZXphYmxlX3RpbWVvdXQoKSBpcyANCmNvbnZlcnRl
ZCB0byBhIGxvbmcuIEkgY291bGQgYmUgd3JvbmcgYWJvdXQgdGhhdC4NCg0KSSdtIGhhcHB5IHRv
IGdvIHdpdGggb3B0aW9uICgyKS4gUGxlYXNlIHN1Z2dlc3QgYSBjb3Vyc2Ugb2YgYWN0aW9uLg0K
DQpncmgNCg0KPiANCj4+ICsgICAgICAgICAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIHdhaXRfZXZlbnRfZnJlZXphYmxlX3RpbWVvdXQodGhyZWFkLT5kb25lX3dhaXQsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRvbmUtPmRvbmUsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMocGFyYW1z
LT50aW1lb3V0KSk7DQo+Pg0KPj4gICAgICAgICAgICAgICAgc3RhdHVzID0gZG1hX2FzeW5jX2lz
X3R4X2NvbXBsZXRlKGNoYW4sIGNvb2tpZSwgTlVMTCwgTlVMTCk7DQo=
