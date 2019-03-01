Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D19220842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="COC8SxO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbfCABY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:24:27 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:12928
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfCABY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 20:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XleK4LWoef66Vmw/5Ekv96WWCsS9CntFKsF7jB7opMI=;
 b=COC8SxO9F+Q4zEn6flGpfYIDYR1YeaVcGUOrEch6/ttSKlWEMNhVY7zTGKsoDkytF5fawz1EIWA1+zWgAW+NAeYPWECecpjx7bBsCaIFmmQ2J2ts5OrU3gCvVZklfWeEP4EP8Yc5uhGVdVmTDkWtL3/TcrDac1SyWWIUYDiow0g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Fri, 1 Mar 2019 01:24:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 01:24:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Topic: [PATCH V4 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Index: AQHUz82AG+ot7CgeSEmqoBD9ub2E8w==
Date:   Fri, 1 Mar 2019 01:24:22 +0000
Message-ID: <1551403185-16314-2-git-send-email-Anson.Huang@nxp.com>
References: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d600cd36-29eb-43a0-7603-08d69de4a24e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3756;23:zdeAYn85o8AZbhQ3AiClo+XFCMAOA22euqyGt?=
 =?iso-8859-1?Q?jD/qwth6v3SfpLiKaEYDnZsFDd89tg/OjUzqDEfmAvS1DqVM5Izpeyp/Ej?=
 =?iso-8859-1?Q?0OIlQPztr3E3xnjSrSTbCBFbfp22J7y1K+i59BDwG/FLj/uuKE5VGNBPpw?=
 =?iso-8859-1?Q?RsBimyv1ZK7hhP3XqSaXw4LChckBCqTWFYsYNYDuGaQHrWq54LemEwHbnO?=
 =?iso-8859-1?Q?nT8wpLYIz6UclWbqCKdvaWuPKVOye6ESmKUoAifwD34uX3ut/DHRgbkBWU?=
 =?iso-8859-1?Q?xIatX94QUDGYbjQ9lDKXRmfzRo9uIlBZEz2RpvWglt43Km1oDUje+DZh8B?=
 =?iso-8859-1?Q?/Z70O/J5ramIMmF69svZTrWgreil+FDIAiwKvIhdsT9qM6fQaPvoNFaacV?=
 =?iso-8859-1?Q?nsNTD/njhxghnHL3nd3shVjbNyLwO7OR4aP+I3McLfvESOJOI3W2UdmpfJ?=
 =?iso-8859-1?Q?zSRPv0Qjsp362d/P1ZYX+PEy47xYiUzlSVSi88p8aqVy3L1Icwi/h2GnfC?=
 =?iso-8859-1?Q?LdDRUNGthVdXDAVomSIOdnh5cklE8/Az6IaGdFLNCUkuCp2auYb2xrE1O+?=
 =?iso-8859-1?Q?8FwmPTkknBg5gs2TykMht6B3Si6lMkDEyj+kxrOVaTQygj/CvWzikCN2Pn?=
 =?iso-8859-1?Q?YH9Cn/Qs7gnEyPedZpEQnI35QYnWwCDb9eBZFP2KaE2ZjQjHwVSSK9WBW3?=
 =?iso-8859-1?Q?6IMme5RhLz+0dEybvFoi1LJjQlLWjKt2My1eyeacsKZOUJWK1/1wwKEr+K?=
 =?iso-8859-1?Q?BbuTvv3LmuJklp2rS4GWUWuWEVI8e4/+9cIJc0MdyvDrrecpgsVI7veJvs?=
 =?iso-8859-1?Q?29G/ZshvwGoIs/6N2SS1pEPDlwkIjyDO7BEM3Nmxaf/eWQ/welTrUOpC+h?=
 =?iso-8859-1?Q?+vNfbx0RD1lSQ+2c5xBne3FTswFYa6Gs0VAr4m+PYiFNCJA4ZSGfjxi08Z?=
 =?iso-8859-1?Q?HzRSpe9mVGCogxXDkmmRSPuPSbq/pL0TgJCpwuZPdQ4P7DkeTX2wJv6gEx?=
 =?iso-8859-1?Q?fvcl/c8yLwYV7IZz1PeRdTK6x4JfYlqGk2i6QZuNFgAZ/ConPt8BK9XYbV?=
 =?iso-8859-1?Q?t9DBC39vABg49+u0YmLHxy3rQclo2EVHIYOs6IrWPIzfKvqdjl2u1ik6sw?=
 =?iso-8859-1?Q?33DA3YoLsCD4huCIT/cf14pZX0fSK3414bhkKA1X33f73Q3GbvHENJZgey?=
 =?iso-8859-1?Q?pMxabAAp1mY9y3fworCke5OpQCSo3W3DC708wFvgUwbnlnhw5psyyp5McU?=
 =?iso-8859-1?Q?0AaXQac2luh3yZPjdVkXjzdNiZc7D88O4eji48KAqxWb1h3AlmPUftz+xo?=
 =?iso-8859-1?Q?fLD0=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3756A1B67AB87E2DA2058F7BF5760@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39840400004)(346002)(199004)(189003)(5660300002)(76176011)(53936002)(478600001)(305945005)(52116002)(6512007)(7736002)(256004)(446003)(14454004)(14444005)(6506007)(386003)(2906002)(476003)(486006)(4326008)(2616005)(25786009)(8936002)(81166006)(81156014)(11346002)(50226002)(8676002)(99286004)(68736007)(2201001)(110136005)(2501003)(316002)(6436002)(102836004)(66066001)(86362001)(97736004)(3846002)(6116002)(6486002)(186003)(26005)(105586002)(36756003)(4744005)(106356001)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L7GKOK07e/U5qdBD5zE4MOUi+aPxOKRj+qFvwcrfSHqYUAvpV6dW1PvYUXu3k/IWRw1Rf7jTdISFHAIMivVQT4FpXxAvTY69uThQ2qgK+uzgqppR4xvzb62u0WhT8vzkJJAPguuXL/SPbXaQdyTEUEnfl3rBy6LkoBss6bllzQUK2D3KBxxDNZwmX25Zw60S/QsRUgXdy5jtlFivvq311PPSTt3h5ndHzawrvoF2/a9IN0nE58PKvV4UVv7cxcnRaGVoTrubm0x1b1hggN4a88k8ivmHaOkoXjWPSFPHMHOKe9mNaf5Pe2KVzcfaQogkbMvXcnXCA5Xco6auE6v1KlOcxQiKjMKFREx8WRWDzlT0uA/OtLMSlPIzJ8ef+KkmRdaL2XGm+BwrNKckwFsYaaoQKTy9GXFtufja4l08z/s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d600cd36-29eb-43a0-7603-08d69de4a24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 01:24:22.4962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has a MMDC module to control DDR, it reuses
i.MX6Q's MMDC module, add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
No change since V3.
---
 arch/arm/boot/dts/imx7ulp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index fca6e50..eb349fd 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -286,6 +286,12 @@
 			status =3D "disabled";
 		};
=20
+		memory-controller@40ab0000 {
+			compatible =3D "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
+			reg =3D <0x40ab0000 0x1000>;
+			clocks =3D <&pcc3 IMX7ULP_CLK_MMDC>;
+		};
+
 		iomuxc1: pinctrl@40ac0000 {
 			compatible =3D "fsl,imx7ulp-iomuxc1";
 			reg =3D <0x40ac0000 0x1000>;
--=20
2.7.4

