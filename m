Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9A4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C81204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bbGsyAqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfDDKsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:48:11 -0400
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:53946
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfDDKsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yFynn64596jX1NwAoD2VA2fvl0sOQDj5xI05QZJS8E=;
 b=bbGsyAqZC/cmQzOm+Vhn/VjY9yjElVaSf81L5rR0xMaOmgQmO5DfEnpI1eyfMFld6SgPI6pxRC0F/0UquG4N+uTEU2voVVN1cpHOfvbVsQf6oIK5Nvm0PTWg/niti/9tCuhMCXQkkW3pn4OCAPnfhRPRcntU/TqNq7d3eXdxuVs=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2736.eurprd04.prod.outlook.com (10.175.22.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Thu, 4 Apr 2019 10:48:03 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::f808:5ebf:a573:3ea1]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::f808:5ebf:a573:3ea1%8]) with mapi id 15.20.1771.011; Thu, 4 Apr 2019
 10:48:03 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: Re: [PATCH] soc: fsl: add DPAA2 console support
Thread-Topic: [PATCH] soc: fsl: add DPAA2 console support
Thread-Index: AQHU5AhknrBzPfGcyEqu6n1s2eiIeg==
Date:   Thu, 4 Apr 2019 10:48:03 +0000
Message-ID: <VI1PR0402MB28001287DEFB65FD29BE98E0E0500@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1553627718-23714-1-git-send-email-ioana.ciornei@nxp.com>
 <CADRPPNSPsRJEPW9uMNoDAEqYvKYPF2ybJX7a48rJJqap3nwOtw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [94.230.156.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: febc1e0e-fa8e-4647-3a4a-08d6b8eb036c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB2736;
x-ms-traffictypediagnostic: VI1PR0402MB2736:
x-microsoft-antispam-prvs: <VI1PR0402MB2736DF67669E44435E368EB2E0500@VI1PR0402MB2736.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(51914003)(30864003)(476003)(68736007)(486006)(86362001)(229853002)(106356001)(105586002)(97736004)(186003)(53546011)(6506007)(76176011)(6636002)(44832011)(478600001)(26005)(102836004)(446003)(6436002)(14454004)(6862004)(4326008)(52536014)(25786009)(33656002)(55016002)(9686003)(99286004)(7696005)(5660300002)(6246003)(53936002)(6116002)(2906002)(3846002)(66066001)(71190400001)(256004)(7736002)(81166006)(14444005)(305945005)(81156014)(8676002)(74316002)(54906003)(8936002)(71200400001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2736;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tNdDVHExv85Oa/zYJRhrV1EytFv8WcadU38BjAEEyaUcNalC/6NnBTM/r41d+bPy/leOZbD/baeIEJr8kX3o1xdkA5O7zDcWwfcevaQKol90aXWalt3EYmJ4fucY89cUNIxlgff6oV0dR6D1TlbB5GM2THkjHCHVRdn0o9XjtqHaNEp/LRi5PN5NxDKb4CymGNgnXDJBsExFk1cGTYjogkJsIWG4UMmyb1/g6JQ8agIYqJ5zQ+ruBYGAiUUINY8sGKEZC1aHIVRbyNhHKJhwcT+1kfw6W8/Dm+JAFUBXq7HIbIp7Ze8el+NaMBuyUEO2pKEG2VjlD3PCNG5yyenC6gJQC70rdEPJrQ0hg54Dj1XTvQM3odi/eKPA0viDnHwXb6AoS7YnRlG7hmyZTViyXp4xslEW+TQ2TS/5hxgQ5ew=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febc1e0e-fa8e-4647-3a4a-08d6b8eb036c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 10:48:03.2022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 10:55 PM, Li Yang wrote:=0A=
> On Tue, Mar 26, 2019 at 2:17 PM Ioana Ciornei <ioana.ciornei@nxp.com> wro=
te:=0A=
>>=0A=
>> This patch adds DPAA2 MC and AIOP console log support.=0A=
>>=0A=
>> The platform driver probes on the "fsl,dpaa2-console" device tree node=
=0A=
>> which describes the base firmware address needed in order to infer the=
=0A=
>> start address of both firmware logs: MC and AIOP.=0A=
>> It then exports two misc char devices which can be used to dump=0A=
>> the needed logs.=0A=
>>=0A=
>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>=0A=
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
>> ---=0A=
>>   drivers/soc/fsl/Kconfig         |  10 ++=0A=
>>   drivers/soc/fsl/Makefile        |   1 +=0A=
>>   drivers/soc/fsl/dpaa2-console.c | 306 ++++++++++++++++++++++++++++++++=
++++++++=0A=
>>   3 files changed, 317 insertions(+)=0A=
>>   create mode 100644 drivers/soc/fsl/dpaa2-console.c=0A=
>>=0A=
>> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig=0A=
>> index 61f8e1433d0a..9fe8222c3968 100644=0A=
>> --- a/drivers/soc/fsl/Kconfig=0A=
>> +++ b/drivers/soc/fsl/Kconfig=0A=
>> @@ -29,4 +29,14 @@ config FSL_MC_DPIO=0A=
>>            other DPAA2 objects. This driver does not expose the DPIO=0A=
>>            objects individually, but groups them under a service layer=
=0A=
>>            API.=0A=
>> +=0A=
>> +config DPAA2_CONSOLE=0A=
>> +       tristate "QorIQ DPAA2 console driver"=0A=
>> +       depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || AR=
M64 || X86_LOCAL_APIC || PPC)))=0A=
> =0A=
> I don't know why FSL_MC driver added there architectures dependency=0A=
> for COMPILE_TEST, but is this driver also only buildable on these=0A=
> architectures?  Can we really just remove these dependencies?=0A=
> =0A=
=0A=
The initial reasoning behind the dependency on the COMPILE_TEST config=0A=
was to catch early build problems on any build configuration.=0A=
And yes, the dpaa2-console can be compiled without a problem on these=0A=
architectures.=0A=
=0A=
In this case, I would suggest to leave the dependencies as they are but =0A=
if you want I can also remove them.=0A=
=0A=
>> +       default y=0A=
>> +       help=0A=
>> +         Console driver for DPAA2 platforms. Exports 2 char devices,=0A=
>> +         /dev/dpaa2_mc_console and /dev/dpaa2_aiop_console,=0A=
>> +         which can be used to dump the Management Complex and AIOP=0A=
>> +         firmware logs.=0A=
>>   endmenu=0A=
>> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile=0A=
>> index 803ef1bfb5ff..57762c9fc7da 100644=0A=
>> --- a/drivers/soc/fsl/Makefile=0A=
>> +++ b/drivers/soc/fsl/Makefile=0A=
>> @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)              +=3D qe/=0A=
>>   obj-$(CONFIG_CPM)                      +=3D qe/=0A=
>>   obj-$(CONFIG_FSL_GUTS)                 +=3D guts.o=0A=
>>   obj-$(CONFIG_FSL_MC_DPIO)              +=3D dpio/=0A=
>> +obj-$(CONFIG_DPAA2_CONSOLE)            +=3D dpaa2-console.o=0A=
>> diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-con=
sole.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..21a5e121f87b=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/soc/fsl/dpaa2-console.c=0A=
>> @@ -0,0 +1,306 @@=0A=
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)=0A=
> =0A=
> Probably good to have a one-line description of the driver?=0A=
=0A=
Will add one in the next version.=0A=
=0A=
> =0A=
>> +/* Copyright 2015-2016 Freescale Semiconductor Inc.=0A=
>> + * Copyright 2018 NXP=0A=
>> + */=0A=
>> +=0A=
>> +#define pr_fmt(fmt) "dpaa2-console: " fmt=0A=
>> +=0A=
>> +#include <linux/module.h>=0A=
>> +#include <linux/of_device.h>=0A=
>> +#include <linux/of_address.h>=0A=
>> +#include <linux/miscdevice.h>=0A=
>> +#include <linux/uaccess.h>=0A=
>> +#include <linux/slab.h>=0A=
>> +#include <linux/fs.h>=0A=
>> +#include <linux/io.h>=0A=
>> +=0A=
>> +MODULE_LICENSE("Dual BSD/GPL");=0A=
>> +MODULE_AUTHOR("Roy Pledge <roy.pledge@nxp.com>");=0A=
>> +MODULE_DESCRIPTION("DPAA2 console driver");=0A=
> =0A=
> These normally go to the bottom of a driver.=0A=
=0A=
Will move them.=0A=
=0A=
> =0A=
>> +=0A=
>> +/* MC firmware base low/high registers indexes */=0A=
>> +#define MCFBALR_OFFSET 0=0A=
>> +#define MCFBAHR_OFFSET 1=0A=
>> +=0A=
>> +/* Bit masks used to get the most/least significant part of the MC base=
 addr */=0A=
