Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1016C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935B420644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bWFvJij0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfEHNxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:53:10 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:37861
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfEHNxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6CQsVhk7mKENS5NeBymmjDOqgS6e1PzopOuWfQN+z0=;
 b=bWFvJij07XUEoyyFlnwBb7K8ifgbW1sT5Q1ru9lwHuUq3nUy48nNQ7QTCbphWZEu8NrOt5sFn490KHJO0mYJwROugU2gA5EyhtR0ENiuW2tAtDrlemtOm2YiroreK0HrHglFUm8uj4deSETYtCbjvi8vXTSOIEXfQcFusfimtU0=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6166.eurprd04.prod.outlook.com (20.179.6.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Wed, 8 May 2019 13:53:06 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 13:53:06 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add dts support for frwy-ls1046a board
Thread-Topic: [PATCH 0/2] Add dts support for frwy-ls1046a board
Thread-Index: AQHVBaVcVxiwNXKHRk6FzKZTFRXjTg==
Date:   Wed, 8 May 2019 13:53:06 +0000
Message-ID: <20190508135501.17578-1-pramod.kumar_1@nxp.com>
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
x-ms-office365-filtering-correlation-id: eff22d21-e4b2-49e2-4638-08d6d3bc7f33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6166;
x-ms-traffictypediagnostic: AM6PR04MB6166:
x-microsoft-antispam-prvs: <AM6PR04MB6166046A09CB6B291C4C7A77F6320@AM6PR04MB6166.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(5660300002)(4744005)(52116002)(99286004)(478600001)(68736007)(1076003)(8936002)(102836004)(6512007)(50226002)(476003)(316002)(81156014)(81166006)(53936002)(73956011)(8676002)(2501003)(36756003)(2616005)(486006)(26005)(6436002)(66946007)(64756008)(66446008)(6486002)(66476007)(66556008)(110136005)(14454004)(86362001)(4326008)(186003)(66066001)(54906003)(25786009)(2201001)(386003)(6506007)(2906002)(7736002)(305945005)(256004)(71200400001)(71190400001)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6166;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WDeIZ4GaOHJw9pL+PBWBtXJAonycMC1l51OLmS5GvKEd9S6JsogtVJfJMakTpnnym86lUDBW2oPhEz3fL3fn2ep318PQCnIoyoDlq4ueRtVSCJIXbw5j3p2f7ovYFjDR0w0CGaGw1AiYr5veddICh+36YJb7ccaCNpLBOqeNZd12R8g1tOzfYAey4bBktrMhPF6lcVnDOIF8t3R+b4aF63YHCqJOpnPu+dmrLidyEDdn7bRm3WXd40sTMp4nTJULuWZe3Ob0orxIZYraxiq9Dgs1Am3DGYE1UFPx7GgmzKThsDq+QjWkG7M+BGJA5Ly/ZM3Bm5sISIy2B8c/6HOE2sjvfNGHJWWzja5aMmtL4RbTKpqppHp/wkNEanz07j3nHzNaGhknQZNqZJ8V2z/+GL35AGaMdU3ByWAhJ6Oer/8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff22d21-e4b2-49e2-4638-08d6d3bc7f33
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 13:53:06.4045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGR0cyBzdXBwb3J0IGZvciBmcnd5LWxzMTA0NmEgd2hpY2ggaXMgYmFzZWQgb24gbHMxMDQ2
YSBzb2MgDQoNCg0KUHJhbW9kIEt1bWFyICgyKToNCiAgZHQtYmluZGluZ3M6IGFybTogZnNsOiBB
ZGQgZGV2aWNlIHRyZWUgYmluZGluZyBmb3IgbHMxMDQ2YS1mcnd5IGJvYXJkDQogIGFkZCBkdHMg
ZmlsZSB0byBlbmFibGUgc3VwcG9ydCBmb3IgbHMxMDQ2YWZyd3kgYm9hcmQuDQoNCiAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgICAgICAgICAgfCAgIDEgKw0KIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlICAgICAgICB8ICAgMSArDQogLi4uL2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1mcnd5LmR0cyAgIHwgMTU2ICsrKysrKysrKysrKysr
KysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTU4IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEtZnJ3eS5kdHMN
Cg0KLS0gDQoyLjE3LjENCg0K
