Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5681FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ECC2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHNPH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:07:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:31274 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfHNPH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:07:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 08:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="194560064"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 14 Aug 2019 08:07:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Aug 2019 18:07:22 +0300
Date:   Wed, 14 Aug 2019 18:07:22 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: typec: fusb302: Small changes
Message-ID: <20190814150722.GA24772@kuha.fi.intel.com>
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
 <a826c351-4e9d-8a33-ad0f-764d13aeb1ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a826c351-4e9d-8a33-ad0f-764d13aeb1ed@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:42:46PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 14-08-19 15:24, Heikki Krogerus wrote:
> > Hi,
> > 
> > This series removes the deprecated fusb302 specific properties, and
> > stops using struct tcpc_config in the driver.
> 
> Series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> This has a small conflict with my
> "[PATCH] usb: typec: fusb302: Call fusb302_debugfs_init earlier"
> patch.

Oh, damn it. Sorry.

> Since we've agreed to do the rootdir leak fix as a separate patch
> (which I will write when I find some time probably tomorrow), I
> was wondering if we can merge my patch first. I would like to see
> a "Cc: stable@vger.kernel.org" added to my patch and then it would
> be good to have it merged first.
> 
> Regardless we should probable prepare one series with all patches
> for Greg to make this easy to merge for him.
> 
> Shall I combine this series + my fix + my to be written fix into
> 1 series, test that on actual hardware and then post that?

That works for me.

thanks,

-- 
heikki
