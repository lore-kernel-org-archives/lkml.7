Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA32C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1B922B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfLLJBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:01:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:47745 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfLLJBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:01:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 01:01:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,305,1571727600"; 
   d="scan'208";a="220648559"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 12 Dec 2019 01:01:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 12 Dec 2019 11:01:32 +0200
Date:   Thu, 12 Dec 2019 11:01:32 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: Fix an undefined reference to
 'extcon_get_state'
Message-ID: <20191212090132.GC31345@kuha.fi.intel.com>
References: <1576136063-50916-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576136063-50916-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 03:34:23PM +0800, zhong jiang wrote:
> Fixes the following compile error:
> 
> drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
> fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
> drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
> fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
> make: *** [vmlinux] Error 1

There are stubs for those functions so that really should not be
happening. I can not reproduce that.

thanks,

-- 
heikki
