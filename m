Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A03AC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F984216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ko1RFjjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGIFky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:40:54 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:54270
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfGIFkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alo2+jNxlDvHNnmY6ncZT3TG91kd09P5iTNL58KzdHc=;
 b=ko1RFjjHEoKQXg7k5mLvWEsoGM088kYUdeAgR+PPKUOVB0A2QDZCDc/QoslqaJQWAerme5SsxJZ7papAb9VzVrHcQa+U6e0D3m4UHnaizsTECQB//WS4/lp6N+KW6/XoiAG5i4O1DIv5ULfnfE1x7SkJPcr9atrDkHEQ2X5cs/w=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3799.eurprd04.prod.outlook.com (52.133.29.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.16; Tue, 9 Jul 2019 05:40:49 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::d5e6:6a87:7e6:95a]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::d5e6:6a87:7e6:95a%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 05:40:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend opp
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend
 opp
Thread-Index: AQHVMjD62bccyXxndUyDszIpSDkBnabAaO+AgAACe/CAAARwgIAAADZQgAFNtACAAA828A==
Date:   Tue, 9 Jul 2019 05:40:49 +0000
Message-ID: <AM6PR0402MB3911D4AA40BC328420DD2CA5F5F10@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
 <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
 <20190708082511.py7gnjbqyp7bnhqx@vireshk-i7>
 <DB3PR0402MB391622133CD116FDE26A4F9AF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190708084957.waiwdun327pgvfv4@vireshk-i7>
 <DB3PR0402MB39164E2F386181255ED37F45F5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190709044504.gyljwwnxdt5niur5@vireshk-i7>
In-Reply-To: <20190709044504.gyljwwnxdt5niur5@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f690bd0a-d01f-406e-60ce-08d7042fff7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3799;
x-ms-traffictypediagnostic: AM6PR0402MB3799:
x-microsoft-antispam-prvs: <AM6PR0402MB3799E10FC12C5E4EEBD416F6F5F10@AM6PR0402MB3799.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(189003)(199004)(76176011)(305945005)(8936002)(99286004)(7696005)(54906003)(26005)(7416002)(81166006)(102836004)(186003)(66476007)(6916009)(66066001)(7736002)(14444005)(446003)(476003)(5660300002)(11346002)(74316002)(64756008)(66446008)(44832011)(76116006)(86362001)(256004)(66946007)(52536014)(6506007)(66556008)(81156014)(8676002)(53546011)(486006)(71200400001)(71190400001)(73956011)(6246003)(478600001)(25786009)(14454004)(2906002)(15650500001)(6436002)(316002)(229853002)(3846002)(6116002)(55016002)(4326008)(53936002)(9686003)(33656002)(68736007)(4744005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3799;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AtrVcCsnY0+uiR1Zxv8u8uBg045zmLvTdSq5Y+3xaoXMMi09MWWXZXZEMLuN7aaCt96HkiBXhedphH14ULzA5bKa2Z/7kA0vZm+ITm/7nxox9P46C+Wzog4tygnGErVrDKXGEkMJXMKZMjd4p811LbGGB9eDwkVBK/NbwUdso+UdUHcAjyXYLUc4irL4kiEmdUBleuamryFzaJ4Ag9P3lk/ZW+II8puKtk3QN5LWygUQMt+PTLxAIIYy8dF3aH0e+6V52JKh2yLMMCpgTn7fUr2ZCncCTP8PX80mow7SYQU2Gi1C+T0tSrsjjl0boeu6IUfiwaWqv9dqb5duxaerKNBgS+FlvAWi9LRvFm4SuIVAXm53MiHyXxM0pXG/nfh+ctAbosleAUnjJ5f7uPVVPFuEmwoB/uLj75ZmIdnQRtw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f690bd0a-d01f-406e-60ce-08d7042fff7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:40:49.1397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpcmVzaA0KDQo+IE9uIDA4LTA3LTE5LCAwODo1NCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+
ID4gRWFjaCBPUFAgaGFzICJvcHAtc3VwcG9ydGVkLWh3IiBwcm9wZXJ0eSBhcyBiZWxvdywgdGhl
IGZpcnN0IHZhbHVlDQo+ID4gbmVlZHMgdG8gYmUgY2hlY2tlZCB3aXRoIHNwZWVkIGdyYWRpbmcg
ZnVzZSwgYW5kIHRoZSBzZWNvbmQgb25lIG5lZWRzDQo+ID4gdG8gYmUgY2hlY2tlZCB3aXRoIG1h
cmtldCBzZWdtZW50IGZ1c2UsIE9OTFkgYm90aCBvZiB0aGVtIHBhc3NlZCwgdGhlbg0KPiA+IHRo
aXMgT1BQIGlzIHN1cHBvcnRlZC4gSXQgY2FsbHMgZGV2X3BtX29wcF9zZXRfc3VwcG9ydGVkX2h3
KCkgdG8gdGVsbA0KPiA+IE9QUCBmcmFtZXdvcmsgdG8gcGFyc2UgdGhlIE9QUCB0YWJsZSwgdGhp
cyBpcyBteSB1bmRlcnN0YW5kaW5nLg0KPiA+DQo+ID4gb3BwLXN1cHBvcnRlZC1odyA9IDwweDg+
LCA8MHgzPjsNCj4gDQo+IFJpZ2h0LCBzbyB0aGF0J3Mgd2hhdCBJIHdhcyBleHBlY3RpbmcuDQo+
IA0KPiBPbmUgdGhpbmcgd2UgY2FuIGRvIGlzIGNoYW5nZSB0aGUgYmluZGluZyBvZiBPUFAgY29y
ZSBhIGJpdCB0byBhbGxvdyBtdWx0aXBsZQ0KPiBPUFAgbm9kZXMgdG8gY29udGFpbiB0aGUgIm9w
cC1zdXNwZW5kIiBwcm9wZXJ0eSBhbmQgc2VsZWN0IHRoZSBvbmUgZmluYWxseQ0KPiB3aXRoIHRo
ZSBoaWdoZXN0IGZyZXF1ZW5jeS4gVGhhdCB3b3VsZCBiZSBhIGJldHRlciBhcyBhIGdlbmVyaWMg
c29sdXRpb24gSU1PLg0KPiANCj4gQW5kIHRoZW4gYSBzbWFsbCBPUFAgY29yZSBwYXRjaCB3aWxs
IGZpeCBpdC4NCg0KTG9va3MgZ29vZCwgSSB3aWxsIHRyeSB0byBnZW5lcmF0ZSBhIHBhdGNoIGZv
ciBvZiBPUFAgY29yZS4NCg0KVGhhbmtzLA0KQW5zb24NCg==
