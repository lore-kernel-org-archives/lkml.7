Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB94C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958CC218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vMCee5wE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfDXD1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:27:20 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:13991
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfDXD1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnjzUFHjbUoI6ILyCuJde3gVM6l4ViOIPB+hjBmccC8=;
 b=vMCee5wEoSFbV/ISx0RAep+VmdctjICusRBXkBhEkpV8R21duwGYZ18bjNcI0A/jqIrDFWdimMzE/8IEeEltRn075BBr4nNmiMMsgZ8PF7qZbBaUViRmyUHMwnFwJTZYdKpnS/Aic0vGEIZsAFkxXmh6fWOVq3gpcHTX4s2BEHc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3817.eurprd04.prod.outlook.com (52.134.73.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 03:27:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 03:27:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable CONFIG_THERMAL_STATISTICS
Thread-Topic: [PATCH] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Thread-Index: AQHU+k2bJJ9MRtHiIEOyvuqXcpXxpQ==
Date:   Wed, 24 Apr 2019 03:27:13 +0000
Message-ID: <1556076113-4593-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e31e442a-e8b6-4bfa-7e1b-08d6c864be27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3817;
x-ms-traffictypediagnostic: DB3PR0402MB3817:
x-microsoft-antispam-prvs: <DB3PR0402MB381723A310EBE2FEC0B49C1FF53C0@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(136003)(376002)(366004)(199004)(189003)(68736007)(66066001)(6512007)(386003)(8676002)(26005)(4744005)(102836004)(3846002)(6116002)(256004)(478600001)(14454004)(53936002)(2501003)(25786009)(186003)(6506007)(4326008)(52116002)(5660300002)(2616005)(305945005)(36756003)(86362001)(486006)(316002)(476003)(66556008)(50226002)(2906002)(73956011)(99286004)(7416002)(6436002)(6486002)(2201001)(66946007)(8936002)(7736002)(64756008)(66446008)(71190400001)(97736004)(66476007)(81166006)(81156014)(110136005)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3817;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oD5t7m3QoMPJlb6ng2GH0ks+gMZL/Ki2zaiWk7Ln3dP8nh5O4DzMMJlbhkB/KF2PlBAO3M/s1csz2XhqyqxS3Nc8W+vuG8Qf7xKhAYHOhg7W428L04D3n7wTswIC4XpWJjPMeqIVTgvPBFgpL9abS1iOoEyf46jVItpSf35p5rB7Imbwc7hCH+e8OPiIwSfRQ5laR8YDtTOmfhiI2oM7zthK6qMVWqCQVMHBGh6snq8ujqegBcwDUxPpqiFzMxcnievAT22VpXgv+Q4Q5a0uW+ZSD++sZWI6ZbPhyIkmwXq5RivULL8E/zUfu4rgTKy7GbxbpgXYolPdRnbCuDddbl3BlMhgcoW3dsb2Iug58PyKG2Af/mEUmmTB4WiCOnzKx8jP4sWIpwjfH9croRI5CK3iu08rxIOFdKaiTZXQTTw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31e442a-e8b6-4bfa-7e1b-08d6c864be27
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 03:27:13.7882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW5hYmxlIENPTkZJR19USEVSTUFMX1NUQVRJU1RJQ1MgdG8gZXh0ZW5kIHRoZSBzeXNmcyBpbnRl
cmZhY2UNCmZvciB0aGVybWFsIGNvb2xpbmcgZGV2aWNlcyBhbmQgZXhwb3NlIHNvbWUgdXNlZnVs
IHN0YXRpc3RpY3MuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0Bu
eHAuY29tPg0KLS0tDQogYXJjaC9hcm0vY29uZmlncy9pbXhfdjZfdjdfZGVmY29uZmlnIHwgMSAr
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9jb25maWdzL2lteF92Nl92N19kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL2lteF92Nl92
N19kZWZjb25maWcNCmluZGV4IDc2NTAwM2EuLmVhMzg3Y2IgMTAwNjQ0DQotLS0gYS9hcmNoL2Fy
bS9jb25maWdzL2lteF92Nl92N19kZWZjb25maWcNCisrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvaW14
X3Y2X3Y3X2RlZmNvbmZpZw0KQEAgLTIyNSw2ICsyMjUsNyBAQCBDT05GSUdfUE9XRVJfU1VQUExZ
PXkNCiBDT05GSUdfU0VOU09SU19NQzEzNzgzX0FEQz15DQogQ09ORklHX1NFTlNPUlNfR1BJT19G
QU49eQ0KIENPTkZJR19TRU5TT1JTX0lJT19IV01PTj15DQorQ09ORklHX1RIRVJNQUxfU1RBVElT
VElDUz15DQogQ09ORklHX1RIRVJNQUxfV1JJVEFCTEVfVFJJUFM9eQ0KIENPTkZJR19DUFVfVEhF
Uk1BTD15DQogQ09ORklHX0lNWF9USEVSTUFMPXkNCi0tIA0KMi43LjQNCg0K
