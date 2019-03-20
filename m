Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFFC21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kqd+yjPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCTJhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:37:15 -0400
Received: from mail-eopbgr790040.outbound.protection.outlook.com ([40.107.79.40]:2947
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfCTJhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q21QDBaUmdp5mfq/JJOBSO1l+d7Mu2xscATlHJ7oVi4=;
 b=kqd+yjPA5Ks7BhaYWjKziCZRNlzprHWFGc7SDfl1zQlMkZM92uWbJO3nDndnozfxEk/rNMOvRy8DzzbgbaUGEDLH6ZvVfHhzGWZX3yYOQt0eV6j0ooLIdftcMP2daTwzpQkrO19LQqYKqLWr+gugusEsQFg3laO5V4RdXmC2RqY=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1452.namprd12.prod.outlook.com (10.172.38.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Wed, 20 Mar 2019 09:37:09 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9559:5e05:6b91:5ab4]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9559:5e05:6b91:5ab4%6]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 09:37:09 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Thread-Topic: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Thread-Index: AQHU3rdvvgMJOAy5E0q2ZMtxTsRIQqYTu9eAgAAzMACAAFR5AA==
Date:   Wed, 20 Mar 2019 09:37:09 +0000
Message-ID: <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
References: <20190320005406.GA16412@archlinux-ryzen>
 <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen>
