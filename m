Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15727C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E302146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552998016;
	bh=jkMMx2f8dBalntiVFswxU2f/RR/VeZk+ZhHWUBVthLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FS47BzZXd9zqlRDCYMSuO7xShjzu/32Fvewu1GzDAN3Y8Gg8gb5ME6A+OW26UUHtX
	 6s9YUpJMsMu0fwDj5l39j6LwtRxjkP2juIOhqiYqUy6MAu0CgZ0pIZPSwz0LMHTxHW
	 tF12rlUUftHoJENKEen5j57umIWjRaGCoCTcWV+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfCSMUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbfCSMUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:20:15 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB162133D;
        Tue, 19 Mar 2019 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552998012;
        bh=jkMMx2f8dBalntiVFswxU2f/RR/VeZk+ZhHWUBVthLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2AFWH1xAyHiTpI3XPuPzMN6gL1zDHr79CZApD2OfTMxyLy2arxiRzrSEuYPRle1TL
         m190SV1Haa2p06Ya6twjR9uv9NM1dMNF0zzBy7xaNpTloq30UO8iUkVMR65yxAW6/y
         J/aPxL7k6kYZ0FepmHqr7Y9H2ldLCHLpHGPFQuoA=
Date:   Tue, 19 Mar 2019 13:20:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "DSouza, Nelson" <nelson.dsouza@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Tony Jones <tonyj@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "eranian@google.com" <eranian@google.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH 4.14 31/34] perf/x86/intel: Fix memory corruption
Message-ID: <20190319122002.GB29633@kroah.com>
References: <20190318084144.657740413@linuxfoundation.org>
 <20190318084149.364327318@linuxfoundation.org>
 <BC9B17E68BB84346BEE0B491BDB7D8AE28A68B8A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC9B17E68BB84346BEE0B491BDB7D8AE28A68B8A@ORSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:29:37PM +0000, DSouza, Nelson wrote:
> With the patch, the kernel crash is not seen on 4.14, 4.19 and 4.20 kernels.

Wonderful, thanks for testing.

greg k-h
