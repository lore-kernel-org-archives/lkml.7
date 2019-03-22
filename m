Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F412C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142742190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfCVQz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:55:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfCVQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:55:26 -0400
Received: from [192.168.1.110] ([95.115.33.167]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MEUaQ-1hEYAx3tQg-00G2Vw; Fri, 22 Mar 2019 17:55:18 +0100
Subject: Re: [PATCH 4/4] Add support for SUNIX Multi-I/O board
To:     Morris Ku <saumah@gmail.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
References: <20190319120835.3840-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <bf8659eb-ecf8-a9e4-33f1-c9bbb7f5ee13@metux.net>
Date:   Fri, 22 Mar 2019 17:55:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190319120835.3840-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eWiRukjkQv7QLGfAKWueAKIrFtlx0msPgswVfbyYFMJdh8zPSPT
 3Qc+GGgXdBoEOEctmrxQq+R0hslQYMO0NbTEjxnGfUe730WIjpsb9FJqkiXDrSBCKPl3ctE
 6vXBLckxpuG0Yo/7Jd/oRETfCqGcjZgm/hGLnWOZtbSxsxPLQkM2AWbns6/cECobr8Tnef2
 AWqHTYtC5Aid4C4YPL1IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OAYMStKONtA=:a0yX2oYsJ1Yc71MZPu+xmF
 BrWBGpq0dikCTRJXTKV46OQs2vZQEhNAKQ+XJSaQo/c0FxeZmGfZZ26Tdivict5C7E3XBonaA
 M22sGFIpVRQ1RITkndQv8CBSu/4llCZnMw8eDIxgs5fCTuUgEi8P+m821tPbE2eOKpZ/rshR4
 aV+fomQJKctPQhiMzSUJHveE9FacXWD/lK3+UCGMdcyOD4N9z1O2KSFN9K6o33fP2k9QfC1eq
 rRiNC2EVh2awUmj39hBBdt2WtZyTBLps05mAri0z2bt1W2w+LJnXCNPFEm6BfWCnYVeqC+Mcm
 lkAPFI7UtQQWnnygjLKPQIeZwMenUvdxUa7NHfIeL243drIeoxS+BmVwKolUpsG89Z99oqGj+
 dtyRBjtzXRgK5wrw6F5K3dPKwFJ4iMjVGQmC4kstez0c1MMF7s/Vqumu2DEB2ZwubkdtbFlaW
 8acJ1GMPSuV/x2YnpKq/RnwADLQOSHiIrss5PQ5uuWNm4LwmRqIpow7pSNzVkbjsIA7WLRm9j
 cSDFzobHS3xtmbTLrTffPp7qZK1lSoC1gv1oVQj/SdF8pA7TxCkEmA5HaK6Nyfpf+iFPl2ln+
 Vq22Ur6qlZGTISaETReNPgiLMvLqydL1IFEH580B3U0lh9fHwwtCzrhnagXL5emjYHwk1suvv
 mRvv5SlIlIjlxmIl9KrHyWiShxvq3raXF/gfLSmV3vGdXdBir9gnDTsHWP/Ek4mnZix0rkQRw
 oefXw8P+ONQ4bKQttHg6SPc8GLC239WwmZEPLyLL9KY50DpAyTf4hOB4MJw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.19 13:08, Morris Ku wrote:

> diff --git a/mfd/sunix/snx_ieee1284_ops.c b/mfd/sunix/snx_ieee1284_ops.c
> new file mode 100644
> index 00000000..2dac03fd
> --- /dev/null

<snip>

> +size_t sunix_parport_ieee1284_read_nibble(struct snx_parport *port,
> +void *buffer, size_t len, int flags)
> +{
> +	return 0;
> +}
> +
> +size_t sunix_parport_ieee1284_read_byte(struct snx_parport *port,
> +void *buffer, size_t len, int flags)
> +{
> +	return 0;
> +}
> +
> +size_t sunix_parport_ieee1284_ecp_write_data(struct snx_parport *port,
> +const void *buffer, size_t len, int flags)
> +{
> +	return 0;
> +}
> +
> +size_t sunix_parport_ieee1284_ecp_read_data(struct snx_parport *port,
> +void *buffer, size_t len, int flags)
> +{
> +	return 0;
> +}
> +
> +size_t sunix_parport_ieee1284_ecp_write_addr(struct snx_parport *port,
> +const void *buffer, size_t len, int flags)
> +{
> +	return 0;
> +}

Why are these all no-ops ?

> diff --git a/mfd/sunix/snx_lp.c b/mfd/sunix/snx_lp.c
> new file mode 100644
> index 00000000..f2478447
> --- /dev/null
> +++ b/mfd/sunix/snx_lp.c

<snip>

> +#undef SNX_LP_STATS

what is this ?

> +static int SNX_PAL_MAJOR;
> +
> +#define SNX_LP_NO SNX_PAR_TOTAL_MAX
> +#undef SNX_CONFIG_LP_CONSOLE

and this ?

> +#ifdef SNX_CONFIG_PARPORT_1284

dont do #define in the middle of the code.

> +static const struct file_operations snx_lp_fops = {
> +	.owner		= THIS_MODULE,
> +	.write		= snx_lp_write,
> +	.open		= snx_lp_open,
> +	.release	= snx_lp_release,
> +#ifdef SNX_CONFIG_PARPORT_1284
> +	.read		= snx_lp_read,
> +#endif
> +};

dont reimplement existing standard functionality your own weird way.
use the partport subsystem. see: Documentation/parport-lowlevel.txt

> +static struct snx_parport_driver snx_lp_driver = {
> +	.name = "lx",
> +	.attach = snx_lp_attach,
> +	.detach = snx_lp_detach,
> +};

yet another case of duplication of some standard struct and hard-
typecasting ? use struct parport_driver here.

> +	SNX_PAL_MAJOR = register_chrdev(0, "lx", &snx_lp_fops);

dont register your own chardev - use the parport subsystem.

> diff --git a/mfd/sunix/snx_parallel.c b/mfd/sunix/snx_parallel.c
> new file mode 100644
> index 00000000..461ea4cc
> --- /dev/null

<snip>

> +struct snx_parport *sunix_parport_pc_probe_port(struct sunix_par_port *priv)
> +{
> +	struct snx_parport_ops *ops = NULL;
> +	struct snx_parport *p = NULL;
> +	struct resource *base_res;
> +	struct resource	*ecr_res = NULL;
> +
> +	if (!priv)
> +		goto out1;
> +
> +	ops = kmalloc(sizeof(struct snx_parport_ops), GFP_KERNEL);

why not kzmalloc ?

> diff --git a/mfd/sunix/snx_ppdev.c b/mfd/sunix/snx_ppdev.c
> new file mode 100644
> index 00000000..9482ed9f
> --- /dev/null
> +++ b/mfd/sunix/snx_ppdev.c

<snip>

> +static const struct file_operations snx_pp_fops = {
> +	.owner		= THIS_MODULE,
> +	.llseek		= no_llseek,
> +	.read		= snx_pp_read,
> +	.write		= snx_pp_write,
> +	.poll		= snx_pp_poll,
> +	.unlocked_ioctl	= snx_dump_par_ioctl,
> +
> +	.open		= snx_pp_open,
> +	.release	= snx_pp_release,
> +};

don't reimplement existing standard functionality - use the parport
subsystem.

> diff --git a/mfd/sunix/snx_ppdev.h b/mfd/sunix/snx_ppdev.h
> new file mode 100644
> index 00000000..0dfec064
> --- /dev/null
> +++ b/mfd/sunix/snx_ppdev.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include "snx_common.h"
> +
> +#define SNX_PP_IOCTL	'p'
> +
> +#define SNX_PP_FASTWRITE	(1<<2)
> +#define SNX_PP_FASTREAD		(1<<3)
> +#define SNX_PP_W91284PIC	(1<<4)

use the BIT() macro

> diff --git a/mfd/sunix/snx_share.c b/mfd/sunix/snx_share.c
> new file mode 100644
> index 00000000..ba6f86a2
> --- /dev/null
> +++ b/mfd/sunix/snx_share.c
> @@ -0,0 +1,629 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "snx_common.h"
> +#define SNX_PARPORT_DEFAULT_TIMESLICE	(HZ/5)
> +
> +unsigned long sunix_parport_default_timeslice = SNX_PARPORT_DEFAULT_TIMESLICE;
> +int sunix_parport_default_spintime = DEFAULT_SPIN_TIME;
> +
> +static LIST_HEAD(snx_portlist);
> +static DEFINE_SPINLOCK(snx_full_list_lock);
> +
> +static DEFINE_SPINLOCK(snx_parportlist_lock);
> +
> +static LIST_HEAD(snx_all_ports);
> +static LIST_HEAD(snx_drivers);
> +
> +static DEFINE_SEMAPHORE(snx_registration_lock);
> +
> +static void sunix_dead_write_lines(
> +struct snx_parport *p, unsigned char b)
> +{}
> +static unsigned char sunix_dead_read_lines(
> +struct snx_parport *p)
> +{ return 0; }
> +static unsigned char sunix_dead_frob_lines(
> +struct snx_parport *p, unsigned char b, unsigned char c)
> +{ return 0; }
> +static void sunix_dead_onearg(struct snx_parport *p)
> +{}
> +static void sunix_dead_initstate(
> +struct snx_pardevice *d, struct snx_parport_state *s)
> +{}
> +static void sunix_dead_state(
> +struct snx_parport *p, struct snx_parport_state *s)
> +{}
> +static size_t sunix_dead_write(
> +struct snx_parport *p, const void *b, size_t l, int f)
> +{ return 0; }
> +static size_t sunix_dead_read(
> +struct snx_parport *p, void *b, size_t l, int f)
> +{ return 0; }
> +
> +
> +static struct snx_parport_ops	sunix_dead_ops = {
> +	.write_data			= sunix_dead_write_lines,
> +	.read_data			= sunix_dead_read_lines,
> +	.write_control		= sunix_dead_write_lines,
> +	.read_control		= sunix_dead_read_lines,
> +	.frob_control		= sunix_dead_frob_lines,
> +	.read_status		= sunix_dead_read_lines,
> +	.enable_irq			= sunix_dead_onearg,
> +	.disable_irq		= sunix_dead_onearg,
> +	.data_forward		= sunix_dead_onearg,
> +	.data_reverse		= sunix_dead_onearg,
> +	.init_state			= sunix_dead_initstate,
> +	.save_state			= sunix_dead_state,
> +	.restore_state		= sunix_dead_state,
> +	.epp_write_data		= sunix_dead_write,
> +	.epp_read_data		= sunix_dead_read,
> +	.epp_write_addr		= sunix_dead_write,
> +	.epp_read_addr		= sunix_dead_read,
> +	.ecp_write_data		= sunix_dead_write,
> +	.ecp_read_data		= sunix_dead_read,
> +	.ecp_write_addr		= sunix_dead_write,
> +	.compat_write_data	= sunix_dead_write,
> +	.nibble_read_data	= sunix_dead_read,
> +	.byte_read_data		= sunix_dead_read,
> +	.owner				= NULL,
> +};

don't reimplement existing standard functionality. use the parport
subsystem.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
