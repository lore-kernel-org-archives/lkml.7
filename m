Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC2CC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71109218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="G0JYKDNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfDXBcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:32:04 -0400
Received: from mail-eopbgr790054.outbound.protection.outlook.com ([40.107.79.54]:21376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729013AbfDXBcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHPLDN56WBwWAYFgspVGElG4DbPow8L37sLrKa3SFI4=;
 b=G0JYKDNnu15n3cUQKHZ7TI75lpQANyBHL514AQn+Ud69hpRVc8vSDc2R/97xWRyGBFBAvZi3AdsmRNAcixdHb4LQ2JLgCrQJ2v7oMnuBSpr4E2QjLYRFKv3KMJf/IXxr1SHSyFfDhmlYxc8Tq9l5sJ72z9zN3VLB8NA3f+yN0Qs=
Received: from BYAPR05MB5240.namprd05.prod.outlook.com (20.177.231.90) by
 BYAPR05MB5813.namprd05.prod.outlook.com (20.178.49.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.9; Wed, 24 Apr 2019 01:31:59 +0000
Received: from BYAPR05MB5240.namprd05.prod.outlook.com
 ([fe80::51f7:404d:19ec:9e8f]) by BYAPR05MB5240.namprd05.prod.outlook.com
 ([fe80::51f7:404d:19ec:9e8f%6]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 01:31:59 +0000
From:   Deepak Singh Rawat <drawat@vmware.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the drm tree
Thread-Index: AQHU+jPNiTBkBQySEUm7D+nW9oMucaZKdw+AgAAKP4CAAAVOAA==
Date:   Wed, 24 Apr 2019 01:31:59 +0000
Message-ID: <45f1305e2ea62ca76a86c6cca1693c20d3a0c891.camel@vmware.com>
References: <20190424102219.48cfdfe2@canb.auug.org.au>
         <44707352378dcd414b476ec5420db23093fb9351.camel@vmware.com>
         <20190424111259.6a1aacce@canb.auug.org.au>
In-Reply-To: <20190424111259.6a1aacce@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com; 
x-originating-ip: [98.234.189.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fed92ce9-9da4-4764-8676-08d6c854a558
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5813;
x-ms-traffictypediagnostic: BYAPR05MB5813:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB58139F79C87BF23F549E5E43BA3C0@BYAPR05MB5813.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(39860400002)(396003)(199004)(189003)(68736007)(25786009)(99286004)(97736004)(6916009)(4326008)(76176011)(2501003)(118296001)(478600001)(966005)(2351001)(53936002)(316002)(6246003)(54906003)(14454004)(6506007)(8676002)(6306002)(476003)(2906002)(81156014)(86362001)(6512007)(256004)(7736002)(36756003)(446003)(102836004)(6116002)(3846002)(81166006)(1730700003)(186003)(305945005)(71200400001)(6486002)(229853002)(73956011)(66946007)(76116006)(26005)(486006)(66556008)(64756008)(66476007)(66446008)(8936002)(71190400001)(5660300002)(66066001)(2616005)(6436002)(11346002)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5813;H:BYAPR05MB5240.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T5Z8koqbHtcQaLZ38UkZ/mIe8n8C4TPyC67Iukf9C7Az0v4Oopsk9Vj8pcaTUSFhhIEMXrcZdWkRt9si0clGHYBr2x0zTC0PVFf+hLpee4ctPrWLVmn2tLWDH85AX5VaL4+Ubdphiy0d7WMBD/vBGNK1O5Qzhh1n81ywHnsHwpe2byCbpqV3Q3UO793zg3lw17vZg6XuxEFmT6/EHvUUBbmzUJA6V6CT+BPHGl5hyPR0hCMjy6nv60FKxMW82ZKaLten4Smfi/WsH6p+KQ17EKsFT0DNpgok322mSIex0pZvS/egn+F1OOtDbCqzMLQHD/7ecE67lkQ1CtronkFppq9a1H+c3l4zkMIyndv2OYoT6zCOHFUOXa+zgutt0KtvpZp4zdYS+DdYfa1VFZgWl/5CDEbN/ZMfWu7KAsGQbhI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C0ED196CE7C9D45BB5384089950FC27@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed92ce9-9da4-4764-8676-08d6c854a558
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 01:31:59.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA0LTI0IGF0IDExOjEyICsxMDAwLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3Rl
Og0KPiBIaSBEZWVwYWssDQo+IA0KPiBPbiBXZWQsIDI0IEFwciAyMDE5IDAwOjM2OjE5ICswMDAw
IERlZXBhayBTaW5naCBSYXdhdCA8DQo+IGRyYXdhdEB2bXdhcmUuY29tPiB3cm90ZToNCj4gPiAN
Cj4gPiBPbiBXZWQsIDIwMTktMDQtMjQgYXQgMTA6MjIgKzEwMDAsIFN0ZXBoZW4gUm90aHdlbGwg
d3JvdGU6DQo+ID4gPiANCj4gPiA+IENvbW1pdA0KPiA+ID4gDQo+ID4gPiAgIGE5ZjU4YzQ1NmU5
ZCAoImRybS92bXdnZng6IEJlIG1vcmUgcmVzdHJpY3RpdmUgd2hlbiBkaXJ0eWluZw0KPiA+ID4g
cmVzb3VyY2VzIikgIA0KPiA+IA0KPiA+IEFjdHVsbHkgdGhlIFNpZ25lZC1vZmYtYnk6IGlzIG5v
dCBtaXNzaW5nIHNlZSANCj4gPiANCj4gPiANCmh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcv
ZHJtL2RybS9jb21taXQvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeD9pZD1hOWY1OGM0NTZlOWRkZTZm
MjcyZTdiZTRkNmJlZDYwN2ZkNzAwOGFhDQo+IA0KPiBUaGVyZSBpcyBubyBTaWduZWQtb2ZmLWJ5
IGZyb20geW91IGFzIHRoZSBjb21taXR0ZXIgKGp1c3QgYQ0KPiBSZXZpZXdlZC1ieSBmcm9tIHlv
dSBhbmQgYSBTaWduZWQtb2ZmLWJ5IGZyb20gdGhlIGF1dGhvcikuDQoNClNvcnJ5IG1pc3NlZCB0
aGF0IHBhcnQgYW5kIG1pc3NlZCB5b3VyIGVtYWlsIGNvbnRleHQgYWJvdXQgY29tbWl0ZXIgYW5k
DQpub3QgdGhlIGF1dGhvci4gSSB0aGluayBhdCB0aGlzIHBvaW50IG5vdGhpbmcgY2FuIGJlIGRv
bmU/DQoNCj4gDQo+ID4gQnkgdGhlIHdheSB0aGVyZSBpcyB0aGUgcGF0dGVyICItLS0iIGJlZm9y
ZSBTaWduZWQtb2ZmLWJ5Oih3aGljaCBpcw0KPiA+IHNhbWUgYXMgdXNlZCBieSBwYXRjaCB0byBz
ZXBhcmF0ZSBkZXNjcmlwdGlvbiBmcm9tIGNvZGUpIGFuZCBJDQo+ID4gdGhpbmsNCj4gPiB0aGUg
c2NyaXB0IGlzIHJlYWRpbmcgb25seSB0aWxsIHRoYXQgcG9pbnQuIEkgdGhpbmsgIi0tLSIgc2hv
dWxkDQo+ID4gbm90IGJlDQo+ID4gdXNlZCBpbiBwYXRjaCBkZXNjcmlwdGlvbi4NCj4gDQo+IEFs
bCB0aGUgdGFncyBzaG91bGQgYmUgKmJlZm9yZSogdGhlICItLSAiIG9yICItLS0iIHNlcGFyYXRv
ci4NCj4gDQo=
