Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6764321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="k3IbCIsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfDXKgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:36:40 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:43007 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbfDXKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:36:40 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 84/F9-23082-33C30CC5; Wed, 24 Apr 2019 10:36:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSa0hTYRj22zmbp3Dxubl8Gym0kMzacmoxtch
  /7U9mhXTBsKOe3GBO3WbNIJqFGMrsTjlmaoWpmYrZxegyF5larjKjFEKGS5tkF5KosMs5O6vs
  3/O9z/O8z/t+vBQhGRbJKcZqYUxG2qAQzSd1q8JWKxPXurLip96KNBOjdwSa57ecIs01/3uBx
  tvsJDXVng2a5j4HkSbSdjteh2rd948g7URDO6ntH/CR2s+d0RnCnUK9MafQuluos1cPCIvOyq
  wj59pIG5qJqETzKRK3E+A6flvAPST4hAA6nCOIf4whmK0pJyvRPEqE1XDu3QfE4Qh8ADyzNpI
  TEbgXgf1Hv5AjpDgdrkz2BkUZYB+7R/A4HVr7vgcakTgGvjjrA3ox3gWfqyqCaR4BfDn5OGCY
  h7fAhWlPKIcRjoKZssuBOoEjYdRXJ+AwYAwXbz8heCwD//hPIa/Phop706F8fSUMvvQhHiug8
  ZVDyOMoGKqrCtY3Qu+pRyJuCMDPEBwe6g6a46Clri9oMMDwp4Zg2GL40TYbNF8QwdR1GYclOB
  c+1g4GvdHQYveSfNOnBDxob2MTKHaD5dB+axW/zBI4VeUNPYZiHXN2c/xTOeaoHIH/Cof+Gh9
  Zj8gWlJxj0ufrLAW03qBUx8cr1epEZZJSnZSgovcrc1RMiTKXMVpMNMuq6H1mlbm0INeQpzIy
  lk7E3lZeMVl9E32qyHejRZRAIRPvi3JlSRbkFOaV6mizLttUYmDMbrSYohQgtqawXLiJyWese
  /QG9kD/0ECFKSLEvzhabC6iC8z6fJ4aQImU67y3lqCmeyZrCQlpLDQy8kjxmlRWijmprsT4t9
  GfYx9CUXKpGIWEhEjCihhTgd7yPz+FIimkkIq3cIFheqPlb94UO4qAHeWgJjCKhf5HyW2oTNL
  49OrCbeXgPFY3Rq6WZm7XNJ2M+BY9/TApZjfhkKfsuPv1UtPSytKuFXtdGZtvvLHZHtk3DUqt
  yT2emdbiNan1zsI0YrwGD6/LPNPSs/6o2+MeH520v/Y7E0a2DqwcPHTa/0Jvsk24uiOTly2wd
  FDWx1Vt2lJ/bJeMSt+frCDNOlodR5jM9G9SKQHH5wMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-22.tower-246.messagelabs.com!1556102194!23896!1
X-Originating-IP: [104.47.12.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32645 invoked from network); 24 Apr 2019 10:36:35 -0000
Received: from mail-db3eur04lp2053.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) (104.47.12.53)
  by server-22.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 24 Apr 2019 10:36:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVwr6UHQL1r6MxGwgX9zMVAhHZca0MoCVNYk7EtTlNI=;
 b=k3IbCIsHQpEuENLqnt62nsMKzT/YgspRLW+CN9ncLMivMAR0qFbTb7XLRAB15nQJr3Ct1Xnr9ej982G7kgUnXlYGKiz4LE0PThav+pfUqRqtfbCffXj/7CC/yCEpTapEHYQ6+kAemBzUWDXc8UGNoMr5HNnRrjVtyAIGqzp/O4I=
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM (20.177.113.222) by
 AM6PR10MB3046.EURPRD10.PROD.OUTLOOK.COM (10.255.120.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 10:36:32 +0000
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40aa:18ca:50db:582e]) by AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40aa:18ca:50db:582e%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 10:36:32 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        LINUX RENESAS SOC <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
Thread-Topic: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value,
 too
Thread-Index: AQHU8rKQiJBjLGoJgEygrdEbYLd/faY82vLAgAAa8ICAAAP5gIAOIf2AgAAJWZA=
Date:   Wed, 24 Apr 2019 10:36:32 +0000
Message-ID: <AM6PR10MB2181AC7C28D7BB52C4EA59FEFE3C0@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB23525523F623FFAC4126EBC9FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <20190415092853.GA1861@kunai>
 <VI1PR10MB23520D64B2120138FF64D0BBFE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdXX_OT9soypArNwqkVYTjiTM890qAvp8ZYHaOh9bW5wgg@mail.gmail.com>
