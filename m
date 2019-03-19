Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D279C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A8F20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rlRbki0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfCSRtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:49:03 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:40659
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfCSRsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0NBVKVhyX/ppGtfTLtqwFT5qFUISZOUUbYjEkgaTY0=;
 b=rlRbki0sy/e1nVK+fY0zDByrz+YHuG+y5ITGY0kTGaNH/FgN1hyT98M4nRhBk5OpxGl0LczAviTa5rnrX/76rsj5bzMX6UTI55a6nfx5pKNSjlkki/BiE/mVV5ec1FsUBPA102KcfJ3FGW5SsSkwKHLOowPIhBpaOHbTbY7IZ+w=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1SPR01MB025.eurprd04.prod.outlook.com (52.134.2.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 17:48:39 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5%3]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 17:48:38 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
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
Subject: [PATCH v7 2/4] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
Thread-Topic: [PATCH v7 2/4] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
Thread-Index: AQHU3nv7ZVZuks5rS0ucf51z1gvPEQ==
Date:   Tue, 19 Mar 2019 17:48:38 +0000
Message-ID: <20190319174823.29467-3-daniel.baluta@nxp.com>
References: <20190319174823.29467-1-daniel.baluta@nxp.com>
In-Reply-To: <20190319174823.29467-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5eaec4b-8dd3-488a-e916-08d6ac931e1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR01MB025;
x-ms-traffictypediagnostic: VI1SPR01MB025:
x-microsoft-antispam-prvs: <VI1SPR01MB02514EFDF39AB5987379824F9400@VI1SPR01MB025.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(36756003)(8936002)(6506007)(102836004)(305945005)(52116002)(76176011)(6116002)(97736004)(26005)(2501003)(7736002)(68736007)(386003)(3846002)(99286004)(25786009)(476003)(486006)(2616005)(186003)(66066001)(44832011)(4744005)(1076003)(106356001)(86362001)(50226002)(105586002)(2906002)(81166006)(81156014)(6436002)(11346002)(446003)(14454004)(6486002)(478600001)(6512007)(54906003)(53936002)(71190400001)(110136005)(316002)(256004)(8676002)(4326008)(5660300002)(71200400001)(7416002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB025;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r8V8L5gAuhPflwQtd/QUYIC0YlU6Db4b3/LvuGH7m83LpjznH6bSTnJzjfT0CMIO5mUzR/pep7bxDDbiFQEoSOlZoJaEzWQfD6Z8X+a/pDcwj4Ldi8suPAXXQyUUI7mYlj+PImpmoBY03JN/w4hoTH5CQvpfhFIvZ/p601GHmu2jZjhGSUBwXI3Y7wZyS/oVjC0MYQHomCXjEujRa3ZEeU5iU0qAS4H5W6lPWyZTHrAfpzoKE3wSs5XKauY8Q6vdI6EvmfYvkllTAO9HOWU3HLVJAXSv3sDrNv2r69TQgL+YzYo1GfiGqQVPjg382J6c2FizOQZcVi/y5m2c+zBqmj19uwBxP8rUO2I7DQ01Ugq7lK0hgg3HLYcW83kmu4pfu+RE/l3llg5ab1VxCHSZjZD8YEluVgTFgFR6m1iS8No=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eaec4b-8dd3-488a-e916-08d6ac931e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 17:48:38.8452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx8mq sdma support.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
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

