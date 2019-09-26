Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19338C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7781217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="k/ffxFhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfIZJWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:22:14 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:58951 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbfIZJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:22:13 -0400
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 1C/AF-19332-1438C8D5; Thu, 26 Sep 2019 09:22:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRWlGSWpSXmKPExsWSoc9lpuvY3BN
  rcOULl8WROV+ZLaY+fMJm8e1KB5PF5V1z2BxYPHbOusvu0fazzGPTqk42j8+b5AJYolgz85Ly
  KxJYM2af/cNc8Jm3Ys76BSwNjFe4uxi5OBgFljJLLLt7mQXCOcYisbXtNROEs5lR4nfvTzYQh
  0XgBLPE5sfvwTJCAtOYJN5M2sgC4TxhlPjzuJexi5GTg03AQmLyiQdsILaIgLNE165WsHZmgY
  uMEhuaG8ASwgIpErvOTGeBKEqV2PfwHHsXIweQbSQx85M/SJhFQFXi3tYNrCA2r0CixKmfW9l
  BbCGg+U0Lu5hBbE4BS4lZ026B1TAKyEp8aVwNFmcWEJe49WQ+E4gtISAgsWTPeWYIW1Ti5eN/
  UPWpEiebbjBCxHUkzl5/AmUrScybewTKlpW4NL8byvaVWLdsB1z9lmPzoWwLiSXdrSwg50sIq
  Ej8O1QJES6QmHDyPFSJmsTiK7tZIGwZiaaHvewQ9mdWiSdnQicw6s9CcjWErSOxYPcnNghbW2
  LZwtfMs8AhIShxcuYTlgWMLKsYLZKKMtMzSnITM3N0DQ0MdA0NjXUNdI1N9BKrdBP1Ukt1k1P
  zSooSgZJ6ieXFesWVuck5KXp5qSWbGIFpKaWQQWkH46ZZb/QOMUpyMCmJ8qpI98QK8SXlp1Rm
  JBZnxBeV5qQWH2KU4eBQkuAVbwDKCRalpqdWpGXmAFMkTFqCg0dJhLewESjNW1yQmFucmQ6RO
  sWoyzHh5dxFzEIsefl5qVLivIYgRQIgRRmleXAjYOn6EqOslDAvIwMDgxBPQWpRbmYJqvwrRn
  EORiVh3hUgU3gy80rgNr0COoIJ6Ii8/G6QI0oSEVJSDUzb9nw0idrr1vydz/DsWmW2RqaICb2
  i5yVumisdXFjh9erju8awY9vM5e6fveJtvl3OLmyHuN7LHyk8Z50vV059YdL+spfl85YDS1pM
  Jj6L+5D98f5F9V2yxX19AqZLHeRdOQMTFQ6Fr7kd/8fN6sW7jSu9ly1cJ/bhh8H6FRL7HAoWV
  bCdN3kyo+ZVvUjH/3un6hf2X//JszkxI9X/FlsD6/qsb1ZX9iQsfRhT8OIVt3zNcpnJC5iFGl
  duTNZ1fpdXJfjw59l51ZzqxXUf37PP/3I+cia7kTPTuWXmRuEvcoP2uYVcf1AV0frsRdqG+5m
  17Cd8Ns5yt6m1U9nZmnn28qFWhvqtwSKNbNMC25uUWIozEg21mIuKEwEJUvueUgQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-223.messagelabs.com!1569489728!446!1
X-Originating-IP: [104.47.10.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 538 invoked from network); 26 Sep 2019 09:22:09 -0000
Received: from mail-db5eur03lp2054.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.54)
  by server-18.tower-223.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 26 Sep 2019 09:22:09 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5EsBlBebMs4VGGEMI2A9S4J+TP+DZjz99qiIC3LOLjb3r9OeiwHbntBCxkEdXlzQzCZF3TMi9x3eriu6U0FrgUAOjRyIzDbPK6IcMvY4Ad4CUFx2NoMDRl/DG2EiEktVPryIyi+mnSP1Pt1sXqTAUxPMiCVYPuW1gWwoxw6Ne93zqCcwmrVA+VpwbpycTir5Vkt/+Nkb6gaZJ6q/iCx3nTmkhf1DMcmG0QYwpDb6P310EdmO/5eBMpPfhE1a6aWrT1JYIZKswnlk9MFTOJE8ywLdPZmPPQuzX98LR0QAtPLKPquktcXzdcD0S3qIxL0sZreErxFDZrI3UAdRELAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEKK2cpwnF0zovO+jZCEHx4ciplMSbqw2rtdjGsA5ao=;
 b=Aj0ja3/tV6+hIb4pWv1TRVyFhW+L/KPtZQMgTD0+THpSCVHjQyi8kPpyWNj9oMOvVQZJ9LWhj9hNc5TQvcMapQTVw0PS55IcmKVJry0nI/ks4MFGBOGy9B3V3+5LCDpidqFYcxKDw6UJFryUpkHn7XUmLOxYWd11shL5FBnYIVjy79pEUngqmiLC+LdJH23UNmH066izFVZnDlwMR9EAgkWLyzGBwApBRYnx1JUiD2MGAJHT2JbH/hSah+1lAt8TsyU68+kg5LZJv+6nxy0fNiEukEZ8QSjSUBGzmyySx/OQ2fiABWv394EkvGYCvBnqlNTg7bb6iTGRBy6Z1rccgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEKK2cpwnF0zovO+jZCEHx4ciplMSbqw2rtdjGsA5ao=;
 b=k/ffxFhCUeTc+x1hDBeO1ufWg2TvNfK5VfRj8v67Sact0Gq04ra2joGwDy3bv9Sdm6Wfbf3lWWBxwawXmAlwmerIG3HSyvatw0PLn9qhqTrtsZ0TUFtAMGV1CLJuHKyIHuRFIZnvDa8lRSyM1a3ZA728KCpQfow9eOn9Qh+EsPM=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1121.EURPRD10.PROD.OUTLOOK.COM (10.169.154.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 26 Sep 2019 09:22:07 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.028; Thu, 26 Sep
 2019 09:22:07 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] regulator: da9062: Simplify da9062_buck_set_mode for
 BUCK_MODE_MANUAL case
