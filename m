Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A62C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196C9216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="wUrgqUEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfFYOz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:55:59 -0400
Received: from mail-eopbgr730135.outbound.protection.outlook.com ([40.107.73.135]:21760
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730758AbfFYOz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector2-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coATQkr1IhrSWU1EQHgjOGj4GJd9F2Arsov6RPY8x7M=;
 b=wUrgqUEIHktIWYn4zdobPxvDxlxfGiDOE2aF9nX3WzFMuegUJeJrZB2ZSBLZQ0VgAvFDOdw3xIlJIm43tK7JvELIuzOHucwgjmQ0UZNTMT5WsSkxED7kYBNoCREzHfWEROVIcVqGW7ZQv7FlXRr88KrB75hy4Lk1/pM3HixJVbs=
Received: from DM6PR01MB4090.prod.exchangelabs.com (20.176.104.151) by
 DM6PR01MB4058.prod.exchangelabs.com (20.176.104.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Tue, 25 Jun 2019 14:55:53 +0000
Received: from DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::f0f2:16e1:1db7:ccb3]) by DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::f0f2:16e1:1db7:ccb3%7]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 14:55:53 +0000
From:   Hoan Tran OS <hoan@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Open Source Submission <patches@amperecomputing.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
Thread-Topic: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
Thread-Index: AQHVKpp8SjYC130sVEibrXL3FC+AS6asJ9uAgABPFQA=
Date:   Tue, 25 Jun 2019 14:55:53 +0000
Message-ID: <8fcd11c8-13d2-f21a-f6c0-c16cff11803b@os.amperecomputing.com>
References: <1561387098-23692-1-git-send-email-Hoan@os.amperecomputing.com>
 <20190625101245.s4vxfosoop52gl4e@willie-the-truck>
