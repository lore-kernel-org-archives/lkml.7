Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DF1C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE32070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="LRD9f5iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfJGKnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:43:24 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:59755 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbfJGKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:43:23 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 1E/0A-04297-7C61B9D5; Mon, 07 Oct 2019 10:43:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRWlGSWpSXmKPExsWSoc9mqntMbHa
  sQd9nc4upD5+wWRxe9ILR4tuVDiaLKX+WM1lc3jWHzYHVY+esu+wem1Z1snncubaHzePzJrkA
  lijWzLyk/IoE1oyfu3cwFizgqbh68C9rA+NGri5GLg5GgaXMElPbfjJCOMdYJBbPWMwE4Wxml
  Pjd+5MNxGEROMEs8efsXDBHSGAKk8SXM0dZIZwHjBIvXq0AynBysAlYSEw+8QDMFhEIlFgy9R
  Q7SBGzwHFGiTM7JzGBJIQFgiRenGplhCgKluh8fQiogQPINpKYfUYdJMwioCLxvusXWDmvQKJ
  EW+s/sHIhgRKJZ9fXg8U5BRwkzk9+D2YzCshKfGlczQxiMwuIS9x6Mh8sLiEgILFkz3lmCFtU
  4uXjf6wQ9akSJ5tuMELEdSTOXn8CZStJzJt7BMqWlbg0vxvK9pU4tWMyM8iZIPWnljlAhC0kl
  nS3skCEVST+HaqEMAskJjxXhzDVJK5fMIcolpG4/WA+OGwlBL6wSjz73MY8gVF/FpKbIWwdiQ
  W7P7FB2NoSyxa+Zp4FDgdBiZMzn7AsYGRZxWieVJSZnlGSm5iZo2toYKBraGika2hpqWturJd
  YpZukl1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokRmJxSCo577mC8O+uN3iFGSQ4mJVFeuV2z
  YoX4kvJTKjMSizPii0pzUosPMcpwcChJ8G4TnR0rJFiUmp5akZaZA0yUMGkJDh4lEd4ZIkBp3
  uKCxNzizHSI1ClGY44JL+cuYua4/n7vUmYhlrz8vFQpcd6FIKUCIKUZpXlwg2AJ/BKjrJQwLy
  MDA4MQT0FqUW5mCar8K0ZxDkYlYd6DIPfwZOaVwO17BXQKE9Apf/ymg5xSkoiQkmpgUnm+5gu
  771S3ohXPpJ6Khv1fv75T4zvz+XbNPMO7lnf7vxZOO+nztnr/dGe754JHFeZtEVWWsAoo3LDv
  qP+arXdPecvzcry5WM6hFz3pyLHJkTp35B1+cx61ndF6ot4/7uadhi9Lk9mfzbaxv26bGrZQ0
  y5qhmzo328VfPVLZ2+N/bG+Quz5BcEjG/5VHdR88nGd7LLJ17oD461OvtfhWOK2QyQhcfnDT1
  XzNaJO58/urt2tLqC2pGiVwo3WfAf53d/nPjAPXtxTuH7m8qLnXw9bKmwolXdg3LNa+n/7Ag+
  /pt7eaNY2u8bA5VdXrmsXC9B4vCWrVO9+oeCPUD9tc/1r3x+nBZ5d8mT6h4OXOJRYijMSDbWY
  i4oTAe7vd3BbBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-288.messagelabs.com!1570444998!734450!1
X-Originating-IP: [104.47.6.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9320 invoked from network); 7 Oct 2019 10:43:18 -0000
Received: from mail-ve1eur02lp2053.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.53)
  by server-16.tower-288.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 7 Oct 2019 10:43:18 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvxWSehEyitIHceM47byUW3dZl59mnzveg5pLI+n5G8czdkAeWVDndbwAyJtvMXCRZs5B1R9UoA5W/0551s8C71rcB/AMQfzGem8/uk9YpoUcGN+DoNXuPmD7wrYGZgtFUCBQjrg427rgJfAAKrHEqzGEI09HP7gilyCdS6Gt21GBcGeEwA7EzLpOA9JbbhdCz99eUb3YrV46w+Plw9VlQXJfSP4kTRnifm05c/KO5zurLh3drJrv7V2FIeSxdHJVP9ckuOQoKwmDkm8wBXqBoWCbwvvALJ7sUfRshiHAeAgBiWaTjJs7J61RCN0WMmo8OULfWNLDiWjO+/LLv6fVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9h5u1ohaewuCJTM1aSmuPsFB0g7+PZDRlH6D9Pl9VU=;
 b=FEX0xt90Y3QOq85HOB/hTHhtCkNCV2CSZEpO0nT86GIF2Bn5uC/HkrZaPhHFKNmcV1JbmC8vKpYW99I5zgJi03U3+ObC9tht0P0dGWuQDPLyU49nWUj5tgv8GwrglJdljLH6Y2Z2gmUfEJMb1P9rixhKIvqafZor4nQ7GLqTk3o1LK6eB+9vlmc36ceb//iwo3SgZ4RACfhW7lK9XwPdymf5Fhom/2U1M+aISytTQFkVZlWy3rZcgn3OJi2YkdcMlUvwGu12r4uoCYmP5PVB4uwAc3DgOhdfywaXNQBvCp+5gX8c858GYRTgNrPYONRjVsCGGgQlaDHz8QLiMsysOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9h5u1ohaewuCJTM1aSmuPsFB0g7+PZDRlH6D9Pl9VU=;
 b=LRD9f5iLEJjY1lbg9P9gvVNLJl8r5Vl0ISJBgdY0oMFRr5TENCJmzNFAkjbNfIMLFO3PKOJFCAm6AFX9CHZLbt8oD9CKQFnvr80ZK6DlUsxY5dN3w0vOlAnnDyiqMOCgMdW87FgYXbypg38+M4QZZb4RIpodHOAS+JjLmbJTeWw=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1106.EURPRD10.PROD.OUTLOOK.COM (10.169.155.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 10:43:08 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1b7:8cda:1411:fb7f]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1b7:8cda:1411:fb7f%8]) with mapi id 15.20.2327.025; Mon, 7 Oct 2019
 10:43:08 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 5/7] regulator: da9211: switch to using
 devm_fwnode_gpiod_get
