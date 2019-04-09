Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B991FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B30020883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="t/Gm+6XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDISoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:44:08 -0400
Received: from mail-eopbgr750098.outbound.protection.outlook.com ([40.107.75.98]:35278
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbfDISoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWve+xt3BuMJnW4AiTVoqHeAljos7bruajlvxmN9vh4=;
 b=t/Gm+6XSZATrea2bCnTPfxti7WBPK3BZwB73y9joz/jzOezkehJ0rJZydA9+tyDc0Kwavr52OtS3olx4EonL9O8Gzsm5GqMn4PfOcU1QYCgIctYzhTLu9x4kxtdyxYcRa2TxoVuwAdUuTVD6vygQIM/Iazy5KDdSW3VbiwiR3iY=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2398.namprd13.prod.outlook.com (52.135.94.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.8; Tue, 9 Apr 2019 18:44:03 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::30dc:67e2:d25a:f1d3]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::30dc:67e2:d25a:f1d3%6]) with mapi id 15.20.1792.007; Tue, 9 Apr 2019
 18:44:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: linux-next: Tree for Apr 9
Thread-Topic: linux-next: Tree for Apr 9
Thread-Index: AQHU7wGcVIA8AnHTf0+0mDqAlHkrdaY0KmKA
Date:   Tue, 9 Apr 2019 18:44:03 +0000
Message-ID: <a7105dcd96843c456116e3aee96fd99a65e76851.camel@hammerspace.com>
References: <20190409180042.15bb90b6@canb.auug.org.au>
         <20190409182524.GA18518@roeck-us.net>
