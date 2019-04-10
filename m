Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C9BC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6D22084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wkQMdutD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfDJBsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:48:00 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:20494
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbfDJBr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHXM/R83k+wq3lhzyeJCXnQ7izpcZb/HxQAHqkZf2fc=;
 b=wkQMdutDaA+gINRH8snkk+TIZ7miHL7GvniaGNLZNgaEOffTCKoPtJ+DhGwEKQh6StB8HFnF2m8bONjzexEss9sw8zAQA/hGaYBhvD0wGCkPd567vaLIAO5zT9vezZJELVuWX+AjHhu6igm5F4JEd5jcmz7T7t9ke0uanS8erlw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 01:47:46 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 01:47:46 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V11 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Topic: [PATCH V11 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Index: AQHU7z9l5bXKuL2C6kqrY3TzrVPnWQ==
Date:   Wed, 10 Apr 2019 01:47:45 +0000
Message-ID: <1554860547-18237-4-git-send-email-Anson.Huang@nxp.com>
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82fde7b5-d727-4da1-0afe-08d6bd568750
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
x-microsoft-antispam-prvs: <DB3PR0402MB3721E274BC01AEE25B30EFF2F52E0@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(2201001)(71190400001)(71200400001)(97736004)(105586002)(68736007)(6436002)(14454004)(8676002)(8936002)(478600001)(50226002)(81166006)(81156014)(7736002)(256004)(53936002)(25786009)(6512007)(305945005)(4326008)(6486002)(26005)(7416002)(106356001)(36756003)(66066001)(186003)(3846002)(6116002)(52116002)(316002)(102836004)(4744005)(6506007)(386003)(446003)(486006)(2906002)(76176011)(110136005)(86362001)(2616005)(476003)(2501003)(11346002)(5660300002)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UgeVk4s+SkTUXIttpgzNU6sZgCuEUIQ8LDMHgdrvfQspGJBpqQhT5IeKIHUCQnpiYl58jn5s1/wtIJaBHT5PcUfEqI6TfNhmcBurZJEWVMg87OGelA+elpF/XhPmEWtKit87eGkgJ8uUa3wAOOT+YZjnH3GMtU8SMV60tOmtsCSEWwCAobXnwDY1OIJtRNcj5zMPCRvh9o+spEs/ejKOFWyTa/BThBXbXpW2LYQ4NsbdsjPVODzCgy46Ce73ZZmoq1f39VjN3BxRSoEYKG02x8ZVZwLgZNwU33tFxGO86ZRaGNTAQ9CAWmX3Z1dn4cfBaGKAap8jwIos/3lYYUz7sek3T9KtOWwzAD32Wby7BHi8K1m+QR5iZXv9o72CtFvauw+r06G9Hs7HY7U6UPWqJsppgCDIDas6gLFHW1+/FOU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fde7b5-d727-4da1-0afe-08d6bd568750
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 01:47:45.9664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VsZWN0IENPTkZJR19QV01fSU1YX1RQTSBieSBkZWZhdWx0IHRvIHN1cHBvcnQgaS5NWDdVTFAN
ClRQTSBQV00uDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KLS0tDQpObyBjaGFuZ2VzLg0KLS0tDQogYXJjaC9hcm0vY29uZmlncy9pbXhfdjZfdjdf
ZGVmY29uZmlnIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYg
LS1naXQgYS9hcmNoL2FybS9jb25maWdzL2lteF92Nl92N19kZWZjb25maWcgYi9hcmNoL2FybS9j
b25maWdzL2lteF92Nl92N19kZWZjb25maWcNCmluZGV4IDc2NTAwM2EuLmYzM2EwMzUgMTAwNjQ0
DQotLS0gYS9hcmNoL2FybS9jb25maWdzL2lteF92Nl92N19kZWZjb25maWcNCisrKyBiL2FyY2gv
YXJtL2NvbmZpZ3MvaW14X3Y2X3Y3X2RlZmNvbmZpZw0KQEAgLTQwMSw2ICs0MDEsNyBAQCBDT05G
SUdfTVBMMzExNT15DQogQ09ORklHX1BXTT15DQogQ09ORklHX1BXTV9GU0xfRlRNPXkNCiBDT05G
SUdfUFdNX0lNWDI3PXkNCitDT05GSUdfUFdNX0lNWF9UUE09eQ0KIENPTkZJR19OVk1FTV9JTVhf
T0NPVFA9eQ0KIENPTkZJR19OVk1FTV9WRjYxMF9PQ09UUD15DQogQ09ORklHX1RFRT15DQotLSAN
CjIuNy40DQoNCg==
