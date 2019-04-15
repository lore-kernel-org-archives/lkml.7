Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF636C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CB52073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="OY25rdYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfDOKDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:03:24 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:62575 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfDOKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:03:23 -0400
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id F3/4E-19010-5E654BC5; Mon, 15 Apr 2019 10:03:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSb0wTZxzHee6u19NQfSgQfjaCocoLjFdoyPS
  IwfiOZmYTNfhC2fCAgzZpS9eWSIcv6oiZgmQSOl0raK24ISjVAkYEQYg6u42w8Wd/nC/4Uxwj
  GDSDqIlT77ii25sn3zyf7/d+33vyY0j1NK1hhEqnYLfyZi29mjJm0NvYmf2dBZnB5ljuz6/DB
  Fd9MUhz89+fIbiatm6K63vWTnCjtxppLvDtMZKLXPiJ2MkY/KEKw7nwHkN/0xWlYaFvnDZ0P3
  crDf+EUvLoAwqTtai88pDCGJjItY2mVTZdznUjT1oNWs1QOEiC72qYrkGrGDU+TcCv9R9KQI0
  nEVzralwGNOag4cHEsk7AVbBwuY6UTCT+jgDP1FkRMEw8zoGGKZfs2QHdLY1RfzWC8fliSVM4
  DWa7vEjSKsxDx8uQQh62pIBXPTeUElglhpsD9yhJI5wMi0fbSEmTOAkeRs4TkgaMobl3mJR1I
  vw9/Voh+wUIf/E7ku+3wNBvESR1A5wKdROUfJ0MI+dro5aPoN3dvtwB8CMEoduPyZWsf3QuGu
  CgufZYVNvAO348Gl4Px+//i+TwGwWc7e8g5GcshqdNQ0rZlAKtdZOUbPqZhLFIQCk1InE6BG9
  lnELpvv/8m+89ka9TwVM7qfQtv1cchL0Ryo+oVsQV2U1lRqeFN5lZfWYmq9dnsVlstl7Hf87y
  OqGCLRasTjsvQh1/2KFzuCzF5hKdVXCGkLhkJZ+RB2+ilktlg2gdQ2gTVbuozgL1mqLyEpeRd
  xgL7RVmwTGI1jOMFlSsuIzqOLtQJlSWmszipq5gYGK1Cao8CascNt7iMJXJ6AeUzdwJTDaRjN
  f7l3g+GRBPNWUttwqaJFV+vhjAUsBYYX33uZXdH0HJmngViomJUcfaBLvF5Pw/n0NJDNLGqz6
  RxsaarM53U+fEQoRYyLOlTSrk5N8jjRv5qY83FQ1Y2smnvexSr+1C25Ge7A03IsQp5psc4cEg
  cuUdHfHvG6t3bavxuF8/WtxtvLt2fGbXp57OjJn+E79MFb75MeFw55PtH3TFpQgWak3DbNWXW
  xNS904v7DuRu/TV44cnt76YvtlYGszOr7/+R//9gRbD8HCumth4wFeVoylN11IOI6/fTNod/F
  vbQfl39gMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-223.messagelabs.com!1555322596!4203225!1
X-Originating-IP: [104.47.6.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27880 invoked from network); 15 Apr 2019 10:03:17 -0000
Received: from mail-ve1eur02lp2055.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.55)
  by server-18.tower-223.messagelabs.com with AES256-SHA256 encrypted SMTP; 15 Apr 2019 10:03:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+rGECt7KI0AQPpojzdUykdcimXMX+BlQ+jEEQvX6mE=;
 b=OY25rdYha+hjyRVqaLGx/sa7SBUX20euvJbPjutoqcJChT1TqVTVWJDkCxwqwztjiqUwjT12CsF/9l6KqmRsEQ6zelaFbkv5pwkHPH2/1GsxIQBYhIzYoP1SFanliBxfXxBdn/y0FaEtLRR69AN+etrHBejrlf6LC2bEhlBGbI4=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1170.EURPRD10.PROD.OUTLOOK.COM (10.169.155.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Mon, 15 Apr 2019 10:03:13 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971%4]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 10:03:13 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Kyle Tso <kyletso@google.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: typec: tcpm: collision avoidance
