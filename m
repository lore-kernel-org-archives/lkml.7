Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69639C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1993420835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KqGJO9Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCTBbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:31:33 -0400
Received: from mail-eopbgr720076.outbound.protection.outlook.com ([40.107.72.76]:48232
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbfCTBbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSQeThEKPMrpY7CH3uJVXjbCO0Sp5s0mD/77W9hs0xk=;
 b=KqGJO9Fd9LjFucf7wlOSPT35/uqlUQqrffCDIX1OCxPHxdzpicSbwAwc80wqzuv0jYY6b4YIsvNRIQGOOPiYfUmoWVQFRL6kHFxbIiqeccTI1Jn6YsyfJ/NFoVaiOvZHpMKEToDVSBXiIca1KDEfmcapHnTHLc7HUFQXLqMfeUw=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.107.150) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 20 Mar 2019 01:31:27 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::3d38:28e0:e1b5:215b]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::3d38:28e0:e1b5:215b%4]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 01:31:27 +0000
From:   "Pan, Xinhui" <Xinhui.Pan@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Thread-Topic: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Thread-Index: AQHU3rdvxNmFG67CBEah8A4XIlBblqYTucrw
Date:   Wed, 20 Mar 2019 01:31:27 +0000
Message-ID: <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <20190320005406.GA16412@archlinux-ryzen>
In-Reply-To: <20190320005406.GA16412@archlinux-ryzen>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [58.35.10.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2fa6b77-d5c4-4d44-2283-08d6acd3c5e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-microsoft-antispam-prvs: <SN6PR12MB2815CA5C0CC52379DDB85F2B87410@SN6PR12MB2815.namprd12.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(53754006)(13464003)(189003)(199004)(14454004)(2906002)(72206003)(106356001)(66066001)(105586002)(478600001)(8676002)(110136005)(54906003)(25786009)(229853002)(7736002)(81156014)(81166006)(33656002)(316002)(8936002)(6116002)(3846002)(446003)(6246003)(6636002)(5660300002)(76176011)(71190400001)(53936002)(71200400001)(86362001)(476003)(11346002)(97736004)(256004)(102836004)(14444005)(53546011)(6506007)(305945005)(99286004)(7696005)(52536014)(55016002)(6436002)(4326008)(486006)(186003)(26005)(68736007)(74316002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2800.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vdC+YCzG7o77H4xH+U/ADSAoCc52EdkhGI44SMR41aqbbido8CyrmZU2jcpIdNM5nATbCt5zbPqPq1GNJH8WUbeupjo0S4QnUfRvztya6eavM1d46bkSASqrtgwm60tHYsaGu23Fr+OajuCAE0YWpvcnhMMkoY1wn3XW8o5YL0Y/dLBWuDOTFcShMA9rYPoe4EF3I6z+XM484Jlp0r/LEfGxBk23Ii+kHyoz95CLsNyQK6F+bO7+D5EqGVGnbLf7AUUdKQMcKPge/ePiyQ5ODYZyYOPKPfnVyAN2+OAMxrJiVqhO2d8wls1E6p6whkk6FydB8aCA9/IM9rsMC3gKRgddHb7TyDbCtL3KEuhp1jXA0ZeW/466TWPeDxwM74v3NxFiK2g30VOMc50v86cGXeheYqgstozSS/rOhrdONUY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fa6b77-d5c4-4d44-2283-08d6acd3c5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 01:31:27.6639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhlc2UgdHdvIGVudW1lcmF0ZWQgdHlwZXMgYXJlIHNhbWUgZm9yIG5vdy4gYm90aCBvZiB0aGVt
IG1pZ2h0IGNoYW5nZSBpbiB0aGUgZnV0dXJlLg0KDQpJIGhhdmUgbm90IHVzZWQgY2xhbmcsIGJ1
dCB3b3VsZCAgLmJsb2NrX2lkID0gIChpbnQpaGVhZC0+YmxvY2sgZml4IHlvdXIgd2FybmluZz8g
SWYgc3VjaCBjaGFuZ2UgaXMgYWNjZXB0YWJsZSwgSSBjYW4gbWFrZSBvbmUgdGhlbi4NCg0KVGhh
bmtzDQp4aW5odWkNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmF0aGFu
IENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4gDQpTZW50OiAyMDE5xOoz1MIy
MMjVIDg6NTQNClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhvdSwg
RGF2aWQoQ2h1bk1pbmcpIDxEYXZpZDEuWmhvdUBhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1
aS5QYW5AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
Y2xhbmctYnVpbHQtbGludXhAZ29vZ2xlZ3JvdXBzLmNvbQ0KU3ViamVjdDogQ2xhbmcgd2Fybmlu
ZyBpbiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCg0KSGkgYWxsLA0K
DQpUaGUgaW50cm9kdWN0aW9uIG9mIHRoaXMgZmlsZSBpbiBjb21taXQgZGJkMjQ5YzI0NDI3ICgi
ZHJtL2FtZGdwdTogYWRkIGFtZGdwdV9yYXMuYyB0byBzdXBwb3J0IHJhcyAodjIpIikgaW50cm9k
dWNlcyB0aGUgZm9sbG93aW5nIENsYW5nDQp3YXJuaW5nczoNCg0KZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjU0NDoyMzogd2FybmluZzogaW1wbGljaXQgY29udmVyc2lv
biBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gYW1kZ3B1X3Jhc19ibG9jaycgdG8gZGlmZmVy
ZW50IGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gdGFfcmFzX2Jsb2NrJyBbLVdlbnVtLWNvbnZlcnNp
b25dDQogICAgICAgICAgICAgICAgICAgICAgICAuYmxvY2tfaWQgPSAgaGVhZC0+YmxvY2ssDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+Xn5+fn4NCmRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzo1NDU6MjQ6IHdhcm5pbmc6IGltcGxpY2l0
IGNvbnZlcnNpb24gZnJvbSBlbnVtZXJhdGlvbiB0eXBlICdlbnVtIGFtZGdwdV9yYXNfZXJyb3Jf
dHlwZScgdG8gZGlmZmVyZW50IGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gdGFfcmFzX2Vycm9yX3R5
cGUnIFstV2VudW0tY29udmVyc2lvbl0NCiAgICAgICAgICAgICAgICAgICAgICAgIC5lcnJvcl90
eXBlID0gaGVhZC0+dHlwZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fn5+fn5+Xn5+fg0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjU0OToy
Mzogd2FybmluZzogaW1wbGljaXQgY29udmVyc2lvbiBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2Vu
dW0gYW1kZ3B1X3Jhc19ibG9jaycgdG8gZGlmZmVyZW50IGVudW1lcmF0aW9uIHR5cGUgJ2VudW0g
dGFfcmFzX2Jsb2NrJyBbLVdlbnVtLWNvbnZlcnNpb25dDQogICAgICAgICAgICAgICAgICAgICAg
ICAuYmxvY2tfaWQgPSAgaGVhZC0+YmxvY2ssDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfn5+fn5+Xn5+fn4NCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYzo1NTA6MjQ6IHdhcm5pbmc6IGltcGxpY2l0IGNvbnZlcnNpb24gZnJvbSBlbnVtZXJhdGlv
biB0eXBlICdlbnVtIGFtZGdwdV9yYXNfZXJyb3JfdHlwZScgdG8gZGlmZmVyZW50IGVudW1lcmF0
aW9uIHR5cGUgJ2VudW0gdGFfcmFzX2Vycm9yX3R5cGUnIFstV2VudW0tY29udmVyc2lvbl0NCiAg
ICAgICAgICAgICAgICAgICAgICAgIC5lcnJvcl90eXBlID0gaGVhZC0+dHlwZSwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+Xn5+fg0KZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjY1MDoyNjogd2FybmluZzogaW1wbGljaXQgY29udmVy
c2lvbiBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gYW1kZ3B1X3Jhc19ibG9jaycgdG8gZGlm
ZmVyZW50IGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gdGFfcmFzX2Jsb2NrJyBbLVdlbnVtLWNvbnZl
cnNpb25dDQogICAgICAgICAgICAgICAgLmJsb2NrX2lkID0gaW5mby0+aGVhZC5ibG9jaywNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fl5+fn5+DQpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmM6NjUxOjM1OiB3YXJuaW5nOiBpbXBsaWNpdCBjb252
ZXJzaW9uIGZyb20gZW51bWVyYXRpb24gdHlwZSAnZW51bSBhbWRncHVfcmFzX2Vycm9yX3R5cGUn
IHRvIGRpZmZlcmVudCBlbnVtZXJhdGlvbiB0eXBlICdlbnVtIHRhX3Jhc19lcnJvcl90eXBlJyBb
LVdlbnVtLWNvbnZlcnNpb25dDQogICAgICAgICAgICAgICAgLmluamVjdF9lcnJvcl90eXBlID0g
aW5mby0+aGVhZC50eXBlLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+
fn5+fn5+fn5+Xn5+fg0KNiB3YXJuaW5ncyBnZW5lcmF0ZWQuDQoNCk5vcm1hbGx5LCBJIHdvdWxk
IHNlbnQgYSBmaXggZm9yIHRoaXMgbXlzZWxmIGJ1dCBJIGFtIG5vdCBlbnRpcmVseSBzdXJlIHdo
eSB0aGVzZSB0d28gZW51bWVyYXRlZCB0eXBlcyBleGlzdCB3aGVuIG9uZSB3b3VsZCBkbyBzaW5j
ZSB0aGV5IGhhdmUgdGhlIHNhbWUgdmFsdWVzIG1pbnVzIHRoZSBwcmVmaXguIEluIGZhY3QsIHRo
ZSB0YV9yYXNfe2Jsb2NrLGVycm9yX3R5cGV9IHZhbHVlcyBhcmUgbmV2ZXIgdXNlZCBhc2lkZSBm
cm9tIGJlaW5nIGRlZmluZWQuIFNvbWUgY2xhcmlmaWNhdGlvbiB3b3VsZCBiZSBhcHByZWNpYXRl
ZC4NCg0KVGhhbmsgeW91LA0KTmF0aGFuDQo=