In-Reply-To: <20190409182524.GA18518@roeck-us.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c68293a-794b-4177-80bd-08d6bd1b56d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR13MB2398;
x-ms-traffictypediagnostic: SN6PR13MB2398:
x-microsoft-antispam-prvs: <SN6PR13MB2398773036E3969B59DBFF94B82D0@SN6PR13MB2398.namprd13.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39830400003)(136003)(53754006)(199004)(189003)(6246003)(105586002)(6512007)(476003)(5660300002)(446003)(76176011)(2616005)(14454004)(11346002)(14444005)(26005)(6506007)(99286004)(478600001)(102836004)(86362001)(229853002)(66066001)(6486002)(110136005)(54906003)(2501003)(186003)(316002)(6436002)(2906002)(25786009)(97736004)(486006)(106356001)(305945005)(256004)(81166006)(68736007)(81156014)(118296001)(8936002)(8676002)(71190400001)(4326008)(71200400001)(7736002)(3846002)(36756003)(53936002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2398;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DFSBz4jOaNPxUY/cho3vfGVCpTjffD3aI4QZzmkuCyzrLzdlFO3Afm0DIdVQRhd5lj5A5bqMDqHInF/xj4a2NgFi6/89/NpUd2EBKyv9QmoU6Xf0MvyqWQxJiPfil83qdKJy6rt5s/3l7ekGO8NymxT+J7lXIUKmXPXBmxEKcOtHpsEaugCU4+QSIdofooESqUwfkHlYe7jFJScPhags8BwBBCWWeywdQw/CPNXv8vfUcPgzM7H4h4Y56fxcj2kwvT0642O8IvgbgSptpUBLFTS/N/ipamu27j2bJ642A4dB00NTvrn+D8RY0b6gJgFm9tafm1+b8k3sPD4lnBoYPHsZUSb/M70l3M5Mv6F/A766zkfrZAqf0G0P+SAdZxVCPBFrPXpWrkBBYzOguWpgDgPrSGpWvQoa9stBWWQaHXw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <690DFFD24CAF2F4E98FF4FD51C00FE7E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c68293a-794b-4177-80bd-08d6bd1b56d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 18:44:03.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA0LTA5IGF0IDExOjI1IC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiBUdWUsIEFwciAwOSwgMjAxOSBhdCAwNjowMDo0MlBNICsxMDAwLCBTdGVwaGVuIFJvdGh3
ZWxsIHdyb3RlOg0KPiA+IEhpIGFsbCwNCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIDIwMTkwNDA4
Og0KPiA+IA0KPiA+IFRoZSBtYWM4MDIxMS1uZXh0IHRyZWUgZ2FpbmVkIGEgY29uZmxpY3QgYWdh
aW5zdCB0aGUgbWFjODAyMTEgdHJlZS4NCj4gPiANCj4gPiBUaGUgZHJtIHRyZWUgc3RpbGwgaGFk
IGl0cyBidWlsZCBmYWlsdXJlIGZvciB3aGljaCBJIGRpc2FibGVkIGENCj4gPiBkcml2ZXIuDQo+
ID4gDQo+ID4gVGhlIGRybS1taXNjIHRyZWUgZ2FpbmVkIGNvbmZsaWN0cyBhZ2FpbnN0IHRoZSBk
cm0gdHJlZSBhbmQgYWxzbyBhDQo+ID4gYnVpbGQNCj4gPiBmYWlsdXJlIGZvciB3aGljaCBJIG1h
cmtlZCBhIGRyaXZlciBhcyBCUk9LRU4uDQo+ID4gDQo+ID4gVGhlIHNjc2ktbWtwIHRyZWUgZ2Fp
bmVkIGEgYnVpbGQgZmFpbHVyZSBmb3Igd2hpY2ggSSByZXZlcnRlZCBhDQo+ID4gY29tbWl0Lg0K
PiA+IA0KPiA+IFRoZSBydGMgdHJlZSBnYWluZWQgYSBjb25mbGljdCBhZ2FpbnN0IHRoZSBvbWFw
IHRyZWUuDQo+ID4gDQo+ID4gTm9uLW1lcmdlIGNvbW1pdHMgKHJlbGF0aXZlIHRvIExpbnVzJyB0
cmVlKTogNTU4Nw0KPiA+ICA1Mzg2IGZpbGVzIGNoYW5nZWQsIDE3NjkwNiBpbnNlcnRpb25zKCsp
LCA4NzQ5MyBkZWxldGlvbnMoLSkNCj4gPiANCj4gDQo+IFRoaXMgb25lIGRlc2VydmVzIGEgcmVw
bHkuDQo+IA0KPiBCdWlsZCByZXN1bHRzOg0KPiAJdG90YWw6IDE1OSBwYXNzOiAxNDQgZmFpbDog
MTUNCj4gRmFpbGVkIGJ1aWxkczogDQo+IAk8bWFueT4NCj4gUWVtdSB0ZXN0IHJlc3VsdHM6DQo+
IAl0b3RhbDogMzQ1IHBhc3M6IDIyNyBmYWlsOiAxMTgNCj4gRmFpbGVkIHRlc3RzOiANCj4gCTxt
YW55Pg0KPiANCj4gQnVpbGQgZmFpbHVyZSBpczoNCj4gDQo+IHMvbmZzZC9uZnNzdmMuYzogSW4g
ZnVuY3Rpb24gJ25mc2Rfc3VwcG9ydF9hY2xfdmVyc2lvbic6DQo+IGZzL25mc2QvbmZzc3ZjLmM6
MTQ1OjE0OiBlcnJvcjogJ05GU0RfQUNMX01JTlZFUlMnIHVuZGVjbGFyZWQNCj4gDQo+IGFuZCBz
aW1pbGFyLiBCdWlsZCBmYWlsdXJlcyBhbmQgKG1hbnkgPyBtb3N0ID8gYWxsID8pIG9mIHRoZSBx
ZW11DQo+IGZhaWx1cmVzDQo+IGFyZSBkdWUgdG8gY29tbWl0IDU1ZDRjNzE2ZWEgKCJuZnNkOiBB
ZGQgY3VzdG9tIHJwY2JpbmQgY2FsbGJhY2tzIGZvcg0KPiBrbmZzZCIpLg0KDQpBbiB1cGRhdGVk
IHBhdGNoIHNldCB0aGF0IGZpeGVzIHRoaXMgaXNzdWUgd2FzIHNlbnQgb3V0IGVhcmxpZXIgdG9k
YXkuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
