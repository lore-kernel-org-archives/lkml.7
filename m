Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C05EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A73520657
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH2N2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:28:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:40772 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfH2N2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:28:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="197805405"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 29 Aug 2019 06:28:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 29 Aug 2019 16:28:07 +0300
Date:   Thu, 29 Aug 2019 16:28:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] software node: Fix use of potentially uninitialized
 variable
Message-ID: <20190829132807.GG5486@kuha.fi.intel.com>
References: <20190829132116.76120-1-heikki.krogerus@linux.intel.com>
 <20190829132116.76120-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829132116.76120-3-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 04:21:16PM +0300, Heikki Krogerus wrote:
> reported by smatch:
> drivers/base/swnode.c:71 software_node_to_swnode() error: uninitialized symbol 'swnode'.
> 
> Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
> Cc: stable@vger.kernel.org

Sorry. That was not needed. I need to resend these.

I think I'll just squash these two patches together.

thanks,

-- 
heikki
