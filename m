Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE8AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F6520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfJCITY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:19:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:63621 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfJCITX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:19:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 01:19:23 -0700
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="182316984"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 01:19:16 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, Mat King <mathewk@google.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>, rafael@kernel.org,
        gregkh@linuxfoundation.org, Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
In-Reply-To: <20191002094650.3fc06a85@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com> <20191002094650.3fc06a85@lwn.net>
Date:   Thu, 03 Oct 2019 11:19:13 +0300
Message-ID: <87muei9r7i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Oct 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> On Tue, 1 Oct 2019 10:09:46 -0600
> Mat King <mathewk@google.com> wrote:
>
>> I have been looking into adding Linux support for electronic privacy
>> screens which is a feature on some new laptops which is built into the
>> display and allows users to turn it on instead of needing to use a
>> physical privacy filter. In discussions with my colleagues the idea of
>> using either /sys/class/backlight or /sys/class/leds but this new
>> feature does not seem to quite fit into either of those classes.
>
> FWIW, it seems that you're not alone in this; 5.4 got some support for
> such screens if I understand things correctly:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=110ea1d833ad

Oh, I didn't realize it got merged already, I thought this was
related...

So we've already replicated the backlight sysfs interface problem for
privacy screens. :(

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