Thread-Topic: [PATCH v2] usb: typec: tcpm: collision avoidance
Thread-Index: AQHU4KspeY0Mu675x0axAclkvdJ7hKYsH+OAgAGJhQCABMDhgIABfVoAgAABNYCAABpfAIABSWkQgAAplQCAADE4AIAAB8BwgAAHRACABPoEgIACcoAg
Date:   Mon, 15 Apr 2019 10:03:13 +0000
Message-ID: <AM5PR1001MB099452876C75E45FD774BA77802B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190322121745.159768-1-kyletso@google.com>
 <20190404141345.GF21319@kuha.fi.intel.com>
 <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net>
 <CAGZ6i=2zKLhS4By8Xanc863G+jSxPYg8SLU-UHkY94r5MiEYag@mail.gmail.com>
 <20190409130230.GC20058@kuha.fi.intel.com>
 <20190409130649.GD20058@kuha.fi.intel.com>
 <9c9d17e3-bd99-c877-359c-a0a1b10a8d73@redhat.com>
 <AM5PR1001MB099440C3AA6DA6BA2AB0F2AE802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CAGZ6i=0rRgNH5bU-zcP58MNi+VSa+xeAQWL67egaZ-ui-ebmYA@mail.gmail.com>
 <9f9a2de9-2cfb-385c-8e99-54b2587113ce@redhat.com>
 <AM5PR1001MB09943830CFED9CB321CC883D802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <76a3c6df-63c0-78e7-c1ca-c83a30e95d38@redhat.com>
 <009662c6-2897-e2dd-03a7-992fc0a78599@redhat.com>
