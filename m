Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3312CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19952245A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfKDGZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:25:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:11037 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbfKDGZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:25:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 22:25:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,266,1569308400"; 
   d="scan'208";a="199928191"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga008.fm.intel.com with ESMTP; 03 Nov 2019 22:25:39 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 1/7] intel_th: gth: Fix the window switching sequence
In-Reply-To: <20191102171419.GA484428@kroah.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com> <20191028070651.9770-2-alexander.shishkin@linux.intel.com> <20191102171419.GA484428@kroah.com>
Date:   Mon, 04 Nov 2019 08:25:39 +0200
Message-ID: <877e4gf998.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, Oct 28, 2019 at 09:06:45AM +0200, Alexander Shishkin wrote:
>> Commit 8116db57cf16 ("intel_th: Add switch triggering support") added
>> a trigger assertion of the CTS, but forgot to de-assert it at the end
>> of the sequence. This results in window switches randomly not happening.
>> 
>> Fix that by de-asserting the trigger at the end of the window switch
>> sequence.
>> 
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/hwtracing/intel_th/gth.c | 3 +++
>>  1 file changed, 3 insertions(+)
>
> Shouldn't this have a Fixes: tag and a cc: stable@ in it?
>
> I can add it if you say it's ok to.

Fixes: yes, but cc: stable shouldn't be required if this goes into 5.4,
because the buggy commit is in 5.4-rc1.

Thank you,
--
Alex
