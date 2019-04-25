Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDC7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A5E20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfDYJuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:50:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:41647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfDYJuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:50:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 02:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="294421804"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2019 02:50:17 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 0/3] stm class/intel_th: Fixes for v5.1
In-Reply-To: <8736m6za90.fsf@ashishki-desk.ger.corp.intel.com>
References: <20190417073536.63014-1-alexander.shishkin@linux.intel.com> <8736m6za90.fsf@ashishki-desk.ger.corp.intel.com>
Date:   Thu, 25 Apr 2019 12:50:16 +0300
Message-ID: <87y33yxvl3.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:
>
>> Hi Greg,
>
> Hi Greg,
>
> This seems to have fallen through the cracks. Unless you picked it up
> already, should I resend these as a part of my pull request for v5.2
> instead? Both fixes are not v5.1 specific and will have to go to stable
> either way.

I see you picked them up already, so disregard that email.

Thanks,
--
Alex
