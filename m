Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC99C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FE120867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570426705;
	bh=fniOtY4YXlVlvneRnJmNfwwvR35gAHn4XKJ7OC653Ig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=DJenswqjrxub9dpV2IvNzABpIRHILeGdKqn8CYNPtK0/N2RHaclH/eeTrcOxsdvJ1
	 3Mu5/m81ruzR3zXI3Bs6o0IR332IiDbDiOlt8vJWDfLEzQn02F1lp3omzImoXUmhA5
	 b/k81IH3Lnn8ne5z7l1EGfXBdmkLBhXdKnx6G+I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJGFiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 01:38:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:44162 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfJGFiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:38:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 22:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="222806536"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2019 22:38:21 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: dwc3: Switch to platform_get_irq_byname_optional()
In-Reply-To: <20191005210449.3926-3-hdegoede@redhat.com>
References: <20191005210449.3926-1-hdegoede@redhat.com> <20191005210449.3926-3-hdegoede@redhat.com>
Date:   Mon, 07 Oct 2019 08:38:21 +0300
Message-ID: <87imp1ru7m.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Hans de Goede <hdegoede@redhat.com> writes:

> The dwc3 code to get the "peripheral" / "host" / "otg" IRQ first tries
> platform_get_irq_byname() and then falls back to the IRQ at index 0 if
> the platform_get_irq_byname().
>
> In this case we do not want platform_get_irq_byname() to print an error
> on failure, so switch to platform_get_irq_byname_optional() instead which
> does not print an error.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205037
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
balbi
