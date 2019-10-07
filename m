Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE8ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6334E214E0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570426750;
	bh=xVzDCAJZfWoUpRakiPZghgCa0QGtfOvZ04wXzKR5l6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=dZFMpiKAYuBzp8//vpiU2feRxon9ruMl/ci4XLM8XN9e+IVWGe0jyUY+dT4yOnQXU
	 aXvMjEEeDOVlwn5AP4KVJxGjIIQJOBPewHhUbTJXLGaYkKIkfJ3M6A7VPeSWhlIBpL
	 NbccdYfv/7BpgRMbeMGrcdEPYBPBUbpnbsYhTaEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfJGFjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 01:39:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:21586 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfJGFjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:39:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 22:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="394231515"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 06 Oct 2019 22:39:07 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: dwc3: Remove dev_err() on platform_get_irq() failure
In-Reply-To: <20191005210449.3926-4-hdegoede@redhat.com>
References: <20191005210449.3926-1-hdegoede@redhat.com> <20191005210449.3926-4-hdegoede@redhat.com>
Date:   Mon, 07 Oct 2019 08:39:06 +0300
Message-ID: <87ftk5ru6d.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Hans de Goede <hdegoede@redhat.com> writes:

> Since commit 7723f4c5ecdb ("driver core: platform: Add an error message to
> platform_get_irq*()"), platform_get_irq() will call dev_err() itself on
> failure, so there is no need for the driver to also do this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
balbi