In-Reply-To: <20190320043440.GA23335@archlinux-ryzen>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:209:15::41) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdaebf8c-e504-4e6a-e26a-08d6ad179f44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1452;
x-ms-traffictypediagnostic: DM5PR12MB1452:
x-microsoft-antispam-prvs: <DM5PR12MB1452A1BA821E1580AB7B0D9383410@DM5PR12MB1452.namprd12.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(13464003)(189003)(199004)(53754006)(76176011)(53546011)(6506007)(386003)(102836004)(105586002)(106356001)(52116002)(99286004)(31686004)(14444005)(256004)(71190400001)(71200400001)(5660300002)(6116002)(446003)(11346002)(2616005)(476003)(486006)(186003)(97736004)(46003)(36756003)(25786009)(316002)(58126008)(54906003)(110136005)(72206003)(14454004)(478600001)(8936002)(8676002)(81166006)(81156014)(4326008)(305945005)(7736002)(68736007)(65826007)(6636002)(53936002)(6246003)(229853002)(64126003)(65956001)(65806001)(2906002)(6512007)(6486002)(6436002)(86362001)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1452;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R6fRTxy+aX5PN257VyJyhULmHcv/AZpuLGTvQge8IMG275EcFYTqQKzQHyKjTUPzfhR+3XBjwfqLquVxk/FjpRrwJuQZ+YQ+wRWgjXUP28QrNnBd93m/xZID2D+FmrnMJuImpB+61jUz1r7iQtPxuvX/rk8YHn7TMzb53QJOREaWFqVAFAv7WXJPyNHf/BX+09L/Q057FNI2rYOx6c2Cb3VgV9n8w3NVHBKZO6ysDz3MYe31yiYTpt6Eai0xlvR/QFY/0HbHFUwkzczLiLKJ3IVy5OcXmJkDhoJeQ+U+KxOU+nmVgbKZCN5ZNs6t+kAltao3kJ4ZHOMAY/JUPlABLq57JZu57rn8iyVsOv3IFZHAo+WOYkeiPjyZwNZ5itEKFuEjMu+Fh5Apqu2cyedcjVs2hwUF9uNJwECJNnIF8Nk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80C3C9A258FB5945A28214A03316D192@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaebf8c-e504-4e6a-e26a-08d6ad179f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 09:37:09.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjAuMDMuMTkgdW0gMDU6MzQgc2NocmllYiBOYXRoYW4gQ2hhbmNlbGxvcjoNCj4gT24gV2Vk
LCBNYXIgMjAsIDIwMTkgYXQgMDE6MzE6MjdBTSArMDAwMCwgUGFuLCBYaW5odWkgd3JvdGU6DQo+
PiB0aGVzZSB0d28gZW51bWVyYXRlZCB0eXBlcyBhcmUgc2FtZSBmb3Igbm93LiBib3RoIG9mIHRo
ZW0gbWlnaHQgY2hhbmdlIGluIHRoZSBmdXR1cmUuDQo+Pg0KPj4gSSBoYXZlIG5vdCB1c2VkIGNs
YW5nLCBidXQgd291bGQgIC5ibG9ja19pZCA9ICAoaW50KWhlYWQtPmJsb2NrIGZpeCB5b3VyIHdh
cm5pbmc/IElmIHN1Y2ggY2hhbmdlIGlzIGFjY2VwdGFibGUsIEkgY2FuIG1ha2Ugb25lIHRoZW4u
DQo+Pg0KPj4gVGhhbmtzDQo+PiB4aW5odWkNCj4+DQo+Pg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+IEZyb206IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRlY2hhbmNlbGxvckBnbWFp
bC5jb20+DQo+PiBTZW50OiAyMDE55bm0M+aciDIw5pelIDg6NTQNCj4+IFRvOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpIDxEYXZpZDEu
WmhvdUBhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4NCj4+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgY2xhbmctYnVpbHQtbGludXhAZ29v
Z2xlZ3JvdXBzLmNvbQ0KPj4gU3ViamVjdDogQ2xhbmcgd2FybmluZyBpbiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4+DQo+PiBIaSBhbGwsDQo+Pg0KPj4gVGhlIGlu
dHJvZHVjdGlvbiBvZiB0aGlzIGZpbGUgaW4gY29tbWl0IGRiZDI0OWMyNDQyNyAoImRybS9hbWRn
cHU6IGFkZCBhbWRncHVfcmFzLmMgdG8gc3VwcG9ydCByYXMgKHYyKSIpIGludHJvZHVjZXMgdGhl
IGZvbGxvd2luZyBDbGFuZw0KPj4gd2FybmluZ3M6DQo+Pg0KPj4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjU0NDoyMzogd2FybmluZzogaW1wbGljaXQgY29udmVyc2lv
biBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gYW1kZ3B1X3Jhc19ibG9jaycgdG8gZGlmZmVy
ZW50IGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gdGFfcmFzX2Jsb2NrJyBbLVdlbnVtLWNvbnZlcnNp
b25dDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgLmJsb2NrX2lkID0gIGhlYWQtPmJsb2Nr
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5efn5+fg0K
Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjU0NToyNDogd2Fybmlu
ZzogaW1wbGljaXQgY29udmVyc2lvbiBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gYW1kZ3B1
X3Jhc19lcnJvcl90eXBlJyB0byBkaWZmZXJlbnQgZW51bWVyYXRpb24gdHlwZSAnZW51bSB0YV9y
YXNfZXJyb3JfdHlwZScgWy1XZW51bS1jb252ZXJzaW9uXQ0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIC5lcnJvcl90eXBlID0gaGVhZC0+dHlwZSwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIH5+fn5+fl5+fn4NCj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yYXMuYzo1NDk6MjM6IHdhcm5pbmc6IGltcGxpY2l0IGNvbnZlcnNpb24gZnJv
bSBlbnVtZXJhdGlvbiB0eXBlICdlbnVtIGFtZGdwdV9yYXNfYmxvY2snIHRvIGRpZmZlcmVudCBl
bnVtZXJhdGlvbiB0eXBlICdlbnVtIHRhX3Jhc19ibG9jaycgWy1XZW51bS1jb252ZXJzaW9uXQ0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIC5ibG9ja19pZCA9ICBoZWFkLT5ibG9jaywNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+Xn5+fn4NCj4+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzo1NTA6MjQ6IHdhcm5pbmc6IGlt
cGxpY2l0IGNvbnZlcnNpb24gZnJvbSBlbnVtZXJhdGlvbiB0eXBlICdlbnVtIGFtZGdwdV9yYXNf
ZXJyb3JfdHlwZScgdG8gZGlmZmVyZW50IGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gdGFfcmFzX2Vy
cm9yX3R5cGUnIFstV2VudW0tY29udmVyc2lvbl0NCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAuZXJyb3JfdHlwZSA9IGhlYWQtPnR5cGUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB+fn5+fn5efn5+DQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmM6NjUwOjI2OiB3YXJuaW5nOiBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20gZW51
bWVyYXRpb24gdHlwZSAnZW51bSBhbWRncHVfcmFzX2Jsb2NrJyB0byBkaWZmZXJlbnQgZW51bWVy
YXRpb24gdHlwZSAnZW51bSB0YV9yYXNfYmxvY2snIFstV2VudW0tY29udmVyc2lvbl0NCj4+ICAg
ICAgICAgICAgICAgICAgLmJsb2NrX2lkID0gaW5mby0+aGVhZC5ibG9jaywNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5efn5+fg0KPj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjY1MTozNTogd2FybmluZzogaW1wbGljaXQgY29udmVy
c2lvbiBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gYW1kZ3B1X3Jhc19lcnJvcl90eXBlJyB0
byBkaWZmZXJlbnQgZW51bWVyYXRpb24gdHlwZSAnZW51bSB0YV9yYXNfZXJyb3JfdHlwZScgWy1X
ZW51bS1jb252ZXJzaW9uXQ0KPj4gICAgICAgICAgICAgICAgICAuaW5qZWN0X2Vycm9yX3R5cGUg
PSBpbmZvLT5oZWFkLnR5cGUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH5+fn5+fn5+fn5+Xn5+fg0KPj4gNiB3YXJuaW5ncyBnZW5lcmF0ZWQuDQo+Pg0KPj4gTm9y
bWFsbHksIEkgd291bGQgc2VudCBhIGZpeCBmb3IgdGhpcyBteXNlbGYgYnV0IEkgYW0gbm90IGVu
dGlyZWx5IHN1cmUgd2h5IHRoZXNlIHR3byBlbnVtZXJhdGVkIHR5cGVzIGV4aXN0IHdoZW4gb25l
IHdvdWxkIGRvIHNpbmNlIHRoZXkgaGF2ZSB0aGUgc2FtZSB2YWx1ZXMgbWludXMgdGhlIHByZWZp
eC4gSW4gZmFjdCwgdGhlIHRhX3Jhc197YmxvY2ssZXJyb3JfdHlwZX0gdmFsdWVzIGFyZSBuZXZl
ciB1c2VkIGFzaWRlIGZyb20gYmVpbmcgZGVmaW5lZC4gU29tZSBjbGFyaWZpY2F0aW9uIHdvdWxk
IGJlIGFwcHJlY2lhdGVkLg0KPj4NCj4+IFRoYW5rIHlvdSwNCj4+IE5hdGhhbg0KPiBIaSBYaW5o
dWksDQo+DQo+IFllcywgZXhwbGljaXRseSBjYXN0aW5nIHRoZXNlIHNpeCBzcG90cyB0byBpbnQg
d291bGQgcmVzb2x2ZSB0aGlzDQo+IHdhcm5pbmcuDQoNCkFub3RoZXIgcXVlc3Rpb24gaXMgaWYg
aXQgaXMgc3VjaCBhIGdvb2QgaWRlYSB0byBqdXN0IHNpbGVuY2UgdGhlIHdhcm5pbmc/DQoNCk1h
eWJlIGFkZCBhIGFtZGdwdV9yYXNfZXJyb3JfdG9fdGEoKSBoZWxwZXIgdG8gZG8gdGhpcyBjYXN0
aW5nPw0KDQpXaGVuIHRoZSBlbnVtcyBkcmlmdCBhd2F5IGZyb20gZWFjaCBvdGhlciB0aGVuIHdl
IGNhbiBzdGlsbCBhZGQgd2FybmluZ3MgDQp0byB0aGF0IGhlbHBlciB0byBtYWtlIHN1cmUgd2Ug
ZG9uJ3QgYWNjaWRlbnRhbGx5IGNhc3QgaW52YWxpZCB2YWx1ZXMgDQphcm91bmQuDQoNClJlZ2Fy
ZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gVGhhbmsgeW91IGZvciB0aGUgcXVpY2sgcmVzcG9uc2Uh
DQo+IE5hdGhhbg0KDQo=
