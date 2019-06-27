Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BD2C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE62E2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pZt1dlzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfF0IMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:12:34 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:62531
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0IMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsdPYxCU7srWVhLq1BGY9FbUyssnUN5o9xuGkke+PCw=;
 b=pZt1dlzCRiWkRS30GslqPfucc/vO1TQMsZjPHxyE6Kswkx0Ob8U7TDi8HSedaa20ElFjTq9vZvBir/CIfn9gZMQSErsiyNBMjrhcippdn7kWU+oEiBXiwXdHaEqK/o+vLbTEFaxHMfldr5iLM0eMBRJtU4p9Ay3HbBNCcvuYkVs=
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com (20.177.35.159) by
 AM6PR04MB4453.eurprd04.prod.outlook.com (20.176.242.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 08:12:21 +0000
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::9c87:7753:43b9:6d4a]) by AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::9c87:7753:43b9:6d4a%4]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 08:12:21 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 2/2] dt-bindings: dsp: fsl: Add DSP IPC binding support
Thread-Topic: [PATCH v2 2/2] dt-bindings: dsp: fsl: Add DSP IPC binding
 support
Thread-Index: AQHVLMALhzY9Df127E6IyTklCWRQSg==
Date:   Thu, 27 Jun 2019 08:12:20 +0000
Message-ID: <20190627081205.22065-3-daniel.baluta@nxp.com>
References: <20190627081205.22065-1-daniel.baluta@nxp.com>
In-Reply-To: <20190627081205.22065-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0020.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::30) To AM6PR04MB5207.eurprd04.prod.outlook.com
 (2603:10a6:20b:e::31)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef5f7e60-15ff-412d-ed94-08d6fad72d5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4453;
x-ms-traffictypediagnostic: AM6PR04MB4453:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM6PR04MB445331A82319DC284FEC1699F9FD0@AM6PR04MB4453.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(966005)(2501003)(81156014)(25786009)(68736007)(256004)(186003)(14454004)(26005)(66066001)(476003)(99286004)(50226002)(6506007)(4326008)(8936002)(8676002)(81166006)(386003)(44832011)(102836004)(52116002)(305945005)(486006)(76176011)(446003)(3846002)(71190400001)(54906003)(53376002)(6306002)(71200400001)(7736002)(11346002)(6436002)(2616005)(478600001)(86362001)(316002)(53936002)(36756003)(5660300002)(1076003)(110136005)(66556008)(66476007)(64756008)(66946007)(73956011)(6486002)(2906002)(6116002)(66446008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4453;H:AM6PR04MB5207.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3tbO6/wDWf0lvpKRVEuDkUAi13vGSihk6hvcbmDCRVpgO+RUMuRfZvUK6JNAAqVgAa7x6j6NA+xjZRL7127JPnlNSpiE2mhUA/swZuSnQWZWf8FaEVNSygITVlS/CLALcuHeoj40eDln4LprBRUWI1vpXgQA+iUeh2ik4oH0K/oPQTUidpSvbldCV3wgnVNkDd2deQ+w9+EalEI8apw99MDdlhll4MQZo9+6SPma/7FFLJIPst+yQiMLyNBckHzSzD4PFBU54/xE2OxSBgt2C5RaKLQhr/zlQDhIkXUqdZovn2DFwBd/YLhcEKZymarfqL7u9UOG8xYwBs/oNRIZ2I116hrZGviO6/s62NlmbXXfM/Z/2g5D8vPsWF+MvdR5RyvuDiDi5riu/Gq+wM9isTAWjLx7TwaVnvK6i1/O2/o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5f7e60-15ff-412d-ed94-08d6fad72d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 08:12:21.0739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daniel.baluta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFNQIElQQyBpcyB0aGUgbGF5ZXIgdGhhdCBhbGxvd3MgdGhlIEhvc3QgQ1BVIHRvIGNvbW11bmlj
YXRlDQp3aXRoIERTUCBmaXJtd2FyZS4NCkRTUCBpcyBwYXJ0IG9mIHNvbWUgaS5NWDggYm9hcmRz
IChlLmcgaS5NWDhRTSwgaS5NWDhRWFApDQoNClNpZ25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEg
PGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rz
cC9mc2wsZHNwX2lwYy55YW1sICB8IDQ0ICsrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZHNwL2ZzbCxkc3BfaXBjLnlhbWwNCg0KZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AvZnNsLGRzcF9pcGMueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AvZnNsLGRzcF9pcGMueWFtbA0K
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uMWNiZjVkMjViMjU4DQot
LS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZHNw
L2ZzbCxkc3BfaXBjLnlhbWwNCkBAIC0wLDAgKzEsNDQgQEANCisjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwgMS4yDQorLS0tDQorJGlk
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9hcm0vZnJlZXNjYWxlL2ZzbCxkc3AueWFt
bCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFt
bCMNCisNCit0aXRsZTogTlhQIGkuTVg4IElQQyBEU1AgaW50ZXJmYWNlDQorDQorbWFpbnRhaW5l
cnM6DQorICAtIERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCisNCitkZXNj
cmlwdGlvbjogfA0KKyAgSVBDIGNvbW11bmljYXRpb24gbGF5ZXIgYmV0d2VlbiBIb3N0IENQVSBh
bmQgRFNQIG9uIE5YUCBpLk1YOCBwbGF0Zm9ybXMNCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0
aWJsZToNCisgICAgZW51bToNCisgICAgICAtIGZzbCxpbXg4cXhwLWRzcA0KKw0KKyAgbWJveGVz
Og0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICBMaXN0IG9mIDwmcGhhbmRsZSB0eXBlIGNoYW5u
ZWw+IC0gMiBjaGFubmVscyBmb3IgVFhEQiwgMiBjaGFubmVscyBmb3IgUlhEQg0KKyAgICAgIChz
ZWUgbWFpbGJveC9mc2wsbXUudHh0KQ0KKyAgICBtYXhJdGVtczogNA0KKw0KKyAgbWJveC1uYW1l
czoNCisgICAgaXRlbXM6DQorICAgICAgLSBjb25zdDogdHhkYjANCisgICAgICAtIGNvbnN0OiB0
eGRiMQ0KKyAgICAgIC0gY29uc3Q6IHJ4ZGIwDQorICAgICAgLSBjb25zdDogcnhkYjENCisNCity
ZXF1aXJlZDoNCisgIC0gY29tcGF0aWJsZQ0KKyAgLSBtYm94ZXMNCisgIC0gbWJveC1uYW1lcw0K
Kw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIGRzcF9pcGMgew0KKyAgICAgIGNvbXBhdGJpbGUg
PSAiZnNsLGlteDhxeHAtZHNwIjsNCisgICAgICBtYm94LW5hbWVzID0gInR4ZGIwIiwgInR4ZGIx
IiwgInJ4ZGIwIiwgInJ4ZGIxIjsNCisgICAgICBtYm94ZXMgPSA8JmxzaW9fbXUxMyAyIDA+LCA8
JmxzaW9fbXUxMyAyIDE+LCA8JmxzaW9fbXUxMyAzIDA+LCA8JmxzaW9fbXUxMyAzIDE+Ow0KKyAg
ICB9Ow0KLS0gDQoyLjE3LjENCg0K
