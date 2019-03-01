Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42D620850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J9ruPgAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbfCAQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:37:12 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:54658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728517AbfCAQhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fwe9t73owHvjIAwZrpHIIY0ojxwLrXm9otyeN0ekMfg=;
 b=J9ruPgAt0C6YEgm++GXeX2qJuaIybgQ/dswwYInYvd1fIY3wXEejm9EBc2/G/k42BamkzsYzJ/uNtTkGCQaSnOhveGRMZSunwdMls73ZExUNRI+Mq9m/S9bjKXQa3PvLDtyzgOxg0AfBjBdSRQQdCCUuJtE02Z45KkaqgDPSnhI=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3648.eurprd04.prod.outlook.com (52.134.14.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 16:36:33 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:36:33 +0000
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
Subject: [PATCH v5 2/4] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
Thread-Topic: [PATCH v5 2/4] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
Thread-Index: AQHU0EzuGVWk5b4owkuCt9GuHmHL9w==
Date:   Fri, 1 Mar 2019 16:36:33 +0000
Message-ID: <20190301163604.10618-3-daniel.baluta@nxp.com>
References: <20190301163604.10618-1-daniel.baluta@nxp.com>
In-Reply-To: <20190301163604.10618-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96e1e122-399f-49cb-7cef-08d69e6410bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3648;
x-ms-traffictypediagnostic: VI1PR0402MB3648:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3648;23:tNr8OdCxa019BsSdGR+DmMtAstPNfh7eFX9AA?=
 =?iso-8859-1?Q?I4nwRwU2vayr3bCDLmmkLEb85J4MTnJ+wmHv9Ta0G0gTxTis2ccuss9AMl?=
 =?iso-8859-1?Q?o87XoUz8HMLxEhJ86Gn/FoDPv+7UzWjcgkyzfYT70eiaHnAcNUBPWV6r10?=
 =?iso-8859-1?Q?3CP/xQwndClYe0CPF7bDgcbPP4/IifTRTWabXIx961hDtB8A6y8uC4FckI?=
 =?iso-8859-1?Q?ovE0wATtET11hQqljJRHj28hsI/FxF7bbX8RFqPN3kObkMPclPsvhKj/rX?=
 =?iso-8859-1?Q?ftyxZBJu0r1gAscigWRoSvFhocqf5YlMnrlO48TB0ZNhgF1AZbuwH6bzng?=
 =?iso-8859-1?Q?o7GusDoQwp5K0RVqzdcB+OnxWyS3s4atkEzHPMk4M4gSBt2aWBRJPRPeMB?=
 =?iso-8859-1?Q?XYigDEWVXmFt0mIqRESUkRjJPlvwq0E4PdpJ/XTRJNc64OL+fnWWi/hyjf?=
 =?iso-8859-1?Q?UwGGvYSV+7RRzEbS+fCWuwsBZWvXXNl38ffZHja8hXpWMRLOK42AHFWxx6?=
 =?iso-8859-1?Q?0Xffmhvx40wouM/04YGYedeTEWEElbCC2HdWbYSvvXX/eqIuIeaXoqNPDl?=
 =?iso-8859-1?Q?PcitG7xt8piEzSwO6hnwXdiDtkEgwzpA2sGDcP51BaxJFZD6X6x/83S6MQ?=
 =?iso-8859-1?Q?m7vmyAdaP5cfaBc+dwLvnH57Tl4+B185O1/Kx/Z7xq24y1wh+WaOLAD5/q?=
 =?iso-8859-1?Q?GJ8Re/ilCNKyXD5eQN4FiKsQtTvQ7gKLdFoAKlwg97g1jKpiKbBHRy2EUp?=
 =?iso-8859-1?Q?chCsW3rP3IDP20oND/w9eGceaEeVgomuwBH85gFvoA6ybtCcX/1k1UgwJl?=
 =?iso-8859-1?Q?+wBs3AJIIfFA+jglrs9W0vaNagOiLDSeCF4lL5WNDTRLogOHVx+uu9i732?=
 =?iso-8859-1?Q?MLfNrZfOy4wWMYzxtmZDcTrjSM7YJ5/ChnNHbcVUCqi0DOFf4CWtteXXVA?=
 =?iso-8859-1?Q?08qF1qVgj7lsrNjAeqNvrVnbe6DenjQBwjOr6dbtZKKvh99surOM5/JnsO?=
 =?iso-8859-1?Q?3OK67bscqwfqGwsi6PF0InRhTPUsVJfIdL7YW3n/SHyG3OiRfT+Z6q3gTM?=
 =?iso-8859-1?Q?dBD/uBf9Qf+WT4qd0fCX7KdHO6CBn5Gj9mC79BtQDMtj/mzXWXbTtc1MDe?=
 =?iso-8859-1?Q?D1+cl+mS/pAmsthtF8iUlYbiPtnmdppbC5JJB+bvjCZW+wY8MB8LDjxDoS?=
 =?iso-8859-1?Q?jE5l+ITKz3s/te7NqE77XTbTdEaWxzFOLeprCHrO5/nF0K2KRQ5J02qxwF?=
 =?iso-8859-1?Q?fx0abga67lUgiOlB6L9E78eUsGX6zjwv07sN8NvQg5L1Espgp9kYN5doX0?=
 =?iso-8859-1?Q?LqH10Wm+nwWlH0xFANGv4zCV/khFFb8LjVyZnh3QtdeoBWR79XjdhWCcIV?=
 =?iso-8859-1?Q?JlEmMUQgq8uxi32ONVVTiBdk51MUIPEaohWDiyTsqlSZ26v/RmgbIcLb34?=
 =?iso-8859-1?Q?O8/WmReX7vMykGxs=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3648458E1ECC848E4B371E5FF9760@VI1PR0402MB3648.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(68736007)(478600001)(76176011)(6916009)(99286004)(386003)(53936002)(66066001)(52116002)(7416002)(4326008)(2501003)(14454004)(54906003)(6512007)(106356001)(2906002)(86362001)(316002)(105586002)(256004)(11346002)(6486002)(486006)(1730700003)(186003)(476003)(102836004)(8676002)(4744005)(25786009)(81166006)(6116002)(2616005)(446003)(5640700003)(3846002)(97736004)(50226002)(26005)(8936002)(71190400001)(5660300002)(6436002)(305945005)(71200400001)(2351001)(6506007)(1076003)(44832011)(7736002)(36756003)(81156014)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3648;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T80cS+GfMWlas1BE1DACLjAjGL9WZpk23PU7HMctVmb2CgLDlultSUWKonDgme+RDdsumevn0XWggI9WU1HUw8alsa4qqCT97QwHmHkWDll7baDd8AgVWS7b8wPETUn0hfD/TsDSlr4hcac1nKPp788Jzq4Kw5xio8+Xr21NoLKDo/DXjxoJRPWKcgy7zJyYM20WpdkX4Gn6Fc+nPMThaxMnA2cugQPPZnbWpsoCsgn/btYLKwbrwnKRHo57KW6b5pYhtONpb/UfWmfRe8QUihbcB1rWQ3ALn2JYacWCoM6at4UT2OglP5JAcFN5Zd94t+fFdNvmJJYB75KnKL7Q3c9+6/NCMG2M15PzTNFJNtfzzXHOtKC5bkfxsYUYIIePQz0vEv7CBRMyRbQiF19/Vo80PgDqIR2zERsR5ApwCAc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e1e122-399f-49cb-7cef-08d69e6410bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:36:33.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3648
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

