Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCB3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B68F2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="p3FQxIBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfDZNJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:09:53 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:38561 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbfDZNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:09:52 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id D1/D0-24742-D1303CC5; Fri, 26 Apr 2019 13:09:49 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSf0wTZxjud3e9noQjH0XDa7VGmxkz5SrVqOc
  fJo4/ljPBZIvRGYORgx60Wg5oi8KWKJAgikGXLBIhCmwpKKAB6zYV8QfFH9VEVEQRAwawzqzE
  jYBRjEbsxxXn/nve53ne533f5OVo4wBr4pRCr+JWZZeFjWEcy9nVgpnuSksebYoRex8EKPHoc
  IgV3/QeoMSH7cdZ8d2zEoN4sP2IXmx7ewatN0htE6WsdLFm0CD5mw+y0pVXjazU+vsjRrp8fp
  KSJvwLvjNs0zvVjNzCdL1jNNxJ59XGF450Bg3FqC+uAsVwDG6l4X1jEyKFEVdR8LTmPKUVwwg
  mW/ojyiyOxSL8EhxiCZ6Nd0Ho1k2amGjcS0HZ1JSBCAlYgs4HVynNtAGqWomJ4BUQLG2exgxe
  DOf+Oq2vQBzHYxmmBjcR2oi/gfKSSorQs3AKnCr/ntAIm+F1Sct0J40T4WmobjodMAZfxz1aw
  3Pg7+cf9ZpfgdulT5DGJ8HdvhAikYAXQeUQo9Fm6Kk7FLVshHcjbQy5BPAAglrfYcNM743um1
  GTCL5DZdHmPOir/iM6dz4cCV6jtOYGFg4HjrHaLZkwduJuNGgBNFcORyfcp6GiY1CvXZME9Zf
  G2Z/R1zVfHFfzhaThZdD46yhNMI/j4XZ1iKlHTDMSM9zObIc3R3a6BFtysmCzrRRWC6vWWOUf
  hQyrUiBkKqrXLUdEq7zHY/UU5WS67FZV8fpR5NPs+ezaC6j+ZHYAzeUoyxx+33ggzRiXkWsvc
  sgexw53gUvxBNB8jrMAv4bqSjPGu5VspTDL6Yq864wMXKxlNl9NZN6TJ+d4nNmadAcJ3LXfhk
  /QRkbNVRVTIp9FTJiYHAXq54iZp+9BZlMCj3Q6nTE2T3HnOL3/18MokUOWBF4lKbFO1ft5Uji
  yBBVZwt4UIEt45f8kUzHKnxxKyS1/9OZG+HFXj3vP5rM/hepW6exb9v2zMzW9oeGlVLW9WKq0
  6Y6aU/fndwtLuhe+nTjbOdA+sbg/pfR6S3pQ5Z//+WLeqd5d9bv95W168d/te5Ni22v71iVfi
  ttQsTnrK9Po2DNfybbr374crD6ZtrXoB1T2sb/oQ+pea4d9JN7CeByybSnt9sifADAHluvvAw
  AA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-23.tower-246.messagelabs.com!1556284188!5196372!1
