Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666EF20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="JD3S1C9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbfCAQg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:36:59 -0500
Received: from mail-eopbgr1400090.outbound.protection.outlook.com ([40.107.140.90]:33427
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728517AbfCAQg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HewLh+G4Pz1E+uDS72qXtqTEjC3nwRTDkQuSTfLiJ6U=;
 b=JD3S1C9Pyh7GIUe83HVEIMXlFwUu3wxlAzC3vqeHQlvFeHZSCqm+V6EUkdR6ljL3kviC8KpvPCq31sI9NcX+VvCeE+sGxn8kQ3HuvXqWopLxvt/tR+JmiY5G9F48AeRHEg5oH2Qq+AG4De9QP9ibYuPXczq6VU/t9Z1FoMA+MPw=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1888.jpnprd01.prod.outlook.com (52.133.169.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 16:36:52 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:36:52 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Thread-Index: AQHUkyFpi/45UrthxEeTw5QuFUj6AaX3HGuggABRjACAAAQ+0A==
Date:   Fri, 1 Mar 2019 16:36:52 +0000
Message-ID: <TYXPR01MB17756DBAF2FD7A1F2A9B82B0C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TYXPR01MB1775A4A3AF86097F284C4A08C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <20190301161624.GA19937@kroah.com>
In-Reply-To: <20190301161624.GA19937@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e381ad49-cc13-4dce-0a47-08d69e641c1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1888;
x-ms-traffictypediagnostic: TYXPR01MB1888:
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1888;20:D47Nj5t80BQ72tHejK82DIltFN/KQRlaCBFf7T4dnWD1zg2du1l3absRcyginf2+jPNP36L+MDDqb2lxXUTcNzr4MKqAeYgxSDJTlCXwVKUfP0wFWyr8kpwjs9kNVFcU21PHpAgiccp6Ox7TOq4O9A4vi8f028BmxeNgAbJBFFw=
x-microsoft-antispam-prvs: <TYXPR01MB18880B6E62CA246039C5EEBDC0760@TYXPR01MB1888.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(189003)(5660300002)(52536013)(478600001)(6436002)(229853002)(68736007)(14454004)(2501003)(74316002)(7736002)(305945005)(55016002)(8936002)(9686003)(4744005)(81166006)(8676002)(81156014)(66066001)(2906002)(7696005)(71190400001)(33656002)(71200400001)(4326008)(476003)(11346002)(105586002)(76176011)(446003)(486006)(44832011)(99286004)(6116002)(25786009)(256004)(3846002)(54906003)(110136005)(316002)(53936002)(97736004)(7416002)(106356001)(6246003)(86362001)(102836004)(6506007)(186003)(53546011)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1888;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8m53GT7t/eOCW8VhwMrZ5mDIBEsTmjaFGIM5aYvcjaov0bCo/jp0s0UJrjHUo7pB+2UIlzJnk0+dHSd/PCnxVCh53cc+rgIVW/4Z4jnR4VHXCwz17XMMIA8lqffqH27r1cDzSBlOy24zB0/7jxTPWb0meS7NXi3q1GUGAJzXKsPvfGUJYAdZ5ZicZ+0EDwRRYTXGyPQ6W75YPPCeKeapz/RfcbtY1S1gJ01n7lDHxiOPhyT8f/GMgX0/qWhKA2yrwNZIo3OtMW54fsp6GWhMbrFAG0MdVf90O7bOLE1GnXvsCL9OeLTpQfjWd8TzW+75S6/dH3FjIttUPHU9clFQc5V3EvYN9VOdr9ei6xmKRcjsOdihUmCM1lujOJreH2FpBSY68uC7TQ8mfztEhZiD2rOCXXvI5n/U3oYVs5faFP4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e381ad49-cc13-4dce-0a47-08d69e641c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:36:52.3171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1888
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Thank you for your reply!

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: 01 March 2019 16:16
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@v=
ger.kernel.org; Simon Horman <horms@verge.net.au>;
> Geert Uytterhoeven <geert+renesas@glider.be>; Chris Paterson <Chris.Pater=
son2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; linux-renesas-soc@vger.kernel.org; Rob Herring=
 <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>
> Subject: Re: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
>=20
> On Fri, Mar 01, 2019 at 11:25:33AM +0000, Fabrizio Castro wrote:
> > Hello Greg,
> >
> > I am sorry to bother you.
> > Do you think you take this patch?
>=20
> device tree bindings need an ack from the DT maintainers before I can
> take them.  Also, this is for xhci, the xhci maintainer is responsible
> for those, not me :)

I am so sorry.

The patch has been reviewed by Geert Uytterhoeven, Simon Horman, and Rob He=
rring already.

Mathias, are you the one taking the patches for Documentation/devicetree/bi=
ndings/usb/usb-xhci.txt now?

Thanks,
Fab

>=20
> thanks,
>=20
> greg k-h
