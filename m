Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A47C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAA4206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="KjAviQud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfDOKti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:49:38 -0400
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:42103
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfDOKth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mnsh/EMyJQFsGKMTSwnk92TeWSXYS7zle04UZxF2k7o=;
 b=KjAviQudYFyDwnDvEDMm1bIfc8qlUEavrZeQUAQ2WovdaDNO7egBjpkMXI/tkw1l71MWx0D0T7RMc+4XQAByb40uWv9i9HrZRTvZ+/zxu4EpTrToln+7GPHVpJsbOpKFHqkIBYM45uRRRpMMddXn4MH4IoAMQG7QpgnLcccpvB4=
Received: from DM6PR03MB3658.namprd03.prod.outlook.com (20.176.85.151) by
 DM6PR03MB3529.namprd03.prod.outlook.com (20.176.85.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 10:49:32 +0000
Received: from DM6PR03MB3658.namprd03.prod.outlook.com
 ([fe80::92d:f66:9079:8a4e]) by DM6PR03MB3658.namprd03.prod.outlook.com
 ([fe80::92d:f66:9079:8a4e%2]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 10:49:31 +0000
From:   "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: dac: ad5758: Modifications for new revision
Thread-Topic: [PATCH] iio: dac: ad5758: Modifications for new revision
Thread-Index: AQHU7tka/wq3zWLEq0G0EoyAncasq6Y7puQAgAFtIVA=
Date:   Mon, 15 Apr 2019 10:49:31 +0000
Message-ID: <DM6PR03MB3658EA518FAE172AC1741446812B0@DM6PR03MB3658.namprd03.prod.outlook.com>
References: <20190409133521.24828-1-mircea.caprioru@analog.com>
 <20190414140220.75133382@archlinux>
In-Reply-To: <20190414140220.75133382@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mircea.Caprioru@analog.com; 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93e7caab-17df-412a-4bc4-08d6c1900ac7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR03MB3529;
x-ms-traffictypediagnostic: DM6PR03MB3529:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-microsoft-antispam-prvs: <DM6PR03MB35295E1CCA74F0924CC3C700812B0@DM6PR03MB3529.namprd03.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(13464003)(6916009)(316002)(76176011)(5660300002)(72206003)(6436002)(305945005)(229853002)(8936002)(11346002)(476003)(9686003)(86362001)(14454004)(446003)(68736007)(52536014)(25786009)(74316002)(486006)(106356001)(71190400001)(71200400001)(2906002)(6246003)(97736004)(81156014)(81166006)(6116002)(33656002)(55016002)(7736002)(8676002)(478600001)(66066001)(4326008)(53936002)(7696005)(99286004)(105586002)(256004)(102836004)(53546011)(6506007)(3846002)(26005)(54906003)(186003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3529;H:DM6PR03MB3658.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kpPgbmui4eZ8K04URVYqC+7kXJkboUGIzLz7sKpFHDHCthQtIYioRrr9Si26Gkpj13fYWosrP2s1aBNN2wgZ1J2JYFooT9dz7zW2yjN2NmMkxe1G8zDCIpUJrMeji0VcWK2TMH77+uXlQPmi2mHwvMIqFVAJm14bRl8PDaA/oPx6zQkQckVpOpAZU7hqsdgG3QOmrRr76WFtHQzCUxKoq1leOWYRnU6C4ulGpqGSO0gHWJa+YEqX+29pPwhdzzQsyxCqHH44THhmMLjeJA/FXUgxouztGFsgQoz6XdZdSZS8hYUgI+OC64ArQShnDwhOFxsPWcUbqBpj0iRTV6nUhBvOTLamaPw6EKdRxoBICB7lx0OUMsKYpzpTYGKpqmnjNdJbx9ThqKsM962EDKmT7E844whkPqrbnvjfRO5/RmY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e7caab-17df-412a-4bc4-08d6c1900ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 10:49:31.9097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

1. Any changes to functionality that might break users of the older revisio=
ns?
From what i have found out there are no users of the older revision since i=
t has not been available for purchasing. Only this new revision.=20
2. Any userspace visible changes?
There are no userspace visible changes.=20
3. Do we want to think about back porting to older kernels?
This could be a benefit, but i don't think the impact will be significant.=
=20
4. Should we support this explicitly by detecting or describing the
   hardware revision in some fashion?
Yes I could use the CHIP_ID register to check the revision and do a V2. Jus=
t wondering if it is needed if there are no older revision chips in use.=20

Thanks,
Mircea

-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org]=20
Sent: Sunday, April 14, 2019 4:02 PM
To: Caprioru, Mircea <Mircea.Caprioru@analog.com>
Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Popa, Stefan Serban =
<StefanSerban.Popa@analog.com>; lars@metafoo.de; gregkh@linuxfoundation.org=
; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5758: Modifications for new revision

[External]


On Tue, 9 Apr 2019 16:35:21 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch will ensure compatibility with the new revision of the=20
> AD5758 dac converter. The modifications consist of removing the=20
> fault_prot_switch function since this option is no longer available,=20
> and enabling the ENABLE_PPC_BUFFERS bit in ADC_CONFIG register before=20
> setting the PPC current mode.
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Hi Mircea,

Talk me through the implications of this change.

1. Any changes to functionality that might break users of the older revisio=
ns?
2. Any userspace visible changes?
3. Do we want to think about back porting to older kernels?
4. Should we support this explicitly by detecting or describing the
   hardware revision in some fashion?

Thanks,

Jonathan



> ---
>  drivers/iio/dac/ad5758.c | 55=20
> +++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c index=20
> 2bdf1b0aee06..a513c70faefa 100644
> --- a/drivers/iio/dac/ad5758.c
> +++ b/drivers/iio/dac/ad5758.c
> @@ -72,8 +72,6 @@
>  #define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)       (((x) & 0x1F) << 0)
>  #define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK    GENMASK(6, 5)
>  #define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)        (((x) & 0x3) << 5)
> -#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK   BIT(7)
> -#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(x)       (((x) & 0x1) << 7)
>
>  /* AD5758_DCDC_CONFIG2 */
>  #define AD5758_DCDC_CONFIG2_ILIMIT_MSK               GENMASK(3, 1)
> @@ -84,6 +82,10 @@
>  /* AD5758_DIGITAL_DIAG_RESULTS */
>  #define AD5758_CAL_MEM_UNREFRESHED_MSK               BIT(15)
>
> +/* AD5758_ADC_CONFIG */
> +#define AD5758_ADC_CONFIG_PPC_BUF_EN(x)              (((x) & 0x1) << 11)
> +#define AD5758_ADC_CONFIG_PPC_BUF_MSK                BIT(11)
> +
>  #define AD5758_WR_FLAG_MSK(x)                (0x80 | ((x) & 0x1F))
>
>  #define AD5758_FULL_SCALE_MICRO      65535000000ULL
> @@ -315,6 +317,18 @@ static int ad5758_set_dc_dc_conv_mode(struct=20
> ad5758_state *st,  {
>       int ret;
>
> +     /*
> +      * The ENABLE_PPC_BUFFERS bit must be set prior to enabling PPC cur=
rent
> +      * mode.
> +      */
> +     if (mode =3D=3D AD5758_DCDC_MODE_PPC_CURRENT) {
> +             ret  =3D ad5758_spi_write_mask(st, AD5758_ADC_CONFIG,
> +                                 AD5758_ADC_CONFIG_PPC_BUF_MSK,
> +                                 AD5758_ADC_CONFIG_PPC_BUF_EN(1));
> +             if (ret < 0)
> +                     return ret;
> +     }
> +
>       ret =3D ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
>                                   AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
>                                  =20
> AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
> @@ -444,23 +458,6 @@ static int ad5758_set_out_range(struct ad5758_state =
*st, int range)
>                                           =20
> AD5758_CAL_MEM_UNREFRESHED_MSK);  }
>
> -static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool=20
> enable) -{
> -     int ret;
> -
> -     ret =3D ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> -                     AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK,
> -                     AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(enable));
> -     if (ret < 0)
> -             return ret;
> -     /*
> -      * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0=
.
> -      * This allows the 3-wire interface communication to complete.
> -      */
> -     return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> -                                          AD5758_DCDC_CONFIG2_BUSY_3WI_M=
SK);
> -}
> -
>  static int ad5758_internal_buffers_en(struct ad5758_state *st, bool=20
> enable)  {
>       int ret;
> @@ -585,8 +582,8 @@ static ssize_t ad5758_write_powerdown(struct=20
> iio_dev *indio_dev,  {
>       struct ad5758_state *st =3D iio_priv(indio_dev);
>       bool pwr_down;
> -     unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
> -     unsigned long int dcdc_config1_msk, dac_config_msk;
> +     unsigned int dc_dc_mode, dac_config_mode, val;
> +     unsigned long int dac_config_msk;
>       int ret;
>
>       ret =3D kstrtobool(buf, &pwr_down); @@ -602,17 +599,6 @@ static=20
> ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
>               val =3D 1;
>       }
>
> -     dcdc_config1_mode =3D AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode=
) |
> -                         AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(val);
> -     dcdc_config1_msk =3D AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
> -                        AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK;
> -
> -     ret =3D ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> -                                 dcdc_config1_msk,
> -                                 dcdc_config1_mode);
> -     if (ret < 0)
> -             goto err_unlock;
> -
>       dac_config_mode =3D AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
>                         AD5758_DAC_CONFIG_INT_EN_MODE(val);
>       dac_config_msk =3D AD5758_DAC_CONFIG_OUT_EN_MSK | @@ -841,11=20
> +827,6 @@ static int ad5758_init(struct ad5758_state *st)
>                       return ret;
>       }
>
> -     /* Enable the VIOUT fault protection switch (FPS is closed) */
> -     ret =3D ad5758_fault_prot_switch_en(st, 1);
> -     if (ret < 0)
> -             return ret;
> -
>       /* Power up the DAC and internal (INT) amplifiers */
>       ret =3D ad5758_internal_buffers_en(st, 1);
>       if (ret < 0)

