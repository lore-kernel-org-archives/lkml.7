Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23521C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBCD2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AqLbGOr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfFRE7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:59:22 -0400
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:4214
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbfFRE7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YkMxd8j2d8QMpQ7UnpLoxtqgbUrfqoLnenExYUsNW8=;
 b=AqLbGOr0lXVVp00q/WibCwYdyGpayaeaTWozDV+NFowb6wWrFmWJiha8ZGwMNOQj3i0e0Lu15VKu5yXjqrFUeFMsZ422+DQssSh/6cvaFrWAlmraQnf3w9WU0fSnF7Tlp2hdMcLVyGQ/D/a56p6joB9PqxOxGnW25si/wYsI+Aw=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (10.255.7.10) by
 MN2PR02MB6365.namprd02.prod.outlook.com (52.132.175.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 04:59:16 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::e55a:e2d1:953f:ed3b]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::e55a:e2d1:953f:ed3b%4]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 04:59:16 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michals@xilinx.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Thread-Topic: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP
 Platform Tap Delays Setup
Thread-Index: AQHVIDwWKZKZdF95gUaFGq/oqBvspKafu1mAgAADioCAAA8FAIAAIhYAgAAJ3oCAAOY6IA==
Date:   Tue, 18 Jun 2019 04:59:16 +0000
Message-ID: <MN2PR02MB60296837F9D1B3088667BE59C1EA0@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com>
 <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com>
 <CAPDyKFp6O8rPZDZS4iKJam2+tXeen_ZMOXKw=WVzJNpBXcSc9g@mail.gmail.com>
