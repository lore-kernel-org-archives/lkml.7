Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B9C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6394420835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="cFf84aXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEAQcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:32:20 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:47787 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbfEAQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:32:20 -0400
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id CE/3B-23354-01AC9CC5; Wed, 01 May 2019 16:32:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0gUURTHvTOzs6O5dlsTj5JC2wvU2dy0msI
  oetBABRX2oQfYqKO7tK7LzloWCGoZmUWFPcgyS8xge4kU5TNTsF3BHmZZPsKlLWqjkixThGzH
  WXt8+937/91zz70chtT20pGMmGsXbRbBrKODKONCtISd3uHaFd/TlcR1P2sluDNuD82NdB8hu
  Of1F2lu7E2BmiuuP6Hian7eRKvUfM1wIc3XlQ2o+VpHMc03f66m+dt3XlB8071Rgh+ujd6s3q
  EyWVKzc3erjOcvdNDWcZw7fqyKyEcNIUdREEPh2yT0tTWq5YUWnyag7rGDVhaDCL46S3xJIEN
  jDkqdg7TMM/Ee8DxqJ2WJxN0EFE1MTEqheAO4XhykjiLGJ22E3gcrFH8R9HY4kcwUngtXR5op
  mTVYgL6iEyqZtXg1/Gi+O1kmEK+B0Rvlkz7CUfC94DopM4nDoddTQcgMGENV4xNS4TD4+PaXS
  vFFcBW+Qsp+HHT2eJDcDuDZcHyQUrajoKuixK9sgpP3v6oV7kdQ7JWmjh5rG/D7HFSVFPnZCi
  W/3vvPzodT7d/87cyCfGcBrfAFGhxjacqz0mCovNNfPxocx92U/G2An5LQ0tRPnUQxZf88TeE
  4uNzwjVY4FqqvfCLLJr9rBrjOe6jLiHKgpak2U6bRniWYzKwhPp41GBaxhmUJbGKCXjjACnox
  h90nSnbWoBf2SXppf1aaOV1vEe21yDdn6daHsfeR51pmK4pgCF2YZo7WtUsbkpqdvt8oSMYUW
  45ZlFrRLIbRgea105fNsImZYm6Gyewb1qkYmGDdTM2wHGskq5AlmTKVqAOxTEulu5zUUpZsix
  gZrpmQJSxLxhzLnxJTI9+FoiJDNSggIEAbbBVtWSb7/7kXhTNIF6p5K1cJNlnsf27y+pogfE2
  kXGqXm7ALf6PIfLT3cIVYvyWxcAmxIG97Roy5LS6v79wGR3T6pUoh2ZvW5g6tC2vMH5m/PPYl
  P1GeePD9rZaIjJ7w2QWft817NbAy+Zx55bQVH+Z8XL/2bGNpMry7ldRvT1pnZunuxB2Lve4+y
  7tm05aEvV/4lK0Xh0JyYuKCD4nC4aLSqIFr6xuCdvI6SjIKhhjSJgm/AbTcIGDtAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-5.tower-262.messagelabs.com!1556728335!6480142!1
X-Originating-IP: [104.47.1.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30722 invoked from network); 1 May 2019 16:32:15 -0000
Received: from mail-ve1eur01lp2054.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.54)
  by server-5.tower-262.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 1 May 2019 16:32:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHA49DX1tmJTKWoK7vgDyPjfhBKqwnvf95lp7xvD+cs=;
 b=cFf84aXXAyzFK1uZdzQnBQkbd0Xw+iMneRonF2nnmkkJLWWN8XIL3mLJHoNHeJ60SLVvOOVHRmL1NJL5K8X3XoptjXQTuiGEjnehEuhyl7hQWEM0nRET5Sd2kI/TYHm8xR/oq70uzZLAzin5ZFANBX6Ueoq/IBizmtavfYneKKY=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1075.EURPRD10.PROD.OUTLOOK.COM (10.169.154.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 1 May 2019 16:32:04 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971%5]) with mapi id 15.20.1856.008; Wed, 1 May 2019
 16:32:04 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Logesh Kolandavel <logesh.kolandavel@timesys.com>,
        Support Opensource <Support.Opensource@diasemi.com>
