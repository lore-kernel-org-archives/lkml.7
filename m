Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9F5C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5332820692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgAHQmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:42:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:36740 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgAHQmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:42:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="218114319"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jan 2020 08:42:48 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipEPw-0005Uf-2f; Wed, 08 Jan 2020 18:42:48 +0200
Date:   Wed, 8 Jan 2020 18:42:48 +0200
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
Subject: Re: [PATCH v2 13/36] platform/x86: intel_scu_ipc: Reformat
 kernel-doc comments of exported functions
Message-ID: <20200108164248.GE32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-14-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-14-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:38PM +0300, Mika Westerberg wrote:
> Format kernel-doc comments of the exported functions to follow the
> typical format that does not have tab indentation. Also capitalize
> parameter descriptions and add a missing period.
> 
> No functional changes intended.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 112 +++++++++++++--------------
>  1 file changed, 55 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index e3f658f1b40a..b1ac381bb7dd 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -219,14 +219,14 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
>  }
>  
>  /**
> - *	intel_scu_ipc_ioread8		-	read a word via the SCU
> - *	@addr: register on SCU
> - *	@data: return pointer for read byte
> + * intel_scu_ipc_ioread8		-	read a word via the SCU
> + * @addr: Register on SCU
> + * @data: Return pointer for read byte
>   *
> - *	Read a single register. Returns 0 on success or an error code. All
> - *	locking between SCU accesses is handled for the caller.
> + * Read a single register. Returns %0 on success or an error code. All
> + * locking between SCU accesses is handled for the caller.
>   *
> - *	This function may sleep.
> + * This function may sleep.
>   */
>  int intel_scu_ipc_ioread8(u16 addr, u8 *data)
>  {
> @@ -235,14 +235,14 @@ int intel_scu_ipc_ioread8(u16 addr, u8 *data)
>  EXPORT_SYMBOL(intel_scu_ipc_ioread8);
>  
>  /**
> - *	intel_scu_ipc_iowrite8		-	write a byte via the SCU
> - *	@addr: register on SCU
> - *	@data: byte to write
> + * intel_scu_ipc_iowrite8		-	write a byte via the SCU
> + * @addr: Register on SCU
> + * @data: Byte to write
>   *
> - *	Write a single register. Returns 0 on success or an error code. All
> - *	locking between SCU accesses is handled for the caller.
> + * Write a single register. Returns %0 on success or an error code. All
> + * locking between SCU accesses is handled for the caller.
>   *
> - *	This function may sleep.
> + * This function may sleep.
>   */
>  int intel_scu_ipc_iowrite8(u16 addr, u8 data)
>  {
> @@ -251,17 +251,17 @@ int intel_scu_ipc_iowrite8(u16 addr, u8 data)
>  EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
>  
>  /**
> - *	intel_scu_ipc_readvv		-	read a set of registers
> - *	@addr: register list
> - *	@data: bytes to return
> - *	@len: length of array
> + * intel_scu_ipc_readvv		-	read a set of registers
> + * @addr: Register list
> + * @data: Bytes to return
> + * @len: Length of array
>   *
> - *	Read registers. Returns 0 on success or an error code. All
> - *	locking between SCU accesses is handled for the caller.
> + * Read registers. Returns %0 on success or an error code. All locking
> + * between SCU accesses is handled for the caller.
>   *
> - *	The largest array length permitted by the hardware is 5 items.
> + * The largest array length permitted by the hardware is 5 items.
>   *
> - *	This function may sleep.
> + * This function may sleep.
>   */
>  int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
>  {
> @@ -270,18 +270,17 @@ int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
>  EXPORT_SYMBOL(intel_scu_ipc_readv);
>  
>  /**
> - *	intel_scu_ipc_writev		-	write a set of registers
> - *	@addr: register list
> - *	@data: bytes to write
> - *	@len: length of array
> + * intel_scu_ipc_writev		-	write a set of registers
> + * @addr: Register list
> + * @data: Bytes to write
> + * @len: Length of array
>   *
> - *	Write registers. Returns 0 on success or an error code. All
> - *	locking between SCU accesses is handled for the caller.
> + * Write registers. Returns %0 on success or an error code. All locking
> + * between SCU accesses is handled for the caller.
>   *
> - *	The largest array length permitted by the hardware is 5 items.
> - *
> - *	This function may sleep.
> + * The largest array length permitted by the hardware is 5 items.
>   *
> + * This function may sleep.
>   */
>  int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
>  {
> @@ -290,19 +289,18 @@ int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
>  EXPORT_SYMBOL(intel_scu_ipc_writev);
>  
>  /**
> - *	intel_scu_ipc_update_register	-	r/m/w a register
> - *	@addr: register address
> - *	@bits: bits to update
> - *	@mask: mask of bits to update
> + * intel_scu_ipc_update_register	-	r/m/w a register
> + * @addr: Register address
> + * @bits: Bits to update
> + * @mask: Mask of bits to update
>   *
> - *	Read-modify-write power control unit register. The first data argument
> - *	must be register value and second is mask value
> - *	mask is a bitmap that indicates which bits to update.
> - *	0 = masked. Don't modify this bit, 1 = modify this bit.
> - *	returns 0 on success or an error code.
> + * Read-modify-write power control unit register. The first data argument
> + * must be register value and second is mask value mask is a bitmap that
> + * indicates which bits to update. %0 = masked. Don't modify this bit, %1 =
> + * modify this bit. returns %0 on success or an error code.
>   *
> - *	This function may sleep. Locking between SCU accesses is handled
> - *	for the caller.
> + * This function may sleep. Locking between SCU accesses is handled
> + * for the caller.
>   */
>  int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
>  {
> @@ -312,16 +310,16 @@ int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
>  EXPORT_SYMBOL(intel_scu_ipc_update_register);
>  
>  /**
> - *	intel_scu_ipc_simple_command	-	send a simple command
> - *	@cmd: command
> - *	@sub: sub type
> + * intel_scu_ipc_simple_command	-	send a simple command
> + * @cmd: Command
> + * @sub: Sub type
>   *
> - *	Issue a simple command to the SCU. Do not use this interface if
> - *	you must then access data as any data values may be overwritten
> - *	by another SCU access by the time this function returns.
> + * Issue a simple command to the SCU. Do not use this interface if you must
> + * then access data as any data values may be overwritten by another SCU
> + * access by the time this function returns.
>   *
> - *	This function may sleep. Locking for SCU accesses is handled for
> - *	the caller.
> + * This function may sleep. Locking for SCU accesses is handled for the
> + * caller.
>   */
>  int intel_scu_ipc_simple_command(int cmd, int sub)
>  {
> @@ -341,16 +339,16 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
>  EXPORT_SYMBOL(intel_scu_ipc_simple_command);
>  
>  /**
> - *	intel_scu_ipc_command	-	command with data
> - *	@cmd: command
> - *	@sub: sub type
> - *	@in: input data
> - *	@inlen: input length in dwords
> - *	@out: output data
> - *	@outlein: output length in dwords
> + * intel_scu_ipc_command	-	command with data
> + * @cmd: Command
> + * @sub: Sub type
> + * @in: Input data
> + * @inlen: Input length in dwords
> + * @out: Output data
> + * @outlen: Output length in dwords
>   *
> - *	Issue a command to the SCU which involves data transfers. Do the
> - *	data copies under the lock but leave it for the caller to interpret
> + * Issue a command to the SCU which involves data transfers. Do the
> + * data copies under the lock but leave it for the caller to interpret.
>   */
>  int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
>  			  u32 *out, int outlen)
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


