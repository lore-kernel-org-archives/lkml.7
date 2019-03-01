Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF951C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D7A20838
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Tyy0bZgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfCANry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:47:54 -0500
Received: from mail-eopbgr1400097.outbound.protection.outlook.com ([40.107.140.97]:52536
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388031AbfCANry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U51rDimZVdtHNp67SfT95m8G2JQ+EG+zUJKEqFlDqSY=;
 b=Tyy0bZgdDzH0BJmLqtlsmZDP6vK89IKRYM+RjtG/6Zfx77VL7QleePj5EdbxAFDe5SDMPsRC139lhhHXPafVfWvrGBQeXHGOYQQn1eEQSa54md/GlCUaF9wNRNTxzaU+pIWpRKUDAQ8rVkVecKhH242bPhvUI9c8ookwOdAIvW0=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1696.jpnprd01.prod.outlook.com (52.133.167.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 13:47:48 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 13:47:48 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774c0
 support
Thread-Topic: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774c0
 support
Thread-Index: AQHUkyD6AD0W0/GlCEuZuz1ywyu8ZqX3I0OQgAAeuICAAAJVMA==
Date:   Fri, 1 Mar 2019 13:47:48 +0000
Message-ID: <TYXPR01MB17757072E9A7E828A92DC6EEC0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732284-5951-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TYXPR01MB1775847A1B243C0B30C69CFBC0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <dde90e93-e8ca-acd2-ffd0-976c51ec309f@arm.com>
In-Reply-To: <dde90e93-e8ca-acd2-ffd0-976c51ec309f@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b80237b-9084-4920-21de-08d69e4c7def
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1696;
x-ms-traffictypediagnostic: TYXPR01MB1696:
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1696;20:v1oboEIqch2s6oJJ9KS0zTn3/hJ8TooZdPVa7PADEuJSwsh2xyjWc2hgUSoszG2M/UMDWBlBAPEtRqZecOe/kmclJP0fr43xBqfe3fpDlnN3KWfmA5S1ROelKT62JhEupkMZx4sB0g9gbPHF8bs+1I7hABxJ6/pvWy+xVM/SluM=
x-microsoft-antispam-prvs: <TYXPR01MB1696627393172FC6B25F20FEC0760@TYXPR01MB1696.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(396003)(136003)(376002)(199004)(189003)(446003)(486006)(11346002)(8676002)(2906002)(14444005)(8936002)(25786009)(33656002)(478600001)(14454004)(256004)(66066001)(81166006)(476003)(53936002)(44832011)(4326008)(81156014)(3846002)(6246003)(99286004)(6116002)(305945005)(74316002)(54906003)(68736007)(316002)(5660300002)(7736002)(53546011)(6436002)(97736004)(186003)(9686003)(6916009)(55016002)(26005)(229853002)(105586002)(71190400001)(71200400001)(86362001)(7696005)(76176011)(7416002)(102836004)(6506007)(106356001)(52536013);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1696;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HjA2bnpsD+rIDAWvZhVNfAp47qCPZOoAicR5Srm4eQLKjMzJl8SxPoJcD+hAJPuJ27VSZkjKiEPOXHmNn73NFMYVkC4di2x8yBT6Hb/snNnTGTx7VEnkm5eklbb9SygKfVaWsNJ0mPjhQDak8H5YcgT2wpWrTkmAvhwBXBdMytWoshC+yB2XW/RgTItxBveMYTntPylb+x3rjTnh0572Shqq2Eyr2zJT8O4371ackvkqtep0NhyQILpyDRPomDBPj3d+L/yOMLSUQ1mxG+pdEotVo1yM5pHlFsQJh623dMfT8eX9GLAmaWFxKXOMUWh886Ed4EXjl3EM3Ah6YFY1LWQkPLjS9jZLT1qmVxWfs+5P9jncEIfNGK5utnAHHxKMzFEHe4hYP/8QskhplDM00vxk+jNKRr4cSqp+Q4BEkFI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80237b-9084-4920-21de-08d69e4c7def
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 13:47:48.2937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFyYw0KDQo+IEZyb206IGRldmljZXRyZWUtb3duZXJAdmdlci5rZXJuZWwub3JnIDxk
ZXZpY2V0cmVlLW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIE1hcmMgWnluZ2ll
cg0KPiBTZW50OiAwMSBNYXJjaCAyMDE5IDEzOjM5DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0
LWJpbmRpbmdzOiBpcnFjaGlwOiByZW5lc2FzLWlycWM6IERvY3VtZW50IHI4YTc3NGMwIHN1cHBv
cnQNCj4gDQo+IE9uIDAxLzAzLzIwMTkgMTE6NDksIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4g
PiBIZWxsbyBNYXJjLA0KPiA+DQo+ID4gSSBhbSBzb3JyeSB0byBib3RoZXIgeW91Lg0KPiA+IERv
IHlvdSB0aGluayB5b3UgY2FuIHRha2UgdGhpcyBwYXRjaD8NCj4gDQo+IEl0IGFscmVhZHkgbWlz
c2VkIHRoZSBib2F0IGZvciB0aGUgbWVyZ2Ugd2luZG93LCBhcyBJIHNlbnQgdGhlIHB1bGwNCj4g
cmVxdWVzdCBsYXN0IHdlZWsuIFBsZWFzZSByZXNlbmQgaXQgYWZ0ZXIgLXJjMSwgYW5kIEknbGwg
cGljayBpdCB1cC4NCg0KV2lsbCBkby4NCg0KVGhhbmtzLA0KRmFiDQoNCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IAlNLg0KPiANCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBGYWINCj4gPg0KPiA+PiBGcm9t
OiBsaW51eC1yZW5lc2FzLXNvYy1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LXJlbmVzYXMt
c29jLW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIEZhYnJpemlvIENhc3Rybw0K
PiA+PiBTZW50OiAxMyBEZWNlbWJlciAyMDE4IDIwOjE4DQo+ID4+IFN1YmplY3Q6IFtQQVRDSF0g
ZHQtYmluZGluZ3M6IGlycWNoaXA6IHJlbmVzYXMtaXJxYzogRG9jdW1lbnQgcjhhNzc0YzAgc3Vw
cG9ydA0KPiA+Pg0KPiA+PiBEb2N1bWVudCBSWi9HMkUgKFI4QTc3NEMwKSBTb0MgYmluZGluZ3Mu
DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2Fz
dHJvQGJwLnJlbmVzYXMuY29tPg0KPiA+PiAtLS0NCj4gPj4gIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9yZW5lc2FzLGlycWMudHh0IHwgMSAr
DQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPj4NCj4gPj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9yZW5lc2FzLGlycWMudHh0DQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL3JlbmVzYXMsaXJxYy50eHQNCj4gPj4gaW5kZXgg
OGRlOTZhNC4uZjk3N2VhNyAxMDA2NDQNCj4gPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL3JlbmVzYXMsaXJxYy50eHQNCj4gPj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL3JlbmVzYXMsaXJxYy50eHQNCj4gPj4gQEAgLTE2LDYgKzE2LDcgQEAgUmVxdWlyZWQgcHJv
cGVydGllczoNCj4gPj4gICAgICAtICJyZW5lc2FzLGlycWMtcjhhNzc5MyIgKFItQ2FyIE0yLU4p
DQo+ID4+ICAgICAgLSAicmVuZXNhcyxpcnFjLXI4YTc3OTQiIChSLUNhciBFMikNCj4gPj4gICAg
ICAtICJyZW5lc2FzLGludGMtZXgtcjhhNzc0YTEiIChSWi9HMk0pDQo+ID4+ICsgICAgLSAicmVu
ZXNhcyxpbnRjLWV4LXI4YTc3NGMwIiAoUlovRzJFKQ0KPiA+PiAgICAgIC0gInJlbmVzYXMsaW50
Yy1leC1yOGE3Nzk1IiAoUi1DYXIgSDMpDQo+ID4+ICAgICAgLSAicmVuZXNhcyxpbnRjLWV4LXI4
YTc3OTYiIChSLUNhciBNMy1XKQ0KPiA+PiAgICAgIC0gInJlbmVzYXMsaW50Yy1leC1yOGE3Nzk2
NSIgKFItQ2FyIE0zLU4pDQo+ID4+IC0tDQo+ID4+IDIuNy40DQo+ID4NCj4gDQo+IA0KPiAtLQ0K
PiBKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLg0K
