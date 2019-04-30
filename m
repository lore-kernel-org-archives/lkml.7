Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F191C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D32C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g579Lo9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfD3FPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:15:52 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:13026
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbfD3FPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta9fMO0dk7pewKBA7DrSOk86lqYpvZH1CHv061S4JgA=;
 b=g579Lo9pG1iL7GGAFjvOAkb7Luw5EyRNl5KAXLPnGSZymKMiGvme8g6VQtQjomM+KrirzuESDxeuIKigGdAODVyaqP418MH4n4IrB/qKEeRPEYXJZmzb48kvZPMr7TluLHGw67JYGAaVyud7X9ZRnaz/Nb+IU4Ix5IUxDQV7mhw=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB6205.eurprd04.prod.outlook.com (20.179.24.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Tue, 30 Apr 2019 05:15:47 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 05:15:47 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
Subject: [PATCH v1] mmc: dt: add DT bindings for ls1028a eSDHC host controller
Thread-Topic: [PATCH v1] mmc: dt: add DT bindings for ls1028a eSDHC host
 controller
Thread-Index: AQHU/xPEWmF2aWlBZkm+gILQArYb6Q==
Date:   Tue, 30 Apr 2019 05:15:47 +0000
Message-ID: <20190430051723.31345-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:36::23) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d7e4c34-82e3-4de3-d40c-08d6cd2ae718
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6205;
x-ms-traffictypediagnostic: VI1PR04MB6205:
x-microsoft-antispam-prvs: <VI1PR04MB62053D5DE39D885430AA3559E93A0@VI1PR04MB6205.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(66446008)(6506007)(99286004)(66476007)(64756008)(66556008)(2906002)(386003)(66946007)(52116002)(6636002)(102836004)(6486002)(97736004)(66066001)(1076003)(25786009)(14454004)(6436002)(73956011)(54906003)(53936002)(50226002)(5660300002)(7736002)(4744005)(44832011)(316002)(305945005)(4326008)(478600001)(256004)(36756003)(71200400001)(86362001)(8936002)(26005)(2201001)(8676002)(186003)(81166006)(6116002)(81156014)(110136005)(486006)(476003)(2616005)(68736007)(71190400001)(2501003)(6512007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6205;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EMuLPZOLhFw13wtFI7bebAlURuTnqSSTrg9h7zfzJBYioLK9bcy//FyH2O0AwWBgBRt4Fvprcqzy0y8yGz8z3LqLMYAHieMaQFenFa30tbuZS7bcoTA1KGfB7piqYaG9OgzOGb2FPx0ibMsvU+YldbLmi0sn2DsOv0Edp8yzEt5hXgUmmTxfjPcONl2BMeZdAZ7cFGBGP5+NoCl3BLUiAgEVhYUts4W3gGnnMIkcbbS9sGzNrxm5TRydvf3ou7J0T5LXbseNpDYhuWEhN8b89WDpGjgT9BtapPp+vo25wD8S9W1CoPkG8qxNzek6xHrqtr8pGv/sYX2eM0VQaIQ9FjrPFXznAbwLwRo6R3fbaSSGMmw8a31BHZK5+UQVrywtmiEAuK7JprieBo7Z58efn3Hj2ThiNDrfhm7GV+opBuU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7e4c34-82e3-4de3-d40c-08d6cd2ae718
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 05:15:47.5382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCg0KQWRkICJmc2wsbHMxMDI4YS1l
c2RoYyIgYmluZGluZ3MgZm9yIGxzMTAyOGEgZVNESEMgaG9zdCBjb250cm9sbGVyDQoNClNpZ25l
ZC1vZmYtYnk6IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQotLS0NCiAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvZnNsLWVzZGhjLnR4dCAgICAgICAgICB8ICAgIDEgKw0KIDEgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtZXNkaGMudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtZXNkaGMudHh0DQppbmRl
eCA5OWM1Y2Y4Li5hNzI1MGI5IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21tYy9mc2wtZXNkaGMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL2ZzbC1lc2RoYy50eHQNCkBAIC0yMSw2ICsyMSw3IEBAIFJlcXVpcmVk
IHByb3BlcnRpZXM6DQogCSJmc2wsbHMxMDQzYS1lc2RoYyINCiAJImZzbCxsczEwNDZhLWVzZGhj
Ig0KIAkiZnNsLGxzMjA4MGEtZXNkaGMiDQorCSJmc2wsbHMxMDI4YS1lc2RoYyINCiAgIC0gY2xv
Y2stZnJlcXVlbmN5IDogc3BlY2lmaWVzIGVTREhDIGJhc2UgY2xvY2sgZnJlcXVlbmN5Lg0KIA0K
IE9wdGlvbmFsIHByb3BlcnRpZXM6DQotLSANCjEuNy4xDQoNCg==