In-Reply-To: <20190625101245.s4vxfosoop52gl4e@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:903:117::13) To DM6PR01MB4090.prod.exchangelabs.com
 (2603:10b6:5:2a::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.28.12.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d568e313-29c1-4bd9-988f-08d6f97d3800
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR01MB4058;
x-ms-traffictypediagnostic: DM6PR01MB4058:
x-microsoft-antispam-prvs: <DM6PR01MB4058F1C90A0B279D2FF74728F1E30@DM6PR01MB4058.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6436002)(81166006)(6916009)(25786009)(8676002)(4326008)(81156014)(6486002)(86362001)(478600001)(2906002)(8936002)(66066001)(3846002)(316002)(53936002)(6116002)(256004)(71200400001)(71190400001)(68736007)(6246003)(26005)(99286004)(2616005)(446003)(476003)(54906003)(52116002)(486006)(53546011)(6506007)(31686004)(386003)(102836004)(11346002)(186003)(229853002)(31696002)(76176011)(14454004)(305945005)(7736002)(66946007)(73956011)(66556008)(5660300002)(6512007)(64756008)(66446008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB4058;H:DM6PR01MB4090.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BhJEcOF+uDJvcc/fR8IBhguDCZ0VVwx2YIV13ru7zqrkWJAp62LUVMQh13SsGlWatcCDaUrMJZCETPdwpuBDUtURqOXxMaUtfkuYpzJFVo7UDOGQ6W5YfXCvCBQoNBmiECqD5h0uQ5Iju84g3GLEIi6aqiP0y+HP5+Lr6/V+xV461mpdEJjx1bDUw1Rm7AJx8TeP82RVxlVeBE6KfOrw5z6deY2kXQgIDkDYa07xPl7EDIMyVFkodrffcFT1chaNQuSWeWNM1G6BpWi3CIfCNQnplYoiPeaa9LDE+RhNHUGXJgDsnsn/1TvyO7jpYQBz1IlGM/7INZ4BGMvWqSvTUnuuc3qMecq4lYK4/MdpTQwOYD5HudhBA1BMPCDn2+TI0vouN5KcntwsyjnNaddxGxV/pBhjY+DgvO5+2SkUQWg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA88AAA5B71B5C4BAABA9C22B8AA4135@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d568e313-29c1-4bd9-988f-08d6f97d3800
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:55:53.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hoan@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCwNCg0KT24gNi8yNS8xOSAzOjEyIEFNLCBXaWxsIERlYWNvbiB3cm90ZToNCj4gT24g
TW9uLCBKdW4gMjQsIDIwMTkgYXQgMDI6Mzg6MjhQTSArMDAwMCwgSG9hbiBUcmFuIE9TIHdyb3Rl
Og0KPj4gU29tZSBOVU1BIG5vZGVzIGhhdmUgbWVtb3J5IHJhbmdlcyB0aGF0IHNwYW4gb3RoZXIg
bm9kZXMuDQo+PiBFdmVuIHRob3VnaCBhIHBmbiBpcyB2YWxpZCBhbmQgYmV0d2VlbiBhIG5vZGUn
cyBzdGFydCBhbmQgZW5kIHBmbnMsDQo+PiBpdCBtYXkgbm90IHJlc2lkZSBvbiB0aGF0IG5vZGUu
DQo+Pg0KPj4gVGhpcyBwYXRjaCBlbmFibGVzIE5PREVTX1NQQU5fT1RIRVJfTk9ERVMgY29uZmln
IGZvciBOVU1BIHRvIHN1cHBvcnQNCj4+IHRoaXMgdHlwZSBvZiBOVU1BIGxheW91dC4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBIb2FuIFRyYW4gPEhvYW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbT4N
Cj4+IC0tLQ0KPj4gICBhcmNoL2FybTY0L0tjb25maWcgfCA3ICsrKysrKysNCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L0tjb25maWcgYi9hcmNoL2FybTY0L0tjb25maWcNCj4+IGluZGV4IDY5N2VhMDUuLjIxZmMxNjgg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L0tjb25maWcNCj4+ICsrKyBiL2FyY2gvYXJtNjQv
S2NvbmZpZw0KPj4gQEAgLTg3Myw2ICs4NzMsMTMgQEAgY29uZmlnIE5FRURfUEVSX0NQVV9FTUJF
RF9GSVJTVF9DSFVOSw0KPj4gICBjb25maWcgSE9MRVNfSU5fWk9ORQ0KPj4gICAJZGVmX2Jvb2wg
eQ0KPj4gICANCj4+ICsjIFNvbWUgTlVNQSBub2RlcyBoYXZlIG1lbW9yeSByYW5nZXMgdGhhdCBz
cGFuIG90aGVyIG5vZGVzLg0KPj4gKyMgRXZlbiB0aG91Z2ggYSBwZm4gaXMgdmFsaWQgYW5kIGJl
dHdlZW4gYSBub2RlJ3Mgc3RhcnQgYW5kIGVuZCBwZm5zLA0KPj4gKyMgaXQgbWF5IG5vdCByZXNp
ZGUgb24gdGhhdCBub2RlLg0KPj4gK2NvbmZpZyBOT0RFU19TUEFOX09USEVSX05PREVTDQo+PiAr
CWRlZl9ib29sIHkNCj4+ICsJZGVwZW5kcyBvbiBBQ1BJX05VTUENCj4gDQo+IEhvdyBjb21lIHRo
aXMgaXMgc3BlY2lmaWMgdG8gQUNQST8NCg0KSSByZWZlcnJlZCB0byB4ODYgY29uZmlnLiBCZXNp
ZGUgb2YgdGhhdCwgSSBvbmx5IGNhbiB0ZXN0IG9uIHRoZSBzeXN0ZW0gDQp3aXRoIEFDUEkgc3Vw
cG9ydGVkLg0KDQo+IA0KPiBJdCB3b3VsZCBiZSBuaWNlIGlmIHRoaXMgd2FzIHRoZSBkZWZhdWx0
LCBnaXZlbiB0aGF0IG9ubHkgaWE2NCwgbWlwcyBhbmQNCj4gc2ggYXBwZWFyIHRvIGJlIHRoZSBv
bmx5IE5VTUEtY2FwYWJsZSBhcmNoaXRlY3R1cmVzIHdoaWNoIGRvbid0IGhhdmUgaXQuDQo+IElu
IG90aGVyIHdvcmRzLCByZXBsYWNlIHRoZSAjaWZkZWYgQ09ORklHX05PREVTX1NQQU5fT1RIRVJf
Tk9ERVMgaW4NCj4gbW0vcGFnZV9hbGxvYy5jIHdpdGggI2lmZGVmIENPTkZJR19OVU1BLg0KDQpB
Z3JlZWQsIGxldCBtZSBzZW5kIGFub3RoZXIgcGF0Y2ggYXMgeW91ciBzdWdnZXN0aW9uLg0KDQpU
aGFua3MNCkhvYW4NCg0KPiBXaWxsDQo+IA0K
