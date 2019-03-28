Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0144BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB80204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfC1AZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:25:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:1993 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfC1AZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:25:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 17:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,278,1549958400"; 
   d="scan'208";a="144471874"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2019 17:25:45 -0700
Date:   Thu, 28 Mar 2019 08:25:25 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 4/6] x86, mm: make split_mem_range() more easy to read
Message-ID: <20190328002525.GA17122@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com>
 <20190212021215.13247-5-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.1903232345500.1798@nanos.tec.linutronix.de>
 <20190327220513.p4qrgxhvmvgooxjv@master>
 <alpine.DEB.2.21.1903280111480.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903280111480.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:16:08AM +0100, Thomas Gleixner wrote:
>Wei,
>
>On Wed, 27 Mar 2019, Wei Yang wrote:
>> On Sun, Mar 24, 2019 at 03:29:04PM +0100, Thomas Gleixner wrote:
>> >Note, it's a combo of changes (including your patch 1/6) and needs to be
>> >split up. It would be nice if you have time to split it up into separate
>> >patches, add proper changelogs and test the heck out of it on both 32 and
>> >64 bit. If you don't have time, please let me know.
>> >
>> 
>> Thanks for your suggestions :-)
>> 
>> Just get my head up, will try to understand the code and test on both
>> arch.
>> 
>> BTW, do you have some suggestions in the test? Currently I just use
>> bootup test. Basicly I think this is fine to cover the cases. Maybe you
>> would have some better idea.
>
>This is about bootup in the first place. After that memory hotplug which
>you can emulate with qemu/kvm IIRC.
>

Ok, this is not difficult.

>The important part about testing is to have systems which expose a wide
>variety memory layouts.
>

May be I can add some test with nvdimm.

>Thanks,
>
>	tglx

-- 
Wei Yang
Help you, Help me
