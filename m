Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C91C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F69214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ivha+smR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDHMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:41:09 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:23812
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfDHMlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaXUUTTdrC18X/LBwK+XKLxoDrpUlMI5/318MjaAwGQ=;
 b=ivha+smRvAE8mHE0RYUVjtMMTlHgNkArvKkEOWS9J0pK2r0QqCD5WJ4aWbu5bsLzmpbbFPJOFup5ac7vxH1Tm6JzGptIowSoz83r/q2rjn/OVHEynIcSiHE9b0NRPWKJXUIFb8lvc2ELxzy2Th1aU2l7QgiBLlqMOGPPZt9qagc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6225.eurprd04.prod.outlook.com (20.179.33.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 12:41:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 12:41:04 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "VI1PR04MB42227AA158BA1FCBF314AA27807B0@vi1pr04mb4222.eurprd04.prod.outlook.com" 
        <VI1PR04MB42227AA158BA1FCBF314AA27807B0@vi1pr04mb4222.eurprd04.prod.outlook.com>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christina Quast <cquast@hanoverdisplays.com>
Subject: RE: [EXT] Re: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix
 PAD_CTL_DSE_X*
Thread-Topic: [EXT] Re: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix
 PAD_CTL_DSE_X*
Thread-Index: AQHU2af7cbSmi8TJKEC1UrPKPbJyuaYqP1+AgAgVXACAAAhWsA==
Date:   Mon, 8 Apr 2019 12:41:04 +0000
Message-ID: <AM0PR04MB421197A4ADC0D726617EBF76802C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313142040.26694-1-cquast@hanoverdisplays.com>
 <20190403084341.GA4636@X250>
 <CACRpkdbfSp0xANWU9Jc0=qrFUN9fJntADxH1J4jZpP=e0NbXaQ@mail.gmail.com>
In-Reply-To: <CACRpkdbfSp0xANWU9Jc0=qrFUN9fJntADxH1J4jZpP=e0NbXaQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53cc2f7b-7ead-4d36-4525-08d6bc1f76e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6225;
x-ms-traffictypediagnostic: AM0PR04MB6225:
x-microsoft-antispam-prvs: <AM0PR04MB6225AD99814A2AA5819F38CA802C0@AM0PR04MB6225.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(4326008)(486006)(5660300002)(7696005)(6116002)(55016002)(99286004)(74316002)(305945005)(6246003)(3846002)(186003)(26005)(102836004)(52536014)(476003)(9686003)(76176011)(106356001)(478600001)(105586002)(6506007)(25786009)(53546011)(53936002)(446003)(11346002)(97736004)(71200400001)(71190400001)(14454004)(7736002)(6436002)(33656002)(229853002)(316002)(54906003)(110136005)(66066001)(2906002)(86362001)(68736007)(7416002)(256004)(8676002)(81166006)(4744005)(81156014)(8936002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6225;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Zaq1b39aoXZdgJqY5ZzZhvUHdrlhP0NF93P2fD2m/M03SIC/y8sdiP09Y4sVXd4c4vyOv1BIG6ulLGQJwLj8BjwsUiLtMFM74sz8v/DxapumccChDeRvfFYUCf3XkCj2Bzy62+k8NrSgVz+QNedJELtMQwhwispoSFLJcOECbaV5Lllfot+ztQEcah5MD9PNxZOKULsESdcn1ACSBBQdgkxH3GkGyime7v6n85SABjtV9GtOWRvLRPv0SwgISUCozC34RHEZvWaxiXyljzWv+XQHWV6BJUYMN62NJUfT517lFmjwn7Grpa2hEwMBSHJfJFkH4Vz1rURu1YiTrMQ0nWemNZn43ucwOO7AO8hYC7MqS41lyRE0LciFcI9Ugoh4bRn/Ajy3WFKIKCGYZ7TbQE6+VpEYJE/l9RR0swle6s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cc2f7b-7ead-4d36-4525-08d6bc1f76e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 12:41:04.3338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMaW51cyBXYWxsZWlqIFttYWlsdG86bGludXMud2FsbGVpakBsaW5hcm8ub3JnXQ0K
PiBTZW50OiBNb25kYXksIEFwcmlsIDgsIDIwMTkgODoxMCBQTQ0KPiBPbiBXZWQsIEFwciAzLCAy
MDE5IGF0IDEwOjQzIEFNIFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+
DQo+ID4gSSBhc3N1bWUgdGhpcyB3aWxsIGdvIHZpYSB5b3VyIHRyZWUuICBMZXQgbWUga25vdyBp
ZiB5b3UgdGhpbmsNCj4gPiBkaWZmZXJlbnRseS4NCj4gDQo+IE9LIEkgYXBwbGllZCBpdCwgaWYg
eW91J3JlIG5vdCBtZXJnaW5nIGFueSBkZXZpY2UgdHJlZXMgdXNpbmcgdGhlc2UgZGVmaW5lcyB0
aGlzDQo+IGN5Y2xlIGl0J3MgZmluZSBJIHN1cHBvc2UuDQo+IA0KDQpJTVggZGV2aWNlIHRyZWUg
ZG9lcyBub3QgdXNlIGl0Lg0KU28gaXQncyBzYWZlLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcN
Cg0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K
