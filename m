Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8641C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7387F20652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Nqqte2+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEBKHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:07:13 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:43148 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfEBKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:07:12 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id FE/95-23082-D41CACC5; Thu, 02 May 2019 10:07:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRWlGSWpSXmKPExsWSoc9npet78FS
  Mwe4WZosrFw8xWUx9+ITNYv6JW2wW3650MFlc3jWHzaJzVz+rxYbvaxkt5nbmOXB4bPjcxOYx
  u+Eii8fOWXfZPTat6mTz2Pd2GZvH+i1XWTw+b5ILYI9izcxLyq9IYM14/qqNseAHb8XVk7eZG
  xiPc3cxcnGwCKxnlnh8oJUdxBESmMIksW/OVxYI5wGjxObJzUAOJwebgIXE5BMP2EBsEYF0iX
  2TJrCCFDELPGCSWLDvMStIQljAXuLtuvOsEEUOEpsm7meHsI0k9sxuYASxWQRUJD4/eQYW5xV
  IlDg99Q9QnANom5XEw+lFICangLXErkd+IBWMArISXxpXM4PYzALiEreezGcCsSUEBCSW7DnP
  DGGLSrx8/I8Voj5V4mTTDUaIuI7E2etPwKZLCChK9D5ggQjLSlya3w1V4isxd9U/sHclBO4wS
  kxYd4oVprelcy/UfAuJJd2tUM0FEo8nzYFqVpM4tLqNDcKWkeje1AQ1aCKbxMdNs8FeFBJIlv
  gw9yw7RJGcxKreh1BFF5gldl96xzKBUWsWkucgbB2JBbs/sUHY2hLLFr5mngUOLkGJkzOfsCx
  gZFnFaJFUlJmeUZKbmJmja2hgoGtoaKxromtkpJdYpZukl1qqm5yaV1KUCJTUSywv1iuuzE3O
  SdHLSy3ZxAhMbSmFLGI7GC8sTT/EKMnBpCTK+3vFqRghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKE
  rwv9wHlBItS01Mr0jJzgEkWJi3BwaMkwpt2ACjNW1yQmFucmQ6ROsWoy3Fg0cO5zEIsefl5qV
  LivDogRQIgRRmleXAjYAn/EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3gqQKTyZeSVwm14
  BHcEEdMTzSWBHlCQipKQaGFcYLD3Odesrh9Rfp4jC6IdHso+GSgWoymzriyra9zvnEKP74//P
  Ml5LtYXIX5gf27IsfJ6p0gyumXN3r+uwXVFSNN8x2eJ2y6KVScHTA79uqd6QWmYb9NHt0rRoE
  bUL+37ueL2YeyK7xIEzv9dle9nobly3e+luDivGB6u2bY318d8vcseya5ISS3FGoqEWc1FxIg
  DhjX2D8wMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-246.messagelabs.com!1556791628!5475643!1
