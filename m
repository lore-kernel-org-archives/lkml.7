Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E676EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43EB218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="YFq/y6nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfDWPdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:33:12 -0400
Received: from mail-eopbgr1410091.outbound.protection.outlook.com ([40.107.141.91]:23832
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728233AbfDWPdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btV+4wVfNK+RICVcYqeNcrjRr73WOr6ctgUm06WXJSs=;
 b=YFq/y6nYWxhieP4IUoNDHaLwO6XzKq+v8LE7FGEBdaaOtSxfF7telOFbnhyYcBrW/M8ak/tBF8DZwvG4eoBmuOx/cvSGskiXC3JAXdX50RJBtw6Wm0ks7xfDpeiwTOXhqvdejlkHb62xnoNEgT5txDRWHqn0M0xhvgHvW2bhj/4=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.13) by
 TY1PR01MB1465.jpnprd01.prod.outlook.com (52.133.160.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 15:32:59 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::60bb:89e4:1a58:e901]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::60bb:89e4:1a58:e901%2]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 15:32:59 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Thread-Index: AQHUkyFpi/45UrthxEeTw5QuFUj6AaX3HGuggABRjACAAAQ+0IBTOpfg
Date:   Tue, 23 Apr 2019 15:32:59 +0000
Message-ID: <TY1PR01MB1770DB45DCD263C6933B9210C0230@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TYXPR01MB1775A4A3AF86097F284C4A08C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <20190301161624.GA19937@kroah.com>
 <TYXPR01MB17756DBAF2FD7A1F2A9B82B0C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB17756DBAF2FD7A1F2A9B82B0C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf564180-a7da-4e0f-e28f-08d6c800f79f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:TY1PR01MB1465;
x-ms-traffictypediagnostic: TY1PR01MB1465:
x-microsoft-antispam-prvs: <TY1PR01MB146525E82364FFB0816430BAC0230@TY1PR01MB1465.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(346002)(39860400002)(376002)(199004)(189003)(66446008)(66946007)(71190400001)(66476007)(64756008)(71200400001)(14454004)(97736004)(6246003)(229853002)(256004)(66556008)(73956011)(93886005)(305945005)(7736002)(54906003)(478600001)(316002)(74316002)(6916009)(76116006)(107886003)(3846002)(6116002)(86362001)(4326008)(26005)(8676002)(81156014)(81166006)(53546011)(68736007)(6506007)(186003)(9686003)(102836004)(5660300002)(76176011)(52536014)(55016002)(7696005)(44832011)(2906002)(6436002)(8936002)(33656002)(446003)(476003)(11346002)(25786009)(486006)(99286004)(66066001)(7416002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1465;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RfilFRWzgRWaImOhEljVDnPL9wP3PxCiYALWCJ14FtDTDSHVC1zFm0HtJhjdcCo4wbGSQYSLXNfhM/CIhrbTMaY0ANdqxMlkry93G2rROa4ftuCvFQrunoHg7Jbo0AW1NOTN8vs658jjWTNdXgx1WYc4F7MVD7T2ymXY/XGtUfzUJsFRtvDfi4bkdpkZm+EAHlRyiPfvVOrNGbiW7meDAiMS/N52ddp+4Yx3tSk5fvcoqOjg4ZVZ6a+6iFNY0/U/JVdAQcyfUxFstrflHcGPOGy46pgTsrAHZJ6JRAJLtU0xYt/HzUSX0TJQMREkAIJV1d93BSlgvFA1XbLVLaNA4bt4crTG24kdfPPF5TDJK+E7cUsNBYFSD6gFuy6gHRSrXw9WOJV8w+H8BFMVoITe6JTZedreigJQBS5zr7Yp+wo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf564180-a7da-4e0f-e28f-08d6c800f79f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 15:32:59.7398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon,

I know you don't normally take this type of patches, but this one has been =
around for more than 4 months now, and I am losing hope here...

Do you think you can this patch?

Thanks,
Fab

> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf Of Fabrizio Castro
> Sent: 01 March 2019 16:37
> Subject: RE: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
>=20
> Hello Greg,
>=20
> Thank you for your reply!
>=20
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: 01 March 2019 16:16
> > To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel=
@vger.kernel.org; Simon Horman <horms@verge.net.au>;
> > Geert Uytterhoeven <geert+renesas@glider.be>; Chris Paterson <Chris.Pat=
erson2@renesas.com>; Biju Das
> > <biju.das@bp.renesas.com>; linux-renesas-soc@vger.kernel.org; Rob Herri=
ng <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>
> > Subject: Re: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
> >
> > On Fri, Mar 01, 2019 at 11:25:33AM +0000, Fabrizio Castro wrote:
> > > Hello Greg,
> > >
> > > I am sorry to bother you.
> > > Do you think you take this patch?
> >
> > device tree bindings need an ack from the DT maintainers before I can
> > take them.  Also, this is for xhci, the xhci maintainer is responsible
> > for those, not me :)
>=20
> I am so sorry.
>=20
> The patch has been reviewed by Geert Uytterhoeven, Simon Horman, and Rob =
Herring already.
>=20
> Mathias, are you the one taking the patches for Documentation/devicetree/=
bindings/usb/usb-xhci.txt now?
>=20
> Thanks,
> Fab
>=20
> >
> > thanks,
> >
> > greg k-h
