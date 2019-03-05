Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ECEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858F7206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="sonEaJFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCEKDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:03:22 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:19076 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbfCEKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:03:22 -0500
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id A8/D5-04122-7694E7C5; Tue, 05 Mar 2019 10:03:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSe0hTYRjG/XbOjifx1OdUfLOUGBLYPNOp2AT
  /CCpcdCeECsXO3NEN51w7s7RArKjUqKxITVyWldYqKrtQ2s0hVpZ5TUsoMheVdjHtDl12PGr1
  3+97n4f3ex54aULRQAXTfK6dt1k4s5LyIY2RVBybvig/Oerj+1htU+VnQnuw301pv3QXyrRd9
  ZXUPFJ3reKpt27H9w26OmcRpRutC11BrpWbLPrs3HVyY8m5FOtvKtc5eAYVoK/yYuRDk/gcAT
  2NFwnxocB7ZDBysRNJjz4ED6pPeGxTaApr4PDbD0jkADwfiuu3U6KJwA4EJ4f6ZMWIpv2xHn6
  +TpA8aVD+/BklcTS87Dg7tofEYdB/dqu3aGdwCtzsjRTHCpwOR5+XkCJPwfHwo+O8TGSEQ+DT
  ltOEyAQOgj531dgcMIbj19sIiQPhzcAvueRPhZ233nlL8who7XUjiZVQ87hCLnEIdFbtGp8vh
  dInHWNVQOx7Zb9j3DQHWhqeEpJQzsDlvaWEGBqwGcpcMRLOhA+fvCVLlxy+OdtlUpk0GHa0jo
  cIBefuflIytRNw5fVjSmoTAUcaRqgSFF7xT7mKfySJVVBzdIgQmcF+cO+QmzyCSCeaq7eZMoz
  2LM5kZjVRUaxGE81q4mPY2Bg1t4nl1HwOu5EX7KxGzW0U1EJeVprZoLbw9jrkOSSDtVF1Fblr
  M1xoOi1TBjIx2vxkxVR9tiHPyAnGVFuOmRdcaCZNK4F5pfNofjY+g89NN5k91zghA+2rDGDso
  swIVi5LMGVIUgti6dvV/Q5CQVqyLXxwEPNSNGHRZMyxTK6YuOlOFBLszyAvLy+Fr5W3ZZns/+
  uDKIhGSn+mLdGzxddksU/+NOgJIfOEGO3aLIawc3+l4AIU/rNoVfNIfOPUzLDEsuHMlofvYxf
  uq29WsTMCD1ANTUn5XT6H71xItD2Tly9QDVChO1MX65e3qyOXTfN3PViZsCZu2ezPhtpFhRHq
  mhvdj8zbXp1+YTs1EHZpVnHlj1JHWPPdqLYbZdaPPdOTNfsCVse9uT+jPclyPu7yklZdrKpy/
  TElKRg5zRzCJnB/ANMb+x/OAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-7.tower-268.messagelabs.com!1551780198!2369798!1
X-Originating-IP: [104.47.6.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24166 invoked from network); 5 Mar 2019 10:03:18 -0000
Received: from mail-ve1eur02lp2054.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.54)
  by server-7.tower-268.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 5 Mar 2019 10:03:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPfvnqie3Z4F+E30oRYl9iT78R0v0ZtVTGMMCyZWtf8=;
 b=sonEaJFKYxcZzEuygIJ2NwVJUWj1moBvcjPhslfHzAX42OGY893gEDHSa5qexscHUE4cT4hMr1WiOjWflgsKVuE2NbO+pEyswv0nDD/Du9x9DLHn9iLrtUGcoEwmqCgVf73iAAWWxVCv0j9kafSojMvureLwQuwyNL89ArzJ8yk=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2448.EURPRD10.PROD.OUTLOOK.COM (20.177.62.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 10:03:09 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1665.019; Tue, 5 Mar 2019
 10:03:09 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] regulator: da9063: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Topic: [PATCH 2/2] regulator: da9063: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Index: AQHU0oyR6xVYpuCjUku2vi+pCvcGDaX8xWsw
Date:   Tue, 5 Mar 2019 10:03:08 +0000
Message-ID: <VI1PR10MB235240E26EFE426F0B6D6EA0FE720@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190304131603.15730-1-axel.lin@ingics.com>
 <20190304131603.15730-2-axel.lin@ingics.com>
