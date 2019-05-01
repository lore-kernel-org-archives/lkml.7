Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACBC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E1021734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SD99WHck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfEAEQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:16:37 -0400
Received: from mail-eopbgr780054.outbound.protection.outlook.com ([40.107.78.54]:40257
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfEAEQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqD7+8LcavM2i8g5afutyzSWImyt/7p5pyneybu02o4=;
 b=SD99WHckovMRfbEv5m0N84c+ia2WM6Fd7jc/oddI10okanH76K8mmIIKgIdRirG6gUl+JsZS/dbzjYXXieo+Wkfm64jRViEXo+MtQZ6JAwigfPbnVekpNh9rhXx8HFgwOG4eJ3TLxw7b86O0DM/do+PpJRig0K2biRMgwKrrQ/k=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5142.namprd05.prod.outlook.com (20.177.231.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.8; Wed, 1 May 2019 04:16:32 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098%7]) with mapi id 15.20.1856.008; Wed, 1 May 2019
 04:16:32 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [tip:x86/mm 14/35] kernel/trace/bpf_trace.c:179:16: error:
 implicit declaration of function 'nmi_uaccess_okay'; did you mean
 '__access_ok'?
Thread-Topic: [tip:x86/mm 14/35] kernel/trace/bpf_trace.c:179:16: error:
 implicit declaration of function 'nmi_uaccess_okay'; did you mean
 '__access_ok'?
