Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6229C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777F02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lTeV93aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfEOKVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:21:24 -0400
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:28071
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfEOKVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geRomdKdzguPpN2SHaCR3vn0+oug+K91JuLc2exQDnI=;
 b=lTeV93aJyHmj4OoEyhi4TeL9U9XqqPSsho1wJq6HMjCdQcW9wXM9LGn502Lnq1dwyY4Mr/zV8CghqNBHZTb6lj8VBZbUtKtL3sM/qME7NgzJevoLzGAV+dm27fuBy0N78ZF5pUy5ZW8zjFz57u10RJeoTpcNoJ+Un2pBcZ2j3cI=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5188.eurprd04.prod.outlook.com (20.177.42.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Wed, 15 May 2019 10:21:20 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 10:21:20 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx8mq: Add SNVS clock
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx8mq: Add SNVS clock
Thread-Index: AQHVCrrVEeSa7rFIWkyl1S849ZKcvw==
Date:   Wed, 15 May 2019 10:21:19 +0000
Message-ID: <AM0PR04MB643421C90D4EA29B65332171EE090@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <1557882259-3353-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc2400f7-fe45-4fc3-3dc7-08d6d91f12bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5188;
x-ms-traffictypediagnostic: AM0PR04MB5188:
x-microsoft-antispam-prvs: <AM0PR04MB518866C0D15690E0FA4CCA78EE090@AM0PR04MB5188.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(53936002)(3846002)(6116002)(7696005)(305945005)(6436002)(99286004)(52536014)(66556008)(229853002)(66946007)(66446008)(64756008)(66476007)(74316002)(76176011)(53546011)(6506007)(71190400001)(71200400001)(14454004)(91956017)(9686003)(55016002)(8936002)(102836004)(86362001)(54906003)(256004)(110136005)(81156014)(7416002)(81166006)(2201001)(8676002)(478600001)(2906002)(73956011)(76116006)(7736002)(26005)(2501003)(476003)(446003)(5660300002)(44832011)(486006)(4326008)(316002)(33656002)(186003)(6246003)(558084003)(68736007)(66066001)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5188;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N7HC1pPVQYBSQXvJBNhD28lTQygfUF5xDZlbDiXcPpg9zUzAd5HGhpjdyWh0R6yWr1+4n3d76kl+HPrsbdlSDtSsOjFBj6kI2zmg57MMCutRd4r/X9jNXc7putrA/BLEGbSue6R019oYUAjA//zrn8jXBqeqIg8Aje1tJw1eW5MPCBnhOw5M3HZOIweDKi3XECpQe1urkmWq38J2Tb+pbJa6GG7k72FvP+fQMklEvOKegODNmV26H0ZceFr2K99+GdhlrdKhDoxODjIamWIc6g5AeZFnPcDGrJqGf+O/LnVvXjHBTEYBdNE9i5AE4LDZjf9R0stqV3bPRh2dk9U7QN65jQCfp4zv7BR5iWJbs7tWqOeVMYY93bEeJDLBwKgF4ywJzQFkslawEiYvGmjlmhnTZWsOP891nhSjVfUTIYE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2400f7-fe45-4fc3-3dc7-08d6d91f12bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 10:21:19.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.2019 04:09, Anson Huang wrote:=0A=
> Add macro for the SNVS clock of the i.MX8MQ.=0A=
> =0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
=0A=
For series (couldn't find a cover letter):=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
