Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CBC468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4B420859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zd7JizMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbfFJGOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:14:03 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:44960
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387431AbfFJGOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SINQaPHgAEEEQOP10ks6cwnEcolXnIrpaqFIzUTCdMU=;
 b=Zd7JizMG12cg/EkzMg01I4KMf1zLz1x1seu3csRatE2/UqwYamilKl+4lCv3lUbUpI6jnSThDzmWFuJosWm6rKezM7TlPG6uAMIG1Zs0i9OWzYa/LqodY6MIYfnv7X5gzS1jCoH3zHeuu/5Usv+P2XD8Chg+IrJzwF0Spwt3HMc=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB3229.eurprd04.prod.outlook.com (10.170.227.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 06:13:57 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9891:c973:a697:3c7b]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9891:c973:a697:3c7b%3]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 06:13:57 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHVG4YPzgz12rGdtU+X64LQwj+FpKaOii2AgAEWlQCAAE43gIAEbGOAgAAQjCA=
Date:   Mon, 10 Jun 2019 06:13:57 +0000
Message-ID: <VI1PR04MB532797447E56454C0E2D3F668B130@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-2-git-send-email-pawell@cadence.com>
 <f032b3f3-409d-b0fc-8d5f-01c898b4c7a7@ti.com>
 <BYAPR07MB470903AF06C1F8A34BBB3C64DD100@BYAPR07MB4709.namprd07.prod.outlook.com>
 <64be9d26-2a68-1b90-89c8-29b227e0cd9c@ti.com>
 <BYAPR07MB470965B3CBCB58E1C7B1253FDD130@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB470965B3CBCB58E1C7B1253FDD130@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ec7f15b-4f3e-4eb2-3508-08d6ed6ad29e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3229;
