Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AAA2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CAiMbj4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfCZOGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:06:20 -0400
Received: from mail-eopbgr790052.outbound.protection.outlook.com ([40.107.79.52]:57782
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfCZOGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGIF2VG8TbvMO4b+p6y7PK3o970F4mtD1P/gKilqSks=;
 b=CAiMbj4ozRBdC5mNIMBAniaIc5AirFpeDYh3YFWNWv39DprfbxuSCOWJqeZMZqgPX8hgDg2+aa9ryCEj9pngOumLFFy6cNMU7JLQ+hUg0vLbGXrKc88DdsnjOZf0GsUn6eeio27621zt0tL5fuInmj6KQop6yYf6ALYa6GowwvM=
Received: from SN6PR02MB4719.namprd02.prod.outlook.com (52.135.113.216) by
 SN6PR02MB4670.namprd02.prod.outlook.com (52.135.113.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Tue, 26 Mar 2019 14:06:16 +0000
Received: from SN6PR02MB4719.namprd02.prod.outlook.com
 ([fe80::f449:86be:6ecf:898f]) by SN6PR02MB4719.namprd02.prod.outlook.com
 ([fe80::f449:86be:6ecf:898f%3]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 14:06:16 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "atull@kernel.org" <atull@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Thread-Topic: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Thread-Index: AQHU2m6UH4Q3vc2IFU2R2umKlRcctqYcykiAgAE5G1A=
Date:   Tue, 26 Mar 2019 14:06:15 +0000
Message-ID: <SN6PR02MB47194C1EEA9BDD8F3FE61B75C25F0@SN6PR02MB4719.namprd02.prod.outlook.com>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
 <20190314140122.23372-7-nava.manne@xilinx.com> <20190315235422.GA29658@bogus>
In-Reply-To: <20190315235422.GA29658@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0bafae-cba1-48c8-f793-08d6b1f43652
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4670;
x-ms-traffictypediagnostic: SN6PR02MB4670:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB46700328173B604E9C2BC7E4C25F0@SN6PR02MB4670.namprd02.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39850400004)(376002)(366004)(396003)(51914003)(199004)(189003)(13464003)(5660300002)(11346002)(6116002)(76176011)(14454004)(2906002)(6916009)(7696005)(8676002)(478600001)(229853002)(9686003)(81166006)(97736004)(55016002)(53546011)(53936002)(186003)(81156014)(33656002)(6246003)(3846002)(66066001)(99286004)(316002)(52536014)(8936002)(54906003)(305945005)(26005)(74316002)(106356001)(71200400001)(105586002)(71190400001)(6506007)(86362001)(7736002)(102836004)(446003)(486006)(6436002)(256004)(68736007)(25786009)(476003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4670;H:SN6PR02MB4719.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 64RNqjzJaGuJgfJZe9OScP1wuay29PS3oPRyJlOZZS+PoQonnJ5An/IamvGrX1vvgssusktxHe7Tl9uqy/6b2HT1BFw5euFYR4Rxcvz/ibwKim12Ai634aHPA5vjKEOi6cUO/gTwnAqViwltvgBMxCrlOxzQwFLxEgCrngRLYYNh3P7JvbZF7jWBYIN0fqIUl5piicivZy+hZh+UZBbddVuUTgrSF/6XhmZBXci2HikuqyfxXk9yXvv2bCN8qow+J5fn1cxFWhEoBH6y8r3kbgXibao2jJ7xAyQk6wO93oLrot+X69k+d3l888fzI7VAmFTOQfWtF5p3rmCMprXrfWxLYQJI1vwutJcRmrWs/KP/DKZKIPG40VN2TjBrcYKbiWkeusu1vxSvRxIjZJqGEeiiT97/3YZlgWLmsGZEQ8Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0bafae-cba1-48c8-f793-08d6b1f43652
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 14:06:15.9726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4670
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

	Thanks for the response.
Please find my response inline.

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, March 26, 2019 12:49 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: atull@kernel.org; mdf@kernel.org; mark.rutland@arm.com; Michal Simek
> <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; linux-fpga@vger.kernel.org; devicetree@vger.kernel.o=
rg;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> chinnikishore369@gmail.com
> Subject: Re: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fp=
ga
> driver
>=20
> On Thu, Mar 14, 2019 at 07:31:22PM +0530, Nava kishore Manne wrote:
> > Add documentation to describe Xilinx ZynqMP fpga driver bindings.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v4:
> > 		-Modified binding description as suggested by Moritz Fischer.
> > Changes for v3:
> >                 -Removed PCAP as a child node to the FW and Created
> > 		 an independent node since PCAP driver is a consumer
> > 		 not a provider.
>=20
> Huh?
>=20
> It was the fpga-regions that I suggested should perhaps be at the top-lev=
el. As
> long as pcap is a function exposed by the firmware it should be a child o=
f it.
>=20
Thanks for providing the clarification. Will address the above comments in =
the next version.

Regards,
Navakishore.
