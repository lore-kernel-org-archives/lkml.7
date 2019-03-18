Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B55320863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="XFXX2Xf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfCRQMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:12:15 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:57252 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbfCRQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:12:14 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 67/1C-06417-F43CF8C5; Mon, 18 Mar 2019 16:11:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSe0hTcRT2t3vvdg1vXTdlx5FBg6KiLUcPtiI
  qCBLsBf1TUdlVb9tgTtuuuFWEFuUjwt6PlVouHGhkjughvbRGLzRdZaksG66s5avXKDHp3t31
  +ufHd873nXO+8+OQmLxdqiJZB8farIxFLZ2Am+aQBs2aexWb0jqOTNcfD4ak+vpPfUgfeV4q0
  T9rOivVV3S4iKVE+g1XQJburSuTpr/7vl+a/sU7ZS2+kTBbs/IcWwlTu68dz7+ocgyN9aMiVK
  QqRxNInG7AYLz0qEwI5PQhCXR6fFIx6EXw8duYpBzFk1JaB1UDw0ggkugaBCXuMlwIMHovgjP
  +L0hQKej1cKv+Ni7gJHoDFLUNYCJeCGX7PDyW8QOnwed1QpaiN4MvfJ8QsJy2wc99J2UCjqcX
  Q6j3SbQLolPha3F9tAtGK6E7VB31AzQNF24+xUScDB/6xglRnwkldwZlYn42tL4MIRGrofaVi
  xBxKvirD8Tyq+De5c7owkB3I3Dd3hMTzYKrvvcxkQWOvOiJDZ4Mzx6el4gF7wkIfK+QiBtkw0
  hla2zyFKg7GMRFUTsGkdeveBHJrzATGprmiNtMhWMHgrJDaIbrn+Vcf1Wuf1Su6H8lwqPTIfw
  cwuuQIctmNpq4XMZs0ejS0jQ63VzNPI3OsEDL7NBkadkCTTZr5WwMz2qZQrvW7szNtuRorSzn
  RfxF5WzH719HwyXGFpRCStTJ1NcbFZvkE7Pycpwmxm7KtBVYWHsLmkySaqBWtPBcoo01so5tZ
  gt/lr9pIBPUSVRXM09T9nwm1242itRjZCDv1gQrMXKwuZ9/z3WNVmFy3JpnZVVKihUKaKHAVG
  D90+73oftRqkpBobi4OHlCPmvLNXP/82GkJJFaQa0TXCWYrdyfqWHekIQ3dKkqaohj/lKqIlQ
  /8OTH6pQ1nsCyWso9qY98u+P0lYyjQe7UEvVOVfG1ut098z88P9a2K+JpHsUCkQJHuHDbyEhG
  OFKNkv0t2887Vx4u3/KGeOENedHmMYXv1sHlxUpn4p2BykXuBzUdgcRBd/kJo0LZOCPzUkZKL
  TeeOvQtxdlYu1UlO+t81LRejdtNjG4WZrMzvwBSjYkQ4wMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-19.tower-239.messagelabs.com!1552925519!2732681!1
X-Originating-IP: [104.47.8.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4544 invoked from network); 18 Mar 2019 16:11:59 -0000
Received: from mail-am5eur03lp2057.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.57)
  by server-19.tower-239.messagelabs.com with AES256-SHA256 encrypted SMTP; 18 Mar 2019 16:11:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qBBR9Q9JdWBkHGFDEPqutzMbjKZDcWBcsYwieMev0Q=;
 b=XFXX2Xf/rzFhwWnqb/Xv7zMqsFvRH5+mPAItLr6SQaKPnWqNjiWvXlpiQlPBKf75hyFhcKeG/KW50GpvgFsDlyTG75C8nhh4Q0kXq8zEBXH7m/3jIKsrVlDWWN2RgNLkdZp0ckqVTnkaXmjiUv7CbGqiT9/t8MwMELUTNqa9IPI=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2720.EURPRD10.PROD.OUTLOOK.COM (20.178.127.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 16:11:58 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 16:11:58 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Maciej Purski <m.purski@samsubg.com>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] regulator: core: fix error path for
 regulator_set_voltage_unlocked
Thread-Topic: [PATCH] regulator: core: fix error path for
 regulator_set_voltage_unlocked
Thread-Index: AQHU3aJihjsaU6EEr0CeM4yEgE+XmqYRjPCAgAAAOnA=
Date:   Mon, 18 Mar 2019 16:11:58 +0000
Message-ID: <VI1PR10MB2352D4EA677EEEA246BAFC16FE470@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318155054.59B483FBD8@swsrvapps-01.diasemi.com>
 <513a7028-b972-a821-7bf1-0e105bf71305@gmail.com>
