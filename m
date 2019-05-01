Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA4FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C6E21783
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="VPD3sRuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEAPM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:12:57 -0400
Received: from mail-eopbgr720056.outbound.protection.outlook.com ([40.107.72.56]:1600
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfEAPM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwoLqd3A2pffZHiTQr1ps4Ogxnn8s7CWEpwht+QlX34=;
 b=VPD3sRuUomxuPcWhSqUQnEQuolasjwi5bS1NW/VynHpj5OWyhzp/14ah60B/n3ba41dXaBeuIZWHeHstlFOQY8wfVu7aH8gsPSRQCFY10Gig9EVRWZ5bl4y7GBbSK8u7QVoByqzCFaPExUhlrwcJfMr/sNrOCMotF/MGQeKAHHc=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3217.namprd10.prod.outlook.com (20.179.138.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 1 May 2019 15:12:52 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::24c5:ea68:cff3:4a16]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::24c5:ea68:cff3:4a16%7]) with mapi id 15.20.1856.008; Wed, 1 May 2019
 15:12:52 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oss@buserror.net" <oss@buserror.net>,
        "Rasmus.Villemoes@prevas.se" <Rasmus.Villemoes@prevas.se>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: soc/fsl: qe: document new
 fsl,qe-snums binding
Thread-Topic: [PATCH v2 4/6] dt-bindings: soc/fsl: qe: document new
 fsl,qe-snums binding
Thread-Index: AQHVAAEbcR+EIbNgq0q8q5zRwMqM06ZWYK2A
Date:   Wed, 1 May 2019 15:12:52 +0000
Message-ID: <4c3aef881393398ca18efac99b1f76e7dbd19acf.camel@infinera.com>
References: <20190430133615.25721-1-rasmus.villemoes@prevas.dk>
         <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
         <20190501092841.9026-5-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190501092841.9026-5-rasmus.villemoes@prevas.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24f776e0-b661-4e67-7b9f-08d6ce477b7b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR10MB3217;
