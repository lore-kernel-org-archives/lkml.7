Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91171C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52070205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p2xcy32Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfCLCY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:24:28 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:15140
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbfCLCYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0aT7loqibI8V0S2yxLe4lEDiz8XJHYFouN3soUSnSs=;
 b=p2xcy32Ykt52d2iiLzNsDYnZk0g47JBjUGq2RuSqYCSX2ii+eh24yctMoPtgLdsdwgzsOO5V8hiZf5BHjYHPfGhqxPC+/xjTXH1IlsRm9shRNsQ1Bq5a3YbSqQ+Hc827zGoHDk9NQKl/vrGOGqWNjNFs4kem/R2dm8AG95P1+EM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 02:24:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 02:24:20 +0000
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
Subject: [PATCH V5 4/4] ARM: dts: imx6qdl: Improve mmdc1 node
Thread-Topic: [PATCH V5 4/4] ARM: dts: imx6qdl: Improve mmdc1 node
Thread-Index: AQHU2HqzU0hM0CqUH0qVFKudOV2WRw==
Date:   Tue, 12 Mar 2019 02:24:20 +0000
Message-ID: <1552357127-1283-4-git-send-email-Anson.Huang@nxp.com>
References: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 123bb68d-da8a-49a6-ab83-08d6a691d545
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:Ov27cU3ZVhTQcBqksaIo5bkptBcpWJNXlb/Ps?=
 =?iso-8859-1?Q?LtgTN7o3Mu5P3GUlEx7zs4s7UFq9WYqI9zAvpsA4CvsRozYfc38gyfehLg?=
 =?iso-8859-1?Q?kagGHu0dbboqR5iuU86u3j8jVJhFmopoNsVE7GEzMXgMInZ4bvA/ICIzx+?=
 =?iso-8859-1?Q?JOD00kpDz5VgaC2zODAmBrvpuXllpujL9Nx+mvUsJ/7AUDCR20jXqdrBby?=
 =?iso-8859-1?Q?7iK3T5c/q9rEDsdPg2zPMhPbq/popngo95RpPj4RrmxIjdpg3VmiWRdXAS?=
 =?iso-8859-1?Q?P9hi+qIBBhfOZ1C2ORpLhjdd6JJy6nDTkVynnVkuu2pEo4L2riHt5VTFL7?=
 =?iso-8859-1?Q?S5SscgWoG83ljDLof2G2B/pXlMS0umXme1WZrmpgAImfMozThI9psYnneD?=
 =?iso-8859-1?Q?ecVNIPzUqxxssvlF+LarRcn/9TvT+iTpVyTK+gk5x8UTGrTmKAMnAVwrlT?=
 =?iso-8859-1?Q?iIUF32YXNHSSeOHHuZaGA1E831G/xmfCbIjyhFZiTEmHL3JiZoWKMZPMk5?=
 =?iso-8859-1?Q?DRVMPciKReL6Q4DntY1Kf/wMpCiabIuRPOKUzaCtKHwBvKPKNdAH8Fe/lV?=
 =?iso-8859-1?Q?1T3rF+pdlkK9Q2h2TPeuIvWDfYiU8dXfckE9Ty1gSHwPwzdfXijmULBghl?=
 =?iso-8859-1?Q?tivyu+rLr7nIZqyUP/VgmdWnPpBMbwzhdKQD1gl+XoEmszDsIMxUpIg3ZY?=
 =?iso-8859-1?Q?WK5U+1xX4A6B1Qz7K85if/6/hnpjcPNG7aGYodx9h7rFRqQipFEWYR5qiF?=
 =?iso-8859-1?Q?1Vw71ibgyBu3GmeKQeR9t8adQIIBERhBcwnrXv03FBAAQvtXuXRGUK9cEg?=
 =?iso-8859-1?Q?TvIfFTbUgBWVFplDOeoVL6GJaKRfbMv/eemJYKhvLZmAAg1uCE0J2Y9dzt?=
 =?iso-8859-1?Q?dQkSpKV68Pe6eGiRFIoHsx7VIJoNNihSnDbAEuN4Cgx3u6R8zVsiItNm7h?=
 =?iso-8859-1?Q?cat3ZgaCvWruLUvynOXwFzN1LbNpGZMmB+fLSmDJEzviHFtV1KMAC7oW05?=
 =?iso-8859-1?Q?L+dHXewv0M/0nDMgJir7UbnaOgtiqc4uO8M8Hm0rtipepLEa3f8LU3gaeH?=
 =?iso-8859-1?Q?H2vVWgm2ZS9td36fM7y2RsncVYEPkMbtLRc4r5hlPrBPQMlvhi5IdF+UW0?=
 =?iso-8859-1?Q?jwPKVhnaLCT0Ha1/LNcoJvajdcFSc6AnMOTlkJ84VEQriSTv2vuGisDDJ2?=
 =?iso-8859-1?Q?z7DeKvHb3F6qkqrWjJYjel+/Tu+MWtJUxIQYZJm6Ymj0AeURkNJf/RxRuv?=
 =?iso-8859-1?Q?dNCuZty89XW8NlyG9PEpZfdavtLHu0t5+o86BBBa+Ki0pyqcvqj2vpnYFF?=
 =?iso-8859-1?Q?8S1H48ffGj0BdQQuCRyFQIhKI?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707145F58D837FC41173DA8F5490@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(2906002)(106356001)(110136005)(316002)(7736002)(486006)(50226002)(476003)(305945005)(6512007)(97736004)(4326008)(6436002)(3846002)(105586002)(25786009)(53936002)(86362001)(6116002)(2201001)(6486002)(14444005)(66066001)(14454004)(478600001)(256004)(71200400001)(4744005)(71190400001)(8936002)(26005)(8676002)(102836004)(36756003)(81156014)(11346002)(81166006)(2501003)(186003)(76176011)(68736007)(2616005)(6506007)(386003)(52116002)(5660300002)(446003)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pt0s+S3vbKt4eXblHgOIYE71vjUmDAjxtpfYVm5Gy8ZobmuOR5/2lzUiwAbdm3Xu1/e0GGhrNA3bKOWYmAlqpYQdD/BB0wZjLxsJ/Jwc2BMnJHruWjN7QhHJjqGCNKUWDdSzLw9y3P+Nh2v+LkKkXzbs6aQRVv84t64Z5vpwGd4Jhu7gtsK2gQ3Y91G6051z3oUljC+kucWCC3B5al1id3RgXTZP4s8vhqkKl/eIMWrhr15HItcy5V17RIdJJwQk0anmm9aYHUgWyORpVubJhwvKcWniYUWTaJYeS8MgQO+7FDRoJrN4oSxsTH0VvEcnO5ju78Ny9H0E0cx5G34FQjL7/TUBH8AWS2EhBsDrO9m7prM0+tmQY89h06Wq+ct45GhGnvD1fGYhR0gHmC4upfZ4VDZlC1Jx2KbWBsoPUJc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123bb68d-da8a-49a6-ab83-08d6a691d545
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 02:24:20.2668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMDC1 compatible string which is missing, and also set
it to be disabled by default, as most of the platforms ONLY
use single channel MMDC0, if dual MMDC channels are used, it
can be enabled in board dts file.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch.
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dts=
i
index 4c7278b..8c51364 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1136,7 +1136,9 @@
 			};
=20
 			mmdc1: memory-controller@21b4000 { /* MMDC1 */
+				compatible =3D "fsl,imx6q-mmdc";
 				reg =3D <0x021b4000 0x4000>;
+				status =3D "disabled";
 			};
=20
 			weim: weim@21b8000 {
--=20
2.7.4

