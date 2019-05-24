Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A6EC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C63217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XuoSaaGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfEXAkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:40:42 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:16571
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731488AbfEXAkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxgKO0W/BktaJK0MWO7PHVKXRW1MuT6dYVnler6z2Bg=;
 b=XuoSaaGND4IKufrscGDMYCVNLtruFSTCTLMbM21EvHE2cOKxpkDlTS8rZ2Z8ksgcrBMJHqM98Lr9hp3MXI/JR7mUpfqFsOr/vrULc9yz+RVU1/f3mACFTXMfaaRtgK52eR59a+OcsF3cQJtEgYZebIqnTBfJmv59kdhXHGc8x/g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.19; Fri, 24 May 2019 00:40:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1922.017; Fri, 24 May 2019
 00:40:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND] arm64: defconfig: Enable CONFIG_QORIQ_THERMAL
Thread-Topic: [PATCH RESEND] arm64: defconfig: Enable CONFIG_QORIQ_THERMAL
Thread-Index: AQHVEclO/85kyS08dEKAaYgO0QP/vQ==
Date:   Fri, 24 May 2019 00:40:37 +0000
Message-ID: <1558658123-8797-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 725ee209-bad8-49c6-d831-08d6dfe0705d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB3850E4496B10B07A07CF84FAF5020@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(2201001)(8936002)(478600001)(6486002)(81166006)(81156014)(86362001)(6116002)(8676002)(3846002)(6436002)(2906002)(68736007)(7416002)(316002)(476003)(50226002)(2616005)(486006)(6512007)(66066001)(26005)(53936002)(110136005)(25786009)(99286004)(186003)(4326008)(71200400001)(71190400001)(102836004)(4744005)(5660300002)(386003)(6506007)(73956011)(66476007)(66556008)(66446008)(64756008)(66946007)(256004)(52116002)(7736002)(305945005)(36756003)(2501003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T8xLOrR0DmBkb6sVJ6DLoIUI4wglTn7AgddpovLrqq3rPDGs+VXQbZkb2GHKNnr2nEfxK4+eogLwYq1sx4QmDOeHq9GgOAokcd5bt2MyHqZOclvbYEEwxAWKphfpXG+xoWYBcFVnfGlZYrRV5JaF6M3osAHBQqlvCV8ORF6iZM1g8jgOyQtAAmuTPHIlScR5dCBcLdA3wfCn66cZ0Xe2DVJ5KddSZrHXJUvkkKRV47uPl7kboS36SS9XexzIssef3+XPruL1qKDIvfK/WcDxlf8ru7dg+bdTIIsvOIU8RXBBG3o8IomYW3lZ8jyuOqEbxp8Ga3aPuI+QhdGZY1bXB3KuFh3DImMjR8s/JZi4ffQwOprdreU+QHrIIC3yE5OEPDPXi0ztGK+Zo+ZVaw+xftekthvQhvLbzN/gjMNmzdQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A536D3C75A2CC448A45555FC24F891F0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725ee209-bad8-49c6-d831-08d6dfe0705d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 00:40:38.0604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ needs CONFIG_QORIQ_THERMAL for thermal support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f0bad30..c91642d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -420,6 +420,7 @@ CONFIG_SENSORS_INA2XX=3Dm
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_THERMAL_EMULATION=3Dy
+CONFIG_QORIQ_THERMAL=3Dm
 CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_RCAR_GEN3_THERMAL=3Dy
--=20
2.7.4

