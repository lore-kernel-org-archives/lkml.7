Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDDC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900C821852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GVswGwjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfGDJqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:46:21 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:12172
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727433AbfGDJqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljhj7FeAXiWI5a7VODEiedFpUN79C177M6SU/g6CbqU=;
 b=GVswGwjQhGypOVx18cNaiBWndm/j8ynoNRE6RBh3lDSUGeNnTk2pjqlEkPYR3XLIBOt++gq8iRDbz+9DpvZR0jwso0njgxfeAssc+srZ+/e7/7W5BH3wZB4gG3X0nTSolWA4k4J238WLoaDMwpv5Q/GSI/aqISsEoevWEg3VKlU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (52.134.65.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 09:46:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 09:46:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Thread-Topic: [PATCH V2 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Thread-Index: AQHVMkvG0A7TyfvQREempPzkyhw2Raa6NMqAgAAA3KA=
Date:   Thu, 4 Jul 2019 09:46:17 +0000
Message-ID: <DB3PR0402MB39167FBAA2A3867148063F83F5FA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704092600.38015-1-Anson.Huang@nxp.com>
 <1562233305.6641.8.camel@pengutronix.de>
In-Reply-To: <1562233305.6641.8.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 281aeadd-c385-48ee-99a5-08d700647609
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3913;
x-ms-traffictypediagnostic: DB3PR0402MB3913:
x-microsoft-antispam-prvs: <DB3PR0402MB39137D96F5F59631D53A906CF5FA0@DB3PR0402MB3913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(199004)(189003)(66946007)(76116006)(64756008)(186003)(66446008)(26005)(44832011)(73956011)(66476007)(76176011)(102836004)(478600001)(66556008)(2501003)(6506007)(110136005)(476003)(316002)(486006)(68736007)(2906002)(446003)(81166006)(8936002)(5660300002)(33656002)(11346002)(8676002)(81156014)(7696005)(52536014)(71200400001)(229853002)(71190400001)(74316002)(7736002)(99286004)(305945005)(66066001)(9686003)(14444005)(2201001)(6116002)(55016002)(25786009)(256004)(53936002)(7416002)(86362001)(4326008)(3846002)(14454004)(6436002)(6246003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kNusKhIU6hMPzMyqe3C1XzQtvxCaFbhVS/0x5zhRA4X4mdybEX1BOlByZyTmG2xYeuNzPddlfRxg724yYlbQ2kZdVGV5V8BlSc3Mzym2ySp4QLoLh2Nxw5ETlq8jogxkcz6Yss81SSKNslKZ+e0mIl/u5+fneh2NXSuy9ATlRGsY3bs+f19Zc2Vig8O+vrBr+3wNCJxqMGRXRRZKmTGmsykuueTfYLXTzDimkJXeOugTX7LQ64YA/h0ky1WusgS8u/nd8/hgjxycBU8Fuwet6S7Wji2535o9G/dfA4Dv+C/Xh+iSUQpDPhWSEHaKjQUHKeCie1xA0v/GosvpLneUjCBjsWQJirWUgEFc3WQ3jbylwUgcwr0aDvSHYSi4Ru1p/o1D5BSpHNIuxtWtcs0zgn82mP2IKj8Hzbj0k3ghobI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281aeadd-c385-48ee-99a5-08d700647609
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 09:46:17.2885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBoaWxpcHANCg0KPiBPbiBUaHUsIDIwMTktMDctMDQgYXQgMTc6MjUgKzA4MDAsIEFuc29u
Lkh1YW5nQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOE1NIGNhbiByZXVzZSBpLk1YOE1RJ3MgcmVzZXQgZHJp
dmVyLCB1cGRhdGUgdGhlIGNvbXBhdGlibGUNCj4gPiBwcm9wZXJ0eSBhbmQgcmVsYXRlZCBpbmZv
IHRvIHN1cHBvcnQgaS5NWDhNTS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IE5ldyBwYXRjaC4NCj4gPiAtLS0N
Cj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXg3LXNy
Yy50eHQgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteDctc3JjLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXg3LXNyYy50eHQNCj4gPiBpbmRleCAxM2Uw
OTUxLi5iYzI0YzQ1IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZXNldC9mc2wsaW14Ny1zcmMudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXg3LXNyYy50eHQNCj4gPiBAQCAtNyw3ICs3
LDcgQEAgY29udHJvbGxlciBiaW5kaW5nIHVzYWdlLg0KPiA+ICBSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPiA+ICAtIGNvbXBhdGlibGU6DQo+ID4gIAktIEZvciBpLk1YNyBTb0NzIHNob3VsZCBiZSAi
ZnNsLGlteDdkLXNyYyIsICJzeXNjb24iDQo+ID4gLQktIEZvciBpLk1YOE1RIFNvQ3Mgc2hvdWxk
IGJlICJmc2wsaW14OG1xLXNyYyIsICJzeXNjb24iDQo+ID4gKwktIEZvciBpLk1YOE1RL2kuTVg4
TU0gU29DcyBzaG91bGQgYmUgImZzbCxpbXg4bXEtc3JjIiwgInN5c2NvbiINCj4gDQo+IFBsZWFz
ZSBzdGlsbCBhZGQgdGhlICJmc2wsaW14OG1tLXNyYyIgZm9yIGkuTVg4TU0sIGp1c3QgaW4gY2Fz
ZSBhIHNpZ25pZmljYW50DQo+IGRpZmZlcmVuY2UgaXMgZGlzY292ZXJlZCBsYXRlci4NCg0KT0ss
IHRoZW4gSSB3aWxsIGFkZCBhIG5ldyBsaW5lIGFzIGJlbG93Og0KDQpGb3IgaS5NWDhNTSBTb0Nz
IHNob3VsZCBiZSAiZnNsLGlteDhtbS1zcmMiLCAiZnNsLGlteDhtcS1zcmMiLCAic3lzY29uIg0K
DQpBbnNvbi4NCg0KPiANCj4gcmVnYXJkcw0KPiBQaGlsaXBwDQo=
