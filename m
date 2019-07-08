Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9DEC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EE42086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sxOtZW76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfGHSsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:48:22 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:22758
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbfGHSsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rw3c0lYfhYGbU92as2KehSCWfz5+bp2FLqc/x8iIhc=;
 b=sxOtZW76JnVhrsDTviJL9R3z/aUSNNM4QVUFZhs/YOO0X6M6NX1D5pljworojarLqHloAzju43NLew3W/vuF/BiVKa3xVKKZke4FN5y9D/r2dYtwd5EXzu9rvRljdw7iTPkW5otMjT26tnul7LLRVOlgESiJ1gOSFqiljf0te9A=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.235.152) by
 VE1PR04MB6672.eurprd04.prod.outlook.com (20.179.235.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 8 Jul 2019 18:48:17 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::358c:d36c:4f8:db79]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::358c:d36c:4f8:db79%4]) with mapi id 15.20.2052.010; Mon, 8 Jul 2019
 18:48:17 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "soc@kernel.org" <soc@kernel.org>
Subject: RE: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
Thread-Topic: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
Thread-Index: AQHVJQRRM+rvlXmln0KUqEroTyzJyqaf1DJAgCFaZTA=
Date:   Mon, 8 Jul 2019 18:48:17 +0000
Message-ID: <VE1PR04MB668750E96558796A2E81DB678FF60@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20190605194511.12127-1-leoyang.li@nxp.com>
 <20190617114948.7xxtpivve52c2jnb@localhost>
 <VE1PR04MB668773AB42154134CE18A6AB8FEB0@VE1PR04MB6687.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB668773AB42154134CE18A6AB8FEB0@VE1PR04MB6687.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b85f1e69-d2d2-450d-09b7-08d703d4d775
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6672;
x-ms-traffictypediagnostic: VE1PR04MB6672:
x-microsoft-antispam-prvs: <VE1PR04MB6672175C1F997916169970C88FF60@VE1PR04MB6672.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(13464003)(199004)(189003)(9686003)(71190400001)(6436002)(55016002)(86362001)(71200400001)(229853002)(5660300002)(76176011)(53546011)(6506007)(53936002)(26005)(6246003)(305945005)(7736002)(186003)(81156014)(8676002)(8936002)(25786009)(476003)(81166006)(486006)(11346002)(6916009)(6116002)(99286004)(446003)(4326008)(3846002)(7696005)(68736007)(102836004)(14444005)(256004)(74316002)(66446008)(64756008)(66476007)(66066001)(66556008)(66946007)(33656002)(73956011)(15650500001)(2906002)(478600001)(76116006)(316002)(14454004)(54906003)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6672;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ysCIHcd3Mg+gz9teEzJ6RHH4Qfy9AC00en/UkHDcoIN7ivTKboB7/YLgyOz6YNclMojLpDRd1H9aXVwAqmJ0SPTqfyONqjJtUhPGd1UQchnkTlPg2DxZXLPDwfypZhrzDcM0Ym1e2zoulssDnu2wKhQSB2mQzG+aqXeZ08wHwjoBI2BVIbXQFhQatfDn5qga8Fmo/tdTjMBAlpywTeFGlcLjRH/GjgnQj9fGEPjZ5VSfecA6cSlXEfqJjOBZYQestCntVOmfwVLlVtqgWE8tUi6bTjt+etWerT+id30EPef6+cPV0gzZvAevcZOZ7UK1akNnTrLHKcLDAEwxUh64dCONeYiNCTg1ZoDhoCcPZ7EmQFdLskkrnzMgfweOZohF7EKzNl5d7e4W/kKF28R1BLRrioex4BK0UaorchOghBY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85f1e69-d2d2-450d-09b7-08d703d4d775
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 18:48:17.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leoyang.li@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Leo Li
> Sent: Monday, June 17, 2019 8:29 AM
> To: Olof Johansson <olof@lixom.net>
> Cc: arm@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; shawnguo@kernel.org
> Subject: RE: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
>=20
>=20
>=20
> > -----Original Message-----
> > From: Olof Johansson <olof@lixom.net>
> > Sent: Monday, June 17, 2019 6:50 AM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: arm@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; shawnguo@kernel.org
> > Subject: Re: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
> >
> > On Wed, Jun 05, 2019 at 02:45:11PM -0500, Li Yang wrote:
> > > Hi arm-soc maintainers,
> > >
> > > This is a rebase of patches that missed 5.2 merge window together
> > > with some new patches for QE.  Please help to review and merge it.
> > > We would like this to be merged earlier because there are other
> > > patches depending on patches in this pull request.  After this is
> > > merged in arm-soc, we can ask other sub-system maintainers to pull
> > > from this tag and apply additional patches.  Thanks.
> >
> > Li,
> >
> > You never followed up with a reply, or removed, the previous tag. So
> > when we process the pull requests that come in, we've already merged it=
.
>=20
> Sorry about that.  Will reply the previous pull request and remove the ol=
d tag
> if update is needed next time.
>=20
> >
> > So, I've merged the previous version. Can you send an incremental pull
> > request on top of that branch/tag instead of a rebase like this was, pl=
ease?
>=20
> Actually the new pull request is based on the old pull request this time.=
  I
> sent the new one as V2 hoping that you can see this first and avoid mergi=
ng
> two times.  Since you have already merged the first one, you can merge th=
e
> second pull request as an incremental pull request directly.

Hi Olof,

I was on vacation for the past two weeks to follow up on this.  Hope this i=
s not too late for this merge window.  Like I mentioned, the new tag is on =
top of the previous tag (you merged) so that it should be able to be merged=
 incrementally.  The only thing is that the description of the new tag also=
 included patches you merged with old tag.  Do you want me to regenerate th=
e tag before you can merge it?

Regards,
Leo