In-Reply-To: <009662c6-2897-e2dd-03a7-992fc0a78599@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c729f594-86fb-4d9e-420c-08d6c18992c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR1001MB1170;
x-ms-traffictypediagnostic: AM5PR1001MB1170:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB11707638F92C1FD3A1C254CAA72B0@AM5PR1001MB1170.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39850400004)(199004)(189003)(66066001)(105586002)(305945005)(478600001)(106356001)(93886005)(97736004)(72206003)(52536014)(33656002)(74316002)(2906002)(68736007)(25786009)(3846002)(14454004)(6116002)(5660300002)(7736002)(229853002)(316002)(5024004)(7696005)(14444005)(256004)(6506007)(53546011)(102836004)(4326008)(55016002)(6436002)(9686003)(476003)(53936002)(11346002)(446003)(486006)(86362001)(76176011)(99286004)(26005)(186003)(71190400001)(110136005)(54906003)(6246003)(8936002)(55236004)(81166006)(71200400001)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1170;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: InDzvSDVxQKnLf8nFQkPg8aMtDqR2zVQxRaQr96fhPIq6p/glDkWwWD6hH7HNygAEgb0x+0jriZ2T6Wzw+mF1squmCrzs6r20MKWyp5DniA+6+BfXf87e0KHrtm/jYmjQVb9Ue/JbdWEyl9HVjDHpLHlFJ9xTx9icw+wWHd5TDYFdmRHcbHHRryGkxu/cxjr4lJ0rSf4y2ov+H28VR3C9OZrgLyNXyG3HRY2slyl7wzIj5qyrFAoB2Bl5rEs9yTHd2mLabhybyJQzvEUZcKjpKEknKrKh2qRjt7m4bG3DuFowXq8hqg0Lq+FGfd5zGcOOpN89KfBEG8BiIKmVAtm0Kmm/ntDSEzsa1azGV3AU6XFjGWuQczyFbGnsjcbHkOi8IMaxWvuOMRFh3eDyrBOgCgCer0YdBy5lwtYenEdaio=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c729f594-86fb-4d9e-420c-08d6c18992c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 10:03:13.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMgQXByaWwgMjAxOSAyMTozOSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCg0KPiBPbiAxMC0w
NC0xOSAxODozOCwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gPiBPbiAxMC0wNC0xOSAxODoxNCwg
QWRhbSBUaG9tc29uIHdyb3RlOg0KPiA+PiBPbiAxMCBBcHJpbCAyMDE5IDE2OjQ1LCBIYW5zIGRl
IEdvZWRlIHdyb3RlOg0KPiANCj4gPHNuaXA+DQo+IA0KPiA+Pj4gU3RhcnRpbmcgdG9nZ2xpbmcg
ZnJvbSB0Y3BtX3NldF9jYygpIGp1c3QgZmVlbHMgd3Jvbmc7IGFuZCBjdXJyZW50bHkNCj4gPj4+
IHBvd2VyIHJvbGUgc3dhcHBpbmcgaXMgYnJva2VuIHdpdGggdGhlIGZ1c2IzMDIsIHdoaWNoIElJ
UkMgdXNlZCB0bw0KPiA+Pj4gd29yay4gSSBzdXNwZWN0IHRoaXMgaXMgcmVsYXRlZC4NCj4gPj4+
DQo+ID4+PiBJIHBsYW4gdG8gd3JpdGUgYSBwYXRjaCB0b21vcnJvdyB0byBmdW5jdGlvbmFsbHkg
dGFrZSB0Y3BtX3NldF9jYygpDQo+ID4+PiBiYWNrIHRvIHRoZSB3YXkgaXQgd2FzIGJlZm9yZS4g
VGhpcyBzaG91bGQgZml4IHlvdXIgY2FzZSBhbmQgSSBob3BlDQo+ID4+PiB0aGlzIGFsc28gZml4
ZXMgcG93ZXItcm9sZSBzd2FwcGluZy4NCj4gPj4+DQo+ID4+PiBUaGlzIHdpbGwgcmUtaW50cm9k
dWNlIEFkYW0gVGhvbXNvbidzIHByb2JsZW0sIGJ1dCBJIGhhdmUgYSBmZWVsaW5nDQo+ID4+PiB0
aGF0IHRoYXQgYWN0dWFsbHkgbmVlZHMgYSBmaXggaW4gdGhlIHRjcG0uYyBjb2RlIHJhdGhlciB0
aGVuIGF0IHRoZSBmdXNiMzAyDQo+IGxldmVsLg0KPiA+Pg0KPiA+PiBUbyBiZSBjbGVhciBoZXJl
LCB0aGUgbmFtZXMgVE9HR0xJTkdfTU9ERV9TTksgYW5kDQo+IFRPR0dMSU5HX01PREVfU1JDDQo+
ID4+IGFyZSBhIG1pc25vbWVyIGZyb20gdGhlIEhXIHNwZWMgZm9yIGZ1c2IzMDIuIFRoZSBkZXZp
Y2UgaXNuJ3QNCj4gPj4gdG9nZ2xpbmcgYW55dGhpbmcgYXMgZmFyIGFzIEknbSBhd2FyZSwgc28g
SSBkb24ndCBuZWNlc3NhcmlseSBhZ3JlZSB3aXRoIHlvdXINCj4gcG9pbnQuDQo+ID4NCj4gPiBJ
ZiBJIHVuZGVyc3RhbmQgdGhlIGRhdGFzaGVldCBjb3JyZWN0bHk6DQo+ID4NCj4gPiAiVGhlIEZV
U0IzMDIgaGFzIHRoZSBjYXBhYmlsaXR5IHRvIGRvIGF1dG9ub21vdXMgRFJQIHRvZ2dsZS4gSW4N
Cj4gPiBhdXRvbm9tb3VzIHRvZ2dsZSB0aGUgRlVTQjMwMiBpbnRlcm5hbGx5IGNvbnRyb2xzIHRo
ZSBQRFdOMSwgUERXTjIsDQo+ID4gUFVfRU4xIGFuZCBQVV9FTjIsIE1FQVNfQ0MxIGFuZCBNRUFT
X0NDMiBhbmQgaW1wbGVtZW50cyBhIGZpeGVkIERSUA0KPiA+IHRvZ2dsZSBiZXR3ZWVuIHByZXNl
bnRpbmcgYXMgYSBTUkMgYW5kIHByZXNlbnRpbmcgYXMgYSBTTksuDQo+ID4gQWx0ZXJuYXRlbHks
IGl0IGNhbiBwcmVzZW50IGFzIGEgU1JDIG9yIFNOSyBvbmx5IGFuZCBwb2xsIENDMSBhbmQgQ0My
DQo+ID4gY29udGludW91c2x5LiINCj4gPg0KPiA+IEl0IGlzIHN0aWxsIGF0dGFjaGluZyBScCBy
ZXNwIFJkIHRvIENDMSBvciBDQzIgb25lIGF0IGEgdGltZSB0byBkZXRlY3QNCj4gPiBwb2xhcml0
eSwgc28gaXQgaXMgc3RpbGwgdG9nZ2xpbmcsIGl0IGp1c3QgaXMgbm90IGRvaW5nIGR1YWwtcm9s
ZQ0KPiA+IHRvZ2dsaW5nLiBUaGlzIGlzIGFsc28gZXhwZWN0ZWQgYmVoYXZpb3IgZm9yIGEgc2lu
aywgYSBzaW5rIG1heSBub3QNCj4gPiBwcmVzZW50IFJkIG9uIGJvdGggQ0MgcGlucyBhdCB0aGUg
c2FtZSB0aW1lLCBvdGhlcndpc2UgdGhlIHNvdXJjZQ0KPiA+IGNhbm5vdCBkZXRlY3QgdGhlIHBv
bGFyaXR5IGFuZCB0aGUgc291cmNlIGFsc28gY2Fubm90IGRldGVjdCBpZiBWY29ubg0KPiA+IGlz
IG5lY2Vzc2FyeS4NCj4gPg0KPiA+PiBJdCdzIGEgbWVjaGFuaXNtIHRvDQo+ID4+IGhhdmUgdGhl
IEhXIHJlcG9ydCB3aGVuIHRoZSBDQyBsaW5lIGNoYW5nZXMgb24gY29ubmVjdGlvbi4gV2l0aG91
dA0KPiA+PiB0aGF0IHdlIGhhdmUgbm8gcmVwb3J0aW5nIGZyb20gdGhlIEhXIGZvciB0aGUgZml4
ZWQgcm9sZSBzY2VuYXJpb3MuDQo+ID4NCj4gPiBOb3QganVzdCBjb25uZWN0aW9uLCBhbHNvIHBv
bGFyaXR5IGRldGVjdGlvbi4gTm90aWNlIHRoYXQgdGhlIHRjcG0NCj4gPiBmcmFtZXdvcmsgLyB0
aGUgZHJpdmVyIGFsc28gaGFzIGEgc3RhcnRfZHJwX3RvZ2dsaW5nKCkgbWV0aG9kLiBJIHRoaW5r
DQo+ID4gd2UgbWF5IGFsc28gbmVlZCBhIHN0YXJ0X3NycF90b2dnbGluZyBmdW5jdGlvbiBqdXN0
IGxpa2UgaXQgYW5kIGNhbGwNCj4gPiB0aGF0IGZyb20gdGhlIFNOS19VTkFUVEFDSEVEIGFuZCBT
UkNfVU5BVFRBQ0hFRCBzdGF0ZXMgZm9yIHNpbmdsZS1yb2xlDQo+ID4gcG9ydHMuIEkgYWdyZWUg
dGhhdCB3ZSBuZWVkIHRvIHN0YXJ0IHRvZ2dsaW5nIHdoZW4gaW4gdGhvc2Ugc3RhdGVzLA0KPiA+
IGJ1dCB0Y3BtX3NldF9jYyBnZXRzIGNhbGxlZCBpbiBhIGxvdCBvZiBvdGhlciBwbGFjZXMgd2hl
cmUgQUZBSUsgd2UNCj4gPiBzaG91bGQgTk9UIHJlc3RhcnQgdG9nZ2xpbmcgYW5kIHlvdXIgcGF0
Y2ggY2F1c2VzIHVzIHRvIHJlc3RhcnQNCj4gPiB0b2dnbGluZyBpbiB0aG9zZSBjYXNlcy4NCj4g
DQo+IE9rLCBzbyBhcyBJIHN1c3BlY3RlZCwgY29tbWl0IGVhM2I0ZDU1MjNiYyAoInVzYjogdHlw
ZWM6IGZ1c2IzMDI6DQo+IFJlc29sdmUgZml4ZWQgcG93ZXIgcm9sZSBjb250cmFjdCBzZXR1cCIp
IGlzIHdoYXQgY2F1c2VkIHRoZSBwb3dlci1yb2xlDQo+IHN3YXBwaW5nIGJyZWFrYWdlIEkndmUg
YmVlbiBzZWVpbmcuDQoNCkFwb2xvZ2llcyBmb3IgdGhlIGJyZWFrYWdlLiBBbm5veWVkIEkgZGlk
bid0IGNhdGNoIHRoYXQgd2hlbiBzdWJtaXR0aW5nIHRoYXQNCnBhdGNoLiBUaGFua3MgZm9yIGxv
b2tpbmcgdG8gcmVzb2x2ZSB0aGlzIGFuZCB3aWxsIHJldmlldyB5b3VyIHVwZGF0ZXMgc2hvcnRs
eS4NCiANCj4gU28gSSd2ZSBwcmVwYXJlZCBhIDMgcGF0Y2ggc2VyaWVzOg0KPiANCj4gMSkgQWRk
IGEgbmV3IHN0YXJ0X3NycF9jb25uZWN0aW9uX2RldGVjdCBmdW5jdGlvbiB3aGljaCwgd2hlbiBp
bXBsZW1lbnRlZA0KPiBieSB0aGUgdGNwY19kZXYsIGdldHMgY2FsbGVkIGluc3RlYWQgb2Ygc3Rh
cnRfZHJwX3RvZ2dsaW5nIGZvciBzaW5nbGUgcm9sZSBwb3J0cw0KPiAoU1JQcykNCj4gDQo+IDIp
IEltcGxlbWVudCAxLiBmb3IgZnVzYjMwMiB0byBmaXggdGhlIFNSUCBpc3N1ZSBBZGFtIHdhcyBz
ZWVpbmcsIHdpdGhvdXQNCj4gZGVwZW5kaW5nIG9uIHNldF9jYyBzdGFydGluZyAidG9nZ2xpbmci
DQo+IG9yIHNvbWV0aGluZyBsaWtlIGl0IGZvciB0aGUgZml4DQo+IA0KPiAzKSBSZXZlcnQgY29t
bWl0IGVhM2I0ZDU1MjNiYywgcmVzdG9yaW5nIHBvd2VyLXJvbGUgc3dhcCBmdW5jdGlvbmFsaXR5
Lg0KPiANCj4gVGhpcyBzaG91bGQgYWxzbyBmaXggdGhlIGlzc3VlIEt5bGUgVHNvIHdhcyBzZWVp
bmcgd2hlbiB0cnlpbmcgdG8gY2hhbmdlIGZyb20gb25lDQo+IFJwIHNldHRpbmcgdG8gYW5vdGhl
ci4NCj4gDQo+IEknbGwgc2VuZCBvdXQgdGhlIHNlcmllcyByaWdodCBhZnRlciB0aGlzIGVtYWls
Lg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCg0K
