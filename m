Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E421CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA50E2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QAkq6wOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfFZOvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:51:04 -0400
Received: from mail-eopbgr820050.outbound.protection.outlook.com ([40.107.82.50]:29312
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727276AbfFZOvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkkkW/+CB6Na3iZDQtMS8RnxvyyEovSnf68WcyHsQXI=;
 b=QAkq6wOMNn6DD5VblnkT5B9RCUa1GcLG1qcKdXOH68kjZIDd+06YUo5ITOfFTUA05El6G11U+iOfjvv0sZLX/nJVeu9d1CtwtAVT0nSA+azIfVKFN6ss7wl19iqjoJ5JXUSUsT5XQiQUJYVWZkOnQVWnB41e6/y+MWReTXY+BLc=
Received: from CH2PR02MB6453.namprd02.prod.outlook.com (52.132.228.24) by
 CH2PR02MB6360.namprd02.prod.outlook.com (52.132.231.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 14:51:01 +0000
Received: from CH2PR02MB6453.namprd02.prod.outlook.com
 ([fe80::8121:11ae:9021:ba9e]) by CH2PR02MB6453.namprd02.prod.outlook.com
 ([fe80::8121:11ae:9021:ba9e%7]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 14:51:01 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the pci tree
Thread-Topic: linux-next: Fixes tag needs some work in the pci tree
Thread-Index: AQHVKQAXrs3iZJMP8Eqa1Kp5MyxBHqatufEAgABRMiA=
Date:   Wed, 26 Jun 2019 14:51:01 +0000
Message-ID: <CH2PR02MB64537BF8468954314EE077CCA5E20@CH2PR02MB6453.namprd02.prod.outlook.com>
References: <20190622234029.21fe1f27@canb.auug.org.au>
 <20190626100024.GB3391@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190626100024.GB3391@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63b2005c-292f-45ae-108e-08d6fa45b4d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6360;
x-ms-traffictypediagnostic: CH2PR02MB6360:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <CH2PR02MB636095323136478A3FD8D292A5E20@CH2PR02MB6360.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(366004)(396003)(376002)(39860400002)(136003)(53754006)(189003)(199004)(8936002)(110136005)(54906003)(3846002)(86362001)(53936002)(102836004)(316002)(81156014)(25786009)(81166006)(76176011)(26005)(229853002)(71190400001)(71200400001)(55016002)(7736002)(9686003)(6246003)(6436002)(8676002)(33656002)(305945005)(186003)(6116002)(476003)(68736007)(446003)(11346002)(486006)(66476007)(74316002)(66946007)(73956011)(64756008)(66446008)(256004)(76116006)(66556008)(4326008)(6506007)(7696005)(2906002)(99286004)(66066001)(4744005)(478600001)(14454004)(52536014)(5660300002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6360;H:CH2PR02MB6453.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2hsfV9zRtmv6kCWMiiR6LKblYBqCaapkEnxJ5xuBxWhHuM8l176J2gc24fhv1TYkc2mH7WYKOpaPcWOjc0rCIlkxdQU7xEAt8S2lEG+mL5yTUf6L8tezkEthJjXQJ9HwvT4Kxzi+aE6zZtp5Q9oEHb+C4vpbALUTvbclFXtP1gU9RQTCYT7ymDhAXViFhzXAFZyBXTNO7IR3KL9ly1SpqDJjWAK5CYb/FmoJt6qU3PVGOQoPjC83rqr9PKV1sLw1PWyTApDpPJBLi8Ln2SM94Mi7HQjVXm6blhHRoiWg86Yd/2aPxc2g7mD1YycFcSfHK4BbOe77tm57LXeErKiJEpKueV4HcuO2LzCQjoJXSzi4dfNrdUeoiQiR7TiCwj/byfQ/A/fEd+Qy0Xj4/C9Gu/uwTRR8WUYufYGAf+Zk9/E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b2005c-292f-45ae-108e-08d6fa45b4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 14:51:01.2180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bharatku@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jun 22, 2019 at 11:40:29PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > In commit
> >
> >   46c1bfcfcd87 ("PCI: xilinx-nwl: Fix Multi MSI data programming")
> >
> > Fixes tag
> >
> >   Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL
> > PCIe
> >
> > has these problem(s):
> >
> >   - Subject has leading but no trailing parentheses
> >   - Subject has leading but no trailing quotes
> >
> > Please do not split Fixes tags across more than one line.
>=20
> Sorry, I do not know how I managed not to run your script on this commit
> log. Log updated on my pci/xilinx branch, Bjorn please pull it when you
> have time.
>=20
Thanks Lorenzo and Stephen for your time.

Regards,
Bharat
