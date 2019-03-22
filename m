Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB59C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6016620830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lSd5VnPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCVHQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:16:13 -0400
Received: from mail-eopbgr800045.outbound.protection.outlook.com ([40.107.80.45]:57152
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbfCVHQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPK4M+3zdKoq+Z8yDc7wTqDaN1szNkuXHjrsWq7OwCI=;
 b=lSd5VnPMtxwt9MMwkxUkraeh9yAVN9QwHDj5CdEDUKM06cPXHz9v6K3P45FpQfLqy1XC5djjlwYWFhBPRBNkIEt/TUtwQgyinN45812I1T8gqjA2xG0nyOQCYPHirVk0dieU7bJNqn5ZWcLMlQkysom7J4Cl7ysigX6jgBBF4OE=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4758.namprd02.prod.outlook.com (52.135.232.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Fri, 22 Mar 2019 07:16:06 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::515e:70e7:954c:9731]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::515e:70e7:954c:9731%6]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 07:16:06 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Nava kishore Manne <navam@xilinx.com>,
        "atull@kernel.org" <atull@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Thread-Index: AQHU2m6UH4Q3vc2IFU2R2umKlRcctqYXSScg
Date:   Fri, 22 Mar 2019 07:16:05 +0000
Message-ID: <BYAPR02MB47104B7E954002CB4087FC71C2430@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
 <20190314140122.23372-7-nava.manne@xilinx.com>
In-Reply-To: <20190314140122.23372-7-nava.manne@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3f4f9cc-608d-4540-e73c-08d6ae964013
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4758;
x-ms-traffictypediagnostic: BYAPR02MB4758:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB4758991336CD7DB75B150BC6C2430@BYAPR02MB4758.namprd02.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(13464003)(26005)(2906002)(86362001)(9686003)(53546011)(71200400001)(102836004)(68736007)(76176011)(25786009)(6506007)(105586002)(71190400001)(2501003)(2201001)(81156014)(6246003)(81166006)(8936002)(5660300002)(8676002)(55016002)(106356001)(52536014)(7696005)(53936002)(478600001)(97736004)(305945005)(7736002)(33656002)(74316002)(66066001)(14454004)(256004)(6436002)(316002)(11346002)(229853002)(446003)(486006)(110136005)(186003)(6116002)(3846002)(99286004)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4758;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ghEyd7BbyOxG+cxDFpdQxRe3P25gMr2uicFO8qs/GFYQeCBKmWeYYM9tHYtTtMeMVOhKCHIyoICbcaAWyL8c2o5Sw5zL0MMjy1CacdeTD2OOzCveAFu+anV0bNpVHqv8wpe4pN//QnIFX5dC6k3FJ9FomZYrTbwfAf8sdmzKKFRNHIXQnJAWkcBxlA7L5nxzKWZROt5V150i/BBb0ECLX3YS87ZtsVnSkLeMwNJyj+11hNtmZO5/WYFC1iBeIqx6Hw5Wmu1SJ2a/J1J8zAjnWox4lRimCguRfvSaHfQh3A6X/Qew4sk8YJRkF/MuLdkZ/Dx9PsCJJJHcgBjFrszWds/sm+YoG9ovLJcMJK/SbylOacT9krybqKSlS8chIu57ffEzaw3pwZEmBmSlDc3m8oEWnvUg3khmsP0G1QoGwfY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f4f9cc-608d-4540-e73c-08d6ae964013
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 07:16:06.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!!

> -----Original Message-----
> From: Nava kishore Manne [mailto:nava.manne@xilinx.com]
> Sent: Thursday, March 14, 2019 7:31 PM
> To: atull@kernel.org; mdf@kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Nava kishore Manne
> <navam@xilinx.com>; linux-fpga@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> chinnikishore369@gmail.com
> Subject: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga d=
river
>=20
> Add documentation to describe Xilinx ZynqMP fpga driver bindings.
>=20
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
> 		-Modified binding description as suggested by Moritz Fischer.
> Changes for v3:
>                 -Removed PCAP as a child node to the FW and Created
> 		 an independent node since PCAP driver is a consumer
> 		 not a provider.
>=20
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt           | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-
> pcap-fpga.txt
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga=
.txt
> b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..6d7f10775d9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,11 @@
> +Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
> +The ZynqMP SoC uses the PCAP (Processor configuration Port) to
> +configure the Programmable Logic (PL). The configuration uses  the firmw=
are
> interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	zynqmp_pcap: pcap {
> +		compatible =3D "xlnx,zynqmp-pcap-fpga";
> +	};
> --
> 2.18.0

