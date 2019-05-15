Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E4C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D2C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="Yw7uQRqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfEORUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:20:50 -0400
Received: from mail-eopbgr700126.outbound.protection.outlook.com ([40.107.70.126]:39776
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfEORUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrbxQCssYb0AoOrQwYexbbQS/u6Oj266/mwqmDClGJw=;
 b=Yw7uQRqtzXbNwF/8phr0STRTPw2XiW8hB3CvzxR7wpobXEGUdgzZERJXcyUaOypkiYAjwALzhsPzEEhmn9j0GcUw/XUuf7ID+Se2AfXf0DF4RWJ0FZfzE8Ws65ICCTcymGR5FSSGjJB1XKijulZIHpvXGrMTZMzuy/MZlP6dAg4=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3770.namprd06.prod.outlook.com (10.167.236.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 17:20:44 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::b496:85ab:4cb0:5876]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::b496:85ab:4cb0:5876%2]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 17:20:44 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH] ARC: [plat-hsdk] Get rid of inappropriate PHY settings
Thread-Topic: [PATCH] ARC: [plat-hsdk] Get rid of inappropriate PHY settings
Thread-Index: AQHVCzOlreV9zN2ODkC/aXsLy4DzSqZsbqWA
Date:   Wed, 15 May 2019 17:20:43 +0000
Message-ID: <1557940843.4229.120.camel@impinj.com>
References: <20190515153340.40074-1-abrodkin@synopsys.com>
In-Reply-To: <20190515153340.40074-1-abrodkin@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 045d265a-f4b6-4a2b-5662-08d6d959a9ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR0601MB3770;
x-ms-traffictypediagnostic: MWHPR0601MB3770:
x-microsoft-antispam-prvs: <MWHPR0601MB3770339FCDA0E79609CCDB4ED3090@MWHPR0601MB3770.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39840400004)(376002)(346002)(189003)(199004)(3846002)(6116002)(6512007)(25786009)(103116003)(4326008)(6486002)(6436002)(256004)(14444005)(5024004)(2501003)(26005)(186003)(8936002)(316002)(81156014)(81166006)(8676002)(66066001)(486006)(476003)(2616005)(11346002)(446003)(91956017)(66446008)(64756008)(66556008)(66476007)(68736007)(73956011)(66946007)(99286004)(76176011)(478600001)(76116006)(6246003)(305945005)(14454004)(7736002)(229853002)(71190400001)(71200400001)(36756003)(86362001)(5660300002)(6506007)(2906002)(54906003)(110136005)(102836004)(53936002)(26583001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3770;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +AF1fAGOuXXAwK+aWhJwFyjGPne87ahnuSyBfux+lLZh8NdH7xeiHEr+NKBvK4j+8l3p8G/kEh+/0I9PHa17MXHmMfcSqc5qlRlaKlWeLlJR1FQefl+KGl6cqXOOkqoIsjA7z5fE8QJVeNMD9aauEVJjfj4eGQ6ad6IcKyrZ5bWabplapRYdy2Q2Lw3PjyGB9wFTJ21oCr2YeMjadhFkKFIPHBUB05TpmN2T0x9jp2GLKRzk1jPfks1kcNBBQzIdDDmiFA/fFE4ND3rQiN21NtxMlsB161r4XD08USpWkbSVapSfelxgFLpIcOGMlU0uKs6BrMMJ7HzX9LPaju43Ak/eIGb51RCHKSYVJ3hR4aVwOBXmm7Co8KG6JXzK6wIvrWvkeouOQJcJBnh6PjhVM36Y3U+dmjy1GY8pmUNIers=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCEC152D4F9FFB45B24A2BCD5A3C5E73@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045d265a-f4b6-4a2b-5662-08d6d959a9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 17:20:43.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTE1IGF0IDE4OjMzICswMzAwLCBBbGV4ZXkgQnJvZGtpbiB3cm90ZToN
Cj4gSW5pdGlhbCBicmluZy11cCBvZiB0aGUgcGxhdGZvcm0gd2FzIGRvbmUgb24gRlBHQSBwcm90
b3R5cGUNCj4gd2hlcmUgVEkncyBEUDgzODY3IFBIWSB3YXMgdXNlZC4gQW5kIHNvIHNvbWUgc3Bl
Y2lmaWMgUEhZDQo+IG9wdGlvbnMgd2VyZSBhZGRlZC4NCj4gDQo+IEp1c3QgdG8gY29uZmlybSB0
aGlzIGlzIHdoYXQgd2UgZ2V0IG9uIEZQR0EgcHJvdG90eXBlIGluIHRoZSBib290bG9nOg0KPiA+
IFRJIERQODM4Njcgc3RtbWFjLTA6MDA6IGF0dGFjaGVkIFBIWSBkcml2ZXIgW1RJIERQODM4Njdd
IC4uLg0KPiANCj4gT24gcmVhbCBib2FyZCB0aG91Z2ggd2UgaGF2ZSBNaWNyZWwgS1pTOTAzMSBQ
SFkgYW5kIHdlIGV2ZW4gaGF2ZQ0KPiBDT05GSUdfTUlDUkVMX1BIWT15IHNldCBpbiBoc2RrX2Rl
ZmNvbmZpZy4gVGhhdCdzIHdoYXQgd2Ugc2VlIGluIHRoZSBib290bG9nOg0KPiA+IE1pY3JlbCBL
U1o5MDMxIEdpZ2FiaXQgUEhZIHN0bW1hYy0wOjAwOiAuLi4NCj4gDQo+IFNvIGVzc2VudGlhbGx5
IGFsbCBUSS1yZWxhdGVkIGJpdHMgaGF2ZSB0byBnbyBhd2F5Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQWxleGV5IEJyb2RraW4gPGFicm9ka2luQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IFRyZW50IFBp
ZXBobyA8dHBpZXBob0BpbXBpbmouY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2Vy
bmVsLm9yZz4NCg0KQWNrZWQtYnk6IDx0cGllcGhvQGltcGluai5jb20+DQoNCj4gLS0tDQo+ICBh
cmNoL2FyYy9ib290L2R0cy9oc2RrLmR0cyB8IDQgLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBAQCAtMjAxLDkgKzIwMCw2IEBADQoNCkkgdGhpbmsgaXQgd291
bGQgYmUgcGVkYW50aWNhbGx5IGNvcnJlY3QgdG8gY2hhbmdlIHRoZSBwaHktbW9kZSB0bw0KInJn
bWlpLWlkIiwgdGhvdWdoIEkgc2VlIG5vdGhpbmcgaW4gdGhlIG1pY3JlbCBwaHkgZHJpdmVyIHRo
YXQgdXNlcw0KdGhpcywgYW5kIHNvIGRvdWJ0IGl0IHdpbGwgZG8gYW55dGhpbmcgYXQgYWxsIGF0
IHRoaXMgcG9pbnQuDQoNClRoZSBNaWNyZWwgcGh5IGFwcGVhcnMgdG8gZGVmYXVsdCB0byBwdXR0
aW5nIGEgY2xvY2sgc2tldyBvbiB0aGUgUkdNSUkNCmxpbmVzIGFuZCB0aGUgZHJpdmVyIHdpbGwg
dXNlIHRoZSBkZWZhdWx0IGlmIG5vIHByb3BlcnRpZXMgYXJlIHByZXNlbnQuDQpTbyBJIGJlbGll
dmUgd2hhdCB5b3VyIGJvYXJkIGlzIGVmZmVjdGl2ZWx5IHVzaW5nIG5vdyBpcyAicmdtaWktaWQi
DQp3aXRoIGRlZmF1bHQgc2tld3MsIHVubGVzcyB0aGUgcGh5IGFuZCB5b3VyIGJvYXJkIGRlc2ln
biBoYXMgc29tZQ0KcmVzaXN0b3IgcGluIHN0cmFwcGluZyB0aGF0IGhhcyBjaGFuZ2VkIHRoaXMu
DQo=
