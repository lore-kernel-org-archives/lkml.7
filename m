Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA24DC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823342083B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JH/o9DNT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J3mHqmde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfF2AzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 20:55:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55146 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF2AzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 20:55:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63AA960ACA; Sat, 29 Jun 2019 00:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561769707;
        bh=DD3dTYKuw/wp0q8UkjPv+YJJrGGBDRXZ5f6BJ6RRMqY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JH/o9DNTDn9yl9tKzsN3Lbr41S4Esf7sPZLbLq8m3rkiavsFdrlTk2VXk2DKppgmC
         PaajjNC8Aec0wK7EdBIgfqBYbSJg8Rg2zIsPJBt5h/pP+h2r1JkVfRLsidew4Mx/fy
         +UQciog+mv+a0rETQbBO3dzqxzXHHnehjjssiAig=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60E71607C3;
        Sat, 29 Jun 2019 00:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561769705;
        bh=DD3dTYKuw/wp0q8UkjPv+YJJrGGBDRXZ5f6BJ6RRMqY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J3mHqmdeJAe3uOjEjYxIkJ8qATiCRlu6mC9Bg5yN+lNYs+RM8Qj8ZdB3G0xtH6ZX5
         AITqBtLakq1Qm7EP4P9aemfc3e/755OVGUZy8mFwOYnJdB19YeOwQUDGx2qo7+2FTH
         Ch2oL2KMyeviCRuQkNpYBoEWMIIbRCdG7w6UGbrY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60E71607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 2/3] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20190628022202.118166-1-saravanak@google.com>
 <20190628022202.118166-3-saravanak@google.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <d97de5ef-68a3-795f-2532-24da8cd2d130@codeaurora.org>
Date:   Fri, 28 Jun 2019 17:55:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190628022202.118166-3-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saravana,

On 6/27/19 7:22 PM, Saravana Kannan wrote:
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 04ad312fd85b..8d690fa0f47c 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -61,6 +61,72 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
>  EXPORT_SYMBOL(of_find_device_by_node);
>  
>  #ifdef CONFIG_OF_ADDRESS
> +static int of_link_binding(struct device *dev, char *binding, char *cell)
> +{
> +	struct of_phandle_args sup_args;
> +	struct platform_device *sup_dev;
> +	unsigned int i = 0, links = 0;
> +	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> +
> +	while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
> +					   &sup_args)) {
> +		i++;
> +		sup_dev = of_find_device_by_node(sup_args.np);
> +		if (!sup_dev)
> +			continue;

This check means that a required dependency link between a consumer and
supplier will not be added in the case that the consumer device is created
before the supply device.  If the supplier device is created and
immediately bound to its driver after late_initcall_sync(), then it is
possible for the sync_state() callback of the supplier to be called before
the consumer gets a chance to probe since its link was never captured.

of_platform_default_populate() below will only create devices for the
first level DT nodes directly under "/".  Suppliers DT nodes can exist as
second level nodes under a first level bus node (e.g. I2C, SPMI, RPMh,
etc).  Thus, it is quite likely that not all supplier devices will have
been created when device_link_check_waiting_consumers() is called.

As far as I can tell, this effectively breaks the sync_state()
functionality (and thus proxy un-voting built on top of it) when using
kernel modules for both the supplier and consumer drivers which are probed
after late_initcall_sync().  I'm not sure how this can be avoided given
that the linking is done between devices in the process of sequentially
adding devices.  Perhaps linking between device nodes instead of devices
might be able to overcome this issue.


> +		if (device_link_add(dev, &sup_dev->dev, dl_flags))
> +			links++;
> +		put_device(&sup_dev->dev);
> +	}
> +	if (links < i)
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +/*
> + * List of bindings and their cell names (use NULL if no cell names) from which
> + * device links need to be created.
> + */
> +static char *link_bindings[] = {
> +#ifdef CONFIG_OF_DEVLINKS
> +	"clocks", "#clock-cells",
> +	"interconnects", "#interconnect-cells",
> +#endif
> +};

