Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7AAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE9121655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TO9aGaIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfEHNxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:53:15 -0400
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:27619
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbfEHNxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgKwGK9XAVAlSpbyrk2pzbEUWzi3GP2Du0GKkaGC+SY=;
 b=TO9aGaIXHYmjEEtVVeIjImR5eEx1cOOePazHzd0u0pkXbyUNWczGQn9/zcwWBZbT1bcBYo1O548/CiSUmuGxBuDwaqiS0vcCWRk5fn4PADToxQtvnXG7T9wlHJE3xCX5jhtDZYVc71VJ2Pc/teS1kg973KMn3TSIVX/mjJoAIjM=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6150.eurprd04.prod.outlook.com (20.179.6.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 8 May 2019 13:53:08 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 13:53:08 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add device tree binding for
 ls1046a-frwy board
Thread-Topic: [PATCH 1/2] dt-bindings: arm: fsl: Add device tree binding for
 ls1046a-frwy board
Thread-Index: AQHVBaVekdR03tTu+kaI2tl1Ga7vNw==
Date:   Wed, 8 May 2019 13:53:08 +0000
Message-ID: <20190508135501.17578-2-pramod.kumar_1@nxp.com>
References: <20190508135501.17578-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190508135501.17578-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0174f398-2964-475b-42fd-08d6d3bc8067
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6150;
x-ms-traffictypediagnostic: AM6PR04MB6150:
x-microsoft-antispam-prvs: <AM6PR04MB615016068AB8D1747E7F9D60F6320@AM6PR04MB6150.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(1076003)(6436002)(476003)(4326008)(66066001)(11346002)(2616005)(71190400001)(71200400001)(14454004)(446003)(4744005)(66476007)(5660300002)(2501003)(3846002)(66556008)(6116002)(64756008)(76176011)(256004)(110136005)(66446008)(2201001)(86362001)(68736007)(54906003)(25786009)(73956011)(52116002)(66946007)(99286004)(486006)(53936002)(6512007)(316002)(6486002)(478600001)(386003)(6506007)(8936002)(50226002)(102836004)(305945005)(7736002)(26005)(2906002)(186003)(81166006)(8676002)(36756003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6150;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: adhty3b5epEA+h1wR5I/blEpRZLE/y1vlhSGuiOEqtVhGqgi8VsnhiIG+TYxvoUzuIlDXv3Wam1YU4PVqhEpmq1wrMZlOoaSUW7E37rdYLS2zY3nKw3plDofyJY3Pu6HXQ9hBMf6SzkEiIrOwBfIvz0BAjL/iAKpw0i+RIxiOtkk68kiL+xeslfTNuYjDDiH9awllcZlEkXI4aCbMCtgpg5meQG/vVg3+xWwqzaf8hWzoatsPWqZPC2rt/3fshLMnIToMp4b9BJkA9xXhh9KhO5q9Q6Eq8jk9U5urI9456Ugpa3F4gBCf9dEmPKaLZnhuKghgN+2XmPSEjwZ+kKdGN4UJ6R9JCADgvvWNog0gghL15rVs/dZKzl8vp3s0mIVE9IYMKPARO3pqjWAKBXKdRG8hXoCbt5UsD7HqqoJCGo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0174f398-2964-475b-42fd-08d6d3bc8067
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 13:53:08.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICJmc2wsbHMxMDQ2YS1mcnd5IiBiaW5kaW5ncyBmb3IgbHMxMDQ2YWZyd3kgYm9hcmQgYmFz
ZWQgb24gbHMxMDQ2YSBTb0MNCg0KU2lnbmVkLW9mZi1ieTogVmFiaGF2IFNoYXJtYSA8dmFiaGF2
LnNoYXJtYUBueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogUHJhbW9kIEt1bWFyIDxwcmFtb2Qua3Vt
YXJfMUBueHAuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9mc2wueWFtbCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCmluZGV4IDdl
MmNkNmFkMjZiZC4uODczOTk5YmY0YTQzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KQEAgLTIwNSw2ICsyMDUsNyBAQCBwcm9wZXJ0aWVz
Og0KICAgICAgICAgICAtIGVudW06DQogICAgICAgICAgICAgICAtIGZzbCxsczEwNDZhLXFkcw0K
ICAgICAgICAgICAgICAgLSBmc2wsbHMxMDQ2YS1yZGINCisgICAgICAgICAgICAgIC0gZnNsLGxz
MTA0NmEtZnJ3eQ0KICAgICAgICAgICAtIGNvbnN0OiBmc2wsbHMxMDQ2YQ0KIA0KICAgICAgIC0g
ZGVzY3JpcHRpb246IExTMTA4OEEgYmFzZWQgQm9hcmRzDQotLSANCjIuMTcuMQ0KDQo=
