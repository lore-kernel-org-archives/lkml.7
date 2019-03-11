Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D50C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="UWrInVOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCKLu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:50:59 -0400
Received: from mail-eopbgr1410105.outbound.protection.outlook.com ([40.107.141.105]:18176
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbfCKLu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Co6VGoryjPbMRhAJ8mlUvRo0GlyUqoc3yPbxDhYtU2c=;
 b=UWrInVOXv89cxKOmrJg/Wo6EyrMcvzbhZYh9vulqLwu7fwg7uct9n2yzSrtUJ78Q0hFowD5UY1lCgci6mgJu/7k5MryGtAggtcLNI1xVjxzONJt3dFT751UQTvZPjdrsbaEo9UevgBO88xwWfTe/UGBh3P5/YH22yEpvfZhVHx0=
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com (20.178.139.140) by
 TYAPR01MB3071.jpnprd01.prod.outlook.com (20.177.104.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 11:50:55 +0000
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::4c6e:195:8a7f:bc73]) by TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::4c6e:195:8a7f:bc73%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 11:50:55 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt: snps,dw-apb-ssi: Add clock bindings documentation
Thread-Topic: [PATCH 1/2] dt: snps,dw-apb-ssi: Add clock bindings
 documentation
Thread-Index: AQHUz2lNX0M8aoex20qIKuy9AOBuh6X6k7SAgAvK+pA=
Date:   Mon, 11 Mar 2019 11:50:55 +0000
Message-ID: <TYAPR01MB401574D8B0996378DCD5DC97DF480@TYAPR01MB4015.jpnprd01.prod.outlook.com>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551360342-23981-2-git-send-email-gareth.williams.jx@renesas.com>
 <20190303233145.GN23441@sirena.org.uk>
In-Reply-To: <20190303233145.GN23441@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e919a103-a5a1-4671-b6c2-08d6a617d1fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB3071;
x-ms-traffictypediagnostic: TYAPR01MB3071:
x-microsoft-exchange-diagnostics: 1;TYAPR01MB3071;20:r2dC85IEOmzI1Stv07/LucxSpLyMdtsp/bEzJPfRkAGheL33YDVM00ZpVXuA96g9PV9P8dvs3XN2EnEEinXsCUSmjUh2rkq2ixVav2v+M1AZYdslfp56p51hTQDQUTwtncaTXt53HEw6nuEntx3pu6oWcaAKYAiCVLlkDxjKtEw=
x-microsoft-antispam-prvs: <TYAPR01MB3071423F0C6DCD367FD1E818DF480@TYAPR01MB3071.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(136003)(396003)(366004)(51914003)(199004)(189003)(4326008)(25786009)(186003)(9686003)(102836004)(68736007)(66066001)(476003)(11346002)(229853002)(256004)(8676002)(6436002)(97736004)(81156014)(81166006)(71190400001)(71200400001)(33656002)(446003)(478600001)(2906002)(6916009)(86362001)(316002)(105586002)(106356001)(74316002)(53936002)(6116002)(6246003)(5660300002)(3846002)(54906003)(55016002)(26005)(486006)(8936002)(7736002)(4744005)(305945005)(14454004)(76176011)(52536013)(7696005)(99286004)(53546011)(6506007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3071;H:TYAPR01MB4015.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4K1cAmJiTkr51nDTw9dillH3O2mqCK32sPPTTPZtpatSqeJ81DM11Ji8/wBvN3y2/J5A9JO6kIbkA7mSsmvnW3Pg4UVosz3e7Nl6ECqjrk/3kLgi9CJebDPUwKEpnLa5t20MNOL+31kphHys7VAqXhj53BTgOeNsrQwznM25S91wlwtOI5vvP4junYQCNQSYJubS2x95rIenJ0/bY3XVwwUIO0zYHW/D54S8BinnZDZKMNdk6Hf5kdiKQ2R+DSm0c+JeTOJ9zIgElvHke0D+PYhjfsyFrGMJIUgBiceLP+vr08FiJ5RFoo5nF36MWVqcDAUvhE/GSvHWUWIx6l8FF1g0n7O/lQZC3i4daZP2grbG+HdYOWy7q2XhaVE9sOIt1gWS71wLFy13a8H3nia+tNfDFjt7onmHiOONBL3dGZc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e919a103-a5a1-4671-b6c2-08d6a617d1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 11:50:55.5612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Mar 03, 2019 at 23:32 +0100, Mark Brown wrote:
> > On Thu, Feb 28, 2019 at 01:25:41PM +0000, Gareth Williams wrote:
> > From: Phil Edworthy <phil.edworthy@renesas.com>
> >
> > The driver requires a clock property, so detail it in the docs.
> > Fix a typo, 'pis' to 'pins'.
> > Add documentation for a separate, optional, interface clock.
>=20
> Please use subject lines matching the style for the subsystem.  This make=
s it
> easier for people to identify relevant patches.

Thanks for the feedback Mark.
I will wait another week to see if there is any other feedback before sendi=
ng an updated version of this patch series.