In-Reply-To: <513a7028-b972-a821-7bf1-0e105bf71305@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f20dec5-bf79-4ba6-ca3a-08d6abbc72ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2720;
x-ms-traffictypediagnostic: VI1PR10MB2720:
x-microsoft-antispam-prvs: <VI1PR10MB2720DA5C3045A105ABC1CCF6F5470@VI1PR10MB2720.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(366004)(376002)(136003)(199004)(189003)(81166006)(99286004)(81156014)(8936002)(105586002)(71200400001)(5660300002)(316002)(6436002)(71190400001)(52536014)(26005)(110136005)(54906003)(106356001)(102836004)(14454004)(7696005)(33656002)(97736004)(6506007)(53546011)(86362001)(76176011)(229853002)(446003)(256004)(9686003)(66066001)(68736007)(2906002)(478600001)(11346002)(305945005)(186003)(7736002)(14444005)(476003)(4326008)(53936002)(74316002)(55016002)(486006)(6246003)(3846002)(107886003)(6116002)(25786009)(8676002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2720;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hjTIMNZzB/0KfOdm06uVBvg3+OSd4rSCpRZwLHZj4qtTwmLRef9i8j9Xxqu5mAQVdZ/wXCH+m4h1AMV2FMbaxhec/z/qRr1sDYFfJB81zGKTN+uK65VVyNM4rSBID/5OqyuRTj9CFabrRvNx8P+mMJGJjgg06qmBHCwhBvMWI1gJKs8VYAVV8UgLGZRVol2ePuR/2Ywxgz+jbaPUShj2y0l7/WUaVNC4DArkDnjIe5nvYUervF8Jnr8GtgzxxyMrm/lvYiWmJ9JeUASlZfdePQXc56iJt4/93IbzdPWsTYFOALqdiTLWrzkNBmE5GL1LUs+14JThOCM8f7PfKj8ixYkI7TU3FDvQRf1wRDHCXt4IgIgP6qSoGN415RK8xpIAUXqMCKWZKljkgBv61Mod30POs42kEDx3xip4Y+sJ2Qw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f20dec5-bf79-4ba6-ca3a-08d6abbc72ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 16:11:58.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpUaGFua3MsDQoNCk9uIDE4IE1hcmNoIDIwMTkgMTY6MDMsIERtaXRyeSBP
c2lwZW5rbyB3cm90ZToNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSByZWd1bGF0b3I6IGNvcmU6
IGZpeCBlcnJvciBwYXRoIGZvcg0KPiByZWd1bGF0b3Jfc2V0X3ZvbHRhZ2VfdW5sb2NrZWQNCj4g
DQo+IDE4LjAzLjIwMTkgMTg6MzIsIFN0ZXZlIFR3aXNzINC/0LjRiNC10YI6DQo+ID4gRHVyaW5n
IHNldmVyYWwgZXJyb3IgcGF0aHMgaW4gdGhlIGZ1bmN0aW9uDQo+ID4gcmVndWxhdG9yX3NldF92
b2x0YWdlX3VubG9ja2VkKCkgdGhlIHZhbHVlIG9mICdyZXQnIGNhbiB0YWtlIG9uIG5lZ2F0aXZl
DQo+ID4gZXJyb3IgdmFsdWVzLiBIb3dldmVyLCBpbiBjYWxscyB0aGF0IGdvIHRocm91Z2ggdGhl
ICdnb3RvIG91dCcgc3RhdGVtZW50LA0KPiA+IHRoaXMgcmV0dXJuIHZhbHVlIGlzIGxvc3QgYW5k
IHJldHVybiAwIGlzIHVzZWQgaW5zdGVhZCwgaW5kaWNhdGluZyBhDQo+ID4gJ3Bhc3MnLg0KPiA+
DQo+ID4gVGhlcmUgYXJlIHNldmVyYWwgY2FzZXMgd2hlcmUgdGhpcyBmdW5jdGlvbiBzaG91bGQg
bGVnaXRpbWF0ZWx5IHJldHVybiBhDQo+ID4gZmFpbCBpbnN0ZWFkIG9mIGEgcGFzczogb25lIHN1
Y2ggY2FzZSBpbmNsdWRlcyBjb25zdHJhaW50cyBjaGVjayBkdXJpbmcNCj4gPiB2b2x0YWdlIHNl
bGVjdGlvbiBpbiB0aGUgY2FsbCB0byByZWd1bGF0b3JfY2hlY2tfdm9sdGFnZSgpLCB3aGljaCBj
YW4NCj4gPiBoYXZlIC1FSU5WQUwgZm9yIHRoZSBjYXNlIHdoZW4gYW4gdW5zdXBwb3J0ZWQgdm9s
dGFnZSBpcyBpbmNvcnJlY3RseQ0KPiA+IHJlcXVlc3RlZC4gSW4gdGhhdCBjYXNlLCAtMjIgaXMg
ZXhwZWN0ZWQgYXMgdGhlIHJldHVybiB2YWx1ZSwgbm90IDAuDQo+ID4NCj4gPiBGaXhlczogOTI0
M2ExOTViZTdhICgicmVndWxhdG9yOiBjb3JlOiBDaGFuZ2Ugdm9sdGFnZSBzZXR0aW5nIHBhdGgi
KQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIFR3aXNzIDxzdHdpc3Mub3BlbnNvdXJjZUBkaWFz
ZW1pLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZWd1bGF0b3IvY29yZS5jIHwgMiArLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9jb3JlLmMgYi9kcml2ZXJzL3JlZ3Vs
YXRvci9jb3JlLmMNCj4gPiBpbmRleCA2ODQ3M2QwLi5jYWY4NzQzIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvcmVndWxhdG9yL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcmVndWxhdG9yL2Nv
cmUuYw0KPiA+IEBAIC0zMzI2LDcgKzMzMjYsNyBAQCBzdGF0aWMgaW50IHJlZ3VsYXRvcl9zZXRf
dm9sdGFnZV91bmxvY2tlZChzdHJ1Y3QNCj4gcmVndWxhdG9yICpyZWd1bGF0b3IsDQo+ID4gIAkJ
Z290byBvdXQyOw0KPiA+DQo+ID4gIG91dDoNCj4gPiAtCXJldHVybiAwOw0KPiA+ICsJcmV0dXJu
IHJldDsNCj4gPiAgb3V0MjoNCj4gPiAgCXZvbHRhZ2UtPm1pbl91ViA9IG9sZF9taW5fdVY7DQo+
ID4gIAl2b2x0YWdlLT5tYXhfdVYgPSBvbGRfbWF4X3VWOw0KPiA+DQo+IA0KPiBMb29rcyBsaWtl
IGEgZ29vZCBjYXRjaC4NCj4gDQo+IFByb2JhYmx5IHdpbGwgYmUgYSBiaXQgYmV0dGVyIHRvIHdy
aXRlIHRoaXMgYXM6DQo+IA0KPiAgICAgICAgIC8qIGZvciBub3QgY291cGxlZCByZWd1bGF0b3Jz
IHRoaXMgd2lsbCBqdXN0IHNldCB0aGUgdm9sdGFnZSAqLw0KPiAgICAgICAgIHJldCA9IHJlZ3Vs
YXRvcl9iYWxhbmNlX3ZvbHRhZ2UocmRldiwgc3RhdGUpOw0KPiAtICAgICAgIGlmIChyZXQgPCAw
KQ0KPiAtICAgICAgICAgICAgICAgZ290byBvdXQyOw0KPiAtDQo+ICsgICAgICAgaWYgKHJldCA8
IDApIHsNCj4gKyAgICAgICAgICAgICAgIHZvbHRhZ2UtPm1pbl91ViA9IG9sZF9taW5fdVY7DQo+
ICsgICAgICAgICAgICAgICB2b2x0YWdlLT5tYXhfdVYgPSBvbGRfbWF4X3VWOw0KPiArICAgICAg
IH0NCj4gIG91dDoNCj4gLSAgICAgICByZXR1cm4gMDsNCj4gLW91dDI6DQo+IC0gICAgICAgdm9s
dGFnZS0+bWluX3VWID0gb2xkX21pbl91VjsNCj4gLSAgICAgICB2b2x0YWdlLT5tYXhfdVYgPSBv
bGRfbWF4X3VWOw0KPiAtDQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCg0KSSd2ZSBqdXN0
IGhhZCBhIHZlcnkgc2ltaWxhciBjb252ZXJzYXRpb24gd2l0aCBBZGFtIFRob21zb24gd2hvIHNp
dHMgbmVhciBtZSBhbmQgYWxzbyANCnNhaWQgdGhlIHR3byBnb3RvcyBtYWtlIGl0IGxvb2sgY29u
ZnVzaW5nLg0KDQpIb25lc3RseSAtLSBJIHdhc24ndCBjb252aW5jZWQgYmVjYXVzZSBpdCBsb29r
ZWQgb2J2aW91cyB0byBtZSwgYnV0IHlvdSBhcmUgdGhlIHNlY29uZA0KcGVyc29uIHRvIHNheSBp
dCAuLiANCkNDOiBBZGFtIFRob21zb24NCg0KU28sIG9rLiBBZ3JlZWQuIDopDQpJJ2xsIG1ha2Ug
dGhlIGNoYW5nZSBhbmQgcmVzZW5kLg0KDQpSZWdhcmRzLA0KU3RldmUNCg==