In-Reply-To: <CAPDyKFp6O8rPZDZS4iKJam2+tXeen_ZMOXKw=WVzJNpBXcSc9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1f67496-6674-4497-2c5e-08d6f3a9b702
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR02MB6365;
x-ms-traffictypediagnostic: MN2PR02MB6365:
x-microsoft-antispam-prvs: <MN2PR02MB6365D39D090964EE67700A1AC1EA0@MN2PR02MB6365.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(376002)(136003)(366004)(189003)(199004)(51914003)(13464003)(72206003)(76176011)(6436002)(14454004)(102836004)(53546011)(7696005)(99286004)(7736002)(66066001)(86362001)(3846002)(73956011)(2906002)(52536014)(6116002)(64756008)(229853002)(76116006)(66476007)(6636002)(5660300002)(316002)(305945005)(8936002)(6246003)(71190400001)(33656002)(25786009)(476003)(53936002)(4326008)(55016002)(446003)(11346002)(486006)(256004)(26005)(66446008)(478600001)(81166006)(81156014)(9686003)(8676002)(66556008)(71200400001)(74316002)(66946007)(68736007)(54906003)(6506007)(186003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6365;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QcghaE8dkJ5+B7n7sZVwficMMEzeZiaBluozbADTyJQqwo+9H56I5gy/6TAwVc8kG8oFYYeLUOqblJEOWtrlgc/twC9saZiinqN1Q34E05yOZf3Y+xLRAe9vaPHLah731x3CO7bEcfpTljKq+cY6UFehUkboarhSElRXEg6in7jWtgFBrBj8uDZpIltbEKxH625Y8c6vQgzPGNf1GaNhgbpLQvMjzNqHrZ8W5cxZT/Bail82wlPBTvxj2BuZz6Z8E3862PvONif8+2/e5stjHDIVMfGQmiQPOMQweJPRQBL2vWMxTIFpjTXpITN0Y6JTGAlgW9wYN+jurtFM6ObA/fqaxgsAU1w05x6+MhNal0XyL23PUWYU1ZfaVg5Q5KMR3nH7hI6tVm0lGXUF5FbRoU6q7OYTPaAJmW5blpxWLPQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f67496-6674-4497-2c5e-08d6f3a9b702
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 04:59:16.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnarani@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBQbGVhc2UgZmluZCBteSBjb21tZW50
cyBiZWxvdy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDE3LCAy
MDE5IDg6MjkgUE0NCj4gVG86IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPg0KPiBD
YzogTWFuaXNoIE5hcmFuaSA8TU5BUkFOSUB4aWxpbnguY29tPjsgUm9iIEhlcnJpbmcNCj4gPHJv
YmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBB
ZHJpYW4NCj4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IFJhamFuIFZhamEgPFJB
SkFOVkB4aWxpbnguY29tPjsgSm9sbHkNCj4gU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+OyBOYXZh
IGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+OyBPbG9mDQo+IEpvaGFuc3NvbiA8b2xv
ZkBsaXhvbS5uZXQ+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBEVE1MDQo+IDxkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTGludXggQVJNIDxsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBtbWM6IHNkaGNp
LW9mLWFyYXNhbjogQWRkIHN1cHBvcnQgZm9yIFp5bnFNUA0KPiBQbGF0Zm9ybSBUYXAgRGVsYXlz
IFNldHVwDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+Pg0KPiA+ID4+DQo+ID4gPj4+IEluIHJlZ2Fy
ZHMgdG8gdGhlIG1tYyBkYXRhIHBhcnQsIEkgc3VnZ2VzdCB0byBkcm9wIHRoZQ0KPiA+ID4+PiAt
PnNldF90YXBfZGVsYXkoKSBjYWxsYmFjaywgYnV0IHJhdGhlciB1c2UgYSBib29sZWFuIGZsYWcg
dG8gaW5kaWNhdGUNCj4gPiA+Pj4gd2hldGhlciBjbG9jayBwaGFzZXMgbmVlZHMgdG8gYmUgY2hh
bmdlZCBmb3IgdGhlIHZhcmlhbnQuIFBvdGVudGlhbGx5DQo+ID4gPj4+IHRoYXQgY291bGQgZXZl
biBiZSBza2lwcGVkIGFuZCBpbnN0ZWFkIGNhbGwgY2xrX3NldF9waGFzZSgpDQo+ID4gPj4+IHVu
Y29uZGl0aW9uYWxseSwgYXMgdGhlIGNsb2NrIGNvcmUgZGVhbHMgZmluZSB3aXRoIGNsb2NrIHBy
b3ZpZGVycw0KPiA+ID4+PiB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCB0aGUgLT5zZXRfcGhhc2UoKSBj
YWxsYmFjay4NCg0KSW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIEkgYW0gdGFraW5nIGNh
cmUgb2YgYm90aCB0aGUgaW5wdXQgYW5kDQpvdXRwdXQgY2xvY2sgZGVsYXlzIHdpdGggdGhlIHNp
bmdsZSBjbG9jayAod2hpY2ggaXMgb3V0cHV0IGNsb2NrKSByZWdpc3RyYXRpb24NCmFuZCBkaWZm
ZXJlbnRpYXRpbmcgdGhlc2UgdGFwIGRlbGF5cyBiYXNlZCBvbiB0aGVpciB2YWx1ZXMNCig8MjU2
IHRoZW4gaW5wdXQgZGVsYXkgYW5kICA+PSAyNTYgdGhlbiBvdXRwdXQgZGVsYXkpLCBiZWNhdXNl
IHRoYXQgaXMNCnp5bnFtcCBzcGVjaWZpYy4gSWYgd2Ugd2FudCB0byBtYWtlIHRoaXMgZ2VuZXJp
Yywgd2UgbWF5IG5lZWQgdG8NCnJlZ2lzdGVyICdhbm90aGVyJyBjbG9jayB3aGljaCB3aWxsIGJl
IHRoZXJlIGFzIGFuIGlucHV0IChzYW1wbGluZykgY2xvY2sNCmFuZCB0aGVuIHdlIGNhbiBtYWtl
IHRoaXMgJ2Nsa19zZXRfcGhhc2UoKScgYmUgY2FsbGVkIHVuY29uZGl0aW9uYWxseQ0KZWFjaCBm
b3IgYm90aCB0aGUgY2xvY2tzIGFuZCBsZXQgdGhlIHBsYXRmb3JtcyBoYW5kbGUgdGhlaXIgY2xv
Y2sgcGFydC4NCldoYXQncyB5b3VyIHRha2Ugb24gdGhpcz8NCg0KVGhhbmtzLA0KTWFuaXNoDQo+
ID4gPj4NCj4gPiA+PiBJbiBjb25uZWN0aW9uIHRvIGFub3RoZXIgdmVyc2lvbiBvZiB0aGlzIGRy
aXZlciBmb3IgbGF0ZXN0IFhpbGlueCBjaGlwDQo+ID4gPj4gaXQgd291bGQgYmUgYmV0dGVyIHRv
IGtlZXAgc2V0X3RhcF9kZWxheSBjYWxsYmFjayBpbiB0aGUgZHJpdmVyLiBUaGUNCj4gPiA+PiBy
ZWFzb24gaXMgdGhhdCBuZXcgY2hpcC9pcCBpcyBjYXBhYmxlIHRvIHNldHVwIHRhcCBkZWxheXMg
ZGlyZWN0bHkNCj4gPiA+PiB3aXRob3V0IGFza2luZyBmaXJtd2FyZSB0byBkbyBpdC4gVGhhdCdz
IHdoeSBmb3IgdmVyc2FsIElQIHRoZXJlIGlzIGENCj4gPiA+PiBuZWVkIHRvIGNhbGwgZGlmZmVy
ZW50IHNldHVwX3RhcF9kZWxheSBmdW5jdGlvbi4NCj4gPiA+DQo+ID4gPiBUaGUgLT5zZXRfdGFw
X2RlbGF5KCkgY2FsbGJhY2sgaXMgZm9yIFp5bmNNcCBwb2ludGluZyB0bw0KPiA+ID4gc2RoY2lf
YXJhc2FuX3p5bnFtcF9zZXRfdGFwX2RlbGF5KCkuIFRoaXMgZnVuY3Rpb24gY2FsbHMgdGhlDQo+
ID4gPiBjbGtfc2V0X3BoYXNlKCkgQVBJLg0KPiA+ID4NCj4gPiA+IFdoYXQgZG9lcyAtPnNldF90
YXBfZGVsYXkoKSBkbyBmb3IgdGhlIGxhdGVzdCB2ZXJzaW9uPw0KPiA+DQo+ID4gVGhlcmUgaXMg
ZGlmZmVyZW50IHNldCBvZiBkZWZhdWx0IHRhcCBkZWxheXMgd2hpY2ggc2hvdWxkIGJlIHByb2dy
YW1tZWQNCj4gPiBhbmQgaXQgaXMgZG9uZSBqdXN0IHZpYSB3cml0aW5nIHRvIHJlZ2lzdGVycyB3
aGljaCBhcmUgdGhlIHBhcnQgb2YNCj4gPiBjb250cm9sbGVyIGFkZHJlc3Mgc3BhY2UuDQo+IA0K
PiBPa2F5LCBJIHNlZS4NCj4gDQo+IE5vdCBzdXJlIHdoYXQgbWFrZXMgbW9zdCBzZW5zZSB0byBk
byBoZXJlLCBidXQgaXQgc291bmRzIHRvIG1lIGxpa2UNCj4gYW5vdGhlciAtPnNldF9waGFzZSgp
IGNhbGxiYWNrIHNob3VsZCBiZSBpbXBsZW1lbnRlZCBmb3IgdGhlIGNsb2NrDQo+IHByb3ZpZGVy
LiBJbiBvdGhlciB3b3JkcywgY2FsbGluZyBjbGtfc2V0X3BoYXNlKCkgc2hvdWxkIGNvbnRpbnVl
IHRvDQo+IHdvcmtzIGp1c3QgZmluZSBmb3IgdGhpcyBjYXNlIGFzIHdlbGwuIElmIGl0IHR1cm5z
IG91dCB0byBiZQ0KPiBpbmNvbnZlbmllbnQsIHdlIGNhbiBhbHdheXMgYWRkIHRoZSAtPnNldF90
YXBfZGVsYXkoKSBhdCBhIGxhdGVyIHBvaW50DQo+IHdoZW4gaXQgbWFrZXMgbW9yZSBzZW5zZS4N
Cg0KDQo+IA0KPiBbLi4uXQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
