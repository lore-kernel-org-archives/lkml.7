Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A49F20854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bGYfWOy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfCONi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:38:56 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:44737
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727248AbfCONi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR+eKCyJFZeis89XUCW9jYGf405HpaFMCVHmwZI6kws=;
 b=bGYfWOy4qdjWiDisokdL/ChS1WSxBS++Q4kVwC4atrByt3gxfhhb02uknXGmfC+m5tnzZD+TZ4Dq3ahJ2BJBOw3iXrX/f1DOSefiethWtwdG3WFJaCithI9qHppB0fv+QnRdlZENXUlDSRgL5loPHYMYS3gEp2kTgNScXrnzcm4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4435.eurprd04.prod.outlook.com (52.135.150.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 13:38:50 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 13:38:50 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Topic: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Index: AQHU2Xv1SFnRc4p0SkOOn59vTkEkO6YMepnAgAAsWECAAA3s4A==
Date:   Fri, 15 Mar 2019 13:38:49 +0000
Message-ID: <AM0PR04MB421176101FD9525175463D5F80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <AM0PR04MB4211DC74D7E72F886A4333D680440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4481232D83340F894644673C88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481232D83340F894644673C88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2fefdfd-f949-4816-d2de-08d6a94b8ea3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4435;
x-ms-traffictypediagnostic: AM0PR04MB4435:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB443551068AD0564FAB08415E80440@AM0PR04MB4435.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(966005)(4326008)(71190400001)(86362001)(4744005)(76176011)(6116002)(33656002)(3846002)(478600001)(7696005)(486006)(6436002)(102836004)(105586002)(106356001)(14454004)(476003)(2501003)(8676002)(74316002)(81156014)(305945005)(68736007)(7736002)(44832011)(81166006)(256004)(11346002)(2201001)(6246003)(8936002)(2906002)(71200400001)(5660300002)(53936002)(229853002)(6506007)(110136005)(99286004)(26005)(97736004)(9686003)(316002)(186003)(66066001)(55016002)(6306002)(446003)(14444005)(52536014)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4435;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: optquMhBTAAB6MYAhZsW33f4311PqrohmD9Z0qkQg5k6Zfe2L0AQ6CKuk0XXDnd0Hox5a+ckUhKpXV/QEJ0dZBYpk+Knvgt0cMg396bW6uoifYbqH/AnfhYopxSVUWlwLLYYi/0m6BNcrnFmJozv+gGoXeHcRrgKDY6r+4a3/H5ebqYL400XKEcWLpEgyHOmMDTe3B1hTPv9nR8niTVplRhK/dYxiw7i7uYV35QmilGlFkTpXG0eOHPOMGhcMmG3C7cYJKU/Xm9DibnPREmPieucm59n59WYfBNNiLk8cUCvEOpY27lbfJ1WrLpn04S/4K7WE35FEtQMSoXZxW9qX9UreZI7yfvc3vHYu+Zyco7cIXfUjJju4uex1TOsExGrIrV81hJ3y4zQBhl7xB573RNc/Sz1aW7gJRvMZZepFNI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fefdfd-f949-4816-d2de-08d6a94b8ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 13:38:49.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > Originally devices are registered in arch_initcall. Now it will be a
> > bit later in arch_initcall_sync and this may cause a bit risk if the
> > code under the default_populate want to access the device service provi=
ded
> by early probe.
> >
> > Probably it's more safe to leave as it is unless you can double
> > confirm there're no such code depends on accessing early probed
> > devices as follows before we can make the change.
>=20
> This has been boot tested on 6Q-SDB/6UL-EVK/6SL-EVK board.
> For i.MX, I only see pinctrl driver use arch_initcall from the link,
> https://elixir.bootlin.com/linux/latest/ident/arch_initcall
>=20
> From my boot test, the pinctrl driver probe will be delayed a bit, but I =
do not
> see issues.
>=20

From what I saw, imx6q_1588_init() and imx6q_axi_init() will use syscon whi=
ch is
registered with postcore_initcall. Without having syscon devices populated,
I wonder those calls may fall.
Can you double check it?

Regards
Dong Aisheng
