Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6482F2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfCOL7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:59:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:46247 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfCOL7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:59:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 04:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="155328773"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 15 Mar 2019 04:58:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Mar 2019 13:58:54 +0200
Date:   Fri, 15 Mar 2019 13:58:54 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 4/6] usb: roles: add API to get usb_role_switch by node
Message-ID: <20190315115854.GJ7752@kuha.fi.intel.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
 <1552635513-2378-5-git-send-email-chunfeng.yun@mediatek.com>
 <20190315081835.GD7752@kuha.fi.intel.com>
 <1552641204.10179.133.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552641204.10179.133.camel@mhfsdcap03>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 05:13:24PM +0800, Chunfeng Yun wrote:
> I encounter a build error when CONFIG_USB_ROLE_SWITCH is not enabled,
> 
> drivers/usb/mtu3/mtu3_dr.o: In function `ssusb_role_sw_register':
> ./drivers/usb/mtu3/mtu3_dr.c:460: undefined reference to
> `usb_role_switch_register'
> drivers/usb/mtu3/mtu3_dr.o: In function `ssusb_otg_switch_exit':
> ./drivers/usb/mtu3/mtu3_dr.c:491: undefined reference to
> `usb_role_switch_unregister'
> 
> the following patch has fixed the issue, but seems not get into kernel,
> [v3,08/12] usb: roles: Add usb role switch notifier.
> https://patchwork.kernel.org/patch/10836525/
> 
> What should I do if I add a new API? Thanks

So if you are asking should you supply dummy functions for the new API,
then I would just say that if you do so, you need to prepare these
patches on top of that series from Yu Chen. In general I'm not sure we
need dummy functions with this API.

Hans, comments?


thanks,

-- 
heikki
