Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CAAC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5B720830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfILRBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:01:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbfILRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:01:45 -0400
Received: from localhost (unknown [88.214.185.227])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 853B214CDFDE3;
        Thu, 12 Sep 2019 10:01:43 -0700 (PDT)
Date:   Thu, 12 Sep 2019 19:01:37 +0200 (CEST)
Message-Id: <20190912.190137.820514851969442445.davem@davemloft.net>
To:     richardcochran@gmail.com
Cc:     felipe.balbi@linux.intel.com, christopher.s.hall@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PTP: add support for one-shot output
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190912165609.GA1439@localhost>
References: <20190911061622.774006-1-felipe.balbi@linux.intel.com>
        <20190911061622.774006-2-felipe.balbi@linux.intel.com>
        <20190912165609.GA1439@localhost>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Sep 2019 10:01:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 12 Sep 2019 09:56:09 -0700

> On Wed, Sep 11, 2019 at 09:16:22AM +0300, Felipe Balbi wrote:
>> Some controllers allow for a one-shot output pulse, in contrast to
>> periodic output. Now that we have extensible versions of our IOCTLs, we
>> can finally make use of the 'flags' field to pass a bit telling driver
>> that if we want one-shot pulse output.
>> 
>> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> ---
>> 
>> Changes since v3:
>> 	- Remove bogus bitwise negation
>> 
>> Changes since v2:
>> 	- Add _PEROUT_ to bit macro
>> 
>> Changes since v1:
>> 	- remove comment from .flags field
> 
> Reviewed-by: Richard Cochran <richardcochran@gmail.com>
> 
> @davem, these two are good to go!

Ok, thanks for reviewing.