x-ms-traffictypediagnostic: BN8PR10MB3217:
x-microsoft-antispam-prvs: <BN8PR10MB32175B4C5538F43C485C14C3F43B0@BN8PR10MB3217.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(40224003)(199004)(189003)(66066001)(53936002)(36756003)(25786009)(6512007)(5660300002)(99286004)(76176011)(316002)(8676002)(86362001)(54906003)(110136005)(2201001)(7416002)(102836004)(476003)(2616005)(11346002)(486006)(256004)(14444005)(14454004)(26005)(6506007)(446003)(118296001)(66556008)(73956011)(66446008)(64756008)(66476007)(72206003)(66946007)(81156014)(81166006)(305945005)(186003)(7736002)(5024004)(91956017)(76116006)(2501003)(68736007)(71190400001)(71200400001)(4326008)(2906002)(6486002)(8936002)(229853002)(478600001)(6116002)(3846002)(6246003)(6436002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR10MB3217;H:BN8PR10MB3540.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xeALA3hdN25/YrneNVKQ9E5TcKKXwTTBiLExr7cJmLM5VqPsPdcu+PKEA0nd+L0cGajrsHcLnmxUoEGnRyw/n4HgHTV57VlPGaPbW0+N5yEJIHBeMcny02gHXEvRoYvjIlAeCIyAFxdEpdsv521IQEbuj4oKEiFKoE49BkWyoV8SZQd385kKG7K+2tk9v24XhQTRLiJVK0voVuZZUIUwXr75XDukM+tnF9NY8yk06GCqZnykoLIifyG62kA8K9LLGRP9AUhBQiaSZeDxDGrXzaTaHQQ7sg6B7ctwlbUmkssQSlUQeRkO8oHBO+rPN38/LdaASlQpkgnM6wWdh46cFAXCjNJ4vRFOOrbbv9qdu78Ae/j3W7Y/LfUTcKs2nDCS1lnXW6DqOMUgp2whdfxf+iu6tYjoMDL2MvhojJQC+G0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0283986214D8D409C19E11E53FCFC81@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f776e0-b661-4e67-7b9f-08d6ce477b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 15:12:52.8714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTAxIGF0IDA5OjI5ICswMDAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3Rl
Og0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBv
cmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IA0KPiBSZWFkaW5nIHRhYmxlIDQtMzAsIGFuZCBpdHMgZm9vdG5vdGVzLCBvZiB0aGUg
UVVJQ0MgRW5naW5lIEJsb2NrDQo+IFJlZmVyZW5jZSBNYW51YWwgc2hvd3MgdGhhdCB0aGUgc2V0
IG9mIHNudW0gX3ZhbHVlc18gaXMgbm90DQo+IG5lY2Vzc2FyaWx5IGp1c3QgYSBmdW5jdGlvbiBv
ZiB0aGUgX251bWJlcl8gb2Ygc251bXMsIGFzIGdpdmVuIGluIHRoZQ0KPiBmc2wscWUtbnVtLXNu
dW1zIHByb3BlcnR5Lg0KPiANCj4gQXMgYW4gYWx0ZXJuYXRpdmUsIHRvIG1ha2UgaXQgZWFzaWVy
IHRvIGFkZCBzdXBwb3J0IGZvciBvdGhlciB2YXJpYW50cw0KPiBvZiB0aGUgUVVJQ0MgZW5naW5l
IElQLCB0aGlzIGludHJvZHVjZXMgYSBuZXcgYmluZGluZyBmc2wscWUtc251bXMsDQo+IHdoaWNo
IGF1dG9tYXRpY2FsbHkgZW5jb2RlcyBib3RoIHRoZSBudW1iZXIgb2Ygc251bXMgYW5kIHRoZSBh
Y3R1YWwNCj4gdmFsdWVzIHRvIHVzZS4NCj4gDQo+IEZvciBleGFtcGxlLCBmb3IgdGhlIE1QQzgz
MDksIG9uZSB3b3VsZCBzcGVjaWZ5IHRoZSBwcm9wZXJ0eSBhcw0KPiANCj4gICAgICAgICAgICAg
ICAgZnNsLHFlLXNudW1zID0gL2JpdHMvIDggPA0KPiAgICAgICAgICAgICAgICAgICAgICAgIDB4
ODggMHg4OSAweDk4IDB4OTkgMHhhOCAweGE5IDB4YjggMHhiOQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgIDB4YzggMHhjOSAweGQ4IDB4ZDkgMHhlOCAweGU5PjsNCg0KSSB0aGluayB5b3UgbmVl
ZCBhZGQgdGhpcyBleGFtcGxlIHRvIHRoZSBxZS50eHQgZG9jIGl0c2VsZnQuIEJUVywgd2hhdCBp
cyAvYml0cy8gPw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFzbXVzIFZpbGxlbW9lcyA8cmFzbXVz
LnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvYy9mc2wvY3BtX3FlL3FlLnR4dCB8IDggKysrKysrKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2ZzbC9jcG1fcWUvcWUudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9mc2wvY3BtX3FlL3FlLnR4
dA0KPiBpbmRleCBkN2FmYWZmNWZhZmYuLjA1ZjVmNDg1NTYyYSAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9mc2wvY3BtX3FlL3FlLnR4dA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2ZzbC9jcG1fcWUvcWUu
dHh0DQo+IEBAIC0xOCw3ICsxOCw4IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAtIHJlZyA6
IG9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSBkZXZpY2UgcmVnaXN0ZXJzLg0KPiAgLSBidXMtZnJl
cXVlbmN5IDogdGhlIGNsb2NrIGZyZXF1ZW5jeSBmb3IgUVVJQ0MgRW5naW5lLg0KPiAgLSBmc2ws
cWUtbnVtLXJpc2NzOiBkZWZpbmUgaG93IG1hbnkgUklTQyBlbmdpbmVzIHRoZSBRRSBoYXMuDQo+
IC0tIGZzbCxxZS1udW0tc251bXM6IGRlZmluZSBob3cgbWFueSBzZXJpYWwgbnVtYmVyKFNOVU0p
IHRoZSBRRSBjYW4gdXNlIGZvciB0aGUNCj4gKy0gZnNsLHFlLXNudW1zOiBUaGlzIHByb3BlcnR5
IGhhcyB0byBiZSBzcGVjaWZpZWQgYXMgJy9iaXRzLyA4JyB2YWx1ZSwNCj4gKyAgZGVmaW5pbmcg
dGhlIGFycmF5IG9mIHNlcmlhbCBudW1iZXIgKFNOVU0pIHZhbHVlcyBmb3IgdGhlIHZpcnR1YWwN
Cj4gICAgdGhyZWFkcy4NCj4gDQo+ICBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiBAQCAtMzQsNiAr
MzUsMTEgQEAgUmVjb21tZW5kZWQgcHJvcGVydGllcw0KPiAgLSBicmctZnJlcXVlbmN5IDogdGhl
IGludGVybmFsIGNsb2NrIHNvdXJjZSBmcmVxdWVuY3kgZm9yIGJhdWQtcmF0ZQ0KPiAgICBnZW5l
cmF0b3JzIGluIEh6Lg0KPiANCj4gK0RlcHJlY2F0ZWQgcHJvcGVydGllcw0KPiArLSBmc2wscWUt
bnVtLXNudW1zOiBkZWZpbmUgaG93IG1hbnkgc2VyaWFsIG51bWJlcihTTlVNKSB0aGUgUUUgY2Fu
IHVzZQ0KPiArICBmb3IgdGhlIHRocmVhZHMuIFVzZSBmc2wscWUtc251bXMgaW5zdGVhZCB0byBu
b3Qgb25seSBzcGVjaWZ5IHRoZQ0KPiArICBudW1iZXIgb2Ygc251bXMsIGJ1dCBhbHNvIHRoZWly
IHZhbHVlcy4NCj4gKw0KPiAgRXhhbXBsZToNCj4gICAgICAgcWVAZTAxMDAwMDAgew0KPiAgICAg
ICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtLQ0KPiAyLjIwLjENCj4gDQoNCg==
