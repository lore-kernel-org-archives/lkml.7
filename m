Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1881FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC2E2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="R0iLG+FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfDZM1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:27:14 -0400
Received: from mail-eopbgr680076.outbound.protection.outlook.com ([40.107.68.76]:27651
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfDZM1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ6k1jkkmfQjgL7BURF1Mwyh55oHVsoYDSDAQDKStdo=;
 b=R0iLG+FENhIOiTi/PVLJLBdMEq7FY3v9fyh9cEqiZ+9F2t+jEIwha4XMat2q3c54kTwkvOkcELppnYd5EFuZH2TAAUadU87H83eNh90U/JuseBGrjbSOp+lF8nNIkzB1xNhq2f9ufQjwL1yqDexTfbIxhQCyTONq4PD6Paw/1Qc=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB3714.namprd02.prod.outlook.com (52.132.8.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 12:27:06 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::9872:12d3:6703:84cd]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::9872:12d3:6703:84cd%2]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 12:27:06 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
Thread-Topic: [PATCH V2 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
Thread-Index: AQHU7rwBkMJ45Oh8Y0arjQYc7Z2U46ZNbD6AgAEMVoA=
Date:   Fri, 26 Apr 2019 12:27:05 +0000
Message-ID: <BL0PR02MB56812D6CE27C3522A7A2A58ACB3E0@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
 <1554804414-206099-2-git-send-email-dragan.cvetic@xilinx.com>
 <20190425202417.GA22307@kroah.com>
In-Reply-To: <20190425202417.GA22307@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 590df2b4-fefc-4f6a-dc1f-08d6ca427ea1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB3714;
x-ms-traffictypediagnostic: BL0PR02MB3714:
x-microsoft-antispam-prvs: <BL0PR02MB371459C8C3419B1A9FA9268FCB3E0@BL0PR02MB3714.namprd02.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(366004)(346002)(13464003)(199004)(189003)(11346002)(305945005)(76116006)(6436002)(55016002)(8676002)(8936002)(7736002)(74316002)(229853002)(99286004)(6916009)(186003)(64756008)(26005)(102836004)(66446008)(73956011)(81156014)(81166006)(66946007)(66476007)(66556008)(86362001)(6506007)(4744005)(2906002)(53546011)(97736004)(476003)(446003)(486006)(33656002)(68736007)(25786009)(53936002)(6246003)(478600001)(4326008)(71200400001)(71190400001)(9686003)(76176011)(256004)(3846002)(6116002)(7696005)(316002)(52536014)(5660300002)(54906003)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3714;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FNDT9Ppn8C1ZqK68Ahxic27mAafNaVUPADkpAC38wP7MPaCWPvO+697eeRk23y2CMK4/sQGT3BKnIC5tebsOpCP8D/ASwDhsx1Atia6uCJ7A7j9CjVISMwb6L3cno1jEN3KyLCr2SQUG9Bnz83sAM0vAVurb2242csRrIhvAq8DYCnagcbRWKzk06u6/cRLSSStjC18w+yAc2nUB7oC2za23V6vKID9Mvita2QTdoGnsxtDSC0Et0OfogfiJ8n8c5xDSHHzJVIuIXYehiMj/gVNpT02JbGhmV4vRohHhu0yT84dqb4g/eQEwK/jygNy77aYTwZCC0of9Ank4jMFMPGbkAojoz2qG3SZ3GaocLdJR+U6DQJZmesXivPWFW7SDIeBt1ATniFjnH6EbAm8wPYRgjSomrXP48f7KeKuxsv4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590df2b4-fefc-4f6a-dc1f-08d6ca427ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 12:27:05.9412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday 25 April 2019 21:24
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; linux-kernel@vger.kernel.org; Derek
> Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V2 01/12] dt-bindings: xilinx-sdfec: Add SDFEC bindin=
g
>=20
> On Tue, Apr 09, 2019 at 11:06:43AM +0100, Dragan Cvetic wrote:
> > Add the Soft Decision Forward Error Correction (SDFEC) Engine
> > bindings which is available for the Zynq UltraScale+ RFSoC
> > FPGA's.
> >
> > Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> > ---
> >  .../devicetree/bindings/misc/xlnx,sd-fec.txt       | 58 ++++++++++++++=
++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.=
txt
>=20
> Don't you have to send new bindings to the DT maintainers?


They will be in the email list from now on.

Thanks
Dragan

>=20
> thanks,
>=20
> greg k-h