Thread-Topic: [PATCH 1/2] regulator: da9062: Simplify da9062_buck_set_mode for
 BUCK_MODE_MANUAL case
Thread-Index: AQHVdC56OTS9Q7efEkSIFtO/XiO5P6c9reKQ
Date:   Thu, 26 Sep 2019 09:22:07 +0000
Message-ID: <AM5PR1001MB0994D5D70956F903FDFB989680860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190926055128.23434-1-axel.lin@ingics.com>
In-Reply-To: <20190926055128.23434-1-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 592b7283-b84a-49fb-1c0f-08d7426300d1
x-ms-traffictypediagnostic: AM5PR1001MB1121:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB112141FC3354B92C8B796249A7860@AM5PR1001MB1121.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(7736002)(110136005)(14454004)(25786009)(66066001)(7696005)(54906003)(478600001)(256004)(14444005)(316002)(76176011)(6246003)(3846002)(71190400001)(71200400001)(4326008)(9686003)(99286004)(86362001)(2906002)(6116002)(33656002)(6436002)(55016002)(229853002)(81166006)(81156014)(52536014)(8936002)(8676002)(5660300002)(53546011)(186003)(6506007)(55236004)(486006)(102836004)(26005)(11346002)(476003)(446003)(305945005)(76116006)(66446008)(66476007)(74316002)(66556008)(64756008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1121;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: osVygA9Jc6lCSzXdg9N2910JbI4V4eVt/gysMbyc/e/fAYyqJbRSLGAuqKbQYZOZlCJV7Yc3RpQH6/kEZC5sjv6eztLuxPaTvdHt5SIu514mPVnQT/MpOrptpFqLQJiW+IqN/bVkhXATX3G8xcJxdYzmGkvvfCo5WNbSvtL752H++/NKhoCrj2L4l0EklcV80kD+UiVJjnpEs7d4lbbYrCBq/E3ByDQj6gztf6K4niMBzJNnqDrvuS9riI9sgwLO+S1IpNfRi4zzBgOiCSYDPFrogynoHKoFg3RnXBmCuUSXWBgJHHXib+qO6/Z1EeCelmUuVR7EN6+vBI8hsM6/4S9ZZNGxA6ZBsBiG5IqKrGYia/2lU2bGGrwx5uFNTfaHhJhiuI17oitOWBa8UCPMzwGYlUIuFwnyyhveohWAk7k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592b7283-b84a-49fb-1c0f-08d7426300d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 09:22:07.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37rFWtIJcOFej6L5N+n2CsHuE0RB0abyyX+TZIIXnfzXKMQXiKALG7NhXeUgOV3hLk++D4Sl1ZeUNgLWMm+N9cAdBk6gWlNivyk0BywOE9c=
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

This patch will need to be rebased on Marco's update titled:

	"regulator: da9062: fix suspend_enable/disable preparation"

However, changes look fine so:

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  drivers/regulator/da9062-regulator.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9=
062-
> regulator.c
> index 710e67081d53..739a40f256f6 100644
> --- a/drivers/regulator/da9062-regulator.c
> +++ b/drivers/regulator/da9062-regulator.c
> @@ -136,7 +136,7 @@ static int da9062_buck_set_mode(struct regulator_dev
> *rdev, unsigned mode)
>  static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
>  {
>  	struct da9062_regulator *regl =3D rdev_get_drvdata(rdev);
> -	unsigned int val, mode =3D 0;
> +	unsigned int val;
>  	int ret;
>=20
>  	ret =3D regmap_field_read(regl->mode, &val);
> @@ -146,7 +146,6 @@ static unsigned da9062_buck_get_mode(struct
> regulator_dev *rdev)
>  	switch (val) {
>  	default:
>  	case BUCK_MODE_MANUAL:
> -		mode =3D REGULATOR_MODE_FAST |
> REGULATOR_MODE_STANDBY;
>  		/* Sleep flag bit decides the mode */
>  		break;
>  	case BUCK_MODE_SLEEP:
> @@ -162,11 +161,9 @@ static unsigned da9062_buck_get_mode(struct
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

