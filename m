Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D67C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6DA2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="0lwzBIrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfDANBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:01:01 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:50674 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbfDANBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:01:00 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 17/BD-05904-88B02AC5; Mon, 01 Apr 2019 13:00:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHfc9tZ+bJt6n4tLJo9UVr06XVgb4
  UES1KMYUQWdRxntxgO+oupBVhfVFmRoUErcyyjFJLUYKwZssszbK8BJZ0wbKFpSYlUnShHY/d
  vv3e5/9//u/zvjwsqelntKxY5BadkmDXMeGUNVHN68vm1JiT6isW8KUTF1V8cMhP8AOtpxn+2
  ugEwd+rf8LwRx5t4i93+ch1KtOZhn2m9jtlyBQ810iZ7nePUKbPzYvS6WzaJuXkF+2irSem1h
  YE1EVfOy6pSlCT2ovCWQo3klB2+DUhHzS4goDOwT7ai9Shw0sEx+7ZZWawEc6MfURexLLRWA+
  nv874STxKwIu2RpXsicKJUNnyipA5GifB8/ZBlcJp8OzNBCMzhZdBz7fzMzkc3gHHJwuVex8Q
  0BC8MeNR4wx4/PQlJTPCcTB1sJ6UmcSxMDRSPZMPGMOFm49JhWNg9M1PWvHvhNJb4yqlvgJ6B
  keQwjq4+NRHKxwH/dXls/VUCFQOkPIQgIcQHH3rZxQhAcq//ZgN0kJX393ZZjs89DXR8gMAL4
  S+qVSld5qGhokSRvk4C0xW9cz2LoK6imFKMfWSUHnsESk3kzgeGlsTj6J43z9v8/1VlPISqCw
  fVsnM4Xlw/+QIdRZRdWhNjtOWZ3U7BJtdb0xK0huNyfoU/WqDsFefYxA9eosouZ1CSDMIe1wG
  V7HDYs81SKK7GYU2K7eQYq4jvzevHc1nCV0MF2w+Z9bMzcnPLbYKLutOp8cuutrRQpbVAbclv
  MasmecU88Si3TZ7aD1/y8BG6KI5iyxzrgLB4bLlKVI3SmYDNcNVJDt++10VqaGkfEnUxnIbZS
  uWrVaP9Cfo96r3ozhtFIfCwsI0EQWi02Fz/6+/R7Es0kVx8XJKhE1y/7nvfWgUIjQK76mWR3E
  LfyVtCUobGNu3+s7PTY7Ahz3+DdLy2sLowTZr4veezeMec+vDiOwvB4KHer2nYlKyOqbU2tqG
  q2ElK8+mvpvmF0d+2G+6SdcWd19P0Sw4PJlc+KS0c31axsnMLenpa1vMq9oyp0s7DmQlf0q4w
  ui2L7Wc6B3mW7YtBrKu6rs3UrX1cnCMGdVRLqtgTCCdLuEX7eTAo+UDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-5.tower-239.messagelabs.com!1554123656!3493767!1
X-Originating-IP: [104.47.9.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15077 invoked from network); 1 Apr 2019 13:00:56 -0000
Received: from mail-ve1eur03lp2056.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.56)
  by server-5.tower-239.messagelabs.com with AES256-SHA256 encrypted SMTP; 1 Apr 2019 13:00:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76ftXICg/clCE6n4FUYk8ft9lb3koyjAi6gjBhwkSOo=;
 b=0lwzBIrpoWnJTddvV1qiBpKln7rNUpsxEoFnMb3PPUcKTJQ+lud+vQ5lxJ5/yftpEpCAiyub3fnG3daaG28bg3FWqnEGOWTKbqRKx5KwA9hD2loaZi9jvrL/bPz3nqrD/4g1IypQedbYFWeP3iptFgQnnvoH2ZmP/8RUaPsA6xU=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2256.EURPRD10.PROD.OUTLOOK.COM (20.177.62.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 13:00:54 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Mon, 1 Apr 2019
 13:00:54 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Wolfram Sang <wsa@the-dreams.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] rtc: da9063: set range
Thread-Topic: [PATCH 1/2] rtc: da9063: set range
Thread-Index: AQHU388srtB02IcKs0uFchLWhDDC3qYnDdiAgAAE+gCAAAkNIIAANSwAgAABgHA=
Date:   Mon, 1 Apr 2019 13:00:54 +0000
Message-ID: <VI1PR10MB2352ADB7AC634641DD6BAE0AFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190401084143.uqbiktkt2vltgrxa@ninjato>
 <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
