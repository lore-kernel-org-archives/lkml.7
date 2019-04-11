Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52F2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A3217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDKNfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:35:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:58375 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfDKNfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:35:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 06:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,337,1549958400"; 
   d="scan'208";a="163389916"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Apr 2019 06:35:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 11 Apr 2019 16:35:46 +0300
Date:   Thu, 11 Apr 2019 16:35:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 09/12] platform/x86: intel_cht_int33fe: Provide
 software nodes for the devices
Message-ID: <20190411133546.GA25743@kuha.fi.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
 <20190410152505.87041-10-heikki.krogerus@linux.intel.com>
 <CAHp75Vde9rX7XaVuUyn_mozwr1VFtCNVYzkerGE4DXT_hp_wPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vde9rX7XaVuUyn_mozwr1VFtCNVYzkerGE4DXT_hp_wPQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 04:31:51PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 10, 2019 at 6:25 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Software nodes provide two features that we will need later.
> > 1) Software nodes can have references to other software nodes.
> > 2) Software nodes can exist before a device entry is created.
> >
> 
> It seems does two things in one patch, and the first one is not
> mentioned in the commit message.
> I would suggest to create a preparation patch which extracts finding
> and registering max17047 device followed by what you do here.

OK, I'll split the patch.

thanks,

-- 
heikki
