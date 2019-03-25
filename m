Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222BCC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7DD20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aiI8jAeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfCYVAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:00:42 -0400
Received: from mail-eopbgr690106.outbound.protection.outlook.com ([40.107.69.106]:53824
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729123AbfCYVAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnhMcKoUYAcC65LqpnTkteBejltTql7XI5FRJC1UKJw=;
 b=aiI8jAeHkS9T3sEObX+d69M+gcSzRcEL/pf7QqSpUhhbm7m6cfJ1WoRT5RC015itgRPy2Ijhr/fkCPlYn7zB//kor1XU+ujxvPOiRzJ5Ip1hd7upzLWeYX4PUDpjoGN6sgsqZWnSU4Z4ImL/jo5R8AAkWxvzfWMZxCuiXIWGCeA=
Received: from DM6PR21MB1305.namprd21.prod.outlook.com (20.179.52.94) by
 DM6PR21MB1243.namprd21.prod.outlook.com (20.179.50.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.2; Mon, 25 Mar 2019 21:00:37 +0000
Received: from DM6PR21MB1305.namprd21.prod.outlook.com
 ([fe80::5d7:1d10:7a44:6620]) by DM6PR21MB1305.namprd21.prod.outlook.com
 ([fe80::5d7:1d10:7a44:6620%7]) with mapi id 15.20.1771.002; Mon, 25 Mar 2019
 21:00:37 +0000
From:   Lakshmi Ramasubramanian <nramas@microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Portable Executable (PE) Signature Validation and Measurement for
 KEXEC system call using IMA
Thread-Topic: Portable Executable (PE) Signature Validation and Measurement
 for KEXEC system call using IMA
Thread-Index: AdTg1clupl0uJvoTS1+4SCE/Pu8WqwCawh8AAAMIjWA=
Date:   Mon, 25 Mar 2019 21:00:36 +0000
Message-ID: <DM6PR21MB13056915DA6AFF16C3753915C35E0@DM6PR21MB1305.namprd21.prod.outlook.com>
References: <BYAPR21MB1301CBCD4956476F8F2F0FC4C3430@BYAPR21MB1301.namprd21.prod.outlook.com>
 <1553542064.3929.69.camel@linux.ibm.com>
In-Reply-To: <1553542064.3929.69.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=nramas@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-25T21:00:33.7664497Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2675b61c-7cd5-4d33-96ed-3a3cf30233d5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:7:1078:7225:fd33:4f42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4264a87c-d6ca-4bf6-d766-08d6b164ee79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1243;
x-ms-traffictypediagnostic: DM6PR21MB1243:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR21MB1243562DF34483B7BB7E8A17C35E0@DM6PR21MB1243.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(13464003)(51914003)(486006)(446003)(476003)(7736002)(11346002)(81156014)(9686003)(229853002)(97736004)(33656002)(6246003)(305945005)(53936002)(22452003)(46003)(316002)(478600001)(6306002)(256004)(105586002)(966005)(55016002)(8936002)(52536014)(10090500001)(8990500004)(6436002)(5660300002)(6116002)(99286004)(6506007)(186003)(76176011)(7696005)(102836004)(6346003)(2501003)(14444005)(86612001)(110136005)(2906002)(14454004)(68736007)(86362001)(2201001)(71200400001)(71190400001)(8676002)(10290500003)(25786009)(81166006)(74316002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1243;H:DM6PR21MB1305.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nramas@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cu0V/d1xc8A6yfAAm9eAdOHrp4sbJhxPrVNsUlU1wG17sW4RXYajAdCp26RNn/BDFqVWuKT9as+At4XD7h5EKG5qshX0jnHgVmwX4Tgx88ygaO53O8W967R20IWjen13neuZ5VeWGjGsfszXy3k1xjcCR+gAc1hF975RUm3LwMFOpKGb0a9V/PES3oCr91ooIRXaSx8QOYq5iDc2n0Ukto77Y6m5VdEhAyA60LK80gIwikWajmU8hm0kahrCNwtSsL4/FR2dM6mUhTfS95RkO83U5S97Dl4gDboUlRso4GTK/QOS8TJiz51ff1weQGI3TPzAWpHJ1/cC98ne/zj12mWsnykq/EfksIBTD5ot7sON4pG13S4a/nqEn6dDQKjt88p5CJ/3YyqphNJLSLcQosJ8QADyBIaVAfsRRD47Zgo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4264a87c-d6ca-4bf6-d766-08d6b164ee79
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 21:00:37.3703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1243
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlIE1pbWkuDQoNClBsZWFzZSBzZWUgbXkgcmVzcG9uc2Vz
IHRvIHlvdXIgcXVlcmllcyBpbmxpbmUuIA0KDQpUaGFua3MsDQogLWxha3NobWkNCg0KPi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWltaSBab2hhciA8em9oYXJAbGludXguaWJt
LmNvbT4gDQo+U2VudDogTW9uZGF5LCBNYXJjaCAyNSwgMjAxOSAxMjoyOCBQTQ0KPlRvOiBMYWtz
aG1pIFJhbWFzdWJyYW1hbmlhbiA8bnJhbWFzQG1pY3Jvc29mdC5jb20+OyBsaW51eC1pbnRlZ3Jp
dHlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVj
dDogUmU6IFBvcnRhYmxlIEV4ZWN1dGFibGUgKFBFKSBTaWduYXR1cmUgVmFsaWRhdGlvbiBhbmQg
TWVhc3VyZW1lbnQgZm9yIEtFWEVDIHN5c3RlbSBjYWxsIHVzaW5nIElNQQ0KDQo+SGkgTGFrc2ht
aSwNCg0KPk9uIEZyaSwgMjAxOS0wMy0yMiBhdCAxNzozOSArMDAwMCwgTGFrc2htaSBSYW1hc3Vi
cmFtYW5pYW4gd3JvdGU6DQo+PiBIZWxsbywNCj4+IA0KPj4gV2hlbiBsb2FkaW5nIHRoZSBuZXcg
a2VybmVsIGltYWdlIGZpbGUgZm9yIGV4ZWN1dGluZyBLRVhFQyBzeXN0ZW0gY2FsbCwgDQo+PiB3
ZSB3b3VsZCBsaWtlIHRvIHZlcmlmeSB0aGF0IHRoZSBrZXJuZWwgaW1hZ2UgZmlsZSBpcyBzaWdu
ZWQgYW5kIA0KPj4gdGhlIHNpZ25lciBjZXJ0aWZpY2F0ZSBpcyB2YWxpZC4NCj4+DQoNCj4gSSdt
IG5vdCBzdXJlIHdoYXQgaXMgbWVhbnQgYnkgImFuZCB0aGUgc2lnbmVyIGNlcnRpZmljYXRlIGlz
IHZhbGlkIi4NCg0KPiBUaGUga2V4ZWMga2VybmVsIGltYWdlIHNpZ25hdHVyZSBjYW4gYmUgdmVy
aWZpZWQgYnkga2V5cyBlaXRoZXIgb24gdGhlDQo+IElNQSBrZXlyaW5nIG9yIHRoZSBwbGF0Zm9y
bSBrZXlyaW5nLiDCoFRoZSBjdXJyZW50IG1ldGhvZCBvZiB2ZXJpZnlpbmcNCj4ga2V5cyBiZWlu
ZyBhZGRlZCB0byB0aGUgSU1BIGtleXJpbmcgaXMgYnkgcmVxdWlyaW5nIHRoZW0gdG8gYmUgc2ln
bmVkDQo+IGJ5IGEga2V5IG9uIHRoZSBidWlsdGluIHRydXN0ZWQga2V5cmluZy4gwqBUaGlzIHBy
b3ZpZGVzIGEgc2lnbmF0dXJlDQo+IGNoYWluIG9mIHRydXN0IGZyb20gYm9vdCB0byB0aGUga2Vy
bmVsLCBiYXNlZCBvbiBhIEhXIHJvb3Qgb2YgdHJ1c3QsDQo+IGFuZCB0aGVuIHRyYW5zaXRpb25z
IHRvIHRoZSBrZXJuZWwgaW1hZ2UncyBlbWJlZGRlZCBrZXlzLiDCoFlvdQ0KPiBwcm9iYWJseSBh
bHJlYWR5IGtub3cgYXMgdG8gd2h5L2hvdyB0aGUgcGxhdGZvcm0ga2V5cyBhcmUgdHJ1c3RlZC4N
Cg0KW0xha3NobWldIEJ5ICJzaWduZXIgY2VydGlmaWNhdGUgaXMgdmFsaWQiIEkgbWVhbnQsIHRo
ZSBrZXkgdXNlZCB0byBzaWduIHRoZSBrZXhlYyBrZXJuZWwgaW1hZ2UgaXMgdHJ1c3RlZC4gDQog
ICAgICAgICAgICAgICAgICBXZSB3aWxsIHZlcmlmeSB0aGUgc2lnbmF0dXJlIHVzaW5nIHRoZSBr
ZXkgaW4gdGhlIElNQSBrZXlyaW5nIA0KICAgICAgICAgICAgICAgICAgKGxpa2UgdGhlIHdheSB5
b3UgaGF2ZSBkZXNjcmliZWQgYWJvdmUpDQoNCj4+IA0KPj4gSWYgdGhlIGtlcm5lbCBpbWFnZSBm
aWxlIGlzIGluIFBvcnRhYmxlIEV4ZWN1dGFibGUgKFBFKSBmb3JtYXQgd2Ugd2FudCB0byANCj4+
IHZhbGlkYXRlIHRoZSBQRSBTaWduYXR1cmUgYW5kIG1lYXN1cmUgdGhlIHNpZ25lciBYLjUwOSBj
ZXJ0aWZpY2F0ZSANCj4+IChFeHRlbmQgYXMgcGFydCBvZiBJTUEgVGVtcGxhdGUgZGVmYXVsdGlu
ZyB0byBQQ1IgMTAsIGlmIG5vdCBvdGhlcndpc2Ugc2V0LCANCj4+ICBhbmQgdGhlIElNQSBtZWFz
dXJlbWVudCBsb2cpLg0KDQo+IEhvdy93aGVuIGRvIHlvdSBwbGFuIHRvICJtZWFzdXJlIHRoZSBz
aWduZXIgWC41MDkgY2VydGlmaWNhdGUiPyDCoElzDQo+IHRoaXMgd2hlbiB0aGUgY2VydGlmaWNh
dGUgaXMgYmVpbmcgbG9hZGVkIG9udG8gdGhlIGtleXJpbmcgb3IgYXQgdXNlPw0KPsKgSSdtIG5v
dCBzdXJlIGhvdyBtdWNoIG9mIHRoZSBjZXJ0aWZpY2F0ZSBpcyBhdmFpbGFibGUgb25jZSBsb2Fk
ZWQNCj4gb250byB0aGUga2V5cmluZy4NCg0KW0xha3NobWldIFdlIHdpbGwgbWVhc3VyZSB0aGUg
c2lnbmVyIGNlcnRpZmljYXRlIHdoZW4gdGhlIGZpbGUgaXMgbG9hZGVkIC0gaW4gb3RoZXIgd29y
ZHMsICJhdCB1c2UiLg0KVGhlIGtlcm5lbCBpbWFnZSBzaWduZXIgaW5mb3JtYXRpb24gbWVhc3Vy
ZWQgaW4gdG8gdGhlIElNQSBsb2cgd2lsbCB0aGVuIGJlIHVzZWQgYXMgb25lIG9mIHRoZSBhdHRl
c3RhdGlvbiBjcml0ZXJpYS4NCg0KPj4gDQo+PiBXZSBwbGFuIHRvIHVzZSBJbnRlZ3JpdHkgTWVh
c3VyZW1lbnQgQXJjaGl0ZWN0dXJlIChJTUEpIGZvciB0aGUgYWJvdmUuDQo+PiANCj4+IFBsZWFz
ZSBsZXQgdXMga25vdyBpZiBhbnlvbmUgaXMgYWxyZWFkeSB3b3JraW5nIG9uIGEgcGF0Y2ggc2V0
DQo+PiBmb3Igc3VjaCBhIGZ1bmN0aW9uYWxpdHkuDQo+PiANCj4+IEkgYW0gYXdhcmUgb2YgdGhl
IHdvcmsgdGhhdCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gQCBJQk0gaXMgZG9pbmcgZm9yIA0KPj4g
IkFwcGVuZGVkIHNpZ25hdHVyZXMgc3VwcG9ydCBmb3IgSU1BIGFwcHJhaXNhbCIgDQo+PiAoV2Vi
IGxpbmsgZ2l2ZW4gYmVsb3cpDQo+PiANCj4+ICAgICBodHRwczovL25hbTA2LnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLm9yZyUyRmxrbWwl
MkYyMDE4JTJGMTIlMkYxMiUyRjEwNDkmYW1wO2RhdGE9MDIlN0MwMSU3Q25yYW1hcyU0MG1pY3Jv
c29mdC5jb20lN0NjMzZkNDJjYjkxMjE0Y2MzY2ExMzA4ZDZiMTU3Zjk2MiU3QzcyZjk4OGJmODZm
MTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2MzY4OTEzODg3NDU1NDg4NzkmYW1wO3Nk
YXRhPU9MdGt1cHRYUVlaSHV2bFZtbjNlaiUyRnBFazUwMVR4elRvRWNiT3JlZjBVVSUzRCZhbXA7
cmVzZXJ2ZWQ9MA0KDQo+IE90aGVyIHRoYW4gVGhpYWdvLCBJJ20gbm90IGF3YXJlIG9mIGFueW9u
ZSBlbHNlIHdvcmtpbmcgb24gdGhpcy4NCj4gwqBUaGlhZ28gaXMgYWN0aXZlbHkgd29ya2luZyBv
biB0aGVzZSBwYXRjaGVzIGFuZCB3aWxsIGJlIHJlLXBvc3RpbmcNCj4gdGhlbSBzaG9ydGx5Lg0K
DQpbTGFrc2htaV0gVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uDQoNCj4gTWltaQ0KDQpUaGFu
a3MsDQogLWxha3NobWkNCg0K
