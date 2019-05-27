Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A8C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9887F2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NahhbJgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfE0MEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:04:23 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:65249
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfE0MEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wRumjJQB3ouNn4eLIeBn/rikleqowhhNTpCqONcaoQ=;
 b=NahhbJgB6q3zYaggGD9tAHV0brDxkT32eQBASqSUzKpqFaIr0pDH9FQ2ofMXfm3lxCy/Dy6vyikEutZcIeXIHLCYUs3VJV/IgAzcid6MpsvNRYnEMf9PXXrc3mljx8duqUGjsUfkvM1eR35KGlb+1WDzEU/rUH/raOIMbJDSLeo=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB5064.eurprd04.prod.outlook.com (20.177.33.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Mon, 27 May 2019 12:04:18 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21%4]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 12:04:18 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/3] arm64: dts: nxp: add ls1046a frwy board support 
Thread-Topic: [PATCH v3 0/3] arm64: dts: nxp: add ls1046a frwy board support 
Thread-Index: AQHVFIRP3J0s0G2/YU6PMd2cA4zVZg==
Date:   Mon, 27 May 2019 12:04:17 +0000
Message-ID: <20190527120619.30546-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: BMXPR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::26) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eca1db8-16e9-4174-0a4b-08d6e29b71aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5064;
x-ms-traffictypediagnostic: AM6PR04MB5064:
x-microsoft-antispam-prvs: <AM6PR04MB5064F4F359AC9F27A7A8F3B1F61D0@AM6PR04MB5064.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(66066001)(14454004)(99286004)(2906002)(486006)(2501003)(52116002)(186003)(110136005)(54906003)(26005)(25786009)(53936002)(4744005)(36756003)(5660300002)(4326008)(256004)(478600001)(2616005)(476003)(6116002)(3846002)(71190400001)(71200400001)(1076003)(81166006)(81156014)(68736007)(6512007)(50226002)(6436002)(66446008)(66556008)(64756008)(73956011)(66946007)(66476007)(316002)(7736002)(305945005)(6486002)(86362001)(386003)(6506007)(2201001)(102836004)(8676002)(8936002)(6636002)(4743002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5064;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5M0zGM0KdYhNn6/jsd1SZUE4YEv1ANEZX96hsrSpN26NvFOZkoIZ36wfKMY/18PZQ8BdRXmedBbSt4028nYGw/xcB7I+4tCmRyjOFPa9K5qodQ3Q3FddfkfHZIELiRXuIhtNCgZSpbSZ27om8GFzzl5dRdXDmhNy09iyetOXhnWbp9CRbnZIRRMVr8ac9hnknKwXKuCQ5tjeuboBI5OBOIymajrMwgItq1zEDvXHLUEoq39koC9Meb6C2uQqmAjloWB/OwlNHPNaPTdra3FPcxKTOO/GAAdDe54IcTr3h3on/AHEBwR7QD9+zBYdPiyifj4OesbEVp5P9c2xrVxmy9P92f+k3sIRdifvFQ1BM0T6RnhqIYDW/vzCB7/vEc9gUnzHXJ/qsi7G4BfFf9oSIbjZnVF20oGNLpHI892xtxw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eca1db8-16e9-4174-0a4b-08d6e29b71aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 12:04:18.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBmb3IgdjM6DQotIFJlbW92ZSB1bmRvY3VtZW50ZWQgcHJvcGVydCBpMmMtbXV4LW5l
dmVyLWRpc2FibGUNCi0gU29ydCBub2RlcyBhdCBpMmMgbXV4IGluIHVuaXQtYWRkcmVzcw0KLSBS
ZW1vdmUgVW5uZWNlc3NhcnkgbmV3bGluZQ0KDQpDaGFuZ2VzIGZvciB2MjoNCi0gTW9kaWZpZWQg
Y29taXQgbWVzc2FnZQ0KLSBBZGQgZHRzIGVudHJ5IGZvciBxc3BpIG5vciBmbGFzaA0KDQpQcmFt
b2QgS3VtYXIgKDMpOg0KICBkdC1iaW5kaW5nczogYXJtOiBueHA6IEFkZCBkZXZpY2UgdHJlZSBi
aW5kaW5nIGZvciBsczEwNDZhLWZyd3kgYm9hcmQNCiAgYXJtNjQ6IGR0czogbnhwOiBhZGQgbHMx
MDQ2YS1mcnd5IGJvYXJkIHN1cHBvcnQNCiAgYXJtNjQ6IGR0czogZnJ3eS1sczEwNDZhOiBhZGQg
c3VwcG9ydCBmb3IgbWljcm9uIG5vciBmbGFzaA0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZzbC55YW1sICAgICAgICAgIHwgICAxICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9NYWtlZmlsZSAgICAgICAgfCAgIDEgKw0KIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvZnNs
LWxzMTA0NmEtZnJ3eS5kdHMgICB8IDE3MiArKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNo
YW5nZWQsIDE3NCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLWZyd3kuZHRzDQoNCi0tIA0KMi4xNy4xDQoN
Cg==