In-Reply-To: <20190304131603.15730-2-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb85143e-25ce-41f1-8b6b-08d6a151c518
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2448;
x-ms-traffictypediagnostic: VI1PR10MB2448:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB2448;23:qZMVFUmxMz2Tdhml2JWvLX5BjKtryyo1Qv1v0AZFu?=
 =?us-ascii?Q?/PSoX4DE/BrjkkTalbOh9+yWbykmr0D0Hl/QcO4JgGenDEYhtum9hPqAc10M?=
 =?us-ascii?Q?njToW7lHUk3Zt9SQnv9+MAvjnZHbt31q/nA0pAKRFuVG8wjplmN8JvWcNsCw?=
 =?us-ascii?Q?kacvk9m9GwO+OuObti0XZQfxLco9I9ih48bQPHF2rE6eTHZ7DDamnJ2mg61w?=
 =?us-ascii?Q?2hAm7JwsZX93IBPT89ZcbnATQr7Ntgltmbww5sWeqTcBWbnEo/Y4kvgWScQJ?=
 =?us-ascii?Q?8l/ncpMLS5fM2RZVpXQT0lXbIOdZYzOE0sH0Z+MSsSu6qvm8tlIlrEbAMU+l?=
 =?us-ascii?Q?oogKGSg90V3BjGf3ZHMztB+Uhi7qZwnKYDSP9ttsm/86fKUeBsekdDb/5tFx?=
 =?us-ascii?Q?spVlPPxd8D63uj5sYFRYA3XtOqpsmuwGzDaHl3vNJOPTu9sxtnxPo+zX7/At?=
 =?us-ascii?Q?h8cj5918rAsUowVdDz/ZR2DV+ijh8TvDBda4OcnS8+a3J+OX0/mEUgKJ81g4?=
 =?us-ascii?Q?MAyGAEZg8M5GWpTL/nmz5C3lY0P2KzehTLXHcNZMmANF94QmGLSEXEiEhBF/?=
 =?us-ascii?Q?Ok2XO1maLZe0pF/tjsjZtwI0KTfyWKbW7p5PydXBtn2/pNGsUPQMzsU+f0kl?=
 =?us-ascii?Q?gDkrnQSzSy8EUYsd3+FkFPVMHV5oMZmbNGenrsQhAi+aZCh47kaLzch5Jsb3?=
 =?us-ascii?Q?rcH1dA3Q+RRP2bvcYCEUgoJ//RjeCIgRbjKwj+YEi9OupaHTbbczXL0mHa0o?=
 =?us-ascii?Q?6F+hRGMlwKI6quVeSeZrUKVYTvEawvrQwLkCZBV6THBuTopdJ39es9HaqfVr?=
 =?us-ascii?Q?kMhb3Gne2vPSWQDuNYhREccqcCNdpCqn58AzCwWRNAH30Q45GajN1p1wBP0A?=
 =?us-ascii?Q?3cFt13ciaDNCrkXf9d8MS20MAZjy1fo/bJx51++eRZIH7Irzp4S6C2lv4hpm?=
 =?us-ascii?Q?vMPVWm+HrMsaDVEq1nnbIPDz/v3YyrrYzeyg33lpLX6HJA+KEcY4HIQJnINl?=
 =?us-ascii?Q?cZocQo3hr7qaXrg3XaJo3qW/JBjGl3PhXLtun8SNqn18taFxkEu8ZpW2x485?=
 =?us-ascii?Q?cw2OJD6aRFFfUjdvk8Bu30RTVuH2Iko0E9oVO3yrCa8h87VtPxHJPE+KT/HF?=
 =?us-ascii?Q?/W+Jfr6JTq0XnvuqokNbmr1ciMQGiT2DhzBlk8EyabCDSeuuaHkb6CnofQ25?=
 =?us-ascii?Q?qpNiX8hDiLMCa02FUalx6xpk2PM/u/lmR8y007Xjae2bnS1O7zaBfc44MJTE?=
 =?us-ascii?Q?vDrOn79TnuSKet7PR4=3D?=
x-microsoft-antispam-prvs: <VI1PR10MB24480BD06C92C6B313E8107CF5720@VI1PR10MB2448.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(55016002)(68736007)(53936002)(6436002)(486006)(76176011)(106356001)(8936002)(81156014)(81166006)(8676002)(9686003)(2906002)(26005)(102836004)(7736002)(305945005)(229853002)(33656002)(86362001)(186003)(476003)(74316002)(53546011)(6506007)(105586002)(11346002)(446003)(97736004)(4326008)(25786009)(256004)(4744005)(478600001)(66066001)(71190400001)(71200400001)(6246003)(14454004)(5660300002)(110136005)(54906003)(316002)(99286004)(6116002)(3846002)(14444005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2448;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mpKgI0K73kMYQPBgI5kvdUsIg2FUoynkg9/Kf0XsLdi4lu7McLsHg4BzzRoGVMZe3wRbnM1FvVk9kdI/OMwtJtd/4+PoyAV4lOhF0AGol64U9p0N7x6vbgtNauuz0vUvMuQKD8mB4Uc/IksrEo9heqjHANc5wEQTFw21Dca8E67xdDMeKqRtF9bblwauyUfMjOJJgyeO0CzUDnYWR4EUXFSsoBtanIeudZ3bnO40kRKkliwTgS+5nVqMutAPHmk/8gORn3kquXGietZNiqO0qwLFmvSFJwX6kSg9JeSfOW3M1/AnaLCQuHAEfY8MsNOjLdm4Tzkdwl+k36WaZJ7zPexUsylwM6RpjuSAakbNKq4a09JJjz0yra7omVSUrqopSlzbtn/XDYua02D22XTwlHGPlxzKwcb7YDJETG7/yLo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb85143e-25ce-41f1-8b6b-08d6a151c518
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:03:08.8765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 March 2019 13:16, Axel Lin wrote:

Hi Axel,

> To: Mark Brown <broonie@kernel.org>
> Subject: [PATCH 2/2] regulator: da9063: Convert to use
> regulator_set/get_current_limit_regmap
>=20
> Use regulator_set/get_current_limit_regmap helpers to save some code.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/da9063-regulator.c | 107 +++++++--------------------
>  1 file changed, 28 insertions(+), 79 deletions(-)

Thanks again,

Acked-by: Steve Twiss <stwiss@opensource.diasemi.com>

Regards,
Steve

ps.

This patch applies to next-20190305.
But doesn't cleanly apply cleanly to v5.0, I guess because there are severa=
l patches
queued up in linux-next, in the same way as the da9062 patch has minor issu=
es for v5.0.

Hunk #4 FAILED at 131.
Hunk #7 FAILED at 850
2 out of 7 hunks FAILED -- saving rejects to file drivers/regulator/da9063-=
regulator.c.rej
