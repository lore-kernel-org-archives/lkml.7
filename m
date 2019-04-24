Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B02C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F7B20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556130409;
	bh=F+6me7MTYts2NQbnvjLd0jtOQSNfUSvWqCoT1rIddl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mOIBY3/UAJaEv6F8XlS+JiRqd0F9nwoZVVXLAHwBDK3EJuzr96Op4lPhamAhL6/UW
	 56m9SDlztFUDNKrSp/2qaIARlQBe+AZlRna7JcVjAEKdCEvA9uoGSVChIgxGdm73bH
	 L3K2r3GNFCFWGV9sLUZUzIyhC98o2qFxl+FOuNd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfDXS0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:26:48 -0400
Received: from casper.infradead.org ([85.118.1.10]:50252 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732960AbfDXS0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zpl3Kp5jL5IHSrBY2v6relyH7ftFWN04nThOvb5SeQc=; b=NngPC7x8RnR6PtI2sKhTEdwt2u
        hBqSl2z4Lm86ts5tRoh3imK2EC7PCxdY74WBq3lNB+8h/GxS4T/cqkemJ7ubWWFLuQhr5yNxLTSPv
        N5jRboYCYTO4yw+bPtSXIP70yXPC+Fges3LSPN504OaRMPSjx/8A0fK5ogmQKmn+rxAtWTqeYsee5
        WpfNI24TSCh5YJFm2qsgisll6qgvR0hDwNlD2X0D4h+N7YxX1IpBoUASbfehac0z1nDaY+hFNRGVJ
        SbMIRYxTDIWUhqJTwu0x05HdlgFZVXhYbtZWu0yaOQuXDikizLMBzcLAOKNhpETBTJ0ChkdG0VOJ7
        mrIvLCaw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJMbU-0002RD-66; Wed, 24 Apr 2019 18:26:44 +0000
Date:   Wed, 24 Apr 2019 15:26:38 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>, linux-acpi@vger.kernel.org
Cc:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 23/23] Documentation: ACPI: move video_extension.txt
 to firmware-guide/acpi and convert to reST
Message-ID: <20190424152638.76691e9e@coco.lan>
In-Reply-To: <20190424175306.25880-24-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
        <20190424175306.25880-24-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Apr 2019 01:53:06 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  .../acpi/video_extension.rst}                 | 83 +++++++++++--------
>  2 files changed, 50 insertions(+), 34 deletions(-)
>  rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (70%)
> 
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 0e60f4b7129a..ae609eec4679 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -23,3 +23,4 @@ ACPI Support
>     i2c-muxes
>     acpi-lid
>     lpit
> +   video_extension
> diff --git a/Documentation/acpi/video_extension.txt b/Documentation/firmware-guide/acpi/video_extension.rst
> similarity index 70%
> rename from Documentation/acpi/video_extension.txt
> rename to Documentation/firmware-guide/acpi/video_extension.rst
> index 79bf6a4921be..099b8607e07b 100644
> --- a/Documentation/acpi/video_extension.txt
> +++ b/Documentation/firmware-guide/acpi/video_extension.rst
> @@ -1,5 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
>  ACPI video extensions
> -~~~~~~~~~~~~~~~~~~~~~
> +=====================
>  
>  This driver implement the ACPI Extensions For Display Adapters for
>  integrated graphics devices on motherboard, as specified in ACPI 2.0
> @@ -8,9 +11,10 @@ defining the video POST device, retrieving EDID information or to
>  setup a video output, etc.  Note that this is an ref. implementation
>  only.  It may or may not work for your integrated video device.
>  
> -The ACPI video driver does 3 things regarding backlight control:
> +The ACPI video driver does 3 things regarding backlight control.

Hmm... didn't notice this change before... The way it is, this
sentence sounds incomplete, specially since you removed the
numbering from the paragraphs. Perhaps you could, instead, be
explicit about what the video driver does, e. g.:

	The ACPI video driver exports the backlight control via a
	sysfs interface, notifies userspace with events and
	changes the backlight level via ACPI firmware, as detailed
	at the following chapters:

@ACPI maintainers: 

Please check if the above properly summarizes the activity done 
with regards to backlight control.

