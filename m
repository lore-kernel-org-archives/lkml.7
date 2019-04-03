Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D30C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58638206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDCTzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:55:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40356 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCTzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:55:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id t8so128713otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RT/NvnxYPYjKcgup7kkuL9JuGznfN3Q1g1WipRC+rBk=;
        b=BH4YdDfpqTgaKamVOZPmb8bgCs18d4FXUjZtMJAEH8b7QFzleH4MmZvjzfUuCCpS5J
         42i6wEb9OfM1yNCu6Z9VOQvS3H9rtZiDeBsQkS0tMg4vmqYdbIditZ0GLn4KG5vceQ9Y
         C8XlopF0PfVyVOguvEadgEHwy5ih2KWglCHUHeZAn+FGOxbwNCr6zZ4FLD0fzEz2xYKl
         C0VeldDiBNJQEZCZjTAAUgpejcatxQvDJNn6h3L2G1oPPBB9BuF8mNVXoJvJLx+PaP82
         oEgufEfIxlTuPj7mbnyYymgP3TetsR8EAQmKWGUVq0w+/F/AmUpuwB6nCJXrGRjGakD5
         eYjg==
X-Gm-Message-State: APjAAAWqWDbtTE1GA8MJrW/hrv/2N6iwjfWMxsHvPeXD30395UXprrgd
        sKURiaYRxD8pRUxfAFon84jIT4copFA=
X-Google-Smtp-Source: APXvYqzEFqj6XxOSMmn/5Ughk9xToF5BvlomPOBfs+P5bFlHW5bxlR9G4x8dtVUPvFd/PfAQxoDcKQ==
X-Received: by 2002:a9d:6344:: with SMTP id y4mr1172396otk.11.1554321334197;
        Wed, 03 Apr 2019 12:55:34 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id y1sm7704068ota.38.2019.04.03.12.55.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 12:55:33 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 103so116668otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:55:33 -0700 (PDT)
X-Received: by 2002:a9d:191a:: with SMTP id j26mr1005749ota.327.1554321333489;
 Wed, 03 Apr 2019 12:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <1553627718-23714-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1553627718-23714-1-git-send-email-ioana.ciornei@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 3 Apr 2019 14:55:21 -0500
X-Gmail-Original-Message-ID: <CADRPPNSPsRJEPW9uMNoDAEqYvKYPF2ybJX7a48rJJqap3nwOtw@mail.gmail.com>
Message-ID: <CADRPPNSPsRJEPW9uMNoDAEqYvKYPF2ybJX7a48rJJqap3nwOtw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: add DPAA2 console support
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 2:17 PM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> This patch adds DPAA2 MC and AIOP console log support.
>
> The platform driver probes on the "fsl,dpaa2-console" device tree node
> which describes the base firmware address needed in order to infer the
> start address of both firmware logs: MC and AIOP.
> It then exports two misc char devices which can be used to dump
> the needed logs.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig         |  10 ++
>  drivers/soc/fsl/Makefile        |   1 +
>  drivers/soc/fsl/dpaa2-console.c | 306 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 317 insertions(+)
>  create mode 100644 drivers/soc/fsl/dpaa2-console.c
>
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 61f8e1433d0a..9fe8222c3968 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -29,4 +29,14 @@ config FSL_MC_DPIO
>           other DPAA2 objects. This driver does not expose the DPIO
>           objects individually, but groups them under a service layer
>           API.
> +
> +config DPAA2_CONSOLE
> +       tristate "QorIQ DPAA2 console driver"
> +       depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86_LOCAL_APIC || PPC)))

I don't know why FSL_MC driver added there architectures dependency
for COMPILE_TEST, but is this driver also only buildable on these
architectures?  Can we really just remove these dependencies?

