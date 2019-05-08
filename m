Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9DEC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB4721019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RbqFnptt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfEHGF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:05:29 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:3088
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfEHGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0Hc6tTNhU2tbeyQ7npKX21/+g0fc8jbGr09+06MYKk=;
 b=RbqFnpttveBArY5h/+CUiaS3kM0aGn0X3U7JY6T91dmEzLVK6kqS+GvDrTtZxc0ONlCpAyUcOE+GMIw0nIUcAYf1u9OFWleCT9OGaek7DXGiDgC1/pw25VRIFbgl/cGvFlTCLBdAYW1CDirBcQK0X9eTIrpyC5P7RnOLW45EBCc=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4141.eurprd04.prod.outlook.com (52.133.14.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 06:04:52 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 06:04:52 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: [PATCH v5 5/5] usb :fsl: Change string format for errata property
Thread-Topic: [PATCH v5 5/5] usb :fsl: Change string format for errata
 property
Thread-Index: AQHVBWPz2g/D/q2EjUyq8am/kxgoRg==
Date:   Wed, 8 May 2019 06:04:52 +0000
Message-ID: <20190508060608.33882-5-yinbo.zhu@nxp.com>
References: <20190508060608.33882-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190508060608.33882-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52e14233-a72d-451b-fa6d-08d6d37b160a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4141;
x-ms-traffictypediagnostic: VI1PR04MB4141:
x-microsoft-antispam-prvs: <VI1PR04MB41416B770B25A03CEAE4F423E9320@VI1PR04MB4141.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(68736007)(446003)(54906003)(2906002)(6116002)(81156014)(11346002)(486006)(476003)(6506007)(2616005)(66066001)(81166006)(8676002)(76176011)(7736002)(305945005)(44832011)(6916009)(36756003)(2171002)(50226002)(53936002)(4326008)(25786009)(86362001)(1076003)(8936002)(186003)(5660300002)(3846002)(52116002)(99286004)(102836004)(316002)(386003)(478600001)(256004)(71190400001)(71200400001)(14454004)(6512007)(6486002)(6436002)(66446008)(73956011)(66946007)(26005)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4141;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rNPYK9UxBdtF7FePgTTMiR2ur3cMV1IpYAdjLANXUIC6z9BNyDFu6kgdAF/lNX/ucUTwgQsMhukC3/NCyHkmD8RT5DWEf0BHYh++bU6hItSfem2Yl6XxYjM2qZnJvbarZki+6HXVJYP++i11AR8o2o466HECKol3SNhw/r8qu7/OStL3CKHzl0FeDNBlW2qU4oSB+baGe2f7jn8GljkDWUkQC3GslvB/iXWlwymFtSgEI3o9TDd7euDkywqJtJQv9+wOT3YxYbB5soZx/s/c6joJd2ERU7MXYGxa0YYQaxe1iqpda2JpA5enfgp5t1pivUd9j6YohwC272A1qjCfDurxouGlYGTFYvjO469Wtqkp5Huq6XifSpMP581PBBtIZYyyQNIPikV7aSMjf/xu4DXkBkmChLC4GhYmUQ7adeo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e14233-a72d-451b-fa6d-08d6d37b160a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 06:04:52.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmlraGlsIEJhZG9sYSA8bmlraGlsLmJhZG9sYUBmcmVlc2NhbGUuY29tPg0KDQpSZW1v
dmUgVVNCIGVycmF0YSBjaGVja2luZyBjb2RlIGZyb20gZHJpdmVyLiBBcHBsaWNhYmlsaXR5IG9m
IGVycmF0dW0NCmlzIHJldHJpZXZlZCBieSByZWFkaW5nIGNvcnJlc3BvbmRpbmcgcHJvcGVydHkg
aW4gZGV2aWNlIHRyZWUuDQpUaGlzIHByb3BlcnR5IGlzIHdyaXR0ZW4gZHVyaW5nIGRldmljZSB0
cmVlIGZpeHVwLg0KDQpTaWduZWQtb2ZmLWJ5OiBSYW1uZWVrIE1laHJlc2ggPHJhbW5lZWsubWVo
cmVzaEBmcmVlc2NhbGUuY29tPg0KU2lnbmVkLW9mZi1ieTogTmlraGlsIEJhZG9sYSA8bmlraGls
LmJhZG9sYUBmcmVlc2NhbGUuY29tPg0KU2lnbmVkLW9mZi1ieTogWWluYm8gWmh1IDx5aW5iby56
aHVAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QvZnNsLW1waC1kci1vZi5jIHwgICAg
NyArKy0tLS0tDQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2ZzbC1tcGgtZHItb2YuYyBiL2Ry
aXZlcnMvdXNiL2hvc3QvZnNsLW1waC1kci1vZi5jDQppbmRleCA3NjJiOTc2Li5hZThmNjBmIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMNCisrKyBiL2RyaXZl
cnMvdXNiL2hvc3QvZnNsLW1waC1kci1vZi5jDQpAQCAtMjI2LDExICsyMjYsOCBAQCBzdGF0aWMg
aW50IGZzbF91c2IyX21waF9kcl9vZl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvZmRl
dikNCiAJCW9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImZzbCx1c2JfZXJyYXR1bS1hMDA1Njk3
Iik7DQogCXBkYXRhLT5oYXNfZnNsX2VycmF0dW1fYTAwNjkxOCA9DQogCQlvZl9wcm9wZXJ0eV9y
ZWFkX2Jvb2wobnAsICJmc2wsdXNiX2VycmF0dW0tYTAwNjkxOCIpOw0KLQ0KLQlpZiAob2ZfZ2V0
X3Byb3BlcnR5KG5wLCAiZnNsLHVzYl9lcnJhdHVtXzE0IiwgTlVMTCkpDQotCQlwZGF0YS0+aGFz
X2ZzbF9lcnJhdHVtXzE0ID0gMTsNCi0JZWxzZQ0KLQkJcGRhdGEtPmhhc19mc2xfZXJyYXR1bV8x
NCA9IDA7DQorCXBkYXRhLT5oYXNfZnNsX2VycmF0dW1fMTQgPQ0KKwkJb2ZfcHJvcGVydHlfcmVh
ZF9ib29sKG5wLCAiZnNsLHVzYl9lcnJhdHVtLTE0Iik7DQogDQogCS8qDQogCSAqIERldGVybWlu
ZSB3aGV0aGVyIHBoeV9jbGtfdmFsaWQgbmVlZHMgdG8gYmUgY2hlY2tlZA0KLS0gDQoxLjcuMQ0K
DQo=
