Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F584C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C3B2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V/dvrrRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfENRRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:17:13 -0400
Received: from mail-eopbgr750058.outbound.protection.outlook.com ([40.107.75.58]:19431
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfENRRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc9AdtCfa2Mwj0MwrRa7J/OEQJU+85g71zfZl/OVdVs=;
 b=V/dvrrRSJXEHGEN2IH+F1MWUylrdZo0jIhUVja96dsJObtxewbtuO15LEkAuijAu2WjBDuDVhWDH/eUVRoiM2Ce9UKYzW26LjeMUj5w8jpQ0WGPLPSVLgwx9ZklFpOCwl8ZMLLEwas6um6gQVjWfSxHOXwu3Nm9ei+h4BN3C8Rw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Tue, 14 May 2019 17:17:07 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::899d:65c6:3f72:20d3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::899d:65c6:3f72:20d3%7]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 17:17:07 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Andre Przywara <andre.przywara@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <James.Morse@arm.com>
Subject: Re: [PATCH v7 12/13] selftests/resctrl: Disable MBA and MBM tests for
 AMD
Thread-Topic: [PATCH v7 12/13] selftests/resctrl: Disable MBA and MBM tests
 for AMD
Thread-Index: AQHUwOxdxBVLcDr5zkmZv13O0Xn8HaZlLPyAgAAekACABiROAA==
Date:   Tue, 14 May 2019 17:17:07 +0000
Message-ID: <f80600a0-9d8c-a50f-5139-508d10ec4b20@amd.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <1549767042-95827-13-git-send-email-fenghua.yu@intel.com>
 <20190510184011.210794fc@donnerap.cambridge.arm.com>
 <3E5A0FA7E9CA944F9D5414FEC6C712209D8A3C19@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C712209D8A3C19@ORSMSX106.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0801CA0022.namprd08.prod.outlook.com
 (2603:10b6:803:29::32) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 673a9fdc-8ccd-474b-346d-08d6d88ffdb1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1163;
