Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB2C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6FC2083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfGUTIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 15:08:01 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:34799 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727216AbfGUTIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 15:08:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E50A8181D3368;
        Sun, 21 Jul 2019 19:07:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drain48_b525613ac200
X-Filterd-Recvd-Size: 2305
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jul 2019 19:07:57 +0000 (UTC)
Message-ID: <300d3c06763883bc4af2d25d5466b7188d20e8f3.camel@perches.com>
Subject: Re: [PATCH v10 3/6] usb:common Patch simplify
 usb_decode_set_clear_feature function.
From:   Joe Perches <joe@perches.com>
To:     Pawel Laszczak <pawell@cadence.com>, felipe.balbi@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        rogerq@ti.com, linux-kernel@vger.kernel.org, jbergsagel@ti.com,
        nsekhar@ti.com, nm@ti.com, sureshp@cadence.com, jpawar@cadence.com,
        kurahul@cadence.com, aniljoy@cadence.com
Date:   Sun, 21 Jul 2019 12:07:56 -0700
In-Reply-To: <1563733939-21214-4-git-send-email-pawell@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
         <1563733939-21214-4-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-21 at 19:32 +0100, Pawel Laszczak wrote:
> Patch adds usb_decode_test_mode and usb_decode_device_feature functions,
> which allow to make more readable and simplify the
> usb_decode_set_clear_feature function.

<chuckle>  I need to read entire patch series before
commenting more I guess...

> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/common/debug.c | 89 ++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
[]
> +static const char *usb_decode_device_feature(u16 wValue)

I believe this is still unnecessary hungarian.

> +{
> +	switch (wValue) {
> +	case USB_DEVICE_SELF_POWERED:
> +		return "Self Powered";
> +	case USB_DEVICE_REMOTE_WAKEUP:
> +		return "Remote Wakeup";
> +	case USB_DEVICE_TEST_MODE:
> +		return "Test Mode";
> +	case USB_DEVICE_U1_ENABLE:
> +		return "U1 Enable";
> +	case USB_DEVICE_U2_ENABLE:
> +		return "U2 Enable";
> +	case USB_DEVICE_LTM_ENABLE:
> +		return "LTM Enable";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}

But yeah, exactly like this... ;)


