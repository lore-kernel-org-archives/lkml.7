Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE97C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE7E20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gQLhIMoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfE0McH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:32:07 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:58963
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbfE0McH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wRumjJQB3ouNn4eLIeBn/rikleqowhhNTpCqONcaoQ=;
 b=gQLhIMoaNsCrGhAMz1ipvaLX4TnMfMpHw7sVKDavEiirOc2A9NYIYWdLwxrviSu6pfMRp26+abKg05RcwZSeZz1MF3rihUvF+uKChG+I7snW5TQgY+FXaGPLkgfg9oPzlJbgq6IA0rP1b/Z+s51MmqlRgpRGsERM6IuS885TBBI=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB5094.eurprd04.prod.outlook.com (20.177.34.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Mon, 27 May 2019 12:32:03 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21%4]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 12:32:03 +0000
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
Thread-Index: AQHVFIgwH93HgR+8M0C0MblbWTpfWA==
Date:   Mon, 27 May 2019 12:32:03 +0000
Message-ID: <20190527123404.30858-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: PN1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::17) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51a2dcde-565f-4ebc-19dc-08d6e29f5281
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5094;
x-ms-traffictypediagnostic: AM6PR04MB5094:
x-microsoft-antispam-prvs: <AM6PR04MB5094520E9E4287F8FA2F56E8F61D0@AM6PR04MB5094.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(189003)(99286004)(25786009)(1076003)(478600001)(256004)(7736002)(6116002)(316002)(6486002)(36756003)(71200400001)(81156014)(81166006)(71190400001)(50226002)(5660300002)(66066001)(6436002)(2501003)(305945005)(66476007)(3846002)(14454004)(4744005)(8676002)(6636002)(8936002)(486006)(102836004)(386003)(6506007)(6512007)(4326008)(2616005)(476003)(68736007)(2201001)(2906002)(86362001)(73956011)(66946007)(53936002)(66556008)(64756008)(66446008)(110136005)(52116002)(186003)(4743002)(26005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5094;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0iEigfbRsVQR+AIdkdsULw/O/TKTKbHY5vksGNH2/OtOfeVDYHl3nKcFTQwPSEk63K+4jqC80Pdf2VrFSVH3B5b4iti47vZCOmnXl7oxuYqLoLpaI8pq8LuZ8xEkfAJy3QgJoxIOXkAiu0ZkgCo888KYaF0OH2T+1lRW9Iz9yhChXdgtkYS8wIPNFWwD4Yk8UlMySo2AHJ41Cd7jJwtJtaXgeEV50EglehDSar/lR6X6hNnk9TKLKBYf385GU2FyqI1yEad45aM4rUO7NniokqHwV7MtkhMlHfvlXSA6p9hjOaArkw9+xlJx6ckg9rfoj1Udxf3XX/5Fv0LUHJY5+jiDMGeCK1tM1P13oNHv9sCyJ1ORSwXWDYucFtzKnDoex574eKRfMX//ZhYZ7LfygcLZWZK70HLy2afvfSy5tw4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a2dcde-565f-4ebc-19dc-08d6e29f5281
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 12:32:03.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5094
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