X-Originating-IP: [104.47.6.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21430 invoked from network); 26 Apr 2019 13:09:48 -0000
Received: from mail-ve1eur02lp2054.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.54)
  by server-23.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 26 Apr 2019 13:09:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdkaOm5aXI6nESQvvlWQ53pd29tP2ZvaMbF08tvHdGI=;
 b=p3FQxIBrrJCa+mg31rHjOtPvPpyUPWVwKznUinFzIfDitCRaHzWgrWUOsZQTGT0XWg9N6qB3bSBsjioraEQoE+kxBBeH4rL6iXJ1rU+zAZ07AW7Ni7OoO/897C3mYp0qL6lbX6OOpCv9Gmes9OTuRCfSiDVIsVRGYLv04GQMYO0=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1201.EURPRD10.PROD.OUTLOOK.COM (10.169.155.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 13:09:46 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971%5]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 13:09:46 +0000
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
Subject: RE: [PATCH] ASoC: da7213: fix DAI_CLK_EN register bit overwrite
Thread-Topic: [PATCH] ASoC: da7213: fix DAI_CLK_EN register bit overwrite
Thread-Index: AQHU+yq7Y7Mbpm6Qg0e28e7V2NTrjaZOaYiw
Date:   Fri, 26 Apr 2019 13:09:46 +0000
Message-ID: <AM5PR1001MB0994D9131132C60AB4DAB7F3803E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190425054249.5675-1-logesh.kolandavel@timesys.com>
In-Reply-To: <20190425054249.5675-1-logesh.kolandavel@timesys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0353017-2192-4abf-a77e-08d6ca4874fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM5PR1001MB1201;
x-ms-traffictypediagnostic: AM5PR1001MB1201:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB120117B9EC35681376DA3AFCA73E0@AM5PR1001MB1201.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(256004)(11346002)(6436002)(97736004)(229853002)(3846002)(2906002)(33656002)(4326008)(14444005)(8936002)(54906003)(14454004)(66946007)(186003)(66446008)(76176011)(64756008)(66556008)(66476007)(6246003)(6116002)(73956011)(68736007)(26005)(110136005)(6506007)(72206003)(478600001)(53546011)(76116006)(52536014)(55236004)(316002)(102836004)(53936002)(446003)(6636002)(99286004)(486006)(7736002)(305945005)(25786009)(74316002)(8676002)(66066001)(81166006)(7696005)(81156014)(55016002)(71200400001)(71190400001)(86362001)(476003)(9686003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1201;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ghIu83GVw9J555F3D6oBc4JOC6hxsNVGoAXkJUMGbHgzV2ulGL2nWKumfbeiTxuyQ7znmNK/wzpF4otapCrvuzLlIsIGx1biLweCVL1BxkQTRvQ47cJXG7VlWhZ7t4lT1TFQa/W92nX5QmrdaW++Bm9RYxPr+wmNHNbNky7F4PMpyHdZ48z/X+4RfHuue3nM9/Y/0l9Alqe5CQvsUiNUBoO7U8t3jFTZMjzazrQQq3I8UPWbuS9MGh5lJ51975kABd9qtQ4+87nGPa4nAP3SAevGFRUQMQ83a96TQPuBnlWLp+Zs4m1H1Abm4O6W4g2p20Y6i91FPmDtAmtEYe1ssUHPA7kOv7m+CGceJ4rfUdCm+8twe9rqVtOwI3hRoG3/q7pCzGAld+ELv3kmaGDDi6M3YwtZoJBGXO3O37IAXcI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0353017-2192-4abf-a77e-08d6ca4874fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 13:09:46.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 April 2019 06:43, Logesh Kolandavel wrote:

> From: Logesh <logesh.kolandavel@timesys.com>
>=20
> If the da7213 codec is configured as Master with the DAPM power down
> delay time set, 'snd_soc_component_write' function overwrites the
> DAI_CLK_EN bit of DAI_CLK_MODE register which leads to audio play
> only once until it re-initialize after codec power up.
>=20
> Signed-off-by: Logesh <logesh.kolandavel@timesys.com>
> ---
>  sound/soc/codecs/da7213.c | 4 +++-
>  sound/soc/codecs/da7213.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 92d006a5283e..306e01684bda 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -1305,7 +1305,9 @@ static int da7213_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	/* By default only 64 BCLK per WCLK is supported */
>  	dai_clk_mode |=3D DA7213_DAI_BCLKS_PER_WCLK_64;
>=20
> -	snd_soc_component_write(component, DA7213_DAI_CLK_MODE,
> dai_clk_mode);
> +	snd_soc_component_update_bits(component,
> DA7213_DAI_CLK_MODE,
> +			    DA7213_DAI_CLK_POL_MASK |
> DA7213_DAI_WCLK_POL_MASK,

We'll also need to add the mask DA7213_DAI_BCLKS_PER_WCLK_MASK' here as wel=
l as
we're setting 'DA7213_DAI_BCLKS_PER_WCLK_64' for this register just prior t=
o
this call. Didn't spot that in earlier conversations.

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

