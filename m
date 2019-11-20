Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF31C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E98F224C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574258621;
	bh=Sr4kx3bxXDK/jq5hC3f7AbWAqNS3/0SiEpKAmoRIlEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J+qke4N/hCOY6mMW17/AJlUvaMgTNtlu73DncKsEAEagrazAFkpFFX2gS2TpqGkWn
	 ctyvnVYriunL7mCJhC5oymp/kNSx3GcWIgORhixDHwyfO9Fq4kCHdcKx/a3jEdfOnp
	 aOLgZUx02a4kross9wYS2mjgxS6B6RHgBjwJbjsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfKTODk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfKTODj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:03:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10AB2235D;
        Wed, 20 Nov 2019 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258619;
        bh=Sr4kx3bxXDK/jq5hC3f7AbWAqNS3/0SiEpKAmoRIlEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hK4GR1x1Abrl7VA11Xe8okhsIqIBZ/8CBV4CCQNg9xzjr2EdlHswxfpv0GARBJsD6
         Yt4A+aUDzvXdO8Co0NiYLgBp8Zwhc893A9rZzaLEfMmXshu2XEnViewLnrQnADVglA
         R6W0Gemh0Vnet6WmV9ZMnWkhFhwbh2db7bsYFB10=
Date:   Wed, 20 Nov 2019 15:03:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH 2/2] firmware: google: Expose coreboot tables over sysfs
Message-ID: <20191120140337.GC2935300@kroah.com>
References: <20191120133958.13160-1-patrick.rudolph@9elements.com>
 <20191120133958.13160-3-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133958.13160-3-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 02:39:47PM +0100, patrick.rudolph@9elements.com wrote:
> +static struct bin_attribute coreboot_attr_data = {
> +	.attr = { .name = "data", .mode = 0444 },
> +	.read = table_data_read,
> +};

BIN_ATTR_RO()?

thanks,

greg k-h
