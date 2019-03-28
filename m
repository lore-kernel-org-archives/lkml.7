Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBF3205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfC1RjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:39:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:59429 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfC1RjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:39:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 10:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,281,1549958400"; 
   d="scan'208";a="159294324"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 Mar 2019 10:38:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 28 Mar 2019 19:38:57 +0200
Date:   Thu, 28 Mar 2019 19:38:57 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] device property: fwnode_is_compatible() helper
Message-ID: <20190328173857.GC9993@kuha.fi.intel.com>
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:43:36PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> Basically the helper is just a generic version of the function
> of_device_is_compatible() that should work also with ACPI and
> software nodes.
> 
> As the first user for the helper, I'm converting in this series the
> USB role switch code to expect the "compatible" property to have the
> value "usb-role-switch" instead of expecting a boolean property named
> "usb-role-switch". I'm doing the same for the USB Type-C mux code.
> 
> thanks,
> 
> Heikki Krogerus (3):
>   device property: Add fwnode_is_compatible() and device_is_compatible()
>     helpers
>   usb: roles: Use the "compatible" property instead of a boolean
>     property
>   usb: typec: mux: Use the "compatible" property instead of a boolean
>     property
> 
>  drivers/base/property.c   | 35 +++++++++++++++++++++++++++++++++++
>  drivers/usb/roles/class.c |  2 +-
>  drivers/usb/typec/mux.c   |  8 ++------
>  include/linux/property.h  |  3 +++
>  4 files changed, 41 insertions(+), 7 deletions(-)

Don't take this series yet. We are having a discussion on whether this
is the correct approach with the USB mux or not in an other mail
thread. The helper itself (patch 1/3) I guess is fine though.


thanks,

-- 
heikki
