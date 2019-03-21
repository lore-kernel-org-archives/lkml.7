Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593AEC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B8218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="h/Ku/e6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCUKMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:12:03 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:40560 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfCUKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:11:54 -0400
X-IronPort-AV: E=Sophos;i="5.60,252,1549954800"; 
   d="scan'208";a="28272554"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Mar 2019 03:11:53 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 21 Mar 2019 03:11:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf3zO81k1Z5o96wD3+ApiA8yCiNrPQQJ6DTam3S6R4w=;
 b=h/Ku/e6Cb2i8RDzA+e75q1UCCoRSqgyQe/BS03amVM/NRaL/YGc3TLm4At+dB19aZCXFhc8O5ZkyJLSNK+Pqe8PHhVw8SLcPaHriN6bV0Zofkurx/Nu67Lsq6RRA2/ajgKaed4GWl8YWUJMlJmFpwcOHwSx+S93ZFGY5HDhHTvU=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB0078.namprd11.prod.outlook.com (10.164.204.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 10:11:51 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5413:49b5:8548:fe44]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5413:49b5:8548:fe44%8]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 10:11:51 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] rtc: at91sam9: drop platform_data support
Thread-Topic: [PATCH 1/6] rtc: at91sam9: drop platform_data support
Thread-Index: AQHU386A9U9S84wfVUmNpMfejRLPmg==
Date:   Thu, 21 Mar 2019 10:11:51 +0000
Message-ID: <d244f811-8133-efac-4601-24b286ca98d8@microchip.com>
References: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0206.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::26) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 519251a9-29da-464f-1683-08d6ade5a2cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB0078;
x-ms-traffictypediagnostic: MWHPR11MB0078:
x-microsoft-antispam-prvs: <MWHPR11MB0078E55FA860E461A6829BBFE0420@MWHPR11MB0078.namprd11.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(8936002)(8676002)(6436002)(110136005)(105586002)(3846002)(25786009)(36756003)(81166006)(6486002)(97736004)(4326008)(102836004)(6246003)(31686004)(6506007)(66066001)(2501003)(386003)(7736002)(229853002)(71190400001)(81156014)(26005)(99286004)(305945005)(6116002)(31696002)(86362001)(72206003)(446003)(2616005)(2906002)(476003)(486006)(5660300002)(52116002)(76176011)(71200400001)(316002)(11346002)(14454004)(53546011)(68736007)(478600001)(14444005)(256004)(106356001)(6512007)(54906003)(186003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0078;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r5OfekEq8UtoLH2XQTX1HjZiRXOi1fyoCIJXz3A+I0XDQaLfKerzAEXAaiEJQwLcyyC23CM5d/iZ+gvbThqCXggbrwVbDtvZq7GjDs0NpG5DPSav2uMe1mgTgCMe9SWNCYA3aTynWCnNTJeUj0nT9qa59hmBDbBJp9ZubzuOgbJ40WfbTHxPOZHdb2rOfo+Hs6GFtS2oYYnKGuyW/k1O2IJjp5M5m+MT9HzFBuZAk0i1gtvV5D+PGBNSfjxIId4VgAeqgjdAQuzPEtPbdVuT8OHY514//4FZ6IDmmyctUrXLinngNtjQI8lN4FvPJKZfBEOwkfCZwWbxAZ3pH2ErAYJHNhde0wrQ/JUCICMX+Gb29AriDPwZcuUmp8+RcYbTF/S0VreV0PbLPlX9ewrq1HaW2HqH3lA0NgFCmO1dUuU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32C169E69F25DF4BB7F2F34C33097D78@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 519251a9-29da-464f-1683-08d6ade5a2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 10:11:51.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0078
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDMvMjAxOSBhdCAxMzo0MCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQoNCj4gQVJD
SF9BVDkxIGlzIERUIG9ubHkgZm9yIGEgd2hpbGUsIGRyb3AgcGxhdGZvcm0gZGF0YSBzdXBwb3J0
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxs
b25pQGJvb3RsaW4uY29tPg0KDQpGb3IgdGhlIHdob2xlIHNlcmllczoNCkFja2VkLWJ5OiBOaWNv
bGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gICBk
cml2ZXJzL3J0Yy9LY29uZmlnICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9ydGMvcnRjLWF0
OTFzYW05LmMgfCA0NCArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
IDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9LY29uZmlnIGIvZHJpdmVycy9ydGMvS2NvbmZpZw0K
PiBpbmRleCA3NTU1ZmQzNDRmZjAuLmZhNTYzODI2OWIzMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ydGMvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL3J0Yy9LY29uZmlnDQo+IEBAIC0xNDMyLDcg
KzE0MzIsNyBAQCBjb25maWcgUlRDX0RSVl9BVDkxUk05MjAwDQo+ICAgY29uZmlnIFJUQ19EUlZf
QVQ5MVNBTTkNCj4gICAJdHJpc3RhdGUgIkFUOTFTQU05IFJUVCBhcyBSVEMiDQo+ICAgCWRlcGVu
ZHMgb24gQVJDSF9BVDkxIHx8IENPTVBJTEVfVEVTVA0KPiAtCWRlcGVuZHMgb24gSEFTX0lPTUVN
DQo+ICsJZGVwZW5kcyBvbiBPRiAmJiBIQVNfSU9NRU0NCj4gICAJc2VsZWN0IE1GRF9TWVNDT04N
Cj4gICAJaGVscA0KPiAgIAkgIFNvbWUgQVQ5MVNBTTkgU29DcyBwcm92aWRlIGFuIFJUVCAoUmVh
bCBUaW1lIFRpbWVyKSBibG9jayB3aGljaA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRj
LWF0OTFzYW05LmMgYi9kcml2ZXJzL3J0Yy9ydGMtYXQ5MXNhbTkuYw0KPiBpbmRleCAxZDMxYzBh
ZTYzMzQuLjdlYzExNGI1OTUxMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ydGMvcnRjLWF0OTFz
YW05LmMNCj4gKysrIGIvZHJpdmVycy9ydGMvcnRjLWF0OTFzYW05LmMNCj4gQEAgLTM0MCwxMyAr
MzQwLDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBydGNfY2xhc3Nfb3BzIGF0OTFfcnRjX29wcyA9
IHsNCj4gICAJLmFsYXJtX2lycV9lbmFibGUgPSBhdDkxX3J0Y19hbGFybV9pcnFfZW5hYmxlLA0K
PiAgIH07DQo+ICAgDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9jb25maWcgZ3Bicl9y
ZWdtYXBfY29uZmlnID0gew0KPiAtCS5uYW1lID0gImdwYnIiLA0KPiAtCS5yZWdfYml0cyA9IDMy
LA0KPiAtCS52YWxfYml0cyA9IDMyLA0KPiAtCS5yZWdfc3RyaWRlID0gNCwNCj4gLX07DQo+IC0N
Cj4gICAvKg0KPiAgICAqIEluaXRpYWxpemUgYW5kIGluc3RhbGwgUlRDIGRyaXZlcg0KPiAgICAq
Lw0KPiBAQCAtMzU3LDYgKzM1MCw3IEBAIHN0YXRpYyBpbnQgYXQ5MV9ydGNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJaW50CQlyZXQsIGlycTsNCj4gICAJdTMyCQlt
cjsNCj4gICAJdW5zaWduZWQgaW50CXNjbGtfcmF0ZTsNCj4gKwlzdHJ1Y3Qgb2ZfcGhhbmRsZV9h
cmdzIGFyZ3M7DQo+ICAgDQo+ICAgCWlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+
ICAgCWlmIChpcnEgPCAwKSB7DQo+IEBAIC0zODIsMzQgKzM3NiwxNCBAQCBzdGF0aWMgaW50IGF0
OTFfcnRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgCWlmIChJU19F
UlIocnRjLT5ydHQpKQ0KPiAgIAkJcmV0dXJuIFBUUl9FUlIocnRjLT5ydHQpOw0KPiAgIA0KPiAt
CWlmICghcGRldi0+ZGV2Lm9mX25vZGUpIHsNCj4gLQkJLyoNCj4gLQkJICogVE9ETzogUmVtb3Zl
IHRoaXMgY29kZSBjaHVuayB3aGVuIHJlbW92aW5nIG5vbiBEVCBib2FyZA0KPiAtCQkgKiBzdXBw
b3J0LiBSZW1lbWJlciB0byByZW1vdmUgdGhlIGdwYnJfcmVnbWFwX2NvbmZpZw0KPiAtCQkgKiB2
YXJpYWJsZSB0b28uDQo+IC0JCSAqLw0KPiAtCQl2b2lkIF9faW9tZW0gKmdwYnI7DQo+IC0NCj4g
LQkJciA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMSk7DQo+
IC0JCWdwYnIgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcik7DQo+IC0JCWlm
IChJU19FUlIoZ3BicikpDQo+IC0JCQlyZXR1cm4gUFRSX0VSUihncGJyKTsNCj4gLQ0KPiAtCQly
dGMtPmdwYnIgPSByZWdtYXBfaW5pdF9tbWlvKE5VTEwsIGdwYnIsDQo+IC0JCQkJCSAgICAgJmdw
YnJfcmVnbWFwX2NvbmZpZyk7DQo+IC0JfSBlbHNlIHsNCj4gLQkJc3RydWN0IG9mX3BoYW5kbGVf
YXJncyBhcmdzOw0KPiAtDQo+IC0JCXJldCA9IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9maXhlZF9h
cmdzKHBkZXYtPmRldi5vZl9ub2RlLA0KPiAtCQkJCQkJImF0bWVsLHJ0dC1ydGMtdGltZS1yZWci
LCAxLCAwLA0KPiAtCQkJCQkJJmFyZ3MpOw0KPiAtCQlpZiAocmV0KQ0KPiAtCQkJcmV0dXJuIHJl
dDsNCj4gLQ0KPiAtCQlydGMtPmdwYnIgPSBzeXNjb25fbm9kZV90b19yZWdtYXAoYXJncy5ucCk7
DQo+IC0JCXJ0Yy0+Z3Bicl9vZmZzZXQgPSBhcmdzLmFyZ3NbMF07DQo+IC0JfQ0KPiArCXJldCA9
IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9maXhlZF9hcmdzKHBkZXYtPmRldi5vZl9ub2RlLA0KPiAr
CQkJCQkiYXRtZWwscnR0LXJ0Yy10aW1lLXJlZyIsIDEsIDAsDQo+ICsJCQkJCSZhcmdzKTsNCj4g
KwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgIA0KPiArCXJ0Yy0+Z3BiciA9IHN5c2Nv
bl9ub2RlX3RvX3JlZ21hcChhcmdzLm5wKTsNCj4gKwlydGMtPmdwYnJfb2Zmc2V0ID0gYXJncy5h
cmdzWzBdOw0KPiAgIAlpZiAoSVNfRVJSKHJ0Yy0+Z3BicikpIHsNCj4gICAJCWRldl9lcnIoJnBk
ZXYtPmRldiwgImZhaWxlZCB0byByZXRyaWV2ZSBncGJyIHJlZ21hcCwgYWJvcnRpbmcuXG4iKTsN
Cj4gICAJCXJldHVybiAtRU5PTUVNOw0KPiBAQCAtNTYxLDEzICs1MzUsMTEgQEAgc3RhdGljIGlu
dCBhdDkxX3J0Y19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIA0KPiAgIHN0YXRpYyBT
SU1QTEVfREVWX1BNX09QUyhhdDkxX3J0Y19wbV9vcHMsIGF0OTFfcnRjX3N1c3BlbmQsIGF0OTFf
cnRjX3Jlc3VtZSk7DQo+ICAgDQo+IC0jaWZkZWYgQ09ORklHX09GDQo+ICAgc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXQ5MV9ydGNfZHRfaWRzW10gPSB7DQo+ICAgCXsgLmNvbXBh
dGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtcnR0IiB9LA0KPiAgIAl7IC8qIHNlbnRpbmVsICov
IH0NCj4gICB9Ow0KPiAgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGF0OTFfcnRjX2R0X2lkcyk7
DQo+IC0jZW5kaWYNCj4gICANCj4gICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBhdDkx
X3J0Y19kcml2ZXIgPSB7DQo+ICAgCS5wcm9iZQkJPSBhdDkxX3J0Y19wcm9iZSwNCj4gDQoNCg0K
LS0gDQpOaWNvbGFzIEZlcnJlDQo=