This list and helper function above are missing support for regulator
<arbitrary-consumer-name>-supply properties.  We require this support on
QTI boards in order to handle regulator proxy un-voting when booting with
kernel modules.  Are you planning to add this support in a follow-on
version of this patch or in an additional patch?

Note that handling regulator supply properties will be very challenging
for at least these reasons:

1. There is not a consistent DT property name used for regulator supplies.

2. The device node referenced in a regulator supply phandle is usually not
the device node which correspond to the device pointer for the supplier.
This is because a single regulator supplier device node (which will have
an associated device pointer) typically has a subnode for each of the
regulators it supports.  Consumers then use phandles for the subnodes.

3. The specification of parent supplies for regulators frequently results
in *-supply properties in a node pointing to child subnodes of that node.
 See [1] for an example.  Special care would need to be taken to avoid
trying to mark a regulator supplier as a supplier to itself as well as to
avoid blocking its own probing due to an unlinked supply dependency.

4. Not all DT properties of the form "*-supply" are regulator supplies.
(Note, this case has been discussed, but I was not able to locate an
example of it.)


Clocks also have a problem.  A recent patch [2] allows clock provider
parent clocks to be specified via DT.  This could lead to cases of
circular "clocks" property dependencies where there are two clock supplier
devices A and B with A having some clocks with B clock parents along with
B having some clocks with A clock parents.  If "clocks" properties are
followed, then neither device would ever be able to probe.

This does not present a problem without this patch series because the
clock framework supports late binding of parents specifically to avoid
issues with clocks not registering in perfectly topological order of
parent dependencies.


> +
> +static int of_link_to_suppliers(struct device *dev)
> +{
> +	unsigned int i = 0;
> +	bool done = true;
> +
> +	if (unlikely(!dev->of_node))
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
> +		if (of_link_binding(dev, link_bindings[i * 2],
> +					link_bindings[i * 2 + 1]))
> +			done = false;
> +
> +	if (!done)
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +static void link_waiting_consumers_func(struct work_struct *work)
> +{
> +	device_link_check_waiting_consumers(of_link_to_suppliers);
> +}
> +static DECLARE_WORK(link_waiting_consumers_work, link_waiting_consumers_func);
> +
> +static bool link_waiting_consumers_enable;
> +static void link_waiting_consumers_trigger(void)
> +{
> +	if (!link_waiting_consumers_enable)
> +		return;
> +
> +	schedule_work(&link_waiting_consumers_work);
> +}
> +
>  /*
>   * The following routines scan a subtree and registers a device for
>   * each applicable node.
> @@ -192,10 +258,13 @@ static struct platform_device *of_platform_device_create_pdata(
>  	dev->dev.platform_data = platform_data;
>  	of_msi_configure(&dev->dev, dev->dev.of_node);
>  
> +	if (of_link_to_suppliers(&dev->dev))
> +		device_link_wait_for_supplier(&dev->dev);
>  	if (of_device_add(dev) != 0) {
>  		platform_device_put(dev);
>  		goto err_clear_flag;
>  	}
> +	link_waiting_consumers_trigger();
>  
>  	return dev;
>  
> @@ -541,6 +610,10 @@ static int __init of_platform_default_populate_init(void)
>  	/* Populate everything else. */
>  	of_platform_default_populate(NULL, NULL, NULL);
>  
> +	/* Make the device-links between suppliers and consumers */
> +	link_waiting_consumers_enable = true;
> +	device_link_check_waiting_consumers(of_link_to_suppliers);
> +
>  	return 0;
>  }
>  arch_initcall_sync(of_platform_default_populate_init);
> 

Thanks,
David

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845-mtp.dts?h=v5.2-rc5#n73

[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc0c209c147f35ed2648adda09db39fcad89e334

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