Thread-Index: AQHU/7LLyaDfyahkm0G3mvJEuL6NTKZVqemA
Date:   Wed, 1 May 2019 04:16:32 +0000
Message-ID: <C72477E3-B055-4985-B6E7-56DB719AB155@vmware.com>
References: <201905010844.3Y1Kne3b%lkp@intel.com>
In-Reply-To: <201905010844.3Y1Kne3b%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 827b7740-9953-4d92-a4e7-08d6cdebcada
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5142;
x-ms-traffictypediagnostic: BYAPR05MB5142:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR05MB51423B16128F7D951805C7D6D03B0@BYAPR05MB5142.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:22;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(446003)(36756003)(102836004)(316002)(26005)(68736007)(186003)(54906003)(71200400001)(6506007)(25786009)(53546011)(5024004)(256004)(14444005)(99286004)(2616005)(476003)(11346002)(33656002)(83716004)(486006)(71190400001)(66066001)(76176011)(4326008)(305945005)(53936002)(5660300002)(7736002)(82746002)(478600001)(6916009)(6306002)(6512007)(86362001)(3846002)(2906002)(6116002)(66556008)(6486002)(229853002)(66476007)(64756008)(66446008)(6436002)(14454004)(8936002)(76116006)(73956011)(66946007)(45080400002)(6246003)(966005)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5142;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DtSpQMo6XE/vUiB+DpiislEdOIzi+ZgIWuHTN+VaPs/9wo7VqxrnXTpzUqcuWvIZEIAwyVoO6mpKNn6zHD5hq9wNsQVGI/Hg2DuYU8tfhZ2U4VlzoxMc/nQWs0X+Wp0Zy6Q10smGOkTe8vc4Lu60dbo7VwFUHYCD5NTg8F9aUsURZ3m3ZrC6s8uTfIskzsC9iEyk0YKxgD4rRYogJlOQx98hi3ihS3wH9WxbkXPZp8zSpOwi4l88uODKDybGXw/SRGuEbFPjNczV1Sy7mVd2aLCez4q2rxs8ZDE3kWDfBS6R9oBC4FkZo7Es6JGnkn82IindvyRqbWPccgTr+G5MddJPe9CR7C+Lv3rCR0ZH11WeVECypSkNPD/IX+lUtJ5y+aKkTi0Ge4GFmrObCkruCHSb1XTIu/foiCT6zuyT/Kg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A0026E649FB024589E43F4E190661E5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827b7740-9953-4d92-a4e7-08d6cdebcada
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 04:16:32.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMzAsIDIwMTksIGF0IDU6MTMgUE0sIGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPiB3cm90ZToNCj4gDQo+IHRyZWU6ICAgaHR0cHM6Ly9uYW0wNC5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0Lmtlcm5lbC5vcmclMkZw
dWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRnRpcCUyRnRpcC5naXQmYW1wO2RhdGE9
MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3QzhhMzgwYjk0NTNmMjQ5ZmQ5MjRhMDhkNmNk
YzllOGNkJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjky
MjY2NDQ4MzIwMTQzMiZhbXA7c2RhdGE9TldoVnRpTFo0bDdMdkxLc05ORHJSNEE4UGxwWEllSDF0
RXJmRno2RW1jTSUzRCZhbXA7cmVzZXJ2ZWQ9MCB4ODYvbW0NCj4gaGVhZDogICAzOTUwNzQ2ZDlk
OGVmOTgxYzFjYjg0MjM4NGUwZTg2ZThkMWFhZDc2DQo+IGNvbW1pdDogYzdiNmYyOWI2MjU3NTMy
NzkyZmM3MjJiNjhmY2MwZTAwYjVhODU2YyBbMTQvMzVdIGJwZjogRmFpbCBicGZfcHJvYmVfd3Jp
dGVfdXNlcigpIHdoaWxlIG1tIGlzIHN3aXRjaGVkDQo+IGNvbmZpZzogczM5MC1kZWZjb25maWcg
KGF0dGFjaGVkIGFzIC5jb25maWcpDQo+IGNvbXBpbGVyOiBzMzkweC1saW51eC1nbnUtZ2NjIChE
ZWJpYW4gNy4yLjAtMTEpIDcuMi4wDQo+IHJlcHJvZHVjZToNCj4gICAgICAgIHdnZXQgaHR0cHM6
Ly9uYW0wNC5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSUyRmludGVsJTJGbGtwLXRlc3RzJTJGbWFzdGVy
JTJGc2JpbiUyRm1ha2UuY3Jvc3MmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNv
bSU3QzhhMzgwYjk0NTNmMjQ5ZmQ5MjRhMDhkNmNkYzllOGNkJTdDYjM5MTM4Y2EzY2VlNGI0YWE0
ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjkyMjY2NDQ4MzIwMTQzMiZhbXA7c2RhdGE9U20l
MkZmakw3VXFFVHY3SEVFcjMyTTJ2M1htR3dkQUQxMFd5cjhabW9RWDUwJTNEJmFtcDtyZXNlcnZl
ZD0wIC1PIH4vYmluL21ha2UuY3Jvc3MNCj4gICAgICAgIGNobW9kICt4IH4vYmluL21ha2UuY3Jv
c3MNCj4gICAgICAgIGdpdCBjaGVja291dCBjN2I2ZjI5YjYyNTc1MzI3OTJmYzcyMmI2OGZjYzBl
MDBiNWE4NTZjDQo+ICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXgg
YnVpbGQgdHJlZQ0KPiAgICAgICAgR0NDX1ZFUlNJT049Ny4yLjAgbWFrZS5jcm9zcyBBUkNIPXMz
OTAgDQo+IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFn
DQo+IFJlcG9ydGVkLWJ5OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+
IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ICAgSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIGluY2x1ZGUvbGludXgva2VybmVsLmg6MTE6MCwNCj4gICAgICAgICAgICAg
ICAgICAgIGZyb20ga2VybmVsL3RyYWNlL2JwZl90cmFjZS5jOjU6DQo+ICAga2VybmVsL3RyYWNl
L2JwZl90cmFjZS5jOiBJbiBmdW5jdGlvbiAnX19fX2JwZl9wcm9iZV93cml0ZV91c2VyJzoNCj4+
PiBrZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmM6MTc5OjE2OiBlcnJvcjogaW1wbGljaXQgZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24gJ25taV91YWNjZXNzX29rYXknOyBkaWQgeW91IG1lYW4gJ19fYWNj
ZXNzX29rJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+ICAgICBp
ZiAodW5saWtlbHkoIW5taV91YWNjZXNzX29rYXkoKSkpDQoNClNvIHMzOTAgZG9lcyBub3QgdXNl
IHRoZSBnZW5lcmljIFRMQiBnYXRoZXIgYXJjaGl0ZWN0dXJlLCB3aGljaCB0cmlnZ2VyZWQNCnRo
ZSBwcm9ibGVtLg0KDQpVbmZvcnR1bmF0ZWx5LCByZXByb2R1Y2luZyB0aGUgZmFpbGVkIGJ1aWxk
IGNhdXNlZCAob3RoZXIpIGVycm9ycy4gQnV0DQp3b3JzZSwgZml4aW5nIHRoaXMgaXNzdWUg4oCc
Y2xlYW5seeKAnSBpcyBoYXJkIGR1ZSB0byB0aGUgZGVwZW5kZW5jaWVzIGJldHdlZW4NCnRoZSBo
ZWFkZXIgZmlsZXMuDQoNClRoZSBiZXN0IEkgbWFuYWdlZCB0byBkbyB3aXRob3V0IG92ZXItY29t
cGxpY2F0aW5nIHRoZSBzb2x1dGlvbiBpcyB0aGUNCmZvbGxvd2luZywgd2hpY2ggbWlnaHQgbm90
IGJlIHN1cGVyIGNsZWFuLiBMZXQgbWUga25vdyB3aGV0aGVyIHRvIHN1Ym1pdCBhDQpzZXBhcmF0
ZSBwYXRjaCAob24gdG9wIG9yIGluc3RlYWQgb2YgdGhlIGN1cnJlbnQgb25lKS4NCg0KLS0gPjgg
LS0NCg0KRnJvbSBiYzYwZGZjNDE1ZjllY2MwMTc3MWIzODhkYWNkNDFhZGM5NzY5MjljIE1vbiBT
ZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4N
CkRhdGU6IFR1ZSwgMzAgQXByIDIwMTkgMTM6NDg6NDggLTA3MDANClN1YmplY3Q6IFtQQVRDSF0g
bW0vdGxiOiBGaXggIlByb3ZpZGUgZGVmYXVsdCBubWlfdWFjY2Vzc19va2F5KCkiDQoNClNpZ25l
ZC1vZmYtYnk6IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQotLS0NCiBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS90bGJmbHVzaC5oIHwgIDQgKy0tLQ0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Vh
Y2Nlc3MuaCAgfCAgMiArKw0KIGluY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmggICAgICAgfCAgOSAt
LS0tLS0tLS0NCiBpbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaCAgICAgICAgIHwgMTIgKysrKysrKysr
KysrDQogNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmggYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQppbmRleCBkZWUzNzU4MzE5NjIuLjc2NWU2YjAxZWVm
ZCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCkBAIC0yNDksNyArMjQ5LDcgQEAgREVDTEFS
RV9QRVJfQ1BVX1NIQVJFRF9BTElHTkVEKHN0cnVjdCB0bGJfc3RhdGUsIGNwdV90bGJzdGF0ZSk7
DQogICogaW50ZXJydXB0ZWQgc29tZSBrZXJuZWwgY29kZSB0aGF0IHdhcyB0ZW1wb3JhcmlseSB1
c2luZyBhDQogICogZGlmZmVyZW50IG1tLg0KICAqLw0KLXN0YXRpYyBpbmxpbmUgYm9vbCBubWlf
dWFjY2Vzc19va2F5KHZvaWQpDQorc3RhdGljIGlubGluZSBib29sIGFyY2hfbm1pX3VhY2Nlc3Nf
b2theSh2b2lkKQ0KIHsNCiAJc3RydWN0IG1tX3N0cnVjdCAqbG9hZGVkX21tID0gdGhpc19jcHVf
cmVhZChjcHVfdGxic3RhdGUubG9hZGVkX21tKTsNCiAJc3RydWN0IG1tX3N0cnVjdCAqY3VycmVu
dF9tbSA9IGN1cnJlbnQtPm1tOw0KQEAgLTI3NCw4ICsyNzQsNiBAQCBzdGF0aWMgaW5saW5lIGJv
b2wgbm1pX3VhY2Nlc3Nfb2theSh2b2lkKQ0KIAlyZXR1cm4gdHJ1ZTsNCiB9DQogDQotI2RlZmlu
ZSBubWlfdWFjY2Vzc19va2F5IG5taV91YWNjZXNzX29rYXkNCi0NCiAvKiBJbml0aWFsaXplIGNy
NCBzaGFkb3cgZm9yIHRoaXMgQ1BVLiAqLw0KIHN0YXRpYyBpbmxpbmUgdm9pZCBjcjRfaW5pdF9z
aGFkb3codm9pZCkNCiB7DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vz
cy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oDQppbmRleCAyMmJhNjgzYWZkYzIu
LmQ0YjQ4N2QyNDQxYyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3Mu
aA0KKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oDQpAQCAtNjk4LDYgKzY5OCw4
IEBAIGV4dGVybiBzdHJ1Y3QgbW92c2xfbWFzayB7DQogICovDQogI2RlZmluZSBfX2NvcHlfZnJv
bV91c2VyX25taSBfX2NvcHlfZnJvbV91c2VyX2luYXRvbWljDQogDQorI2RlZmluZSBubWlfdWFj
Y2Vzc19va2F5KCkgYXJjaF9ubWlfdWFjY2Vzc19va2F5KCkNCisNCiAvKg0KICAqIFRoZSAidW5z
YWZlIiB1c2VyIGFjY2Vzc2VzIGFyZW4ndCByZWFsbHkgInVuc2FmZSIsIGJ1dCB0aGUgbmFtaW5n
DQogICogaXMgYSBiaWcgZmF0IHdhcm5pbmc6IHlvdSBoYXZlIHRvIG5vdCBvbmx5IGRvIHRoZSBh
Y2Nlc3Nfb2soKQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmggYi9pbmNs
dWRlL2FzbS1nZW5lcmljL3RsYi5oDQppbmRleCA0ODBlNWIyYTU3NDguLmI5ZWRjNzYwOGQ5MCAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmgNCisrKyBiL2luY2x1ZGUvYXNt
LWdlbmVyaWMvdGxiLmgNCkBAIC0yMSwxNSArMjEsNiBAQA0KICNpbmNsdWRlIDxhc20vdGxiZmx1
c2guaD4NCiAjaW5jbHVkZSA8YXNtL2NhY2hlZmx1c2guaD4NCiANCi0vKg0KLSAqIEJsaW5kbHkg
YWNjZXNzaW5nIHVzZXIgbWVtb3J5IGZyb20gTk1JIGNvbnRleHQgY2FuIGJlIGRhbmdlcm91cw0K
LSAqIGlmIHdlJ3JlIGluIHRoZSBtaWRkbGUgb2Ygc3dpdGNoaW5nIHRoZSBjdXJyZW50IHVzZXIg
dGFzayBvciBzd2l0Y2hpbmcNCi0gKiB0aGUgbG9hZGVkIG1tLg0KLSAqLw0KLSNpZm5kZWYgbm1p
X3VhY2Nlc3Nfb2theQ0KLSMgZGVmaW5lIG5taV91YWNjZXNzX29rYXkoKSB0cnVlDQotI2VuZGlm
DQotDQogI2lmZGVmIENPTkZJR19NTVUNCiANCiAvKg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvdWFjY2Vzcy5oIGIvaW5jbHVkZS9saW51eC91YWNjZXNzLmgNCmluZGV4IDJiNzAxMzBhZjU4
NS4uZTJlMTI5NDVkZWFiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC91YWNjZXNzLmgNCisr
KyBiL2luY2x1ZGUvbGludXgvdWFjY2Vzcy5oDQpAQCAtMjgwLDQgKzI4MCwxNiBAQCB2b2lkIF9f
bm9yZXR1cm4gdXNlcmNvcHlfYWJvcnQoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqZGV0
YWlsLA0KIAkJCSAgICAgICB1bnNpZ25lZCBsb25nIGxlbik7DQogI2VuZGlmDQogDQorLyoNCisg
KiBCbGluZGx5IGFjY2Vzc2luZyB1c2VyIG1lbW9yeSBmcm9tIE5NSSBjb250ZXh0IGNhbiBiZSBk
YW5nZXJvdXMgaWYgd2UncmUgaW4NCisgKiB0aGUgbWlkZGxlIG9mIHN3aXRjaGluZyB0aGUgY3Vy
cmVudCB1c2VyIHRhc2sgb3Igc3dpdGNoaW5nIHRoZSBsb2FkZWQgbW0uDQorICogUHJvdmlkZSBh
IGRlZmF1bHQgaW1wbGVtZW50YXRpb24gZm9yIGFyY2hpdGVjdHVyZXMgdGhhdCBkbyBub3QgcHJv
dmlkZSBvbmUuDQorICovDQorI2lmbmRlZiBubWlfdWFjY2Vzc19va2F5DQorc3RhdGljIGlubGlu
ZSBib29sIG5taV91YWNjZXNzX29rYXkodm9pZCkNCit7DQorCXJldHVybiB0cnVlOw0KK30NCisj
ZW5kaWYNCisNCiAjZW5kaWYJCS8qIF9fTElOVVhfVUFDQ0VTU19IX18gKi8NCi0tIA0KMi4xNy4x
DQoNCg==
