Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC51A2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567774792;
	bh=7dNk/wkZnLE10eskmOPYWTGcMMyxymm+d1pUFfQCuyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iG0RNqL5X6mPh+K5B0dHGYxteRjffyZGt1wXxVk/H260eGOHRWtAaqbvJHvS3vk4z
	 ryqbNRDTxrlrsXmNKsbZ0W+mCzCdmSJZHncC6iDeMw31wWKUQFqE+LOvv5bGUJ2tFr
	 4psEWjAsLVzDK0z8hJSxLeEE53dvjcx90FW1SXcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405072AbfIFM7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389339AbfIFM7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:59:49 -0400
Received: from linux-8ccs (unknown [92.117.154.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159162082C;
        Fri,  6 Sep 2019 12:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567774789;
        bh=7dNk/wkZnLE10eskmOPYWTGcMMyxymm+d1pUFfQCuyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jWKjib7HXGf9DXvqicd2O3TEr9G0MiiQirVVoMEPsSyl3Ax2Z7E/pgZPmsIeGvtmw
         9aIEF/zG7KLYJ5GJqeQgT9JGXX0vXR5KB2Jbr1JDGzmmKzjhPSuLEEMN8mHOZtNCcq
         8p6p8wN06pECWmJcTXD9ddlnILpjS1rviRKvNfNc=
Date:   Fri, 6 Sep 2019 14:59:42 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, joel@joelfernandes.org,
        lucas.de.marchi@gmail.com, maco@android.com, sspatil@google.com,
        will@kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v5 10/11] usb-storage: remove single-use define for
 debugging
Message-ID: <20190906125942.GA31531@linux-8ccs>
References: <20180716122125.175792-1-maco@android.com>
 <20190906103235.197072-1-maennich@google.com>
 <20190906103235.197072-11-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190906103235.197072-11-maennich@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Maennich [06/09/19 11:32 +0100]:
>USB_STORAGE was defined as "usb-storage: " and used in a single location
>as argument to printk. In order to be able to use the name
>'USB_STORAGE', drop the definition and use the string directly for the
>printk call.
>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Signed-off-by: Matthias Maennich <maennich@google.com>

Greg, didn't you pick this patch up for usb-next already (for the 5.4
merge window)? If that's the case, I could apply the series omitting
this patch (once there are no more comments or complaints).

Thanks!

Jessica

