Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C99CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE0F218E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wGFtsrG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfDHOM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:12:28 -0400
Received: from mail-eopbgr820047.outbound.protection.outlook.com ([40.107.82.47]:49695
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfDHOMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFSiJO0hR8ae1DIoGnj2xkz4xpeSgrA7AVoxTpdA+dE=;
 b=wGFtsrG3Ei/QNOF9cHRG5hmXUoQNyo8syY/ATCyiK0VLVOZ2lmvlUqhO+c1a964grulS0+3AvVVHRJWvwkwxKBbozQaiZCQPOYKQ/1tNddnKxRR0aecBGfmc3zYJWkZKnY1Iy/P6ir2U2meiLLDdUUrvg/1pZ2/80zVzlRZ60O0=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2781.namprd12.prod.outlook.com (52.135.107.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 14:12:16 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 14:12:16 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH RESEND 1/5] x86/MCE: Make struct mce_banks[] static
Thread-Topic: [PATCH RESEND 1/5] x86/MCE: Make struct mce_banks[] static
Thread-Index: AQHU7hURp8JU2hYgskGwOHdL3M5DZA==
Date:   Mon, 8 Apr 2019 14:12:15 +0000
Message-ID: <20190408141205.12376-2-Yazen.Ghannam@amd.com>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0025.prod.exchangelabs.com (2603:10b6:804:2::35)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f753b24-600b-416e-d133-08d6bc2c33f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2781;
x-ms-traffictypediagnostic: SN6PR12MB2781:
x-microsoft-antispam-prvs: <SN6PR12MB2781BEBF9BC8DA31CB372CADF82C0@SN6PR12MB2781.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(52116002)(25786009)(478600001)(4326008)(6512007)(2501003)(5640700003)(14454004)(76176011)(53936002)(97736004)(14444005)(71200400001)(71190400001)(256004)(50226002)(6486002)(72206003)(6436002)(8936002)(106356001)(105586002)(2351001)(81166006)(1076003)(186003)(81156014)(6916009)(8676002)(6506007)(102836004)(66066001)(5660300002)(386003)(11346002)(486006)(26005)(68736007)(36756003)(2616005)(446003)(7736002)(3846002)(6116002)(316002)(305945005)(99286004)(86362001)(476003)(2906002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2781;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gK6q5hoBXjICsxH4kX0E7aEeTqxDuVFCPoiFBdERhVOxTwr/rqvkCDxjomNnIEzHXQfh/LCSjvxLUIz+aQRlZsFsCCQBHIYnsPcmGHpeemYmL/N4MGTAvPAo8ZqINgFQLqEPpiE8VwGf4RPtOBUYOaT0M+fh1pgRlRfzEM/T9HtaJDOsgqYoJA2fzgpEfJZEM8bUGxZ1cKEnmmMxn3Ulm3Gw3/f5J66KthZBZXFdlIx35olAk1Kw3TySerm23hgHv7JKiGolXsIXy80HE05c/shVaG4VOeOhIfw1r0GUyafbfFaYgX1IbSOhCmNGP85tncJFWgNFzd+DwWgSaHBB6oQ4/TIs9FxLwq0NlE21iA0YKyClkBuyc3ZbsRo2nptwQq14FQhu8tEN8ZDAj49m8rf0g7MsoVBeDPy2Wyu19dc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f753b24-600b-416e-d133-08d6bc2c33f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 14:12:15.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgc3RydWN0
IG1jZV9iYW5rc1tdIGFycmF5IGlzIG9ubHkgdXNlZCBpbiBtY2UvY29yZS5jIHNvIG1vdmUgdGhl
DQpkZWZpbml0aW9uIG9mIHN0cnVjdCBtY2VfYmFuayB0byBtY2UvY29yZS5jIGFuZCBtYWtlIHRo
ZSBhcnJheSBzdGF0aWMuDQoNCkFsc28sIGNoYW5nZSB0aGUgImluaXQiIGZpZWxkIHRvIGJvb2wg
dHlwZS4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQu
Y29tPg0KLS0tDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jICAgICB8IDExICsrKysr
KysrKystDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZXJuYWwuaCB8IDEwIC0tLS0tLS0t
LS0NCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2UvY29yZS5jDQppbmRleCA1ODkyNWU3Y2NiMjcuLjhkMGQxZTg0MjVkYiAx
MDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KKysrIGIvYXJjaC94
ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQpAQCAtNjQsNyArNjQsMTYgQEAgc3RhdGljIERFRklO
RV9NVVRFWChtY2Vfc3lzZnNfbXV0ZXgpOw0KIA0KIERFRklORV9QRVJfQ1BVKHVuc2lnbmVkLCBt
Y2VfZXhjZXB0aW9uX2NvdW50KTsNCiANCi1zdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rcyBfX3Jl
YWRfbW9zdGx5Ow0KKyNkZWZpbmUgQVRUUl9MRU4gICAgICAgICAgICAgICAxNg0KKy8qIE9uZSBv
YmplY3QgZm9yIGVhY2ggTUNFIGJhbmssIHNoYXJlZCBieSBhbGwgQ1BVcyAqLw0KK3N0cnVjdCBt
Y2VfYmFuayB7DQorCXU2NAkJCWN0bDsJCQkvKiBzdWJldmVudHMgdG8gZW5hYmxlICovDQorCWJv
b2wJCQlpbml0OwkJCS8qIGluaXRpYWxpc2UgYmFuaz8gKi8NCisJc3RydWN0IGRldmljZV9hdHRy
aWJ1dGUJYXR0cjsJCQkvKiBkZXZpY2UgYXR0cmlidXRlICovDQorCWNoYXIJCQlhdHRybmFtZVtB
VFRSX0xFTl07CS8qIGF0dHJpYnV0ZSBuYW1lICovDQorfTsNCisNCitzdGF0aWMgc3RydWN0IG1j
ZV9iYW5rICptY2VfYmFua3MgX19yZWFkX21vc3RseTsNCiBzdHJ1Y3QgbWNlX3ZlbmRvcl9mbGFn
cyBtY2VfZmxhZ3MgX19yZWFkX21vc3RseTsNCiANCiBzdHJ1Y3QgbWNhX2NvbmZpZyBtY2FfY2Zn
IF9fcmVhZF9tb3N0bHkgPSB7DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uv
aW50ZXJuYWwuaCBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVybmFsLmgNCmluZGV4IGFm
NWVhYjFlNjVlMi4uMDMyZDUyYzY2NjE2IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvaW50ZXJuYWwuaA0KKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZXJuYWwu
aA0KQEAgLTIyLDE3ICsyMiw4IEBAIGVudW0gc2V2ZXJpdHlfbGV2ZWwgew0KIA0KIGV4dGVybiBz
dHJ1Y3QgYmxvY2tpbmdfbm90aWZpZXJfaGVhZCB4ODZfbWNlX2RlY29kZXJfY2hhaW47DQogDQot
I2RlZmluZSBBVFRSX0xFTgkJMTYNCiAjZGVmaW5lIElOSVRJQUxfQ0hFQ0tfSU5URVJWQUwJNSAq
IDYwIC8qIDUgbWludXRlcyAqLw0KIA0KLS8qIE9uZSBvYmplY3QgZm9yIGVhY2ggTUNFIGJhbmss
IHNoYXJlZCBieSBhbGwgQ1BVcyAqLw0KLXN0cnVjdCBtY2VfYmFuayB7DQotCXU2NAkJCWN0bDsJ
CQkvKiBzdWJldmVudHMgdG8gZW5hYmxlICovDQotCXVuc2lnbmVkIGNoYXIgaW5pdDsJCQkJLyog
aW5pdGlhbGlzZSBiYW5rPyAqLw0KLQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBhdHRyOwkJCS8q
IGRldmljZSBhdHRyaWJ1dGUgKi8NCi0JY2hhcgkJCWF0dHJuYW1lW0FUVFJfTEVOXTsJLyogYXR0
cmlidXRlIG5hbWUgKi8NCi19Ow0KLQ0KIHN0cnVjdCBtY2VfZXZ0X2xsaXN0IHsNCiAJc3RydWN0
IGxsaXN0X25vZGUgbGxub2RlOw0KIAlzdHJ1Y3QgbWNlIG1jZTsNCkBAIC00Nyw3ICszOCw2IEBA
IHN0cnVjdCBsbGlzdF9ub2RlICptY2VfZ2VuX3Bvb2xfcHJlcGFyZV9yZWNvcmRzKHZvaWQpOw0K
IGV4dGVybiBpbnQgKCptY2Vfc2V2ZXJpdHkpKHN0cnVjdCBtY2UgKmEsIGludCB0b2xlcmFudCwg
Y2hhciAqKm1zZywgYm9vbCBpc19leGNwKTsNCiBzdHJ1Y3QgZGVudHJ5ICptY2VfZ2V0X2RlYnVn
ZnNfZGlyKHZvaWQpOw0KIA0KLWV4dGVybiBzdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rczsNCiBl
eHRlcm4gbWNlX2JhbmtzX3QgbWNlX2JhbmtzX2NlX2Rpc2FibGVkOw0KIA0KICNpZmRlZiBDT05G
SUdfWDg2X01DRV9JTlRFTA0KLS0gDQoyLjE3LjENCg0K
