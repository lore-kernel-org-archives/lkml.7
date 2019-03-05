Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2479CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F742082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KkdNv/p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCEJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:42:38 -0500
Received: from mail-eopbgr730079.outbound.protection.outlook.com ([40.107.73.79]:10608
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbfCEJmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeMcI756p8LNd26jY03XoM4eMXpBZwmn8kofGITsAIY=;
 b=KkdNv/p0R6sCSBm+P6px3nxC0yrMVRhbYMZg0rK4YT5mjF4dwlyJwNWtfgW6zS3jBsGTCdEZFy21ZJ/srr/i6KtEkSaMMNZrqiganUSdP+GhfXNBbRoIsG2qvUeuIjZnTayge3sBUMS+6VEix3Nt9fLEwp6PlYj2EnRhpFkdxjE=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB5350.namprd02.prod.outlook.com (20.177.124.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 09:42:27 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::b572:d2a1:b4dd:9162]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::b572:d2a1:b4dd:9162%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 09:42:27 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Alan Tull <atull@kernel.org>,
        Moritz Fischer <moritz.fischer@ettus.com>
Subject: RE: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Thread-Topic: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Thread-Index: AQHUsOdKmglIsGXrYUShdUJ415kWF6W53/kAgAEjAjCAMXYnAIAPHL/wgABnVgCAAQKe0A==
Date:   Tue, 5 Mar 2019 09:42:27 +0000
Message-ID: <BYAPR02MB471068180BA4592779B0C2CEC2720@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-7-nava.manne@xilinx.com> <20190121154928.GA32129@bogus>
 <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
 <BYAPR02MB4710216D63D98A56ABD99E67C2710@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CAL_JsqLn8LrO_qHkXK0hgwjvsedMCAEL0MTYXBLrke2cgri3+g@mail.gmail.com>
In-Reply-To: <CAL_JsqLn8LrO_qHkXK0hgwjvsedMCAEL0MTYXBLrke2cgri3+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cb66178-da6d-432d-90aa-08d6a14ee0fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5350;
x-ms-traffictypediagnostic: BYAPR02MB5350:
x-ms-exchange-purlcount: 1
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI1MzUwOzIzOkt5VUtNemt5cSs3RGhoc0Y3OEJFUGVzWlBH?=
 =?utf-8?B?WHdnMXNBc0YvQSsvUHc5T2RVYUZ2QWRBYS8vd1VGMmJYaTdQUnhzS2xmVWZu?=
 =?utf-8?B?c1RubU1yTHp3N3FZamZjZVNmNk5LVDhjdE1BNFFGRjN1OTBWa2JBNlpaa1Jo?=
 =?utf-8?B?aUdkNGVhM2dTZVE4MTE2QUQrYjJzSXdaNXFHdWlkTlM5QmpxVmJzc2xrVnBK?=
 =?utf-8?B?aXMwTFVpaDU4Z2trYmQ3aUJqUEd0NkhqTjVWOGJMQTlmZXcwY0hTbVN3T3px?=
 =?utf-8?B?c2pFbEVaTnZzbzZ5Z2tsRWdsV3VLT3ZKZzNYYlpKaWtLVWIxTUdrMDI5OVVX?=
 =?utf-8?B?QkxGQ3hpbm1GM0tGRnJNOFdybEJweFUrVTlSeUNsbGREdDNCTjRWVitoLzhM?=
 =?utf-8?B?U0JlZ3prRTdqR0NTTlROZ2JXTEVpYXRKMFM2bHE1WUozcTFvaG5UTjN2eUUy?=
 =?utf-8?B?RnV4c2tiV0JieEw5dnFkTzlkMUZTeExSSklzdGlYU0JQQlU2MHdGMEpUOTM0?=
 =?utf-8?B?dkVxUitBQ1R4eFIydnJLdTdReUZnamFlbi9yTURtWG5kRXk5ZzBHNTVzcjMz?=
 =?utf-8?B?MWN3a1Y2Ri93S1p1OUxPaW1VKzE4U3ZnVC9pQjJBVWRaSGw4ckppczM1cWVO?=
 =?utf-8?B?bExSTS9yZDZEYURSVjRHRkJrbDRPRWpyRlk2Q1YyZW9MWXBwR21vY1hFQnhY?=
 =?utf-8?B?ZTFRai9wYk84NW1aN0RHRGdOYU5kajdETjVQczhzcWZRNjRkamt3Y0xNQ2Ja?=
 =?utf-8?B?bFVrcUlDZVYzWFVWVzN6U3ZETUIxenlDWTQyenp6UzlIR1ZhaU0zTXpiZndL?=
 =?utf-8?B?bVgvKzM0SWZzM21oVjRWc2dJTFMwTnNzYXQ3TW05eUlHaTI4eXM2NW9WMHEv?=
 =?utf-8?B?MmR5M3lURHpNaWNuYTd0V1ZlRXNNams5QWZKVW9YcWhWU0oydGRiSTlmbVJ0?=
 =?utf-8?B?OUhLSDVoY2VuNFAreCtmN3plaUVwU01sQmltOVZ3aHNXR1JFbGxrOEIvY0I1?=
 =?utf-8?B?MmpaUjdmOCt6MU9rcFFvenI4YktzanZyQkhIK29VZG1kb0xnQk54S3BNbmNF?=
 =?utf-8?B?cEJTMlFrbWlNQ0w3TGZOQVVUNnFxdCt4RXIxN0w2RTNxOE9uaDRpRGh5M0N4?=
 =?utf-8?B?ZnEwMWoxWEJmL1ZBalFIL0F6b2thVC9rUnJZYVVDWTJBb2c2a1RwenEyRHRH?=
 =?utf-8?B?czM1UzBKdXhLYWp3eitSQmpHQ3o4UENUSUdSbTdXbXVNWU81WCtINnBxUzZI?=
 =?utf-8?B?NGpPQi9rRXllaStFRXJCd3Q0N3pYb1R1aHoxTnZYbjBPQVFleUlsYnNUc2dq?=
 =?utf-8?B?UXlMdjhhNnN3bDJjcWViTXhpVlN2Q21DTXlDeExOSGZ5WUE1eG1QUEJnMUNy?=
 =?utf-8?B?aUZvTzgyRW1lZjVBTGhIRnBLUFhLUHR1RDZIc0ZIMWFrNkpBeUhuaEZWbEVB?=
 =?utf-8?B?QnJHOHQ0clBhU2xUNWlPTGJQU0tBNXVQYXN4VVprNXFpYU5rK1Zab0d1WUFB?=
 =?utf-8?B?a2MrdzVKWVhkMGFSTSt5M3YxdFVpUnJZVUF3ZWlGcUdrUCsvejBxK3g3SzFR?=
 =?utf-8?B?UEk3QmlZdGVpTGxRRDRrcXNoZkRDUzRFRzBTQjFxMURKNnZUTVhaN2ZNcmdO?=
 =?utf-8?B?REh4d1ZpNzA2VFNmMjMyZDBNSUljQW9CWGljdWdseGp1WmkwcVN2WGdUblM5?=
 =?utf-8?B?ejl1Q3BXTzYzYmZDNm9MTjB0RGhXZG1odkNJMTB1VmxRRHB2N0hMaThsMXh2?=
 =?utf-8?B?ZXJ1NHNkamRNNmxrS3l6aU1SR3RMUFJnTUtVTmRHQVEvdGNzb1dod2w1V1Fj?=
 =?utf-8?Q?H8Ga8gS13elvC?=
x-microsoft-antispam-prvs: <BYAPR02MB535090236C5740B40D154DFEC2720@BYAPR02MB5350.namprd02.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(366004)(136003)(51914003)(189003)(13464003)(199004)(5660300002)(52536013)(81166006)(81156014)(8676002)(99286004)(76176011)(105586002)(106356001)(93886005)(6246003)(229853002)(7696005)(7736002)(8936002)(55016002)(6116002)(74316002)(9686003)(53936002)(86362001)(305945005)(71190400001)(71200400001)(6306002)(6916009)(256004)(2906002)(26005)(25786009)(68736007)(3846002)(53546011)(6506007)(33656002)(186003)(102836004)(66066001)(486006)(97736004)(14454004)(478600001)(966005)(4326008)(446003)(316002)(476003)(11346002)(6436002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5350;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zkAJZLuFwibDr07NVZXqopTmmiEgM+iJurw2Fy40Gg68LMGc1MiY3PbKUzdVkiZsNgFKVuV6xw7unVlMMziS1VBjJXwYdalEZoaeNS0SA27MI8HygPrPNm8KhEz9s7SpmdrL43K3azWYEI375Lq/I2kzB1IaOwqxZKZmb5A6MYdgtujlWRNtcHaCM55bnvF+CqfygU6x8piCcj5tfG4xMtiKpfDlQ7juI7y2JYCHagS/8D1kp14cMNBcL6TifGGACCUq63F7X76PHDAsHDWvjUBIZikxLXXFppGpfB+QRzfcMnyBykczpWPuytM8/UJIbWCzr5JvtzOQA09PPI2tRcjhdv1cGgUrRAYuYP++1ZpmG3p/ChrNF40yw/eOLl0cb90JEU5UAYfQ4GTcM82NaMT8QKshfZp+X+U5kcibuRE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb66178-da6d-432d-90aa-08d6a14ee0fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 09:42:27.1676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4NClBsZWFzZSBmaW5kIG15
IHJlc3BvbnNlIGlubGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBSb2IgSGVycmluZyBbbWFpbHRvOnJvYmhAa2VybmVsLm9yZ10NCj4gU2VudDogTW9uZGF5LCBN
YXJjaCA0LCAyMDE5IDEwOjU3IFBNDQo+IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhp
bGlueC5jb20+DQo+IENjOiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgTWljaGFsIFNpbWVrIDxtaWNo
YWxzQHhpbGlueC5jb20+OyBSYWphbiBWYWphDQo+IDxSQUpBTlZAeGlsaW54LmNvbT47IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBKb2xseSBTaGFoDQo+IDxKT0xM
WVNAeGlsaW54LmNvbT47IGNoaW5uaWtpc2hvcmUzNjlAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgNi82XSBkdC1iaW5kaW5nczogZnBnYTogQWRkIGJpbmRpbmdzIGZvciBaeW5x
TVAgZnBnYQ0KPiBkcml2ZXINCj4gDQo+IE9uIE1vbiwgTWFyIDQsIDIwMTkgYXQgNTozNSBBTSBO
YXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4g
SGkgUm9iLA0KPiA+DQo+ID4gIFRoYW5rcyBmb3IgcHJvdmlkaW5nIHRoZSByZXZpZXcgY29tbWVu
dHMuLg0KPiA+IFBsZWFzZSBmaW5kIG15IHJlc3BvbnNlIGlubGluZS4NCj4gPg0KPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86
cm9iaEBrZXJuZWwub3JnXQ0KPiA+ID4gU2VudDogU2F0dXJkYXksIEZlYnJ1YXJ5IDIzLCAyMDE5
IDI6MDEgQU0NCj4gPiA+IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+
DQo+ID4gPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IE1pY2hhbCBTaW1layA8bWljaGFsc0B4
aWxpbnguY29tPjsgUmFqYW4NCj4gPiA+IFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgtIGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBKb2xseQ0KPiA+ID4gU2hh
aCA8Sk9MTFlTQHhpbGlueC5jb20+OyBjaGlubmlraXNob3JlMzY5QGdtYWlsLmNvbQ0KPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyA2LzZdIGR0LWJpbmRpbmdzOiBmcGdhOiBBZGQgYmluZGlu
Z3MgZm9yDQo+ID4gPiBaeW5xTVAgZnBnYSBkcml2ZXINCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEph
biAyMywgMjAxOSBhdCAyOjQ2IFBNIE5hdmEga2lzaG9yZSBNYW5uZQ0KPiA+ID4gPG5hdmFtQHhp
bGlueC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gSGkgUm9iLA0KPiA+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIHByb3ZpZGluZyB0aGUgY29t
bWVudHMuLi4NCj4gPiA+DQo+ID4gPiBQbGVhc2UgZml4IHlvdXIgbWFpbGVyIHRvIHNlbmQgcGxh
aW4gdGV4dCBlbWFpbHMgdG8gbWFpbCBsaXN0cy4NCj4gPiA+DQo+ID4gVGhhbmtzIGZvciBwb2lu
dGluZyBpdC4uDQo+ID4NCj4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBSb2IgSGVycmluZyBbbWFpbHRvOnJvYmhAa2Vy
bmVsLm9yZ10NCj4gPiA+ID4NCj4gPiA+ID4gPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjEsIDIw
MTkgOToxOSBQTQ0KPiA+ID4gPg0KPiA+ID4gPiA+IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5h
dmFtQHhpbGlueC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+ID4gQ2M6IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+ID4gPiA+ID4gUmFqYW4g
VmFqYQ0KPiA+ID4gPg0KPiA+ID4gPiA+IDxSQUpBTlZAeGlsaW54LmNvbT47IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+ID4gPiBsaW51eC0NCj4gPiA+ID4NCj4g
PiA+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgSm9sbHkgU2hhaA0KPiA+ID4gPg0KPiA+ID4gPiA+IDxKT0xMWVNAeGlsaW54LmNvbT47IGNo
aW5uaWtpc2hvcmUzNjlAZ21haWwuY29tDQo+ID4gPiA+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MyA2LzZdIGR0LWJpbmRpbmdzOiBmcGdhOiBBZGQgYmluZGluZ3MgZm9yDQo+ID4g
PiA+ID4gWnlucU1QIGZwZ2ENCj4gPiA+ID4NCj4gPiA+ID4gPiBkcml2ZXINCj4gPiA+ID4NCj4g
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+IE9uIE1vbiwgSmFuIDIxLCAyMDE5IGF0IDExOjA4
OjM1UE0gKzA1MzAsIE5hdmEga2lzaG9yZSBNYW5uZSB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4g
PiA+IEFkZCBkb2N1bWVudGF0aW9uIHRvIGRlc2NyaWJlIFhpbGlueCBaeW5xTVAgZnBnYSBkcml2
ZXIgYmluZGluZ3MuDQo+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhLm1hbm5lQHhpbGlueC5jb20+
DQo+ID4gPiA+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4NCj4gPiA+ID4gPiA+IENoYW5nZXMg
Zm9yIHYzOg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgLVJl
bW92ZWQgUENBUCBhcyBhIGNoaWxkIG5vZGUgdG8gdGhlDQo+ID4gPiA+ID4gPiBGVyBhbmQgQ3Jl
YXRlZA0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYW4gaW5k
ZXBlbmRlbnQgbm9kZSBzaW5jZSBQQ0FQIGRyaXZlcg0KPiA+ID4gPiA+ID4gaXMgYSBjb25zdW1l
cg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbm90IGEgcHJv
dmlkZXIuDQo+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gIC4uLi9i
aW5kaW5ncy9mcGdhL3hsbngsenlucW1wLXBjYXAtZnBnYS50eHQgICAgICAgICB8IDEzICsrKysr
KysrKysrKysNCj4gPiA+ID4NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGxu
eCx6eW5xbXAtcGNhcC1mcGdhLnQNCj4gPiA+ID4gPiA+IHh0DQo+ID4gPiA+DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPg0KPiA+ID4gPiA+ID4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS94bG54LHp5bnFtcC1wY2Fw
LWZwZ2ENCj4gPiA+ID4gPiA+IC50eHQNCj4gPiA+ID4NCj4gPiA+ID4gPiA+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGxueCx6eW5xbXAtcGNhcC1mcGdhDQo+ID4g
PiA+ID4gPiAudHh0DQo+ID4gPiA+DQo+ID4gPiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+ID4gPg0KPiA+ID4gPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4xZjZmNTg4NzIzMTENCj4g
PiA+ID4NCj4gPiA+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4NCj4gPiA+ID4gPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL3hsbngsenlucW1wLXBj
YXAtDQo+ID4gPiA+ID4gPiArKysgZnBnYQ0KPiA+ID4gPiA+ID4gKysrIC50eHQNCj4gPiA+ID4N
Cj4gPiA+ID4gPiA+IEBAIC0wLDAgKzEsMTMgQEANCj4gPiA+ID4NCj4gPiA+ID4gPiA+ICtEZXZp
Y2UgVHJlZSB6eW5xbXAtZnBnYSBiaW5kaW5ncyBmb3IgdGhlIFp5bnEgVWx0cmFzY2FsZSsNCj4g
PiA+ID4gPiA+ICtNUFNvQw0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gK2NvbnRyb2xsZWQgdXNpbmcg
WnlucU1QIFNvQyBmaXJtd2FyZSBpbnRlcmZhY2UgRm9yIEJpdHN0cmVhbQ0KPiA+ID4gPg0KPiA+
ID4gPiA+ID4gK2NvbmZpZ3VyYXRpb24gb24gWnlucU1wIFNvYyB1c2VzIHByb2Nlc3NvciBjb25m
aWd1cmF0aW9uDQo+ID4gPiA+DQo+ID4gPiA+ID4gPiArcG9ydChQQ0FQKSB0byBjb25maWd1cmUg
dGhlIHByb2dyYW1tYWJsZSBsb2dpYyhQTCkgdGhyb3VnaCBQUw0KPiA+ID4gPiA+ID4gK2J5DQo+
ID4gPiA+DQo+ID4gPiA+ID4gPiArdXNpbmcgRlcgaW50ZXJmYWNlLg0KPiA+ID4gPg0KPiA+ID4g
PiA+ID4gKw0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4g
PiA+DQo+ID4gPiA+ID4gPiArLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiAieGxueCx6eW5x
bXAtcGNhcC1mcGdhIg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPg0KPiA+ID4gPiA+
ID4gK0V4YW1wbGU6DQo+ID4gPiA+DQo+ID4gPiA+ID4gPiArICAgICAgenlucW1wX3BjYXA6IHBj
YXAgew0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAieGxueCx6eW5xbXAtcGNhcC1mcGdhIjsNCj4gPiA+ID4NCj4gPiA+ID4gPiA+ICsgICAg
ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gVGhlcmUncyBubyBu
ZWVkIGZvciBhIERUIG5vZGUuIEp1c3QgbWFrZSB0aGUgZmlyd2FyZSBkcml2ZXINCj4gPiA+ID4g
PiBjcmVhdGUgYSBwbGF0Zm9ybQ0KPiA+ID4gPg0KPiA+ID4gPiA+IGRldmljZSBmb3IgcGNhcC4N
Cj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGlzIGRyaXZlciBiZWluZyB1c2VkIGJ5IHRoZSBGUEdBIG1hbmFnZXIgZnJhbWV3b3JrKGZwZ2Et
cmVnaW9uKQ0KPiA+ID4gPiB0byBhcHBseQ0KPiA+ID4gb3ZlcmxheSdzIHNvIHRoaXMgbm9kZSBp
cyBuZWVkZWQgQUZBSUsuDQo+ID4gPg0KPiA+ID4gVGhlIGJpbmRpbmcgc2F5cyBub3RoaW5nIGFi
b3V0IGNoaWxkIG5vZGVzIGFuZCB3aGF0IHRoZXkgYXJlLiBQbGVhc2UNCj4gPiA+IGRlZmluZSB0
aGF0Lg0KPiA+ID4NCj4gPiBEbyB5b3UgbWVhbiBJIG5lZWQgdG8gYWRkIHRoZSBleGFtcGxlIHVz
YWdlIG9mIHRoZSBwY2FwIG5vZGUgbGlrZSBhcyBiZWxvdw0KPiBpbiB0aGUgYmluZGluZyBkb2M/
DQo+IA0KPiBZb3UgY2FuIGhhdmUgYW4gZXhhbXBsZSwgYnV0IG5vLCBJIG1lYW50IHlvdSBuZWVk
IHNheSBzb21ldGhpbmcgbGlrZSAiVGhlDQo+IHBjYXAgbm9kZSBtYXkgaGF2ZSAxIG9yIG1vcmUg
Y2hpbGQgbm9kZXMgd2hpY2ggaGF2ZSBhbiAnZnBnYS1yZWdpb24nDQo+IGNvbXBhdGlibGUuDQo+
ID4NCj4gPiBEZXZpY2UgVHJlZSBFeGFtcGxlIGZvciBGdWxsIFJlY29uZmlndXJhdGlvbg0KPiA+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4NCj4gPiBM
aXZlIERldmljZSBUcmVlIGNvbnRhaW5zOg0KPiA+DQo+ID4gICAgICAgICB6eW5xbXBfcGNhcDog
cGNhcCB7DQo+ID4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAieGxueCx6eW5xbXAtcGNh
cC1mcGdhIjsNCj4gPiAgICAgICAgIH07DQo+ID4NCj4gPiAgICAgICAgIGZwZ2FfcmVnaW9uMDog
ZnBnYS1yZWdpb24wIHsNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGEgY2hpbGQgb2YgcGNhcC4NCj4g
DQpBRkFJSyB3ZSBjYW4ndCBwdXQgdGhlIGZwZ2EtcmVnaW9uIGFzIGEgY2hpbGQgb2YgcGNhcCBh
cyBib3RoIGFyZSBpbmRlcGVuZGVudCBhbmQgdGhleSByZWZlcmVkIHRvIGVhY2ggb3RoZXIgdXNp
bmcgcGhhbmRsZXJzDQpJIGhhdmUgbWFkZSB0aGlzIGNoYW5nZXMgYnkgbG9va2luZyBpbnRvIHRo
ZSBiZWxvdyByZWZlcmVuY2UgZG9jLg0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4
L2Jsb2IvbWFzdGVyL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2Et
cmVnaW9uLnR4dCANCg0KPiA+ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZwZ2EtcmVn
aW9uIjsNCj4gPiAgICAgICAgICAgICAgICAgZnBnYS1tZ3IgPSA8Jnp5bnFtcF9wY2FwPjsNCj4g
PiAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MHgxPjsNCj4gPiAgICAgICAgICAg
ICAgICAgI3NpemUtY2VsbHMgPSA8MHgxPjsNCj4gPiAgICAgICAgICAgICAgICAgcmFuZ2VzOw0K
PiA+ICAgICAgICAgfTsNCj4gPg0KPiA+IERUIE92ZXJsYXkgY29udGFpbnM6DQo+IA0KPiBEb24n
dCBzaG93IG92ZXJsYXlzIGluIGV4YW1wbGVzLiBKdXN0IHNob3cgYSBmaW5hbCB0cmVlIChpLmUu
IGJhc2Ugd2l0aCBvdmVybGF5DQo+IGFwcGxpZWQpLg0KDQpUbyBnZXQgYSBiZXR0ZXIgcGljdHVy
ZSBmb3IgdGhlIHVzZXJzIGkgaGF2ZSBhZGRlZCB0aGlzIGV4YW1wbGUgbm9kZSB3aXRoIG92ZXJs
YXlzDQpJIGZlZWwgaXQncyBnb29kIHRvIGhhdmUgdGhpcyBpbmZvIGJlY2F1c2UgaXQgd2lsbCBu
b3QgaW1wYWN0IHRoZSBmdW5jdGlvbmFsaXR5IG9mIFBDQVAgbm9kZS4NClBsZWFzZSBsZXQgbWUg
a25vdyBpZiB5b3Ugc3RpbGwgIHdhbnQgbWUgdG8gbWFrZSB0aGlzIGV4YW1wbGUgd2l0aG91dCBv
dmVybGF5IG5vZGUuDQoNClJlZ2FyZHMsDQpOYXZha2lzaG9yZS4NCg==
