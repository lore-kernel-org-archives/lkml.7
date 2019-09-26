Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8F3217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="U20zm1f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfIZJXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:23:21 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:52196 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbfIZJXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:23:20 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id C0/36-25181-6838C8D5; Thu, 26 Sep 2019 09:23:18 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRWlGSWpSXmKPExsWSoc9lodva3BN
  r0HrT1OLInK/MFlMfPmGz+Halg8ni8q45bA4sHjtn3WX3aPtZ5rFpVSebx+dNcgEsUayZeUn5
  FQmsGesOX2AqWMlTsblxO2MD4zKuLkYuDkaBpcwSf/98YIZwjrFIPD27khXC2cwo8bv3JxuIw
  yJwglmi7dIUMEdIYBqTxMkX3awQzhNGib+/FjJ2MXJysAlYSEw+8YANxBYRcJbo2tUK1sEscJ
  FRYkNzA1hCWCBF4vW/7SwQRakSNzqbgLZzANlGEj9X2IOYLAKqEpO6xEAqeAUSJe7Na2AGsYU
  E0iT2bl7OBGJzClhKrH/yhh3EZhSQlfjSuBqshllAXOLWk/lgNRICAhJL9pxnhrBFJV4+/scK
  UZ8qcbLpBiNEXEfi7PUnULaSxLy5R6BsWYlL87uhbF+JzTv2sMDUbzk2HypuIbGku5UF5GQJA
  RWJf4cqIcIFEld2b4cqUZPY1nUS6hwZiaaHveygEJEQeMkqMW3eS7YJjPqzkJwNYetILNj9iQ
  3C1pZYtvA18yxwUAhKnJz5hGUBI8sqRsukosz0jJLcxMwcXUMDA11DQ2Ndc10jEyO9xCrdJL3
  UUt3k1LySokSgrF5iebFecWVuck6KXl5qySZGYGJKKWT/tIPxxqw3eocYJTmYlER5VaR7YoX4
  kvJTKjMSizPii0pzUosPMcpwcChJ8Io3AOUEi1LTUyvSMnOASRImLcHBoyTCW9gIlOYtLkjML
  c5Mh0idYtTlmPBy7iJmIZa8/LxUKXFeQ5AiAZCijNI8uBGwhH2JUVZKmJeRgYFBiKcgtSg3sw
  RV/hWjOAejkjDvCpApPJl5JXCbXgEdwQR0RF5+N8gRJYkIKakGJo8ZqzIP8mxe9Fz76ON/Ief
  UmPnMLm348KkxJ99Hi/+40IG8dXuEv+g+09TPOLxB9PJjq5pa11p1ly1vBTY0n29+bcSYcZPP
  68z6vLwr94+tb13xfduc5o6/XudYM/2C/AKbr9/NOR68ke/dthy3gktrMxhXRs3d80QjNX3FE
  mXv08wSaZ0MoSfn/TX7/GcT62XJaS9F81a4WcvFSsr+PfKub8KJPF49plPrWzhbCr/8Ol6fJB
  ybliOcc3On++PLb6rvpLetM2tgbMuJO+MRHpnTonfDsWwi31Z96SjrOW77E3hn7Xlme1LcZun
  EVVPC01OiczNTJs78+GZhrtAjIemU/IUiLfmdWTdseh04lFiKMxINtZiLihMBOpeWbFMEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-30.tower-239.messagelabs.com!1569489797!7885!1
X-Originating-IP: [104.47.10.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7908 invoked from network); 26 Sep 2019 09:23:17 -0000
Received: from mail-db5eur03lp2056.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.56)
  by server-30.tower-239.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 26 Sep 2019 09:23:17 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSDpSvdT9aQ9gPwIDvG6bfy/06SwKzUXfts2NMg9xsxlIHXkZ4TitcaYAJkG9+Dv/hhZvOQo6aHxRlpF1CREORQa6bNOGvOGfeDIy/hupXfcA1U7lAO7AQwwiTnO07jOEoXIiexXnebE1HRgkdrHDw2J0NIKI7t7HDX+JkIgm/spi+ysSXLis6HDv7zoo4P5K0eqb0z4JygezxpVmvFd60IrYsC6IF0ZymwFyUFFcgvn64aBuJBzz7gIKvDQP8/vdxdkhN3RJYK7rAWoKZRxxm6SBBHDWabNiOCaQm0HvvZkIS5LUAPtZ6AJejzP5BPjnb5E2xiw8mJTgx7PWWnP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkkSYyztYneH9bwMAVzrFe9HTfEQRcPzwwypyjpPKMs=;
 b=fSH6hYS2lkAdDDQKxBBFJhFsEqmtZt/ZW27laaWz2hz6bPvXetq2w5NWgvmZyfmwdCX5woThEAdHEWYq+qSNIBiWkqewAqbkvNOFByYcQj0rtLXiLsfuvTXs85XloUzL8t3yp4ceQdVpgxCltCaN21wNdeI59aa6m5VxZAO6M2rP2C3RjRB/3Pchfm0vS0BZp15e2o7az5Soloa6mY/tSInwMIw8pF4L3Mju3OXNJmCMMYBWAl4sc232JkDUat+d/z3vspOJHDc1BY4aGx4U2zYla9zODnDhbWDfMm9ZVVz7FsKT2SAw3x6oKQI0OOC6RgXKiCmucgpcfNJRLSYtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkkSYyztYneH9bwMAVzrFe9HTfEQRcPzwwypyjpPKMs=;
 b=U20zm1f7MmuMVApV5nvH9+YIjtqbgp/zlwSV06BSbCjADijgayLyu0vvMPWvpbIZ8dvjsfYzFkRlYFW9yDVPNhEVG60FeghYdG9Gr+TGV6ldQC6rXyqOiA45eH1HdVVXzVL9Vu2jqlUtr0tQshbpASZCug4p/etclj7JKnXnJIA=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1121.EURPRD10.PROD.OUTLOOK.COM (10.169.154.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 26 Sep 2019 09:23:16 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.028; Thu, 26 Sep
 2019 09:23:16 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] regulator: da9063: Simplify da9063_buck_set_mode for
 BUCK_MODE_MANUAL case
