Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8D7C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F153217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="US/umAmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfEUCQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:16:52 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:34563
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfEUCQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luVXe9ppYOUAjgWv4+viPwG8DNqcuVUU9kONVNRzOVQ=;
 b=US/umAmAh2ZfAH7SX9GexjXN5LQT1XRpZsoiwrkTWx8sFU4LI975ItxiDAkfB9lJQKZb3e72/5DBXj78HvfNHrIarjGq4m9OeuECMkJ5NlcKK55WHtN28UkX0kDZUfSCIKPGPi6wKtDK0GP/sN0rLB2OUUtOgAa/mW5teY8pRkc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 02:16:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 02:16:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: linux-next: build failure after merge of the imx-mxs tree
Thread-Topic: linux-next: build failure after merge of the imx-mxs tree
Thread-Index: AQHVD1yx789OZHQ730mdKrHPx497h6Z01vKw
Date:   Tue, 21 May 2019 02:16:47 +0000
Message-ID: <DB3PR0402MB39165C5944880EA0B0A37F91F5070@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190521083756.4c8aee8a@canb.auug.org.au>
In-Reply-To: <20190521083756.4c8aee8a@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80bd84e5-623d-4529-fd15-08d6dd9260d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3658;
x-ms-traffictypediagnostic: DB3PR0402MB3658:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB36583E37703D162B2414FB4DF5070@DB3PR0402MB3658.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39850400004)(199004)(189003)(13464003)(26005)(186003)(305945005)(2906002)(9686003)(6306002)(55016002)(6116002)(99286004)(3846002)(7736002)(25786009)(5660300002)(76176011)(486006)(4326008)(33656002)(110136005)(6436002)(53546011)(6506007)(316002)(7696005)(446003)(11346002)(476003)(52536014)(68736007)(74316002)(229853002)(44832011)(256004)(14444005)(102836004)(53936002)(8936002)(73956011)(86362001)(76116006)(66446008)(66946007)(66476007)(66556008)(64756008)(71200400001)(71190400001)(66066001)(478600001)(8676002)(966005)(14454004)(81156014)(54906003)(81166006)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3658;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BoS3+mwhTtXXA0awdtRsEOhmYJLt+J/vSSMKopi4Lxhn7dD3Xpvghw0WZXopIbYgIJO9N/kftYlQlKejoRhq7njFxPzpo6byYh0ZxGldDQPOHIXjaT7Ap0bpkkG4LKxcCu/D/VmTlOOT4me0nEq0Wze6vz9fEflee1SetOLNc9ociruMXAS0u/HHB8GQjcpAbXXWO2OBuxPyxOLmz+S2KasoB2lUA9hTTtgzg8gWBOJu2je2CcBzs9LGNM+mFGlnRDX/6uFqxakQU9ae6VglFyPK8iIsoOGdZzSqqkv5wLbW6Z/75cjAjNA0gb83FVkUyu4LWEBD/br1lfqQQPgKCt/SmHDXlY8n2drtWa9+KDAadGtxyLQT4RZM+Z4vmRkLN8A6US91s1LECS52PLK35vQW1D1rUfgUmj2rovM/m6I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bd84e5-623d-4529-fd15-08d6dd9260d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 02:16:47.7410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4vU2hhd24NCglJIHJlYWxpemVkIHRoaXMgaXNzdWUgbGFzdCB3ZWVrIHdoZW4g
SSB1cGRhdGVkIG15IExpbnV4LW5leHQgdHJlZSAoTk9UIHN1cmUgd2h5IEkgZGlkIE5PVCBtZWV0
IHN1Y2ggaXNzdWUgd2hlbiBJIGRpZCB0aGUgcGF0Y2gpLCBzbyBJIHJlc2VudCB0aGUgcGF0Y2gg
c2VyaWVzIG9mIGFkZGluZyBoZWFkIGZpbGUgImlvLmgiIHRvIGZpeCB0aGlzIGlzc3VlLCBwbGVh
c2UgYXBwbHkgYmVsb3cgVjIgcGF0Y2ggc2VyaWVzIGluc3RlYWQsIHNvcnJ5IGZvciB0aGUgaW5j
b252ZW5pZW5jZS4NCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDk0NDY4
MS8NCg0KdGhhbmtzLA0KQW5zb24uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogU3RlcGhlbiBSb3Rod2VsbCBbbWFpbHRvOnNmckBjYW5iLmF1dWcub3JnLmF1XQ0KPiBT
ZW50OiBUdWVzZGF5LCBNYXkgMjEsIDIwMTkgNjozOCBBTQ0KPiBUbzogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBDYzogTGludXggTmV4dCBNYWlsaW5nIExpc3QgPGxpbnV4LW5l
eHRAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcNCj4gTGlzdCA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz47IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29t
PjsNCj4gQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogbGlu
dXgtbmV4dDogYnVpbGQgZmFpbHVyZSBhZnRlciBtZXJnZSBvZiB0aGUgaW14LW14cyB0cmVlDQo+
IA0KPiBIaSBTaGF3biwNCj4gDQo+IEFmdGVyIG1lcmdpbmcgdGhlIGlteC1teHMgdHJlZSwgdG9k
YXkncyBsaW51eC1uZXh0IGJ1aWxkIChhcm0NCj4gbXVsdGlfdjdfZGVmY29uZmlnKSBmYWlsZWQg
bGlrZSB0aGlzOg0KPiANCj4gZHJpdmVycy9jbGsvaW14L2Nsay5jOiBJbiBmdW5jdGlvbiAnaW14
X21tZGNfbWFza19oYW5kc2hha2UnOg0KPiBkcml2ZXJzL2Nsay9pbXgvY2xrLmM6MjA6ODogZXJy
b3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uDQo+ICdyZWFkbF9yZWxheGVkJzsg
ZGlkIHlvdSBtZWFuICd4Y2hnX3JlbGF4ZWQnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi0N
Cj4gZGVjbGFyYXRpb25dDQo+ICAgcmVnID0gcmVhZGxfcmVsYXhlZChjY21fYmFzZSArIENDTV9D
Q0RSKTsNCj4gICAgICAgICBefn5+fn5+fn5+fn5+DQo+ICAgICAgICAgeGNoZ19yZWxheGVkDQo+
IGRyaXZlcnMvY2xrL2lteC9jbGsuYzoyMjoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24NCj4gJ3dyaXRlbF9yZWxheGVkJzsgZGlkIHlvdSBtZWFuICd4Y2hnX3JlbGF4
ZWQnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi0NCj4gZGVjbGFyYXRpb25dDQo+ICAgd3Jp
dGVsX3JlbGF4ZWQocmVnLCBjY21fYmFzZSArIENDTV9DQ0RSKTsNCj4gICBefn5+fn5+fn5+fn5+
fg0KPiAgIHhjaGdfcmVsYXhlZA0KPiANCj4gQ2F1c2VkIGJ5IGNvbW1pdA0KPiANCj4gICAwZGM2
YjQ5MmI2ZTAgKCJjbGs6IGlteDogQWRkIGNvbW1vbiBBUEkgZm9yIG1hc2tpbmcgTU1EQyBoYW5k
c2hha2UiKQ0KPiANCj4gSSBoYXZlIHVzZWQgdGhlIGlteC1teHMgdHJlZSBmcm9tIG5leHQtMjAx
OTA1MjAgZm9yIHRvZGF5Lg0KPiANCj4gLS0NCj4gQ2hlZXJzLA0KPiBTdGVwaGVuIFJvdGh3ZWxs
DQo=
