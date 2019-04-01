Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CA4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD65920870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="I/g0ud94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDAMjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:39:46 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:1075 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbfDAMjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:39:45 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 2C/7D-19701-D8602AC5; Mon, 01 Apr 2019 12:39:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSe0hTYRjG/c45206yE5+z8m04wdNdPHPLqFM
  QXf5pGFIE9YcYddSTG2zTdjayC1FIZdoi0miNzDSx1FJaWWH3ZVmGXcywJApJZ0lWkhF0o51z
  7Pbfw/N7vud7v4+XJg3dWiMtFnlFj1twstpYyp6mncP5tTXZlsGR8fye93U6PtJ7leCftB7V8
  i1v3xP8ncZuLb//wTK+/m6QXKyzHTu91Ra+VYJskepmynavo5+yfQolrdRkaRzunIKi9Rr7j8
  ghsvClqWjkcLVmBzptKkWxNIWbSfhyrQmVonG0Ae8n4FCHTQYG/BJBw40BUgZabIVj7z4ooQm
  4GMGLQK4cIvFBAi4+7VZC8TgNKs69ItSQBV6Ee3SliI7qpTDknyHbFJ4KT0MnlB4Gr4XQ5xqN
  etk5BKVVdQoYh1fBhW+XlR6ETTC6s1HpJ3EC9PZXKT5gDLVXHpKqnghvX//UqPl1sOf6sE71U
  6Gzpx+pmoW6Z0GNqk3QVVU25mdCW99eSh4CcC+CV+WVWhWkwHf/mTFthC+vR8ZKnXCy+oTyMM
  CJ8Hg0Uz07oIGWwbOE+o258LGycyyfBA3+PkrVj0ioP5IsnyXxLGhuTTuAZgX/eVrwL1HtZKg
  o69MFle+Kg3tH+qnjiGpAfI7HkW/3ugSHk7NaLJzVOpuzzk/nZqfPMQtbOMEs+rhNouTlrGZh
  k2SWNrtynXlmt+gNoehu5RXeHLqEWk/lh9FkmmAnMpFQdbZhfE5B3ma7INnXeXxOUQqjRJpmg
  UHRHTTEecR8sWiDwxld0N8YaD07gUmVMSMVCi7Jka+iDpRO36jpqyTp4ZuDlaSBche4RWMCky
  JHsRy1+9x/in4vexcyGeMZFBMTY9AXih6Xw/s/H0IJNGLjmSYq2qJ3uL1/7huKjkJER+F9VfI
  oXuEvMu5AtS2XPZ6M7Q2LtmUeqHh+fY2ee5Ng6tz9Nbhi6T7TciJjVxzLBJJK1kxj9gbKIo/x
  wayLK9yrEmM7N65sn9L1/erqgKUjxq931CcPs8FnC1CgNm1JU1dxW7i8cUrqQFvGkp6TiyffL
  g+6QqMl89rnZj2fZJ75aPr94vNk/ML2C9k+lpLsgjWF9EjCLwq2PivnAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-5.tower-268.messagelabs.com!1554122380!4383911!1
X-Originating-IP: [104.47.6.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10298 invoked from network); 1 Apr 2019 12:39:41 -0000
Received: from mail-ve1eur02lp2052.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.52)
  by server-5.tower-268.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 1 Apr 2019 12:39:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3ZHalzfkEmdsvun6VDf5HD4a60VDi58Vc9cGF68YxU=;
 b=I/g0ud94SV4kiwEdKn24TvUajYeHPpp3VfbCwAv5lFSBymCfrpLB6gm5Cn1BYY1h93WSkhPxVMmXIJQKxDXwtFxi792qUQoJICcmkrUzxYjVvjzebzrBhe62ZrLXVe4bKn8M53Ps7Ur42rNAYctsDUKqjcuFmSSxfXRVW/n0Smo=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1856.EURPRD10.PROD.OUTLOOK.COM (10.165.195.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 12:39:39 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Mon, 1 Apr 2019
 12:39:39 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] rtc: da9063: set range
Thread-Topic: [PATCH 1/2] rtc: da9063: set range
Thread-Index: AQHU388srtB02IcKs0uFchLWhDDC3qYnDdiAgAAE+gCAAAkNIA==
Date:   Mon, 1 Apr 2019 12:39:39 +0000
Message-ID: <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190401084143.uqbiktkt2vltgrxa@ninjato>
 <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
