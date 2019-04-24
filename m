Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667DCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3262D217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfDXVUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:20:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfDXVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:20:07 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJPJ8-00078e-KU; Wed, 24 Apr 2019 23:19:58 +0200
Date:   Wed, 24 Apr 2019 23:19:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v17 2/3] /proc/pid/arch_status: Add AVX-512 usage elapsed
 time
In-Reply-To: <20190421183529.9141-2-aubrey.li@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1904242318100.1762@nanos.tec.linutronix.de>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com> <20190421183529.9141-2-aubrey.li@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019, Aubrey Li wrote:

$Subject: /proc/pid/arch_status: Add AVX-512 usage elapsed time

x86 patches surely have a different prefix.

>  
> +#ifdef CONFIG_PROC_PID_ARCH_STATUS
> +/* Add support for task architecture specific output in /proc/pid/arch_status */
> +void task_arch_status(struct seq_file *m, struct task_struct *task);
> +#define task_arch_status task_arch_status
> +#endif /* CONFIG_PROC_PID_ARCH_STATUS */

See previous reply.

Thanks,

	tglx
