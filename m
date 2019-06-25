Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D17C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8B020665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXOt0tAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfFYHH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:07:26 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:16683
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfFYHHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8HKRmA0t2b9qClhq3yOLc/W8mjm7O8q2IAz2vweakY=;
 b=kXOt0tAtd8qN/+TyU6D5Y+thZdulEJCTrjMB8OmySXT1SDvOhl39L32hhG9omwPVwBs7+fA6MYYa3H+Pnpe/eoKgnp9CT9IzwvwDdXWJABmGw+ONjQeIjG1Em7qGK6HDfbK70In9Mu4lNkA3ZmKwSmLZpOnJvbU1Ve9EpyUsA2Y=
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com (20.176.236.22) by
 DB7PR04MB4028.eurprd04.prod.outlook.com (52.134.108.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 07:07:20 +0000
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::2c71:9f2f:8db1:a290]) by DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::2c71:9f2f:8db1:a290%4]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 07:07:20 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Recall: [PATCH 2/2] clk: imx8mm: GPT1 clock mux option #5 should be
 sys_pll1_80m
Thread-Topic: [PATCH 2/2] clk: imx8mm: GPT1 clock mux option #5 should be
 sys_pll1_80m
Thread-Index: AQHVKyShV/C541yfwEOXsooxpsWQLg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 25 Jun 2019 07:07:20 +0000
Message-ID: <DB7PR04MB5178A84F3FC1BCF4843D441587E30@DB7PR04MB5178.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f37cb83-06dd-4085-2cc4-08d6f93bc422
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4028;
x-ms-traffictypediagnostic: DB7PR04MB4028:
x-microsoft-antispam-prvs: <DB7PR04MB402867C44C9B3F561BDFE36487E30@DB7PR04MB4028.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(66476007)(66446008)(316002)(73956011)(25786009)(71190400001)(71200400001)(186003)(26005)(74316002)(305945005)(64756008)(102836004)(66556008)(6506007)(486006)(14454004)(66066001)(558084003)(2906002)(7736002)(256004)(7696005)(110136005)(8676002)(68736007)(6436002)(86362001)(9686003)(2201001)(55016002)(8936002)(81156014)(4326008)(52536014)(6116002)(3846002)(81166006)(5660300002)(2501003)(478600001)(66946007)(99286004)(76116006)(476003)(53936002)(33656002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4028;H:DB7PR04MB5178.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FtnHWyYqCLiNAuSRL/8vDldZWPex35pheTa9W+j7UixI8Ilt16g8YwwgWWibfIEX6I1gxFafuh2GM8WeNwv4FD8Nb8aBrW4tiFupgcTFx0JWbajiIWvAbmY1FTlY0A6/+Pid6qeZWd2kCRCo0OPAWjjqN1Z9wh7S2MpF+tFfIhtrYAv/oDmjU54IXUv5vOFviI6dFsBdFuWSLFVKJp/9zRkKFYN23UIwRsY8mdw3b4yedSL+yAlI9j6/GsIgHTkAioxzBMLusXRc2HidHrwiPuwufY/2FmxF1/i1qo/YciTKqMdVET9kCrB2VILKSeA+I3q2EwS9UYn3OMJZHbjRKbyzXK57IbSGsOEXuts6mPbwmFq/xfpA/IEZOZjS/f7XV/jAbNQ9lzvulfVoDRMd3oIndc0UTH9X68b3NMdPLLI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f37cb83-06dd-4085-2cc4-08d6f93bc422
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:07:20.6915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ping.bai@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacky Bai would like to recall the message, "[PATCH 2/2] clk: imx8mm: GPT1 =
clock mux option #5 should be sys_pll1_80m".=