x-ms-traffictypediagnostic: DM5PR12MB1163:
x-microsoft-antispam-prvs: <DM5PR12MB1163ED2910E26A737FF7640895080@DM5PR12MB1163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(6436002)(5660300002)(71190400001)(71200400001)(6486002)(99286004)(68736007)(3846002)(6116002)(110136005)(7416002)(316002)(54906003)(14454004)(256004)(36756003)(72206003)(66066001)(478600001)(25786009)(73956011)(66946007)(53936002)(86362001)(7736002)(8936002)(66476007)(305945005)(64756008)(8676002)(66556008)(31696002)(66446008)(81156014)(81166006)(386003)(53546011)(6506007)(26005)(102836004)(4326008)(31686004)(76176011)(52116002)(11346002)(486006)(2906002)(6512007)(476003)(446003)(2616005)(6246003)(186003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1163;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rmnfg2mPWUwwmHow42sTN8IjX7tlVfc/Fvz4xNJ0ZArAciOTRBK3hIv7fa0aKqoLUv2Ui3EyAaKd6ih/Acv5LTb3QlMPJ/gEcVmLJEoHiLSCS0J4GT02jgbPgljeY0gZ1eZzLbE7D4ZDcSZ+VsBH6sbH56j5sq8UPfidlpNsfII5PXZ112Y5P357CVw2UNe2Z2Y9LT6Np7QLdC016SR9wSWibUMUlbAu0Pwqwv1/N495w6OtUz0/gTipyIRynrVaqgrxJnJ/mJ9B0UhFQPWTVCXi+gfCa3LoxXc88zY2WUFvzHKACM5N70yjXYojAH34CCwy/kOiMPOXTUjLb0tOSjXkmTX3DYsvqkNf88+YHkAhBZH3VlwW3TtY/8yzA+4bZmWENI9KTmIcXJSr7vaXLASmaTfDkCPb6IAMSOlHz5c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F30790853A24542AEEBF3B81336DF8B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673a9fdc-8ccd-474b-346d-08d6d88ffdb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 17:17:07.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVuZ2h1YS9BbmRyZSwNCg0KDQpPbiA1LzEwLzE5IDI6MjkgUE0sIFl1LCBGZW5naHVhIHdyb3Rl
Og0KPiBbQ0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQo+IA0KPj4gT24gRnJpZGF5LCBNYXkgMTAs
IDIwMTkgMTA6NDAgQU0NCj4+IEFuZHJlIFByenl3YXJhIFttYWlsdG86YW5kcmUucHJ6eXdhcmFA
YXJtLmNvbV0gd3JvdGU6DQo+PiBUbzogWXUsIEZlbmdodWEgPGZlbmdodWEueXVAaW50ZWwuY29t
Pg0KPj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgSW5nbyBNb2xu
YXINCj4+IDxtaW5nb0ByZWRoYXQuY29tPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
OyBIIFBldGVyIEFudmluDQo+PiA8aHBhQHp5dG9yLmNvbT47IEx1Y2ssIFRvbnkgPHRvbnkubHVj
a0BpbnRlbC5jb20+OyBDaGF0cmUsIFJlaW5ldHRlDQo+PiA8cmVpbmV0dGUuY2hhdHJlQGludGVs
LmNvbT47IFNoYW5rYXIsIFJhdmkgViA8cmF2aS52LnNoYW5rYXJAaW50ZWwuY29tPjsNCj4+IFNo
ZW4sIFhpYW9jaGVuIDx4aWFvY2hlbi5zaGVuQGludGVsLmNvbT47IFBhdGhhbiwgQXJzaGl5YSBI
YXlhdGtoYW4NCj4+IDxhcnNoaXlhLmhheWF0a2hhbi5wYXRoYW5AaW50ZWwuY29tPjsgUHJha2h5
YSwgU2FpIFByYW5lZXRoDQo+PiA8c2FpLnByYW5lZXRoLnByYWtoeWFAaW50ZWwuY29tPjsgQmFi
dSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPjsNCj4+IGxpbnV4LWtlcm5lbCA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IEphbWVzIE1vcnNlDQo+PiA8SmFtZXMuTW9yc2VAYXJtLmNv
bT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMTIvMTNdIHNlbGZ0ZXN0cy9yZXNjdHJsOiBE
aXNhYmxlIE1CQSBhbmQgTUJNIHRlc3RzDQo+PiBmb3IgQU1EDQo+Pg0KPj4gT24gU2F0LCAgOSBG
ZWIgMjAxOSAxODo1MDo0MSAtMDgwMA0KPj4gRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRlbC5j
b20+IHdyb3RlOg0KPj4NCj4+IEhpLA0KPj4NCj4+PiBGcm9tOiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1v
Z2VyQGFtZC5jb20+DQo+Pj4NCj4+PiBGb3Igbm93LCBkaXNhYmxlIE1CQSBhbmQgTUJNIHRlc3Rz
IGZvciBBTUQuIERlY2lkaW5nIHRlc3QgcGFzcy9mYWlsIGlzDQo+Pj4gbm90IGNsZWFyIHJpZ2h0
IG5vdy4gV2UgY2FuIGVuYWJsZSB3aGVuIHdlIGhhdmUgc29tZSBjbGFyaXR5Lg0KPj4NCj4+IEkg
ZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcmlnaHQgd2F5LiBUaGUgYXZhaWxhYmlsaXR5IG9mIGZl
YXR1cmVzIHNob3VsZCBiZQ0KPj4gcXVlcnlhYmxlLCBmb3IgaW5zdGFuY2UgYnkgbG9va2luZyBp
bnRvIC9zeXMvZnMvcmVzY3RybC9pbmZvLiBDaGVja2luZyBmb3IgYQ0KPj4gY2VydGFpbiB2ZW5k
b3IgdG8gc2tpcCB0ZXN0cyBqdXN0IHNvdW5kcyB3cm9uZyB0byBtZSwgYW5kIGlzIGRlZmluaXRl
bHkgbm90DQo+PiBzY2FsYWJsZSBvciBmdXR1cmUgcHJvb2YuDQo+Pg0KPj4gV2Ugc2hvdWxkIHJl
YWxseSBjaGVjayB0aGUgYXZhaWxhYmlsaXR5IG9mIGEgZmVhdHVyZSwgdGhlbiBza2lwIHRoZSB3
aG9sZQ0KPj4gc3Vic3lzdGVtIHRlc3QgaW4gcmVzY3RybF90ZXN0cy5jLg0KPiANCj4gQmFidSBt
YXkgY29ycmVjdCBpZiBJJ20gd3Jvbmc6IEFNRCBkb2VzIHN1cHBvcnQgdGhlIE1CQSBhbmQgTUJN
IGZlYXR1cmVzLiBTbyBpZiBxdWVyeWluZyB0aGUgaW5mbyBkaXJlY3RvcnksIHRoZSBmZWF0dXJl
cyBhcmUgdGhlcmUuIEJ1dCBBTUQgZG9lc24ndCB3YW50IHRvIHN1cHBvcnQgdGhlIHRlc3Rpbmcg
Zm9yIHRoZSBmZWF0dXJlcyBpbiB0aGUgY3VycmVudCBwYXRjaCBzZXQuIFRoZXkgbWF5IHN1cHBv
cnQgdGhlIHRlc3RpbmcgaW4gdGhlIGZ1dHVyZS4NCg0KWWVzLiBBTUQgc3VwcG9ydHMgdGhlIE1C
QSBhbmQgTUJNIGZlYXR1cmVzLiBCdXQsIGRlY2lkaW5nIHRoZSB0ZXN0DQpwYXNzL2ZhaWwgd2Fz
IG5vdCBjbGVhciB0byBtZS4gVGhhdCBpcyB3aHkgSSBkZWNpZGVkIHRvIGRpc2FibGUgdGhlIHRl
c3QNCmZvciBub3cuIFJpZ2h0IG5vdywgaXQgcmVwb3J0cyB0aGUgdGVzdCByZXN1bHQgYXMgImZh
aWwiLiBXZSBjYW4gYWRkIHRoZQ0KdGVzdCBpbiB0aGUgZnV0dXJlIHdpdGggc29tZSBtb2RpZmlj
YXRpb25zLg0KDQo+IA0KPiBUaGFua3MuDQo+IA0KPiAtRmVuZ2h1YQ0KPiANCg==
