Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526F421850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553066669;
	bh=LKSGoa7DsIhXCSg0GT6TmhCEBzU9cUCmQC9JwaSOddg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CGkfYs1+gSXS6DWozp4d8B9xgshBCPYI5d+JyBrgC5p02KS36ufoYuRqa3mIMHm7N
	 dpHsnC7p2a1GjDnfnBwWj9ivb51OLAE7sqe3jMV/L5iWAueNSWI8GD5uVX3NvII2nf
	 t318PUba8eBDgQYGP6sdPp55LtUriTXwo44hSLD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCTHY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTHY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:24:27 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823F121841;
        Wed, 20 Mar 2019 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553066667;
        bh=LKSGoa7DsIhXCSg0GT6TmhCEBzU9cUCmQC9JwaSOddg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiSsL3jbW9n6vDtU4OiEnJkf3hibFnU86PaeRywVD1pijTWvtiuLM485j/4yJjIrq
         MlVbh07E9GsGkDYbwzPWaqv6FsjpwGFnVKx8GccIqa5Z7Cqt9gGRXrM+hfZ8/wC4jU
         nqb7Iw/p3jAnJHBAVqesI+6HyZCH1beKfsvwjYx4=
Date:   Wed, 20 Mar 2019 08:24:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>,
        kjlu@umn.edu, linux-kernel@vger.kernel.org,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2] staging: rtl8188eu: Fix potential NULL pointer
 dereference
Message-ID: <20190320072424.GD2647@kroah.com>
References: <20190319210801.19074-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319210801.19074-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:07:54PM -0500, Aditya Pakki wrote:
> hwxmits is allocated via kcalloc and not checked for failure before its
> dereference. The patch fixes this problem by returning an error in
> rtl8723bs.
> 
> ---
> v1: Return error and remove print in case of failure, per Greg
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Please fix.