In-Reply-To: <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f6edd9-1979-418f-c6f7-08d6b6a2137c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2256;
x-ms-traffictypediagnostic: VI1PR10MB2256:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR10MB22561BE5B186DCBBC1F9E46FF5550@VI1PR10MB2256.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(366004)(346002)(376002)(396003)(40764003)(189003)(199004)(71190400001)(9686003)(74316002)(256004)(54906003)(33656002)(86362001)(81156014)(93886005)(8676002)(6116002)(97736004)(105586002)(106356001)(2906002)(229853002)(316002)(53936002)(52536014)(81166006)(99286004)(3846002)(486006)(55016002)(6306002)(6246003)(446003)(966005)(11346002)(6506007)(186003)(102836004)(6916009)(478600001)(5660300002)(476003)(66066001)(76176011)(4326008)(53546011)(68736007)(25786009)(6436002)(71200400001)(7736002)(7696005)(26005)(8936002)(305945005)(4744005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2256;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S99MPP8mWIbJXVr7xIQoyjQAFcRM57LkthLhQ/1gfWcrzzXB37iU66s1aBnq4YBc7aZ7KA5hbXvNhfFEieFa4H5YgyS1qq5c6pY1InwvSlF8X1GrMf8HTjjKmSSCejs9vi6AeqSCy4Scvl6nkitNBKyMipK5klLLWSmNu6pk8BpeLXvkAmSHgn9uln1BIEdXOCVTkYTVCjj8TRDuyEBA8PIvOh+XdkM8FAzQpnGIHviXn9qs6yocrd4JYAWBtP5eLDWa3pVMejz49CYhV3GBO3qNXTsHr/ioeJDCKra/7EZXlpLTqF9VmybVzP5kmSIA3ZSTjOz0xKe8KHrFaUaTp2F0zIO+Y2fQEuBjyZUDtrddE2rQeD3ueE8JB1xHjYOZePLo/oXWwyM5H+d2E8bzjfDKEU1VIRuTl6xeUukmJSE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f6edd9-1979-418f-c6f7-08d6b6a2137c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 13:00:54.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDAxIEFwcmlsIDIwMTkgMTM6NDIsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3
cm90ZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBydGM6IGRhOTA2Mzogc2V0IHJhbmdl
DQo+IA0KPiBIaSBTdGV2ZSwNCj4gDQo+IE9uIE1vbiwgQXByIDEsIDIwMTkgYXQgMjozOSBQTSBT
dGV2ZSBUd2lzcyB3cm90ZToNCj4gPiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlcmUgYXJlIG5v
IFJUQyBhbGFybSByZWdyZXNzaW9ucy4NCj4gPiBJIGFtIHVzaW5nIGFuIGkuTVg2USBib2FyZCBh
bmQgd2l0aCBhbiB1bm1vZGlmaWVkIHY1LjEtcmMxIGtlcm5lbCwgZm9yIHRoZQ0KPiA+IGFsYXJt
cywgSSBzZWUgZXZlcnl0aGluZyB3b3JraW5nIG9rYXkgWy4uLl0NCj4gDQo+IFRoYW5rcyENCj4g
DQo+IEkgd2FzIGp1c3Qgd29uZGVyaW5nIHdoZXRoZXIgdGhleSB3b3JrIGZvciBXb2xmcmFtLCB3
aG8gaGFzIGEgc2ltaWxhcg0KPiBidXQgZGlmZmVyZW50IGJvYXJkIHRoYW4gSSBoYXZlLiBMYXN0
IHRpbWUgSSB0cmllZCwgdGhleSBkaWRuJ3Qgd29yayBmb3IgbWUuDQoNCkkgdGhpbmsgSSByZW1l
bWJlciwgLi4gd2FzIHRoaXMgaXQ/DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzZFRDhF
M0IyMjA4MUE0NDU5REFDNzY5OUYzNjk1RkI3MDIyMTc5RjIzNkBTVy1FWC1NQlgwMi5kaWFzZW1p
LmNvbS8NCg0KSSByZW1lbWJlciBwcmV2aW91c2x5IEkgd2Fzbid0IGFibGUgdG8gcXVpY2tseSBw
cm92aWRlIHlvdSB3aXRoIGEgcmVncmVzc2lvbg0KdGVzdCByZXN1bHQgYWZ0ZXIgeW91IGZpeGVk
IGFuIElSUSBwcm9ibGVtIHRoYXQgYWZmZWN0ZWQgdGhlIERBOTA2MyBSVEMNCih0aGFua3MgZm9y
IHlvdXIgaGVscCBvbiB0aGF0IGJ0dykuDQoNClJlZ2FyZHMsDQpTdGV2ZQ0K