> +       default y
> +       help
> +         Console driver for DPAA2 platforms. Exports 2 char devices,
> +         /dev/dpaa2_mc_console and /dev/dpaa2_aiop_console,
> +         which can be used to dump the Management Complex and AIOP
> +         firmware logs.
>  endmenu
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> index 803ef1bfb5ff..57762c9fc7da 100644
> --- a/drivers/soc/fsl/Makefile
> +++ b/drivers/soc/fsl/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)              += qe/
>  obj-$(CONFIG_CPM)                      += qe/
>  obj-$(CONFIG_FSL_GUTS)                 += guts.o
>  obj-$(CONFIG_FSL_MC_DPIO)              += dpio/
> +obj-$(CONFIG_DPAA2_CONSOLE)            += dpaa2-console.o
> diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-console.c
> new file mode 100644
> index 000000000000..21a5e121f87b
> --- /dev/null
> +++ b/drivers/soc/fsl/dpaa2-console.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)

Probably good to have a one-line description of the driver?

> +/* Copyright 2015-2016 Freescale Semiconductor Inc.
> + * Copyright 2018 NXP
> + */
> +
> +#define pr_fmt(fmt) "dpaa2-console: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/miscdevice.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Roy Pledge <roy.pledge@nxp.com>");
> +MODULE_DESCRIPTION("DPAA2 console driver");

These normally go to the bottom of a driver.

