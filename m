Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B87C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0331E20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nfVv+pVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEBP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:58:40 -0400
Received: from mail-eopbgr680058.outbound.protection.outlook.com ([40.107.68.58]:13793
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfEBP6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM+3cLq8TrOi5fmHr+fQEEekPfuxNoeIBO5BsndwO5M=;
 b=nfVv+pVZvCBfTa+iAbi9b9yBuoyGLsCke4ALK7Iisg2yqB+UpSlg5XDpnYD97CJ7Kwjsz01BWtEeUV/dsd/9Nl6uEAHCiPNvFvXHQ4P7WhEqE3dXdKPAD5vrvpqsQVhcdygQmaXbXOONwYpJ9cdMOPyCnnSABaYUotgLfnpfG60=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1447.namprd12.prod.outlook.com (10.172.71.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Thu, 2 May 2019 15:58:37 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::c84c:8885:45d3:fb52]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::c84c:8885:45d3:fb52%3]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 15:58:37 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Phillips, Kim" <kim.phillips@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>
Subject: [PATCH] MAINTAINERS: include vendor specific files under
 arch/*/events/*
Thread-Topic: [PATCH] MAINTAINERS: include vendor specific files under
 arch/*/events/*
Thread-Index: AQHVAP/npOiGZUWVcEOaqFlwCEIRQw==
Date:   Thu, 2 May 2019 15:58:37 +0000
Message-ID: <20190502155805.7539-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0137.namprd05.prod.outlook.com
 (2603:10b6:803:2c::15) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14fbd694-3df7-4e5a-f8c1-08d6cf170957
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1447;
x-ms-traffictypediagnostic: CY4PR12MB1447:
x-microsoft-antispam-prvs: <CY4PR12MB1447F14747F4D811E0A7CEED87340@CY4PR12MB1447.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(189003)(199004)(25786009)(476003)(6506007)(386003)(14454004)(66066001)(478600001)(4326008)(486006)(36756003)(53936002)(3846002)(6116002)(6512007)(71200400001)(73956011)(66476007)(66556008)(64756008)(66446008)(71190400001)(66946007)(102836004)(8936002)(7736002)(68736007)(81166006)(6486002)(8676002)(99286004)(110136005)(316002)(50226002)(6436002)(305945005)(26005)(81156014)(186003)(7416002)(1076003)(256004)(54906003)(52116002)(2616005)(2501003)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1447;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wO5cFkHL3yOFK8kcrbjEUKFZ17aeZ4bQL6pS/hfkOkQdWbQWiutR8u0t/IJGle5LrsPK12GhZpyT9Deu1WeMHCkOa6jL8QjNcTQU3yzvuURKQLh3zVoxTNrI0c+yMg9ohAiG+eb8cVyioRiz/kj+3ZUNOBFsSpAs3NoAY0jOfhvPeuZ8Bwu9OrSbPbihn37CWyJhKXlSOaoELpV40VYupTymmi1DOeTywmqzt/U38tpPWJ2q0bRDHW64POnnfA18WpgPs3ZbAW5Geqg3iYb432YMgUhzeRDUfhOEPuLTj9sIYBtqI2aexloDcI4GDYU9QELirqnGv3YScjrjYmX1F3gTM27focmexMxj6zjCbW6o7bFqMGVZ8SDrU6PgjynMaHIDaii9HZXwp8+VovN4wzn7YnN+q4N1dErbHHKeSGE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1A56C72293F704A84A15FA1F33BE646@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fbd694-3df7-4e5a-f8c1-08d6cf170957
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 15:58:37.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2ltIFBoaWxsaXBzIDxraW0ucGhpbGxpcHNAYW1kLmNvbT4NCg0KQWRkIGFuIGV4cGxp
Y2l0IHN1YmRpcmVjdG9yeSBzcGVjaWZpY2F0aW9uIGZvciBhcmNoL3g4Ni9ldmVudHMvYW1kIHRv
DQp0aGUgTUFJTlRBSU5FUlMgZmlsZSwgdG8gZGlzdGluZ3Vpc2ggaXQgZnJvbSBpdHMgcGFyZW50
LiBUaGlzIHdpbGwNCnByb2R1Y2UgdGhlIGNvcnJlY3Qgc2V0IG9mIG1haW50YWluZXJzIGZvciB0
aGUgZmlsZXMgZm91bmQgdGhlcmVpbi4NCg0KRml4ZXM6IDM5YjAzMzJhMjE1OCAoInBlcmYveDg2
OiBNb3ZlIHBlcmZfZXZlbnRfYW1kLmMgLi4uLi4uLi4uLi4gPT4geDg2L2V2ZW50cy9hbWQvY29y
ZS5jIikNClNpZ25lZC1vZmYtYnk6IEtpbSBQaGlsbGlwcyA8a2ltLnBoaWxsaXBzQGFtZC5jb20+
DQpDYzogSmFuYWthcmFqYW4gTmF0YXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFqYW5AYW1kLmNv
bT4NCkNjOiBTdXJhdmVlIFN1dGhpa3VscGFuaXQgPFN1cmF2ZWUuU3V0aGlrdWxwYW5pdEBhbWQu
Y29tPg0KQ2M6IEdhcnkgSG9vayA8R2FyeS5Ib29rQGFtZC5jb20+DQpDYzogVGhvbWFzIExlbmRh
Y2t5IDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT4NCkNjOiBNYXJ0aW4gTGnFoWthIDxtbGlza2FA
c3VzZS5jej4NCkNjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQpDYzog
SW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQpDYzogQXJuYWxkbyBDYXJ2YWxobyBkZSBN
ZWxvIDxhY21lQGtlcm5lbC5vcmc+DQpDYzogQWxleGFuZGVyIFNoaXNoa2luIDxhbGV4YW5kZXIu
c2hpc2hraW5AbGludXguaW50ZWwuY29tPg0KQ2M6IEppcmkgT2xzYSA8am9sc2FAcmVkaGF0LmNv
bT4NCkNjOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+DQpDYzogVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQpDYzogQm9yaXNsYXYgUGV0a292IDxicEBhbGll
bjguZGU+DQpDYzogIkguIFBldGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCkNjOiBQdSBXZW4g
PHB1d2VuQGh5Z29uLmNuPg0KQ2M6IHg4NkBrZXJuZWwub3JnDQpDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KLS0tDQogTUFJTlRBSU5FUlMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMN
CmluZGV4IDVjMzhmMjFhZWU3OC4uM2ExNWI2ZDc1ODRlIDEwMDY0NA0KLS0tIGEvTUFJTlRBSU5F
UlMNCisrKyBiL01BSU5UQUlORVJTDQpAQCAtMTIxNzYsNiArMTIxNzYsNyBAQCBGOglhcmNoLyov
a2VybmVsLyovKi9wZXJmX2V2ZW50Ki5jDQogRjoJYXJjaC8qL2luY2x1ZGUvYXNtL3BlcmZfZXZl
bnQuaA0KIEY6CWFyY2gvKi9rZXJuZWwvcGVyZl9jYWxsY2hhaW4uYw0KIEY6CWFyY2gvKi9ldmVu
dHMvKg0KK0Y6CWFyY2gvKi9ldmVudHMvKi8qDQogRjoJdG9vbHMvcGVyZi8NCiANCiBQRVJTT05B
TElUWSBIQU5ETElORw0KLS0gDQoyLjIxLjANCg0K
