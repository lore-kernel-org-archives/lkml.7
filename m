Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C353FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F4D214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555967173;
	bh=KmqNI8XiNhOoM2KPNxmzHiSUDuinjjS0Rwt5IpK/1AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eaK8E/uKZSVfMCCCRXVfu6ZZnhEfOt019Pta/zj+ot/UR7oXbLRJiy0+yiPJ7BsRM
	 bsUgoMjfOyr2cxwxqdHLLEYoPSu4lmCeFV+lcfhP7y0KW7DXUbImoSSBco/4Iot05y
	 xr4TpsvxI7okBrZERQpZvjL1CJ+IltcIOji3XEg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfDVVGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfDVVGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:06:10 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507BB20896;
        Mon, 22 Apr 2019 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555967169;
        bh=KmqNI8XiNhOoM2KPNxmzHiSUDuinjjS0Rwt5IpK/1AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GyfGxAgF3fg8hafSuM2XLDR4QGq/JZ8J+mfSK7WGauvsQb7BhlasyF6WwVSEikSA
         mbhAcWQuZFxi7yb4rEtR536JJ6EzPVR9bv8gyMxTXuKjyGzMyyhvDzKyrkFvTTAbkY
         dYG/Kj0UjQgt0mcNSaMYCk3Yb2VG1a0ZdM6EsUUk=
Date:   Mon, 22 Apr 2019 23:06:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, namhyung@kernel.org,
        mingo@kernel.org
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Message-ID: <20190422210606.GA8805@kroah.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422083257.21805-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:32:56AM +0300, Alexandru Ardelean wrote:
> This helper is similar to __sysfs_match_string() with the exception that it
> ignores NULL elements within the array.

sysfs is "one value per file", why are you trying to write multiple
things on a single line to a single sysfs file?

Is IIO really that messy?  :)

thanks,

greg k-h
