Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F157C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A662173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RiXT8zfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCMF2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:28:34 -0400
Received: from mail-eopbgr750075.outbound.protection.outlook.com ([40.107.75.75]:28549
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfCMF2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN2DZ2n+6aBR74sCYxWHdnz0WGW8scqZlsAtOUFE7Ic=;
 b=RiXT8zfsOi2I8d9PqK2Q+i/xFBvqc9x4G7eSwlRtguH9X6E/piuBqglCnIY6zeysMGM8jW7C/ehN5d6qTGJtsRKWjQT5ffNkRqeIYTX3imEhZxi8m1MPnL2C1vfnqUKP/AkgdWkmhLiPSAtJ3cWR5cYrQv0dB0PSDrsqRFlFQ4o=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4214.namprd02.prod.outlook.com (20.176.249.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 05:28:25 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::515e:70e7:954c:9731]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::515e:70e7:954c:9731%6]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 05:28:25 +0000
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
Thread-Index: AQHUsOdKmglIsGXrYUShdUJ415kWF6W53/kAgAEjAjCAMXYnAIAPHL/wgABnVgCAAQKe0IAMWWoA
Date:   Wed, 13 Mar 2019 05:28:24 +0000
Message-ID: <BYAPR02MB47100FC86E3879C5C2AAAC9EC24A0@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-7-nava.manne@xilinx.com> <20190121154928.GA32129@bogus>
 <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
 <BYAPR02MB4710216D63D98A56ABD99E67C2710@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CAL_JsqLn8LrO_qHkXK0hgwjvsedMCAEL0MTYXBLrke2cgri3+g@mail.gmail.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ea60736-21f2-45e7-c594-08d6a774b73c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4214;
