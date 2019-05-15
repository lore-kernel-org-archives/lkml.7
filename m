Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8BC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD13B20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q6BAxxfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEOIcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:32:25 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:45955
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfEOIcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrCjeTDamcaoaTq2VUYAyidZ2kOWwo9zMS8K20Z+yls=;
 b=Q6BAxxfUweDsAcRiZqxT2vFgS1SybJD7DhFAg+gE9gSoHqpW0EjWnw9HBHkZc0U3xZE7XvKPOWu4H4goTbjLl6llYnuXvzKzP2b+qmUZLWux60jRmFXbkS8APqfkysouQA7mpQbSi8Xqtkxzfumqfn4dhDip+FRY1YiZ7/RiuCw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 08:32:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 08:32:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Topic: [PATCH V2 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Index: AQHVCvi1eA/hofdk10abC8XGsCMMkw==
Date:   Wed, 15 May 2019 08:32:19 +0000
Message-ID: <1557908823-11349-2-git-send-email-Anson.Huang@nxp.com>
References: <1557908823-11349-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557908823-11349-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b267a1c7-5e24-4716-b3a4-08d6d90fd7e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-microsoft-antispam-prvs: <DB3PR0402MB3897B40B00A8244B942E5C3BF5090@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(256004)(486006)(6486002)(2616005)(476003)(2501003)(11346002)(6512007)(446003)(3846002)(66446008)(316002)(66476007)(14454004)(73956011)(53936002)(66946007)(7416002)(25786009)(66556008)(64756008)(305945005)(7736002)(186003)(6116002)(6436002)(68736007)(66066001)(81156014)(71190400001)(8936002)(26005)(110136005)(478600001)(102836004)(52116002)(36756003)(8676002)(4744005)(71200400001)(2201001)(4326008)(50226002)(2906002)(5660300002)(386003)(86362001)(6506007)(76176011)(81166006)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cfE+xLdX3XqlzbrywkzbxgJALiWeoxqGq7klCpS5MS45L3C87ZvS7pomluDbsZQlCnPvFMOwZAY7ZZ3BTHn5NBMjzuEC1es7nwkivUGSIOHTHJwCc2O3hPCXgAqPYrBjmhvzzXJqe1OiEd9zW7QCm6jrMo/IPcSR2+6yJ4oAh1lnaDqv4ZjW4c31ktOrx4+jPleNTaF6oT7X80QHgF+FynsuV6KI+ZAgsEww46FsVCe0EO3Ad+w+3GWsjBxr41dnKg9v1z8fTpaoY9XWnOeMOdHbsYdlt/+iRjjj4/6bE7w7v0+ctDZ6lIC+8+6GvR5GZOFvm6o8loqBOIVv/eunCdcKJBzpdThbjFegSExbrFQxFIJMYz6UD5E5Mb8DK2TVJeRJh1Cu1l77vvV11TjOUOXQ2yI9zXmTw10Pag1POpw=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D5835D23D9D92147B90F99F527FB66A8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b267a1c7-5e24-4716-b3a4-08d6d90fd7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 08:32:19.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch selects CONFIG_IMX_SCU_SOC by default to support
i.MX system controller unit SoC info driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8871cf7..d3a4508 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -691,6 +691,7 @@ CONFIG_RPMSG_QCOM_GLINK_RPM=3Dy
 CONFIG_RPMSG_QCOM_GLINK_SMEM=3Dm
 CONFIG_RPMSG_QCOM_SMD=3Dy
 CONFIG_RASPBERRYPI_POWER=3Dy
+CONFIG_IMX_SCU_SOC=3Dy
 CONFIG_QCOM_COMMAND_DB=3Dy
 CONFIG_QCOM_GENI_SE=3Dy
 CONFIG_QCOM_GLINK_SSR=3Dm
--=20
2.7.4