Thread-Topic: [PATCH 5/7] regulator: da9211: switch to using
 devm_fwnode_gpiod_get
Thread-Index: AQHVewjtpvmbrVtU2kiqONBPbEXVZKdPAbpg
Date:   Mon, 7 Oct 2019 10:43:08 +0000
Message-ID: <AM5PR1001MB0994E69A1599A582473B87B2809B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
 <20191004231017.130290-6-dmitry.torokhov@gmail.com>
In-Reply-To: <20191004231017.130290-6-dmitry.torokhov@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 658befe0-cff4-4d38-573b-08d74b1324a9
x-ms-traffictypediagnostic: AM5PR1001MB1106:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB1106DF55C8CA167731DE31A3A79B0@AM5PR1001MB1106.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39850400004)(199004)(189003)(6246003)(229853002)(478600001)(107886003)(54906003)(110136005)(25786009)(14454004)(66946007)(476003)(11346002)(256004)(71190400001)(4326008)(66446008)(64756008)(76116006)(66556008)(66476007)(6436002)(316002)(71200400001)(9686003)(55016002)(74316002)(7696005)(52536014)(6116002)(3846002)(76176011)(7736002)(305945005)(486006)(5660300002)(53546011)(6506007)(2906002)(446003)(66066001)(186003)(99286004)(33656002)(81166006)(81156014)(8676002)(55236004)(102836004)(86362001)(26005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1106;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l36LCqUNSSOFdxCGkrmbUu782oNZpPZzVvexpvfu+75X2dZimf6HBu5R0reA6sVcqqs+soMInt34wDH1i5Y1ybN4NvfmmjyHNOUsqEekAuZpSHGiEsIANAn1+yaJmQwk2uy5bByTZM5lIh1dX7ek82kWU7UzydYazch45Ugat/bNS2gCYj9vbtcZsJyR8hgFPbun7FxBraTRCJ+t/0qKyfo7gE6OWklQQSfVU58VumeSsdom73H85c/qQtV/4u3u9y1TRPelfzLYFQhkBZ1obIpLGr5BZfCNV/YlLfiaraJoweG+CcL6Huy8Ll8CP1Yq1JguJbbVDRFDgTLz98YloSYFKvggLX7kE1i5Thui24+cPSrlgq+/NslFpTlZQoJrHRvosMhdlGzMvYSVB8Eu0Nj8pdv44+BIZBowFT3G/fY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658befe0-cff4-4d38-573b-08d74b1324a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 10:43:08.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOK2MJZ1+VfYE3+Y3anZYlIjqD8nYZ6M7lkbyCT+IlVrjsqMYvRaEBwiMYHUxNpYbLzYNx6FRj8IoJOVMhm4qMmzO2X+58KTM6WRpmO1mxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 October 2019 00:10, Dmitry Torokhov wrote:

> devm_gpiod_get_from_of_node() is being retired in favor of
> devm_fwnode_gpiod_get_index(), that behaves similar to
> devm_gpiod_get_index(), but can work with arbitrary firmware node. It
> will also be able to support secondary software nodes.
>=20
> Let's switch this driver over.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>=20
>  drivers/regulator/da9211-regulator.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9=
211-
> regulator.c
> index bf80748f1ccc..523dc1b95826 100644
> --- a/drivers/regulator/da9211-regulator.c
> +++ b/drivers/regulator/da9211-regulator.c
> @@ -283,12 +283,12 @@ static struct da9211_pdata
> *da9211_parse_regulators_dt(
>=20
>  		pdata->init_data[n] =3D da9211_matches[i].init_data;
>  		pdata->reg_node[n] =3D da9211_matches[i].of_node;
> -		pdata->gpiod_ren[n] =3D devm_gpiod_get_from_of_node(dev,
> -				  da9211_matches[i].of_node,
> -				  "enable-gpios",
> -				  0,
> -				  GPIOD_OUT_HIGH |
> GPIOD_FLAGS_BIT_NONEXCLUSIVE,
> -				  "da9211-enable");
> +		pdata->gpiod_ren[n] =3D devm_fwnode_gpiod_get(dev,
> +					of_fwnode_handle(pdata-
> >reg_node[n]),
> +					"enable",
> +					GPIOD_OUT_HIGH |
> +
> 	GPIOD_FLAGS_BIT_NONEXCLUSIVE,
> +					"da9211-enable");
>  		if (IS_ERR(pdata->gpiod_ren[n]))
>  			pdata->gpiod_ren[n] =3D NULL;
>  		n++;
> --
> 2.23.0.581.g78d2f28ef7-goog