x-ms-traffictypediagnostic: BYAPR02MB4214:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR02MB42141E059DA0E7F2B6453E85C24A0@BYAPR02MB4214.namprd02.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(51914003)(13464003)(199004)(189003)(7736002)(305945005)(74316002)(55016002)(54906003)(26005)(53936002)(3846002)(6116002)(81156014)(6436002)(105586002)(186003)(81166006)(106356001)(9686003)(6306002)(14454004)(86362001)(446003)(68736007)(476003)(93886005)(486006)(316002)(25786009)(4326008)(6246003)(966005)(52536013)(478600001)(2906002)(6346003)(66066001)(102836004)(5660300002)(6506007)(53546011)(33656002)(97736004)(8936002)(71200400001)(71190400001)(6916009)(229853002)(256004)(76176011)(99286004)(7696005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4214;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sxCXzJuSxYxLMz/kSSqjjroH73ioiQ2FpR9cHd5SPC4latCazsfuGmvolqwITKdbrs1nKJ1FLvn0qSZpGR9Gb8WxnzS3gJMRLqDp2F1UQRKUklkLOYxbnVH5dD8no1gWQoDefd0Lw0AMEzIobftMp0Z/+CwtjK/840WUpNVRD1XzGJL7TSbN+ueD4EnYABL212My6ySM2e1qnTa3+J2UIWVG425ammS+SpGp6desDu9OZk+IPWHEEayk4icn/dpZvH0e5F0SQWxJemtbY7k8rXmfKd1TpaVfOfEwSkeBxKdjmDeuit7Wzmc9nc4lzoeJDTXci0rlAIg/xm8hTG34qnSPvvIYgAzwZ5QmPhnTQLUVbMtTvQYhlFMTffD4p2AaCqzSz9qSmUWT5w07J7ElFEAUlaCRNYoLAlEzfrF407M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea60736-21f2-45e7-c594-08d6a774b73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 05:28:25.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZyAhIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5hdmEga2lz
aG9yZSBNYW5uZQ0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCA1LCAyMDE5IDM6MTIgUE0NCj4gVG86
ICdSb2IgSGVycmluZycgPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IFJhamFuIFZhamENCj4gPFJB
SkFOVkB4aWxpbnguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IEpvbGx5IFNoYWgNCj4gPEpPTExZU0B4aWxpbnguY29tPjsgY2hpbm5pa2lzaG9yZTM2OUBn
bWFpbC5jb207ICdBbGFuIFR1bGwnDQo+IDxhdHVsbEBrZXJuZWwub3JnPjsgTW9yaXR6IEZpc2No
ZXIgPG1vcml0ei5maXNjaGVyQGV0dHVzLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MyA2
LzZdIGR0LWJpbmRpbmdzOiBmcGdhOiBBZGQgYmluZGluZ3MgZm9yIFp5bnFNUCBmcGdhDQo+IGRy
aXZlcg0KPiANCj4gSGkgUm9iLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcXVpY2sgcmVzcG9uc2Uu
DQo+IFBsZWFzZSBmaW5kIG15IHJlc3BvbnNlIGlubGluZS4NCj4gDQo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBSb2IgSGVycmluZyBbbWFpbHRvOnJvYmhAa2VybmVs
Lm9yZ10NCj4gPiBTZW50OiBNb25kYXksIE1hcmNoIDQsIDIwMTkgMTA6NTcgUE0NCj4gPiBUbzog
TmF2YSBraXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPg0KPiA+IENjOiBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBSYWphbg0KPiA+
IFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC0NCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgSm9sbHkgU2hhaA0KPiA+IDxKT0xMWVNAeGlsaW54LmNvbT47IGNoaW5u
aWtpc2hvcmUzNjlAZ21haWwuY29tDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA2LzZdIGR0
LWJpbmRpbmdzOiBmcGdhOiBBZGQgYmluZGluZ3MgZm9yIFp5bnFNUA0KPiA+IGZwZ2EgZHJpdmVy
DQo+ID4NCj4gPiBPbiBNb24sIE1hciA0LCAyMDE5IGF0IDU6MzUgQU0gTmF2YSBraXNob3JlIE1h
bm5lIDxuYXZhbUB4aWxpbnguY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEhpIFJvYiwN
Cj4gPiA+DQo+ID4gPiAgVGhhbmtzIGZvciBwcm92aWRpbmcgdGhlIHJldmlldyBjb21tZW50cy4u
DQo+ID4gPiBQbGVhc2UgZmluZCBteSByZXNwb25zZSBpbmxpbmUuDQo+ID4gPg0KPiA+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBSb2IgSGVycmluZyBbbWFp
bHRvOnJvYmhAa2VybmVsLm9yZ10NCj4gPiA+ID4gU2VudDogU2F0dXJkYXksIEZlYnJ1YXJ5IDIz
LCAyMDE5IDI6MDEgQU0NCj4gPiA+ID4gVG86IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGls
aW54LmNvbT4NCj4gPiA+ID4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29tOyBNaWNoYWwgU2ltZWsg
PG1pY2hhbHNAeGlsaW54LmNvbT47IFJhamFuDQo+ID4gPiA+IFZhamEgPFJBSkFOVkB4aWxpbngu
Y29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPiBsaW51
eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEpv
bGx5DQo+ID4gPiA+IFNoYWggPEpPTExZU0B4aWxpbnguY29tPjsgY2hpbm5pa2lzaG9yZTM2OUBn
bWFpbC5jb20NCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA2LzZdIGR0LWJpbmRpbmdz
OiBmcGdhOiBBZGQgYmluZGluZ3MgZm9yDQo+ID4gPiA+IFp5bnFNUCBmcGdhIGRyaXZlcg0KPiA+
ID4gPg0KPiA+ID4gPiBPbiBXZWQsIEphbiAyMywgMjAxOSBhdCAyOjQ2IFBNIE5hdmEga2lzaG9y
ZSBNYW5uZQ0KPiA+ID4gPiA8bmF2YW1AeGlsaW54LmNvbT4NCj4gPiA+ID4gd3JvdGU6DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBIaSBSb2IsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gVGhhbmtzIGZvciBwcm92aWRpbmcgdGhlIGNvbW1lbnRzLi4uDQo+ID4gPiA+
DQo+ID4gPiA+IFBsZWFzZSBmaXggeW91ciBtYWlsZXIgdG8gc2VuZCBwbGFpbiB0ZXh0IGVtYWls
cyB0byBtYWlsIGxpc3RzLg0KPiA+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciBwb2ludGluZyBpdC4u
DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtl
cm5lbC5vcmddDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAy
MSwgMjAxOSA5OjE5IFBNDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRvOiBOYXZhIGtpc2hvcmUg
TWFubmUgPG5hdmFtQHhpbGlueC5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IENjOiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiA+
ID4gPiA+ID4gUmFqYW4gVmFqYQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA8UkFKQU5WQHhpbGlu
eC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiA+ID4g
PiBsaW51eC0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEpvbGx5IFNoYWgNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPEpPTExZU0B4aWxpbnguY29tPjsgY2hpbm5pa2lzaG9yZTM2OUBnbWFpbC5jb20NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA2LzZdIGR0LWJpbmRp
bmdzOiBmcGdhOiBBZGQgYmluZGluZ3MNCj4gPiA+ID4gPiA+IGZvciBaeW5xTVAgZnBnYQ0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBkcml2ZXINCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gT24gTW9uLCBKYW4gMjEsIDIwMTkgYXQgMTE6MDg6MzVQTSArMDUz
MCwgTmF2YSBraXNob3JlIE1hbm5lDQo+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
IEFkZCBkb2N1bWVudGF0aW9uIHRvIGRlc2NyaWJlIFhpbGlueCBaeW5xTVAgZnBnYSBkcml2ZXIg
YmluZGluZ3MuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmEubWFubmVAeGlsaW54
LmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiBDaGFuZ2VzIGZvciB2MzoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAtUmVtb3ZlZCBQQ0FQIGFzIGEgY2hpbGQgbm9kZSB0byB0aGUNCj4gPiA+
ID4gPiA+ID4gRlcgYW5kIENyZWF0ZWQNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBhbiBpbmRlcGVuZGVudCBub2RlIHNpbmNlIFBDQVANCj4gPiA+ID4g
PiA+ID4gZHJpdmVyIGlzIGEgY29uc3VtZXINCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBub3QgYSBwcm92aWRlci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ICAuLi4vYmluZGluZ3MvZnBnYS94bG54LHp5
bnFtcC1wY2FwLWZwZ2EudHh0ICAgICAgICAgfCAxMw0KPiArKysrKysrKysrKysrDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL3hsbngsenlu
cW1wLXBjYXAtZnBnYQ0KPiA+ID4gPiA+ID4gPiAudA0KPiA+ID4gPiA+ID4gPiB4dA0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdA0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2ZwZ2EveGxueCx6eW5xbXAtcGNhcC1mcA0KPiA+ID4gPiA+ID4gPiBnYQ0KPiA+ID4gPiA+
ID4gPiAudHh0DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZnBnYS94bG54LHp5bnFtcC1wY2FwLWZwDQo+ID4gPiA+ID4gPiA+IGdh
DQo+ID4gPiA+ID4gPiA+IC50eHQNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4u
MWY2ZjU4ODcyMzExDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9mcGdhL3hsbngsenlucW1wLXBjYQ0KPiA+ID4gPiA+ID4gPiArKysgcC0NCj4gPiA+ID4g
PiA+ID4gKysrIGZwZ2ENCj4gPiA+ID4gPiA+ID4gKysrIC50eHQNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiBAQCAtMCwwICsxLDEzIEBADQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gK0Rldmlj
ZSBUcmVlIHp5bnFtcC1mcGdhIGJpbmRpbmdzIGZvciB0aGUgWnlucSBVbHRyYXNjYWxlKw0KPiA+
ID4gPiA+ID4gPiArTVBTb0MNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiArY29udHJvbGxlZCB1
c2luZyBaeW5xTVAgU29DIGZpcm13YXJlIGludGVyZmFjZSBGb3INCj4gPiA+ID4gPiA+ID4gK0Jp
dHN0cmVhbQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ICtjb25maWd1cmF0aW9uIG9uIFp5bnFN
cCBTb2MgdXNlcyBwcm9jZXNzb3IgY29uZmlndXJhdGlvbg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ICtwb3J0KFBDQVApIHRvIGNvbmZpZ3VyZSB0aGUgcHJvZ3JhbW1hYmxlIGxvZ2ljKFBMKSB0
aHJvdWdoDQo+ID4gPiA+ID4gPiA+ICtQUyBieQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ICt1
c2luZyBGVyBpbnRlcmZhY2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ICstIGNvbXBhdGlibGU6IHNob3VsZCBjb250YWluICJ4bG54LHp5bnFtcC1wY2FwLWZw
Z2EiDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ICtFeGFtcGxlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ICsgICAgICB6eW5xbXBfcGNhcDog
cGNhcCB7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAieGxueCx6eW5xbXAtcGNhcC1mcGdhIjsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiArICAgICAgfTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gVGhlcmUncyBubyBuZWVkIGZvciBhIERUIG5vZGUuIEp1c3QgbWFrZSB0aGUgZmlyd2Fy
ZSBkcml2ZXINCj4gPiA+ID4gPiA+IGNyZWF0ZSBhIHBsYXRmb3JtDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IGRldmljZSBmb3IgcGNhcC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGRyaXZlciBiZWluZyB1c2Vk
IGJ5IHRoZSBGUEdBIG1hbmFnZXINCj4gPiA+ID4gPiBmcmFtZXdvcmsoZnBnYS1yZWdpb24pIHRv
IGFwcGx5DQo+ID4gPiA+IG92ZXJsYXkncyBzbyB0aGlzIG5vZGUgaXMgbmVlZGVkIEFGQUlLLg0K
PiA+ID4gPg0KPiA+ID4gPiBUaGUgYmluZGluZyBzYXlzIG5vdGhpbmcgYWJvdXQgY2hpbGQgbm9k
ZXMgYW5kIHdoYXQgdGhleSBhcmUuDQo+ID4gPiA+IFBsZWFzZSBkZWZpbmUgdGhhdC4NCj4gPiA+
ID4NCj4gPiA+IERvIHlvdSBtZWFuIEkgbmVlZCB0byBhZGQgdGhlIGV4YW1wbGUgdXNhZ2Ugb2Yg
dGhlIHBjYXAgbm9kZSBsaWtlIGFzDQo+ID4gPiBiZWxvdw0KPiA+IGluIHRoZSBiaW5kaW5nIGRv
Yz8NCj4gPg0KPiA+IFlvdSBjYW4gaGF2ZSBhbiBleGFtcGxlLCBidXQgbm8sIEkgbWVhbnQgeW91
IG5lZWQgc2F5IHNvbWV0aGluZyBsaWtlDQo+ID4gIlRoZSBwY2FwIG5vZGUgbWF5IGhhdmUgMSBv
ciBtb3JlIGNoaWxkIG5vZGVzIHdoaWNoIGhhdmUgYW4gJ2ZwZ2EtcmVnaW9uJw0KPiA+IGNvbXBh
dGlibGUuDQo+ID4gPg0KPiA+ID4gRGV2aWNlIFRyZWUgRXhhbXBsZSBmb3IgRnVsbCBSZWNvbmZp
Z3VyYXRpb24NCj4gPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQo+ID4gPg0KPiA+ID4gTGl2ZSBEZXZpY2UgVHJlZSBjb250YWluczoNCj4gPiA+DQo+ID4g
PiAgICAgICAgIHp5bnFtcF9wY2FwOiBwY2FwIHsNCj4gPiA+ICAgICAgICAgICAgICAgICBjb21w
YXRpYmxlID0gInhsbngsenlucW1wLXBjYXAtZnBnYSI7DQo+ID4gPiAgICAgICAgIH07DQo+ID4g
Pg0KPiA+ID4gICAgICAgICBmcGdhX3JlZ2lvbjA6IGZwZ2EtcmVnaW9uMCB7DQo+ID4NCj4gPiBU
aGlzIHNob3VsZCBiZSBhIGNoaWxkIG9mIHBjYXAuDQo+ID4NCj4gQUZBSUsgd2UgY2FuJ3QgcHV0
IHRoZSBmcGdhLXJlZ2lvbiBhcyBhIGNoaWxkIG9mIHBjYXAgYXMgYm90aCBhcmUgaW5kZXBlbmRl
bnQNCj4gYW5kIHRoZXkgcmVmZXJlZCB0byBlYWNoIG90aGVyIHVzaW5nIHBoYW5kbGVycyBJIGhh
dmUgbWFkZSB0aGlzIGNoYW5nZXMgYnkNCj4gbG9va2luZyBpbnRvIHRoZSBiZWxvdyByZWZlcmVu
Y2UgZG9jLg0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmQNCj4gaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4
dA0KPiANCj4gPiA+ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZwZ2EtcmVnaW9uIjsN
Cj4gPiA+ICAgICAgICAgICAgICAgICBmcGdhLW1nciA9IDwmenlucW1wX3BjYXA+Ow0KPiA+ID4g
ICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDB4MT47DQo+ID4gPiAgICAgICAgICAg
ICAgICAgI3NpemUtY2VsbHMgPSA8MHgxPjsNCj4gPiA+ICAgICAgICAgICAgICAgICByYW5nZXM7
DQo+ID4gPiAgICAgICAgIH07DQo+ID4gPg0KPiA+ID4gRFQgT3ZlcmxheSBjb250YWluczoNCj4g
Pg0KPiA+IERvbid0IHNob3cgb3ZlcmxheXMgaW4gZXhhbXBsZXMuIEp1c3Qgc2hvdyBhIGZpbmFs
IHRyZWUgKGkuZS4gYmFzZQ0KPiA+IHdpdGggb3ZlcmxheSBhcHBsaWVkKS4NCj4gDQo+IFRvIGdl
dCBhIGJldHRlciBwaWN0dXJlIGZvciB0aGUgdXNlcnMgaSBoYXZlIGFkZGVkIHRoaXMgZXhhbXBs
ZSBub2RlIHdpdGgNCj4gb3ZlcmxheXMgSSBmZWVsIGl0J3MgZ29vZCB0byBoYXZlIHRoaXMgaW5m
byBiZWNhdXNlIGl0IHdpbGwgbm90IGltcGFjdCB0aGUNCj4gZnVuY3Rpb25hbGl0eSBvZiBQQ0FQ
IG5vZGUuDQo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgIHdhbnQgbWUgdG8gbWFr
ZSB0aGlzIGV4YW1wbGUgd2l0aG91dCBvdmVybGF5DQo+IG5vZGUuDQo+IA0KPiBSZWdhcmRzLA0K
PiBOYXZha2lzaG9yZS4NCg==
