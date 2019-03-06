Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F07C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7AC20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FoXTRe+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfCFNJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:09:48 -0500
Received: from mail-eopbgr30065.outbound.protection.outlook.com ([40.107.3.65]:28135
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbfCFNJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nFDxqTHGfx7MlTRQbwq6B0KCkmw+bZUQ+I+V/Asmmw=;
 b=FoXTRe+aYpxyEfedAsLr4XNunEGa1KmHwjo0HYNN2H0+fY4frbx9uV3qPkvO7EInXX6FLQRZY18jZIuPEkOWYPhWvVUhf8TJNYLIxyjx7r45lbuj6hPoCpV0K3s9g/hOhHEU5AH1WHtpWLc3/1pyOX+ArmG8mo42mTOaNfYq9L4=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB3956.eurprd04.prod.outlook.com (52.134.93.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Wed, 6 Mar 2019 13:09:42 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 13:09:42 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Patrick Wildt <patrick@blueri.se>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and
 gaps
Thread-Topic: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and
 gaps
Thread-Index: AQHU0ziyUrOqOGzNAUGITeZr+qRjmqX9Xs+AgAE2d4A=
Date:   Wed, 6 Mar 2019 13:09:42 +0000
Message-ID: <20190306130941.dqf3swx66bchm5k2@fsr-ub1664-175>
References: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com>
 <155181110921.20095.1641360339603928947@swboyd.mtv.corp.google.com>
In-Reply-To: <155181110921.20095.1641360339603928947@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c83256c0-5391-4657-9a8a-08d6a234ff4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3956;
x-ms-traffictypediagnostic: AM0PR04MB3956:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB3956;23:IitVHXsis6mdMevel/SL2ShwQl969MEmIIcNYdxjj?=
 =?us-ascii?Q?UpMx5AJlbDSOO1MnA934w7PpsNEyAJSeYDGGiW2by7MWyHg8DFPB8hMb6KXk?=
 =?us-ascii?Q?o2SBWE0ESS6bjz3uUgq9xX8BuQwZu8iDMRv7d+23qBUrfN0/1c8YLr8qz/AX?=
 =?us-ascii?Q?ns/4GjBzvCHZzwkfEKINNGvgYQlQGR6/HJvJtCvfPCyRSEQHokzmyLyv7H67?=
 =?us-ascii?Q?HWDYZ9JypeEZekRa6DYLFTyYODffrGAxzX6TVO9YCVuGOffCK5MGN4JsKVDw?=
 =?us-ascii?Q?IrK98OkYAP40OfE/IQt1oruEmBUF7/ZTDsQNQ+GWmIFWkD/hgBmA8y0KrQgf?=
 =?us-ascii?Q?BECPQPxX3zbCy1Tp9HvB8R7ul4IY1hDrgdAIPgeZglPH7Hxj2DU9uYWi2fl+?=
 =?us-ascii?Q?CiktVnlwqzNCkaV9E3flNvE6RBFO6oxV/hrwR9o9PoTPOuJYs6KbvRj483gp?=
 =?us-ascii?Q?lK5avYSEICpvj8HQacI/R1naEQJmc8KUumq1zoXqfGz7c/qiR7rhbn1naflp?=
 =?us-ascii?Q?afelaVGP183QH9U7/G/sBKh73CbH+9XvmptGjE+RFCJoYmdbgUhk74kSx4E3?=
 =?us-ascii?Q?1Dpe820XGJC7UNzsl2ikdydMi5GoCxtBxlS/yNEVDurFM3Zl4XVj5spw9I7j?=
 =?us-ascii?Q?e2CnzZ0r847mf8IuEekOi4ZofjbVvJctj/25MF0lxwnAbWrguU1kz/6yiBXR?=
 =?us-ascii?Q?wjnO45xsJXprmtxFtzORLp2R5XmDPrzhNU5YqkXilpowoseBcwkvmfxnzp4+?=
 =?us-ascii?Q?+CsmW2f03nZY5c4VHJZ95nOjEFe/jaUIgNX4ctWeP4At6L1qDobncoBHSfQo?=
 =?us-ascii?Q?B+o1jlcoWvBHZCHmbTi4w3ruBD+F9qkElh3wsmY9w3sOY1EbEwlB1sBJPkPV?=
 =?us-ascii?Q?NDxPT1k+M+dtkQW1QoiOtVd9GMEMdNhKfcOJrRZaVdyGoQ7AiEdDYRYcLfLm?=
 =?us-ascii?Q?JgqSl4aO3gvpNpmiGSvQlwTGppEPlWeExsJx/PYdm41mMSAK9m1LlPizYOmW?=
 =?us-ascii?Q?60jm/4EdOuvplxlcKDQIUXOVdT3eD6Gi0ZedDJPAWvsxltPY6hMyF4Jh7Crs?=
 =?us-ascii?Q?ZvFGPra+AubjeHQZpkQeTEZAgSmZJ84ch+oN23k2ckfY82VNHBGaoVtJv8Cs?=
 =?us-ascii?Q?Cmxtp1KgXlkTJdUVinIH99jpRco7GC5QHld5ba3eF4mWFIR9PzwexZg06FDu?=
 =?us-ascii?Q?lu3clfLDpeY7k5EgsM04Putruf50hCDFtoNeKtT5fXhojXwnhkhQzvN9JrwG?=
 =?us-ascii?Q?iTgZa1tcY7HdmahxFWgLS/QJb4mLfd/ZNdUeT0wPz2Q2BH1b8MdZDyz7vQcp?=
 =?us-ascii?Q?OWe+qaep+ojS4Iki8xXGd4=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB3956B88D4A78E972F89E2AC2F6730@AM0PR04MB3956.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(53936002)(26005)(106356001)(186003)(86362001)(8676002)(8936002)(105586002)(4326008)(25786009)(81166006)(476003)(33716001)(68736007)(478600001)(81156014)(6486002)(446003)(229853002)(11346002)(97736004)(44832011)(3846002)(6116002)(6246003)(6436002)(486006)(66066001)(6512007)(102836004)(9686003)(2906002)(99286004)(6506007)(71190400001)(256004)(14444005)(71200400001)(5660300002)(1076003)(76176011)(53546011)(7416002)(7736002)(54906003)(6916009)(14454004)(316002)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3956;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WjXuyZpDVVdA9vNG31dNdADY9wWGyC8NT0BHFS2g9k8yFN+g28sMyOrHlM07Qdf+XnA7HLShNadO1+lYYzGCkz8QEeH89EgS+kU1eOjJMyXG7xJpZ1Rg8/5KZkdVu+w8UoZnf8YiV2NmE4b3nwiE5L1s6OCDWFqtW83CnAE5cMiQUsN3tpZ6aCaxch4XO2YDlmUlAzz+VhVja0IR2Az6Vim9FD1zjoe9IoKBR1s4d9kuYl6ZzwR0aHDF0w4yF02W5gV/0K8r9ayB2ri2prTzKJdrTS0uutn8eDO7gPyV3lIIuyZCwhsFhqEwY2r1ZsT3kfCkRW1LWd4T4XgMyE7jUNAhxPNbqGQfL/Ha4T4PeTUYlLjjlMhwboHWBDi+79c3N7RKMLfiH9+GtLa4HMMOjdBgL22cnHHrC+RQoNlTBvc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACE3C48577F71A4580F6C4435A037E26@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83256c0-5391-4657-9a8a-08d6a234ff4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 13:09:42.3602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-03-05 10:38:29, Stephen Boyd wrote:
> Quoting Abel Vesa (2019-03-05 01:49:16)
> > IMX8MQ_CLK_USB_PHY_REF changes from 163 to 153, this way removing the g=
ap.
> > All the following clock ids are now decreased by 10 to keep the numberi=
ng
> > right. Doing this, the IMX8MQ_CLK_CSI2_CORE is not overlapped with
> > IMX8MQ_CLK_GPT1 anymore. IMX8MQ_CLK_GPT1_ROOT changes from 193 to 183 a=
nd
> > all the following ids are updated accordingly.
>=20
> Why do the numbers need to be consecutive? This looks difficult to merge
> given that the commit that's being "fixed" is in v5.0 and thus the
> integer value of these defines is pretty much an ABI. So if there are
> holes in the space, I suggest we leave them there unless something is
> really wrong or unworkable with that solution.
>=20

I would've ignored it but there are a few overlaps.

#define IMX8MQ_CLK_GPT1                        170
overlaps with:
#define IMX8MQ_CLK_CSI2_CORE           170

#define IMX8MQ_CLK_CSI2_PHY_REF                181
overlaps with:
#define IMX8MQ_CLK_ECSPI3_ROOT                 181

#define IMX8MQ_CLK_CSI2_ESC            182
overlaps with:
#define IMX8MQ_CLK_ENET1_ROOT                  182

By removing the gaps, some of the overlaps are also removed.

I can just get rid of the overlaps and keep the gaps if that makes it more =
ok
for the stability of the ABI.

> BTW, it would be great if the binding header was generated once and then
> never changed again so that we don't have to spend time on these sorts
> of patches in the future. Please try to fully describe each possible clk
> that might be used with a particular binding instead of adding new clk
> ids over time, especially if you have access to the silicon manufacturer
> documentation and can easily figure out all the clks that are there
> beforehand.
>=20

Here is an example of why this is not really doable: clk-sccg-pll.c.
The original design was adding the intermediary clocks like:

IMX8MQ_SYS1_PLL1_OUT       =20
IMX8MQ_SYS1_PLL1_OUT_DIV   =20
IMX8MQ_SYS1_PLL1_REF_DIV   =20
IMX8MQ_SYS1_PLL2
IMX8MQ_SYS1_PLL2_DIV =20
IMX8MQ_SYS1_PLL2_OUT =20

And these were just for SYS1_PLL. There are 2 more SYSx_PLL.
Plus the DRAM_PLL, the VIDEO2_PLL and the AUDIO_PLL.

Since the refactoring of clk-sccg-pll.c, these are not used anymore (or sho=
uld
not be used). So I would have to remove them, but as you said, it would bre=
ak
the ABI. And this example goes even further with the fact that the PHY_27M
and the mux between the PHY_27M and the OSC_27 are to be controlled by the
display controller driver itself (at this point the PHY_27M is not yet upst=
ream
and I can't say for sure it will ever be). Basically, what this means is th=
at=20
the PHY_27M will have to be exposed as a standalone clock even if it is hid=
den
behind a mux which has another clock that can provide the same rate. That
is only because there is some difference in phase (AFAIU) between the OSC_2=
7M
and the PHY_27M, at the same rate. And this is just one example.

Point being, there is no way of knowing beforehand what intermediary clocks
are needed, even with the silicon manufacturer documentation, until the
driver that makes use of a specific clock actually works.=
