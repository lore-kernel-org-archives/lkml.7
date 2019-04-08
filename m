Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B80C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4481F2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WAzLaP+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfDHSxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:53:08 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:64213
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDHSxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlRaAUjKc5PuQdrNHeOQB/IOw74qYP0biDTW8yMuRGc=;
 b=WAzLaP+fqAUM7JwizpTp39le0pS+FUpVeMaC05SaFIcguKkpAsHaNWYGKGQefWzHBXR6oghsJ+eJKbQ5UOSfNBtt8IC3W6/OhMJUe2I8c52W078jER6073l9TpTAQ12z+ObVDufKsn1B4IPSob7qICa4y6jzHO7abzxga+WU4DQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6530.eurprd04.prod.outlook.com (20.179.254.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 18:53:03 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 18:53:03 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Olof Johansson <olof@lixom.net>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND] arm64: defconfig: Enable RTC_DRV_SNVS
Thread-Topic: [RESEND] arm64: defconfig: Enable RTC_DRV_SNVS
Thread-Index: AQHU7jxLq+OSUQszvUq2rZ157qMiNg==
Date:   Mon, 8 Apr 2019 18:53:03 +0000
Message-ID: <1554749572-5090-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0043.eurprd05.prod.outlook.com
 (2603:10a6:800:60::29) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f9499ae-3282-435a-485f-08d6bc536dab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6530;
x-ms-traffictypediagnostic: AM0PR04MB6530:
x-microsoft-antispam-prvs: <AM0PR04MB65308DA9D155C9EEDD1E31FDF62C0@AM0PR04MB6530.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(8936002)(186003)(6116002)(305945005)(36756003)(102836004)(44832011)(110136005)(6512007)(53936002)(386003)(52116002)(6506007)(4326008)(256004)(81166006)(3846002)(66066001)(4744005)(26005)(486006)(7736002)(316002)(81156014)(6436002)(54906003)(2501003)(106356001)(50226002)(14454004)(71190400001)(478600001)(71200400001)(99286004)(2616005)(476003)(6486002)(8676002)(105586002)(68736007)(2906002)(86362001)(5660300002)(25786009)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6530;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SYm9F2wRZSPhwjRwRcEwhWJOOz/A/g1C41X1G0kit3QQQYdfZR+WmwxiDYdDCUbz8jIXD/nAyguyuZEVMr0xzW738KlLQeFhEq+asrfXqRFP+YU8rsG5g+LCXqmkzYoPu08C7eSuqDdft4Un+c5m16xfc6Um1JHtHbiwgJmt6QRb61UFbcekI7i6JDriJ1hySnAiJ1dtYjUgtrfyPPVpxQW/NXlgzAe/SAsu0iVE4rcX9iAZQvorOv5rpCkoZINlx+vMj+INopSo2vCPPiMZxhgxLXTumGaxK1rjuNx8n1GY6BZn+FL8GzLbpMRF30cViy77To5zl4XB9d2FtlNmW6Zw0JyG8TTI9UQx84vFj01d+8C1qmgiKfR7Vr67BRxizWWnBhK3YYdp7XFthghHBGehZc0AjS3qCvaEnq+cvJ4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9499ae-3282-435a-485f-08d6bc536dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 18:53:03.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ needs it for RTC support.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9e313f5..81739d6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -619,6 +619,7 @@ CONFIG_RTC_DRV_PL031=3Dy
 CONFIG_RTC_DRV_SUN6I=3Dy
 CONFIG_RTC_DRV_ARMADA38X=3Dy
 CONFIG_RTC_DRV_TEGRA=3Dy
+CONFIG_RTC_DRV_SNVS=3Dy
 CONFIG_RTC_DRV_IMX_SC=3Dm
 CONFIG_RTC_DRV_XGENE=3Dy
 CONFIG_DMADEVICES=3Dy
--=20
2.7.4

