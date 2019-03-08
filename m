Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2467A20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b61ymqbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCHMCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:02:49 -0500
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:15337
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfCHMCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fwe9t73owHvjIAwZrpHIIY0ojxwLrXm9otyeN0ekMfg=;
 b=b61ymqbFAPUJl9UyjGMZVk7ZARbAyMbmsTgyTA6OQy5TcgPg6gu3BIUynhXGG3qu3g6yEDez8Uuqi1Q9ELMYRJt7KTo8ekn96/i/AATI2+FQfMExWiwACtr6gwZ+/YIiekGrqIQA2CMH1tnCkYBjthZot9m9+bRU9HBD3lkSuvk=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3776.eurprd04.prod.outlook.com (52.134.15.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 12:02:25 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 12:02:25 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v6 2/4] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
Thread-Topic: [PATCH v6 2/4] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
Thread-Index: AQHU1abLXSeJ/E1ZU0KttzkdSxjLZw==
Date:   Fri, 8 Mar 2019 12:02:25 +0000
Message-ID: <20190308120141.3698-3-daniel.baluta@nxp.com>
References: <20190308120141.3698-1-daniel.baluta@nxp.com>
In-Reply-To: <20190308120141.3698-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0074.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54ca46b7-3d23-4cc7-c9d0-08d6a3bded76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3776;
x-ms-traffictypediagnostic: VI1PR0402MB3776:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3776;23:XBlgSOggTaPj1x0J5DrzsMrSitj9AYRRZNzpa?=
 =?iso-8859-1?Q?AdG+eMCxXBj3N3jkuJ9+etSImR4/kyVMAnhAJztrhA/zaTVx6evOWNrYnT?=
 =?iso-8859-1?Q?CJxtNKNdSYw8LF6+0TG6eKHWZyaZEKmtOadN5kYuSt3IMO9uOI5hRiZyqo?=
 =?iso-8859-1?Q?0YhiAM0w3XtKddb/hWDAqc8V/IgMBoILXyObLFKz7z5LJskcLWrp0RwgU+?=
 =?iso-8859-1?Q?xfIPFCexP/YNQq2bE6Csk0Dx6pjFAY/5FI+1pzhmQHGfwjwoU7YG36ruEs?=
 =?iso-8859-1?Q?xlMy0JCyyY4AnaSaZDjxwvMMU60QN4n+kKuApcAb6cFRcw9571ZVkyDF3F?=
 =?iso-8859-1?Q?OI63UZ6s4pfHTvZChftZ4MaVWW9essyrRdLtsK/aomgZ4btt6+ZkBaL/Ze?=
 =?iso-8859-1?Q?smXq1sRNQcrYl0P0pY3sNPpTgDUYOPqrPdBz17QH5tditiSRSqzv+IB0I+?=
 =?iso-8859-1?Q?k6BtCFzIuQSSkB/S1UsUg4xjFoEAaRjDWH5Q6Sse1N8hbN0vy1rCyBDhvq?=
 =?iso-8859-1?Q?WvkS/h0++8pmP/dw/8FW5MHvnKW50mYQmfP/vb6L83mAKo6/XAPyBiGUDW?=
 =?iso-8859-1?Q?a39Vst+I0YTEuOqDT6GLisWkfGJZInWMeeHGGLr5lWsu1Ys2bIlYXbStmH?=
 =?iso-8859-1?Q?oUvt9Gxj9wPFcIomjXyFbJQMGLIiAWdqUf1hjuPu5ZIDnckT9X85LHkyNw?=
 =?iso-8859-1?Q?+uRbJYK7LbN+M1LBo82+wpYJuP6h43yK2XlYlODzFKbnO3SszNLohTaCOk?=
 =?iso-8859-1?Q?LDRRV1IfWkGAWLbndmjuVVBILsUCcgU+u+I85jZv7fV5qkl+vNvzd5MRb6?=
 =?iso-8859-1?Q?/f7TVyiz8FMdwhXjF2a6F33HdHOZlDlFKiz+FTjtHVP+EHZp+99k0CAG0X?=
 =?iso-8859-1?Q?1466qtCIQrl1SdcdKvomff2zpA3j6KUDCy0hhoSklEW6d8CiVCrvW1VDM7?=
 =?iso-8859-1?Q?m4MR/ub39WbEPNAORqBbaQcxDWUggZVjm2Ism6j+5xNokgxYZzYcF3D9VC?=
 =?iso-8859-1?Q?8qC+MtxHZOHMgEPEtOmgaL4s80nc9xSTxtOGgGS0m8cVXWH+RSXYuw3w+Y?=
 =?iso-8859-1?Q?kxsrsec9Mf2P53+N2cDnCEcYnjpqcpMjoQGu2neSy0FiE+FgbWj2Y1onzP?=
 =?iso-8859-1?Q?doobKJ05vbzh8SZmagkvUhe3CyVx+Wq0G0BI/kxj+X6vHLfHavRpKfHbJ8?=
 =?iso-8859-1?Q?W/jYYxFa0v2Q1c+A2BHr9BPg2C6Dh+m4Oka+z4pXZDe9S/uHv4kvUkDMm6?=
 =?iso-8859-1?Q?1bXKNqYpYjYp05/Kk6c2XTTBzNzMnE+WUt1lxCd/Lbx8BktkbVnieutNhe?=
 =?iso-8859-1?Q?DTfFM45IWG8s+HWtMcny44OZ3I7y8G9mR8eB+/AtFUqitdLd6aKlNyFQaf?=
 =?iso-8859-1?Q?aRMqI5frUt9FC7PJ1BUBaaBlkq32GTl2sBoFwQae8IPiCIz8Tnhn5wzvoa?=
 =?iso-8859-1?Q?WfcS1n9Sd2+Q1loI=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3776B1AAF36CA4EA3B87ADDBF94D0@VI1PR0402MB3776.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(36756003)(52116002)(2906002)(68736007)(6436002)(25786009)(7736002)(478600001)(305945005)(4744005)(105586002)(1076003)(14454004)(2351001)(81166006)(106356001)(256004)(6486002)(8676002)(8936002)(50226002)(6916009)(4326008)(102836004)(54906003)(3846002)(6506007)(26005)(66066001)(386003)(6116002)(316002)(486006)(1730700003)(81156014)(97736004)(44832011)(6512007)(476003)(186003)(446003)(7416002)(86362001)(5640700003)(11346002)(71200400001)(71190400001)(99286004)(2616005)(53936002)(2501003)(5660300002)(76176011)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3776;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K0vtrzocOkqUlcQ6OVsQa9rNwozBAUvqfVMrl+cmLWlgxVqpvbQ8WXMiEaeuAr41tYas6FMRUPmbsUzY5g37U04Ug1yYbFmwEIQlTTHNJEPTWtCchm3hPC3fNN135CcAP1rGCDx+GchimlftZRSPTTWO6GJ3WbyT47bf7q3/DQRKeVFzMLUgswYlsy6MgdZ365MzQUEsiODZ9e1fh5lDIIfuwKkxnSyW6I1y6nxms+F2FcmUB2rt7dN4RI7Pm/d3sq38Xer4Hb5r1z4CJo5um0NF7UDyQIgcOgTG3910oRQNcw+eqw0Vcw63Pu2dlpoUF9WQzkCFuADaen4YwPbrxR6C32wy5swhQcanMM6pdXc8279c6odCjTLpTldAE4TIp8nMrtz9QaxiPxtzaXr7s/FmEklvDSc9nldUim6nm5Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ca46b7-3d23-4cc7-c9d0-08d6a3bded76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 12:02:25.0797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx8mq sdma support.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Docum=
entation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 3c9a57a8443b..9d8bbac27d8b 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx8mq-sdma"
   The -to variants should be preferred since they allow to determine the
   correct ROM script addresses needed for the driver to work without addit=
ional
   firmware.
--=20
2.17.1

