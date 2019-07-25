Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D09C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37679218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mSA2KEdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfGYUdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:33:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5007 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGYUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:33:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a12250000>; Thu, 25 Jul 2019 13:33:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 13:33:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 13:33:33 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jul
 2019 20:33:33 +0000
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
To:     Thomas Gleixner <tglx@linutronix.de>, <hpa@zytor.com>
CC:     <john.hubbard@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190724231528.32381-1-jhubbard@nvidia.com>
 <20190724231528.32381-2-jhubbard@nvidia.com>
 <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
 <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <345add60-de4a-73b1-0445-127738c268b4@nvidia.com>
Date:   Thu, 25 Jul 2019 13:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564086821; bh=7vIH1kWvmqez3KLZ/8msqPekiwbm2JMvpnI0by9JVgg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mSA2KEdu1hOXSHVH4ZyJXRdMsHgCXRaVIXdY+H6eGkEQIEAxauS/D1+YqulI1Rm6v
         JpyKQSChjePrUf8Eed3flbe8UOdGv0BIx+QSIkufcZCPOYLcoIhjGB5fNoWs0ClPxX
         pLmllJBDAmQaK0XNpu/RXwIZavh7GZJ0cJBOih6pp/sBSJ64D32uZabyqmgX+FKniN
         gSO/Z1pOmub8ZBEqgIwtGpr6ieF0Painiw9PKRj+t3ci2mp3yGyZvtYKUJQUqr9+hn
         zT0IMeBmX7OofAOBYRzr8wsTxaCy4c/6n3E5PT9k60NGuIL8Lk/ZppyF+02m3SNypf
         z6cMZqCxBfy5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 12:22 AM, Thomas Gleixner wrote:
> On Wed, 24 Jul 2019, hpa@zytor.com wrote:
>> On July 24, 2019 4:15:28 PM PDT, john.hubbard@gmail.com wrote:
>>> From: John Hubbard <jhubbard@nvidia.com>
>>>
>>> Recent gcc compilers (gcc 9.1) generate warnings about an
>>> out of bounds memset, if you trying memset across several fields
>>> of a struct. This generated a couple of warnings on x86_64 builds.
>>>
>>> Because struct boot_params is __packed__, normal variable
>>> variable assignment will work just as well as a memset here.
>>> Change three u32 fields to be cleared to zero that way, and
>>> just memset the _pad4 field.
>>>
>>> This clears up the build warnings for me.
>>>
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>> arch/x86/include/asm/bootparam_utils.h | 11 +++++------
>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/bootparam_utils.h
>>> b/arch/x86/include/asm/bootparam_utils.h
>>> index 101eb944f13c..4df87d4a043b 100644
>>> --- a/arch/x86/include/asm/bootparam_utils.h
>>> +++ b/arch/x86/include/asm/bootparam_utils.h
>>> @@ -37,12 +37,11 @@ static void sanitize_boot_params(struct boot_params
>>> *boot_params)
>>> 	if (boot_params->sentinel) {
>>> 		/* fields in boot_params are left uninitialized, clear them */
>>> 		boot_params->acpi_rsdp_addr = 0;
>>> -		memset(&boot_params->ext_ramdisk_image, 0,
>>> -		       (char *)&boot_params->efi_info -
>>> -			(char *)&boot_params->ext_ramdisk_image);
>>> -		memset(&boot_params->kbd_status, 0,
>>> -		       (char *)&boot_params->hdr -
>>> -		       (char *)&boot_params->kbd_status);
>>> +		boot_params->ext_ramdisk_image = 0;
>>> +		boot_params->ext_ramdisk_size = 0;
>>> +		boot_params->ext_cmd_line_ptr = 0;
>>> +
>>> +		memset(&boot_params->_pad4, 0, sizeof(boot_params->_pad4));
>>> 		memset(&boot_params->_pad7[0], 0,
>>> 		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
>>> 			(char *)&boot_params->_pad7[0]);
>>
>> The problem with this is that it will break silently when changes are
>> made to this structure.
> 
> That's not really the worst problem. Changes to that struct which touch any
> of the to be cleared ranges will break anyway if not handled correctly in
> the sanitizer function.
> 
> What's worse is that the patch is broken.  It 'clears' the build warnings,
> but not all the fields which have been cleared before:
> 
> It removes the clearing of the range between kbd_status and hdr without any
> replacement. It neither clears edid_info.


Yes. Somehow I left that chunk out. Not my finest hour. 

> 
> The above approach is doomed and if we have to handle this GCC0.1 madness
> then this needs to be done smarter. Something like the completely untested
> thing below.
> 
> Thanks,
> 
> 	tglx
> 
> 8<--------------
> diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
> index 101eb944f13c..f5bc4c01b66b 100644
> --- a/arch/x86/include/asm/bootparam_utils.h
> +++ b/arch/x86/include/asm/bootparam_utils.h
> @@ -9,6 +9,18 @@
>   * add completing #includes to make it standalone.
>   */
>  
> +struct boot_params_clear {
> +	unsigned int	offs;
> +	unsigned int	len;
> +};
> +
> +#define BOOT_PARAM_CLEAR(start, end)				\
> +{								\
> +	.offs	= offsetof(struct boot_params, start),		\
> +	.len	= offsetof(struct boot_params, end) -		\
> +		  offsetof(struct boot_params, start),		\
> +}
> +
>  /*
>   * Deal with bootloaders which fail to initialize unknown fields in
>   * boot_params to zero.  The list fields in this list are taken from
> @@ -20,7 +32,19 @@
>   */
>  static void sanitize_boot_params(struct boot_params *boot_params)
>  {
> -	/* 
> +	const struct boot_params_clear toclear[] = {
> +		BOOT_PARAM_CLEAR(acpi_rdsp_addr, _pad3),
> +		BOOT_PARAM_CLEAR(ext_ramdisk_image, efi_info),
> +		BOOT_PARAM_CLEAR(kbd_status, hdr),
> +		BOOT_PARAM_CLEAR(_pad7, edd_mbr_sig_buffer),
> +		BOOT_PARAM_CLEAR(_pad8, eddbuf),
> +		{
> +			.offs	= offsetof(struct boot_params, _pad9),
> +			.len	= sizeof(boot_params->_pad9),
> +		},
> +	}
> +
> +	/*
>  	 * IMPORTANT NOTE TO BOOTLOADER AUTHORS: do not simply clear
>  	 * this field.  The purpose of this field is to guarantee
>  	 * compliance with the x86 boot spec located in
> @@ -36,20 +60,11 @@ static void sanitize_boot_params(struct boot_params *boot_params)
>  	 */
>  	if (boot_params->sentinel) {
>  		/* fields in boot_params are left uninitialized, clear them */
> -		boot_params->acpi_rsdp_addr = 0;
> -		memset(&boot_params->ext_ramdisk_image, 0,
> -		       (char *)&boot_params->efi_info -
> -			(char *)&boot_params->ext_ramdisk_image);
> -		memset(&boot_params->kbd_status, 0,
> -		       (char *)&boot_params->hdr -
> -		       (char *)&boot_params->kbd_status);
> -		memset(&boot_params->_pad7[0], 0,
> -		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
> -			(char *)&boot_params->_pad7[0]);
> -		memset(&boot_params->_pad8[0], 0,
> -		       (char *)&boot_params->eddbuf[0] -
> -			(char *)&boot_params->_pad8[0]);
> -		memset(&boot_params->_pad9[0], 0, sizeof(boot_params->_pad9));
> +		char *p = (char *) boot_params;
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(toclear); i++)
> +			memset(p + toclear[i].start, 0, toclear[i].len);
>  	}
>  }


Looks nice.


thanks,
-- 
John Hubbard
NVIDIA