>> +#define MC_FW_ADDR_MASK_HIGH 0x1FFFF=0A=
>> +#define MC_FW_ADDR_MASK_LOW  0xE0000000=0A=
>> +=0A=
>> +#define MC_BUFFER_OFFSET 0x01000000=0A=
>> +#define MC_BUFFER_SIZE   (1024 * 1024 * 16)=0A=
>> +#define MC_OFFSET_DELTA  MC_BUFFER_OFFSET=0A=
>> +=0A=
>> +#define AIOP_BUFFER_OFFSET 0x06000000=0A=
>> +#define AIOP_BUFFER_SIZE   (1024 * 1024 * 16)=0A=
>> +#define AIOP_OFFSET_DELTA  0=0A=
>> +=0A=
>> +#define LOG_HEADER_FLAG_BUFFER_WRAPAROUND 0x80000000=0A=
>> +#define LAST_BYTE(a) ((a) & ~(LOG_HEADER_FLAG_BUFFER_WRAPAROUND))=0A=
>> +=0A=
>> +/* MC and AIOP Magic words */=0A=
>> +#define MAGIC_MC   0x4d430100=0A=
>> +#define MAGIC_AIOP 0x41494F50=0A=
>> +=0A=
>> +struct log_header {=0A=
>> +       __le32 magic_word;=0A=
>> +       char reserved[4];=0A=
>> +       __le32 buf_start;=0A=
>> +       __le32 buf_length;=0A=
>> +       __le32 last_byte;=0A=
>> +};=0A=
>> +=0A=
>> +struct console_data {=0A=
>> +       char *map_addr;=0A=
>> +       struct log_header *hdr;=0A=
>> +       char *start_addr;=0A=
>> +       char *end_addr;=0A=
>> +       char *end_of_data;=0A=
>> +       char *cur_ptr;=0A=
>> +};=0A=
>> +=0A=
>> +struct resource mc_base_addr;=0A=
>> +=0A=
>> +static inline void adjust_end(struct console_data *cd)=0A=
>> +{=0A=
>> +       u32 last_byte =3D readl(&cd->hdr->last_byte);=0A=
>> +=0A=
>> +       cd->end_of_data =3D cd->start_addr + LAST_BYTE(last_byte);=0A=
>> +}=0A=
>> +=0A=
>> +static u64 get_mc_fw_base_address(void)=0A=
>> +{=0A=
>> +       u64 mcfwbase =3D 0ULL;=0A=
>> +       u32 *mcfbaregs;=0A=
>> +=0A=
>> +       mcfbaregs =3D (u32 *)ioremap(mc_base_addr.start,=0A=
>> +                                  resource_size(&mc_base_addr));=0A=
>> +       if (!mcfbaregs) {=0A=
>> +               pr_err("could not map MC Firmaware Base registers\n");=
=0A=
>> +               return -EIO;=0A=
>> +       }=0A=
>> +=0A=
>> +       mcfwbase  =3D readl(mcfbaregs + MCFBAHR_OFFSET) & MC_FW_ADDR_MAS=
K_HIGH;=0A=
>> +       mcfwbase <<=3D 32;=0A=
>> +       mcfwbase |=3D readl(mcfbaregs + MCFBALR_OFFSET) & MC_FW_ADDR_MAS=
K_LOW;=0A=
>> +       iounmap(mcfbaregs);=0A=
>> +=0A=
>> +       pr_debug("MC base address at 0x%016llx\n", mcfwbase);=0A=
>> +       return mcfwbase;=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t dpaa2_console_size(struct console_data *cd)=0A=
>> +{=0A=
>> +       ssize_t size;=0A=
>> +=0A=
>> +       if (cd->cur_ptr <=3D cd->end_of_data)=0A=
>> +               size =3D cd->end_of_data - cd->cur_ptr;=0A=
>> +       else=0A=
>> +               size =3D (cd->end_addr - cd->cur_ptr) +=0A=
>> +                       (cd->end_of_data - cd->start_addr);=0A=
>> +=0A=
>> +       return size;=0A=
>> +}=0A=
>> +=0A=
>> +static int dpaa2_generic_console_open(struct inode *node, struct file *=
fp,=0A=
>> +                                     u64 offset, u64 size,=0A=
>> +                                     u32 expected_magic,=0A=
>> +                                     u32 offset_delta)=0A=
>> +{=0A=
>> +       u32 read_magic, wrapped, last_byte, buf_start, buf_length;=0A=
>> +       struct console_data *cd;=0A=
>> +       u64 base_addr;=0A=
>> +       int err;=0A=
>> +=0A=
>> +       cd =3D kmalloc(sizeof(*cd), GFP_KERNEL);=0A=
>> +       if (!cd)=0A=
>> +               return -ENOMEM;=0A=
>> +=0A=
>> +       base_addr =3D get_mc_fw_base_address();=0A=
>> +       if (base_addr < 0)=0A=
> =0A=
> We are leaking cd structure here.=0A=
=0A=
Ugh, that's right. Will fix.=0A=
=0A=
> =0A=
>> +               return -EIO;=0A=
>> +=0A=
>> +       cd->map_addr =3D ioremap(base_addr + offset, size);=0A=
>> +       if (!cd->map_addr) {=0A=
>> +               pr_err("cannot map console log memory\n");=0A=
>> +               err =3D -EIO;=0A=
>> +               goto err_ioremap;=0A=
>> +       }=0A=
>> +=0A=
>> +       cd->hdr =3D (struct log_header *)cd->map_addr;=0A=
>> +       read_magic =3D readl(&cd->hdr->magic_word);=0A=
>> +       last_byte =3D readl(&cd->hdr->last_byte);=0A=
>> +       buf_start =3D readl(&cd->hdr->buf_start);=0A=
>> +       buf_length =3D readl(&cd->hdr->buf_length);=0A=
>> +=0A=
>> +       if (read_magic !=3D expected_magic) {=0A=
>> +               pr_warn("expected =3D %08x, read =3D %08x\n",=0A=
>> +                       expected_magic, read_magic);=0A=
>> +               err =3D -EIO;=0A=
>> +               goto err_magic;=0A=
>> +       }=0A=
>> +=0A=
>> +       cd->start_addr =3D cd->map_addr + buf_start - offset_delta;=0A=
>> +       cd->end_addr =3D cd->start_addr + buf_length;=0A=
>> +=0A=
>> +       wrapped =3D last_byte & LOG_HEADER_FLAG_BUFFER_WRAPAROUND;=0A=
>> +=0A=
>> +       adjust_end(cd);=0A=
>> +       if (wrapped && cd->end_of_data !=3D cd->end_addr)=0A=
>> +               cd->cur_ptr =3D cd->end_of_data + 1;=0A=
>> +       else=0A=
>> +               cd->cur_ptr =3D cd->start_addr;=0A=
>> +=0A=
>> +       fp->private_data =3D cd;=0A=
>> +=0A=
>> +       return 0;=0A=
>> +=0A=
>> +err_magic:=0A=
>> +       iounmap(cd->map_addr);=0A=
>> +=0A=
>> +err_ioremap:=0A=
>> +       kfree(cd);=0A=
>> +=0A=
>> +       return err;=0A=
>> +}=0A=
>> +=0A=
>> +static int dpaa2_mc_console_open(struct inode *node, struct file *fp)=
=0A=
>> +{=0A=
>> +       return dpaa2_generic_console_open(node, fp,=0A=
>> +                                         MC_BUFFER_OFFSET, MC_BUFFER_SI=
ZE,=0A=
>> +                                         MAGIC_MC, MC_OFFSET_DELTA);=0A=
>> +}=0A=
>> +=0A=
>> +static int dpaa2_aiop_console_open(struct inode *node, struct file *fp)=
=0A=
>> +{=0A=
>> +       return dpaa2_generic_console_open(node, fp,=0A=
>> +                                         AIOP_BUFFER_OFFSET, AIOP_BUFFE=
R_SIZE,=0A=
>> +                                         MAGIC_AIOP, AIOP_OFFSET_DELTA)=
;=0A=
>> +}=0A=
>> +=0A=
>> +static int dpaa2_console_close(struct inode *node, struct file *fp)=0A=
>> +{=0A=
>> +       struct console_data *cd =3D fp->private_data;=0A=
>> +=0A=
>> +       iounmap(cd->map_addr);=0A=
>> +       kfree(cd);=0A=
>> +       return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,=0A=
>> +                                 size_t count, loff_t *f_pos)=0A=
>> +{=0A=
>> +       struct console_data *cd =3D fp->private_data;=0A=
>> +       size_t bytes =3D dpaa2_console_size(cd);=0A=
>> +       size_t bytes_end =3D cd->end_addr - cd->cur_ptr;=0A=
>> +       size_t written =3D 0;=0A=
>> +=0A=
>> +       /* Check if we need to adjust the end of data addr */=0A=
>> +       adjust_end(cd);=0A=
>> +=0A=
>> +       if (cd->end_of_data =3D=3D cd->cur_ptr)=0A=
>> +               return 0;=0A=
>> +=0A=
>> +       if (count < bytes)=0A=
>> +               bytes =3D count;=0A=
>> +=0A=
>> +       if (bytes > bytes_end) {=0A=
>> +               if (copy_to_user(buf, cd->cur_ptr, bytes_end))=0A=
>> +                       return -EFAULT;=0A=
>> +               buf +=3D bytes_end;=0A=
>> +               cd->cur_ptr =3D cd->start_addr;=0A=
>> +               bytes -=3D bytes_end;=0A=
>> +               written +=3D bytes_end;=0A=
>> +       }=0A=
>> +=0A=
>> +       if (copy_to_user(buf, cd->cur_ptr, bytes))=0A=
>> +               return -EFAULT;=0A=
>> +       cd->cur_ptr +=3D bytes;=0A=
>> +       written +=3D bytes;=0A=
>> +=0A=
>> +       return written;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct file_operations dpaa2_mc_console_fops =3D {=0A=
>> +       .owner          =3D THIS_MODULE,=0A=
>> +       .open           =3D dpaa2_mc_console_open,=0A=
>> +       .release        =3D dpaa2_console_close,=0A=
>> +       .read           =3D dpaa2_console_read,=0A=
>> +};=0A=
>> +=0A=
>> +static struct miscdevice dpaa2_mc_console_dev =3D {=0A=
>> +       .minor =3D MISC_DYNAMIC_MINOR,=0A=
>> +       .name =3D "dpaa2_mc_console",=0A=
>> +       .fops =3D &dpaa2_mc_console_fops=0A=
>> +};=0A=
>> +=0A=
>> +static const struct file_operations dpaa2_aiop_console_fops =3D {=0A=
>> +       .owner          =3D THIS_MODULE,=0A=
>> +       .open           =3D dpaa2_aiop_console_open,=0A=
>> +       .release        =3D dpaa2_console_close,=0A=
>> +       .read           =3D dpaa2_console_read,=0A=
>> +};=0A=
>> +=0A=
>> +static struct miscdevice dpaa2_aiop_console_dev =3D {=0A=
>> +       .minor =3D MISC_DYNAMIC_MINOR,=0A=
>> +       .name =3D "dpaa2_aiop_console",=0A=
>> +       .fops =3D &dpaa2_aiop_console_fops=0A=
>> +};=0A=
>> +=0A=
>> +static int dpaa2_console_probe(struct platform_device *pdev)=0A=
>> +{=0A=
>> +       int error;=0A=
>> +=0A=
>> +       error =3D of_address_to_resource(pdev->dev.of_node, 0, &mc_base_=
addr);=0A=
>> +       if (error < 0) {=0A=
>> +               pr_err("of_address_to_resource() failed for %pOF with %d=
\n",=0A=
>> +                      pdev->dev.of_node, error);=0A=
>> +               return error;=0A=
>> +       }=0A=
>> +=0A=
>> +       error =3D misc_register(&dpaa2_mc_console_dev);=0A=
>> +       if (error) {=0A=
>> +               pr_err("dpaa2-console: cannot register device %s\n",=0A=
>> +                      dpaa2_mc_console_dev.name);=0A=
> =0A=
> The pr_fmt already have the dpaa2-console prefix.=0A=
> =0A=
>> +               goto err_register_mc;=0A=
>> +       }=0A=
>> +=0A=
>> +       error =3D misc_register(&dpaa2_aiop_console_dev);=0A=
>> +       if (error) {=0A=
>> +               pr_err("dpaa2-console: cannot register device %s\n",=0A=
>> +                      dpaa2_aiop_console_dev.name);=0A=
> =0A=
> The pr_fmt already have the dpaa2-console prefix.=0A=
> =0A=
=0A=
=0A=
Yep, will remove the duplicate "dpaa2-console" prefix.=0A=
=0A=
Thanks for the review,=0A=
Ioana C=0A=
=0A=
=0A=
>> +               goto err_register_aiop;=0A=
>> +       }=0A=
>> +=0A=
>> +       return 0;=0A=
>> +=0A=
>> +err_register_aiop:=0A=
>> +       misc_deregister(&dpaa2_mc_console_dev);=0A=
>> +err_register_mc:=0A=
>> +       return error;=0A=
>> +}=0A=
>> +=0A=
>> +static int dpaa2_console_remove(struct platform_device *pdev)=0A=
>> +{=0A=
>> +       misc_deregister(&dpaa2_mc_console_dev);=0A=
>> +       misc_deregister(&dpaa2_aiop_console_dev);=0A=
>> +=0A=
>> +       return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct of_device_id dpaa2_console_match_table[] =3D {=0A=
>> +       { .compatible =3D "fsl,dpaa2-console",},=0A=
>> +       {},=0A=
>> +};=0A=
>> +=0A=
>> +MODULE_DEVICE_TABLE(of, dpaa2_console_match_table);=0A=
>> +=0A=
>> +static struct platform_driver dpaa2_console_driver =3D {=0A=
>> +       .driver =3D {=0A=
>> +                  .name =3D "dpaa2-console",=0A=
>> +                  .pm =3D NULL,=0A=
>> +                  .of_match_table =3D dpaa2_console_match_table,=0A=
>> +                  },=0A=
>> +       .probe =3D dpaa2_console_probe,=0A=
>> +       .remove =3D dpaa2_console_remove,=0A=
>> +};=0A=
>> +module_platform_driver(dpaa2_console_driver);=0A=
>> --=0A=
>> 1.9.1=0A=
>>=0A=
> =0A=
=0A=
