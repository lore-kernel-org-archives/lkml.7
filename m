Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE99CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899CB2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366954;
	bh=IU8BXeRqGfeflmR7lycoGix76x/12u88OXgqpyAdQ7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jAi6kTpudp0HV3FkOIOU7JUiETNlmKuuvXM67ot1QPZcdaANYh53LLcDld0NFrRd2
	 n2LPqnzv33jmspPqARILHgXZ8RKWgVaIBK2Z8SpBx1beOpUqjEaEJJi2yFWHJGPS02
	 CJkTwkHIqyQOsZXo2Dxpjl7fLxR5LIpZVqBZsbpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbfB1PPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:15:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34913 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbfB1PPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:15:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so17976242otm.2;
        Thu, 28 Feb 2019 07:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0j6joHu15+je8kSpGX+0UlDC66GvtH0yHijikizo0hM=;
        b=cQ+y457f8MMEkf1NPH6PnLfvRGazLAxrCbgZm32CtkxgjwmckEFZjb/5PvChneRlJg
         YZC5MM36ipbdi5roBKJvKNTb4/KmzWjSyVw0nZDu6ajvCfEEfc/Vbt9ZlVgSfGXEWZMd
         KoUs4LYbGb1Su5uEPXg2Y6SAi2t35U8ipHyhEMUrgqT0xTDlL1D+5bz3hbGn66HAR5D/
         m2kz7z3IMDHpP3lxXOansCsR+nwxi1Bxciw1KGgLJbhL9w6UuxiJOOV+sXaiVG6bJb5T
         lIjt0c7UmQC/IL0SzrzUFpolvBEOg7cyjSQxHRBxJhbUY0IjbiasjBPFGP+Xw0metXYS
         guJA==
X-Gm-Message-State: APjAAAVyjPZuOzTplb37vx9Ta+6R0XsHaXkpD2x/zhQmwR3SSXCFPY+e
        T4jlznRyfkUCJjj+c8Rxkw==
X-Google-Smtp-Source: APXvYqx4WqzXTDqLTM1AGOs2KwxXp1XXhFkZX2RCQwVyVMFxRlwPgBLi84yHPOFGh5OXAdq37/GHYQ==
X-Received: by 2002:a9d:5c82:: with SMTP id a2mr47341oti.3.1551366944246;
        Thu, 28 Feb 2019 07:15:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y12sm7404959otk.80.2019.02.28.07.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 07:15:43 -0800 (PST)
Date:   Thu, 28 Feb 2019 09:15:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: Add missing documentation for lm75
Message-ID: <20190228151543.GA18597@bogus>
References: <20190212113808.3040-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212113808.3040-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 05:08:08PM +0530, Jagan Teki wrote:
> Add missing dt-binding documentation for lm75 hwmon sensor.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> -  Add all compatible nodes available in lm75.
> 
>  .../devicetree/bindings/hwmon/lm75.txt        | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
> new file mode 100644
> index 000000000000..12d8cf7cf592
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.txt
> @@ -0,0 +1,37 @@
> +*LM75 hwmon sensor.
> +
> +Required properties:
> +- compatible: manufacturer and chip name, one of
> +		"adi,adt75",
> +		"dallas,ds1775",
> +		"dallas,ds75",
> +		"dallas,ds7505",
> +		"gmt,g751",
> +		"national,lm75",
> +		"national,lm75a",
> +		"national,lm75b",
> +		"maxim,max6625",
> +		"maxim,max6626",
> +		"maxim,max31725",
> +		"maxim,max31726",
> +		"maxim,mcp980x",
> +		"st,stds75",
> +		"st,stlm75",
> +		"microchip,tcn75",
> +		"ti,tmp100",
> +		"ti,tmp101",
> +		"ti,tmp105",
> +		"ti,tmp112",
> +		"ti,tmp175",
> +		"ti,tmp275",
> +		"ti,tmp75",
> +		"ti,tmp75c",

Some of these are in trivial-devices.yaml already. So you either need to 
remove them from there. Or you can move all these to trivial-devices and 
benefit from having a schema. I prefer the latter, but either way is 
fine. You can remove them from trivial-devices.yaml in a separate patch, 
so:

Acked-by: Rob Herring <robh@kernel.org>

Rob

P.S. Third option is convert this doc to DT schema. Don't tell anyone, 
but you'll be a the top of my review queue.