x-ms-traffictypediagnostic: VI1PR04MB3229:
x-microsoft-antispam-prvs: <VI1PR04MB3229B94CFAD7F3009FDAC51C8B130@VI1PR04MB3229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(316002)(52536014)(33656002)(5660300002)(256004)(54906003)(66446008)(110136005)(66476007)(66556008)(64756008)(6436002)(55016002)(53936002)(25786009)(73956011)(66946007)(76116006)(9686003)(229853002)(476003)(26005)(44832011)(74316002)(2501003)(99286004)(305945005)(11346002)(446003)(76176011)(102836004)(2906002)(186003)(68736007)(6116002)(3846002)(486006)(7696005)(6506007)(14454004)(478600001)(7736002)(86362001)(71200400001)(71190400001)(8936002)(66066001)(81156014)(81166006)(4326008)(6246003)(7416002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3229;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JkdYXcYftmv/JVICL5CHyg/m8Usg8zwguuHM9dMacpDe55ZNDuFmoCqRXrG2Vvg/4HXD/Zk4BZ2HAnRffn6kkQ7Ss75X9Qrc+Ko4YZ7Tu+nXh9mhx5pf3etorWXQmMtPRDR3tsaBzJa2JpKDWfWFgT9dNWusOTrauLrOYaUjfUb+pXE+GeOg6Qm3jqy1ZWMZJJXA5Ebm/VOWL96fEVi/RbGKkXCrpjTIg0q7aDm1rMUbW6zkRuEVsh3w9QaIm+Utkiytv8MMaT+rdMmBB6AvQ3AuYQd/+qePK+zG6VFSabn6VRkdo3EZV89XBUXgo/ZCwxlUEPicsZ+O95AICt7D8Cp+M6Gqy7Cr3FCZTcO7xlqWyar5H6NQDyXgr4U81FxWz+SFdtBi4rmL0sjxCfdBubq/qus6TFK/OFe28y9oO0E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7f15b-4f3e-4eb2-3508-08d6ed6ad29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 06:13:57.3734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peter.chen@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiAgLSByZWctbmFtZXMgLSByZWdpc3RlciBtZW1vcnkgYXJlYSBuYW1lczoNCj4gICAgICAg
ICAieGhjaSIgLSBmb3IgSE9TVCByZWdpc3RlcnMgc3BhY2UNCj4gICAgICAgICAiZGV2IiAtIGZv
ciBERVZJQ0UgcmVnaXN0ZXJzIHNwYWNlDQo+ICAgICAgICAgIm90ZyIgLSBmb3IgT1RHL0RSRCBy
ZWdpc3RlcnMgc3BhY2UNCj4gIC0gY29tcGF0aWJsZTogU2hvdWxkIGNvbnRhaW46DQo+ICAgICAg
ICAgImNkbnMsdXNiMy0xLjAuMCIgLSBmb3IgMHgwMDAyNDUwMiBjb250cm9sbGVyIHZlcnNpb24N
Cj4gICAgICAgICAiY2Rucyx1c2IzLTEuMC4xIiAtIGZvciAweDAwMDI0NTA5IGNvbnRyb2xsZXIg
dmVyc2lvbg0KPiAgICAgICAgICJjZG5zLHVzYjMtMS4wLjIiIC0gZm9yIDB4MDAwMjQ1MEMgY29u
dHJvbGxlciB2ZXJzaW9uDQo+ICAgICAgICAgImNkbnMsdXNiMy0xLjAuMyIgLSBmb3IgMHgwMDAy
NDUwZCBjb250cm9sbGVyIHZlcnNpb24NCg0KSWYgdGhlIHZhbHVlIGNhbiBiZSByZWFkIGZyb20g
cmVnaXN0ZXIsIHdoeSB3ZSBzdGlsbCBuZWVkIGRpZmZlcmVudCBjb21wYXRpYmxlcz8NCg0KPiBF
eGFtcGxlOg0KPiAgICAgICAgIHVzYkBmMzAwMDAwMCB7DQo+ICAgICAgICAgICAgICAgICBjb21w
YXRpYmxlID0gImNkbnMsdXNiMy0xLjAuMSI7DQo+ICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRz
ID0gPEdJQ19VU0JfSVJRIDcgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPEdJQ19VU0JfSVJRICA3IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfVVNCX0lSUSAgOCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4gICAgICAgICAgICAgICAgIGludGVycnVwdC1uYW1lcyA9ICJob3N0
IiwgInBlcmlwaGVyYWwiLCAib3RnIjsNCj4gICAgICAgICAgICAgICAgIHJlZyA9IDwweGYzMDAw
MDAwIDB4MTAwMDA+LCAgICAgLyogbWVtb3J5IGFyZWEgZm9yIEhPU1QgcmVnaXN0ZXJzICovDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIDwweGYzMDEwMDAwIDB4MTAwMDA+LCAgIC8qIG1lbW9y
eSBhcmVhIGZvciBERVZJQ0UgcmVnaXN0ZXJzICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IDwweGYzMDIwMDAwIDB4MTAwMDA+OyAgIC8qIG1lbW9yeSBhcmVhIGZvciBPVEcvRFJEIHJlZ2lz
dGVycw0KPiAqLw0KPiAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gInhoY2kiLCAiZGV2Iiwg
Im90ZyI7DQo+ICAgICAgICAgICAgICAgICBwaHlzID0gPCZ1c2IzX3BoeT47DQo+ICAgICAgICAg
ICAgICAgICBwaHktbmFtZXMgPSAiY2RuczMsdXNicGh5IjsNCj4gDQo+IA0KPiBNYXliZSBJIHNo
b3VsZCBhZGQgYWxzbyBzb21ldGhpbmcgZm9yIHVzYjJfcGh5IGluIGR0LWJpbmRpbmcgYW5kIGlu
IGRyaXZlciA/DQo+IA0KDQpUaGUgUEhZIGRyaXZlciBpcyBsb2NhdGVkIGF0OiBkcml2ZXJzL3Bo
eS9jYWRlbmNlL3BoeS1jYWRlbmNlLXNpZXJyYS5jLg0KV2lsbCB3ZSBuZWVkIGFub3RoZXIgb25l
IGZvciBVU0IyIFBIWT8NCg0KUGV0ZXINCg0KDQo+IFRoYW5rcywNCj4gUmVnYXJkcywNCj4gUGF3
ZWwNCj4gDQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IFBhd2VsDQo+ID4+DQo+ID4+DQo+ID4+
Pg0KPiA+Pj4+ICsNCj4gPj4+PiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPj4+PiArIC0gbWF4
aW11bS1zcGVlZCA6IHZhbGlkIGFyZ3VtZW50cyBhcmUgInN1cGVyLXNwZWVkIiwgImhpZ2gtc3Bl
ZWQiIGFuZA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgImZ1bGwtc3BlZWQiOyByZWZlciB0
byB1c2IvZ2VuZXJpYy50eHQNCj4gPj4+PiArIC0gZHJfbW9kZTogU2hvdWxkIGJlIG9uZSBvZiAi
aG9zdCIsICJwZXJpcGhlcmFsIiBvciAib3RnIi4NCj4gPj4+PiArIC0gcGh5czogcmVmZXJlbmNl
IHRvIHRoZSBVU0IgUEhZDQo+ID4+Pj4gKw0KPiA+Pj4+ICtFeGFtcGxlOg0KPiA+Pj4+ICsJdXNi
QGYzMDAwMDAwIHsNCj4gPj4+PiArCQljb21wYXRpYmxlID0gImNkbnMsdXNiMy0xLjAuMSI7DQo+
ID4+Pj4gKwkJaW50ZXJydXB0cyA9IDxVU0JfSVJRICA3IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
PiA+Pj4NCj4gPj4+IFRoaXMgZXhhbXBsZSB3b24ndCB3b3JrIGFzIGNvZGUgcmVxdWVzdHMgZm9y
IDMgc2VwYXJhdGUgaW50ZXJydXB0cy4NCj4gPj4+DQo+ID4+Pj4gKwkJcmVnID0gPDB4ZjMwMDAw
MDAgMHgxMDAwMAkvKiBtZW1vcnkgYXJlYSBmb3IgSE9TVA0KPiByZWdpc3RlcnMgKi8NCj4gPj4+
PiArCQkJMHhmMzAxMDAwMCAweDEwMDAwCS8qIG1lbW9yeSBhcmVhIGZvciBERVZJQ0UNCj4gcmVn
aXN0ZXJzICovDQo+ID4+Pj4gKwkJCTB4ZjMwMjAwMDAgMHgxMDAwMD47CS8qIG1lbW9yeSBhcmVh
IGZvcg0KPiBPVEcvRFJEIHJlZ2lzdGVycyAqLw0KPiA+Pj4+ICsJCXJlZy1uYW1lcyA9ICJ4aGNp
IiwgImRldiIsICJvdGciOw0KPiA+Pj4+ICsJfTsNCj4gPj4+Pg0KPiA+Pj4NCj4gPg0KPiA+DQo+
ID4tLQ0KPiA+Y2hlZXJzLA0KPiA+LXJvZ2VyDQo+ID4NCj4gPlRleGFzIEluc3RydW1lbnRzIEZp
bmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPiA+WS10dW5udXMv
QnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kNCg==