In-Reply-To: <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45518e8b-51e0-4c95-7b1e-08d6b69f1ba3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1856;
x-ms-traffictypediagnostic: VI1PR10MB1856:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR10MB1856CD26EB5BAC1E5A3370DCF5550@VI1PR10MB1856.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39850400004)(136003)(199004)(189003)(229853002)(110136005)(316002)(476003)(52536014)(486006)(446003)(11346002)(54906003)(4326008)(53936002)(99286004)(2906002)(6436002)(6116002)(3846002)(71200400001)(71190400001)(76176011)(25786009)(97736004)(7696005)(6246003)(966005)(55016002)(14454004)(68736007)(478600001)(6506007)(53546011)(186003)(26005)(14444005)(86362001)(66066001)(5660300002)(256004)(6306002)(7736002)(33656002)(305945005)(106356001)(105586002)(8936002)(81156014)(102836004)(9686003)(74316002)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1856;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xSn1dm6vIBC120cj/i2ySLq3Q7ftpeVtqw2+HNCInX2zRfsKjQpv8Qzep4xKvKh+wllVEU2Nu/UGJfa9DiKg539z/bct9mcYwo3KHIVMRWBaB/F9FpVzdBY2yVj9N/Q9FbKhODMNyzRNsI512DzVvcef0qTilo3+fkFCIj0/eq8ZLQ6aAqsOgzTClKSd9LKCmpM/uXpdiUCCLxOHZLttJSFU/tI7JWGeH5AieQAh0FlLq3Ycn5YESMQ6HE4fDdSq/yTQbcW60zKagqagMh872sSYKtrjC4h8Vt+YxPorlwn2nuK1NpRR27J3quqd5/RoGb1OJ5aqlIeN4XjT4kjGHP19EQMPkiUmLZLxhzS0NFmHiywBAuxYK9RGt57TkNfCrw7Am8ziBEHN3iZ+McL/koIT6EtW918tpChg8XZtXvw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45518e8b-51e0-4c95-7b1e-08d6b69f1ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 12:39:39.7556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDAxIEFwcmlsIDIwMTkgMTA6MDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3
cm90ZToNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gcnRjOiBkYTkwNjM6IHNldCByYW5n
ZQ0KPiANCj4gSGkgV29sZnJhbSwNCj4gDQo+IE9uIE1vbiwgQXByIDEsIDIwMTkgYXQgMTA6NDMg
QU0gV29sZnJhbSBTYW5nIDx3c2FAdGhlLWRyZWFtcy5kZT4gd3JvdGU6DQo+ID4gT24gVGh1LCBN
YXIgMjEsIDIwMTkgYXQgMTE6MTU6NTZBTSArMDEwMCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6
DQo+ID4gPiBUaGUgREE5MDYyIGFuZCBEQTkwNjMgaGF2ZSBhIHllYXIgcmVnaXN0ZXIgdGhhdCBj
YW4gZ28gdXAgdG8gMHgzRi4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcmUg
QmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdpbmVlcmluZy5jb20+DQo+ID4NCj4g
PiBJIGNvdWxkbid0IHRlc3QgdGhlIHVwcGVyIGxpbWl0IChEQTkwNjMgaG9va2VkIHRvIGEgMzJi
aXQgc3lzdGVtIGhlcmUpLA0KPiA+IGJ1dCBsb3dlciBsaW1pdCB3b3JrcyBhbmQgUlRDIGluIGdl
bmVyYWwgd29ya3MuDQo+IA0KPiBCVFcsIGRvZXMgdGhlIFJUQyBhbGFybSBpbnRlcnJ1cHQgd29y
ayBmb3IgeW91Pw0KDQpBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlcmUgYXJlIG5vIFJUQyBhbGFy
bSByZWdyZXNzaW9ucy4NCg0KSSBhbSB1c2luZyBhbiBpLk1YNlEgYm9hcmQgYW5kIHdpdGggYW4g
dW5tb2RpZmllZCB2NS4xLXJjMSBrZXJuZWwsIGZvciB0aGUNCmFsYXJtcywgSSBzZWUgZXZlcnl0
aGluZyB3b3JraW5nIG9rYXkgV0lUSE9VVCBBbGV4YW5kcmUncyBwYXRjaGVzIC4uLg0KDQpUaGVu
LCBXSVRIIEFsZXhhbmRyZSdzIHBhdGNoZXMgLi4uDQotIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FiZWxsb25pL2xpbnV4LmdpdC9jb21taXQvP2g9cnRj
LW5leHQmaWQ9MDVlNGZmZWFkZWNhYTZmNTAxMjE4NTA0Yjg2YTZjZWM4OTIwMmJkOQ0KLSBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hYmVsbG9uaS9saW51
eC5naXQvY29tbWl0Lz9oPXJ0Yy1uZXh0JmlkPWRhNDRlMGViN2VjNjg1M2I1ZDIwZmFiYTdkYzM0
YzQ4ZTRiYjM1YzcNCi4uLiBhcHBsaWVkIHRvIHY1LjEtcmMxLCBhbmQgd2l0aCB0aGUgc2FtZSBz
ZXQtdXAsDQoNClsgICAgMi4wMjcxNDRdIGRhOTA2MyAxLTAwNTg6IERldmljZSBkZXRlY3RlZCAo
Y2hpcC1JRDogMHg2MSwgdmFyLUlEOiAweDYwKQ0KWyAgICAyLjQ4MzY5OV0gZGE5MDYzLXJ0YyBk
YTkwNjMtcnRjOiBETUEgbWFzayBub3Qgc2V0DQpbICAgIDIuNTIzMjc5XSBkYTkwNjMtcnRjIGRh
OTA2My1ydGM6IHJlZ2lzdGVyZWQgYXMgcnRjMA0KDQpMaW51eCB0ZXN0IDUuMS4wLXJjMSAjMSBT
TVAgTW9uIEFwciAxIDEzOjA1OjMyIEJTVCAyMDE5IGFybXY3bCBHTlUvTGludXgNCg0KWy4uLl0N
Cg0KW1BBU1NdIFNldHRpbmcgdGhlIGN1cnJlbnQgZGF0ZSBhbmQgdGltZSBmcm9tIHRoZSBkYTkw
NjMtcnRjIGRhOTA2My1ydGMgYXMgMjAwMC0wMS0wMSAwMDowMDowMA0KW1BBU1NdIFNldHRpbmcg
dGhlIGFsYXJtIGRhdGUgYW5kIHRpbWUgZnJvbSB0aGUgZGE5MDYzLXJ0YyBkYTkwNjMtcnRjIGFz
IDIwMDAtMDEtMDEgMDA6MDA6MDUgKCs1IHNlY3MgaW50byB0aGUgZnV0dXJlKQ0KW1BBU1NdIFNl
dHRpbmcgdGhlIGxpc3RlbmVyIG9uIGRhOTA2My1ydGMgZGE5MDYzLXJ0YyB0aGVuIHdhaXRpbmcg
Zm9yIGVsYXBzZWQgdGltZW91dCBvZiAxNSBzZWNvbmRzLi4uDQpbUEFTU10gVGhlIGFsYXJtIHdh
cyB0cmlnZ2VyZWQgb24gZGE5MDYzLXJ0YyBkYTkwNjMtcnRjIHdpdGhpbiB0aGUgZXhwZWN0ZWQg
dGltZSBhbmQgdGhlIGFsYXJtIGhhcHBlbmVkIGF0IDIwMDAtMDEtMDEgMDA6MDA6MDUNCg0KW1BB
U1NdIFNldHRpbmcgdGhlIGN1cnJlbnQgZGF0ZSBhbmQgdGltZSBmcm9tIHRoZSBkYTkwNjMtcnRj
IGRhOTA2My1ydGMgYXMgMjAwMC0wMS0wMSAwMDowMDowMA0KW1BBU1NdIFNldHRpbmcgdGhlIGFs
YXJtIGRhdGUgYW5kIHRpbWUgZnJvbSB0aGUgZGE5MDYzLXJ0YyBkYTkwNjMtcnRjIGFzIDIwMDAt
MDEtMDEgMDA6MDA6MTUgKCsxNSBzZWNzIGludG8gdGhlIGZ1dHVyZSkNCltQQVNTXSBTZXR0aW5n
IHRoZSBsaXN0ZW5lciBvbiBkYTkwNjMtcnRjIGRhOTA2My1ydGMgdGhlbiB3YWl0aW5nIGZvciBl
bGFwc2VkIHRpbWVvdXQgb2YgMjUgc2Vjb25kcy4uLg0KW1BBU1NdIFRoZSBhbGFybSB3YXMgdHJp
Z2dlcmVkIG9uIGRhOTA2My1ydGMgZGE5MDYzLXJ0YyB3aXRoaW4gdGhlIGV4cGVjdGVkIHRpbWUg
YW5kIHRoZSBhbGFybSBoYXBwZW5lZCBhdCAyMDAwLTAxLTAxIDAwOjAwOjE1DQoNCj4gY2F0IC9w
cm9jL2ludGVycnVwdHMgfCBncmVwIGRhOTANCjI0NzogICAgICAgICAgMiAgICAgICAgICAwICAg
ICAgICAgIDAgICAgICAgICAgMCAgZ3Bpby1teGMgIDExIExldmVsICAgICBkYTkwNjMtaXJxDQoz
MDU6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAyICAgICAgICAgIDAgIGRhOTA2My1p
cnEgICAxIExldmVsICAgICBBTEFSTQ0KDQpJIGdldCBhbiBpZGVudGljYWwgcmVzdWx0Lg0KU28g
YXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRoZXJlIGFyZSBubyBSVEMgYWxhcm0gcmVncmVzc2lvbnMu
DQoNClRlc3RlZC1ieTogU3RldmUgVHdpc3MgPHN0d2lzcy5vcGVuc291cmNlQGRpYXNlbWkuY29t
Pg0KDQpSZWdhcmRzLA0KU3RldmUNCg==
