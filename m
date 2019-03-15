Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13344C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DD221872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ns28L5VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfCOKeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:34:46 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:8358
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728869AbfCOKeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlTjDVmdpjxmvv78i4cgOToZsK6Zk/wG6GeZtXeRLPw=;
 b=Ns28L5VQvugexuL6t2xxRIvVpra1BBpFYGEymQTHxw+rH/LBHYNgoVZG/5FaDMhHHdPTptcaOdJltbTc+8tn4+SwbGYYLdlFYONWvtT9azGERdg/KxkaZQXd6GZME5DH9yPFv9Rhk1sprtWYbXcPNaovLGg3qiu8IqSa5Sov16w=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6370.eurprd04.prod.outlook.com (20.179.252.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 10:34:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 10:34:42 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Topic: [PATCH V4 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHUycaIN7xFf3mk/UCK6kIxRpvqJqYMoDEQ
Date:   Fri, 15 Mar 2019 10:34:42 +0000
Message-ID: <AM0PR04MB421124EF723BD6444E4DA7C080440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d7a21bb-4fbc-4525-f750-08d6a931d5f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6370;
x-ms-traffictypediagnostic: AM0PR04MB6370:
x-microsoft-antispam-prvs: <AM0PR04MB6370D6E31D10127F9EAB61FF80440@AM0PR04MB6370.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(4326008)(256004)(8936002)(86362001)(7416002)(68736007)(102836004)(55016002)(53936002)(2201001)(14454004)(25786009)(6116002)(558084003)(5660300002)(6246003)(316002)(7736002)(71200400001)(3846002)(81166006)(9686003)(229853002)(110136005)(305945005)(74316002)(8676002)(81156014)(6436002)(2906002)(99286004)(106356001)(478600001)(446003)(11346002)(486006)(476003)(66066001)(52536014)(44832011)(105586002)(71190400001)(76176011)(7696005)(33656002)(6506007)(26005)(2501003)(97736004)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6370;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RX7aaeXbk0dKrl6QEHuL3v4k0oYe1iJmqvE7VR/iqhCM6wdI6Jt5IoEgSpzbiPc5pyFculfA6cB/9mCzkePRY+id97NQZyvC9F6TfXgGnRDlAv3EroX8p37YVgEpzVebtU0ZVpb136VZkH70lkfKoRLOwwcnKrSBEcwHLPDmrpOEEuVMTsnsnQ8YzeJ8COncAHdNYgK7dikAWscuiQs+Gk6AUYbtwo/HluoS7PozwemTVWMojikGLLMnusfkOKyq0ApDSJJKV9vHieiDAWdA3cI5PLjsXx15LSQA35EjF3Y55SbH5VbK8I7HHbihUpTN6cAWvDG5k75pydvBLe7ePwYzGrQ9ckm2q4A+SOB2f5qnajAF7BxX/rnOkw+Dw6YOu+0+iL1awm5MuhRZ6QnRL2Z1vf2diOO0fmPUEk8sZFE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7a21bb-4fbc-4525-f750-08d6a931d5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 10:34:42.6130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
>=20
> Add scu general interrupt function support.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