> +
> +/* MC firmware base low/high registers indexes */
> +#define MCFBALR_OFFSET 0
> +#define MCFBAHR_OFFSET 1
> +
> +/* Bit masks used to get the most/least significant part of the MC base addr */
> +#define MC_FW_ADDR_MASK_HIGH 0x1FFFF
> +#define MC_FW_ADDR_MASK_LOW  0xE0000000
> +
> +#define MC_BUFFER_OFFSET 0x01000000
> +#define MC_BUFFER_SIZE   (1024 * 1024 * 16)
> +#define MC_OFFSET_DELTA  MC_BUFFER_OFFSET
> +
> +#define AIOP_BUFFER_OFFSET 0x06000000
> +#define AIOP_BUFFER_SIZE   (1024 * 1024 * 16)
> +#define AIOP_OFFSET_DELTA  0
> +
> +#define LOG_HEADER_FLAG_BUFFER_WRAPAROUND 0x80000000
> +#define LAST_BYTE(a) ((a) & ~(LOG_HEADER_FLAG_BUFFER_WRAPAROUND))
> +
> +/* MC and AIOP Magic words */
> +#define MAGIC_MC   0x4d430100
> +#define MAGIC_AIOP 0x41494F50
> +
> +struct log_header {
> +       __le32 magic_word;
> +       char reserved[4];
> +       __le32 buf_start;
> +       __le32 buf_length;
> +       __le32 last_byte;
> +};
> +
> +struct console_data {
> +       char *map_addr;
> +       struct log_header *hdr;
> +       char *start_addr;
> +       char *end_addr;
> +       char *end_of_data;
> +       char *cur_ptr;
> +};
> +
> +struct resource mc_base_addr;
> +
> +static inline void adjust_end(struct console_data *cd)
> +{
> +       u32 last_byte = readl(&cd->hdr->last_byte);
> +
> +       cd->end_of_data = cd->start_addr + LAST_BYTE(last_byte);
> +}
> +
> +static u64 get_mc_fw_base_address(void)
> +{
> +       u64 mcfwbase = 0ULL;
> +       u32 *mcfbaregs;
> +
> +       mcfbaregs = (u32 *)ioremap(mc_base_addr.start,
> +                                  resource_size(&mc_base_addr));
> +       if (!mcfbaregs) {
> +               pr_err("could not map MC Firmaware Base registers\n");
> +               return -EIO;
> +       }
> +
> +       mcfwbase  = readl(mcfbaregs + MCFBAHR_OFFSET) & MC_FW_ADDR_MASK_HIGH;
> +       mcfwbase <<= 32;
> +       mcfwbase |= readl(mcfbaregs + MCFBALR_OFFSET) & MC_FW_ADDR_MASK_LOW;
> +       iounmap(mcfbaregs);
> +
> +       pr_debug("MC base address at 0x%016llx\n", mcfwbase);
> +       return mcfwbase;
> +}
> +
> +static ssize_t dpaa2_console_size(struct console_data *cd)
> +{
> +       ssize_t size;
> +
> +       if (cd->cur_ptr <= cd->end_of_data)
> +               size = cd->end_of_data - cd->cur_ptr;
> +       else
> +               size = (cd->end_addr - cd->cur_ptr) +
> +                       (cd->end_of_data - cd->start_addr);
> +
> +       return size;
> +}
> +
> +static int dpaa2_generic_console_open(struct inode *node, struct file *fp,
> +                                     u64 offset, u64 size,
> +                                     u32 expected_magic,
> +                                     u32 offset_delta)
> +{
> +       u32 read_magic, wrapped, last_byte, buf_start, buf_length;
> +       struct console_data *cd;
> +       u64 base_addr;
> +       int err;
> +
> +       cd = kmalloc(sizeof(*cd), GFP_KERNEL);
> +       if (!cd)
> +               return -ENOMEM;
> +
> +       base_addr = get_mc_fw_base_address();
> +       if (base_addr < 0)

We are leaking cd structure here.

> +               return -EIO;
> +
> +       cd->map_addr = ioremap(base_addr + offset, size);
> +       if (!cd->map_addr) {
> +               pr_err("cannot map console log memory\n");
> +               err = -EIO;
> +               goto err_ioremap;
> +       }
> +
> +       cd->hdr = (struct log_header *)cd->map_addr;
> +       read_magic = readl(&cd->hdr->magic_word);
> +       last_byte = readl(&cd->hdr->last_byte);
> +       buf_start = readl(&cd->hdr->buf_start);
> +       buf_length = readl(&cd->hdr->buf_length);
> +
> +       if (read_magic != expected_magic) {
> +               pr_warn("expected = %08x, read = %08x\n",
> +                       expected_magic, read_magic);
> +               err = -EIO;
> +               goto err_magic;
> +       }
> +
> +       cd->start_addr = cd->map_addr + buf_start - offset_delta;
> +       cd->end_addr = cd->start_addr + buf_length;
> +
> +       wrapped = last_byte & LOG_HEADER_FLAG_BUFFER_WRAPAROUND;
> +
> +       adjust_end(cd);
> +       if (wrapped && cd->end_of_data != cd->end_addr)
> +               cd->cur_ptr = cd->end_of_data + 1;
> +       else
> +               cd->cur_ptr = cd->start_addr;
> +
> +       fp->private_data = cd;
> +
> +       return 0;
> +
> +err_magic:
> +       iounmap(cd->map_addr);
> +
> +err_ioremap:
> +       kfree(cd);
> +
> +       return err;
> +}
> +
> +static int dpaa2_mc_console_open(struct inode *node, struct file *fp)
> +{
> +       return dpaa2_generic_console_open(node, fp,
> +                                         MC_BUFFER_OFFSET, MC_BUFFER_SIZE,
> +                                         MAGIC_MC, MC_OFFSET_DELTA);
> +}
> +
> +static int dpaa2_aiop_console_open(struct inode *node, struct file *fp)
> +{
> +       return dpaa2_generic_console_open(node, fp,
> +                                         AIOP_BUFFER_OFFSET, AIOP_BUFFER_SIZE,
> +                                         MAGIC_AIOP, AIOP_OFFSET_DELTA);
> +}
> +
> +static int dpaa2_console_close(struct inode *node, struct file *fp)
> +{
> +       struct console_data *cd = fp->private_data;
> +
> +       iounmap(cd->map_addr);
> +       kfree(cd);
> +       return 0;
> +}
> +
> +static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,
> +                                 size_t count, loff_t *f_pos)
> +{
> +       struct console_data *cd = fp->private_data;
> +       size_t bytes = dpaa2_console_size(cd);
> +       size_t bytes_end = cd->end_addr - cd->cur_ptr;
> +       size_t written = 0;
> +
> +       /* Check if we need to adjust the end of data addr */
> +       adjust_end(cd);
> +
> +       if (cd->end_of_data == cd->cur_ptr)
> +               return 0;
> +
> +       if (count < bytes)
> +               bytes = count;
> +
> +       if (bytes > bytes_end) {
> +               if (copy_to_user(buf, cd->cur_ptr, bytes_end))
> +                       return -EFAULT;
> +               buf += bytes_end;
> +               cd->cur_ptr = cd->start_addr;
> +               bytes -= bytes_end;
> +               written += bytes_end;
> +       }
> +
> +       if (copy_to_user(buf, cd->cur_ptr, bytes))
> +               return -EFAULT;
> +       cd->cur_ptr += bytes;
> +       written += bytes;
> +
> +       return written;
> +}
> +
> +static const struct file_operations dpaa2_mc_console_fops = {
> +       .owner          = THIS_MODULE,
> +       .open           = dpaa2_mc_console_open,
> +       .release        = dpaa2_console_close,
> +       .read           = dpaa2_console_read,
> +};
> +
> +static struct miscdevice dpaa2_mc_console_dev = {
> +       .minor = MISC_DYNAMIC_MINOR,
> +       .name = "dpaa2_mc_console",
> +       .fops = &dpaa2_mc_console_fops
> +};
> +
> +static const struct file_operations dpaa2_aiop_console_fops = {
> +       .owner          = THIS_MODULE,
> +       .open           = dpaa2_aiop_console_open,
> +       .release        = dpaa2_console_close,
> +       .read           = dpaa2_console_read,
> +};
> +
> +static struct miscdevice dpaa2_aiop_console_dev = {
> +       .minor = MISC_DYNAMIC_MINOR,
> +       .name = "dpaa2_aiop_console",
> +       .fops = &dpaa2_aiop_console_fops
> +};
> +
> +static int dpaa2_console_probe(struct platform_device *pdev)
> +{
> +       int error;
> +
> +       error = of_address_to_resource(pdev->dev.of_node, 0, &mc_base_addr);
> +       if (error < 0) {
> +               pr_err("of_address_to_resource() failed for %pOF with %d\n",
> +                      pdev->dev.of_node, error);
> +               return error;
> +       }
> +
> +       error = misc_register(&dpaa2_mc_console_dev);
> +       if (error) {
> +               pr_err("dpaa2-console: cannot register device %s\n",
> +                      dpaa2_mc_console_dev.name);

The pr_fmt already have the dpaa2-console prefix.

> +               goto err_register_mc;
> +       }
> +
> +       error = misc_register(&dpaa2_aiop_console_dev);
> +       if (error) {
> +               pr_err("dpaa2-console: cannot register device %s\n",
> +                      dpaa2_aiop_console_dev.name);

The pr_fmt already have the dpaa2-console prefix.

> +               goto err_register_aiop;
> +       }
> +
> +       return 0;
> +
> +err_register_aiop:
> +       misc_deregister(&dpaa2_mc_console_dev);
> +err_register_mc:
> +       return error;
> +}
> +
> +static int dpaa2_console_remove(struct platform_device *pdev)
> +{
> +       misc_deregister(&dpaa2_mc_console_dev);
> +       misc_deregister(&dpaa2_aiop_console_dev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id dpaa2_console_match_table[] = {
> +       { .compatible = "fsl,dpaa2-console",},
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, dpaa2_console_match_table);
> +
> +static struct platform_driver dpaa2_console_driver = {
> +       .driver = {
> +                  .name = "dpaa2-console",
> +                  .pm = NULL,
> +                  .of_match_table = dpaa2_console_match_table,
> +                  },
> +       .probe = dpaa2_console_probe,
> +       .remove = dpaa2_console_remove,
> +};
> +module_platform_driver(dpaa2_console_driver);
> --
> 1.9.1
>