X-Originating-IP: [104.47.14.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23896 invoked from network); 2 May 2019 10:07:08 -0000
Received: from mail-vi1eur04lp2058.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (104.47.14.58)
  by server-4.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 2 May 2019 10:07:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d79/PvtV5NHswfZyQ0SHN3QdSMQYeivxpnwzxEgzk5A=;
 b=Nqqte2+jmOBvXl2uDbClcD42/XVrRQ55nDBkdioKDNlshbGz6HjsOdRNDS83lkf2RhqVCugQzLkIN8/RhW4HjBN93QbbaYPRwlFRpPrL9FqWhhnJSqyUrprIfp6/iS6lA8rcrOXmZr+S7ClaL8+X/G1qURInm98bOBqqmmj4MTk=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1041.EURPRD10.PROD.OUTLOOK.COM (10.169.155.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 2 May 2019 10:07:06 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 10:07:06 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "dgreid@chromium.org" <dgreid@chromium.org>
Subject: RE: [PATCH] ASoC: da7219: Update the support rate list
Thread-Topic: [PATCH] ASoC: da7219: Update the support rate list
Thread-Index: AQHVAJyitg9iRjOROEK/950fcGO9eKZXm2CQ
Date:   Thu, 2 May 2019 10:07:05 +0000
Message-ID: <AM5PR1001MB0994A52E77F12680F71AB08080340@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190502040743.184310-1-yuhsuan@chromium.org>
In-Reply-To: <20190502040743.184310-1-yuhsuan@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bfedf67-761e-4a3e-9db7-08d6cee5ee65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM5PR1001MB1041;
x-ms-traffictypediagnostic: AM5PR1001MB1041:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB1041D6A66F9B524356552376A7340@AM5PR1001MB1041.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39850400004)(366004)(346002)(199004)(189003)(54906003)(446003)(86362001)(486006)(55016002)(110136005)(6436002)(229853002)(476003)(7736002)(66556008)(186003)(76116006)(8936002)(66946007)(64756008)(66446008)(6506007)(11346002)(73956011)(9686003)(66476007)(2501003)(3846002)(256004)(53546011)(76176011)(8676002)(66066001)(6116002)(81166006)(7696005)(102836004)(14454004)(478600001)(305945005)(6246003)(99286004)(55236004)(71200400001)(71190400001)(72206003)(81156014)(5660300002)(53936002)(25786009)(316002)(52536014)(26005)(74316002)(68736007)(33656002)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1041;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4U0P0lTt6/2Z4ShRV3AfnlHjbcuyYwHIuF1ev3qLmZPJ8k1a3lozTyY+nlWKbdRVp4VnDpiDD7yxccH/ZiEn+uLKf8tTcTHHdEKtNT7csI7dymCKQmoMoC/IThNMO5JnPBN0Rp1AVEh/DVPG8OKRDSfKVDbVtyKhqlpOLerzzz6+9xL20d0TnALYPRwT/Y0suEwL+GQ9fJPCXKNsL7klGp3/LxYZWRyBS7ePuRAeyUN78lGoz6btni4NKcp1j1Eaz/KEE+oyaygpq0jTa2JVsN38xmkoy3j2nKL1vWgR1bmiDL4NastPJzSxe6qgRXHocKrVePNfTLf5dBAf1Ne7CrcxERy7RwPvKTXX0yQtkKGN56bTRpE/goZGsg5jMRvxDnM8JdMp3TCIJqigr8EhdEca6FnBFHL9P4JRZrnBgT4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfedf67-761e-4a3e-9db7-08d6cee5ee65
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 10:07:06.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 May 2019 05:08, Yu-Hsuan Hsu wrote:

> If we want to set rate to 64000 on da7219, it fails and returns
> "snd_pcm_hw_params: Invalid argument".
> We should remove 64000 from support rate list because it is not
> available.
>=20
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7219.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 5f5fa3416af3..7497457cf3d4 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1658,20 +1658,26 @@ static const struct snd_soc_dai_ops da7219_dai_op=
s
> =3D {
>  #define DA7219_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |
> SNDRV_PCM_FMTBIT_S20_3LE |\
>  			SNDRV_PCM_FMTBIT_S24_LE |
> SNDRV_PCM_FMTBIT_S32_LE)
>=20
> +#define DA7219_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025
> |\
> +		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> +		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> +		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> +		      SNDRV_PCM_RATE_96000)
> +
>  static struct snd_soc_dai_driver da7219_dai =3D {
>  	.name =3D "da7219-hifi",
>  	.playback =3D {
>  		.stream_name =3D "Playback",
>  		.channels_min =3D 1,
>  		.channels_max =3D DA7219_DAI_CH_NUM_MAX,
> -		.rates =3D SNDRV_PCM_RATE_8000_96000,
> +		.rates =3D DA7219_RATES,
>  		.formats =3D DA7219_FORMATS,
>  	},
>  	.capture =3D {
>  		.stream_name =3D "Capture",
>  		.channels_min =3D 1,
>  		.channels_max =3D DA7219_DAI_CH_NUM_MAX,
> -		.rates =3D SNDRV_PCM_RATE_8000_96000,
> +		.rates =3D DA7219_RATES,
>  		.formats =3D DA7219_FORMATS,
>  	},
>  	.ops =3D &da7219_dai_ops,
> --
> 2.21.0.593.g511ec345e18-goog