If you agree with that, feel free to add:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  
> -1 Export a sysfs interface for user space to control backlight level
> +Export a sysfs interface for user space to control backlight level
> +==================================================================
>  
>  If the ACPI table has a video device, and acpi_backlight=vendor kernel
>  command line is not present, the driver will register a backlight device
> @@ -22,36 +26,41 @@ The backlight sysfs interface has a standard definition here:
>  Documentation/ABI/stable/sysfs-class-backlight.
>  
>  And what ACPI video driver does is:
> -actual_brightness: on read, control method _BQC will be evaluated to
> -get the brightness level the firmware thinks it is at;
> -bl_power: not implemented, will set the current brightness instead;
> -brightness: on write, control method _BCM will run to set the requested
> -brightness level;
> -max_brightness: Derived from the _BCL package(see below);
> -type: firmware
> +
> +actual_brightness:
> +  on read, control method _BQC will be evaluated to
> +  get the brightness level the firmware thinks it is at;
> +bl_power:
> +  not implemented, will set the current brightness instead;
> +brightness:
> +  on write, control method _BCM will run to set the requested brightness level;
> +max_brightness:
> +  Derived from the _BCL package(see below);
> +type:
> +  firmware
>  
>  Note that ACPI video backlight driver will always use index for
>  brightness, actual_brightness and max_brightness. So if we have
> -the following _BCL package:
> +the following _BCL package::
>  
> -Method (_BCL, 0, NotSerialized)
> -{
> -	Return (Package (0x0C)
> +	Method (_BCL, 0, NotSerialized)
>  	{
> -		0x64,
> -		0x32,
> -		0x0A,
> -		0x14,
> -		0x1E,
> -		0x28,
> -		0x32,
> -		0x3C,
> -		0x46,
> -		0x50,
> -		0x5A,
> -		0x64
> -	})
> -}
> +		Return (Package (0x0C)
> +		{
> +			0x64,
> +			0x32,
> +			0x0A,
> +			0x14,
> +			0x1E,
> +			0x28,
> +			0x32,
> +			0x3C,
> +			0x46,
> +			0x50,
> +			0x5A,
> +			0x64
> +		})
> +	}
>  
>  The first two levels are for when laptop are on AC or on battery and are
>  not used by Linux currently. The remaining 10 levels are supported levels
> @@ -62,13 +71,15 @@ as a "brightness level" indicator. Thus from the user space perspective
>  the range of available brightness levels is from 0 to 9 (max_brightness)
>  inclusive.
>  
> -2 Notify user space about hotkey event
> +Notify user space about hotkey event
> +====================================
>  
>  There are generally two cases for hotkey event reporting:
> +
>  i) For some laptops, when user presses the hotkey, a scancode will be
>     generated and sent to user space through the input device created by
>     the keyboard driver as a key type input event, with proper remap, the
> -   following key code will appear to user space:
> +   following key code will appear to user space::
>  
>  	EV_KEY, KEY_BRIGHTNESSUP
>  	EV_KEY, KEY_BRIGHTNESSDOWN
> @@ -84,23 +95,27 @@ ii) For some laptops, the press of the hotkey will not generate the
>      notify value it received and send the event to user space through the
>      input device it created:
>  
> +	=====		==================
>  	event		keycode
> +	=====		==================
>  	0x86		KEY_BRIGHTNESSUP
>  	0x87		KEY_BRIGHTNESSDOWN
>  	etc.
> +	=====		==================
>  
>  so this would lead to the same effect as case i) now.
>  
>  Once user space tool receives this event, it can modify the backlight
>  level through the sysfs interface.
>  
> -3 Change backlight level in the kernel
> +Change backlight level in the kernel
> +====================================
>  
>  This works for machines covered by case ii) in Section 2. Once the driver
>  received a notification, it will set the backlight level accordingly. This does
>  not affect the sending of event to user space, they are always sent to user
>  space regardless of whether or not the video module controls the backlight level
>  directly. This behaviour can be controlled through the brightness_switch_enabled
> -module parameter as documented in admin-guide/kernel-parameters.rst. It is recommended to
> -disable this behaviour once a GUI environment starts up and wants to have full
> -control of the backlight level.
> +module parameter as documented in admin-guide/kernel-parameters.rst. It is
> +recommended to disable this behaviour once a GUI environment starts up and
> +wants to have full control of the backlight level.



Thanks,
Mauro
