Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C527EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BFA20818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="n+9+4dsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfCAMDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:03:13 -0500
Received: from mail-eopbgr1400124.outbound.protection.outlook.com ([40.107.140.124]:35098
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbfCAMDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGiuni9977cVA3YIVyDyvPu/UMQjFarYlomOmwl2wSc=;
 b=n+9+4dsXnc8EOhYTS2Yt0yAZ76KNsb5JJRPkV1NvUroPuhvrtpGH3zGa7YeGx6Bi1Z4FKHMANkDChU415jz9FFqg/Jk/njEjmFBNAblN+8+OaouolFA6L+Lg4VBMUTeuPnUJR4kNg7S3ZIu2LGIdz+AT9VKNG3CDrAnmq1/7Huw=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1535.jpnprd01.prod.outlook.com (52.133.166.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Fri, 1 Mar 2019 12:03:07 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 12:03:07 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Simon Horman <horms@verge.net.au>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiharaml@si-linux.co.jp" <ebiharaml@si-linux.co.jp>,
        Lukasz Majewski <lukma@denx.de>
Subject: RE: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Thread-Topic: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Thread-Index: AQHUrcqn7iCjVkUVBUihzBp2UqLnOqXfpZYQgAD02QCAACZkAIAWMKTg
Date:   Fri, 1 Mar 2019 12:03:06 +0000
Message-ID: <TYXPR01MB1775ECF6D79FCA2C0040DA06C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB1770A46D7FA45A8AFA923DADC0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20190215075226.413d55dc@jawa> <c2eb829b-96a7-20cb-913f-ce4214f2156c@suse.de>
In-Reply-To: <c2eb829b-96a7-20cb-913f-ce4214f2156c@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 644f6e3d-148d-4369-7f65-08d69e3dddc7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1535;
x-ms-traffictypediagnostic: TYXPR01MB1535:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1535;20:u08jSO4RuaMbo2R6DP4uvOnN2mr1oZMtm6FLoOPuNJfs96iEoM45eHpZSoJgFEsf4dve5e576fs0lT/3IRxCM1PIdl1sOumsTq1jO8CggHfqilufgoufB5CQbYWlikr6Gldv54qyQHHcvSPVVCvk23Rjv9fFmygFygOLH6/iFCw=
x-microsoft-antispam-prvs: <TYXPR01MB153523BB83A1FBED9158658EC0760@TYXPR01MB1535.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(106356001)(11346002)(446003)(52536013)(186003)(66066001)(7736002)(305945005)(8936002)(486006)(68736007)(476003)(44832011)(7416002)(74316002)(86362001)(25786009)(81156014)(81166006)(97736004)(256004)(8676002)(5660300002)(3846002)(6116002)(71200400001)(71190400001)(4326008)(53936002)(6306002)(102836004)(26005)(7696005)(76176011)(9686003)(93886005)(53386004)(229853002)(55016002)(316002)(54906003)(110136005)(6436002)(6246003)(33656002)(99286004)(105586002)(53546011)(6506007)(2906002)(14454004)(478600001)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1535;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aEtn4I2uM8G0UJxCgFwvuG21PuX40V8LblODEE3ZjRsHNsXvzsuiDfDe1kTJJbFP5w5/qLSBhnVrPuP/TqdppjfPCr5HJH9OK6dhHxNFPE6NjWce4gm+NJiP5Axdp53cFZNibFOduqJaYj5Lh8GopC7vTACwQI97DyNsTHZ11TYsVFK6mUmvXpvxVTRHFjvBqQws5LebU5TIpu2azVYuOxpbPzAkeYy1Eia3hXcczt4kc8BoekeQT49rj/yrx1yz4iHKpTQBd85uEFNfFD11RmDScHPCxF7b2JQKpForwg5JUsYVnaMS1KAupMCqY3KBFyFtA6SH5I5m3xVhfCdQC9nEYkqCfUaDfcTopXQ2sAbK27UJKfWWyr1pF49jjcyBiFqqUgWo1Y0S3O9+EmLjm+CJzPb8ht0yO1tT7F8r3rs=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644f6e3d-148d-4369-7f65-08d69e3dddc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 12:03:06.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1535
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Andreas.

> From: Andreas F=E4rber <afaerber@suse.de>
> Sent: 15 February 2019 09:10
> Subject: Re: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Lin=
ux.
>=20
> Hi Lukasz and Fabrizio,
>=20
> Am 15.02.19 um 07:52 schrieb Lukasz Majewski:
> > The best approach is to run:
> >
> > git format patch -1 <your patch sha>
> >
> > And then
> >
> > scripts/get_maintainer.pl 0001-xxxxxxx
> >
> > You shall see the the list of people to send the patch.
>=20
> No, that does not answer his question. And please don't top-post.
>=20
> >> Who is the best person for taking this patch?
>=20
> The answer is: whomever is taking dt-bindings patches in the following
> 10 patches that make use of this prefix, once you have a Reviewed-by
> from Rob. So, most likely the Renesas kernel maintainer(s), i.e. Simon,
> which differs from get_maintainers.pl of vendor-prefixes.txt.

Simon, do you think you can take this patch?

Thanks,
Fab

>=20
> Regards,
> Andreas
>=20
> >>> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >>> Sent: 16 January 2019 18:38
> >>> Subject: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon
> >>> Linux.
> >>>
> >>> From: Biju Das <biju.das@bp.renesas.com>
> >>>
> >>> Add Silicon Linux to the list of devicetree vendor prefixes.
> >>>
> >>> Website: http://www.si-linux.co.jp
> >>>
> >>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> >>> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >>> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> >>> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> >>> 4b1a2a8..02a7037 100644 ---
> >>> a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
> >>> b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -344,6
> >>> +344,7 @@ sgxSGX Sensortech sharpSharp Corporation
> >>>  shimafujiShimafuji Electric, Inc.
> >>>  si-enSi-En Technology Ltd.
> >>> +si-linuxSilicon Linux Corporation
> >>>  sifiveSiFive, Inc.
> >>>  sigmaSigma Designs, Inc.
> >>>  siiSeiko Instruments, Inc.
> >>> --
> >>> 2.7.4
> >>
> >>
> >>
> >> Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael
> >> Hannawald, Sitz der Gesellschaft/Registered office: Duesseldorf,
> >> Arcadiastrasse 10, 40472 Duesseldorf,
> >> Germany,Handelsregister/Commercial Register: Duesseldorf, HRB 3708
> >> USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE
> >> reg. no.: DE 14978647
> >
> >
> >
> >
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> >
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.d=
e
> >
>=20
>=20
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=FCrnberg)
