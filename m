Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5347C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E64F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfDQJwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:52:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45937 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfDQJwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:52:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id k92so2296320edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 02:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+zT28kDMButlPwZHfCkpmJ/Ssw+TDsJCMi0mgZkOg2Q=;
        b=sFxczMBeHWwuhl6jHk6dKbQeYjQHMEDhEzjUg0A6b4Kw+opSy31yOvEckgI/yESoBF
         fsNebX0+sO8zOhKay6Cs54uxF+bXexPJ8+VYXOvETzDmRET181+LkPBFmSTCEQC7JbpS
         nL9AFObpb4O1ow/KpEU2fGqP0Ok8Ez9K/o87acd/zt/QF5wuUPv/7Cu7OojB1hSdiWUs
         50lKBK5jqg2z1q0HNQ1knrdlZ9BIFF76jx4R/WA0p+wHZUURKXZzagYZA1bQNh1yEJnd
         jYQ9GbIdDEu4/QsCHEI8kz6VhZMEauFQuh4yv5hReB6892aE5NGPyQ4sA5hHOTKc2luR
         l7sA==
X-Gm-Message-State: APjAAAWa08fTpoaWRgLon9eodIFAVZAxxGEK8pqZB1gSsJil06Y2ErPY
        QmL/n6if3ygKT+ALfQKdAzqq/w==
X-Google-Smtp-Source: APXvYqxWqx1BXim3osj7InhTfgyiU/TFaZ8oSwxYwGC9hVRHUp26/iX/AIwhfiWLSMBsDRPy0dFkYQ==
X-Received: by 2002:a50:9317:: with SMTP id m23mr6204623eda.114.1555494722581;
        Wed, 17 Apr 2019 02:52:02 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h16sm8082640eja.23.2019.04.17.02.52.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 02:52:01 -0700 (PDT)
Subject: Re: [PATCH v3 11/13] platform/x86: intel_cht_int33fe: Provide fwnode
 for the USB connector
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-12-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <daed3557-7595-86c5-fde1-6ec048b0935d@redhat.com>
Date:   Wed, 17 Apr 2019 11:52:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412134122.82903-12-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-04-19 15:41, Heikki Krogerus wrote:
> In ACPI, and now also in DT, the USB connectors usually have
> their own device nodes. In case of USB Type-C, those
> connector (port) nodes are child nodes of the controller or
> PHY device, in our case the fusb302. The software fwnodes
> allow us to create a similar child node for fusb302 that
> represents the connector also on Intel CHT.
> 
> This makes it possible replace the fusb302 specific device
> properties which were deprecated with the common USB
> connector properties that tcpm.c is able to use directly.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/platform/x86/intel_cht_int33fe.c | 37 ++++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 863a792d9282..eff5990322ff 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -24,6 +24,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
> +#include <linux/usb/pd.h>
>   
>   #define EXPECTED_PTYPE		4
>   
> @@ -31,6 +32,7 @@ enum {
>   	INT33FE_NODE_FUSB302,
>   	INT33FE_NODE_MAX17047,
>   	INT33FE_NODE_PI3USB30532,
> +	INT33FE_NODE_USB_CONNECTOR,
>   	INT33FE_NODE_MAX,
>   };
>   
> @@ -111,9 +113,29 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
>   
>   static const struct property_entry fusb302_props[] = {
>   	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
> -	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
> -	PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
> -	PROPERTY_ENTRY_U32("fcs,max-sink-microwatt", 36000000),

Note that the 36000000 value being removed here is max-sink-microwatt,
esp. the _max_ part is important. And recent versions of the fusb302
code ignore this entirely.

> +	{ }
> +};
> +
> +#define PDO_FIXED_FLAGS \
> +	(PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
> +
> +static const u32 src_pdo[] = {
> +	PDO_FIXED(5000, 1500, PDO_FIXED_FLAGS),
> +};
> +
> +static const u32 snk_pdo[] = {
> +	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
> +	PDO_VAR(5000, 12000, 3000),
> +};
> +
> +static const struct property_entry usb_connector_props[] = {
> +	PROPERTY_ENTRY_STRING("name", "connector"),
> +	PROPERTY_ENTRY_STRING("data-role", "dual"),
> +	PROPERTY_ENTRY_STRING("power-role", "dual"),
> +	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
> +	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
> +	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
> +	PROPERTY_ENTRY_U32("op-sink-microwatt", 36000000),

Where as "op-sink-microwatt" is more interpreted as a minimum
value for non PPS supplies not being able to deliver this causes
the Capability Mismatch to get set. But for PPS supplies if I'm
reading the code correctly, the entire PPS negotiation is failed
by tcpm.c if this cannot be matched. I guess / hope that there
is a fallback to none PPS PDOs then but I'm not sure.

Anyways the charger the GPD-win ships with is a non PD capable
5V/2A charger and the GPD-pocket ships with a charger which does
max 12V/2A. The device itself will work fine on around 10W and
even charge at that level (albeit slowly). So I believe that 10W
would be a better value for "op-sink-microwatt" (the dt-binding
says it is mandatory so we cannot just leave it out).

Regards,

Hans





>   	{ }
>   };
>   
> @@ -148,6 +170,15 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>   		data->node[i] = fwnode;
>   	}
>   
> +	/* Node for the USB connector (FUSB302 is the parent) */
> +	fwnode = fwnode_create_software_node(usb_connector_props,
> +					     data->node[INT33FE_NODE_FUSB302]);
> +	if (IS_ERR(fwnode)) {
> +		ret = PTR_ERR(fwnode);
> +		goto err_remove_nodes;
> +	}
> +	data->node[INT33FE_NODE_USB_CONNECTOR] = fwnode;
> +
>   	return 0;
>   
>   err_remove_nodes:
> 
