Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7316AC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A020869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDLQK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:10:59 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:10:59 -0400
Received: from [192.168.1.110] ([77.9.22.14]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZCOl-1hJfkq3nqj-00V86X; Fri, 12 Apr 2019 18:10:46 +0200
Subject: Re: [PATCH 4/4 V2] Add support for SUNIX Multi-IO board
To:     Morris Ku <saumah@gmail.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
References: <20190412133653.3932-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <5dafa790-4ec9-f651-e5be-efb68e98bbe6@metux.net>
Date:   Fri, 12 Apr 2019 18:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190412133653.3932-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sxOfx/0WhG4pRt9AzNZ2XA3tdDIBaH4n9qhqGq0BV4qIPcGHM8k
 hREGwCCRHFmZOW+iEb81w5WHsRFKzvuMEv9cJsc4q9E9y8IdTf5WaVB/diMU/o0JINeWu9M
 H9T4f8AGDyz5Q9bzW7rVK84j1VTc4E6OZ1hmIbPK4aAX9SWgH9jV8lhO7omxc6ki97FucwO
 9eHvK15JDbFTCK2EBYcMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9S5E/3UZPlg=:fjStcfrIuOanov/dgJtEgZ
 I4841eIdbd6YDTsRuJ3aerQZW2cPAwaKaHXqe2DEEJAOEQFKNdLK4f069CbkfQu6IbI0j5V7i
 kNnAoOtO+wBArxSj61WGJPoigAnL8mQnn/UICZxzCEKEijNb4bFj3jpFBCD0ymh1wRDktALZQ
 NdHCFhMM/nMB215LTuooxasm8dOYbwDm9EN5Hu9zLkv3c+1GyMBBEHQIZpTWRwSkZ+dc/At8H
 FfenroL1t7QC3Wbf77HEanASw42R+UYiwBGsl3/zpl+740hHzjv4e0P5i+WvngTxSPdfnRxob
 wJk/kMNkUf48jxSr2Pfs5t0O5mCRY3tzqiZs8p2sKYBkHHe+aLFmeWfr/ESOhgFd7570VOG61
 ZE7vQ8947M9snlHPo50MXqY6nJMoxskmC5N+75zPTroshxq8XUkt68r2RfLny55F6R6D3TEHs
 2Sv4cXKxon7wtA/AAL2E2UraWDbIjc9n6ExQ3v+kIP9Il6xPmzAxk/xYeOpo9BL8YFrrrVPnD
 oVDZqapjJLhj69k/fQctIzTIfBa5i4JQ3zfOfg4GDHPF/0K+GZ6hwOGTHR9R4wZdSmUrWYDnT
 TrN6rGZjRmbvoC/cH/kQTL81a/ERH0HffHipKrbdvXG1nUYCrJo9aUR4U3jHIgO6TbIc7tUBJ
 8xRZFiU1OnGb0InS9TGmkogNKefWtss/hju9kK6AgKlz1CJXOcLdBqQUSn8cqzCxA6A5nKbQa
 nlD2YP/DwaXzkq2ETVSyFfbPY16pjNqB8YwC2VidY5JQJ1RHJs4f0NJFLv0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.19 15:36, Morris Ku wrote:
> This patch is a reincarnation of the first version of the
> fix which has been discussed as not a correct approach.



> diff --git a/drivers/mfd/sunix/snx_ieee1284.c b/drivers/mfd/sunix/snx_ieee1284.c
> new file mode 100644
> index 000000000000..94adf24e53e1
> --- /dev/null
> +++ b/drivers/mfd/sunix/snx_ieee1284.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "snx_common.h"
> +
> +static void sunix_parport_ieee1284_wakeup(struct parport *port)
> +{
> +	up(&port->physport->ieee1284.irq);
> +}
> +
> +static void sunix_timeout_waiting_on_port(struct timer_list *t)
> +{
> +	struct parport *port = from_timer(port, t, timer);
> +
> +	sunix_parport_ieee1284_wakeup(port);
> +}
> +
> +int sunix_parport_wait_event(struct parport *port, signed long timeout)
> +{
> +	int ret;
> +
> +	if (!port->physport->cad->timeout)
> +		return 1;
> +
> +	timer_setup(&port->timer, sunix_timeout_waiting_on_port, 0);
> +	mod_timer(&port->timer, jiffies + timeout);
> +
> +	ret = down_interruptible(&port->physport->ieee1284.irq);
> +
> +	if (!del_timer(&port->timer) && !ret)
> +		ret = 1;
> +
> +	return      ret;
> +}
> +
> +
> +int sunix_parport_poll_peripheral(struct parport *port, unsigned char mask,
> +unsigned char result, int usec)
> +{
> +	int count = usec / 5 + 2;
> +	int i;
> +	unsigned char status;
> +
> +	for (i = 0; i < count; i++) {
> +		status = sunix_parport_read_status(port);
> +
> +		if ((status & mask) == result)
> +			return 0;
> +
> +		if (signal_pending(current))
> +			return -EINTR;
> +
> +		if (need_resched())
> +			break;
> +
> +		if (i >= 2)
> +			udelay(5);
> +
> +	}
> +
> +	return 1;
> +}
> +
> +
> +int sunix_parport_wait_peripheral(struct parport *port,
> +unsigned char mask, unsigned char result)
> +{
> +	int ret;
> +	int usec;
> +	unsigned long deadline;
> +	unsigned char status;
> +
> +	usec = port->physport->spintime;
> +
> +	if (!port->physport->cad->timeout)
> +		usec = 35000;
> +
> +	ret = sunix_parport_poll_peripheral(port, mask, result, usec);
> +
> +	if (ret != 1)
> +		return ret;
> +
> +	if (!port->physport->cad->timeout)
> +		return 1;
> +
> +	deadline = jiffies + (HZ + 24) / 25;
> +
> +	while (time_before(jiffies, deadline)) {
> +		int ret;
> +
> +		if (signal_pending(current))
> +			return -EINTR;
> +
> +		ret = sunix_parport_wait_event(port, (HZ + 99) / 100);
> +		if (ret < 0)
> +			return ret;
> +
> +		status = sunix_parport_read_status(port);
> +		if ((status & mask) == result)
> +			return 0;
> +
> +		if (!ret)
> +			schedule_timeout_interruptible(msecs_to_jiffies(10));
> +	}
> +
> +	return 1;
> +}
> +
> +
> +int sunix_parport_negotiate(struct parport *port, int mode)
> +{
> +	if (mode == IEEE1284_MODE_COMPAT)
> +		return 0;
> +
> +	return -1;
> +}
> +
> +
> +ssize_t sunix_parport_write(struct parport *port,
> +const void *buffer, size_t len)
> +{
> +	ssize_t ret;
> +
> +	ret = port->ops->compat_write_data(port, buffer, len, 0);
> +
> +	return ret;
> +}
> +
> +
> +ssize_t sunix_parport_read(struct parport *port, void *buffer, size_t len)
> +{
> +	return -ENODEV;
> +}
> +
> +
> +long sunix_parport_set_timeout(struct pardevice *dev, long inactivity)
> +{
> +	long int old = dev->timeout;
> +
> +	dev->timeout = inactivity;
> +
> +	if (dev->port->physport->cad == dev)
> +		sunix_parport_ieee1284_wakeup(dev->port);
> +
> +	return old;
> +}
> diff --git a/drivers/mfd/sunix/snx_ieee1284_ops.c b/drivers/mfd/sunix/snx_ieee1284_ops.c
> new file mode 100644
> index 000000000000..5e0a80d36953
> --- /dev/null
> +++ b/drivers/mfd/sunix/snx_ieee1284_ops.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "snx_common.h"
> +
> +
> +size_t sunix_parport_ieee1284_write_compat(struct parport *port,
> +const void *buffer, size_t len, int flags)
> +{
> +	int no_irq = 1;
> +	ssize_t count = 0;
> +	const unsigned char *addr = buffer;
> +	unsigned char byte;
> +	struct pardevice *dev = port->physport->cad;
> +	unsigned char ctl = (PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT);
> +
> +	if (port->irq != PARPORT_IRQ_NONE) {
> +		sunix_parport_enable_irq(port);
> +		no_irq = 0;
> +	}
> +
> +	port->physport->ieee1284.phase = IEEE1284_PH_FWD_DATA;
> +	sunix_parport_write_control(port, ctl);
> +	sunix_parport_data_forward(port);
> +
> +	while (count < len) {
> +		unsigned long expire = jiffies + dev->timeout;
> +		long wait = (HZ + 99) / 100;
> +		unsigned char mask = (PARPORT_STATUS_ERROR |
> +		PARPORT_STATUS_BUSY);
> +		unsigned char val = (PARPORT_STATUS_ERROR |
> +		PARPORT_STATUS_BUSY);
> +
> +		do {
> +			if (!sunix_parport_wait_peripheral(port, mask, val))
> +				goto ready;
> +
> +			if ((sunix_parport_read_status(port) &
> +			(PARPORT_STATUS_PAPEROUT | PARPORT_STATUS_SELECT |
> +			PARPORT_STATUS_ERROR)) != (PARPORT_STATUS_SELECT |
> +			PARPORT_STATUS_ERROR))
> +				goto stop;
> +
> +			if (!time_before(jiffies, expire))
> +				break;
> +
> +			if (count && no_irq) {
> +				sunix_parport_release(dev);
> +
> +				schedule_timeout_interruptible(wait);
> +
> +				sunix_parport_claim_or_block(dev);
> +			} else {
> +				sunix_parport_wait_event(port, wait);
> +			}
> +
> +			if (signal_pending(current))
> +				break;
> +
> +			wait *= 2;
> +		} while (time_before(jiffies, expire));
> +
> +		if (signal_pending(current))
> +			break;
> +
> +		break;
> +
> +ready:
> +		byte = *addr++;
> +		sunix_parport_write_data(port, byte);
> +		udelay(1);
> +
> +		sunix_parport_write_control(port, ctl | PARPORT_CONTROL_STROBE);
> +		udelay(1);
> +
> +		sunix_parport_write_control(port, ctl);
> +		udelay(1);
> +
> +		count++;
> +
> +		if (time_before(jiffies, expire)) {
> +			if (!sunix_parport_yield_blocking(dev) &&
> +			need_resched())
> +				schedule();
> +		}
> +	}
> +stop:
> +	port->physport->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
> +
> +	return count;
> +}
> +
> +size_t sunix_parport_ieee1284_epp_write_data(struct parport *port,
> +const void *buffer, size_t len, int flags)
> +{
> +	unsigned char *bp = (unsigned char *) buffer;
> +	size_t ret = 0;
> +
> +	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE |
> +	PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT |
> +	PARPORT_CONTROL_INIT, PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
> +
> +	port->ops->data_forward(port);
> +
> +	for (; len > 0; len--, bp++) {
> +		sunix_parport_write_data(port, *bp);
> +		sunix_parport_frob_control(port, PARPORT_CONTROL_AUTOFD,
> +		PARPORT_CONTROL_AUTOFD);
> +
> +		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
> +		0, 10))
> +			break;
> +
> +		sunix_parport_frob_control(port, PARPORT_CONTROL_AUTOFD, 0);
> +
> +		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
> +		PARPORT_STATUS_BUSY, 5))
> +			break;
> +
> +		ret++;
> +	}
> +
> +	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE, 0);
> +	return ret;
> +}
> +
> +
> +size_t sunix_parport_ieee1284_epp_read_data(struct parport *port,
> +void *buffer, size_t len, int flags)
> +{
> +	unsigned char *bp = (unsigned char *) buffer;
> +	unsigned int ret = 0;
> +
> +	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE |
> +	PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT |
> +	PARPORT_CONTROL_INIT, PARPORT_CONTROL_INIT);
> +
> +	port->ops->data_reverse(port);
> +
> +	for (; len > 0; len--, bp++) {
> +		sunix_parport_frob_control(port, PARPORT_CONTROL_AUTOFD,
> +		PARPORT_CONTROL_AUTOFD);
> +
> +		if (sunix_parport_wait_peripheral(port, PARPORT_STATUS_BUSY, 0))
> +			break;
> +
> +		*bp = sunix_parport_read_data(port);
> +
> +		sunix_parport_frob_control(port, PARPORT_CONTROL_AUTOFD, 0);
> +
> +		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
> +		PARPORT_STATUS_BUSY, 5))
> +			break;
> +
> +		ret++;
> +	}
> +	port->ops->data_forward(port);
> +	return ret;
> +}
> +
> +
> +size_t sunix_parport_ieee1284_epp_write_addr(struct parport *port,
> +const void *buffer, size_t len, int flags)
> +{
> +	unsigned char *bp = (unsigned char *)buffer;
> +	size_t ret = 0;
> +
> +	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE |
> +	PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT |
> +	PARPORT_CONTROL_INIT, PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
> +
> +	port->ops->data_forward(port);
> +
> +	for (; len > 0; len--, bp++) {
> +		sunix_parport_write_data(port, *bp);
> +		sunix_parport_frob_control(port, PARPORT_CONTROL_SELECT,
> +		PARPORT_CONTROL_SELECT);
> +
> +		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
> +		0, 10))
> +			break;
> +
> +		sunix_parport_frob_control(port, PARPORT_CONTROL_SELECT, 0);
> +
> +		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
> +		PARPORT_STATUS_BUSY, 5))
> +			break;
> +
> +		ret++;
> +	}
> +
> +	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE, 0);
> +	return ret;
> +}
> +
> +size_t sunix_parport_ieee1284_epp_read_addr(struct parport *port,
> +void *buffer, size_t len, int flags)
> +{
> +	unsigned char *bp = (unsigned char *) buffer;
> +	unsigned int ret = 0;
> +
> +	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE |
> +	PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT |
> +	PARPORT_CONTROL_INIT, PARPORT_CONTROL_INIT);
> +
> +	port->ops->data_reverse(port);
> +
> +	for (; len > 0; len--, bp++) {
> +		sunix_parport_frob_control(port, PARPORT_CONTROL_SELECT,
> +		PARPORT_CONTROL_SELECT);
> +
> +		if (sunix_parport_wait_peripheral(port, PARPORT_STATUS_BUSY, 0))
> +			break;
> +
> +		*bp = sunix_parport_read_data(port);
> +
> +		sunix_parport_frob_control(port, PARPORT_CONTROL_SELECT,
> +		PARPORT_CONTROL_SELECT);
> +
> +		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
> +		PARPORT_STATUS_BUSY, 5))
> +			break;
> +
> +		ret++;
> +	}
> +
> +	port->ops->data_forward(port);
> +	return ret;
> +}
> +
> diff --git a/drivers/mfd/sunix/snx_lp.c b/drivers/mfd/sunix/snx_lp.c
> new file mode 100644
> index 000000000000..da6d45db134a
> --- /dev/null
> +++ b/drivers/mfd/sunix/snx_lp.c
> @@ -0,0 +1,603 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "snx_common.h"
> +#include "snx_lp.h"
> +
> +static int SNX_PAL_MAJOR;
> +
> +#define SNX_LP_NO SNX_PAR_TOTAL_MAX
> +
> +static struct snx_lp_struct snx_lp_table[SNX_LP_NO];
> +static unsigned int snx_lp_count;
> +static struct class *snx_lp_class;
> +
> +#define SNX_LP_PREEMPT_REQUEST 1
> +#define SNX_LP_PARPORT_CLAIMED 2
> +
> +#ifdef CONFIG_LP_CONSOLE
> +static struct parport *console_registered;
> +#endif

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.


