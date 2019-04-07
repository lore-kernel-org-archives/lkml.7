Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DA6C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 13:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E660220B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 13:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDGNCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 09:02:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:27266 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDGNCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 09:02:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 06:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,321,1549958400"; 
   d="scan'208";a="162166575"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2019 06:02:41 -0700
Subject: Re: [PATCH v13 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, aubrey.li@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190224044400.34975-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
 <20190406214143.GA21551@avx2>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <7cd8fa2d-301a-5c96-ce3d-3dc373a5d8f5@linux.intel.com>
Date:   Sun, 7 Apr 2019 21:02:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190406214143.GA21551@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/7 5:41, Alexey Dobriyan wrote:
> On Fri, Apr 05, 2019 at 09:32:35PM +0200, Thomas Gleixner wrote:
>>> +/* Add support for architecture specific output in /proc/pid/status */
>>> +extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
>      ^^^^^^
> 
> Unnecessary extern.
> 
The linkage is default extern, but with this functions and variables
can be treated the same way.

Is it mandatory not to use it explicitly? ./script/checkpatch.pl did
not report this.

Thanks,
-Aubrey
