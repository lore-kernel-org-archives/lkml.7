Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A06ECDE28
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44E0222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfIKH1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:27:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:61106 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfIKH1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:27:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 00:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="200462770"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 11 Sep 2019 00:27:42 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 11 Sep 2019 10:27:41 +0300
Date:   Wed, 11 Sep 2019 10:27:41 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20190911072741.GA981@kuha.fi.intel.com>
References: <20190911003306.74ca7251@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911003306.74ca7251@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:33:06AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   fd3f7275826f ("software node: Initialize the return value in software_node_find_by_name()")
> 
> Fixes tag
> 
>   Fixes: 1666faedb567 ("software node: Add software_node_get_reference_args()")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 
> Did you mean
> 
> Fixes: 1666faedb567 ("software node: Add software_node_find_by_name()")
> 
> or
> 
> Fixes: b06184acf751 ("software node: Add software_node_get_reference_args()")

Rafael, it seems you have rebased your branch. Do you want me to
resend those fixes, or can you fix the tags in them yourself?

thanks,

-- 
heikki
