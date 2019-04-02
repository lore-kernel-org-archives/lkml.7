Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23E3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6684D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pJsxsZLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDBU1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:27:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4279 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDBU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:27:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca3c5c60000>; Tue, 02 Apr 2019 13:27:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 13:27:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Apr 2019 13:27:46 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 20:27:45 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 20:27:45 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.50) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Apr 2019 20:27:45 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3062.namprd12.prod.outlook.com (20.178.54.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Tue, 2 Apr 2019 20:27:43 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 20:27:43 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V1 21/26] DT bindings: spi: add tx/rx clock delay SPI
 client properties
Thread-Topic: [PATCH V1 21/26] DT bindings: spi: add tx/rx clock delay SPI
 client properties
Thread-Index: AQHU5GII4NltLCGlVEuJ3bH7lX99LKYlUQwAgAQKOKA=
Date:   Tue, 2 Apr 2019 20:27:43 +0000
Message-ID: <BYAPR12MB33988CD5578E3421E5AB005FC2560@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-21-git-send-email-skomatineni@nvidia.com>
 <5ca06155.1c69fb81.60281.9b59@mx.google.com>
In-Reply-To: <5ca06155.1c69fb81.60281.9b59@mx.google.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66658fd8-0df9-4f61-363b-08d6b7a9a957
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB3062;
x-ms-traffictypediagnostic: BYAPR12MB3062:
x-microsoft-antispam-prvs: <BYAPR12MB30620A5B44C085BCDCAE06A4C2560@BYAPR12MB3062.namprd12.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(106356001)(6436002)(5660300002)(71190400001)(71200400001)(54906003)(97736004)(229853002)(316002)(2906002)(7736002)(52536014)(74316002)(305945005)(6246003)(8936002)(4326008)(81156014)(81166006)(105586002)(14454004)(55016002)(9686003)(99286004)(53936002)(68736007)(25786009)(8676002)(6916009)(478600001)(3846002)(14444005)(256004)(6116002)(86362001)(7696005)(66066001)(186003)(26005)(11346002)(446003)(476003)(33656002)(486006)(6506007)(76176011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3062;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pohfeGuap88idngMAmCoYs8UipnWQGeBaTT9nJP6GjTEZrBVpWFF1jjztuvfDiCbEHSpjwzw944VCOwlXaKVu2bUuJ6fI0g3TH/4c/aVDHZvzvl4damqbIxz4BEsWHmBP+B73LPFandcvYcSYIOz+3XtsZC5SXdiJagsEBX0MDRY/jTvi7WKVSUsxDElrEJw1eNA4R0Fk3jFYemKQ8C+OsI2j1g7kW48oeYW77CxsrqYiJqdUYltrGBrcMa1kA2jdJ714EV5pPKSCLyY3Wobaa6kbhc5n1pbMDp49uPYP+rMlUGjaj9VbP8GXq6szu4l8Oo8cNGJuxy1Nz+2CEVlpwL0oDnoKWlTp27/xLrYO5VdUyLqCpkaGkucrEo/PvVqCD5dNJL1g6hJtU4YXfAe1kMTpGR7lSLKM8VssYr5q/U=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66658fd8-0df9-4f61-363b-08d6b7a9a957
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 20:27:43.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554236870; bh=du1QvcRlYeNf26trHju2FtTfXkskcJxbfIbkgt9x8tE=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=pJsxsZLu7udkOVCX/yN+jHaW3CwR/DJwrirH7jj9wC0CHz8IglE0hDzMxPoZYMmpE
         5+4ERAfMPqxQuObRVoxKYn6ND0Jfx9LjUIs1jUiqsBh1udvcBEUcu4vO3b4pLyoF+7
         V+u8vUYTIsZgyUZInZZHabttBPPPzzto9W4m6yb6/5NvGI8JY9olyZ0yDHAuMEBzRc
         hfz+QqbLhbLpbwk7WWbvNoksTBfstXlQ1oUEQ0IqWVFrToh9oP6MiG8q+03ipAf1r6
         4mTAh+qw2RbS9L9AJNxVj8oDr/G9iliYFiZDS2C9TDB0Hh2OWAt+NeLcbZwdTHzJLw
         Y2cr8vO3HmjkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 26, 2019 at 10:56:42PM -0700, Sowjanya Komatineni wrote:
> > This patch adds Tegra SPI master tx and rx clock delay properties.
> >=20
> > TX/RX clock delays may vary depending on the platform design trace=20
> > lengths for each client on the Tegra SPI bus. These properties helps=20
> > to tune the clock delays.
> >=20
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  .../devicetree/bindings/spi/nvidia,tegra114-spi.txt      | 16 ++++++++=
++++++++
> >  1 file changed, 16 insertions(+)
>
> Just combine this with patch 19.
>
> > diff --git=20
> > a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt=20
> > b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> > index 6167c5234b64..2b84b7b726ce 100644
> > --- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> > +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> > @@ -29,6 +29,12 @@ spi-client device controller properties:
> >  - nvidia,cs-hold-clk-count: CS hold timing parameter.
> >  - nvidia,cs-inactive-cycles: CS inactive delay in terms of clock betwe=
en
> >    transfers.
> > +- nvidia,tx-clk-tap-delay: Delays the clock going out to the external=
=20
> > +device
> > +  with this tap value. This property is used to tune the outgoing=20
> > +data from
> > +  Tegra SPI master with respect to outgoing Tegra SPI master clock.
> > +- nvidia,rx-clk-tap-delay: Delays the clock coming in from the=20
> > +external device
> > +  with this tap value. This property is used to adjust the Tegra SPI=20
> > +master
> > +  clock with respect to the data from the SPI slave device.
>
> Are there units? What's the range of values.

TX/RX Clock delays are tap counts and there is internal tap-to-tap delay.
Will update to specify tap to delay correlation along with supported tap va=
lues range.

As per feedback from mark, will move CS timing to API implementation as the=
y are not
Tegra SPI specific and applicable in general.

>
> > =20
> >  Example:
> > =20
> > @@ -45,4 +51,14 @@ spi@7000d600 {
> >  	reset-names =3D "spi";
> >  	dmas =3D <&apbdma 16>, <&apbdma 16>;
> >  	dma-names =3D "rx", "tx";
> > +
> > +	<spi-client>@<bus_num> {
> > +		...
> > +		...
> > +		nvidia,cs-setup-clk-count =3D <10>;
> > +		nvidia,cs-hold-clk-count =3D <10>;
> > +		nvidia,rx-clk-tap-delay =3D <0>;
> > +		nvidia,tx-clk-tap-delay =3D <16>;
> > +		...
> > +	};
> >  };
> > --
> > 2.7.4
> >=20