> +
> +#define r_dtr(x)	(sunix_parport_read_data(snx_lp_table[(x)].dev->port))
> +#define r_str(x)	(sunix_parport_read_status(snx_lp_table[(x)].dev->port))
> +#define w_ctr(x, y)	do { sunix_parport_write_control(snx_lp_table[(x)].dev->port, (y)); } while (0)
> +#define w_dtr(x, y)	do { sunix_parport_write_data(snx_lp_table[(x)].dev->port, (y)); } while (0)
> +
> +static void snx_lp_claim_parport_or_block(struct snx_lp_struct *this_lp)
> +{
> +	if (!test_and_set_bit(SNX_LP_PARPORT_CLAIMED, &this_lp->bits))
> +		sunix_parport_claim_or_block(this_lp->dev);
> +}
> +static void snx_lp_release_parport(struct snx_lp_struct *this_lp)
> +{
> +	if (test_and_clear_bit(SNX_LP_PARPORT_CLAIMED, &this_lp->bits))
> +		sunix_parport_release(this_lp->dev);
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_lp_preempt(void *handle)
> +{
> +	struct snx_lp_struct *this_lp = (struct snx_lp_struct *)handle;
> +
> +	set_bit(SNX_LP_PREEMPT_REQUEST, &this_lp->bits);
> +	return 1;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_lp_negotiate(struct parport *port, int mode)
> +{
> +	if (sunix_parport_negotiate(port, mode) != 0) {
> +		mode = IEEE1284_MODE_COMPAT;
> +		sunix_parport_negotiate(port, mode);
> +	}
> +	return (mode);
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_lp_reset(int minor)
> +{
> +	int retval;
> +
> +	snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
> +
> +	w_ctr(minor, SNX_LP_PSELECP);
> +
> +	udelay(SNX_LP_DELAY);
> +
> +	w_ctr(minor, SNX_LP_PSELECP | SNX_LP_PINITP);
> +
> +	retval = r_str(minor);
> +
> +	snx_lp_release_parport(&snx_lp_table[minor]);
> +	return retval;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static void snx_lp_error(int minor)
> +{
> +	DEFINE_WAIT(wait);
> +
> +	int polling;
> +
> +	if (SNX_LP_F(minor) & SNX_LP_ABORT)
> +		return;
> +
> +	polling = snx_lp_table[minor].dev->port->irq == PARPORT_IRQ_NONE;
> +
> +	if (polling)
> +		snx_lp_release_parport(&snx_lp_table[minor]);
> +
> +	prepare_to_wait(&snx_lp_table[minor].waitq, &wait, TASK_INTERRUPTIBLE);
> +
> +	schedule_timeout(SNX_LP_TIMEOUT_POLLED);
> +	finish_wait(&snx_lp_table[minor].waitq, &wait);
> +
> +	if (polling)
> +		snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
> +	else
> +		sunix_parport_yield_blocking(snx_lp_table[minor].dev);
> +
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_lp_check_status(int minor)
> +{
> +	int error = 0;
> +	unsigned int last = snx_lp_table[minor].last_error;
> +	unsigned char status = r_str(minor);
> +
> +	if ((status & SNX_LP_PERRORP) && !(SNX_LP_F(minor) & SNX_LP_CAREFUL)) {
> +		last = 0;
> +	} else if ((status & SNX_LP_POUTPA)) {
> +		if (last != SNX_LP_POUTPA) {
> +			last = SNX_LP_POUTPA;
> +			pr_info("SNX Info : lp%d port out of paper.\n", minor);
> +		}
> +		error = -ENOSPC;
> +	} else if (!(status & SNX_LP_PSELECD)) {
> +		if (last != SNX_LP_PSELECD) {
> +			last = SNX_LP_PSELECD;
> +			pr_info("SNX Info : lp%d port off-line.\n", minor);
> +		}
> +		error = -EIO;
> +	} else if (!(status & SNX_LP_PERRORP)) {
> +		if (last != SNX_LP_PERRORP) {
> +			last = SNX_LP_PERRORP;
> +			pr_info("SNX Info : lp%d port on fire.\n", minor);
> +		}
> +		error = -EIO;
> +	} else {
> +		last = 0;
> +	}
> +
> +	snx_lp_table[minor].last_error = last;
> +
> +	if (last != 0)
> +		snx_lp_error(minor);
> +
> +	return error;
> +}
> +
> +
> +static int snx_lp_wait_ready(int minor, int nonblock)
> +{
> +	int error = 0;
> +
> +	if (snx_lp_table[minor].current_mode != IEEE1284_MODE_COMPAT)
> +		return 0;
> +
> +
> +	do {
> +		error = snx_lp_check_status(minor);
> +
> +		if (error && (nonblock || (SNX_LP_F(minor) & SNX_LP_ABORT)))
> +			break;
> +
> +
> +		if (signal_pending(current)) {
> +			error = -EINTR;
> +			break;
> +		}
> +	} while (error);
> +
> +	return error;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static ssize_t snx_lp_write(struct file *file,
> +const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	unsigned int minor = iminor(file->f_path.dentry->d_inode);
> +
> +	struct parport *port = snx_lp_table[minor].dev->port;
> +	char *kbuf = snx_lp_table[minor].lp_buffer;
> +
> +	ssize_t retv = 0;
> +	ssize_t written;
> +	size_t copy_size = count;
> +	int nonblock = ((file->f_flags & O_NONBLOCK) ||
> +	(SNX_LP_F(minor) & SNX_LP_ABORT));
> +
> +	if (copy_size > SNX_LP_BUFFER_SIZE)
> +		copy_size = SNX_LP_BUFFER_SIZE;
> +
> +	if (mutex_lock_interruptible(&snx_lp_table[minor].port_mutex))
> +		return -EINTR;
> +
> +	if (copy_from_user(kbuf, buf, copy_size)) {
> +		retv = -EFAULT;
> +		goto out_unlock;
> +	}
> +
> +	snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
> +
> +	snx_lp_table[minor].current_mode = snx_lp_negotiate(
> +	port, snx_lp_table[minor].best_mode);
> +
> +	sunix_parport_set_timeout(snx_lp_table[minor].dev, (nonblock ?
> +	SNX_PARPORT_INACTIVITY_O_NONBLOCK : snx_lp_table[minor].timeout));
> +
> +	retv = snx_lp_wait_ready(minor, nonblock);
> +
> +	do {
> +		written = sunix_parport_write(port, kbuf, copy_size);
> +		if (written > 0) {
> +			copy_size -= written;
> +			count -= written;
> +			buf  += written;
> +			retv += written;
> +		}
> +
> +		if (signal_pending(current)) {
> +			if (retv == 0)
> +				retv = -EINTR;
> +
> +			break;
> +		}
> +
> +		if (copy_size > 0) {
> +			int error;
> +
> +			sunix_parport_negotiate(snx_lp_table[minor].dev->port,
> +			IEEE1284_MODE_COMPAT);
> +			snx_lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
> +
> +			error = snx_lp_wait_ready(minor, nonblock);
> +
> +			if (error) {
> +				if (retv == 0)
> +					retv = error;
> +
> +				break;
> +			} else if (nonblock) {
> +				if (retv == 0)
> +					retv = -EAGAIN;
> +
> +				break;
> +			}
> +
> +			sunix_parport_yield_blocking(snx_lp_table[minor].dev);
> +			snx_lp_table[minor].current_mode = snx_lp_negotiate(
> +			port, snx_lp_table[minor].best_mode);
> +
> +		} else if (need_resched()) {
> +			schedule();
> +		}
> +
> +		if (count) {
> +			copy_size = count;
> +			if (copy_size > SNX_LP_BUFFER_SIZE)
> +				copy_size = SNX_LP_BUFFER_SIZE;
> +
> +
> +			if (copy_from_user(kbuf, buf, copy_size)) {
> +				if (retv == 0)
> +					retv = -EFAULT;
> +
> +				break;
> +			}
> +		}
> +	} while (count > 0);
> +
> +	if (test_and_clear_bit(SNX_LP_PREEMPT_REQUEST,
> +		&snx_lp_table[minor].bits)) {
> +		pr_info("SNX Info : lp%d releasing parport.\n", minor);
> +		sunix_parport_negotiate(snx_lp_table[minor].dev->port,
> +		IEEE1284_MODE_COMPAT);
> +
> +		snx_lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
> +
> +		snx_lp_release_parport(&snx_lp_table[minor]);
> +	}
> +
> +out_unlock:
> +
> +	mutex_unlock(&snx_lp_table[minor].port_mutex);
> +
> +	return retv;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_lp_open(struct inode *inode, struct file *file)
> +{
> +	unsigned int minor = iminor(inode);
> +
> +	if (minor >= SNX_LP_NO)
> +		return -ENXIO;
> +
> +
> +	if ((SNX_LP_F(minor) & SNX_LP_EXIST) == 0)
> +		return -ENXIO;
> +
> +
> +	if (test_and_set_bit(SNX_LP_BUSY_BIT_POS, &SNX_LP_F(minor)))
> +		return -EBUSY;
> +
> +
> +	if ((SNX_LP_F(minor) & SNX_LP_ABORTOPEN) &&
> +						!(file->f_flags & O_NONBLOCK)) {
> +		int status;
> +
> +		snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
> +		status = r_str(minor);
> +		snx_lp_release_parport(&snx_lp_table[minor]);
> +
> +		if (status & SNX_LP_POUTPA) {
> +			pr_info("SNX Error: lp%d out of paper.\n", minor);
> +			SNX_LP_F(minor) &= ~SNX_LP_BUSY;
> +			return -ENOSPC;
> +		} else if (!(status & SNX_LP_PSELECD)) {
> +			pr_info("SNX Error: lp%d off-line.\n", minor);
> +			SNX_LP_F(minor) &= ~SNX_LP_BUSY;
> +			return -EIO;
> +		} else if (!(status & SNX_LP_PERRORP)) {
> +			pr_info("SNX Error: lp%d printer error.\n", minor);
> +			SNX_LP_F(minor) &= ~SNX_LP_BUSY;
> +			return -EIO;
> +		}
> +	}
> +
> +	snx_lp_table[minor].lp_buffer = kzalloc(SNX_LP_BUFFER_SIZE, GFP_KERNEL);
> +
> +	if (!snx_lp_table[minor].lp_buffer) {
> +		SNX_LP_F(minor) &= ~SNX_LP_BUSY;
> +		return -ENOMEM;
> +	}
> +
> +	snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
> +
> +	if ((snx_lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
> +		!sunix_parport_negotiate(snx_lp_table[minor].dev->port,
> +		IEEE1284_MODE_ECP)) {
> +		pr_info("SNX Info : lp%d ECP mode.\n", minor);
> +		snx_lp_table[minor].best_mode = IEEE1284_MODE_ECP;
> +	} else {
> +		snx_lp_table[minor].best_mode = IEEE1284_MODE_COMPAT;
> +	}
> +
> +	sunix_parport_negotiate(snx_lp_table[minor].dev->port,
> +	IEEE1284_MODE_COMPAT);
> +
> +	snx_lp_release_parport(&snx_lp_table[minor]);
> +	snx_lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
> +
> +	return 0;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_lp_release(struct inode *inode, struct file *file)
> +{
> +	unsigned int minor = iminor(inode);
> +
> +	snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
> +	sunix_parport_negotiate(snx_lp_table[minor].dev->port,
> +	IEEE1284_MODE_COMPAT);
> +
> +	snx_lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
> +	snx_lp_release_parport(&snx_lp_table[minor]);
> +	kfree(snx_lp_table[minor].lp_buffer);
> +	snx_lp_table[minor].lp_buffer = NULL;
> +	SNX_LP_F(minor) &= ~SNX_LP_BUSY;
> +
> +	return 0;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static const struct file_operations lp_fops = {
> +	.owner		= THIS_MODULE,
> +	.write		= snx_lp_write,
> +	.open		= snx_lp_open,
> +	.release	= snx_lp_release,
> +};
> +
> +#ifdef CONFIG_LP_CONSOLE
> +#define SNX_CONSOLE_LP 0
> +
> +#define SNX_CONSOLE_LP_STRICT	1
> +
> +static void snx_lp_console_write(struct console *co,
> +const char *s, unsigned int count)
> +{
> +	struct snx_pardevice *dev = snx_lp_table[SNX_CONSOLE_LP].dev;
> +	struct snx_parport *port = dev->port;
> +	ssize_t written;
> +
> +	if (sunix_parport_claim(dev))
> +		return;
> +
> +	sunix_parport_set_timeout(dev, 0);
> +
> +	sunix_parport_negotiate(port, IEEE1284_MODE_COMPAT);
> +
> +	do {
> +		ssize_t canwrite = count;
> +		char *lf = memchr(s, '\n', count);
> +
> +		if (lf)
> +			canwrite = lf - s;
> +
> +		if (canwrite > 0) {
> +			written = sunix_parport_write(port, s, canwrite);
> +
> +			if (written <= 0)
> +				continue;
> +
> +			s += written;
> +			count -= written;
> +			canwrite -= written;
> +		}
> +
> +		if (lf && canwrite <= 0) {
> +			const char *crlf = "\r\n";
> +			int i = 2;
> +
> +			s++;
> +			count--;
> +			do {
> +				written = sunix_parport_write(port, crlf, i);
> +				if (written > 0)
> +					i -= written, crlf += written;
> +
> +			} while (i > 0 && (SNX_CONSOLE_LP_STRICT ||
> +				written > 0));
> +		}
> +	} while (count > 0 && (SNX_CONSOLE_LP_STRICT || written > 0));
> +
> +	sunix_parport_release(dev);
> +}
> +
> +static struct console snx_lpcons = {
> +	.name		= "lx",
> +	.write		= snx_lp_consle_write,
> +	.flags		= CON_PRINTBUFFER,
> +};
> +
> +#endif

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_parport_nr[SNX_LP_NO] = {0, 1, 2, 3};
> +static int reset;
> +
> +
> +static int snx_lp_register(int nr, struct parport *port)
> +{
> +	snx_lp_table[nr].dev = sunix_parport_register_device(port, "lx",
> +	snx_lp_preempt, NULL, NULL, 0, (void *) &snx_lp_table[nr]);
> +
> +	if (snx_lp_table[nr].dev == NULL)
> +		return 1;
> +
> +
> +	snx_lp_table[nr].flags |= SNX_LP_EXIST;
> +
> +	if (reset)
> +		snx_lp_reset(nr);
> +
> +
> +	device_create(snx_lp_class, NULL, MKDEV(SNX_PAL_MAJOR, nr),
> +	NULL, "lp%d", nr);
> +
> +	pr_info("SNX Info : lp%d port using %s (%s).\n", nr, port->name,
> +	(port->irq == PARPORT_IRQ_NONE)?"polling":"interrupt-driven");
> +
> +
> +#ifdef CONFIG_LP_CONSOLE
> +
> +	if (!nr) {
> +		if (port->modes & PARPORT_MODE_SAFEININT) {
> +			register_console(&snx_lpcons);
> +			console_registered = port;
> +			pr_info("SNX Info : lp%d port console ready.\n",
> +			CONSOLE_LP);
> +		} else {
> +			pr_info("SNX Info : lp%d port cannot run console on %s.\n",
> +			CONSOLE_LP, port->name);
> +		}
> +	}
> +#endif
> +
> +	return 0;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static void snx_lp_attach(struct parport *port)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < SNX_LP_NO; i++) {
> +		if (port->number == snx_parport_nr[i]) {
> +			if (!snx_lp_register(i, port))
> +				snx_lp_count++;
> +
> +			break;
> +		}
> +	}
> +}
> +
> +static void snx_lp_detach(struct parport *port)
> +{
> +
> +#ifdef CONFIG_LP_CONSOLE
> +	if (console_registered == port) {
> +		unregister_console(&snx_lpcons);
> +		console_registered = NULL;
> +	}
> +#endif
> +
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static struct parport_driver lp_driver = {
> +	.name = "lx",
> +	.attach = snx_lp_attach,
> +	.detach = snx_lp_detach,
> +};
> +
> +
> +static int snx_lp_init(void)
> +{
> +	int i, err = 0;
> +
> +	for (i = 0; i < SNX_LP_NO; i++) {
> +		snx_lp_table[i].dev = NULL;
> +		snx_lp_table[i].flags = 0;
> +		snx_lp_table[i].chars = SNX_LP_INIT_CHAR;
> +		snx_lp_table[i].time = SNX_LP_INIT_TIME;
> +		snx_lp_table[i].wait = SNX_LP_INIT_WAIT;
> +		snx_lp_table[i].lp_buffer = NULL;
> +		snx_lp_table[i].last_error = 0;
> +		init_waitqueue_head(&snx_lp_table[i].waitq);
> +		init_waitqueue_head(&snx_lp_table[i].dataq);
> +
> +		mutex_init(&snx_lp_table[i].port_mutex);
> +
> +		snx_lp_table[i].timeout = 10 * HZ;
> +	}
> +
> +	SNX_PAL_MAJOR = register_chrdev(0, "lx", &lp_fops);
> +
> +	if (SNX_PAL_MAJOR < 0) {
> +		pr_info("SNX Error: lp unable to get major\n");
> +		return -EIO;
> +	}
> +
> +	snx_lp_class = class_create(THIS_MODULE, "sprinter");
> +
> +	if (IS_ERR(snx_lp_class)) {
> +		err = PTR_ERR(snx_lp_class);
> +		goto out_reg;
> +	}
> +
> +	if (sunix_parport_register_driver(&lp_driver)) {
> +		pr_info("SNX Error: lp unable to register with parport.\n");
> +		err = -EIO;
> +		goto out_class;
> +	}
> +
> +	if (!snx_lp_count)
> +		pr_info("SNX Warng: lp driver loaded but no devices found.\n");
> +
> +
> +	return 0;
> +
> +out_class:
> +
> +	class_destroy(snx_lp_class);
> +
> +out_reg:
> +
> +	unregister_chrdev(SNX_PAL_MAJOR, "lx");
> +	return err;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +int sunix_par_lp_init(void)
> +{
> +	int status = 0;
> +
> +	status = snx_lp_init();
> +	return status;
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +void sunix_par_lp_exit(void)
> +{
> +	unsigned int offset;
> +
> +	sunix_parport_unregister_driver(&lp_driver);
> +
> +#ifdef CONFIG_LP_CONSOLE
> +	unregister_console(&snx_lpcons);
> +#endif
> +
> +	unregister_chrdev(SNX_PAL_MAJOR, "lx");
> +
> +	for (offset = 0; offset < SNX_LP_NO; offset++) {
> +		if (snx_lp_table[offset].dev == NULL)
> +			continue;
> +
> +		sunix_parport_unregister_device(snx_lp_table[offset].dev);
> +
> +		device_destroy(snx_lp_class, MKDEV(SNX_PAL_MAJOR, offset));
> +
> +	}
> +
> +	class_destroy(snx_lp_class);
> +}

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.


> diff --git a/drivers/mfd/sunix/snx_lp.h b/drivers/mfd/sunix/snx_lp.h
> new file mode 100644
> index 000000000000..a0929642834c
> --- /dev/null
> +++ b/drivers/mfd/sunix/snx_lp.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SNX_LP_H
> +#define _LINUX_SNX_LP_H
> +
> +#include <linux/mutex.h>
> +
> +#define SNX_LP_EXIST		0x0001
> +#define SNX_LP_SELEC		0x0002
> +#define SNX_LP_BUSY		0x0004
> +#define SNX_LP_BUSY_BIT_POS	2
> +#define SNX_LP_OFFL		0x0008
> +#define SNX_LP_NOPA		0x0010
> +#define SNX_LP_ERR		0x0020
> +#define SNX_LP_ABORT		0x0040
> +#define SNX_LP_CAREFUL		0x0080
> +#define SNX_LP_ABORTOPEN	0x0100
> +
> +#define SNX_LP_TRUST_IRQ_	0x0200
> +#define SNX_LP_NO_REVERSE	0x0400
> +#define SNX_LP_DATA_AVAIL	0x0800
> +
> +#define SNX_LP_PBUSY		0x80
> +#define SNX_LP_PACK		0x40
> +#define SNX_LP_POUTPA		0x20
> +#define SNX_LP_PSELECD		0x10
> +#define SNX_LP_PERRORP		0x08
> +
> +#define SNX_LP_INIT_CHAR	1000
> +#define SNX_LP_INIT_WAIT	1
> +#define SNX_LP_INIT_TIME	2
> +
> +#define SNX_LPCHAR		0x0601
> +#define SNX_LPTIME		0x0602
> +#define SNX_LPABORT		0x0604
> +#define SNX_LPSETIRQ	0x0605
> +#define SNX_LPGETIRQ	0x0606
> +#define SNX_LPWAIT		0x0608
> +
> +#define SNX_LPCAREFUL		0x0609
> +#define SNX_LPABORTOPEN		0x060a
> +#define SNX_LPGETSTATUS		0x060b
> +#define SNX_LPRESET			0x060c
> +
> +#define SNX_LPGETFLAGS		0x060e
> +#define SNX_LPSETTIMEOUT	0x060f
> +
> +#define SNX_LP_TIMEOUT_INTERRUPT	(60 * HZ)
> +#define SNX_LP_TIMEOUT_POLLED		(10 * HZ)
> +
> +#define SNX_LP_PARPORT_UNSPEC	-4
> +#define SNX_LP_PARPORT_AUTO	-3
> +#define SNX_LP_PARPORT_OFF	-2
> +#define SNX_LP_PARPORT_NONE	-1
> +
> +#define SNX_LP_F(minor)		snx_lp_table[(minor)].flags
> +#define SNX_LP_CHAR(minor)	snx_lp_table[(minor)].chars
> +#define SNX_LP_TIME(minor)	snx_lp_table[(minor)].time
> +#define SNX_LP_WAIT(minor)	snx_lp_table[(minor)].wait
> +#define SNX_LP_IRQ(minor)	snx_lp_table[(minor)].dev->port->irq
> +#define SNX_LP_BUFFER_SIZE PAGE_SIZE
> +#define SNX_LP_BASE(x)			snx_lp_table[(x)].dev->port->base
> +
> +
> +struct snx_lp_struct {
> +	struct pardevice	*dev;
> +	unsigned long		flags;
> +	unsigned int		chars;
> +	unsigned int		time;
> +	unsigned int		wait;
> +	char			*lp_buffer;
> +
> +	wait_queue_head_t	waitq;
> +
> +	unsigned int		last_error;
> +	struct mutex		port_mutex;
> +
> +	wait_queue_head_t	dataq;
> +
> +	long			timeout;
> +	unsigned int		best_mode;
> +	unsigned int		current_mode;
> +	unsigned long		bits;
> +};
> +

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +#define SNX_LP_PINTEN		0x10
> +#define SNX_LP_PSELECP		0x08
> +#define SNX_LP_PINITP		0x04
> +#define SNX_LP_PAUTOLF		0x02
> +#define SNX_LP_PSTROBE		0x01
> +#define SNX_LP_DUMMY		0x00
> +#define SNX_LP_DELAY		50
> +
> +#endif
> diff --git a/drivers/mfd/sunix/snx_parallel.c b/drivers/mfd/sunix/snx_parallel.c
> new file mode 100644
> index 000000000000..17fdc48cd9b6
> --- /dev/null
> +++ b/drivers/mfd/sunix/snx_parallel.c
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "snx_common.h"
> +

<snip>

> +static inline unsigned char sunix_parport_pc_read_control(struct parport *p)

If it's not the original PC parport, remove the misleading "pc" from the
function names.

> +static int  sunix_parport_PS2_supported(struct parport *pb)
> +{
> +	return 0;
> +}
> +
> +static int  sunix_parport_EPP_supported(struct parport *pb)
> +{
> +	return 0;
> +}
> +
> +
> +static int  sunix_parport_ECPEPP_supported(struct parport *pb)
> +{
> +	return 0;
> +}
> +
> +static int  sunix_parport_ECPPS2_supported(struct parport *pb)
> +{
> +	return 0;
> +}

do these really need to be defined, when they're just no-op anyways ?

> +struct parport *sunix_parport_pc_probe_port(struct sunix_par_port *priv)
> +{
> +	struct parport_operations *ops = NULL;
> +	struct parport *p = NULL;
> +	struct resource *base_res;
> +	struct resource	*ecr_res = NULL;
> +
> +	if (!priv)
> +		goto out1;
> +
> +	ops = kzalloc(sizeof(struct parport_operations), GFP_KERNEL);

use devm_ variant whenever possible.

> +	if (!ops)
> +		goto out1;
> +
> +	p = sunix_parport_register_port(priv, ops);
> +	if (!p)
> +		goto out2;
> +
> +	base_res = request_region(p->base, SNX_PAR_ADDRESS_LENGTH,

use devm_ variant whenever possible.

> +	"snx_par_base");
> +	if (!base_res)
> +		goto out3;
> +
> +	memcpy(ops, &parport_pc_ops, sizeof(struct parport_operations));

Is this dynamically allocated ops structure really needed ?
Can't see where it's actually used. And if it doesn't need to be
changes at runtime, directly take the reference to the original struct.

> +void sunix_parport_pc_unregister_port(struct parport *p)
> +{
> +	struct sunix_par_port *priv = p->private_data;
> +	struct parport_operations *ops = p->ops;
> +
> +	sunix_parport_remove_port(p);
> +
> +	spin_lock(&snx_ports_lock);
> +	list_del_init(&priv->list);
> +	spin_unlock(&snx_ports_lock);

Is that global list *really* necessary ?

> diff --git a/drivers/mfd/sunix/snx_ppdev.c b/drivers/mfd/sunix/snx_ppdev.c
> new file mode 100644
> index 000000000000..003839820340
> --- /dev/null
> +++ b/drivers/mfd/sunix/snx_ppdev.c
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "snx_ppdev.h"
> +
> +#define SNX_PARPORT_MAX 4
> +#define SNX_CHRDEV "sppdev"
> +
> +static int SNX_PPD_MAJOR;
> +
> +struct snx_pp_struct {
> +	struct pardevice	*pdev;

Why not deriving from struct pardevice instead of separate structs ?

> +static ssize_t snx_pp_read(struct file *file,
> +char __user *buf, size_t count, loff_t *ppos)

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static ssize_t snx_pp_write(struct file *file,
> +const char __user *buf, size_t count, loff_t *ppos)
Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_pp_open(struct inode *inode, struct file *file)

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static int snx_pp_release(struct inode *inode, struct file *file)

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static unsigned int snx_pp_poll(struct file *file, poll_table *wait)

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +static const struct file_operations pp_fops = {
> +	.owner		= THIS_MODULE,
> +	.llseek		= no_llseek,
> +	.read		= snx_pp_read,
> +	.write		= snx_pp_write,
> +	.poll		= snx_pp_poll,
> +
> +	.open		= snx_pp_open,
> +	.release	= snx_pp_release,
> +};

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> +int sunix_par_ppdev_init(void)
> +{
> +
> +	int err = 0;
> +
> +	SNX_PPD_MAJOR = register_chrdev(0, SNX_CHRDEV, &pp_fops);

Don't reimplement existing standard functions. LP already works ontop of
parport driver subsystem. You should write a parport driver instead.

> diff --git a/drivers/mfd/sunix/snx_share.c b/drivers/mfd/sunix/snx_share.c
> new file mode 100644
> index 000000000000..327661b4ff50
> --- /dev/null
> +++ b/drivers/mfd/sunix/snx_share.c
> @@ -0,0 +1,634 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "snx_common.h"
> +#define SNX_PARPORT_DEFAULT_TIMESLICE	(HZ/5)
> +
> +int		sunix_parport_default_spintime;
> +static struct parport *sunix_parport_get_port(struct parport *port);
> +struct parport *sunix_parport_find_base(unsigned long base);
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
> +struct parport *p, unsigned char b)
> +{}
> +static unsigned char sunix_dead_read_lines(
> +struct parport *p)
> +{ return 0; }
> +static unsigned char sunix_dead_frob_lines(
> +struct parport *p, unsigned char b, unsigned char c)
> +{ return 0; }
> +static void sunix_dead_onearg(struct parport *p)
> +{}
> +static void sunix_dead_initstate(
> +struct pardevice *d, struct parport_state *s)
> +{}
> +static void sunix_dead_state(
> +struct parport *p, struct parport_state *s)
> +{}
> +static size_t sunix_dead_write(
> +struct parport *p, const void *b, size_t l, int f)
> +{ return 0; }
> +static size_t sunix_dead_read(
> +struct parport *p, void *b, size_t l, int f)
> +{ return 0; }
> +
> +
> +static struct parport_operations	dead_ops = {
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
> +
> +};

What exactly is "dead ops" supposed to mean ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
