Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3828C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E2620692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgAHQmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:42:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:10190 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgAHQmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:42:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:42:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="303603238"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 08:42:11 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipEPL-0005UD-5m; Wed, 08 Jan 2020 18:42:11 +0200
Date:   Wed, 8 Jan 2020 18:42:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/36] platform/x86: intel_scu_ipc: Drop
 intel_scu_ipc_raw_command()
Message-ID: <20200108164211.GD32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-12-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-12-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:36PM +0300, Mika Westerberg wrote:
> There is no user for this function so we can drop it from the driver.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_scu_ipc.h |  2 -
>  drivers/platform/x86/intel_scu_ipc.c | 63 ----------------------------
>  2 files changed, 65 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
> index b59afa59a4cb..2a1442ba6e78 100644
> --- a/arch/x86/include/asm/intel_scu_ipc.h
> +++ b/arch/x86/include/asm/intel_scu_ipc.h
> @@ -38,8 +38,6 @@ int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
>  int intel_scu_ipc_simple_command(int cmd, int sub);
>  int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
>  			  u32 *out, int outlen);
> -int intel_scu_ipc_raw_command(int cmd, int sub, u8 *in, int inlen,
> -			      u32 *out, int outlen, u32 dptr, u32 sptr);
>  
>  extern struct blocking_notifier_head intel_scu_notifier;
>  
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index ba857e54800b..93a810fa6c8a 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -383,69 +383,6 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
>  }
>  EXPORT_SYMBOL(intel_scu_ipc_command);
>  
> -#define IPC_SPTR		0x08
> -#define IPC_DPTR		0x0C
> -
> -/**
> - * intel_scu_ipc_raw_command() - IPC command with data and pointers
> - * @cmd:	IPC command code.
> - * @sub:	IPC command sub type.
> - * @in:		input data of this IPC command.
> - * @inlen:	input data length in dwords.
> - * @out:	output data of this IPC command.
> - * @outlen:	output data length in dwords.
> - * @sptr:	data writing to SPTR register.
> - * @dptr:	data writing to DPTR register.
> - *
> - * Send an IPC command to SCU with input/output data and source/dest pointers.
> - *
> - * Return:	an IPC error code or 0 on success.
> - */
> -int intel_scu_ipc_raw_command(int cmd, int sub, u8 *in, int inlen,
> -			      u32 *out, int outlen, u32 dptr, u32 sptr)
> -{
> -	struct intel_scu_ipc_dev *scu = &ipcdev;
> -	int inbuflen = DIV_ROUND_UP(inlen, 4);
> -	u32 inbuf[4];
> -	int i, err;
> -
> -	/* Up to 16 bytes */
> -	if (inbuflen > 4)
> -		return -EINVAL;
> -
> -	mutex_lock(&ipclock);
> -	if (scu->dev == NULL) {
> -		mutex_unlock(&ipclock);
> -		return -ENODEV;
> -	}
> -
> -	writel(dptr, scu->ipc_base + IPC_DPTR);
> -	writel(sptr, scu->ipc_base + IPC_SPTR);
> -
> -	/*
> -	 * SRAM controller doesn't support 8-bit writes, it only
> -	 * supports 32-bit writes, so we have to copy input data into
> -	 * the temporary buffer, and SCU FW will use the inlen to
> -	 * determine the actual input data length in the temporary
> -	 * buffer.
> -	 */
> -	memcpy(inbuf, in, inlen);
> -
> -	for (i = 0; i < inbuflen; i++)
> -		ipc_data_writel(scu, inbuf[i], 4 * i);
> -
> -	ipc_command(scu, (inlen << 16) | (sub << 12) | cmd);
> -	err = intel_scu_ipc_check_status(scu);
> -	if (!err) {
> -		for (i = 0; i < outlen; i++)
> -			*out++ = ipc_data_readl(scu, 4 * i);
> -	}
> -
> -	mutex_unlock(&ipclock);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(intel_scu_ipc_raw_command);
> -
>  /*
>   * Interrupt handler gets called when ioc bit of IPC_COMMAND_REG set to 1
>   * When ioc bit is set to 1, caller api must wait for interrupt handler called
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


