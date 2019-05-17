Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B44C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6FC217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558115971;
	bh=SWL63IOuJG5gM5oQVFmjLL4N6Eo6juwVs637U8pmW3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PH3zazdjFsN8UuMDd6CBsUaA5kd9jnuMbr32EGGfuDVTJIEarZQVadRZUH3CjhIK4
	 m0d+YIhTGd6ZsD6y48z9pMTJblyQHe5EvIxT+QnPrJDIp0A7FoZGvQ5kLcSHJGMbK5
	 w3bbnePvbk+7H2Kwq9/uK5hXoQkK6bda15cNIXqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfEQR7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfEQR73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:59:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E16921773;
        Fri, 17 May 2019 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558115969;
        bh=SWL63IOuJG5gM5oQVFmjLL4N6Eo6juwVs637U8pmW3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Awo8jfRwqiLbT4uODENudpkr3n04WnSim8CidHfOxdmkowkaMyYyxbO/A+pXFKRYB
         ud7LuUB2+LYBY4084ih5NRclyWBW/sQZLKYGeseqa7U0/d6EvTH923bBN3Sy5OIs4o
         UdaX4xTRzNjihMcRiAGeutga/17xArb/5I5iTWTE=
Date:   Fri, 17 May 2019 19:59:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] platform/mellanox/mlxbf-bootctl: Add the ABI
 definitions
Message-ID: <20190517175926.GA24535@kroah.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-2-git-send-email-lsun@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558115345-32476-2-git-send-email-lsun@mellanox.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 01:49:05PM -0400, Liming Sun wrote:
> This commit adds the ABI definitions exposed to userspace for
> the platform/mellanox/mlxbf-bootctl driver.
> 
> Reviewed-by: Vadim Pasternak <vadimp@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> ---
>  .../ABI/testing/sysfs-platform-mellanox-bootctl    | 58 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> new file mode 100644
> index 0000000..19a14db
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> @@ -0,0 +1,58 @@
> +What:		/sys/bus/platform/drivers/mlxbf-bootctl/lifecycle_state
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	"Liming Sun <lsun@mellanox.com>"
> +Description:
> +		The Life-cycle state of the SoC, which could be one of the
> +		following values.
> +		  Production - Production state and can be updated to secure
> +		  GA Secured - Secure chip and not able to change state
> +		  GA Non-Secured - Non-Secure chip and not able to change state
> +		  RMA - Return Merchandise Authorization

A "driver" does not have a lifecycle state, a "device" does.

You are putting all of these attributes in the wrong place.  Put them on
your device please, not the driver.  driver-specific attributes are
_VERY_ rare, and only for things that can modify/show for all devices
attached to that driver.

thanks,

greg k-h
