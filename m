Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01FBC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB3D20717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0sK1oRXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfE1DTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 23:19:09 -0400
Received: from mail-eopbgr770082.outbound.protection.outlook.com ([40.107.77.82]:37508
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727342AbfE1DTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 23:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A1j82J7PFmwaO0+ezdQpVSKncfgXFLaJF+ikHUFa9A=;
 b=0sK1oRXPnhNhvx6GyoReN4lTObPah+QQU95qzh//nPGpI8OrZx4TlJ9xRNkuIeOfTU3p4fqSapR6CM5K12aSkbYdAAxWQCtmqaU/YfzVWzGGQgJEkMFufR1vFbOfHm0B2BUejAURgarI1OQDePaL/WUZTuimDRanB2NLxwQwilo=
Received: from MN2PR12MB2910.namprd12.prod.outlook.com (20.179.81.219) by
 MN2PR12MB4015.namprd12.prod.outlook.com (10.255.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Tue, 28 May 2019 03:17:24 +0000
Received: from MN2PR12MB2910.namprd12.prod.outlook.com
 ([fe80::385d:9453:a16d:3964]) by MN2PR12MB2910.namprd12.prod.outlook.com
 ([fe80::385d:9453:a16d:3964%6]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 03:17:24 +0000
From:   "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        =?utf-8?B?THVpcyBDbMOhdWRpbyBHb27Dp2FsdmVz?= <lclaudio@redhat.com>
Subject: RE: [PATCH 25/44] tools headers UAPI: Sync drm/drm.h with the kernel
Thread-Topic: [PATCH 25/44] tools headers UAPI: Sync drm/drm.h with the kernel
Thread-Index: AQHVFN0U1cnf5T55iEWbm+IE8PPdtaZ/3Z2Q
Date:   Tue, 28 May 2019 03:17:24 +0000
Message-ID: <MN2PR12MB291084F771AC4462BD31AE39B41E0@MN2PR12MB2910.namprd12.prod.outlook.com>
References: <20190527223730.11474-1-acme@kernel.org>
 <20190527223730.11474-26-acme@kernel.org>
In-Reply-To: <20190527223730.11474-26-acme@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a3065d5-9dd1-46c9-c7c7-08d6e31b014f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB4015;
x-ms-traffictypediagnostic: MN2PR12MB4015:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR12MB40157E3AF710CE9932E30B7BB41E0@MN2PR12MB4015.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(376002)(396003)(13464003)(189003)(199004)(76176011)(102836004)(9686003)(14454004)(7736002)(305945005)(6306002)(7696005)(6506007)(3846002)(53546011)(25786009)(6116002)(8676002)(81156014)(81166006)(73956011)(256004)(76116006)(8936002)(66446008)(64756008)(110136005)(66556008)(66476007)(66946007)(6436002)(54906003)(99286004)(55016002)(33656002)(229853002)(316002)(486006)(446003)(476003)(11346002)(68736007)(478600001)(74316002)(966005)(72206003)(5660300002)(6246003)(7416002)(71190400001)(4326008)(53936002)(52536014)(86362001)(71200400001)(66066001)(2906002)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4015;H:MN2PR12MB2910.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IU/5SPMeNeEaMuqebVQNUIjt9Z4FNwDvpkfng2PoGftMkRVq/T1mDlwjYGR5RTGqxpqlXNIEBlwmy8z5a6/hk3mkCNrjavC9eBuoY3uWr7RhEahQZF0seoAvXFjrcq30ZXJvVpWjGfKWggtQd5lu+1xwPJoOfDHWbxbKmqTCAJ5zWJMCU3iI9wJZ0DguInuiGsRTEexdTpXVOnZqYqpmWYN5R9w7tNBQHqwAwRvp21P+KeqBRI2a2kR5Xggbd0cYVhOQ0n/F9uAks4D4dpMrPpBGFiYucxA2uqmLfDJJbu468x7ShDsae6bNo8AJBXg0IopS4hAq1c+gpt3ifBXM1Qf5SfmjtYSKxdoRQn6CIoh4BNPEXnuZ2la2KGQqwLromeHngPlU0lSf09aTubKGuSHGVrak12Nv3LlW5dKHdLM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3065d5-9dd1-46c9-c7c7-08d6e31b014f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 03:17:24.3432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhoucm1@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hpY2ggYnJhbmNoIGFyZSB5b3UgYmFzZWQ/IFNlZW1zIGFsbCB0aGUgc3RydWN0cyBhcmUgYWxy
ZWFkeSBzeW5jZWQgZXhjZXB0IERSTV9DQVBfU1lOQ09CSl9USU1FTElORS4NCg0KLURhdmlkDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gPGFjbWVAa2VybmVsLm9yZz4gDQpTZW50OiBUdWVzZGF5LCBNYXkgMjgsIDIwMTkgNjozNyBB
TQ0KVG86IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPjsgVGhvbWFzIEdsZWl4bmVyIDx0
Z2x4QGxpbnV0cm9uaXguZGU+DQpDYzogSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgTmFt
aHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgQ2xhcmsgV2lsbGlhbXMgPHdpbGxpYW1z
QHJlZGhhdC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQHJlZGhh
dC5jb20+OyBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEJyZW5kYW4g
R3JlZ2cgPGJyZW5kYW4uZC5ncmVnZ0BnbWFpbC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpIDxEYXZpZDEuWmhv
dUBhbWQuY29tPjsgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT47IExpb25lbCBMYW5k
d2VybGluIDxsaW9uZWwuZy5sYW5kd2VybGluQGludGVsLmNvbT47IEx1aXMgQ2zDoXVkaW8gR29u
w6dhbHZlcyA8bGNsYXVkaW9AcmVkaGF0LmNvbT4NClN1YmplY3Q6IFtQQVRDSCAyNS80NF0gdG9v
bHMgaGVhZGVycyBVQVBJOiBTeW5jIGRybS9kcm0uaCB3aXRoIHRoZSBrZXJuZWwNCg0KRnJvbTog
QXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQHJlZGhhdC5jb20+DQoNClRvIHBpY2sgdXAg
dGhlIGNoYW5nZXMgaW4gdGhlc2UgY3NldHM6DQoNCiAgMDYwY2ViYjIwY2RiICgiZHJtOiBpbnRy
b2R1Y2UgYSBjYXBhYmlsaXR5IGZsYWcgZm9yIHN5bmNvYmogdGltZWxpbmUgc3VwcG9ydCIpDQog
IDUwZDFlYmVmNzllZiAoImRybS9zeW5jb2JqOiBhZGQgdGltZWxpbmUgc2lnbmFsIGlvY3RsIGZv
ciBzeW5jb2JqIHY1IikNCiAgZWE1Njk5MTBjYmFiICgiZHJtL3N5bmNvYmo6IGFkZCB0cmFuc2l0
aW9uIGlvdGNscyBiZXR3ZWVuIGJpbmFyeSBhbmQgdGltZWxpbmUgdjIiKQ0KICAyN2I1NzVhOWFh
MmYgKCJkcm0vc3luY29iajogYWRkIHRpbWVsaW5lIHBheWxvYWQgcXVlcnkgaW9jdGwgdjYiKQ0K
ICAwMWQ2YzM1NzgzNzkgKCJkcm0vc3luY29iajogYWRkIHN1cHBvcnQgZm9yIHRpbWVsaW5lIHBv
aW50IHdhaXQgdjgiKQ0KICA3ODMxOTVlYzFjYWQgKCJkcm0vc3luY29iajogZGlzYWJsZSB0aGUg
dGltZWxpbmUgVUFQSSBmb3Igbm93IHYyIikNCiAgNDgxOTdiYzU2NGM3ICgiZHJtOiBhZGQgc3lu
Y29iaiB0aW1lbGluZSBzdXBwb3J0IHY5IikNCg0KV2hpY2ggYXV0b21hZ2ljYWxseSByZXN1bHRz
IGluIHRoZSBmb2xsb3dpbmcgbmV3IGlvY3RscyBiZWluZyByZWNvZ25pemVkIGJ5IHRoZSAncGVy
ZiB0cmFjZScgaW9jdGwgY21kIGFyZyBiZWF1dGlmaWVyOg0KDQogICQgdG9vbHMvcGVyZi90cmFj
ZS9iZWF1dHkvZHJtX2lvY3RsLnNoID4gL3RtcC9iZWZvcmUNCiAgJCBjcCBpbmNsdWRlL3VhcGkv
ZHJtL2RybS5oIHRvb2xzL2luY2x1ZGUvdWFwaS9kcm0vZHJtLmgNCiAgJCB0b29scy9wZXJmL3Ry
YWNlL2JlYXV0eS9kcm1faW9jdGwuc2ggPiAvdG1wL2FmdGVyDQogICQgZGlmZiAtdSAvdG1wL2Jl
Zm9yZSAvdG1wL2FmdGVyDQogIC0tLSAvdG1wL2JlZm9yZQkyMDE5LTA1LTIyIDEwOjI1OjMxLjQ0
MzE1MTE4MiAtMDMwMA0KICArKysgL3RtcC9hZnRlcgkyMDE5LTA1LTIyIDEwOjI1OjQ2LjQ0OTM1
NDgxOSAtMDMwMA0KICBAQCAtMTAzLDYgKzEwMywxMCBAQA0KICAgCVsweEM3XSA9ICJNT0RFX0xJ
U1RfTEVTU0VFUyIsDQogICAJWzB4QzhdID0gIk1PREVfR0VUX0xFQVNFIiwNCiAgIAlbMHhDOV0g
PSAiTU9ERV9SRVZPS0VfTEVBU0UiLA0KICArCVsweENBXSA9ICJTWU5DT0JKX1RJTUVMSU5FX1dB
SVQiLA0KICArCVsweENCXSA9ICJTWU5DT0JKX1FVRVJZIiwNCiAgKwlbMHhDQ10gPSAiU1lOQ09C
Sl9UUkFOU0ZFUiIsDQogICsJWzB4Q0RdID0gIlNZTkNPQkpfVElNRUxJTkVfU0lHTkFMIiwNCiAg
IAlbRFJNX0NPTU1BTkRfQkFTRSArIDB4MDBdID0gIkk5MTVfSU5JVCIsDQogICAJW0RSTV9DT01N
QU5EX0JBU0UgKyAweDAxXSA9ICJJOTE1X0ZMVVNIIiwNCiAgIAlbRFJNX0NPTU1BTkRfQkFTRSAr
IDB4MDJdID0gIkk5MTVfRkxJUCIsDQogICAgJA0KDQpJLmUuIHRoZSBzdHJhY2UgbGlrZSByYXdf
dHJhY2Vwb2ludDpzeXNfZW50ZXIgaGFuZGxlciBpbiAncGVyZiB0cmFjZScNCndpbGwgZ2V0IHRo
ZSBjbWQgaW50ZWdlciB2YWx1ZSBhbmQgbWFwIGl0IHRvIHRoZSBzdHJpbmcuDQoNCkF0IHNvbWUg
cG9pbnQgaXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIHRyYW5zbGF0ZSBmcm9tIHN0cmluZyB0byBp
bnRlZ2VyIGFuZCB1c2UgdG8gZmlsdGVyIHVzaW5nIGV4cHJlc3Npb25zIHN1Y2ggYXM6DQoNCiAg
ICMgcGVyZiB0cmFjZSAtZSBpb2N0bC9jbWQ9PURSTV9JT0NUTF9TWU5DT0JKKi8NCg0KT3Igc29t
ZSBtb3JlIHN1aXRhYmxlIHN5bnRheCB0byBleHByZXNzIHRoYXQgb25seSB0aGVzZSBpb2N0bHMg
d2hlbiBhY3Rpbmcgb24gRFJNIGZkcyBzaG91bGQgYmUgc2hvd24uDQoNCkNjOiBBZHJpYW4gSHVu
dGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCkNjOiBCcmVuZGFuIEdyZWdnIDxicmVuZGFu
LmQuZ3JlZ2dAZ21haWwuY29tPg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4NCkNjOiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPg0KQ2M6
IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+DQpDYzogSmlyaSBPbHNhIDxqb2xzYUBr
ZXJuZWwub3JnPg0KQ2M6IExpb25lbCBMYW5kd2VybGluIDxsaW9uZWwuZy5sYW5kd2VybGluQGlu
dGVsLmNvbT4NCkNjOiBMdWlzIENsw6F1ZGlvIEdvbsOnYWx2ZXMgPGxjbGF1ZGlvQHJlZGhhdC5j
b20+DQpDYzogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KTGluazogaHR0cHM6
Ly9sa21sLmtlcm5lbC5vcmcvbi90aXAtanJjOW9ndzMzdzR6Z3FjM3B1N28xbDNnQGdpdC5rZXJu
ZWwub3JnDQpTaWduZWQtb2ZmLWJ5OiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAcmVk
aGF0LmNvbT4NCi0tLQ0KIHRvb2xzL2luY2x1ZGUvdWFwaS9kcm0vZHJtLmggfCAzNyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvaW5jbHVkZS91YXBpL2RybS9kcm0uaCBiL3Rv
b2xzL2luY2x1ZGUvdWFwaS9kcm0vZHJtLmggaW5kZXggMzAwZjMzNjYzM2YyLi42NjFkNzNmOWE5
MTkgMTAwNjQ0DQotLS0gYS90b29scy9pbmNsdWRlL3VhcGkvZHJtL2RybS5oDQorKysgYi90b29s
cy9pbmNsdWRlL3VhcGkvZHJtL2RybS5oDQpAQCAtNjQ5LDYgKzY0OSw3IEBAIHN0cnVjdCBkcm1f
Z2VtX29wZW4gew0KICNkZWZpbmUgRFJNX0NBUF9QQUdFX0ZMSVBfVEFSR0VUCTB4MTENCiAjZGVm
aW5lIERSTV9DQVBfQ1JUQ19JTl9WQkxBTktfRVZFTlQJMHgxMg0KICNkZWZpbmUgRFJNX0NBUF9T
WU5DT0JKCQkweDEzDQorI2RlZmluZSBEUk1fQ0FQX1NZTkNPQkpfVElNRUxJTkUJMHgxNA0KIA0K
IC8qKiBEUk1fSU9DVExfR0VUX0NBUCBpb2N0bCBhcmd1bWVudCB0eXBlICovICBzdHJ1Y3QgZHJt
X2dldF9jYXAgeyBAQCAtNzM1LDggKzczNiwxOCBAQCBzdHJ1Y3QgZHJtX3N5bmNvYmpfaGFuZGxl
IHsNCiAJX191MzIgcGFkOw0KIH07DQogDQorc3RydWN0IGRybV9zeW5jb2JqX3RyYW5zZmVyIHsN
CisJX191MzIgc3JjX2hhbmRsZTsNCisJX191MzIgZHN0X2hhbmRsZTsNCisJX191NjQgc3JjX3Bv
aW50Ow0KKwlfX3U2NCBkc3RfcG9pbnQ7DQorCV9fdTMyIGZsYWdzOw0KKwlfX3UzMiBwYWQ7DQor
fTsNCisNCiAjZGVmaW5lIERSTV9TWU5DT0JKX1dBSVRfRkxBR1NfV0FJVF9BTEwgKDEgPDwgMCkg
ICNkZWZpbmUgRFJNX1NZTkNPQkpfV0FJVF9GTEFHU19XQUlUX0ZPUl9TVUJNSVQgKDEgPDwgMSkN
CisjZGVmaW5lIERSTV9TWU5DT0JKX1dBSVRfRkxBR1NfV0FJVF9BVkFJTEFCTEUgKDEgPDwgMikg
Lyogd2FpdCBmb3IgdGltZSANCitwb2ludCB0byBiZWNvbWUgYXZhaWxhYmxlICovDQogc3RydWN0
IGRybV9zeW5jb2JqX3dhaXQgew0KIAlfX3U2NCBoYW5kbGVzOw0KIAkvKiBhYnNvbHV0ZSB0aW1l
b3V0ICovDQpAQCAtNzQ3LDEyICs3NTgsMzMgQEAgc3RydWN0IGRybV9zeW5jb2JqX3dhaXQgew0K
IAlfX3UzMiBwYWQ7DQogfTsNCiANCitzdHJ1Y3QgZHJtX3N5bmNvYmpfdGltZWxpbmVfd2FpdCB7
DQorCV9fdTY0IGhhbmRsZXM7DQorCS8qIHdhaXQgb24gc3BlY2lmaWMgdGltZWxpbmUgcG9pbnQg
Zm9yIGV2ZXJ5IGhhbmRsZXMqLw0KKwlfX3U2NCBwb2ludHM7DQorCS8qIGFic29sdXRlIHRpbWVv
dXQgKi8NCisJX19zNjQgdGltZW91dF9uc2VjOw0KKwlfX3UzMiBjb3VudF9oYW5kbGVzOw0KKwlf
X3UzMiBmbGFnczsNCisJX191MzIgZmlyc3Rfc2lnbmFsZWQ7IC8qIG9ubHkgdmFsaWQgd2hlbiBu
b3Qgd2FpdGluZyBhbGwgKi8NCisJX191MzIgcGFkOw0KK307DQorDQorDQogc3RydWN0IGRybV9z
eW5jb2JqX2FycmF5IHsNCiAJX191NjQgaGFuZGxlczsNCiAJX191MzIgY291bnRfaGFuZGxlczsN
CiAJX191MzIgcGFkOw0KIH07DQogDQorc3RydWN0IGRybV9zeW5jb2JqX3RpbWVsaW5lX2FycmF5
IHsNCisJX191NjQgaGFuZGxlczsNCisJX191NjQgcG9pbnRzOw0KKwlfX3UzMiBjb3VudF9oYW5k
bGVzOw0KKwlfX3UzMiBwYWQ7DQorfTsNCisNCisNCiAvKiBRdWVyeSBjdXJyZW50IHNjYW5vdXQg
c2VxdWVuY2UgbnVtYmVyICovICBzdHJ1Y3QgZHJtX2NydGNfZ2V0X3NlcXVlbmNlIHsNCiAJX191
MzIgY3J0Y19pZDsJCS8qIHJlcXVlc3RlZCBjcnRjX2lkICovDQpAQCAtOTA5LDYgKzk0MSwxMSBA
QCBleHRlcm4gIkMiIHsNCiAjZGVmaW5lIERSTV9JT0NUTF9NT0RFX0dFVF9MRUFTRQlEUk1fSU9X
UigweEM4LCBzdHJ1Y3QgZHJtX21vZGVfZ2V0X2xlYXNlKQ0KICNkZWZpbmUgRFJNX0lPQ1RMX01P
REVfUkVWT0tFX0xFQVNFCURSTV9JT1dSKDB4QzksIHN0cnVjdCBkcm1fbW9kZV9yZXZva2VfbGVh
c2UpDQogDQorI2RlZmluZSBEUk1fSU9DVExfU1lOQ09CSl9USU1FTElORV9XQUlUCURSTV9JT1dS
KDB4Q0EsIHN0cnVjdCBkcm1fc3luY29ial90aW1lbGluZV93YWl0KQ0KKyNkZWZpbmUgRFJNX0lP
Q1RMX1NZTkNPQkpfUVVFUlkJCURSTV9JT1dSKDB4Q0IsIHN0cnVjdCBkcm1fc3luY29ial90aW1l
bGluZV9hcnJheSkNCisjZGVmaW5lIERSTV9JT0NUTF9TWU5DT0JKX1RSQU5TRkVSCURSTV9JT1dS
KDB4Q0MsIHN0cnVjdCBkcm1fc3luY29ial90cmFuc2ZlcikNCisjZGVmaW5lIERSTV9JT0NUTF9T
WU5DT0JKX1RJTUVMSU5FX1NJR05BTAlEUk1fSU9XUigweENELCBzdHJ1Y3QgZHJtX3N5bmNvYmpf
dGltZWxpbmVfYXJyYXkpDQorDQogLyoqDQogICogRGV2aWNlIHNwZWNpZmljIGlvY3RscyBzaG91
bGQgb25seSBiZSBpbiB0aGVpciByZXNwZWN0aXZlIGhlYWRlcnMNCiAgKiBUaGUgZGV2aWNlIHNw
ZWNpZmljIGlvY3RsIHJhbmdlIGlzIGZyb20gMHg0MCB0byAweDlmLg0KLS0NCjIuMjAuMQ0KDQo=
