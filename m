Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3608C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 05:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD965204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 05:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jApky+rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEEF53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 01:57:29 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:44627
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbfEEF52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 01:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY3Pp4s3UvCS+IiyOJ2yUG7o2JQlVpriz9QewseXjgU=;
 b=jApky+rxLVihSUXi6FaVadQ8whn8o/pjV7REhUcsZuvXf8/UA2wKL8VtREhlooYYIkrNQsnoBzlXNN48iKBnrvezD5sd1HL2JKIUieSfSqQS3UqRooBemneUwWHKpGheKksJBLETRIOcFytFpJPn0NjRzkCCGoEZvcDopXRKWsQ=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB6142.eurprd04.prod.outlook.com (20.179.27.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 05:57:24 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 05:57:24 +0000
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
Subject: [PATCH v2] dt-bindings: mmc: add DT bindings for ls1028a eSDHC host
 controller
Thread-Topic: [PATCH v2] dt-bindings: mmc: add DT bindings for ls1028a eSDHC
 host controller
Thread-Index: AQHVAwdpp6V9RlifYUCEEBqdXkT1GQ==
Date:   Sun, 5 May 2019 05:57:24 +0000
Message-ID: <20190505055858.37509-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79a1801b-b755-482e-b37f-08d6d11e8b48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6142;
x-ms-traffictypediagnostic: VI1PR04MB6142:
x-microsoft-antispam-prvs: <VI1PR04MB6142A6845F0EDFE86FACBFD5E9370@VI1PR04MB6142.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:321;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(366004)(346002)(189003)(199004)(6506007)(8936002)(36756003)(6116002)(50226002)(26005)(68736007)(3846002)(66946007)(99286004)(7736002)(2906002)(5660300002)(52116002)(6486002)(186003)(486006)(44832011)(2616005)(53936002)(6436002)(2501003)(305945005)(102836004)(476003)(478600001)(14444005)(8676002)(110136005)(6512007)(316002)(71200400001)(71190400001)(66066001)(73956011)(66556008)(66446008)(64756008)(66476007)(386003)(2201001)(81156014)(81166006)(14454004)(54906003)(1076003)(4744005)(25786009)(256004)(86362001)(6636002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6142;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8eYOzElD8MiOakdUlGdKrdubrEXSoV5vFYqhljRBR+ektJOI7ivkjjLjbRHq/ChUNtB8uYmpZoxUPP48L7OkZTfJ1jYO0r+Qo8/7joheJvN73GvBK9sByRDFAtikqJGSL4G21ACe1hBL4R2t6sGpgrG0F0484iee7JX9J387aMcjm0trdNp0ZrX/5Z+eem16xogTgcSWNT0EjR7MIGtwC3zi9iK5HvoRjlk/o4Q8ysP+T8DTM4qmda15gAldp8+bJmdz0KuWg1milBEF1X3xrizuKOFbejGFaCQaaxK3LINsNNyUkkRHYs9vROulIiwoL84JYhgOV6XW7e0ufB1S+ix9pdGWA+JZKGDbLgr5UCaN6DI+HrxekdE/LzUtTmpvpJ9dEtAKPn0qsz448vHXj9pjE6FPcD/XZO2MDvrO58M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a1801b-b755-482e-b37f-08d6d11e8b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 05:57:24.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCg0KQWRkICJmc2wsbHMxMDI4YS1l
c2RoYyIgYmluZGluZ3MgZm9yIGxzMTAyOGEgZVNESEMgaG9zdCBjb250cm9sbGVyDQoNClNpZ25l
ZC1vZmYtYnk6IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQotLS0NCkNoYW5nZSBpbiB2
MjoNCgkJYXMgYWxwaGFiZXRpY2FsIG9yZGVyIHRvIHVwZGF0ZSBkdC1iaW5kaW5ncw0KCQl1cGRh
dGUgdGhlIGNvbW1pdCBpbmZvcm1hdGlvbi4NCg0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tbWMvZnNsLWVzZGhjLnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21tYy9mc2wtZXNkaGMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21t
Yy9mc2wtZXNkaGMudHh0DQppbmRleCA5OWM1Y2Y4NTA3ZTguLmVkYjhjYWRiOTU0MSAxMDA2NDQN
Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNsLWVzZGhjLnR4
dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtZXNkaGMu
dHh0DQpAQCAtMTcsNiArMTcsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIAkiZnNsLHQ0MjQw
LWVzZGhjIg0KICAgICBQb3NzaWJsZSBjb21wYXRpYmxlcyBmb3IgQVJNOg0KIAkiZnNsLGxzMTAx
MmEtZXNkaGMiDQorCSJmc2wsbHMxMDI4YS1lc2RoYyINCiAJImZzbCxsczEwODhhLWVzZGhjIg0K
IAkiZnNsLGxzMTA0M2EtZXNkaGMiDQogCSJmc2wsbHMxMDQ2YS1lc2RoYyINCi0tIA0KMi4xNy4x
DQoNCg==