Thread-Topic: [PATCH 2/2] regulator: da9063: Simplify da9063_buck_set_mode for
 BUCK_MODE_MANUAL case
Thread-Index: AQHVdC57KXku93gnqEC8kczRA+UL+qc9r3Vg
Date:   Thu, 26 Sep 2019 09:23:16 +0000
Message-ID: <AM5PR1001MB0994B90D77039A555F36802E80860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190926055128.23434-1-axel.lin@ingics.com>
 <20190926055128.23434-2-axel.lin@ingics.com>
In-Reply-To: <20190926055128.23434-2-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffec9d0c-b0f3-407a-2bf4-08d7426329d0
x-ms-traffictypediagnostic: AM5PR1001MB1121:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB1121A2C71EE9D025FDF44DB3A7860@AM5PR1001MB1121.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(7736002)(110136005)(14454004)(25786009)(66066001)(7696005)(54906003)(478600001)(256004)(316002)(76176011)(6246003)(3846002)(71190400001)(71200400001)(4326008)(9686003)(99286004)(86362001)(2906002)(6116002)(33656002)(6436002)(55016002)(229853002)(81166006)(81156014)(52536014)(8936002)(8676002)(5660300002)(53546011)(186003)(6506007)(55236004)(486006)(102836004)(26005)(11346002)(476003)(446003)(305945005)(76116006)(66446008)(66476007)(74316002)(66556008)(64756008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1121;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l805y56PZSpCvL3L2FdPV0deUqxNnj/T3LS2IXE+b+dNZoTeCJp6T3Ft0gKSZzWssH6Bpn8SagAqdiklCWAtkPJo6iIG0RamVWXBr3EQ3HykxLxhEWRcLo9ieS0m4tMMvnVp43fZvcTed5Pq554E3Meo/WJ/cwB780HFUY1msKcZ7G5AQVT/+E//n14neUSAPJk1wH0EOSpBPnPclp0Tzc2Fk8ljJT/wqXysznVxyCObobAEVcv4iJIHDDIWr1Zu/XLYn7+njMLfwsI4RTRH0OjRmzwcMVsVIzVKwzXVuvibcVafn/5pAecLEDJBepY3+VlWmbeMSI+seiG17tuLaCuWkMOBjDhxdNu8drCE2LwNv+SYemC3sham3Sf8WsyAzXYieqJ+7VU98Efdm/9aqixZduT9Oa77QDLkd8XOwxY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffec9d0c-b0f3-407a-2bf4-08d7426329d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 09:23:16.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9rQ+HdEKuy44GiqiXlyTB7wVSqdXcKGQIQe9Lt/QFwwXmUMMjyGQ0a7ytrTTh+3rdce6UVdA4EZteJtK++tiM5zu/QBP/w8y7Wd/xCDCjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2019 06:51, Axel Lin wrote:

> The sleep flag bit decides the mode for BUCK_MODE_MANUAL case, simplify
> the logic as the result is the same.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  drivers/regulator/da9063-regulator.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9=
063-
> regulator.c
> index 28b1b20f45bd..2aceb3b7afc2 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -225,7 +225,7 @@ static unsigned da9063_buck_get_mode(struct
> regulator_dev *rdev)
>  {
>  	struct da9063_regulator *regl =3D rdev_get_drvdata(rdev);
>  	struct regmap_field *field;
> -	unsigned int val, mode =3D 0;
> +	unsigned int val;
>  	int ret;
>=20
>  	ret =3D regmap_field_read(regl->mode, &val);
> @@ -235,7 +235,6 @@ static unsigned da9063_buck_get_mode(struct
> regulator_dev *rdev)
>  	switch (val) {
>  	default:
>  	case BUCK_MODE_MANUAL:
> -		mode =3D REGULATOR_MODE_FAST |
> REGULATOR_MODE_STANDBY;
>  		/* Sleep flag bit decides the mode */
>  		break;
>  	case BUCK_MODE_SLEEP:
> @@ -262,11 +261,9 @@ static unsigned da9063_buck_get_mode(struct
> regulator_dev *rdev)
>  		return 0;
>=20
>  	if (val)
> -		mode &=3D REGULATOR_MODE_STANDBY;
> +		return REGULATOR_MODE_STANDBY;
>  	else
> -		mode &=3D REGULATOR_MODE_NORMAL |
> REGULATOR_MODE_FAST;
> -
> -	return mode;
> +		return REGULATOR_MODE_FAST;
>  }
>=20
>  /*
> --
> 2.20.1