In-Reply-To: <CAMuHMdXX_OT9soypArNwqkVYTjiTM890qAvp8ZYHaOh9bW5wgg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2713e75-8ce0-420f-92f7-08d6c8a0b813
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR10MB3046;
x-ms-traffictypediagnostic: AM6PR10MB3046:
x-microsoft-antispam-prvs: <AM6PR10MB304655A76692B9146A69FEEFF53C0@AM6PR10MB3046.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39850400004)(51914003)(189003)(199004)(305945005)(478600001)(74316002)(14454004)(8936002)(6436002)(81166006)(81156014)(7736002)(14444005)(55016002)(256004)(97736004)(33656002)(68736007)(71200400001)(229853002)(71190400001)(6506007)(53546011)(5660300002)(316002)(66476007)(73956011)(25786009)(476003)(64756008)(52536014)(66066001)(99286004)(66446008)(53936002)(66946007)(66556008)(7696005)(54906003)(4326008)(76176011)(110136005)(3846002)(6116002)(86362001)(186003)(93886005)(102836004)(8676002)(486006)(446003)(11346002)(107886003)(9686003)(26005)(6246003)(76116006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB3046;H:AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QLXPxNaeuRzDQBF8HXErPinL43joCEtee7xFDGnDyWL1eCoRCcHhmp23cHegTyO43tt/3X1IrT4ldmLDWtIn5mxXuCs/np9DGcrKrTPmKbrDNXnuDI7KUEd7JeGfUQ4ZM92jLV9nQhe9xqVT5yBj6yfjOnR9/4hmbREtuS96wbKuTAlWtS3hC3HvdmlD3ffcbe+5Y/QT0kp3Y67kjuVzx4oe4t+9mtsFDKiJLzQ6Yh42/Jcy1wJEy8qCV56G+lF+j6zJI/SEdh5go+Z1OojpjT+5FtXvTDIkQJ7f/EukomI8Lgj2nMAcErYJIQ5k0VywTRm7VFxi7QMeXBhsok8pM41q6IdJ/X7EDTNpCp36T+8LsTdlav1u4SfHnySl+zhLBqxvDdnIe2nSiZZ7ngpbTh5jmIc5/JKY+Xu5lkR/ZG4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2713e75-8ce0-420f-92f7-08d6c8a0b813
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 10:36:32.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcy4NCg0KT24gMjQgQXByaWwgMjAxOSAxMDozMiwgR2VlcnQgVXl0
dGVyaG9ldmVuIHdyb3RlOg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZUXSB3YXRjaGRvZzog
ZGE5MDYzX3dkdDogcGFyc2UgRFQgZm9yIHRpbWVvdXQgdmFsdWUsIHRvbw0KPiANCj4gSGkgU3Rl
dmUsDQo+IA0KPiBPbiBNb24sIEFwciAxNSwgMjAxOSBhdCAxMjoxMCBQTSBTdGV2ZSBUd2lzcyB3
cm90ZToNCj4gPiBPbiAxNSBBcHJpbCAyMDE5IDEwOjI5LCBXb2xmcmFtIFNhbmcgd3JvdGU6DQo+
ID4gPiBPbiBNb24sIEFwciAxNSwgMjAxOSBhdCAwODoxMToxNkFNICswMDAwLCBTdGV2ZSBUd2lz
cyB3cm90ZToNCj4gPiA+ID4gT24gMTQgQXByaWwgMjAxOSAxMjoxMCwgV29sZnJhbSBTYW5nIHdy
b3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IFRlc3RlZCB3aXRoIGEgUmVuZXNhcyBMYWdlciBib2Fy
ZCAoUi1DYXIgSDIsIERBOTA2M0FEKQ0KPiA+ID4gPg0KPiA+ID4gSXQgaXMgYW4gZWFybHkgdmVy
c2lvbiBvZiB0aGUgTGFnZXIgZGV2ZWxvcG1lbnQgYm9hcmQuIEkgaGF2ZSBubyBudW1iZXJzDQo+
ID4gPiBidXQgbXkgYXNzdW1wdGlvbiBpcyB0aGVyZSBhcmUgbm90IHRvbyBtYW55IG91dCB0aGVy
ZS4NCj4gPg0KPiA+IFRoYW5rcywgeWVzLCB0aGVyZSBpcyBpbnRlcmVzdCBmcm9tIHRoZSBoYXJk
d2FyZSBlbmdpbmVlcnMgaGVyZS4gVGhhbmtzIGZvciB0aGUNCj4gPiBjb25maXJtYXRpb24gYWJv
dXQgeW91ciBib2FyZC4gSSB3aWxsIGluZm9ybSB0aGVtIGFib3V0IHRoZSBEQTkwNjMgQUQgc2ls
aWNvbiBvbg0KPiA+IHRoZSBSZW5lc2FzIExhZ2VyIGJvYXJkIC0tIGFuZCBJIHdpbGwgbGV0IHlv
dSBrbm93IHRoZWlyIHJlc3BvbnNlLg0KPiANCj4gRm9yIHRoZSByZWNvcmQsIEkgc2VlIHRoZSBm
b2xsb3dpbmcgREE5MDYzIHZhcmlhbnRzIG9uIHRoZSBSZW5lc2FzIGJvYXJkcyBJIGhhdmUNCj4g
YWNjZXNzIHRvOg0KPiAgIC0gREE5MDYzIEFEOiBMYWdlciAoUi1DYXIgSDIpLCBLb2Vsc2NoIChS
LUNhciBNMi1XKSwNCj4gICAtIERBOTA2MyBCQjogR29zZSAoUi1DYXIgTTItTiksIEJsYW5jaGUg
KFItQ2FyIFYySCksIEFsdCAoUi1DYXIgRTIpLg0KPiANCj4gSSBjYW5ub3QgY2hlY2sgUG9ydGVy
IChSLUNhciBNMi1XKSBhbmQgU2lsayAoUi1DYXIgRTIpIHJpZ2h0IG5vdywgYnV0DQo+IGZyb20g
TWFyZWsncyByZXBvcnQsIFBvcnRlciBoYXMgREE5MDYzTCBDQS4NCj4gDQo+IE1hcmVrOiB3aGlj
aCB2YXJpYW50IGRvZXMgeW91ciBTdG91dCAoUi1DYXIgSDIpIGhhdmU/DQoNClRoYW5rcyBmb3Ig
dGhlIGhhcmR3YXJlIGRldGFpbHMuIEkgcmUtaXRlcmF0ZWQgdGhlIGluZm8gZnJvbSBXb2xmcmFt
J3MgbGFzdCBlLW1haWwgdG8gdGhlDQpoYXJkd2FyZSBlbmdpbmVlcnMgZHVyaW5nIHRoaXMgbW9y
bmluZydzIG1lZXRpbmcuIEl0IGNhbiBhbHNvIGJlIGxvb2tlZCB1cCBvbiBMS01MIGlmDQpuZWVk
ZWQuIEkgd2lsbCBwYXNzIG9uIHRoZSBkZXRhaWxzIHlvdSBoYXZlIHNlbnQsIG5leHQuDQoNClRv
IGJlIGNsZWFyIC0tIEkgYW0gdHJlYXRpbmcgdGhlc2UgaW5mb3JtYWwgY29udmVyc2F0aW9ucyBv
biBMS01MIGFzIGEgZGF0YSBjb2xsZWN0aW9uDQpleGVyY2lzZSBhbmQgZm9yIHRoZW0gdG8gYmUg
dXNlZCBhcyBpbmZvcm1hdGlvbi1vbmx5LiBCdXQsIEkgcHVzaGVkLWJhY2sgYWdhaW4gYW5kIGFz
a2VkIGZvcg0KYW55IGRpc2N1c3Npb25zIHRvIGdvIHRocm91Z2ggbW9yZSBmb3JtYWwgY2hhbm5l
bHMgYW5kIG5vdCB0byByZXF1aXJlIG1lIGFzIGEgZ28tYmV0d2VlbiwNCm9yIHRvIGluY2x1ZGUg
dGhlIGludm9sdmVtZW50IG9mIGluZGl2aWR1YWxzIGxpa2UgeW91cnNlbHZlcywgb3IgdG8gdXNl
IHRoZSBMS01MIGNoYW5uZWwuDQoNClRoaXMgaXMgbm90IHBhdGNoIHJlbGF0ZWQgYW5kIEkgZG9u
J3Qgd2FudCB0byByZXF1ZXN0IGFueSBtb3JlIG9mIGFueWJvZHkncyB0aW1lLg0KDQpSZWdhcmRz
LA0KU3RldmUNCg0K