CC:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: da7213: fix DAI_CLK_EN register bit overwrite
Thread-Topic: [PATCH v2] ASoC: da7213: fix DAI_CLK_EN register bit overwrite
Thread-Index: AQHU//zoZK9xcowMKU+/9Rs3e1ejAaZWdLGg
Date:   Wed, 1 May 2019 16:32:04 +0000
Message-ID: <AM5PR1001MB0994908D0F450CC19DADF69F803B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190501090424.28861-1-logesh.kolandavel@timesys.com>
In-Reply-To: <20190501090424.28861-1-logesh.kolandavel@timesys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e73294d-4623-42f0-7a9b-08d6ce528bb0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM5PR1001MB1075;
x-ms-traffictypediagnostic: AM5PR1001MB1075:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB1075D1BE011DDB2AD272D171A73B0@AM5PR1001MB1075.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(376002)(136003)(366004)(199004)(189003)(486006)(14444005)(446003)(476003)(186003)(26005)(102836004)(6506007)(53546011)(55236004)(86362001)(256004)(33656002)(66066001)(76176011)(7696005)(6636002)(6116002)(2906002)(3846002)(99286004)(305945005)(74316002)(316002)(68736007)(66476007)(81156014)(81166006)(8936002)(76116006)(73956011)(71200400001)(71190400001)(9686003)(14454004)(53936002)(110136005)(5660300002)(52536014)(54906003)(8676002)(7736002)(11346002)(66446008)(64756008)(66556008)(66946007)(6436002)(4326008)(229853002)(55016002)(72206003)(478600001)(25786009)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1075;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UXIT3sAYZf+Bg9lG4ZWkLMmWzk3UuThf6iATxfV6NXeMIQFmr4F8kV806uiHvFzW/Dwm9P0l7cyuE2l8eJ/BrWBfmdUeJEJ6amWATejrIGherJE1kTU/cdXRm6LweURjBFoScAhhPq8mqn5iUMfHnmOgOzzXEVLJikGK497F2nLQqROpNWji8t2Cs7QIlbuNY6L/55MI6XMe8EIvk52usOsibhj0qRfhtA/Nj3ngqOLeO4dlxm3AQsNJJb8+/fRlSifXJ4n9eNV//97CbEHidmgeDCUeGKknQPUw0kNEXhHM54xyTK4U5sAt70nZLR9e38cQLZ8U5lukUWypaWF9dKBCd12WmXJfiSqGrlOaISgIYMw3MeAOJZXpEdX8hx+iuN0RDz4dmhcowiQn49A5pNudN757Iy+mJVHvLxtGqZo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e73294d-4623-42f0-7a9b-08d6ce528bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 16:32:04.4791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 May 2019 10:04, Logesh Kolandavel wrote:

> From: Logesh <logesh.kolandavel@timesys.com>
>=20
> If the da7213 codec is configured as Master with the DAPM power down
> delay time set, 'snd_soc_component_write' function overwrites the
> DAI_CLK_EN bit of DAI_CLK_MODE register which leads to audio play
> only once until it re-initialize after codec power up.
>=20
> Signed-off-by: Logesh <logesh.kolandavel@timesys.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
> Changes in v2:
> -Include the mask DA7213_DAI_BCLKS_PER_WCLK_MASK
>=20
>  sound/soc/codecs/da7213.c | 5 ++++-
>  sound/soc/codecs/da7213.h | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 92d006a5283e..425c11d63e49 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -1305,7 +1305,10 @@ static int da7213_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	/* By default only 64 BCLK per WCLK is supported */
>  	dai_clk_mode |=3D DA7213_DAI_BCLKS_PER_WCLK_64;
>=20
> -	snd_soc_component_write(component, DA7213_DAI_CLK_MODE,
> dai_clk_mode);
> +	snd_soc_component_update_bits(component,
> DA7213_DAI_CLK_MODE,
> +			    DA7213_DAI_BCLKS_PER_WCLK_MASK |
> +			    DA7213_DAI_CLK_POL_MASK |
> DA7213_DAI_WCLK_POL_MASK,
> +			    dai_clk_mode);
>  	snd_soc_component_update_bits(component, DA7213_DAI_CTRL,
> DA7213_DAI_FORMAT_MASK,
>  			    dai_ctrl);
>  	snd_soc_component_write(component, DA7213_DAI_OFFSET,
> dai_offset);
> diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
> index 5a78dba1dcb5..9d31efc3cfe5 100644
> --- a/sound/soc/codecs/da7213.h
> +++ b/sound/soc/codecs/da7213.h
> @@ -181,7 +181,9 @@
>  #define DA7213_DAI_BCLKS_PER_WCLK_256				(0x3 << 0)
>  #define DA7213_DAI_BCLKS_PER_WCLK_MASK
> 	(0x3 << 0)
>  #define DA7213_DAI_CLK_POL_INV					(0x1 << 2)
> +#define DA7213_DAI_CLK_POL_MASK
> 	(0x1 << 2)
>  #define DA7213_DAI_WCLK_POL_INV					(0x1 << 3)
> +#define DA7213_DAI_WCLK_POL_MASK				(0x1 << 3)
>  #define DA7213_DAI_CLK_EN_MASK					(0x1 << 7)
>=20
>  /* DA7213_DAI_CTRL =3D 0x29 */
> --
> 2.21.0

