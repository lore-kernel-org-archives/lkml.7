Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9D0C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D0D2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iak7S05z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfCYP0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:26:08 -0400
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:14645
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbfCYP0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhRvkbPNkBjkK6SQ/ITb8k5MFh0hFbRLcA2L0CeD3SM=;
 b=Iak7S05z03ODIEKVedkE7sy8eNnV7F9lmtdXKz6MIyu7+7fF9Ktk3Basstb5jgwna1ypxVDass8GGe4YI48oq1bOTIMATChSQuxzcwRlg3B4ox+nr7aCFrMk1ywLXYTWB89JPv9aH4tgcyqiGw85Ng24d/uUHBpu6nQxlWbDWtY=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB6000.eurprd04.prod.outlook.com (20.178.123.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 15:26:03 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::c569:97f1:a391:4d00]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::c569:97f1:a391:4d00%3]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 15:26:03 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH] ARM: dts: ls1021: Fix SGMII PCS link remaining down after
 PHY disconnect
Thread-Topic: [PATCH] ARM: dts: ls1021: Fix SGMII PCS link remaining down
 after PHY disconnect
Thread-Index: AQHU4u10/As1+FdGfk+r8tl5GBIdhaYcbfQA
Date:   Mon, 25 Mar 2019 15:26:03 +0000
Message-ID: <VI1PR04MB4880FE626BF9E898FD898495965E0@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1553506240-2584-1-git-send-email-vladimir.oltean@nxp.com>
In-Reply-To: <1553506240-2584-1-git-send-email-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c1ba7d7-84ca-495b-4de6-08d6b136319f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6000;
x-ms-traffictypediagnostic: VI1PR04MB6000:
x-microsoft-antispam-prvs: <VI1PR04MB6000E2B1654F52A6FE4281C2965E0@VI1PR04MB6000.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(13464003)(6246003)(11346002)(6636002)(6506007)(102836004)(3846002)(4326008)(7736002)(110136005)(446003)(25786009)(186003)(71190400001)(33656002)(305945005)(8936002)(2906002)(478600001)(26005)(44832011)(14444005)(99286004)(68736007)(86362001)(97736004)(105586002)(66066001)(2501003)(5660300002)(81166006)(229853002)(53936002)(106356001)(476003)(81156014)(71200400001)(8676002)(74316002)(256004)(76176011)(55016002)(6436002)(7696005)(54906003)(316002)(52536014)(6116002)(486006)(14454004)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6000;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kf2UGiHPN0qk1WXsv9y1kFLMScXNhwQXS5aLRWr1k4gWEdoMRzTdzK1lOI9dmeEimGwRrfKURotj+0nb3er4BZnt9mpdCIFnJGiZ5HywPp0IPHIU0KWbevUjL9gqnoR/lhqbOBb8tE2hDTcGD4pnTLytEAVNhp5/IIgqdY5sMIp48K27QJXOuSRi1RJzgPVgsZ7N/V0MAXNL0gH5XrRiELMbAmknQu/tP1fzDjg8rw2ZGgPpog/9/GtdYOPVLlrV0ZLM6y+14EQHyjNirjCNcR1LrLQ+aipK7a2gjKqsZFHhsSz8hpE3/XjNuL2zJtU6FdfcLkVSNS+cVKV6duHWrqihVc/GdbtZfsVX96YB/b2E6BIawSDmrjT/1C4G6ly1bDhLyNTNHZKJJjT6MsjgEDNrhtsFOdjYuh5xiEgZAOE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1ba7d7-84ca-495b-4de6-08d6b136319f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 15:26:03.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Vladimir Oltean
>Sent: Monday, March 25, 2019 11:31 AM
>To: shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; Claudiu Manoil
><claudiu.manoil@nxp.com>
>Cc: robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org;
>devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>netdev@vger.kernel.org; davem@davemloft.net; Vladimir Oltean
><vladimir.oltean@nxp.com>
>Subject: [PATCH] ARM: dts: ls1021: Fix SGMII PCS link remaining down after=
 PHY
>disconnect
>
>Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
>But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC a=
re
>pointing towards the same internal PCS. Therefore nobody is controlling th=
e
>internal PCS of eTSEC0.
>
>Upon initial ndo_open, the SGMII link is ok by virtue of U-boot initializa=
tion. But
>upon an ifdown/ifup sequence, the code path from ndo_open -> init_phy ->
>gfar_configure_serdes does not get executed for the PCS of eTSEC0 (and is
>executed twice for MAC eTSEC1). So the SGMII link remains down for eTSEC0.
>On the LS1021A-TWR board, to signal this failure condition, the PHY driver=
 keeps
>printing
>'803x_aneg_done: SGMII link is not ok'.
>
>Fixes: 055223d4d22d ("ARM: dts: ls1021a: Enable the eTSEC ports on QDS and
>TWR")
>Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
