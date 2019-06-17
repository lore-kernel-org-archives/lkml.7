Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F1C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E18720657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IMaulPYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfFQN2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:28:54 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:16345
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfFQN2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXdEZOOKnezUzKmpFBaKWBJGd3nS04aFoTGg5T7Yass=;
 b=IMaulPYz1qZO9sxXIE33umTn91jfoosTLnsOv2rmpe9f7BAVLGqb8fTM/6O7CFkh3R1b7RBGRuRhwcpuLjVlC5UEEGjuqtwo3tNeqV8fqPA/MM1tI8NOmFJB0LRBRNY1dvTWhZFruou/TXzdNWjXwa8pvvDxFJK/dx71iM0UObg=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.235.152) by
 VE1PR04MB6734.eurprd04.prod.outlook.com (20.179.234.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Mon, 17 Jun 2019 13:28:50 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::9e6:e136:4c09:fe67]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::9e6:e136:4c09:fe67%5]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 13:28:50 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
Thread-Topic: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
Thread-Index: AQHVJQRRM+rvlXmln0KUqEroTyzJyqaf1DJA
Date:   Mon, 17 Jun 2019 13:28:50 +0000
Message-ID: <VE1PR04MB668773AB42154134CE18A6AB8FEB0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20190605194511.12127-1-leoyang.li@nxp.com>
 <20190617114948.7xxtpivve52c2jnb@localhost>
In-Reply-To: <20190617114948.7xxtpivve52c2jnb@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1941167b-0928-4a26-9881-08d6f327bbf3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6734;
x-ms-traffictypediagnostic: VE1PR04MB6734:
x-microsoft-antispam-prvs: <VE1PR04MB67340C2E09B0606C1D9429728FEB0@VE1PR04MB6734.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(13464003)(199004)(316002)(7736002)(8676002)(53546011)(305945005)(14444005)(256004)(76176011)(6916009)(2906002)(6506007)(6436002)(478600001)(102836004)(26005)(55016002)(73956011)(76116006)(7696005)(4326008)(229853002)(25786009)(54906003)(71200400001)(9686003)(99286004)(66446008)(53936002)(186003)(6246003)(71190400001)(5660300002)(15650500001)(68736007)(14454004)(66946007)(52536014)(66556008)(66476007)(3846002)(6116002)(86362001)(64756008)(33656002)(11346002)(66066001)(446003)(486006)(476003)(8936002)(81166006)(81156014)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6734;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7M5msL7QeM2Q3txSLahmjLTuBD6OXB2ZwHcHFIzdGcDWXStkAFr2k1IH6G41dhVix9eW+C+IvIsiGiYRVhWtlWAv2umevBd2FJohRY0QDeSTt+3RW4qzPoVSheAjwGwikE7XtM1UpXZ3FLqBcSa5o2yMPHoatwMytlSRcV7VX6XHIDV8DUlZnMEkx4Kljir4In06RnXWuU6ccQUKK+MnQE2eplQ/f7rW49jvYGMwZnKHuMQpiPFcIK/aim3gGgLJ/+BbI/2rL7mqMcivQI+90VIHVMNg1yXLf9uIKN5XLFF9wC9X3rg3AZxCWloQQ2NOWBoqmv2ww9R80q2jjCjmtaiUYSD8Dc58eShLGVLnfcfNIp3+ScOkPA6B8DDU5tHR3HYilTGLKfpaN4k356s7S8p0W/KeuLirwZfm3sfUfk4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1941167b-0928-4a26-9881-08d6f327bbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 13:28:50.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leoyang.li@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Olof Johansson <olof@lixom.net>
> Sent: Monday, June 17, 2019 6:50 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: arm@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; shawnguo@kernel.org
> Subject: Re: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
>=20
> On Wed, Jun 05, 2019 at 02:45:11PM -0500, Li Yang wrote:
> > Hi arm-soc maintainers,
> >
> > This is a rebase of patches that missed 5.2 merge window together with
> > some new patches for QE.  Please help to review and merge it.  We
> > would like this to be merged earlier because there are other patches
> > depending on patches in this pull request.  After this is merged in
> > arm-soc, we can ask other sub-system maintainers to pull from this tag
> > and apply additional patches.  Thanks.
>=20
> Li,
>=20
> You never followed up with a reply, or removed, the previous tag. So when
> we process the pull requests that come in, we've already merged it.

Sorry about that.  Will reply the previous pull request and remove the old =
tag if update is needed next time.

>=20
> So, I've merged the previous version. Can you send an incremental pull
> request on top of that branch/tag instead of a rebase like this was, plea=
se?

Actually the new pull request is based on the old pull request this time.  =
I sent the new one as V2 hoping that you can see this first and avoid mergi=
ng two times.  Since you have already merged the first one, you can merge t=
he second pull request as an incremental pull request directly.

Regards,
Leo

>=20
>=20
> Thanks!
>=20
> -Olof
