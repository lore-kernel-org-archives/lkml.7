Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174EAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B75214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfDYIVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:21:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfDYIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:21:03 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJZci-00081X-FQ; Thu, 25 Apr 2019 10:20:52 +0200
Date:   Thu, 25 Apr 2019 10:20:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
In-Reply-To: <1d7954b3-32e9-b3ac-1157-6b9c29ddbfe7@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1904251019520.1960@nanos.tec.linutronix.de>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com> <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de> <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com> <alpine.DEB.2.21.1904250917400.1762@nanos.tec.linutronix.de>
 <1d7954b3-32e9-b3ac-1157-6b9c29ddbfe7@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019, Li, Aubrey wrote:
> On 2019/4/25 15:20, Thomas Gleixner wrote:
> > Let the arch select CONFIG_PROC_PID_ARCH_STATUS 
> 
> Sorry, I didn't get the point here, above you mentioned not mixing arch and proc code
> and not enabling this on x86 right away, then how to let x86 select it?
> 

By using 'select PROC_PID_ARCH_STATUS' in the arch/xxxx/Kconfig file in the
patch which implements the required arch function perhaps?

Thanks,

	tglx
