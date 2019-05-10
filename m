Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFEBC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF2D2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SopPsFDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfEJNAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:00:18 -0400
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:23298
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbfEJNAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3nAIffZWJtiZei8PXmyXUVi/mz6wf4IYQ+H6UL+HKg=;
 b=SopPsFDNh0ykzSFIGxYVysXBApPwpaAvxTfZnOL3+n+q3+2B1od9PLYuNJ8wiYSXfbHAyuocgfZOtq4HrfaWnYqnFPu3uB3SQjVDValkJIJi/E5mrEKGt5RFIs3hqesrPhLKdW0HBq+K5E1beinUnBztT5y1umHBk/aHdMP0F94=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6182.eurprd04.prod.outlook.com (20.179.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 13:00:13 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda%6]) with mapi id 15.20.1856.016; Fri, 10 May 2019
 13:00:13 +0000
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
Subject: [PATCH v2 0/3] arm64: dts: nxp: add ls1046a frwy board support
Thread-Topic: [PATCH v2 0/3] arm64: dts: nxp: add ls1046a frwy board support
Thread-Index: AQHVBzBOJHZGTIZmHEO+Z8xAU6v8Bg==
Date:   Fri, 10 May 2019 13:00:13 +0000
Message-ID: <20190510130207.14330-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bfb1743-11e8-4a16-2e77-08d6d54770aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6182;
x-ms-traffictypediagnostic: AM6PR04MB6182:
x-microsoft-antispam-prvs: <AM6PR04MB61827E85A7D23DA8EC410457F60C0@AM6PR04MB6182.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(50226002)(2906002)(6436002)(99286004)(6486002)(186003)(4744005)(110136005)(53936002)(6116002)(52116002)(3846002)(8936002)(4326008)(25786009)(26005)(8676002)(81156014)(81166006)(54906003)(2501003)(66066001)(6636002)(14454004)(6512007)(386003)(102836004)(6506007)(36756003)(478600001)(305945005)(71190400001)(1076003)(486006)(256004)(476003)(2616005)(86362001)(71200400001)(66946007)(66476007)(66556008)(66446008)(316002)(2201001)(7736002)(73956011)(68736007)(64756008)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6182;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rrJhgjucL9Yj4f9TagoUidfXepBEAAA3ddCHQcfPyRS+1Yor1D1YFKhWdugpZ05b/8heo9ithF4LFBw0CtrXZ+MC4jV1AyV0G+lcrN065h8EWfUBb3oUnqVbFaJrGOmdljfCFF2+lTIxFx1mt4a0RlGGRhPGsnG4s/n16JF/Is2wg6Lo7GwdynNb44GUT4Bq8IS6T/QnTILnEPUsNXXzRu1dtJ1KQYn8VlgK2nS9vm0ydIvEbMmm3xLMKaPEhm3frHY88kanMrFYXWBkAkJzV5P+34bbjmRSzqrDMCIzwrVgKsHsQ/PMxyzWRhINd+ELcmdLqHe1WLfVhZUZsyt7AvGr6/9DbUFi7v6VGXmUZOq6molHkNoLNV19JOTWHy+QoyEguGs/PceneI91hP/IgMhGDu2Nw5lMVLfiZ6yLI+M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfb1743-11e8-4a16-2e77-08d6d54770aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 13:00:13.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBmb3IgdjI6DQotIE1vZGlmaWVkIGNvbWl0IG1lc3NhZ2UNCi0gQWRkIGR0cyBlbnRy
eSBmb3IgcXNwaSBub3IgZmxhc2gNCg0KQ2hhbmdlcyBmb3IgdjE6DQotIEFkZCBkdHMgc3VwcG9y
dCBmb3IgbHMxMDQ2YSBmcnd5IGJvYXJkLg0KLSBBZGQgImZzbCxsczEwNDZhLWZyd3kiIGJpbmRp
bmdzIGZvciBsczEwNDZhZnJ3eSBib2FyZCBiYXNlZCBvbiBsczEwNDZhIFNvQw0KDQpQcmFtb2Qg
S3VtYXIgKDMpOg0KICBkdC1iaW5kaW5nczogYXJtOiBueHA6IEFkZCBkZXZpY2UgdHJlZSBiaW5k
aW5nIGZvciBsczEwNDZhLWZyd3kgYm9hcmQNCiAgYXJtNjQ6IGR0czogbnhwOiBhZGQgbHMxMDQ2
YS1mcnd5IGJvYXJkIHN1cHBvcnQNCiAgYXJtNjQ6IGR0czogbnhwOiBmcnd5LWxzMTA0NmE6IGFk
ZCBzdXBwb3J0IGZvciBtaWNyb24gbm9yIGZsYXNoDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vZnNsLnlhbWwgICAgICAgICAgfCAgIDEgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL01ha2VmaWxlICAgICAgICB8ICAgMSArDQogLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHMxMDQ2YS1mcnd5LmR0cyAgIHwgMTczICsrKysrKysrKysrKysrKysrKw0KIDMgZmlsZXMg
Y2hhbmdlZCwgMTc1IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEtZnJ3eS5kdHMNCg0KLS0gDQoyLjE3LjEN
Cg0K
